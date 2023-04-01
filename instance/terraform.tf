terraform {
  required_version = ">=1.4.4"

  cloud {
    organization = "ystkfujii"
    
    workspaces {
      name = "instance"
    }
  }

  required_providers {
    nifcloud = {
      source  = "nifcloud/nifcloud"
      version = ">=1.7.0"
    }
  }
}
