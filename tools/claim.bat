@echo off
rem
rem NT version of the unix script claim
rem
rem $Log: claim.bat,v $
rem Revision 1.5  1997/04/09 12:03:37  jont
rem Modify to call unix script
rem
rem Revision 1.4  1997/01/08  18:02:13  jont
rem Add ability to give a bug number
rem
rem Revision 1.3  1996/04/09  18:07:14  daveb
rem Added -u (= update-reason) argument.
rem
rem Revision 1.2  1995/03/21  15:15:34  jont
rem Fix error message
rem
rem Revision 1.1  1995/03/21  15:01:49  jont
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
sh claim %MYARGS%
