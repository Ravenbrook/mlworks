@echo off
rem
rem NT version of the unix script locks
rem
rem $Log: locks.bat,v $
rem Revision 1.2  1999/04/16 16:20:04  daveb
rem Automatic checkin:
rem changed attribute _comment to 'rem'
rem
rem
rem Copyright (C) 1999 Harlequin Group plc.  All rights reserved.
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
sh locks %MYARGS%
