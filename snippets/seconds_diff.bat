@echo off

set "time_1=09:35:39"
set "time_2=09:38:10"

call :getTimeDiff %time_1% %time_2%
pause
exit /b

:getTimeDiff
:: Taken from http://stackoverflow.com/a/9935540
for /F "tokens=2-4 delims=: " %%a in ("%1") do (
   set /A "start_time=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)"
)
for /F "tokens=2-4 delims=:" %%a in ("%2") do (
   set /A "end_time=(((%%a*60)+1%%b %% 100)*60+1%%c %% 100)"
)

echo %start_time%
echo %end_time%
set /A elapsed_time=end_time-start_time
echo %elapsed_time%
set /A hh=elapsed_time/(60*60), rest=elapsed_time%%(60*60), mm=rest/(60), rest%%=60, ss=rest

if %mm% lss 10 set mm=0%mm%
if %ss% lss 10 set ss=0%ss%

echo %hh%:%mm%:%ss%
