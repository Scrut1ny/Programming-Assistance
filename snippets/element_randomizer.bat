@echo off
setlocal enabledelayedexpansion

REM --Randomizes the first X elements in an array--

set arrayList[1]=A. Option One
set arrayList[2]=B. Option Two
set arrayList[3]=C. Option Three
set arrayList[4]=D. OPtion Four
set varHolder=0

cls
echo **BEFORE**
for /L %%A in (1,1,4) do (
	echo %%A - !arrayList[%%A]!
)

REM --Takes two random elements between 1 and maxChanged and switches them.--
REM --During testing, we'll randomly set the value to 4. In practice, this number--
REM --could be as high as ten. But it will usually be four.--
set maxChanged=4

REM --"None of the above" should always be last--
if "%arrayList[4]%"=="D. None of the above" set maxChanged=3

REM --"Both _ and _" means that the answer order should not change--
if "%arrayList[4]%"=="D. Both A and B" goto endLabel
if "%arrayList[4]%"=="D. Both A and C" goto endLabel
if "%arrayList[4]%"=="D. Both B and C" goto endLabel


REM --Randomly select two elements in the array and swap them. Repeat until thoroughly shuffled.--
REM --Also, this can't be done inside a FOR because they don't play nice with delayed expansion.--

set counter=0
:forLoop
set /a varA=%RANDOM%%%maxChanged%+1

:setVarB
set /a varB=%RANDOM%%%maxChanged%+1
REM --varA can not be the same element as varB--
if %varA% equ %varB% goto setVarB

REM echo Swapping elements %varA% and %varB%

set varHolder=!arrayList[%varA%]!
set arrayList[%varA%]=!arrayList[%varB%]!
set arraylist[%varB%]=!varHolder!

set /a counter+=1
if %counter% neq 20 goto forLoop

:endLabel
echo.
echo **AFTER**
for /L %%A in (1,1,4) do (
	echo %%A - !arrayList[%%A]!
)