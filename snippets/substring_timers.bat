@echo off
setlocal enabledelayedexpansion

set "time_1=24/11/15 08:06:59"
set "time_2=24/11/15 11:47:02"

call :GetTimeDiff "!time_1!" "!time_2!"

pause
exit /b

:GetTimeDiff
set "start_timestamp=%~1"
set /a start_hh=1!start_timestamp:~9,2!%%100, start_mm=1!start_timestamp:~12,2!%%100, start_ss=1!start_timestamp:~15,2!%%100
set /a "start_time=(((!start_hh!*60)+!start_mm!)*60+!start_ss!)"
echo Started !start_time! seconds after midnight

set "end_timestamp=%~2"
set /a end_hh=1!end_timestamp:~9,2!%%100, end_mm=1!end_timestamp:~12,2!%%100, end_ss=1!end_timestamp:~15,2!%%100
set /a "end_time=(((!end_hh!*60)+!end_mm!)*60+!end_ss!)"
echo Ended !end_time! seconds after midnight

set elapsed_time=0
set /a elapsed_time=!end_time!-!start_time!
if !elapsed_time! lss 0 set /a elapsed_time+=86400
goto :eof