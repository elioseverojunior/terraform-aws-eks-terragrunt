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
    execute  = ["bash", "-c", "${include.root.inputs.tfenv} ${local.tfenv_version}"]
  }
}

inputs = {
  cluster_name = include.application.inputs.application
  default_tags = {
    "Name"        = include.application.inputs.application
    "ansible"  = "false"
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "eks"
    "region"   = "sa-east-1"
    "repo"     = "https://github.com/elioseverojunior/terraform-aws-eks-terragrunt.git"
    "stack"    = include.environment.inputs.environment
    "tier"     = "infra"
    "vpc_id"   = "vpc-0aa97d8dc6991a18d"
  }
}