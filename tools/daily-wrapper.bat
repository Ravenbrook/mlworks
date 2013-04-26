@echo off
rem A batch script to control the execution of the daily script
rem
rem $Log: daily-wrapper.bat,v $
rem Revision 1.1  1995/03/17 14:43:35  jont
rem new unit
rem NT version of daily-wrapper
rem
rem
rem Copyright (C) Harlequin 1995
rem
rem
d:
cd \ml\ml_ref\mlw\tools
call daily > daily-log
