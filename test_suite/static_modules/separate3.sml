(*
Ensure correct encapsulation of multiple topdecs

Result: OK
 
$Log: separate3.sml,v $
Revision 1.21  1998/06/15 12:32:56  mitchell
[Bug #30422]
newProject now requires a directory

 * Revision 1.20  1998/06/04  14:20:36  johnh
 * [Bug #30369]
 * Replace project source path with a list of files.
 *
 * Revision 1.19  1998/05/21  12:22:42  mitchell
 * [Bug #50071]
 * Replace touchAllSource by a force compile
 *
 * Revision 1.18  1998/05/07  09:29:09  mitchell
 * [Bug #50071]
 * Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 * Revision 1.17  1998/05/04  16:55:14  mitchell
 * [Bug #50071]
 * Replace uses of Shell.Build.loadSource by Shell.Project
 *
 * Revision 1.16  1997/11/21  10:54:20  daveb
 * [Bug #30323]
 *
 * Revision 1.15  1997/04/01  16:54:16  jont
 * Modify to stop displaying syserror type
 *
 * Revision 1.14  1996/12/20  11:51:48  jont
 * New source path required since test suite has moved
 *
 * Revision 1.13  1996/05/22  10:55:13  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.12  1996/04/12  11:36:58  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.11  1996/04/03  10:16:08  stephenb
 * Update wrt recent changes in OS structure -- __os is no longer in
 * initbasis, it is system dependent.
 *
 * Revision 1.10  1996/02/23  16:18:26  daveb
 * Converted Shell structure to new capitalisation convention.
 *
Revision 1.9  1996/01/25  17:35:56  jont
More Shell modifications

Revision 1.8  1996/01/24  11:35:07  stephenb
Replace MLWorks.OS.Unix.getwd by OS.FileSys.getDir

Revision 1.7  1995/12/08  11:45:34  daveb
Shell compile commands have changed.

Revision 1.6  1995/02/24  15:14:43  jont
Modify to be only for the make system (ie not for .mo files)

Revision 1.5  1994/04/26  15:54:47  jont
Shell structure revisions

Revision 1.4  1993/12/10  19:05:12  jont
New name for recompile

Revision 1.3  1993/08/20  13:12:35  jont
*** empty log message ***

Revision 1.2  1993/08/04  12:18:37  jont
*** empty log message ***

Revision 1.1  1993/08/03  11:51:29  jont
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(
  Shell.Project.newProject (OS.Path.fromUnixPath "/tmp");
  let 
    val path = OS.Path.concat [OS.FileSys.getDir(), "static_modules"]
    val files = map (fn s => OS.Path.concat [path, s])
		    ["separate3_b.sml", 
		     "separate3_a.sml"]
  in
    Shell.Project.setFiles (files)
  end;
  Shell.Project.setTargetDetails "separate3_b.sml";
  Shell.Project.setTargets ["separate3_b.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
);
