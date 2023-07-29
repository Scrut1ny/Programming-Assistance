:: Taken from https://stackoverflow.com/a/22959721/4158862
@echo off
setlocal enableextensions disabledelayedexpansion

rem Call the subroutine to get the password    
call :getPassword password 

rem Echo what the function returns
if defined password (
    echo You have typed [%password%]
) else (
    echo You have typed nothing
)
pause
rem End of the process    
endlocal
exit /b


rem Subroutine to get the password
:getPassword returnVar
setlocal enableextensions disabledelayedexpansion
set "_password="

rem We need a backspace to handle character removal
for /f %%a in ('"prompt;$H&for %%b in (0) do rem"') do set "BS=%%a"

rem Prompt the user 
set /p "=Password:" <nul 

:keyLoop
rem retrieve a keypress
set "key="
for /f "delims=" %%a in ('xcopy /l /w "%~f0" "%~f0" 2^>nul') do if not defined key set "key=%%a"
set "key=%key:~-1%"

rem handle the keypress 
rem     if No keypress (enter), then exit
rem     if backspace, remove character from password and console
rem     else add character to password and go ask for next one
if defined key (
    if "%key%"=="%BS%" (
        if defined _password (
            set "_password=%_password:~0,-1%"
            REM setlocal enabledelayedexpansion & set /p "=!BS! !BS!"<nul & endlocal
        )
    ) else (
        set "_password=%_password%%key%"
        set /p "="<nul
    )
    goto :keyLoop
)
echo(
rem return password to caller
if defined _password ( set "exitCode=0" ) else ( set "exitCode=1" )
endlocal & set "%~1=%_password%" & exit /b %exitCode%