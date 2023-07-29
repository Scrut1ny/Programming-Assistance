::------------------------------------------------------------------------------
:: strLen7 by dbenham
:: Calculates the length of a string and stores that value in a variable
:: https://ss64.org/viewtopic.php?pid=6478#p6478
::
:: Arguments: %1 - The string to calculate the length of
::            %2 - The variable to store the length in
:: Returns:   None
::------------------------------------------------------------------------------
@echo off
:getLength
setlocal EnableDelayedExpansion
set "s=#%~1"
set "len=0"
for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
	if "!s:~%%N,1!" neq "" (
		set /a "len+=%%N"
		set "s=!s:~%%N!"
	)
)
endlocal&if "%~2" neq "" (set %~2=%len%) else echo %len%
exit /b