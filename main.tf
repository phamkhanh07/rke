module "rke_cluster" {
  source = "./modules/proxmox_vm"

  pm_target_node             = var.rke_target_node
  cluster_name               = var.rke_cluster_name
  cluster_node_count         = var.rke_cluster_node_count
  vm_template_name           = var.rke_vm_template_name
  vm_os_type                 = var.rke_vm_os_type
  vm_bootdisk                = var.rke_vm_bootdisk
  vm_user                    = var.rke_vm_user
  vm_user_password           = var.rke_user_password
  vm_user_sshkey             = var.rke_user_sshkey
  vm_memory                  = var.rke_vm_memory
  vm_cpu_type                = var.rke_vm_cpu_type
  vm_vcpu                    = var.rke_vm_vcpu
  vm_host_number             = var.rke_vm_network_cidr_host_number
  vm_network_cidr            = var.rke_vm_network_cidr
  vm_nameserver              = var.vm_nameserver
  vm_cloudinit_cdrom_storage = var.rke_cloudinit_cdrom_storage
  vm_os_disk_size            = var.rke_vm_os_disk_size
  vm_os_disk_location        = var.rke_vm_os_disk_location
  vm_data_disk_size          = var.rke_vm_data_disk_size
  vm_data_disk_location      = var.rke_vm_data_disk_location
  vm_tags                    = var.rke_tags

}

module "k8s_master" {
  source = "./modules/proxmox_vm"

  pm_target_node             = var.k8s_master_target_node
  cluster_name               = var.k8s_master_cluster_name
  cluster_node_count         = var.k8s_master_cluster_node_count
  vm_template_name           = var.k8s_master_vm_template_name
  vm_os_type                 = var.k8s_master_vm_os_type
  vm_bootdisk                = var.k8s_master_vm_bootdisk
  vm_user                    = var.k8s_master_vm_user
  vm_user_password           = var.k8s_master_user_password
  vm_user_sshkey             = var.k8s_master_user_sshkey
  vm_memory                  = var.k8s_master_vm_memory
  vm_cpu_type                = var.k8s_master_vm_cpu_type
  vm_vcpu                    = var.k8s_master_vm_vcpu
  vm_host_number             = var.k8s_master_vm_network_cidr_host_number
  vm_nameserver              = var.vm_nameserver
  vm_network_cidr            = var.k8s_master_vm_network_cidr
  vm_cloudinit_cdrom_storage = var.k8s_master_vm_cloudinit_cdrom_storage
  vm_os_disk_size            = var.k8s_master_vm_os_disk_size
  vm_os_disk_location        = var.k8s_master_vm_os_disk_location
  vm_data_disk_size          = var.k8s_master_vm_data_disk_size
  vm_data_disk_location      = var.k8s_master_vm_data_disk_location
  vm_tags                    = var.k8s_master_tags
}

module "k8s_worker" {
  source                     = "./modules/proxmox_vm"
  pm_target_node             = var.k8s_worker_target_node
  cluster_name               = var.k8s_worker_cluster_name
  cluster_node_count         = var.k8s_worker_cluster_node_count
  vm_template_name           = var.k8s_worker_vm_template_name
  vm_os_type                 = var.k8s_worker_vm_os_type
  vm_bootdisk                = var.k8s_worker_vm_bootdisk
  vm_user                    = var.k8s_worker_vm_user
  vm_user_password           = var.k8s_worker_user_password
  vm_user_sshkey             = var.k8s_worker_user_sshkey
  vm_memory                  = var.k8s_worker_vm_memory
  vm_cpu_type                = var.k8s_worker_vm_cpu_type
  vm_vcpu                    = var.k8s_worker_vm_vcpu
  vm_host_number             = var.k8s_worker_vm_network_cidr_host_number
  vm_nameserver              = var.vm_nameserver
  vm_network_cidr            = var.k8s_worker_vm_network_cidr
  vm_cloudinit_cdrom_storage = var.k8s_worker_vm_cloudinit_cdrom_storage
  vm_os_disk_size            = var.k8s_worker_vm_os_disk_size
  vm_os_disk_location        = var.k8s_worker_vm_os_disk_location
  vm_data_disk_size          = var.k8s_worker_vm_data_disk_size
  vm_data_disk_location      = var.k8s_worker_vm_data_disk_location
  vm_tags                    = var.k8s_worker_tags
}

resource "time_sleep" "wait_vm_create" {
  depends_on      = [module.rke_cluster, module.k8s_master, module.k8s_worker]
  create_duration = "90s"
}

resource "null_resource" "check_ssh_rke_cluster" {
  depends_on = [time_sleep.wait_vm_create]
  count      = length(module.rke_cluster.vms_info)
  connection {
    type = "ssh"
    user = var.k8s_master_vm_user
    host = module.rke_cluster.vms_info[count.index].vm_ip
  }
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -o LogLevel=DEBUG -i ${var.bastion_sshkey_location} ${module.rke_cluster.vms_info[count.index].vm_user}@${module.rke_cluster.vms_info[count.index].vm_ip} exit"
  }
}

resource "null_resource" "check_ssh_k8s_master" {
  depends_on = [time_sleep.wait_vm_create]
  count      = length(module.k8s_master.vms_info)
  connection {
    type = "ssh"
    user = var.k8s_master_vm_user
    host = module.k8s_master.vms_info[count.index].vm_ip
  }
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -o LogLevel=DEBUG -i ${var.bastion_sshkey_location} ${module.k8s_master.vms_info[count.index].vm_user}@${module.k8s_master.vms_info[count.index].vm_ip} exit"
  }
}

resource "null_resource" "check_ssh_k8s_worker" {
  depends_on = [time_sleep.wait_vm_create]
  count      = length(module.k8s_worker.vms_info)
  connection {
    type = "ssh"
    user = var.k8s_worker_vm_user
    host = module.k8s_worker.vms_info[count.index].vm_ip
  }
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -o LogLevel=DEBUG -i ${var.bastion_sshkey_location} ${module.k8s_worker.vms_info[count.index].vm_user}@${module.k8s_worker.vms_info[count.index].vm_ip} exit"
  }
}

resource "local_file" "ansible_inventory" {
  depends_on = [null_resource.check_ssh_rke_cluster, null_resource.check_ssh_k8s_master, null_resource.check_ssh_k8s_worker]
  filename   = "${path.cwd}/ansible/inventory.yaml"
  content = templatefile("${path.cwd}/ansible/inventory.tpl", {
    rke_info    = module.rke_cluster.vms_info,
    master_info = module.k8s_master.vms_info,
    worker_info = module.k8s_worker.vms_info
  })
}
resource "null_resource" "ansible_update_os" {
  depends_on = [local_file.ansible_inventory]
  provisioner "local-exec" {
    working_dir = "${path.cwd}/ansible"
    command     = "ansible-playbook -i inventory.yaml update_os.yaml -v"
  }
}

resource "null_resource" "ansible_install_rke" {
  depends_on = [null_resource.ansible_update_os]
  provisioner "local-exec" {
    working_dir = "${path.cwd}/ansible"
    command     = "ansible-playbook -i inventory.yaml rke_install.yaml -v"
  }
}
