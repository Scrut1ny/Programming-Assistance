@echo off
setlocal enabledelayedexpansion

set "Whitelisted=00929036-5104-11ED-B377-34824127DF45"

:: wmic csproduct get uuid
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /value ^| find "="') do set "UUID=%%A"

if "%UUID%"=="!Whitelisted!" (
    goto :authorized
) else (
    goto :unauthorized
)

:authorized
echo Whitelisted & pause
goto :EOF

:unauthorized
echo Blacklisted & pause
goto :EOF

exit /b 0
