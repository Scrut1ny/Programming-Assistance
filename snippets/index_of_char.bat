:indexOf <char> <string>
:: Returns the index of the first instance
@echo off
setlocal enabledelayedexpansion

if "%2"=="" echo USAGE: indexOf ^<char^> ^<string^>&exit /b
if not "%3"=="" echo USAGE: indexOf ^<char^> ^<string^>&exit /b

set char=%1
set string=%2

call :strlen %string% string_len

set index=-1
for /L %%A in (!string_len!,-1,0) do if "!string:~%%A,1!"=="%char%" set index=%%A
if !index! equ -1 echo %char% not located in %string%&exit/b

set "printn=<nul set /p echo="

echo %char% is located at position !index!
echo.
echo %string%
for /L %%A in (1,1,!index!) do %printn%.
echo ^^

exit /b

:strlen
echo %1>tmp
for %%A in (tmp) do set /a %2=%%~zA-2
del tmp