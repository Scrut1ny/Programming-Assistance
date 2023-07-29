:length word
:: Returns the number of characters in whatever is passed in

@echo off
setlocal enabledelayedexpansion
cls

if "%~1"=="" (
	echo Please enter some text.
	exit /b
)

set "words=%*
>tmp echo(!words!
for %%A in (tmp) do set /a length=%%~zA-2
del tmp
echo !words! consists of !length! characters.