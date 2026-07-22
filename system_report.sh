#!/usr/bin/env bash

# =====================================
# Linux System Report
# Author: sdmx44
# Version: 1.0 
# Description:
# Generates a simple Linux system report.
# =====================================

print_header(){

echo "=========================================="
echo "           Linux System Report            "
echo "=========================================="

}

show_date(){
	echo "Date       : $(date)"
}

show_user(){
	echo "User       : $(whoami)"
}

show_hostname(){
	echo "Hostname   : $(hostname)"
}

show_kernel(){
 	echo "Kernel     : Linux $(uname -r)"
}

show_uptime(){
	echo "Uptime     : $(uptime -p)"
}
show_disk_usage(){

	DISK_INFO=$(df -h / | tail -n 1)
	FILESYSTEM=$( echo "$DISK_INFO" | awk '{print $1}')
	SIZE=$( echo "$DISK_INFO" | awk '{print $2}')
	USED=$( echo "$DISK_INFO" | awk '{print $3}')
	AVAILABLE=$( echo "$DISK_INFO" | awk '{print $4}')
	USAGE=$( echo "$DISK_INFO" | awk '{print $5}')
	MOUNT=$( echo "$DISK_INFO" | awk '{print $6}')
	
echo
echo "========== Disk Usage =========="
echo "Filesystem : $FILESYSTEM"
echo "Size       : $SIZE"
echo "Used       : $USED"
echo "Available  : $AVAILABLE"
echo "Usage      : $USAGE"
echo "Mount on   : $MOUNT"
}

show_memory_usage(){

	MEM_INFO=$(free -h | grep Mem)
	MEM_TOTAL=$(echo "$MEM_INFO" | awk '{print $2}')
	MEM_USED=$(echo "$MEM_INFO" | awk '{print $3}')
	MEM_FREE=$(echo "$MEM_INFO" | awk '{print $7}')
	SWAP_INFO=$(free -h | grep Swap)
	SWAP_TOTAL=$(echo "$SWAP_INFO" | awk '{print $2}')
	SWAP_USED=$(echo "$SWAP_INFO" | awk '{print $3}')
	SWAP_FREE=$(echo "$SWAP_INFO" | awk '{print $4}')

echo "======== Memory Usage =========="
echo "Total RAM  : $MEM_TOTAL"
echo "Used RAM   : $MEM_USED"
echo "Free RAM   : $MEM_FREE"
echo 
echo "Total Swap  : $SWAP_TOTAL"
echo "Used Swap   : $SWAP_USED"
echo "Free Swap   : $SWAP_FREE"

}

show_services(){

	SSH_STATUS=$(systemctl is-active sshd)
	FIREWALL_STATUS=$(systemctl is-active firewalld)


echo "========== Services ============"
if [ "$SSH_STATUS" = "active" ]; then
	echo "SSH service   : Running"
else
	echo "SSH service   : Stopped"	
fi
if [ "$FIREWALL_STATUS" = "active" ]; then
	echo "Firewall      : Running"
else
	echo "Firewall      : Stopped"
fi
}
echo
print_header
echo
echo "=========== General ============"
show_date
show_user
show_hostname
show_kernel
show_uptime
echo
show_disk_usage
echo
show_memory_usage
echo
show_services
echo
