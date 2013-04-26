@echo off
rem ... Version of inst.bat which expects doc already in
rem ... canonical directory structure in InstallShield\documentation
rem Check parameters
del data.z
if "%1" == "" goto bad_parameters
if "%2" == "" goto bad_parameters
if not "%3" == "" goto bad_parameters
rem Compress the doc components
program\icomp documentation\guide\ps\*.ps data.z documentation\guide\ps /h
program\icomp documentation\guide\pdf\*.pdf data.z documentation\guide\pdf /h
program\icomp documentation\guide\html\*.* data.z documentation\guide\html /h
program\icomp documentation\installation-notes\ps\*.ps data.z documentation\installation-notes\ps /h
program\icomp documentation\installation-notes\pdf\*.pdf data.z documentation\installation-notes\pdf /h
program\icomp documentation\installation-notes\html\*.* data.z documentation\installation-notes\html /h
program\icomp documentation\release-notes\ps\*.ps data.z documentation\release-notes\ps /h
program\icomp documentation\release-notes\pdf\*.pdf data.z documentation\release-notes\pdf /h
program\icomp documentation\release-notes\html\*.* data.z documentation\release-notes\html /h
program\icomp documentation\reference\ps\*.ps data.z documentation\reference\ps /h
program\icomp documentation\reference\pdf\*.pdf data.z documentation\reference\pdf /h
program\icomp documentation\reference\html\*.* data.z documentation\reference\html /h
copy %1\distribution\setup.rul setup.rul
copy %1\distribution\setup.lst setup.lst
rem Don't distribute the IS sources -- once they're copied 
rem delete them temporarily from the distribution (see 50082)
del %1\distribution\setup.rul 
del %1\distribution\setup.lst
rem ....Build components...
program\icomp %1\distribution\*.* data.z /h
program\icomp %1\distribution\html\*.* data.z documentation /h
program\icomp %1\distribution\bin\I386\%2\*.* data.z bin /h
program\icomp %1\distribution\images\I386\%2\*.* data.z images /h
program\icomp %1\distribution\pervasive\I386\%2\*.* data.z pervasive /h
program\icomp %1\distribution\pervasive\I386\%2\DEPEND\*.sml data.z pervasive\DEPEND /h
program\icomp %1\distribution\objects\I386\%2\Release\*.mo data.z objects\Release /h
program\icomp %1\distribution\objects\I386\%2\DEPEND\*.sml data.z objects\DEPEND /h
program\icomp %1\distribution\scripts\*.* data.z scripts /h
program\icomp %1\distribution\utils\*.sml data.z utils /h
program\icomp %1\distribution\examples\basis\*.* data.z examples\basis /h
program\icomp %1\distribution\examples\threads\*.* data.z examples\threads /h
program\icomp %1\distribution\examples\mswindows\*.* data.z examples\mswindows /h
program\icomp %1\distribution\examples\gui\*.* data.z examples\gui /h
program\icomp %1\distribution\examples\gui\mswindows\*.* data.z examples\gui\mswindows /h
program\icomp %1\distribution\examples\foreign\add\*.* data.z examples\foreign\add /h
program\icomp %1\distribution\examples\foreign\stdio\*.* data.z examples\foreign\stdio /h
program\icomp %1\distribution\examples\projects\*.* data.z examples\projects /h
program\icomp %1\distribution\examples\projects\subprojects\*.* data.z examples\projects\subprojects /h
program\icomp %1\distribution\basis\*.sml data.z basis /h
program\icomp %1\distribution\basis\basis.mlp data.z basis /h
program\icomp %1\distribution\winsys\*.sml data.z winsys /h
program\icomp %1\distribution\winsys\*.mlp data.z winsys /h
program\icomp %1\distribution\foreign\*.* data.z foreign /h
mkdir disk1
copy data.z disk1
copy program\_ISDEL.EXE disk1
copy program\_isres.DLL disk1
copy program\_SETUP.DLL disk1
copy program\SETUP.EXE disk1
copy program\uninst.exe disk1
copy program\_setup.lib disk1
copy program\_INST32I.EX_ disk1
rem split -f1420 -d1@770 data.z
rem copy disk1.id disk1
rem copy disk2.id disk2
program\compile setup.rul
program\packlist setup.lst
copy setup.ins disk1
copy setup.pkg disk1
rename disk1\data.z DATA.Z
rename disk1\_isres.DLL _ISRES.DLL
rename disk1\uninst.exe UNINST.EXE
rename disk1\_setup.lib _SETUP.LIB
rename disk1\setup.ins SETUP.INS
rename disk1\setup.pkg SETUP.PKG
rem Restore IS sources to the distribution now we've done the packaging
copy setup.rul %1\distribution\setup.rul
copy setup.lst %1\distribution\setup.lst
goto done
:bad_parameters
@echo Bad parameters to %0 ^<drive eg D:^> ^<system type eg Win95^>
:done
