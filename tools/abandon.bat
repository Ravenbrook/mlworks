@echo off
rem
rem NT version of the unix script abandon
rem
rem $Log: abandon.bat,v $
rem Revision 1.2  1997/04/09 12:03:46  jont
rem Modify to call unix script
rem
rem Revision 1.1  1995/03/21  15:45:51  jont
rem new unit
rem NT version of unix script
rem
rem
rem Copyright (C) Harlequin 1995
rem
rem Deal with switches
rem
set MYARGS= 
:startmyargs
if "%1"=="" goto endmyargs
set MYARGS=%MYARGS% %1
shift
goto startmyargs
:endmyargs
sh abandon %MYARGS%
