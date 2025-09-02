terraform {
  backend "s3" {}
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
  api_timeout          = 10
}

module "vm" {
  for_each = var.virtual_machines

  source = "./modules/vm"

  providers = {
    vsphere = vsphere
  }

  cluster         = each.value.cluster
  datacenter      = each.value.datacenter
  datastore       = each.value.datastore
  disk_size       = each.value.disk_size
  folder          = each.value.folder
  linked_clone    = each.value.linked_clone
  memory          = each.value.memory
  name            = each.value.name
  network         = each.value.network
  num_cpus        = each.value.num_cpus
  template        = each.value.template

  ipv4_address    = each.value.ipv4_address
  ipv4_gateway    = each.value.ipv4_gateway
  dns_server_list = each.value.dns_server_list
  time_zone       = each.value.time_zone
}
