containers = {
  "minio" = {
    node           = "CAMBIAR"
    cpu_cores      = 2
    memory         = 2048
    disk_size      = 22
    datastore      = "local-lvm"
    network_bridge = "vmbr0"


    ip_address = "192.168.X.Y/24"
    gateway    = "CAMBIAR"
  }
}

ssh_public_key = "CAMBIAR"
template_file_id = "CAMBIAR"

pm_api_url      = "CAMBIAR"
pm_api_token_id = "CAMBIAR"
pm_api_token_secret = "CAMBIAR"
