skip                          = true
terragrunt_version_constraint = ">= 0.32"

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    bucket  = "pd-sre-production"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-2"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  tags = {
    "pd:ansible"  = false
    "pd:deployer" = "elio.severo@passeidireto.com"
    "pd:iac"      = "terraform"
    "pd:owner"    = "SRE"
    "pd:project"  = "TBD"
    "pd:region"   = "TBD"
    "pd:repo"     = "https://github.com/PasseiDireto/terraform-jenkins-iac.git"
    "pd:stack"    = "TBD"
    "pd:tier"     = "infra"
    "pd:vpc_id"   = "TBD"
  }
  tfenv = "${get_parent_terragrunt_dir()}/scripts/tfenv.sh"
}
