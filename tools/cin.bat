@echo off
rem
rem NT version of the unix script cin
rem
rem $Log: cin.bat,v $
rem Revision 1.3  1997/04/09 16:02:20  jont
rem Modify to call unix script
rem
rem Revision 1.2  1995/03/21  15:13:27  jont
rem Fix error message
rem
rem Revision 1.1  1995/03/21  14:53:53  jont
rem new unit
rem Nt version of the unix script
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
sh cin %MYARGS%
