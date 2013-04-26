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
rem Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.

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
