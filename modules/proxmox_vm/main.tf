resource "proxmox_vm_qemu" "cluster" {
  count                   = var.cluster_node_count
  name                    = "${var.cluster_name}-instance-${format("%02d", count.index)}"
  target_node             = var.pm_target_node
  desc                    = "${var.cluster_name} on proxmox"
  onboot                  = true
  scsihw                  = "virtio-scsi-pci"
  bootdisk                = var.vm_bootdisk
  qemu_os                 = "l26"
  os_type                 = var.vm_os_type
  agent                   = 1
  cloudinit_cdrom_storage = var.vm_cloudinit_cdrom_storage
  define_connection_info  = true
  clone                   = var.vm_template_name
  full_clone              = true

  ssh_user   = var.vm_user
  sshkeys    = var.vm_user_sshkey
  ciuser     = var.vm_user
  cipassword = var.vm_user_password

  memory = var.vm_memory
  cpu    = var.vm_cpu_type
  cores  = var.vm_vcpu
  tags   = var.vm_tags
  disks {
    virtio {
      virtio0 {
        disk {
          size    = var.vm_os_disk_size
          storage = var.vm_os_disk_location
        }
      }
      virtio1 {
        disk {
          size    = var.vm_data_disk_size
          storage = var.vm_data_disk_location
        }
      }
    }
  }

  network {
    bridge   = var.vm_network_bridge
    model    = var.vm_network_bridge_model
    firewall = false
  }
  ipconfig0 = "ip=${cidrhost(var.vm_network_cidr, var.vm_host_number + count.index)}${local.vm_net_subnet_mask},gw=${local.vm_net_default_gw}"

  lifecycle {
    ignore_changes = [network]
  }
}


