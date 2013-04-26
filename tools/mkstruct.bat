@echo off
rem $Log: mkstruct.bat,v $
rem Revision 1.14  1997/07/08 12:20:54  jont
rem [Bug #20089]
rem Remove use of .compound files
rem
rem Revision 1.13  1997/05/15  13:01:23  matthew
rem Adding gui_tests-compiler
rem
rem Revision 1.12  1997/04/02  14:27:03  johnh
rem Added subcompounds demos and break-trace to MLWgui_tests.
rem
rem Revision 1.11  1997/04/01  09:11:36  daveb
rem Added the MLWgui_tests compound and its sub-compounds.
rem
rem Revision 1.10  1996/12/18  17:32:20  daveb
rem Moved MLW/src/test_suite to MLW/test_suite.
rem Also added line for MLWtest_suite-debugger.
rem
rem Revision 1.9  1996/10/17  12:58:08  jont
rem Merging in license server stuff
rem
rem Revision 1.8.2.2  1996/10/08  13:54:11  nickb
rem Add MLWrts_license .compound files.
rem
rem Revision 1.8.2.1  1996/10/07  16:38:02  hope
rem branched from 1.8
rem
rem Revision 1.8  1996/06/10  15:00:57  jont
rem Add stuff to deal with MLWtest_suite-{basis,hsell}
rem
rem Revision 1.7  1996/04/19  10:20:01  jont
rem initbasis moves to basis
rem
rem Revision 1.6  1995/07/28  08:38:23  matthew
rem Removing mention of MLWlibrary
rem
rem Revision 1.5  1995/07/26  15:43:49  matthew
rem Adding mswindows and gui directories
rem
rem Revision 1.4  1995/03/21  16:19:14  jont
rem Change :: into rem
rem
rem Revision 1.3  1995/03/17  11:43:22  jont
rem Protect mkdir with if not exist
rem
rem Revision 1.2  1995/03/17  10:32:37  jont
rem Add link creation (new directories for NT)
rem
rem Revision 1.1  1995/03/16  12:39:05  jont
rem new unit
rem NT version
rem
rem Copyright Harlequin Ltd. 1995
cd MLW\src
if not exist mir mkdir mir
if not exist machine mkdir machine
if not exist system mkdir system
if not exist winsys mkdir winsys
cd ..

cd ..
