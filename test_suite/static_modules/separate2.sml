(*
Test of Shell.Compile.loadSource
Result: OK
 
$Log: separate2.sml,v $
Revision 1.21  1998/06/15 12:32:23  mitchell
[Bug #30422]
newProject now requires a directory

 * Revision 1.20  1998/06/04  14:19:19  johnh
 * [Bug #30369]
 * Replace project source path with a list of files.
 *
 * Revision 1.19  1998/05/21  12:22:20  mitchell
 * [Bug #50071]
 * Replace touchAllSource by a force compile
 *
 * Revision 1.18  1998/05/07  09:28:54  mitchell
 * [Bug #50071]
 * Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 * Revision 1.17  1998/05/04  16:45:46  mitchell
 * [Bug #50071]
 * Replace uses of Shell.Build.loadSource by Shell.Project
 *
 * Revision 1.16  1997/11/21  10:54:13  daveb
 * [Bug #30323]
 *
 * Revision 1.15  1997/04/01  16:53:48  jont
 * Modify to stop displaying syserror type
 *
 * Revision 1.14  1996/12/20  11:51:40  jont
 * New source path required since test suite has moved
 *
 * Revision 1.13  1996/05/22  10:55:10  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.12  1996/04/12  11:36:48  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.11  1996/04/03  10:11:13  stephenb
 * Update wrt recent changes in OS structure -- __os is no longer in
 * initbasis it is system dependent.
 *
 * Revision 1.10  1996/02/23  16:18:09  daveb
 * Converted Shell structure to new capitalisation convention.
 *
Revision 1.9  1996/01/25  17:32:43  jont
More Shell modifications

Revision 1.8  1996/01/24  11:54:07  stephenb
Replace MLWorks.OS.Unix.getwd by OS.FileSys.getDir

Revision 1.7  1995/12/08  11:49:31  daveb
Shell compile commands have changed.

Revision 1.6  1995/02/24  15:10:06  jont
Modify to be only for the make system (ie not for .mo files)

Revision 1.5  1994/04/26  15:49:06  jont
Shell structure revisions

Revision 1.4  1993/12/10  19:05:03  jont
New name for recompile

Revision 1.3  1993/08/20  13:10:35  jont
Revised for new test suite

Revision 1.2  1993/08/04  12:11:35  jont
*** empty log message ***

Revision 1.1  1993/07/30  17:14:12  jont
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
		    ["separate2_c.sml", 
		     "separate2_b.sml", 
		     "separate2_a.sml"]
  in
    Shell.Project.setFiles (files)
  end;
  Shell.Project.setTargetDetails "separate2_c.sml";
  Shell.Project.setTargets ["separate2_c.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
);






