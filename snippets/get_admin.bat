@echo off
set "__COMPAT_LAYER=RunAsInvoker"
>nul 2>&1 net session && goto :is_admin || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
exit /b

:: If we've gotten this far, we're Administrator. Let's prove it by doing the exact same thing
:: that we did to test that we were Administrator.
:is_admin
net session
pause