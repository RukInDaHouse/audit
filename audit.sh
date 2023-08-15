################# Linux Information #################

#01. Linux Kernel Information
AUDIT_UNAME=$(uname -a)
#02. Linux Distribution Information
AUDIT_RELEASE=$(lsb_release -a)

################# System Information #################

#01. CPU/System Information
AUDIT_CPUINFO=$(cat /proc/cpuinfo)
#02. Available RAM
AUDIT_FREE=$(free -h)
#03. Available Disk Space"
AUDIT_DISK_SPACE=$(df -h)
#04. RAID Info
AUDIT_MDSTAT=$(cat /proc/mdstat)untitled:Untitled-1
#05. LVM Info
lvm_installed=$(apt-cache pkgnames | grep -x "lvm2")
if [ -z "lvm_installed" ]
then {
	AUDIT_LVM_AVAILABILITY="0"
} else {
	AUDIT_LVM_AVAILABILITY="1"
	AUDIT_PVS="$pvs"
	AUDIT_VGS="$vgs"
	AUDIT_LVS="$lvs"
}
#06. Network Interfaces
AUDIT_NETWORK_INTERFACES=$(ifconfig -a)

################# Services Information #################

#01. Running Services
AUDIT_SERVICES="$(service --status-all |grep "+")"
#02. Check Running Processes
AUDIT_PROCESSES="$(ps -a)"
#03. List All Packages Installed
AUDIT_PACKAGES="$(apt-cache pkgnames)"
#04. Check for Broken Dependencies
AUDIT_BROKEN_DEPENDENCIES="$(apt-get check)"
#05. Check Upgradable Packages
AUDIT_UPGRADABLE_PACKAGES="$(apt list --upgradeable)"
#06. Check your Source List File
AUDIT_SOURCE_LIST="$(cat /etc/apt/sources.list)"

################# Users Information #################

#01. Current Logged In Users
AUDIT_LOGGED_USERS="$(w)"
#02. List User Names
AUDIT_USER_NAMES="$(cut -d: -f1 /etc/passwd)"
#03. Check for Null Passwords
AUDIT_NULL_PASSWORDS="$(sudo getent shadow | grep '^[^:]*:.\?:' | cut -d: -f1)"
#04. Password Policies
AUDIT_PASSWORD_POLICES="$(cat /etc/pam.d/common-password)"

################# Network Information #################

#01. Network Parameters
AUDIT_SYSCTL="$(/etc/sysctl.conf)"
#02. Active Internet Connections and Open Ports
AUDIT_OPEN_PORTS="$(netstat -lnap | grep LISTEN | grep -v LISTENING | awk '{print "|"$1"|"$4"|"$7"|"}')"
#03. IPtable Information
AUDIT_IPTABLES="$(iptables -L -n -v)"
#04. IP Routing Table
AUDIT_ROUTE="$(route -n | awk '{print "|"$1"|"$2"|"$3"|"$4"|"$5"|"$6"|"$7"|"$8"|"}')"
#05. TCP wrappers
AUDIT_ALLOW_HOSTS="$(cat /etc/hosts.allow)"
AUDIT_DENY_HOSTS="$(cat /etc/hosts.deny)"
#06. Check SSH Configuration
AUDIT_SSH_CONFIG="$(cat /etc/ssh/sshd_config)"
#07. Failed login attempts
AUDIT_DENY_HOSTS="$(grep --color "failure" /var/log/auth.log)"

################# Nginx Information #################

nginx_installed=$(service --status-all | grep '+' | grep nginx)
	if [ "$nginx_installed" ]
		then {
			AUDIT_NGINX_AVAILABILITY="1"
			#01. Nginx Version
			AUDIT_NGINX_VERSION="$(nginx -V)"
			#02. Nginx Modules
			AUDIT_NGINX_MODULES="$(nginx -V)"
		} else
			AUDIT_NGINX_AVAILABILITY="0"
		fi

################# PHP Information #################

php_installed=$(service --status-all | grep '+' | grep php)
    if [ "$php_installed" ]
        then {
			AUDIT_PHP_AVAILABILITY="1"
			#01. PHP Version
			AUDIT_PHP_VERSION="$(php -i | grep -m1 "PHP Version" | cut -d= -f2- | cut -c 3-)"
			#02. PHP Loaded Configuration File
			AUDIT_PHP_CONFIG="$(php -i | grep "Loaded Configuration File" | cut -d= -f2- | cut -c 3-)"
			#03. Configuration File (php.ini) Path
			AUDIT_PHP_PATH="$(php -i | grep "Configuration File (php.ini) Path" | cut -d= -f2- | cut -c 3-)"
			#04. PHP Modules
			AUDIT_PHP_MODULES="$(php -m)"
        } else 
        	AUDIT_PHP_AVAILABILITY="0"
        fi

################# MySQL Information #################

