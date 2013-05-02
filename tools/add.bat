@echo off
rem
rem NT version of the unix script add
rem
rem $Log: add.bat,v $
rem Revision 1.6  1997/04/09 12:01:59  jont
rem Modify to call unix script
rem
rem Revision 1.5  1996/10/23  12:55:09  jont
rem [Bug #1668]
rem Allow adding to non trunk branches
rem
rem Revision 1.4  1996/05/24  15:29:15  jont
rem Update following gratuitous hope parameter changes
rem
rem Revision 1.3  1996/02/26  12:30:35  jont
rem Modify to preserve file date on add
rem
rem Revision 1.2  1995/03/21  15:55:03  jont
rem Problems with comments
rem
rem Revision 1.1  1995/03/21  15:35:28  jont
rem new unit
rem NT version of unix script
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
set MYARGS= 
:startmyargs
if "%1"=="" goto endmyargs
set MYARGS=%MYARGS% %1
shift
goto startmyargs
:endmyargs
sh add %MYARGS%
