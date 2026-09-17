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

terraform {
  backend "s3" {
    use_lockfile = true
    region         = "main"
    skip_credentials_validation = true # Para evitar la validación de credenciales
    skip_metadata_api_check     = true # Para evitar la verificación de la API de metadatos
    skip_region_validation      = true # Para evitar la validación de la región
    skip_requesting_account_id = true # Para evitar la solicitud del ID de cuenta (si no, usa aws)
    use_path_style            = true # Para usar el estilo de ruta en lugar del estilo de subdominio
  }
}