mysql_installed=$(service --status-all | grep '+' | grep mysql)
	if [ "$mysql_installed" ]
		then {
			AUDIT_MYSQL_AVAILABILITY="1"
			# 01. Current MySQL Version
			AUDIT_MYSQL_VERSION="<tr>"$'\n'"  <th>01</th>"$'\n'"  <th>Current MySQL Version</th>"$'\n'"  <th>$(mysql -V)<th>"$'\n'"</tr>"
			# 02. Current MySQL Default Engine
			AUDIT_MYSQL_ENGINE="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "default_storage_engine" | awk '{print $2}')"
			# 03. Current MySQL Basedir
			AUDIT_MYSQL_BASEDIR="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "basedir" | awk '{print $2}')"
			# 04. Current MySQL Datadir
			AUDIT_MYSQL_DATADIR="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "datadir" | awk '{print $2}')"
			# 05. Current MySQL TMP Dir
			AUDIT_MYSQL_TMPDIR="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "tmpdir" | awk '{print $2}')"
			# 06. Current MySQL Port
			AUDIT_MYSQL_PORT="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "port" | awk '{print $2}')"
			# 07. Current MySQL Socket
			AUDIT_MYSQL_SOCKET="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "socket" | awk '{print $2}')"
			# 08. Current MySQL PID File
			AUDIT_MYSQL_PID_FILE="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "pid_file" | awk '{print $2}')"
			# 09. Current MySQL Bind Address
			AUDIT_MYSQL_BIND_ADDRESS="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "bind_address" | awk '{print $2}')"
			# 10. Current MySQL Log Output
			AUDIT_MYSQL_LOG_OUTPUT="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "log_output" | awk '{print $2}')"
			# 11. Current MySQL General Log File
			AUDIT_MYSQL_GENERAL_LOG="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "general_log_file" | awk '{print $2}')"
			# 12. Current MySQL Error Log File
			AUDIT_MYSQL_ERROR_LOG="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "log_error" | awk '{print $2}')"
			# 13. Current MySQL Slow Query Log File
			AUDIT_MYSQL_SLOW_LOG="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "slow_query_log_file" | awk '{print $2}')"
			# 14. Current MySQL Relay Log File
			AUDIT_MYSQL_RELAY_LOG="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "relay_log" | awk '{print $2}')"
			# 15. Current Innodb Max Undo Log Size
			AUDIT_MYSQL_UNDO_LOG_SIZE="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "innodb_max_undo_log_size" | awk '{print $2}')"
			# 16. Current MySQL Expire Logs Days
			AUDIT_MYSQL_EXPIRE_LOGS_DAYS="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "expire_logs_days" | awk '{print $2}')"
			# 17. Current Binlog Format
			AUDIT_MYSQL_BINLOG_FORMAT="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "binlog_format" | awk '{print $2}')"
			# 18. Current Innodb Force Recovery Level
			AUDIT_MYSQL_FORCE_RECOVERY="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "innodb_force_recovery" | awk '{print $2}')"
			# 19. Current Innodb Read Only Status
			AUDIT_MYSQL_READ_ONLY_STATUS="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "innodb_read_only" | awk '{print $2}')"
			# 20. Current Default Authentication Plugin
			AUDIT_MYSQL_AUTH_PLUGIN="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "default_authentication_plugin" | awk '{print $2}')"
			# 21. Current Innodb Buffer Pool Chunk Size
			AUDIT_MYSQL_CHUNK_SIZE="$(mysql -e "show variables like 'innodb_%';" | grep "innodb_buffer_pool_chunk_size" | awk '{print $2}')"
			# 22. Current Innodb Buffer Pool Size
			AUDIT_MYSQL_BUFFER_POOL_SIZE="$(mysql -e "show variables like 'innodb_%';" | grep "innodb_buffer_pool_size" | awk '{print $2}')"
			# 23. Current Innodb Open Files
			AUDIT_MYSQL_OPEN_FILES="$(mysql -e "show variables like 'innodb_%';" | grep "innodb_open_files" | awk '{print $2}')"
			# 24. Current Innodb Buffer Pool Filename
			AUDIT_MYSQL_BUFFER_POOL_FILENAME="$(mysql -e "show variables like 'innodb_%';" | grep "innodb_buffer_pool_filename" | awk '{print $2}')"
			# 25. Current Innodb Buffer Pool Dump At Shutdown
			AUDIT_MYSQL_BUFFER_POOL_DUMP="$(mysql -e "show variables like 'innodb_%';" | grep "innodb_buffer_pool_dump_at_shutdown" | awk '{print $2}')"
			# 26. Current Innodb Replication Delay
			AUDIT_MYSQL_REPL_DELAY="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "innodb_replication_delay" | awk '{print $2}')"
			# 27. Current Innodb Page Size
			AUDIT_MYSQL_PAGE_SIZE="$(mysql -e "SHOW GLOBAL VARIABLES" | grep "innodb_page_size" | awk '{print $2}')"
		} else
			AUDIT_MYSQL_AVAILABILITY="0"
		fi

################# Redis Information #################

redis_installed=$(service --status-all | grep '+' | grep redis)
    if [ "$redis_installed" ]
        then {
			AUDIT_REDIS_AVAILABILITY="1"
            #01. Current Redis Version
            AUDIT_REDIS_VERSION="$(redis-cli info | grep redis_version: | cut -d: -f2-)"
            #02. Current GCC Version
            AUDIT_REDIS_GCC_VERSION="$(redis-cli info | grep gcc_version: | cut -d: -f2-)"
			#03. Current memory usage
            AUDIT_REDIS_MEMORY_USAGE="$(redis-cli info memory | grep used_memory_human: | cut -d: -f2-)"
            #04. Current rss memory usage
            AUDIT_REDIS_RSS_MEMORY_USAGE="$(redis-cli info memory | grep used_memory_rss_human: | cut -d: -f2-)"
            #05. Current memory peak usage
            AUDIT_REDIS_PEAK_MEMORY_USAGE="$(redis-cli info memory | grep used_memory_peak_human: | cut -d: -f2-)"
            #06. AOF status
            AUDIT_REDIS_AOF_STATUS="$(redis-cli info | grep aof_enabled: | cut -d: -f2-)"
            #07. RDB last time
            AUDIT_REDIS_RDB_LAST_TIME="$(redis-cli info | grep rdb_last_bgsave_time_sec: | cut -d: -f2-)"
            #08. RDB last changes
            AUDIT_REDIS_RDB_LAST_CHANGES="$(redis-cli info | grep rdb_changes_since_last_save: | cut -d: -f2-)"
        } else 
            AUDIT_REDIS_AVAILABILITY="0"
        fi

#####################################################

