@echo off
setlocal enabledelayed expansion
cls
set array_string="one,two,three,four,five,six and seven,eight,nine"
call :make_array arr %array_string% -1
cls
set arr[
pause>nul
exit /b

:make_array
set /a array_index=%3+1
if not "%~2"=="" (
	for /F "tokens=1,* delims=," %%A in ("%~2") do (
		set %1[%array_index%]=%%A
		call :make_array %1 "%%B" %array_index%
	)
)
goto :eof