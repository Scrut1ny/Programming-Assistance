@echo off
setlocal enableDelayedExpansion
:::::
:: Advanced user input in batch [using xcopy]
:: Fetch result using for /f from main
:::::
set "prompt="
:: the input prompt
set "symbol="
:: the symbol that displays instead
set "length="
:: the max length of the input
set "allowed="
:: allowed characters ("a b c A B C")
set "invalid="
:: invalid characters ("b c d B C D")
:: allowed characters will override invalid
:::::

:: parse flags dict
:flags
if not "%~1" == "" (
    set "%~1"
    shift
    goto flags
)

:: Fetch needed characters
for /f %%A in ('copy /Z "%comspec%" nul') do set "CR=%%A"
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "BS=%%A"
:: start of program
if not defined symbol (
    set "symbol=^!key^!"
)
set "input=."
>CON <NUL set /p "=.!BS! !BS!!prompt!"
:input
set "key="
for /f "delims=" %%A in ('xcopy /w "!comspec!" "!comspec!" 2^>nul') do (
    if not defined key set "key=%%A^!"
)
if !key:~-1!==^^ (
    set "key=^"
) else set "key=!key:~-2,1!"
if !key! equ !BS! (
    if not "!input!" == "." (
        set "input=!input:~0,-1!"
        <NUL set /p "=!BS! !BS!" >CON
    )
) else if !key! equ !CR! (
    >CON echo:
    echo:!input:~1!
    exit /B 0
) else (
    if defined length (
        if "!input:~-%length%!" neq "!input!" (
            goto input
        )
    )
    for %%A in ("!key!") do (
        if defined allowed (
            if "!allowed:%%~A=!" equ "!allowed!" (
                goto input
            )
        ) else (
            if defined invalid (
                if "!invalid:%%~A=!" neq "!invalid!" (
                    goto input
                )
            )
        )
        set "input=!input!!key!"
        >CON <NUL set /p "=.!BS! !BS!%symbol%"
    )
)
goto input