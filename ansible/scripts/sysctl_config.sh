#!/bin/bash

# Check if bc command is available
if ! command -v bc &>/dev/null; then
    echo "This script requires GNU bc. Install it with: sudo apt install bc -y"
    exit 1
fi

# Backup sysctl.conf
cp /etc/sysctl.conf /etc/sysctl.conf.bk

# Update system limits
cat <<EOF >> /etc/security/limits.conf
*       -       nofile  65535
*       -       fsize   unlimited
*       -       cpu     unlimited
*       -       memlock unlimited
*       -       data    unlimited
*       -       nproc   64000

root    -       nofile  65535
root    -       nproc   64000
EOF

# Calculate system parameters
mem_bytes=$(awk '/MemTotal:/ { printf "%0.f",$2 * 1024}' /proc/meminfo)
shmmax=$(echo "$mem_bytes * 0.90" | bc | cut -f 1 -d '.') 
shmall=$(expr $mem_bytes / $(getconf PAGE_SIZE))
max_orphan=$(echo "$mem_bytes * 0.10 / 65536" | bc | cut -f 1 -d '.')
file_max=$(echo "$mem_bytes / 4194304 * 256" | bc | cut -f 1 -d '.')
max_tw=$(($file_max*2))
min_free=$(echo "($mem_bytes / 1024) * 0.01" | bc | cut -f 1 -d '.')

# Update sysctl.conf
cat <<EOF > /etc/sysctl.conf
net.ipv4.tcp_syncookies = 0
net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_synack_retries = 3
net.ipv4.tcp_syn_retries = 3
net.ipv4.tcp_rfc1337 = 1
net.ipv4.ip_local_port_range = 1024 65535
net.ipv4.conf.all.log_martians = 1
net.ipv4.tcp_ecn = 0
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1
net.ipv4.tcp_fack = 1
net.ipv4.tcp_dsack = 1
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_syn_backlog = 20000
net.ipv4.tcp_max_orphans = $max_orphan
net.ipv4.tcp_orphan_retries = 0
net.ipv4.tcp_fin_timeout = 20
net.ipv4.tcp_max_tw_buckets = $max_tw
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_rmem = 4096 87380 33554432 
net.ipv4.tcp_wmem = 4096 65536 33554432
net.core.rmem_max = 33554432
net.core.wmem_max = 33554432
net.core.netdev_max_backlog = 2500
net.core.somaxconn = 65000
vm.swappiness = 10
vm.dirty_background_ratio = 5
vm.dirty_ratio = 15
vm.min_free_kbytes = $min_free
fs.file-max = 64000
fs.suid_dumpable = 2 
kernel.printk = 4 4 1 7
kernel.core_uses_pid = 1
kernel.sysrq = 0
kernel.msgmax = 65536
kernel.msgmnb = 65536
kernel.shmmax = $shmmax
kernel.shmall = $shmall
vm.overcommit_memory = 1
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
net.ipv4.tcp_mem = 786432 1048576 26777216
net.ipv4.tcp_max_tw_buckets = 360000
EOF

echo "System parameters updated."
/sbin/sysctl -p /etc/sysctl.conf
