@echo off
rem
rem A small program to ease setting of variables from program results
rem
rem Copyright Harlequin (C) 1995
rem
rem $Log: setvar.bat,v $
rem Revision 1.1  1995/03/20 17:29:05  jont
rem new unit
rem Common subroutine for setting variables to evaluated results
rem
rem
%2 %3 %4 %5 %6 %7 %8 %9 > c:\tmp\setvar.tmp
sed -e "s,^,@set %1=," c:\tmp\setvar.tmp > c:\tmp\setvar.bat
call c:\tmp\setvar
rm c:\tmp\setvar.bat c:\tmp\setvar.tmp
