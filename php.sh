function php_check {
	php_installed=$(service --status-all | grep '+' | grep php)
    if [ "$php_installed" ]
        then {
			echo "###############################################"
			echo
			echo -e "01. PHP Version"
			echo
			php -i | grep -m1 "PHP Version" | cut -d= -f2- | cut -c 3-
			echo
			echo "###############################################"
			echo
			echo -e "02. PHP Loaded Configuration File"
			echo
			php -i | grep "Loaded Configuration File" | cut -d= -f2- | cut -c 3-
			echo
			echo "###############################################"
			echo
			echo -e "03. PHP Loaded Configuration File"
			echo
			php -i | grep "Loaded Configuration File" | cut -d= -f2- | cut -c 3-
			echo
			echo "###############################################"
			echo
			echo -e "04. PHP Loaded Configuration File"
			echo
			php -i | grep "Configuration File (php.ini) Path" | cut -d= -f2- | cut -c 3-
			echo
			echo "###############################################"
			echo
			echo -e "05. PHP Modules"
			echo
			php -m
			echo "###############################################"
			echo
        } else 
        	echo "PHP not installed"
        fi
}
