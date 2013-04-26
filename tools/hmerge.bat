@echo off
rem
rem NT version of the unix script hmerge
rem
rem $Log: hmerge.bat,v $
rem Revision 1.1  1997/04/09 16:07:31  jont
rem new unit
rem Wrapper to the unix version of the script
rem
rem
rem Copyright (C) Harlequin 1997
rem
rem collect the arguments
rem if DOS wasn't so poor we wouldn't have to do this
set MYARGS= 
:startmyargs
if "%1"=="" goto endmyargs
set MYARGS=%MYARGS% %1
shift
goto startmyargs
:endmyargs
sh hmerge %MYARGS%
