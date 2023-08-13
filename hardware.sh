CPU=$(cat /proc/cpuinfo)
function hardware_check {
    echo "###############################################"
    echo
    echo -e "01. CPU/System Information"
    echo
    CPU=$(cat /proc/cpuinfo)
    echo
    echo "###############################################"
    echo
    echo -e "02. Available RAM"
    echo
    free -h
    echo
    echo "###############################################"
    echo
    echo -e "03. Available Disk Space"
    echo
    df -h
    echo
    echo "###############################################"
    echo
    echo -e "04. RAID Info"
    echo
    cat /proc/mdstat
    echo
    echo "###############################################"
    echo
    echo -e "05. RAID Info"
    echo
	lvm_installed=$(apt-cache pkgnames | grep -x "lvm2")
	if [ -z "lvm_installed" ]
    then
		echo -e "LVM not installed"
    else
		pvs
		vgs
		lvs
    fi
    echo
    echo "###############################################"
    echo
    echo -e "06. Network Interfaces"
    echo
    ifconfig -a
    echo
    echo "###############################################"
    echo
    echo -e "06. Uptime Information"
    echo
    uptime
    echo
}
