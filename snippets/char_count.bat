@echo off
::setlocal enabledelayedexpansion

set counter=0
set var=12345678901234567890
set crop_var=%var%

:crop
set /a counter+=1
set crop_var=%crop_var:~1%

if defined crop_var goto crop
echo %var% contains %counter% digits
