data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "default" {
  count = var.resource_pool == null ? 0 : 1

  name = format("%s/%s", data.vsphere_compute_cluster.cluster.name, var.resource_pool)
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

locals {
  is_windows_template = can(regex("(?i)windows", data.vsphere_virtual_machine.template.guest_id))
}

resource "vsphere_virtual_machine" "vm" {
  name                   = var.name
  datastore_id           = data.vsphere_datastore.datastore.id
  guest_id               = data.vsphere_virtual_machine.template.guest_id
  resource_pool_id       = var.resource_pool == null ? data.vsphere_compute_cluster.cluster.resource_pool_id : data.vsphere_resource_pool.default[0].id
  num_cpus               = 2
  #cpu_hot_add_enabled    = true
  #cpu_hot_remove_enabled = true
  memory                 = 2048
  #memory_hot_add_enabled = true
  firmware               = "efi"
  folder                 = var.folder
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = var.disk_size
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone
    customize {
      dynamic "linux_options" {
        for_each = local.is_windows_template ? [] : [1]
        content {
          host_name = var.name
          domain    = var.domain
        }
      }
      dns_server_list = var.dns_server_list
      dynamic "network_interface" {
        for_each = var.ipv4_address != null && length(split("/", var.ipv4_address)) > 1 ? [1] : [0]
        content {
          ipv4_address = var.ipv4_address != null && length(split("/", var.ipv4_address)) > 1 ? split("/", var.ipv4_address)[0] : null
          ipv4_netmask = var.ipv4_address != null && length(split("/", var.ipv4_address)) > 1 ? split("/", var.ipv4_address)[1] : null
        }
      }
      ipv4_gateway = var.ipv4_gateway
    }
  }
}
