# proxmox variable
variable "pm_api_url" {
  description = "proxmox api url"
  type        = string
}
variable "pm_api_token_id" {
  description = "proxmox token id"
  type        = string
}
variable "pm_api_token_secret" {
  description = "proxmox api token secret"
  type        = string
  sensitive   = true
}

variable "bastion_sshkey_location" {
  type        = string
  description = "bastion sshkey locations"
  sensitive   = true
}

# rke for rancher
# rke cluster variables
variable "rke_cluster_name" {
  type        = string
  description = "rke cluster name"
  default     = "rke_cluster"
}
variable "rke_target_node" {
  description = "proxmox node witch place rke cluster"
  type        = string
}
variable "rke_vm_agent" {
  type        = number
  default     = 1
  description = "Cloud-init agent status, 1 = enable, 0 = disable"
}
variable "rke_vm_onboot" {
  type        = bool
  default     = true
  description = "Boot with proxmox cluster"
}

variable "rke_cluster_node_count" {
  description = "Number of node on rke cluster"
  type        = number
}
variable "rke_vm_template_name" {
  description = "Template to create rke nodes"
  type        = string
}
variable "rke_vm_os_type" {
  description = "rke cluster node os type"
  type        = string
  default     = "ubuntu"
}
variable "rke_vm_bootdisk" {
  description = "VMs boot disk name"
  type        = string
}
variable "rke_vm_user" {
  description = "VMs user"
  type        = string
}
variable "rke_user_password" {
  description = "VMs users password"
  type        = string
  sensitive   = true
}

variable "rke_user_sshkey" {
  description = "VMs users sshkey"
  type        = string
  sensitive   = true
}
variable "rke_vm_memory" {
  description = "RAM of VMs"
  type        = number
}
variable "rke_vm_cpu_type" {
  description = "VMs CPU type"
  type        = string
  default     = "host"
}
variable "rke_vm_vcpu" {
  description = "VMs core"
  type        = number
  default     = 2
}
variable "rke_vm_network_bridge" {
  description = "vm network bridge name"
  type        = string
  default     = "vmbr0"
}
variable "rke_vm_network_bridge_model" {
  description = "vm network bridge model"
  type        = string
  default     = "virtio"
}
variable "rke_vm_network_cidr" {
  type        = string
  description = "rke network cidr"
}
variable "rke_vm_network_cidr_host_number" {
  description = "The host number VMs in CIDR"
  type        = number
}
variable "rke_cloudinit_cdrom_storage" {
  type = string
}
variable "rke_vm_os_disk_size" {
  type = number
}
variable "rke_vm_os_disk_location" {
  type = string
}
variable "rke_vm_data_disk_size" {
  type = number
}
variable "rke_vm_data_disk_location" {
  type = string
}
variable "rke_tags" {
  type = string
}

# k8s cluster variables
# k8s master
variable "k8s_master_cluster_name" {
  type        = string
  description = "k8s_master cluster name"
  default     = "k8s_master_cluster"
}
variable "k8s_master_target_node" {
  description = "proxmox node witch place k8s_master cluster"
  type        = string
}
variable "k8s_master_vm_agent" {
  type        = number
  default     = 1
  description = "Cloud-init agent status, 1 = enable, 0 = disable"
}
variable "k8s_master_vm_onboot" {
  type        = bool
  default     = true
  description = "Boot with proxmox cluster"
}

