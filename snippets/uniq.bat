@echo off
setlocal enabledelayedexpansion

set "prev_LT="
for /f "delims=" %%A in ('sort %1') do (
	set "current_LT=%%A"
	if not !prev_LT!==!current_LT! echo !current_LT!
	set "prev_LT=%%A"
)