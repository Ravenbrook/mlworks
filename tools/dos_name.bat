@echo off
rem
rem Small program to produce dos version of filename
rem
echo %1 > c:\tmp\dos_name.tmp
call setvar dname sed -e "s,/,\\,g" c:\tmp\dos_name.tmp
rm c:\tmp\dos_name.tmp
