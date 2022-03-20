locals {
  tfenv_version = "latest"
  remote_state = merge(include.root.remote_state,
    {
      backend = include.root.remote_state.backend
      config = merge(
        include.root.remote_state.config,
        {
          bucket = include.environment.inputs.s3_remote_bucket,
          region = include.region.inputs.aws_region,
        }
      )

      generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
      }
    }
  )
}

remote_state = local.remote_state

include "root" {
  path           = find_in_parent_folders()
  expose         = true
  merge_strategy = "deep"
}

include "team" {
  path           = find_in_parent_folders("team.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "environment" {
  path           = find_in_parent_folders("environment.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "region" {
  path           = find_in_parent_folders("region.hcl")
  expose         = true
  merge_strategy = "deep"
}

include "application" {
  path           = find_in_parent_folders("application.hcl")
  expose         = true
  merge_strategy = "deep"
}

terraform {
  source = "../../../../../../apps//eks/"

  before_hook "tfenv" {
    commands = ["init", "plan", "apply", "import", "push", "refresh", "validate", "destroy"]
    execute  = ["bash", "-c", "${include.root.inputs.tfenv}", local.tfenv_version]
  }
}

inputs = {
  ecr_name = "jenkins"
  tags = {
    "Name"        = "jenkins-ecr-registry"
    "pd:ansible"  = "false"
    "pd:deployer" = "elio.severo@passeidireto.com"
    "pd:iac"      = "terraform"
    "pd:owner"    = "SRE"
    "pd:project"  = "jenkins-ecr-registry"
    "pd:region"   = "us-east-1"
    "pd:repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "pd:stack"    = include.environment.inputs.environment
    "pd:tier"     = "infra"
    "pd:vpc_id"   = "vpc-0aa97d8dc6991a18d"
  }
}