variable "k8s_master_cluster_node_count" {
  description = "Number of node on k8s_master cluster"
  type        = number
}
variable "k8s_master_vm_template_name" {
  description = "Template to create k8s_master nodes"
  type        = string
}
variable "k8s_master_vm_os_type" {
  description = "k8s_master cluster node os type"
  type        = string
  default     = "ubuntu"
}
variable "k8s_master_vm_bootdisk" {
  description = "VMs boot disk name"
  type        = string
}
variable "k8s_master_vm_user" {
  description = "VMs user"
  type        = string
}
variable "k8s_master_user_password" {
  description = "VMs users password"
  type        = string
  sensitive   = true
}
variable "k8s_master_user_sshkey" {
  description = "VMs users sshkey"
  type        = string
  sensitive   = true
}
variable "k8s_master_vm_memory" {
  description = "RAM of VMs"
  type        = number
}
variable "k8s_master_vm_cpu_type" {
  description = "VMs CPU type"
  type        = string
  default     = "host"
}
variable "k8s_master_vm_vcpu" {
  description = "VMs core"
  type        = number
  default     = 2
}
variable "k8s_master_vm_network_bridge" {
  description = "vm network bridge name"
  type        = string
  default     = "vmbr0"
}
variable "k8s_master_vm_network_bridge_model" {
  description = "vm network bridge model"
  type        = string
  default     = "virtio"
}
variable "k8s_master_vm_network_cidr" {
  type        = string
  description = "k8s_master network cidr"
}
variable "k8s_master_vm_network_cidr_host_number" {
  description = "The host number VMs in CIDR"
  type        = number
}
variable "k8s_master_vm_cloudinit_cdrom_storage" {
  type = string
}
variable "k8s_master_vm_os_disk_size" {
  type = number
}
variable "k8s_master_vm_os_disk_location" {
  type = string
}
variable "k8s_master_vm_data_disk_size" {
  type = number
}
variable "k8s_master_vm_data_disk_location" {
  type = string
}
variable "k8s_master_tags" {
  type = string
}

# k8s worker
variable "k8s_worker_cluster_name" {
  type        = string
  description = "k8s_worker cluster name"
  default     = "k8s_worker_cluster"
}
variable "k8s_worker_target_node" {
  description = "proxmox node witch place k8s_worker cluster"
  type        = string
}
variable "k8s_worker_vm_agent" {
  type        = number
  default     = 1
  description = "Cloud-init agent status, 1 = enable, 0 = disable"
}
variable "k8s_worker_vm_onboot" {
  type        = bool
  default     = true
  description = "Boot with proxmox cluster"
}

variable "k8s_worker_cluster_node_count" {
  description = "Number of node on k8s_worker cluster"
  type        = number
}
variable "k8s_worker_vm_template_name" {
  description = "Template to create k8s_worker nodes"
  type        = string
}
variable "k8s_worker_vm_os_type" {
  description = "k8s_worker cluster node os type"
  type        = string
  default     = "ubuntu"
}
variable "k8s_worker_vm_bootdisk" {
  description = "VMs boot disk name"
  type        = string
}
variable "k8s_worker_vm_user" {
  description = "VMs user"
  type        = string
}
variable "k8s_worker_user_password" {
  description = "VMs users password"
  type        = string
  sensitive   = true
}
variable "k8s_worker_user_sshkey" {
  description = "VMs users sshkey"
  type        = string
  sensitive   = true
}
variable "k8s_worker_vm_memory" {
  description = "RAM of VMs"
  type        = number
}
variable "k8s_worker_vm_cpu_type" {
  description = "VMs CPU type"
  type        = string
  default     = "host"
}
variable "k8s_worker_vm_vcpu" {
  description = "VMs core"
  type        = number
  default     = 2
}
variable "k8s_worker_vm_network_bridge" {
  description = "vm network bridge name"
  type        = string
  default     = "vmbr0"
}
variable "k8s_worker_vm_network_bridge_model" {
  description = "vm network bridge model"
  type        = string
  default     = "virtio"
}
variable "k8s_worker_vm_network_cidr" {
  type        = string
  description = "k8s_worker network cidr"
}
variable "k8s_worker_vm_network_cidr_host_number" {
  description = "The host number VMs in CIDR"
  type        = number
}
variable "k8s_worker_vm_cloudinit_cdrom_storage" {
  type = string
}
variable "k8s_worker_vm_os_disk_size" {
  type = number
}
variable "k8s_worker_vm_os_disk_location" {
  type = string
}
variable "k8s_worker_vm_data_disk_size" {
  type = number
}
variable "k8s_worker_vm_data_disk_location" {
  type = string
}
variable "k8s_worker_tags" {
  type = string
}

