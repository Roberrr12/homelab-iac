resource "proxmox_virtual_environment_container" "container" {
    for_each = var.containers
    start_on_boot = true
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
        type = "debian"
    }
} 

