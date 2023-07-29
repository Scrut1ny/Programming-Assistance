@echo off
setlocal enabledelayedexpansion

REM ******************************************************************
REM * Padded Formatted Text                                          *
REM *                                                                *
REM * USAGE: pftext.bat [text] [width] [pad character]               *
REM *                                                                *
REM * FUNCTION                                                       *
REM * - Formats a string to fit within a column of specified width   *
REM * - Pads and remaining space at the end of each line with spaces *
REM *                                                                *
REM * PARAMETERS                                                     *
REM * - %1 specifies the text to format and pad                      *
REM * - %2 specifies the width of the column                         *
REM * - %3 specifies the character to use to pad extra spaces        *
REM *   - Quotes and carets can not be padding characters            *
REM *                                                                *
REM * VERSION HISTORY                                                *
REM * - 1.1 (24 Feb 2013)                                            *
REM *   - Discovered that double colons instead of REM to comment    *
REM *     breaks some functionality. Reverted to REM statements.     *
REM *   - Shortened the word wrap code so that space-word is added   *
REM *     instead of word-space.                                     *
REM * - 1.0 (23 Feb 2013)                                            *
REM *   - Original version                                           *
REM ******************************************************************

cls
set unformattedText=The quick brown fox jumps over the lazy dogs.
set padChar= 
set width=35
set counter=0

REM -- Strip the quotes from any arguments --
if not [%1]==[] set unformattedText=%~1

if not [%2]==[] set width=%2

REM -- Use only the first character from the argument for the pad character --
set pChar=%~3
if not [%3]==[] set padChar=%pChar:~0,1%

REM -- Count the number of words in the sentence --
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

REM -- Exit loop via goto. Apologize profusely. --
:loopBreak

REM -- Determine the size of each word --
set /a counter=!counter!-1
for /l %%A in (0,1,!counter!) do (
	echo !words[%%A]!>tmp.txt
	for %%J in (tmp.txt) do (
		set /a len[%%A]=%%~zJ
		set /a len[%%A]-=2
		del tmp.txt

		REM -- width must be a minimum of the longest word --
		if !len[%%A]! gtr %width% set /a width=!len[%%A]!+1
	)
)

REM -- Place the first word --
set newString=!words[0]!
set stringLength=!len[0]!
set lineCounter=0

for /l %%A in (1,1,!counter!) do (
REM -- If there's room for a space and the next word on the line, place them --
REM -- If the next word cannot be placed, do not add a space --
REM -- Leading words on new lines are not preceded by spaces --

	set /a possLength=!stringLength!+!len[%%A]!+1

	REM -- if the next word fits on the line --
	if !possLength! leq %width% (
		set newString=!newString! !words[%%A]!
		set /a stringLength+=!len[%%A]!+1
	) else (
		set lines[!lineCounter!]=!newString!
		set /a lineCounter+=1
		set newString=!words[%%A]!
		set /a stringLength=!len[%%A]!
	)

	REM -- if it's the last word --
	if %%A equ !counter! (
		set lines[!lineCounter!]=!newString!
	)
)

REM -- Determine the size of each line --
for /l %%A in (0,1,!lineCounter!) do (
	echo !lines[%%A]!>tmp.txt
	for %%J in (tmp.txt) do (
		set /a linelen[%%A]=%%~zJ
		set /a linelen[%%A]-=2
		del tmp.txt
	)
)

REM -- Pad the lines --
for /l %%A in (0,1,!lineCounter!) do (
	for /l %%G in (!linelen[%%A]!,1,%width%) do (
		if %%G lss %width% (
			set lines[%%A]=!lines[%%A]!%padChar%
		)
	)
)

REM -- See if it worked --
for /l %%A in (0,1,!lineCounter!) do (
	echo !lines[%%A]! (!linelen[%%A]!^)
)