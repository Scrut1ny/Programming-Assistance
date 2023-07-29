:centerText <text>
@echo off
setlocal enabledelayedexpansion
cls
set window_width=80
set "text=The quick brown fox jumps over the lazy dog."
if not "%~1"=="" set text=%~1

call :center "The quick brown fox jumps over the lazy dog."
exit /b

:center
:: Subtract the width of the window from the length of the string and divide by
:: two. Then add that many spaces to the beginning of the string.
set text=%~1
echo !text!>tmp
for %%A in (tmp) do set /a length=%%~zA-2
del tmp
set /a spaces=(%window_width%-!length!)/2

for /l %%A in (1,1,!spaces!) do (
	set "text= !text!"
)

echo !text!