resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name      = each.key
  node_name = each.value.node

  cpu {
    cores = each.value.cpu_cores
    type = each.value.cpu_type
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    interface = "scsi0"
    size      = each.value.disk_size
  }
  
  # Red
  network_device {
    bridge = each.value.network_bridge
  }

  # Sistema operativo
  operating_system {
    type = "l26"
  }

  # Cloud-init
  initialization {
    ip_config {
      ipv4 {
        address = each.value.ip_address
        gateway = each.value.gateway
      }
    }

    user_account {
        username = var.username
        keys = [var.ssh_public_key]
    }
  }

  clone {
    vm_id = each.value.template_id
    full = true 
  }
}

/* resource "proxmox_virtual_environment_container" "container" {
  for_each = var.containers

  node_name = each.value.node

  initialization {
    hostname = each.key

    ip_config {
      ipv4 {
        address = each.value.ip_address
        gateway = each.value.gateway
      }
    }

    user_account {
        username = var.username
        keys    = [var.ssh_public_key]
    }
  }

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = each.value.datastore
    size         = each.value.disk_size
  }

  network_interface {
    name   = "eth0"
    bridge = each.value.network_bridge
  }

  operating_system {
    template_file_id = var.template_file_id
  }
} */


