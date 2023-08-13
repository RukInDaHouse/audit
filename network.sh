function network_check {
    echo "###############################################"
	echo
    echo -e "01. Network Parameters"
    echo
    cat /etc/sysctl.conf
    echo
    echo "###############################################"
    echo
    echo -e "02. Active Internet Connections and Open Ports"
    echo
    netstat -lnap | grep LISTEN | grep -v LISTENING | awk '{print "|"$1"|"$4"|"$7"|"}'
    echo
    echo "###############################################"
    echo
    echo -e "03. IPtable Information"
    echo
    iptables -L -n -v
    echo
    echo "###############################################"
    echo
    echo -e "04. IP Routing Table"
    echo
    route -n | awk '{print "|"$1"|"$2"|"$3"|"$4"|"$5"|"$6"|"$7"|"$8"|"}'
    echo
    echo "###############################################"
    echo
    echo -e "05. TCP wrappers"
    echo
    cat /etc/hosts.allow
    echo
    cat /etc/hosts.deny
    echo
	echo "###############################################"
	echo
    echo -e "06. Check SSH Configuration"
    echo
    cat /etc/ssh/sshd_config
    echo
    echo "###############################################"
    echo
    echo -e "07. Failed login attempts"
    echo
    grep --color "failure" /var/log/auth.log
    echo
    echo "###############################################"
}
