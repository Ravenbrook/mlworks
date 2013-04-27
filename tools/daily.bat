@echo off
rem A batch script to do overnight builds on Artin
rem
rem $Log: daily.bat,v $
rem Revision 1.1  1995/03/17 13:54:26  jont
rem new unit
rem First attempt at overnight build for NT
rem
rem 
rem Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
rem All rights reserved.
rem 
rem Redistribution and use in source and binary forms, with or without
rem modification, are permitted provided that the following conditions are
rem met:
rem 
rem 1. Redistributions of source code must retain the above copyright
rem    notice, this list of conditions and the following disclaimer.
rem 
rem 2. Redistributions in binary form must reproduce the above copyright
rem    notice, this list of conditions and the following disclaimer in the
rem    documentation and/or other materials provided with the distribution.
rem 
rem THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
rem IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
rem TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
rem PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
rem HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
rem SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
rem TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
rem PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
rem LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
rem NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
rem SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
