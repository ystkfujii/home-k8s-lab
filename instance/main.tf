locals {
  key_name = "homek8slab"
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
    nifcloud_security_group.this,
  ]
  type      = "IN"
  from_port = 22
  to_port   = 22
  protocol  = "TCP"
  cidr_ip   = var.working_server_ip
}

# security group
resource "nifcloud_security_group" "this" {
  group_name        = "k8slabins"
  availability_zone = var.availability_zone
}

# module
module "instance_100" {
  source  = "ystkfujii/instance/nifcloud"
  version = "0.0.4"

  instance_name     = "fluentd"
  availability_zone = var.availability_zone

  key_name = local.key_name
  security_group_name = nifcloud_security_group.this.group_name
}
