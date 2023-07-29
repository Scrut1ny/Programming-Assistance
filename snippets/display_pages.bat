::------------------------------------------------------------------------------
:: USAGE
::     display_pages.bat
::
:: DESCRIPTION
::     Displays a number of options, 10 per page
::
:: AUTHOR
::     sintrode
::
:: VERSION
::     1.0 (2018-10-16) - Initial Verison [sintrode]
::------------------------------------------------------------------------------
@echo off
setlocal enabledelayedexpansion

:: Initialize array
set "max_index=112"
set /a pages=%max_index%/10
set "current_page=0"
for /L %%A in (0,1,%max_index%) do set "array[%%A]=%%A"

:menu
if "%current_page%"=="0" (
	set "page_header="
) else (
	set "page_header=%current_page%"
)

:: For _0 to _9, if array[%%A] exists, display it.
cls
echo SELECT A CATEGORY - Page %current_page%
echo --------------------------
for /L %%A in (!page_header!0,1,!page_header!9) do (
	if defined array[%%A] (
		set /a index=%%A-!page_header!0
		echo [!index!] - !array[%%A]!
	)
)
echo(
echo [P]revious        [N]ext        [Q]uit
set /p "selection=Selection: "

call :validate_input "%selection%" || goto :menu

if /I "%selection%"=="P" (
	if not "!current_page!"=="0" set /a current_page-=1
	goto :menu
)
if /I "%selection%"=="N" (
	if not "!current_page!"=="%pages%" set /a current_page+=1
	goto :menu
)
if /I "%selection%"=="Q" exit /b

for /f %%A in ("!page_header!") do (
	echo You selected !array[%%A%selection%]!
)

exit /b

::------------------------------------------------------------------------------
:: Determines if a specified string is exclusively valid input
::
:: Arguments: %1 - The string to check
:: Returns:   0 if the string is [0-9nNpPqQ], 1 if it is not
::------------------------------------------------------------------------------
:validate_input
for /f "tokens=1,2 delims=0123456789NPQnpq" %%A in ("%~1x") do (
	if "%%A"=="x" if "%%B"=="" exit /b 0
	exit /b 1
)