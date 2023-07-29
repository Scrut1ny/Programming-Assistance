:progress.bat
:: Displays a progress bar in the window instead of the title bar
@echo off
setlocal enabledelayedexpansion
cls

:: Create a backspace character
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "BS=%%A"

:: Create the batch equivalent of bash's `print -n`
set "printn=<nul set /p echo="

:: Set the length of the bar (e.g. [-----] is five)
set bar_length=10
set dash_loop=%bar_length%+1
set /a dot_loop=%dash_loop%-2

set "bar=["
for /l %%A in (1,1,%dot_loop%) do set "bar=!bar!."
set "bar=%bar%]"

%printn%%bar%
for /l %%A in (1,1,%bar_length%) do (
	for /l %%B in (1,1,!dash_loop!) do (
		%printn%%BS%
	)

	%printn%-

	for /l %%B in (1,1,!dot_loop!) do (
		%printn%.
	)

	%printn%]

	timeout 1 >nul
	set /a dash_loop=!dash_loop!-1
	set /a dot_loop=!dot_loop!-1
)