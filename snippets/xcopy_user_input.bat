@echo off
setlocal disabledelayedexpansion
for /f %%A in ('copy /Z "%comspec%" nul') do set "CR=%%A")
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "BS=%%A"
set "^=!."
setlocal enabledelayedexpansion
call :getInput string
echo:
echo:!string!
exit /b

:getInput
set "input=."

:keyLoop
set "key="
for /f "delims=" %%A in ('xcopy /w "!comspec!" "!comspec!" 2^>nul') do (
    if not defined key (
        set "key=%%A^!"
    )
)
if !key:~-1!==^^ (
    set "key=^"
) else set "key=!key:~-2,1!"
if !key! equ !CR! (
    set "%~1=!input:~1!"
    exit /b 0
) else if !key! equ !BS! (
    if not !input!==. (
        set "input=!input:~0,-1!"
        <NUL set /p "=!BS! !BS!"
    )
) else (
    set "input=!input!!key!"
    <NUL set /p "=.!BS!!key!"
)
goto :keyLoop