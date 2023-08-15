#!/bin/bash
#
# sokdr
#
source ./variables.sh
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
REPORT_TABLE_HEADER="<table class="center">"
REPORT_TABLE_FOOTER="</table>"
REPORT_DATE=$(date)
REPORT_TITLE="<h2><b>Hostname:</b> $HOSTNAME<br><b>Date:</b> $REPORT_DATE</h2>"
AUDIT_HEADER="MySQL"
REPORT_PAGE_HEADER="<h1>"$AUDIT_HEADER"</h1>"
touch ./report.html
START=$(date +%s)
AUDIT_HEADER="MySQL"
cat > report.html << EOF
<!DOCTYPE html>
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet'>
<style>
    h1 {
      text-align: center;
      font-family: Lato;
      font-style: normal;
      font-weight: 700;
      line-height: normal; 
      font-weight: bold;
    }

    h2 {
      text-align: left;
      font-family: Lato;
      font-style: normal;
      font-weight: 400;
      line-height: normal;
      font-size: 18px;
      margin-left: 5%;
    }

    .darkMode {
      background-color: #757575;
      color: #FFF;
    }

    .lightMode {
      background-color: #F5F5F5;
      color: #000000;
    }

    .buffer {
      width: 100%;
      height: 50px;
    }

    .center {
      margin-left: auto;
      margin-right: auto;
    }

    .swapMode {
      position: fixed;
      top: 15px;
      right: 15px;
      width: 50px;
      height: 50px;
      cursor: pointer;
    }

    .swapModeDark {
      -webkit-filter: invert(95%);
      filter: invert(95%);
    }

    .panel {
      position: fixed;
      width: 100%;
      height: 50px;
      left: 0;
      right: 0;
      bottom: 0;
      font-size: 8px;
      padding: 0;
      display: flex;
      border: 1px solid #DFDFDF;
      border-bottom: none;
      border-left: none;
      border-top: none;  
    }

    .panelLightMode {
      background: rgba(240, 240, 240, 1);
    }

    .panelDarkMode {
      background-color: #757575;
    }

    .panelButtonLightMode {
      background: rgba(240, 240, 240, 1);
      color: #000000;
    }

    .panelButtonDarkMode {
      background-color: #757575;
      color: #FFF;
    }

    .logo {
      display: inline-block;
      align-items: center;
      width: 50px;
      height: 50px;
      background: #252833;
      border: none;
      text-decoration: none;
      transition: all .2s;
      cursor: pointer;
    }

    .logo:active,
    .logo:hover {
      outline: 0;
    }

    .logo:hover {
      background-color: #FFFFFF;
      border-color: rgba(0, 0, 0, 0.19);
    }

    .panelButton {
      display: inline-block;
      align-items: center;
      border: 1px solid #FFFFFF;
      border-bottom: none;
      border-top: none;
      box-sizing: border-box;
      cursor: pointer;
      font-family: Lato;
      font-size: 15px;
      width: 160px;
      height: 50px;
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

    .panelButtonLightMode:hover {
      background-color: #FFFFFF;
      border-color: rgba(0, 0, 0, 0.19);
    }

    .panelButtonDarkMode:hover {
      background-color: #444;
      border-color: rgba(0, 0, 0, 0.19);
    }

    .invisible {
      display: none;
    }

    svg {
      width: 50px;
      height: 50px;
      padding: auto;
      transition: all 1.8s;
    }

    table, th, td {
      border: 1px solid var(--table, #D9D9D9); 
      font-family: Lato;
      font-style: normal;
      font-weight: 400;
      line-height: normal; 
      padding: 10px;
      text-align: center;
    }

    table {
      border-collapse: collapse;
      margin: 30px;
      width: 90%; 
    }

    td {
      height: 90px;
      font-style: normal;
      font-weight: 700;
      line-height: normal; 
      font-weight: bold;
    }

    tr:nth-child(even) {
      background: var(--05-ff-00, rgba(5, 255, 0, 0.20))
    }

    .cellLightMode {
      background: #F5F5F5;
    }

    .cellDarkMode {
      background: #959595;
    }
</style>
<html>
    <head>
        <title>Report</title>
    </head>
    <body class="lightMode">
    <div class="swapMode" onclick="myFunction()">
      <svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 64 62">
        <path d="m56.6 32-7.2 7.2v10.2H39.2L32 56.6l-7.2-7.2H14.6V39.2L7.4 32l7.2-7.2V14.6h10.2L32 7.4l7.2 7.2h10.2v10.2l7.2 7.2zm-11.8 5.3c2.9-7-.4-15.1-7.5-18.1-5.4-2.2-11.6-.8-15.5 3.5 3.1-2 6.9-2.3 10.2-.9 5.6 2.3 8.3 8.8 6 14.4-2.3 5.6-8.8 8.3-14.5 6l-1.8-.9c1.4 1.5 3.1 2.7 5 3.5 7.1 2.9 15.2-.5 18.1-7.5z"/>
      </svg>
    </div>

$REPORT_PAGE_HEADER
$REPORT_TITLE
$REPORT_TABLE_HEADER
$AUDIT_MYSQL_VARIABLES_FIRST_TABLE
$AUDIT_MYSQL_VALUES_FIRST_TABLE
$REPORT_TABLE_FOOTER

$REPORT_TABLE_HEADER
$AUDIT_MYSQL_VARIABLES_SECOND_TABLE
$AUDIT_MYSQL_VALUES_SECOND_TABLE
$REPORT_TABLE_FOOTER

$REPORT_TABLE_HEADER
$AUDIT_MYSQL_VARIABLES_THIRD_TABLE
$AUDIT_MYSQL_VALUES_THIRD_TABLE
$REPORT_TABLE_FOOTER

    <div class="buffer"></div>
    <div class="panel panelLightMode">
      <a href="https://nixys.ru/" target="_blank">
        <div class="logo">
          <svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" id="svg2" x="0" y="0" version="1.1" viewBox="0 0 92.5 100.5">
            <style>.st0,.st2{fill-rule:evenodd;clip-rule:evenodd;fill:#fff}.st2{display:none}</style>
            <g id="g10" transform="matrix(1.33333 0 0 -1.33333 0 228)">
              <g id="g12" transform="scale(.1)">
                <path id="path14" d="m289.5 1084.3-12.1 12.1-52.5 52.5-16.8 16.8-7.1 7.1-13.5 13.5-5.1-5.1c-6.6-6.6-6.6-17.3 0-23.9l52.5-52.5 23.9-23.9 52.5-52.5c6.6-6.6 17.3-6.6 23.9 0l5.1 5.1-39 39-11.8 11.8" class="st0"/>
                <path id="path16" d="m212.9 1483.2 11.9 11.9 52.5 52.5 16.8 16.8 7.1 7.1 39 39-5.1 5.1c-6.6 6.6-17.3 6.6-23.9 0l-52.5-52.5-23.9-23.9-52.5-52.5c-6.6-6.6-6.6-17.3 0-23.9l5.1-5.1 13.5 13.5 12 12" class="st0"/>
                <path id="path18" d="m616.8 1334-52.5 52.5-23.9 23.9-30.6 30.6-39-39c-5.4-5.4-12.7-8.4-20.4-8.4s-14.9 3-20.4 8.4l-52.5 52.5c-1.2 1.2-2.7 1.4-3.5 1.4-.8 0-2.3-.2-3.5-1.4L357 1441l30.6-30.6 23.9-23.9L464 1334c6.6-6.6 6.6-17.3 0-23.9l-52.5-52.5-23.9-23.9-30.6-30.6 13.5-13.5c1.2-1.2 2.7-1.4 3.5-1.4.8 0 2.3.2 3.5 1.4l52.5 52.5c5.4 5.4 12.7 8.4 20.4 8.4 7.7 0 14.9-3 20.4-8.4l39-39 30.6 30.6 23.9 23.9 52.5 52.5c6.5 6.6 6.5 17.3 0 23.9" class="st0"/>
                <path id="path20" fill="#f9e808" fill-rule="evenodd" d="m514.9 1181.2-52.5 52.5c-3.3 3.3-7.6 4.9-11.9 4.9-4.3 0-8.7-1.6-11.9-4.9l-52.5-52.5c-3.3-3.3-7.6-4.9-11.9-4.9s-8.7 1.6-11.9 4.9l-52.5 52.5-23.9 23.9-52.5 52.5c-6.6 6.6-6.6 17.3 0 23.9l52.5 52.5 23.9 23.9 52.5 52.5c3.3 3.3 7.6 4.9 11.9 4.9s8.7-1.7 11.9-4.9l52.5-52.5c3.3-3.3 7.6-4.9 11.9-4.9 4.3 0 8.7 1.6 11.9 4.9l52.5 52.5c6.6 6.6 6.6 17.3 0 23.9l-52.5 52.5-23.9 23.9-52.5 52.5c-3.3 3.3-7.6 4.9-11.9 4.9s-8.7-1.6-11.9-4.9l-52.5-52.5-23.9-23.9-52.5-52.5-23.9-23.9-52.5-52.5-23.9-23.9-52.5-52.5c-6.6-6.6-6.6-17.3 0-23.9l52.5-52.5 23.9-23.9 52.5-52.5 23.9-23.9 52.5-52.5 23.9-23.9 52.5-52.5c3.3-3.3 7.6-4.9 11.9-4.9s8.7 1.6 11.9 4.9l52.5 52.5 23.9 23.9 52.5 52.5c6.6 6.6 6.6 17.3 0 23.9" clip-rule="evenodd"/><path id="path22" d="m284.2 1310.1 52.5-52.5c6.6-6.6 17.3-6.6 23.9 0l52.5 52.5c6.6 6.6 6.6 17.3 0 23.9l-52.5 52.5c-6.6 6.6-17.3 6.6-23.9 0l-52.5-52.5c-6.6-6.6-6.6-17.3 0-23.9" class="st0"/>
              </g>
            </g>
          </svg>
        </div>
      </a>
      <button class="panelButton panelButtonLightMode">Linux</button>
      <button class="panelButton panelButtonLightMode">System</button>
      <button class="panelButton panelButtonLightMode">Services</button>
      <button class="panelButton panelButtonLightMode">Users</button>
      <button class="panelButton panelButtonLightMode">Network</button>
      <button class="panelButton panelButtonLightMode">Nginx</button>
      <button class="panelButton panelButtonLightMode">PHP</button>
      <button class="panelButton panelButtonLightMode">MySQL</button>
      <button class="panelButton panelButtonLightMode">Redis</button>
    </div>
  </body>
  <script>
    function myFunction() {
      var bodyColor = document.body;
      bodyColor.classList.toggle("darkMode");
      bodyColor.classList.toggle("lightMode");

      var panelButtonColor = document.getElementsByClassName("panelButton");
      for (var i = 0; i < panelButtonColor.length; i++) {
        panelButtonColor[i].classList.toggle('panelButtonLightMode');
        panelButtonColor[i].classList.toggle('panelButtonDarkMode');
      }

      var cellColor = document.getElementsByClassName("cellHeader");
      for (var i = 0; i < cellColor.length; i++) {
        cellColor[i].classList.toggle('cellLightMode');
        cellColor[i].classList.toggle('celllDarkMode');
      }

      var panelColor = document.getElementsByClassName("panel");
      for (var i = 0; i < panelColor.length; i++) {
        panelColor[i].classList.toggle('panelLightMode');
        panelColor[i].classList.toggle('panelDarkMode');
      }

      var swapColor = document.getElementsByClassName("swapMode");
      for (var i = 0; i < swapColor.length; i++) {
        swapColor[i].classList.toggle('swapModeDark');
      }
    } 
  </script>
</html>

EOF

END=$(date +%s)
DIFF=$(( $END - $START ))
echo Script completed in $DIFF seconds :
echo
echo Executed on :
date

exit 0;
