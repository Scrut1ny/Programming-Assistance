@echo off
setlocal enabledelayedexpansion
REM mode con cols=35

REM -- The Progress Bar --
set mainProgressBar[0]=[
set mainProgressBar[11]=]

for /l %%A in (1,1,10) do (
	set mainProgressBar[%%A]=  
)

for /l %%G in (1,1,11) do (
	for /l %%A in (0,1,5) do (
		set fullBar=!fullBar!!mainProgressBar[%%A]!
	)
	
	set /a progress=%%G-1
	set /a progress*=10
	set fullBar=!fullBar!!progress!
	
	for /l %%A in (6,1,11) do (
		set fullBar=!fullBar!!mainProgressBar[%%A]!
	)

	title !fullBar!

	set mainProgressBar[%%G]=#
	set fullBar=
	ping localhost -n 2 >nul
)

title !fullBar!
cls