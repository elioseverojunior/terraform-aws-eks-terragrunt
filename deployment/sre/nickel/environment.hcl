inputs = {
  access_cidr_blocks = ["10.0.0.0/16", "191.13.225.219/32"]
  environment        = "lab"
  environment_short  = "lab"
  s3_remote_bucket   = "nutrien-terraform-br-nickel"
  k8s_version        = "1.22"
}