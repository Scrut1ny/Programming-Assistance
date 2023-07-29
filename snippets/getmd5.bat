@echo off
setlocal enabledelayedexpansion

for %%A in (%*) do (
	<nul set /p =Processing %%A...
	
	for /f "delims=" %%B in ('certutil -hashfile %%A MD5 ^| find /v ":"') do (
		set raw_line=%%B
		set line=!raw_line: =!
		echo %%A: !line! >>md5.txt
	)
	
	echo DONE
)