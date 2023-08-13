#!/bin/bash
#
# sokdr
#
source hardware.sh
source linux.sh
source mysql.sh
source nginx.sh
source network.sh
source packages.sh
source php.sh
source redis.sh
source users.sh
tput clear
trap ctrl_c INT

function ctrl_c() {
	echo "**You pressed Ctrl+C...Exiting"
	exit 0;
}

echo -e "###############################################"
echo -e "###############################################"
echo -e "###############################################"
echo "_    _                 _          _ _ _   "
echo "| |  (_)_ _ _  ___ __  /_\ _  _ __| (_) |_ "
echo "| |__| |   \ || \ \ / / _ \ || / _  | |  _|"
echo "|____|_|_||_\_ _/_\_\/_/ \_\_ _\__ _|_|\__|"
echo
echo "###############################################"
echo "Welcome to security audit of your linux machine:"
echo "###############################################"
echo
echo "Script will automatically gather the required info:"
echo "The checklist can help you in the process of hardening your system:"
echo "Note: it has been tested for Debian Linux Distro:"
echo
sleep 3
echo
echo "File will be saved on $path/LinuxAudit.txt "
echo
touch $path/LinuxAudit.txt
{            
		echo "###############################################"
    	echo
    	echo
    	sleep 3
		echo
		echo "Script Starts"
		START=$(date +%s)
		echo
		{
			hardware_check
			linux_check
			mysql_check
			network_check
			nginx_check
			packages_check
			php_check
			redis_check
			users_check
		}
    	END=$(date +%s)
    	DIFF=$(( $END - $START ))
    	echo Script completed in $DIFF seconds :
    	echo
    	echo Executed on :
    	date
    	echo
    	exit 0;
} >  $path/LinuxAudit.txt
done

END=$(date +%s)
DIFF=$(( $END - $START ))
echo Script completed in $DIFF seconds :
echo
echo Executed on :
date
echo

exit 0;
