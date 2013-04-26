@echo off
rem
rem NT version of the unix script cout
rem
rem $Log: cout.bat,v $
rem Revision 1.6  1997/04/09 16:02:30  jont
rem Modify to call unix script
rem
rem Revision 1.5  1996/01/24  11:19:05  matthew
rem Adding -n option
rem
rem Revision 1.4  1995/03/21  15:11:48  jont
rem Remove superfluous echo off
rem
rem Revision 1.3  1995/03/21  14:25:17  jont
rem Problems with command line options
rem
rem Revision 1.2  1995/03/21  14:15:21  jont
rem Add command line switches
rem
rem Revision 1.1  1995/03/21  13:43:03  jont
rem new unit
rem NT version of unix command
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
sh cout %MYARGS%
