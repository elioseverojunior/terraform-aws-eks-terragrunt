terraform {
  required_version = ">= 1.0.11"

  required_providers {
    aws        = ">= 3.0.0, <= 4.0.0"
    local      = ">= 1.0.0, <= 2.0.0"
    kubernetes = ">= 2.0.0, <= 3.0.0"
  }
}
