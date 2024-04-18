all:
    hosts:
%{ for vm in rke_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"
%{ endfor ~}
%{ for vm in master_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"
%{ endfor ~}
%{ for vm in worker_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"
%{ endfor ~}
rke_cluster:
    hosts:
%{ for vm in rke_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"    
%{ endfor ~}            
k8s_master:
    hosts:
%{ for vm in master_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"
%{ endfor ~}
k8s_worker:
    hosts:
%{ for vm in worker_info ~}
        ${vm.vm_name}:
            ansible_host: ${vm.vm_ip}
            ansible_port: 22
            ansible_ssh_user: ${vm.vm_user}
            ansible_ssh_private_key_file: "~/.ssh/homelab"
%{ endfor ~}    
k8s_cluster:
    children:
        k8s_master:
        k8s_worker:


