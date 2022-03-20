variable "cluster_name" {
  default = "br-dev01-eks"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "k8s_version" {
  default = "1.21"
}

variable "nodes_instances_sizes" {
  default = [
    "t3.small"
  ]
}

variable "auto_scale_options" {
  default = {
    min     = 4
    max     = 10
    desired = 6
  }
}

variable "nlb_ingress_internal" {
  type    = bool
  default = false
}

variable "nlb_ingress_type" {
  type    = string
  default = "network"
}

variable "proxy_protocol_v2" {
  type    = bool
  default = false
}

variable "nlb_ingress_enable_termination_protection" {
  type    = bool
  default = false
}

variable "enable_cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "cluster_private_zone" {
  type    = string
  default = "k8s.pd-sandbox.com"
}

variable "kiali_virtual_service_host" {
  type    = string
  default = "kiali.k8s.pd-sandbox.com"
}

variable "grafana_kiali_virtual_service_host" {
  type    = string
  default = "grafana.kiali.k8s.pd-sandbox.com"
}

variable "default_tags" {
  type = map(any)
  default = {
    Application         = "EKS"
    Cluster             = "SND"
    DataClassification  = "Excluded"
    Env_desc            = "SRE AWS EKS CLUSTER"
    Environment         = "US-EAST-1-SND-SRE"
    Environment_Type    = "SND"
    Environment_Version = "DEV01"
    ManagedBy           = "Terraform"
    Market              = "BR"
    Name                = "US-EAST-1-SND-SRE"
    Owner               = "elio.severo@passeidireto.com"
    Purpose             = "DIGITAL"
    Squad               = "SRE"
    Team                = "SRE"
    Tribe               = "SRE"
    Workload            = "SANDBOX"
  }
}