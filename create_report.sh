#!/bin/bash
#
# sokdr
#
source ./audit.sh
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
REPORT_TABLE_HEADER="<table>"$'\n'"<tr>"$'\n'"  <td>№</td>"$'\n'"  <td>Parametr</th>"$'\n'"  <td>Value</td>"$'\n'"</td>"
REPORT_TABLE_FOOTER="</table>"
AUDIT_HEADER="MySQL"
REPORT_PAGE_HEADER="<h1>"$AUDIT_HEADER"</h1>"
touch ./report.html
START=$(date +%s)
AUDIT_HEADER="MySQL"
cat > report.html << EOF
<!DOCTYPE html>
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet'>
<style>
    .panel {
      position: fixed;
      width: 100%;
      height: 40px;
      background: black;
      left: 0;
      right: 0;
      bottom: 0;
      font-size: 8px;
      padding: 0;
      display: flex;
      border: 1px solid #DFDFDF;
    }

    .panelButton {
      display: inline-block;
      align-items: center;
      background-color: rgba(240, 240, 240, 0.26);
      border: 1px solid #DFDFDF;
      border-radius: 16px;
      box-sizing: border-box;
      color: #000000;
      cursor: pointer;
      font-family: Inter, sans-serif;
      font-size: 15px;
      width: 160px;
      height: 40px;
      text-decoration: none;
      transition: all .2s;
      user-select: none;
      -webkit-user-select: none;
      touch-action: manipulation;
    }

    .panelButton:active,
    .panelButton:hover {
      outline: 0;
    }

    .panelButton:hover {
      background-color: #FFFFFF;
      border-color: rgba(0, 0, 0, 0.19);
    }

    .invisible {
      display: none;
    }

    button svg {
      width: 20px;
      padding: auto;
      transition: all 1.8s;
    }

    table, th, td {
      border: 1px solid var(--table, #D9D9D9); 
      font-family: Lato;
      font-weight: lighter;
      padding: 10px;
      gap: 10px;
      text-align: center;
    }

    td {
      font-weight: bold;
    }
</style>
<html>
    <head>
        <title>Report</title>
    </head>
    <body>
$REPORT_PAGE_HEADER
$REPORT_TABLE_HEADER
$AUDIT_MYSQL_VERSION
$AUDIT_MYSQL_ENGINE
$AUDIT_MYSQL_BASEDIR
$AUDIT_MYSQL_DATADIR
$AUDIT_MYSQL_TMPDIR
$AUDIT_MYSQL_PORT
$AUDIT_MYSQL_SOCKET
$AUDIT_MYSQL_PID_FILE
$AUDIT_MYSQL_BIND_ADDRESS
$AUDIT_MYSQL_LOG_OUTPUT
$AUDIT_MYSQL_GENERAL_LOG
$AUDIT_MYSQL_ERROR_LOG
$AUDIT_MYSQL_SLOW_LOG
$AUDIT_MYSQL_RELAY_LOG
$AUDIT_MYSQL_UNDO_LOG_SIZE
$AUDIT_MYSQL_EXPIRE_LOGS_DAYS
$AUDIT_MYSQL_BINLOG_FORMAT
$AUDIT_MYSQL_FORCE_RECOVERY
$AUDIT_MYSQL_READ_ONLY_STATUS
$AUDIT_MYSQL_AUTH_PLUGIN
$AUDIT_MYSQL_CHUNK_SIZE
$AUDIT_MYSQL_BUFFER_POOL_SIZE
$AUDIT_MYSQL_OPEN_FILES
$AUDIT_MYSQL_BUFFER_POOL_FILENAME
$AUDIT_MYSQL_BUFFER_POOL_DUMP
$AUDIT_MYSQL_REPL_DELAY
$AUDIT_MYSQL_PAGE_SIZE
$REPORT_TABLE_FOOTER
        <div class="panel"></div>
    </body>
</html>

EOF

END=$(date +%s)
DIFF=$(( $END - $START ))
echo Script completed in $DIFF seconds :
echo
echo Executed on :
date

exit 0;