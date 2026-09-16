pm_api_url      = "https://urlproxmox:8006/api2/json"
pm_api_token_id = "id-token-terraform"
pm_api_token_secret = "token-secret-terraform"

username = "CAMBIA"
ssh_public_key = "CAMBIA"
#template_file_id = ""
vms = {
  "ctrl-01" = {
    node           = "CAMBIAR"
    cpu_cores      = 2
    memory         = 4096
    disk_size      = 22
    network_bridge = "CAMBIAR"
    cpu_type = "x86-64-v2-AES"

    template_id = 9000

    ip_address = "192.168.X.Y/24"
    gateway    = "CAMBIAR"
  }
  "ctrl-02" = {
    node           = "CAMBIAR"
    cpu_cores      = 2
    memory         = 4096
    disk_size      = 22
    network_bridge = "CAMBIAR"
    cpu_type = "x86-64-v2-AES"

    template_id = 9000

    ip_address = "192.168.X.Y/24"
    gateway    = "CAMBIAR"
  }
}
#containers = {
#  "minio" = {
#    node           = "CAMBIAR"
#    cpu_cores      = 2
#    memory         = 2048
#    disk_size      = 22
#    datastore      = "CAMBIAR"
#    network_bridge = "CAMBIAR"
#
#
#    ip_address = "192.168.X.Y/24".
#    gateway    = "CAMBIAR"
#  }
#}