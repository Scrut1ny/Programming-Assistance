@echo off
setlocal enabledelayedexpansion

REM *************************************************************************
REM * isNum2.bat                                                            *
REM *                                                                       *
REM * USAGE                                                                 *
REM * isnum2.bat <number>                                                   *
REM *                                                                       *
REM * FUNCTION                                                              *
REM * - Completely rewrites the code for checking to see if a variable is a *
REM *   valid number. Apparently it can be done with a couple loops and a   *
REM *   short if statement. Go figure. Thanks, Rob van der Woude.           *
REM *                                                                       *
REM * PARAMETERS                                                            *
REM * - %1 is the number to check                                           *
REM *************************************************************************

set num=%1
set firstChar=!num:~0,1!
set isNegative=FALSE
set decimals=0

REM -- Strip the negative sign if one exists --
if "%firstChar%"=="-" (
	set num=!num:~1!
	set isNegative=TRUE
)

REM -- Split the number, using the decimal as a delimiter --
for /f "tokens=1,2,3 delims=." %%A in ("!num!") do (
	REM -- If there are more than 2 parts, there are extra decimals --
	if NOT "%%C"=="" (
		echo Too many decimals.
		set decimals=2
	)
)

REM -- if anything is left in !num!, there are things other than numbers --
for /f "tokens=1 delims=1234567890." %%A in ("!num!") do (
	echo Invalid number.
)