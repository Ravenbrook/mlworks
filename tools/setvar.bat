@echo off
rem
rem A small program to ease setting of variables from program results
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
