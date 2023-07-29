@echo off
setlocal enabledelayedexpansion

for /f "skip=2 tokens=2,3,4* delims=," %%a in ('"wmic nic where (NETEnabled=True) get GUID,NetconnectionID,MACAddress /format:csv"') do (set "GUID1=%%a" & set "MAC=%%b" & set "NIC=%%c")

call :get_guid %GUID1% folder & echo !folder!

pause

:get_guid
for /f "tokens=6 delims=\" %%A in ('reg query "HKLM\SYSTEM\ControlSet001\Control\Class" /f "%~1" /s /t REG_SZ ^| find "Class"') do set "%~2=%%A" & exit /b