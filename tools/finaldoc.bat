@echo off
rem Script to install final version of Windows documentation.
rem
rem $Log: finaldoc.bat,v $
rem Revision 1.1  1997/07/28 16:10:48  daveb
rem new unit
rem [Bug #30188]
rem Script to add final release notes and installation notes to Windows
rem distributions.
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

rem  This script takes one parameter: the directory containing the data.z file
rem  that needs updating.  The rest of the distribution should be unchanged.
rem  The best place to run this script is the install_shield directory, as it
rem  brings the checked-out documentation up to date.

rem  This script uses tar to unpack the HTML files stored in the MLdoc compound.
rem  This version of tar is included in the Cygnus GNU-tools for Windows.

rem Check parameters
if "%1" == "" goto bad_parameters
if not "%2" == "" goto bad_parameters

rem  Download the new doc.
call hope co -recursive -missing-dir create -extra-files delete -comp DOCml 
cd ml\install\htm\windows
call tar -xf install-win-1-0r2.tar
cd ..\..\..\relnotes\htm
call tar -xf relnotes-1-0r2.tar
cd ..\..\..

rem  Remove the old versions.
program\icomp documentation\installation-notes\ps\*.* %1\data.z -R
program\icomp documentation\installation-notes\html\*.* %1\data.z -R
program\icomp documentation\release-notes\ps\*.* %1\data.z -R
program\icomp documentation\release-notes\html\*.* %1\data.z -R
program\icomp documentation\guide\ps\*.* %1\data.z -R
program\icomp documentation\reference\ps\*.* %1\data.z -R

rem  Now install the final versions.
program\icomp ml\install\pdf\install-win-1-0r2.pdf %1\data.z documentation\installation-notes\pdf /h
program\icomp ml\install\htm\windows\*.htm %1\data.z documentation\installation-notes\html /h
program\icomp ml\install\htm\windows\*.gif %1\data.z documentation\installation-notes\html /h
program\icomp ml\relnotes\pdf\relnotes-1-0r2.pdf %1\data.z documentation\release-notes\pdf /h
program\icomp ml\relnotes\htm\*.htm %1\data.z documentation\release-notes\html /h
program\icomp ml\relnotes\htm\*.gif %1\data.z documentation\release-notes\html /h
program\icomp ml\guide\pdf\guide-win-1-0.pdf %1\data.z documentation\guide\pdf /h
program\icomp ml\reference\pdf\reference-1-0.pdf %1\data.z documentation\reference\pdf /h

goto done
:bad_parameters
@echo Bad parameters to %0 ^<dir containing data.z^>
:done
