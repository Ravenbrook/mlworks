@echo off
rem A batch script to do overnight builds on Artin
rem
rem $Log: daily.bat,v $
rem Revision 1.1  1995/03/17 13:54:26  jont
rem new unit
rem First attempt at overnight build for NT
rem
rem 
rem Copyright (C) Harlequin 1995
rem
rem First checkout entire source tree
rem
d:
cd \ml\ml_ref
if not exist MLW mkdir MLW
cd MLW
if not exist tools mkdir tools
call hope co -compound MLWtools -unit coutall.bat
cd ..
call mlw\tools\coutall
d:
cd \ml\ml_ref
call mlw\tools\mkstruct
rem
rem Now build the runtime system
rem
d:
cd \ml\ml_ref\mlw\src\rts
make ARCH=I386 OS=NT clean
make ARCH=I386 OS=NT generated
make ARCH=I386 OS=NT runtime runtime-g
nmake -f makefile.mak
rem
rem Now do the compilation using a reference compiler
rem This part not very good, since we don't really have a reference compiler
rem
e:
cd \ml\ml_nt\mlw\src
call build d:\ml\ml_ref\MLW
