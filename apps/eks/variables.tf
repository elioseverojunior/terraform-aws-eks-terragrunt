variable "cluster_name" {
  type = string
}

variable "aws_region" {
  default = "sa-east-1"
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
  default = "k8s.nickel.nutrien.digital"
}

variable "kiali_virtual_service_host" {
  type    = string
  default = "kiali.k8s.nickel.nutrien.digital"
}

variable "grafana_kiali_virtual_service_host" {
  type    = string
  default = "grafana.k8s.nickel.nutrien.digital"
}

variable "default_tags" {
  type = map(any)
}

variable "aws_vpc_ipv4_pod_cidr_block" {
  description = "AWS VPC IPv4 POD CIDR Block"
  type        = string
  default     = "172.16.0.0/16"
}