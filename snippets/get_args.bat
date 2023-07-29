@ECHO OFF
SETLOCAL
SET "switches=name age whatever"
SET "noargs=option anotheroption"
SET "swindicators=/ -"
SET "otherparameters="
:: clear switches
FOR %%a IN (%switches% %noargs%) DO SET "%%a="

:swloop
IF "%~1"=="" GOTO process

FOR %%a IN (%swindicators%) DO (
 FOR %%b IN (%noargs%) DO (
  IF /i "%%a%%b"=="%~1" SET "%%b=Y"&shift&GOTO swloop
 )
 FOR %%b IN (%switches%) DO (
  IF /i "%%a%%b"=="%~1" SET "%%b=%~2"&shift&shift&GOTO swloop
 )
)
SET "otherparameters=%otherparameters% %1"
SHIFT
GOTO swloop

:process

FOR %%a IN (%switches% %noargs% otherparameters) DO IF DEFINED %%a (CALL ECHO %%a=%%%%a%%) ELSE (ECHO %%a NOT defined)

GOTO :EOF