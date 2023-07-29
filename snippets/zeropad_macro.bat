@echo off
setlocal disabledelayedexpansion
cls

set "time_string=5:7:2"
set LF=^


:: Keep above two blank lines
set ^"rn=^^^%LF%%LF%^%LF%%LF%^^"

set zeropad=for %%N in (1 2) do if %%N==2 (%rn%
	for /f "tokens=1-3 delims=:" %%A in ("%time_string%") do (%rn%
		set /a hh=%%A,mm=%%B,ss=%%C%rn%
		if %%B LSS 10 set mm=0%%B%rn%
		if %%C LSS 10 set ss=0%%C%rn%
		echo !hh!:!mm!:!ss!%rn%
	)%rn%
) else setlocal enabledelayedexpansion

setlocal enabledelayedexpansion
%zeropad%

pause