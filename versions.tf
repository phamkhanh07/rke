terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "1.2.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "4.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
