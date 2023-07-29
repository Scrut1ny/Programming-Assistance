@echo off
setlocal disabledelayedexpansion
cls

set LF=^


:: Keep the above two blank lines or you'll break absolutely everything. I'm serious.
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

set "readTime(x)=(hh=x/3600, rest=x%%3600, mm=rest/60, ss=rest%%60)"
set DisplayHHMMSS=for %%n in (1 2) do if %%n==2 (%\n%
		for /f "tokens=1,2,3 delims=," %%a in ("!argv!") do (%\n%
			set dh=00%%a%\n%
			set dh=!dh:~-2!%\n%
			set dm=00%%b%\n%
			set dm=!dm:~-2!%\n%
			set ds=00%%c%\n%
			set ds=!ds:~-2!%\n%
		)%\n%
		echo !dh!:!dm!:!ds!%\n%
	) else setlocal enabledelayedexpansion ^& set argv=,

setlocal enabledelayedexpansion

set seconds=7564
set /a "elapsed_time=!readTime(x):x=%seconds%!
%DisplayHHMMSS% !hh!,!mm!,!ss!
