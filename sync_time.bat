@echo off
:: Ensure the script is running with Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Please right-click this script and select "Run as administrator".
    pause
    exit /b 1
)

echo Starting Windows Time service...
net start w32time >nul 2>&1

echo Configuring time servers...
w32tm /config /syncfromflags:manual /manualpeerlist:"://windows.com,0x8 pool.ntp.org,0x8" /update

echo Resyncing system clock...
w32tm /resync

echo ----------------------------------------
w32tm /query /status
echo ----------------------------------------

echo Time sync completed.
pause
