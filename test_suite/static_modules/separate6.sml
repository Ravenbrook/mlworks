(*
Check batch compilation of empty file

Result: OK
 
$Log: separate6.sml,v $
Revision 1.18  1998/06/15 12:33:11  mitchell
[Bug #30422]
newProject now requires a directory

 * Revision 1.17  1998/06/04  14:33:49  johnh
 * [Bug #30369]
 * Replace project source path with a list of files.
 *
 * Revision 1.16  1998/05/21  12:23:02  mitchell
 * [Bug #50071]
 * Replace touchAllSource by a force compile
 *
 * Revision 1.15  1998/05/07  09:29:24  mitchell
 * [Bug #50071]
 * Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 * Revision 1.14  1998/05/04  16:56:00  mitchell
 * [Bug #50071]
 * Replace uses of Shell.Build.loadSource by Shell.Project
 *
 * Revision 1.13  1997/11/21  10:54:30  daveb
 * [Bug #30323]
 *
 * Revision 1.12  1997/04/01  16:54:32  jont
 * Modify to stop displaying syserror type
 *
 * Revision 1.11  1996/12/20  11:54:42  jont
 * New source path required since test suite has moved
 *
 * Revision 1.10  1996/05/22  10:55:18  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.9  1996/04/12  11:37:45  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.8  1996/04/03  10:06:52  stephenb
 * Update wrt recent changes in OS structure -- __os is no longer in
 * initbasis, it is system dependent.
 *
 * Revision 1.7  1996/02/23  16:19:03  daveb
 * Converted Shell structure to new capitalisation convention.
 *
Revision 1.6  1996/01/25  17:36:11  jont
More Shell modifications

Revision 1.5  1996/01/24  11:26:21  stephenb
OS reorganisation: OS specific stuff is no longer in the pervasive
library, so changed to use OS independent version.

Revision 1.4  1995/12/08  11:47:48  daveb
Shell compile commands have changed.

Revision 1.3  1995/02/24  15:27:27  jont
Modify to be only for the make system (ie not for .mo files)

Revision 1.2  1994/04/26  16:11:56  jont
Shell structure revisions

Revision 1.1  1994/02/16  17:03:15  johnk
new file

Copyright (c) 1994 Harlequin Ltd.
*)

(
  Shell.Project.newProject (OS.Path.fromUnixPath "/tmp");
  Shell.Project.setFiles 
    [OS.Path.concat [OS.FileSys.getDir(), "static_modules", "separate6_a.sml"]];
  Shell.Project.setTargetDetails "separate6_a.sml";
  Shell.Project.setTargets ["separate6_a.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
);



