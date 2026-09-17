terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.113.1"
    }
  }
  required_version = ">= 1.16.0, < 2.0.0"
}
