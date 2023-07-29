@echo off
setlocal enabledelayedexpansion

set datetime[1][1][stopped]="13/11/15 09:15:26"
set datetime[1][1][started]="13/11/15 09:18:26"
set datetime[1][2][stopped]="13/11/15 11:01:19"
set datetime[1][2][started]="13/11/15 11:01:43"
set datetime[2][1][stopped]="11/11/15 07:19:01"
set datetime[2][1][started]="11/11/15 19:31:58"

call :getTimeDiff 1 !datetime[1][1][stopped]! !datetime[1][1][started]!
echo.
call :getTimeDiff 1 !datetime[1][2][stopped]! !datetime[1][2][started]!
echo.
call :readableTime !elapsed_time!
echo Total Time for DateTime 1: !human_time!

echo.
echo ----------
echo.
call :getTimeDiff 2 !datetime[2][1][stopped]! !datetime[2][1][started]!
echo.
call :readableTime !elapsed_time!
echo Total Time for DateTime 2: !human_time!

pause
exit /b

::------------------------------------------------------------------------------
:: Calculates the number of seconds between two timestamps in HH:MM:SS format
:: Based on http://stackoverflow.com/a/9935540/4158862
::
:: Arguments: %1 - The datetime to keep a running time for
::            %2 - The beginning timestamp in DD/MM/YY HH:MM:SS format
::            %3 - The ending timestamp in DD/MM/YY HH:MM:SS format
:: Returns:   None
::------------------------------------------------------------------------------
:getTimeDiff
set "elapsed_time="
for /f "tokens=2-4 delims=: " %%A in ("%~2") do (
	echo Start Time: %%A:%%B:%%C
	set /A "start_time=((((1%%A %% 100)*60)+1%%B %% 100)*60+1%%C %% 100)
)

for /F "tokens=2-4 delims=: " %%A in ("%~3") do (
	echo End Time: %%A:%%B:%%C
	set /A "end_time=((((1%%A %% 100)*60)+1%%B %% 100)*60+1%%C %% 100)
)

set /a elapsed_time=!end_time!-!start_time!
set /a datetime[%1]_total+=!elapsed_time!
goto :eof

::------------------------------------------------------------------------------
:: Converts seconds to HH:MM:SS format
:: From the bottom part of http://stackoverflow.com/a/9935540/4158862
::
:: Arguments: %1 - Number of seconds to convert
:: Returns:   None
::------------------------------------------------------------------------------
:readableTime
set "human_time="
set /A hh=%1/3600, rest=%1%%3600, mm=rest/60, rest%%=60, ss=rest
if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%
set "human_time=%hh%:%mm%:%ss%"
goto :eof