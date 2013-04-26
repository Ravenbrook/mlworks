@echo off
rem Climbs the directory tree up from the argument, searching for a
rem .compound file. When it finds one, constructs compound and unit names
rem accordingly.
rem 
rem Meant for use as eval `findcomp foo/bar`, in which case it defines 3
rem shell variables: 
rem
rem $unit: the unit name
rem $compound: the compound name
rem $dir: the compound directory
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
rem $Log: findcomp.bat,v $
rem Revision 1.2  1995/03/21 13:15:04  jont
rem Fix numerous bugs
rem
rem Revision 1.1  1995/03/20  17:27:47  jont
rem new unit
rem Dos version of unix program findcomp
rem
rem
call un_name %1
call setvar unit basename %uname%
call setvar dir dirname %uname%
call dos_name %dir%
if not exist %dname% goto no_dir
cd %dname%
call setvar dname cd
:loop
if exist .compound goto got_dir
call un_name %dname%
  call setvar prev_dir dirname %uname%
  if "%prev_dir%"=="." goto no_dir
  rem Above is bad case
  call setvar this_dir basename %uname%
  set dir=%prev_dir%
  set unit=%this_dir%:%unit%
  call dos_name %dir%
  cd %dname%
  goto loop
rem End of loop
:got_dir
rem Found the right place
call setvar compound cat .compound
call dos_name %dir%
set dir=%dname%
goto done
:no_dir
rem Bad case, not found
set compound=crap
set unit=
set dir=
:done
