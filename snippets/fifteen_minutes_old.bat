@echo off
setlocal enabledelayedexpansion

set newFilesExist=FALSE

:: This script returns all files less than 15 minutes old

:: Get current time and convert it to minutes since the end of BC
:: %DATE:~-10% grabs the last 10 characters of the date (01/10/2013, etc.)
:: %TIME:~0,5% grabs characters 0-5 of the time ( 0:52, etc. - note the space)

for /f "tokens=1-5 delims=/: " %%f in ('echo %DATE:~-10% %TIME:~0,5%') do (
	call :ordinalMinutes %%h %%f %%g %%i %%j
	set currentDateTime=!minutesPast!

	:: Create a reference timestamp from 15 minutes ago
	set /a refDateTime=!currentDateTime!-15

)

:: For each file, compare the timestamp to the reference timestamp
for %%X in (*) do (
	for /f "tokens=1,2,3,4,5 delims=/: " %%A in ('echo %%~tX') do (
		call :ordinalMinutes %%C %%A %%B %%D %%E
		set /a minutesOld=!refDateTime!-!minutesPast!

		if !minutesOld! lss 15 set newFilesExist=TRUE
	)
)

if [%newFilesExist%]==[TRUE] (
	echo Files younger than 15 minutes exist. > report.txt
	type report.txt
)

goto:eof

::------------------------------------------------------------------------------
:: Ordinal Minutes
::
:: Calculates the number of minutes since a given date and time and stores the
:: value in the variable %minutesPast%
::------------------------------------------------------------------------------
:ordinalMinutes

:: Make an arraylike that holds the number of days past at the start of the month
:: I can bruteforce this instead of doing math because this is constant. :)
set monthMinsPast[1]=0
set monthMinsPast[2]=44640
set monthMinsPast[3]=84960
set monthMinsPast[4]=129600
set monthMinsPast[5]=172800
set monthMinsPast[6]=217440
set monthMinsPast[7]=253400
set monthMinsPast[8]=296800
set monthMinsPast[9]=344920
set monthMinsPast[10]=393120
set monthMinsPast[11]=437760
set monthMinsPast[12]=480960

:: Strip the leading zeroes from to get rid of the "Invalid number" error
set /a month=100%2%%100
set /a day=100%3%%100
set /a hour=100%4%%100
set /a minute=100%5%%100

set /a minutesPast=%1*525600
set /a minutesPast=%minutesPast%+!monthMinsPast[%month%]!
set /a minutesPast=%minutesPast%+%day%*1440
set /a minutesPast=%minutesPast%+%hour%*60
set /a minutesPast=%minutesPast%+%minute%

:: Add a day if it's a leap year and would have already happened
if %month% geq 3 (
	if %1%%4 equ 0 (
		if %1 NEQ 2100 set /a minutesPast=%minutesPast%+1440
	)
)
goto:eof
