skip                          = true
terragrunt_version_constraint = ">= 0.32"

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    bucket  = "nutrien-terraform-br-prd"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "sa-east-1"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  default_tags = {
    "ansible"  = false
    "iac"      = "terraform"
    "owner"    = "SRE"
    "project"  = "TBD"
    "region"   = "TBD"
    "repo"     = "https://github.com/elioseverojunior/terraform-aws-eks-terragrunt.git"
    "stack"    = "TBD"
    "tier"     = "infra"
    "vpc_id"   = "TBD"
  }
  tfenv = "${get_parent_terragrunt_dir()}/scripts/tfenv.sh"
}
