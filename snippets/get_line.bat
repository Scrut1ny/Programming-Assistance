::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: get_line.bat <line number> <file name>
:: 
:: Arguments: line_number - which line to return
::            file_name   - file to read in
:: Returns:   The nth line of <file_name>.txt
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
setlocal enabledelayedexpansion
goto verify

:: Displays the script usage string for when the script is incorrectly called
:print_usage
echo USAGE: get_line.bat ^<line number^> ^<file name^>
echo.
echo Line number must be an integer larger than 0.
exit /b

:verify
:: Ensure that both parameters are set
if "%1"=="" goto print_usage
if "%2"=="" goto print_usage

:: Ensure that %1 is a positive integer
for /F "delims=1234567890" %%A in ("%~1") do if not "%%A"=="" goto print_usage
if %~1 lss 1 goto print_usage

:: Ensure that %2 exists
if not exist %2 (
	echo Unable to locate %2
	exit /b
)
set line_number=%1
set file_name=%2

if !line_number! equ 1 (
	echo Retrieving line 1
	set /p return_line=<%file_name%
) else (
	set /a skip_lines=!line_number!-1
	(
		for /L %%A in (1,1,!skip_lines!) do set /p ignore=
		set /p return_line=
	)<!file_name!
)

echo !return_line!