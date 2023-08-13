#!/bin/bash
source hardware.sh
touch report.html
cat > report.html << EOF
<!DOCTYPE html>
<style>
    .panel {
        position: fixed;
        width: 100%;
        height: 50px;
        background: black;
        left: 0;
        right: 0;
        bottom: 0;
    }
    .block {
        position: fixed;
        width: 150px;
        height: 450px;
        font-size: 10px;
    }
</style>
<html>
    <head>
        <title>Report</title>
    </head>
    <body>
        <h1>Hello</h1>
        <div class="block">$CPU</div>
        <div class="panel"></div>
    </body>
</html>

EOF