@echo off
rem
rem NT version of the unix script remove
rem
rem $Log: remove.bat,v $
rem Revision 1.3  1997/04/09 12:03:30  jont
rem Modify to call unix script
rem
rem Revision 1.2  1996/10/23  14:57:58  jont
rem [Bug #1669]
rem Add -b option to specify branch
rem
rem Revision 1.1  1995/03/21  15:41:58  jont
rem new unit
rem NT version of unix script
rem
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
sh remove %MYARGS%
