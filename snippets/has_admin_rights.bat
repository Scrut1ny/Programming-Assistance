:isAdmin
:: Checks to see if the user has admin rights
@echo off
net session >nul 2>&1

if %errorlevel%==0 (
	echo User has admin rights.
) else (
	echo User does not have admin rights.
)