@echo off
setlocal enabledelayedexpansion

:: Get the new HSM password from user input
set /p "new_password=New HSM Password: "

:: Generate the HSM command script as usual
(
	echo lush user password set admin !new_password!
	echo exit
) >raw_ascii_hsm_commands.txt

:: certutil aborts if the output file already exists, so delete it
if exist raw_hex_hsm_commands.txt del raw_hex_hsm_commands.txt

:: Convert the raw text file to hexadecimal
certutil -encodehex raw_ascii_hsm_commands.txt raw_hex_hsm_commands.txt

:: Extract the hexadecimal from the output file, then remove all occurrences of " 0d" and spaces
for /f "delims=" %%A in (raw_hex_hsm_commands.txt) do (
	set raw_line=%%A
	set sub_line=!raw_line:~5,51!
	set no_ctrl_m=!sub_line: 0d=!
	set processed_line=!no_ctrl_m: =!
	set full_document=!full_document!!processed_line!
)

:: Store the new data in a text file for processing
echo !full_document! >processed_hex_hsm_commands.txt

:: Convert the hexadecimal back to ASCII
certutil -decodehex processed_hex_hsm_commands.txt processed_ascii_hsm_commands.txt

:: Temp file cleanup
del raw_ascii_hsm_commands.txt
del raw_hex_hsm_commands.txt
del processed_hex_hsm_commands.txt