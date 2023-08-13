function redis_check {
    redis_installed=$(service --status-all | grep '+' | grep redis)
    if [ "$redis_installed" ]
        then {
            echo "###############################################"
            echo
            echo -e "01. Current Redis Version"
            echo
            redis-cli info | grep redis_version: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "02. Current GCC Version"
            echo                   
            redis-cli info | grep gcc_version: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "03. Current memory usage"
            echo
            redis-cli info memory | grep used_memory_human: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "04. Current rss memory usage"
            echo
            redis-cli info memory | grep used_memory_rss_human: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "05. Current memory peak usage"
            echo
            redis-cli info memory | grep used_memory_peak_human: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "06. AOF status"
            echo
            redis-cli info | grep aof_enabled: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "07. RDB last time"
            echo
            redis-cli info | grep rdb_last_bgsave_time_sec: | cut -d: -f2-
            echo
            echo "###############################################"
            echo
            echo -e "08. RDB last changes"
            echo
            redis-cli info | grep rdb_changes_since_last_save: | cut -d: -f2-
            echo
        } else 
            echo "Redis not installed"
        fi
}