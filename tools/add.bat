@echo off
rem
rem NT version of the unix script add
rem
rem $Log: add.bat,v $
rem Revision 1.6  1997/04/09 12:01:59  jont
rem Modify to call unix script
rem
rem Revision 1.5  1996/10/23  12:55:09  jont
rem [Bug #1668]
rem Allow adding to non trunk branches
rem
rem Revision 1.4  1996/05/24  15:29:15  jont
rem Update following gratuitous hope parameter changes
rem
rem Revision 1.3  1996/02/26  12:30:35  jont
rem Modify to preserve file date on add
rem
rem Revision 1.2  1995/03/21  15:55:03  jont
rem Problems with comments
rem
rem Revision 1.1  1995/03/21  15:35:28  jont
rem new unit
rem NT version of unix script
rem
rem Copyright (C) Harlequin 1995
rem
set MYARGS= 
:startmyargs
if "%1"=="" goto endmyargs
set MYARGS=%MYARGS% %1
shift
goto startmyargs
:endmyargs
sh add %MYARGS%
