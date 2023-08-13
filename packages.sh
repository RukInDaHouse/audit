function packages_check {
    echo "###############################################"
    echo
    echo -e "01. Running Services"
    echo
    service --status-all |grep "+"
    echo
	echo "###############################################"
    echo
    echo -e "02. Check Running Processes"
    echo
    ps -a
    echo
	echo "###############################################"
	echo
    echo -e "03. List All Packages Installed"
	echo
    apt-cache pkgnames
    echo
    echo "###############################################"
    echo
    echo -e "04. Check for Broken Dependencies"
    echo
    apt-get check
    echo
	echo "###############################################"
    echo
    echo -e "05. Check Upgradable Packages"
    echo
    apt list --upgradeable
    echo
	echo "###############################################"
    echo
	echo -e "06. Check your Source List File"
    echo
    cat /etc/apt/sources.list
    echo
}
