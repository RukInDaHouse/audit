function linux_check {
	echo "###############################################"
    echo -e "01. Linux Kernel Information"
    echo
    uname -a
    echo
    echo "###############################################"
    echo
    echo -e "02. Linux Distribution Information"
    echo
    lsb_release -a
    echo
}
