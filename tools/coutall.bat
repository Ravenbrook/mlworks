@echo off
rem #!/bin/sh
rem === CHECK OUT ALL FILES ===
rem
rem Searches in and below the current directory for RCS files and checks
rem them out as read-only working files.  This will not overwrite files
rem with writable modes, and so does not overwrite locked working files.
rem
rem $Log: coutall.bat,v $
rem Revision 1.16  1997/07/23 12:13:18  jont
rem [Bug #30133]
rem Modify to call the shell coutall to preserve compatibility
rem
rem Revision 1.15  1997/06/11  10:55:26  stephenb
rem [Bug #30166]
rem Add -s option so that it is possible for the daily build to
rem skip writable files rather than being warned about them.
rem
rem Revision 1.14  1997/06/10  19:11:21  daveb
rem [Bug #30172]
rem Renamed "args" variable.
rem
rem Revision 1.13  1997/06/05  09:52:12  daveb
rem [Bug #30166]
rem Hope 1.24 replaced -force with more precise options.
rem
rem Revision 1.12  1996/06/04  11:23:22  jont
rem Change cp to copy to preserve time stamps
rem
rem Revision 1.11  1996/02/12  14:10:59  jont
rem Ensure we're in the right directory before proceeding with the checkout
rem
rem Revision 1.10  1996/01/30  17:01:35  jont
rem Add extra-files delete to the checkout script to remove stale units
rem
rem Revision 1.9  1996/01/26  15:19:31  jont
rem Ensure runtime system checked out with co-date for consistent compilation.
rem
rem Revision 1.8  1995/08/17  16:23:06  jont
rem Modify to fix problem calling hope on latest NT
rem
rem Revision 1.7  1995/07/27  13:56:09  matthew
rem New gui directory structure
rem
rem Revision 1.6  1995/07/24  11:23:40  daveb
rem The -working-files argument to the Hope checkout command has changed to
rem -writable-files.
rem
rem Revision 1.5  1995/03/15  18:29:46  jont
rem Add some attrib commands to ensure copying doesn't fail
rem
rem Revision 1.4  1995/02/28  12:50:13  jont
rem Modify use of version (deprecated) to branch
rem
rem Revision 1.3  1995/02/09  17:57:23  jont
rem More to get file copying working
rem
rem Revision 1.2  1995/02/09  15:45:25  jont
rem Modifications to cope with lack of links on NT
rem
rem Revision 1.1  1995/02/02  14:38:34  jont
rem new unit
rem No reason given
rem
rem Revision 1.5  1994/08/31  14:55:35  jont
rem Add -force option to hope checkout command
rem
rem Revision 1.4  1994/06/22  13:47:51  nickh
rem Add new hope switches.
rem
rem Revision 1.3  1994/02/04  17:33:54  daveb
rem Converted to hope.
rem
rem Revision 1.2  1993/01/15  13:12:02  richard
rem Added -d option and corrected option passing.
rem
rem Revision 1.1  1992/10/23  13:36:40  richard
rem Initial revision
rem
set MYARGS= 
:startmyargs
if "%1"=="" goto endmyargs
set MYARGS=%MYARGS% %1
shift
goto startmyargs
:endmyargs
sh coutall %MYARGS%
@echo Copying into link directories
@cd MLW\src
@attrib -r mir\*.sml
@copy harp\*.sml mir >NUL
@attrib -r machine\*.sml
@copy i386\*.sml machine >NUL
@attrib -r system\*.sml
@copy win_nt\*.sml system >NUL
@attrib -r winsys\*.sml
@copy mswindows\*.sml winsys >NUL
@cd ..\..
