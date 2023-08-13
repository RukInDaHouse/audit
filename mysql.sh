function mysql_check {
	mysql_installed=$(service --status-all | grep '+' | grep mysql)
    if [ "$mysql_installed" ]
		then {
			echo "###############################################"
			echo
			echo -e "01. Current MySQL Version"
			echo
			mysql -V
			echo
			echo "###############################################"
			echo
			echo -e "02. Current MySQL Variables"
			echo
			mysql -e "show variables like 'innodb_%';"
			echo
		} else
			echo "MySQL not installed"
		fi
}