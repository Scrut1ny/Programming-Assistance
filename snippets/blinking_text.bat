:: blink.bat - Makes text blink on the screen
:: This is going to be one of those things to looks simple on paper and turns out to be really hard, isn't it?
:: The easy way would be to just CLS and print over and over, but I want non-blinking text to remain persistent
@echo off
setlocal enabledelayedexpansion
cls

:: Create a backspace character
for /F %%A in ('"prompt $H&for %%B in (1) do rem"') do set "BS=%%A"

:: Create the batch equivalent of bash's `print -n`
set "printn=<nul set /p echo="

:: Set up the field
echo This line never gets deleted
echo Neither does this one

:: Blink the message five times, once per second
:: One %BS% character per printed character (^^! counts as one character) followed by spaces to overwrite
for /L %%A in (1,1,5) do (
	%printn%This one blinks^^!
	ping 1.1.1.1 -n 2 >nul
	%printn%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%                
	ping 1.1.1.1 -n 2 >nul
	%printn%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%
)

:: Print the message one last time so that the line ends with a \r\n and the message stays on the screen
echo This one blinks^^!