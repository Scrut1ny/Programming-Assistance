:cutExtraSpaces <inputfile>
:: Removes excess spaces between words from each line in %inputfile%
@echo off
setlocal enabledelayedexpansion
cls

set filename=%1
set wholeline=
for /f "delims=" %%A in (%filename%) do (
	set line=%%A
	
	for /f "tokens=1,2,3,4,5,6*" %%B in ("!line!") do (
		call :parser "%%B %%C %%D %%E %%F %%G %%H"
	)
	set wholeline=!wholeline!!newString!
)
echo !wholeline!

:parser
:: Removes all extra spaces from a string
set oldString=%1
set newString=
for /f "tokens=1,2,3,4,5,6*" %%I in ("!oldString!") do (
	set "newString=%%I%%J%%K%%L%%M%%N%%O"
)
goto :EOF