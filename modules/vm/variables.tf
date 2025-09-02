variable "name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "datacenter" {
  description = "The datacenter to use"
  type        = string
}

variable "datastore" {
  description = "The datastore to use"
  type        = string
}

variable "disk_size" {
  description = "The size of the disk"
  type        = number
}

variable "cluster" {
  description = "The cluster to use"
  type        = string
}

variable "resource_pool" {
  description = "The resource pool to use"
  type        = string
  default     = null
}

variable "network" {
  description = "The network to use"
  type        = string
}

variable "num_cpus" {
  description = "The number of CPUs to allocate"
  type        = number
}

variable "memory" {
  description = "The amount of memory to allocate"
  type        = number
}

variable "folder" {
  description = "The folder to place the virtual machine in"
  type        = string
}

variable "template" {
  description = "The template to clone"
  type        = string
}

variable "linked_clone" {
  description = "Whether to create a linked clone"
  type        = bool
  default     = false
}


variable "ipv4_address" {
  description = "The IP address of the virtual machine"
  type        = string
  default     = null
}

variable "ipv4_gateway" {
  description = "The gateway for the virtual machine"
  type        = string
  default     = null
}

variable "domain" {
  description = "The domain to use for the virtual machine"
  type        = string
  default     = "local"
}

variable "dns_server_list" {
  description = "The DNS servers to use"
  type        = list(string)
  default     = []
}

variable "time_zone" {
  description = "The time zone to use"
  type        = string
  default     = "85"
}
