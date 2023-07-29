@echo off
setlocal enabledelayedexpansion

set LT_hostname=AAAAAAAA
set !LT_hostname![total]=60

echo !LT_hostname!
call echo %%!LT_hostname![total]%%