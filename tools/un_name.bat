@echo off
rem
rem Small program to produce unit version of filename
rem
echo %1 > c:\tmp\un_name.tmp
call setvar uname sed -e "s,\\,/,g" c:\tmp\un_name.tmp
rm c:\tmp\un_name.tmp
