@echo off
set /p "input="

for /f "tokens=1 delims=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" %%A in ("%input%") do (
	echo Invalid Entry.
)