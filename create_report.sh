#!/bin/bash
#
# sokdr
#
source ./variables.sh


[ -d ./tmp ] || mkdir ./tmp
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
AUDIT_DISK_SPACE=$(<./tmp/df.txt)
AUDIT_NETWORK=$(<./tmp/network.txt)
AUDIT_SERVICES=$(<./tmp/service.txt)
AUDIT_PROCESSES=$(<./tmp/ps.txt)
AUDIT_ROUTE=$(<./tmp/route.txt)
AUDIT_LOGGED_USERS=$(<./tmp/users.txt)
AUDIT_OPEN_PORTS=$(<./tmp/proto.txt)
cat > report.html << EOF
<!DOCTYPE html>
<link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet'>
<script
src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"
integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg=="
crossorigin="anonymous"
referrerpolicy="no-referrer"
></script>
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
      width: 2,5%;
      height: 50px;
      background: #252833;
      border: none;
      text-decoration: none;
      transition: all .2s;
      cursor: pointer;
    }

    .createPdf {
        display: inline-block;
        width: 2.5%;
        height: 50px;
        background: #252833;
        border: none;
        text-decoration: none;
        transition: all .2s;
        cursor: pointer;
        float:right;
        clear:right;
    }

    .logo:active,
    .logo:hover {
      outline: 0;
    }

    .logo:hover {
      background-color: #FFFFFF;
      border-color: rgba(0, 0, 0, 0.19);
    }

    .createPdf:active,
    .createPdf:hover {
      outline: 0;
    }

    .createPdf:hover {
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
      width: 90%;
      height: 100%;
      padding: auto;
      transition: all 1.8s;
      display: block;
      margin: auto;
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

    .barButtons {
        width: 95%;
    }
</style>
<html>
    <head>
        <title>Report</title>
    </head>
    <body class="lightMode">
    <div class="swapMode" onclick="swapMode()">
      <svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 64 62">
        <path d="m56.6 32-7.2 7.2v10.2H39.2L32 56.6l-7.2-7.2H14.6V39.2L7.4 32l7.2-7.2V14.6h10.2L32 7.4l7.2 7.2h10.2v10.2l7.2 7.2zm-11.8 5.3c2.9-7-.4-15.1-7.5-18.1-5.4-2.2-11.6-.8-15.5 3.5 3.1-2 6.9-2.3 10.2-.9 5.6 2.3 8.3 8.8 6 14.4-2.3 5.6-8.8 8.3-14.5 6l-1.8-.9c1.4 1.5 3.1 2.7 5 3.5 7.1 2.9 15.2-.5 18.1-7.5z"/>
      </svg>
    </div>
    <div id="invoice">

$REPORT_PAGE_HEADER
$REPORT_TITLE

$AUDIT_SERVICES
$AUDIT_NETWORK
$AUDIT_PROCESSES
$AUDIT_LOGGED_USERS
$AUDIT_DISK_SPACE
$AUDIT_ROUTE
$AUDIT_OPEN_PORTS


$REPORT_TABLE_HEADER
$AUDIT_RAM_USAGE_VARIABLES
$AUDIT_RAM_USAGE_VALUES
$REPORT_TABLE_FOOTER

$REPORT_TABLE_HEADER
$AUDIT_DISK_INFO_VARIABLES
$AUDIT_DISK_INFO_VALUES
$REPORT_TABLE_FOOTER


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
    </div>
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
      <div class="barButtons">
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
    <div class="createPdf" id="download-button">
        <svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" viewBox="0 0 318.188 318.188" fill="#fff">
            <path d="M283.149 52.722 232.625 2.197A7.5 7.5 0 0 0 227.321 0H40.342a7.5 7.5 0 0 0-7.5 7.5v303.188a7.5 7.5 0 0 0 7.5 7.5h237.504a7.5 7.5 0 0 0 7.5-7.5V58.025c0-1.989-.79-3.896-2.197-5.303zm-48.328-27.115 24.918 24.919h-24.918V25.607zM47.842 15h171.98v10.263H47.842V15zm222.504 288.188H47.842V40.263h171.98v17.763a7.5 7.5 0 0 0 7.5 7.5h43.024v237.662z"/><path d="M201.704 147.048c-3.615-.024-7.177.154-10.693.354-1.296.087-2.579.199-3.861.31a93.594 93.594 0 0 1-3.813-4.202c-7.82-9.257-14.134-19.755-19.279-30.664 1.366-5.271 2.459-10.772 3.119-16.485 1.205-10.427 1.619-22.31-2.288-32.251-1.349-3.431-4.946-7.608-9.096-5.528-4.771 2.392-6.113 9.169-6.502 13.973-.313 3.883-.094 7.776.558 11.594.664 3.844 1.733 7.494 2.897 11.139a165.324 165.324 0 0 0 3.588 9.943 171.593 171.593 0 0 1-2.63 7.603c-2.152 5.643-4.479 11.004-6.717 16.161l-3.465 7.507c-3.576 7.855-7.458 15.566-11.814 23.02-10.163 3.585-19.283 7.741-26.857 12.625-4.063 2.625-7.652 5.476-10.641 8.603-2.822 2.952-5.69 6.783-5.941 11.024-.141 2.394.807 4.717 2.768 6.137 2.697 2.015 6.271 1.881 9.4 1.225 10.25-2.15 18.121-10.961 24.824-18.387 4.617-5.115 9.872-11.61 15.369-19.465l.037-.054c9.428-2.923 19.689-5.391 30.579-7.205 4.975-.825 10.082-1.5 15.291-1.974 3.663 3.431 7.621 6.555 11.939 9.164 3.363 2.069 6.94 3.816 10.684 5.119 3.786 1.237 7.595 2.247 11.528 2.886 1.986.284 4.017.413 6.092.335 4.631-.175 11.278-1.951 11.714-7.57.134-1.721-.237-3.229-.98-4.551-3.643-6.493-16.231-8.533-22.006-9.451-4.553-.723-9.2-.939-13.804-.935zm-75.06 20.697a170.827 170.827 0 0 1-6.232 9.041c-4.827 6.568-10.34 14.369-18.322 17.286-1.516.554-3.512 1.126-5.616 1.002-1.874-.11-3.722-.936-3.637-3.065.042-1.114.587-2.535 1.423-3.931.915-1.531 2.048-2.935 3.275-4.226 2.629-2.762 5.953-5.439 9.777-7.918 5.865-3.805 12.867-7.23 20.672-10.286-.449.71-.897 1.416-1.34 2.097zm27.222-84.26a38.169 38.169 0 0 1-.323-10.503 24.858 24.858 0 0 1 1.038-4.952c.428-1.33 1.352-4.576 2.826-4.993 2.43-.688 3.177 4.529 3.452 6.005 1.566 8.396.186 17.733-1.693 25.969-.299 1.31-.632 2.599-.973 3.883a121.219 121.219 0 0 1-1.648-4.821c-1.1-3.525-2.106-7.091-2.679-10.588zm16.683 66.28a236.508 236.508 0 0 0-25.979 5.708c.983-.275 5.475-8.788 6.477-10.555 4.721-8.315 8.583-17.042 11.358-26.197 4.9 9.691 10.847 18.962 18.153 27.214.673.749 1.357 1.489 2.053 2.22-4.094.441-8.123.978-12.062 1.61zm61.744 11.694c-.334 1.805-4.189 2.837-5.988 3.121-5.316.836-10.94.167-16.028-1.542-3.491-1.172-6.858-2.768-10.057-4.688-3.18-1.921-6.155-4.181-8.936-6.673 3.429-.206 6.9-.341 10.388-.275 3.488.035 7.003.211 10.475.664 6.511.726 13.807 2.961 18.932 7.186 1.009.833 1.331 1.569 1.214 2.207zM158.594 233.392h-16.606v47.979h15.523c7.985 0 14.183-2.166 18.591-6.498 4.408-4.332 6.613-10.501 6.613-18.509 0-7.438-2.096-13.127-6.285-17.065-4.19-3.938-10.135-5.907-17.836-5.907zm7.909 33.917c-1.838 2.287-4.726 3.43-8.664 3.43h-2.888v-26.877h3.773c3.545 0 6.187 1.061 7.926 3.183 1.739 2.123 2.609 5.382 2.609 9.78.001 4.703-.918 8.198-2.756 10.484zM129.78 237.363c-3.041-2.647-7.592-3.971-13.652-3.971H99.522v47.979h12.963v-15.917h3.643c5.819 0 10.309-1.46 13.472-4.381 3.161-2.92 4.742-7.061 4.742-12.421-.001-4.879-1.521-8.642-4.562-11.289zm-10.288 15.884c-1.149 1.094-2.697 1.641-4.644 1.641h-2.363v-11.026h3.348c3.588 0 5.382 1.619 5.382 4.857-.001 1.924-.575 3.434-1.723 4.528zM191.314 281.371h12.766v-18.017h14.374v-10.403H204.08v-9.156h15.589v-10.403h-28.355z"/>
        </svg>
    </div>
  </body>
  <script>
    function swapMode() {
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
  <script>
      const pdfButton = document.getElementById('download-button');
      var opt = {
        filename:     'report.pdf',
        jsPDF:        { format: 'A1', orientation: 'landscape' }
      };
      function generatePDF() {
        const element = document.getElementById('invoice');
        html2pdf().set(opt).from(element).save();
      }
      pdfButton.addEventListener('click', generatePDF);
  </script>
</html>

EOF

END=$(date +%s)
DIFF=$(( $END - $START ))
echo Script completed in $DIFF seconds :
echo
echo Executed on :
date
rm ./tmp/df.txt
rm ./tmp/network.txt
rm ./tmp/proto.txt
rm ./tmp/ps.txt
rm ./tmp/route.txt
rm ./tmp/service.txt
rm ./tmp/users.txt
exit 0;