@echo off
setlocal enabledelayedexpansion

set "Whitelisted=00000000-0000-0000-0000-00D8613A05B4"
set "Blacklisted=00000000-0000-0000-0000-000000000000"

:: wmic csproduct get uuid
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /value ^| find "="') do set "serialnumber=%%A"

if "%serialnumber%"=="!Whitelisted!" goto:authorized do (
	if "%serialnumber%"=="!Blacklisted!" goto:unauthorized
)
exit /b 0

:authorized
echo Whitelisted&pause
exit /b 0

:unauthorized
echo Blacklisted&pause
exit /b 0

FF FE 0A 0D