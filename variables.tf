variable "virtual_machines" {
  description = "The list of virtual machines to create"
  type = map(object({
    cluster         = string
    datacenter      = string
    datastore       = string
    disk_size       = optional(number)
    folder          = string
    linked_clone    = optional(bool)
    memory          = number
    name            = string
    network         = string
    num_cpus        = number
    template        = string

    ipv4_address    = optional(string)
    ipv4_gateway    = optional(string)
    dns_server_list = optional(list(string))
    time_zone       = optional(string)
  }))
  default = {}
}