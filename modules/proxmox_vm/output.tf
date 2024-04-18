output "vms_info" {
  value = [
    for vm in proxmox_vm_qemu.cluster : {
      vm_name = vm.name
      vm_user = vm.ssh_user
      vm_ip   = regex("(\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b)", vm.ipconfig0)[0]
    }
  ]
}
output "vm_info" {
  value = {
    for vm in proxmox_vm_qemu.cluster : vm.name => {
      vm_ip   = regex("(\\b(?:[0-9]{1,3}\\.){3}[0-9]{1,3}\\b)", vm.ipconfig0)[0]
      vm_user = vm.ssh_user
    }
  }
}
