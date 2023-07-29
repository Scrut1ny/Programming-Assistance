@echo off
setlocal enabledelayedexpansion

REM ******************************************
REM * Text  Formatter                        *
REM *                                        *
REM * USAGE                                  *
REM * - txtfrmt.bat [text]                   *
REM *                                        *
REM * FUNCTION                               *
REM * - This script takes a string and       *
REM *   formats it to fit within a column of *
REM *   specified length.                    *
REM *                                        *
REM * PARAMETERS                             *
REM * - %1 specifies the text to format      *
REM *                                        *
REM * THANKS                                 *
REM * - http://stackoverflow.com/a/269819    *
REM ******************************************

cls
set unformattedText=The quick brown fox jumps over the lazy dogs.
set width=15
set counter=0
set slashN=^


if not [%1]==[] set unformattedText=%~1

:: -- XFD am I literally using recursion in a batch file? --
:: -- Regardless, I'm counting the number of words in the sentence --
:wordCounter
for /f "tokens=1,* delims= " %%A in ("%unformattedText%") do (
	if not "%%A"=="" (
		set words[!counter!]=%%A
		set /a counter=!counter!+1
		set unformattedText=%%B
		goto wordCounter
	) else (
		goto loopBreak
	)
)

:: -- Everybody who has ever coded anything hates me for what I've just done --
:loopBreak
echo There are !counter! words in your sentence.

:: -- Determine the size of each word --
set /a counter=!counter!-1
for /l %%A in (0,1,!counter!) do (
	echo !words[%%A]!>tmp.txt
	for %%J in (tmp.txt) do (
		set /a len[%%A]=%%~zJ
		set /a len[%%A]-=2
		del tmp.txt
		if !len[%%A]! gtr %width% set /a width=!len[%%A]!+1
	)
)

:: -- Concatenate the words and spaces --
set newString=
set stringLength=0
for /l %%A in (0,1,!counter!) do (
	if %%A lss !counter! (
		set /a possLength=!stringLength!+!len[%%A]!+1

		if !possLength! leq %width% (
			set newString=!newString!!words[%%A]! 
			set /a stringLength+=!len[%%A]!+1
		) else (
			set newString=!newString!!slashN!!words[%%A]! 
			set /a stringLength=!len[%%A]!+1
		)
	) else (
		set /a possLength=!stringLength!+!len[%%A]!

		if !possLength! leq %width% (
			set newString=!newString!!words[%%A]!
			set /a stringLength+=!len[%%A]!
		) else (
			set newString=!newString!!slashN!!words[%%A]!
			set /a stringLength=!len[%%A]!
		)
	)
)

echo !newString!