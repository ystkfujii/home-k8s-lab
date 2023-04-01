locals {
  instance_key_name     = "deployerkey"

  instance_type_cp      = "e-large8"
  instance_type_wk      = "e-large16"

  instance_count_wk = 3
}

#####
# Provider
#
provider "nifcloud" {
  region     = var.region
}

#####
# Security Group
#
resource "nifcloud_security_group_rule" "ssh_from_working_server" {
  security_group_names = [
    module.k8s_300.security_group_name.control_plane,
    module.k8s_300.security_group_name.worker,
  ]
  type      = "IN"
  from_port = 22
  to_port   = 22
  protocol  = "TCP"
  cidr_ip   = var.working_server_ip
}

#####
# Module
#
module "k8s_300" {
  source  = "ystkfujii/minimum-k8s-cluster/nifcloud"
  version = "0.0.5"

  availability_zone = var.availability_zone
  prefix            = "300"

  instance_key_name = local.instance_key_name

  instance_count_wk = local.instance_count_wk

  instance_type_cp = local.instance_type_cp
  instance_type_wk = local.instance_type_wk
}

