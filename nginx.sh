function nginx_check {
	nginx_installed=$(service --status-all | grep '+' | grep nginx)
    if [ "$nginx_installed" ]
		then {
			echo "###############################################"
			echo
			echo -e "01. Nginx Version"
			echo
			nginx -V
			echo
			echo "###############################################"
			echo
			echo -e "02. Nginx Modules"
			echo
			nginx -V
			echo
		} else
			echo "PHP not installed"
		fi
}
