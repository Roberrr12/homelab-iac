variable "pm_api_url" {
  type = string
}

variable "pm_api_token_id" {
  type = string
}

variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}

variable "username" {
  type        = string
}

variable "ssh_public_key" {
  type        = string
}

# variable "template_file_id" {
#  type = string
#} 

variable "vms" {

  type = map(object({
    node           = string
    cpu_cores      = number
    memory         = number
    disk_size      = number
    network_bridge = string
    cpu_type = string
    
    template_id = number

    ip_address = string
    gateway    = string

  }))
}

#variable "containers" {
#  type = map(object({
#    node           = string
#    cpu_cores      = number
#    memory         = number
#    disk_size      = number
#    datastore      = string
#    network_bridge = string
#
#    ip_address = string
#    gateway    = string
#  }))
#}
