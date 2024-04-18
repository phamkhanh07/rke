# proxmox config
variable "pm_target_node" {
  description = "Required The name of the Proxmox Node on which to place the VM"
  type        = string
}

# Cluster config
variable "cluster_name" {
  description = "Required The name of the VM within Proxmox"
  type        = string
}
variable "cluster_node_count" {
  description = "Number of vm to create"
  type        = number
}
# VMs 
# VMs config optional
variable "vm_template_name" {
  description = "proxmox vm tempalte name"
  type        = string
}
variable "vm_os_type" {
  description = "VMs os type"
  type        = string
  default     = "ubuntu"
}
variable "vm_bootdisk" {
  description = "VM boot os disk"
  type        = string
  default     = "virtio0"
}
variable "vm_user" {
  type        = string
  description = "user name of vms"
}
variable "vm_user_password" {
  description = "user password"
  type        = string
  sensitive   = true
}
variable "vm_user_sshkey" {
  description = "vm_user sshkey"
  type        = string
  sensitive   = true
}
variable "vm_memory" {
  description = "vm memory on MB"
  type        = number
  default     = 2048
}
variable "vm_cpu_type" {
  description = "Type of CPU "
  type        = string
  default     = "host"
}
variable "vm_vcpu" {
  description = "Number of CPU core alocate to VM"
  type        = number
  default     = 2
}
# VMs network
variable "vm_network_bridge" {
  description = "vm network bridge name"
  type        = string
  default     = "vmbr0"
}
variable "vm_network_bridge_model" {
  description = "vm network bridge model"
  type        = string
  default     = "virtio"
}
variable "vm_host_number" {
  description = "The host number VMs in CIDR"
  type        = number
}
variable "vm_network_cidr" {
  type        = string
  description = "CIDR of VMs network"
}
variable "vm_nameserver" {
  description = "DNS server ipaddress"
  type = string
}
# VMs disk
variable "vm_cloudinit_cdrom_storage" {
  description = "Set the storage location for the cloud-init drive"
  type        = string
  default     = "local-lvm"
}
variable "vm_os_disk_size" {
  description = "vm os disk size"
  type        = number
  default     = 20
}
variable "vm_os_disk_location" {
  description = "vm os disk location on proxmox"
  type        = string
}
variable "vm_data_disk_size" {
  description = "vm data disk size"
  type        = number
}
variable "vm_data_disk_location" {
  description = "vm data disk location on proxmox"
  type        = string
}
variable "vm_tags" {
  description = "tag for vm"
  type        = string
}

# get data for vms
locals {
  # get vm subnet mask from variable network cidr. EX cird = 192.168.1.0/24 return 24
  vm_net_subnet_mask = "/${split("/", var.vm_network_cidr)[1]}"
  # get default gateway from variable network cidr. EX cidr p 192.168.1.0/24 return 192.168.1.1
  vm_net_default_gw = cidrhost(var.vm_network_cidr, 1)
}

