(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
Result: OK

 *
 * Test Win32 OS.IO.*.  All tests should return true.
 * 
 * Cannot test much at the moment since there is currently no way to create
 * a socket -- roll on the standard Socket Library.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io.sml,v $
 * Revision 1.8  1998/07/14 17:07:26  jont
 * [Bug #20131]
 * Use forceCompileAll to avoid out of date modules being loaded
 *
 *  Revision 1.7  1998/07/02  17:07:12  jont
 *  [Bug #20120]
 *  Modify to work with latest state of project system
 *
 *  Revision 1.6  1998/05/15  12:57:51  jont
 *  [Bug #30323]
 *  Rework in terms of project system
 *
 *  Revision 1.5  1998/01/22  16:22:13  jont
 *  [Bug #30323]
 *  Remove unnecessary uses of Shell.Build.loadSource
 *
 *  Revision 1.4  1997/04/01  16:50:09  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1997/03/12  16:45:48  jont
 *  Fix bug 1910
 *  Remove spurious path setting
 *  Change FILE_DESC to IODESC
 *
 *  Revision 1.2  1996/10/22  13:24:39  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/06/14  13:13:49  stephenb
 *  new unit
 *
 *)

local
  fun hd [] = raise Match
    | hd(x :: _) = x;
  val _ = Shell.Options.set(Shell.Options.ValuePrinter.maximumStrDepth, 0);
  val path = hd(Shell.Path.sourcePath());
  val _ = Shell.Project.openProject(OS.Path.joinDirFile{dir=path, file="basis.mlp"});
  val config_files = #files(Shell.Project.showConfigurationDetails"I386/NT")
  val files = Shell.Project.showFiles() @ config_files
  val _ = Shell.Project.closeProject()
  val files =
    map
    (fn file =>
     OS.Path.joinDirFile{dir=path, file=file})
    files
  val _ = Shell.Project.newProject(OS.Path.fromUnixPath "/tmp");
  val _ = Shell.Project.setFiles files;
  val _ = Shell.Project.setTargetDetails "__win32.sml";
  val _ = Shell.Project.setTargetDetails "__os_io.sml";
  val _ = Shell.Project.setTargets ["__win32.sml", "__os_io.sml"];
  val _ = Shell.Project.forceCompileAll();
in
  val _ = Shell.Project.loadAll();
end;

val kind_a = OSIO_.kind (Win32_.IODESC 0) = OSIO_.Kind.file;

val kind_b = OSIO_.kind (Win32_.IODESC 1) = OSIO_.Kind.file;

val kind_c = OSIO_.kind (Win32_.IODESC 2) = OSIO_.Kind.file;

val kind_e = (ignore(OSIO_.kind (Win32_.IODESC 42)); false) handle OS.SysErr _ => true;

local

  fun makePD n = 
    case OSIO_.pollDesc (Win32_.IODESC n) of
      NONE => raise OS.SysErr ("foo", NONE)
    | SOME pd => (OSIO_.pollIn o OSIO_.pollOut) pd

in
  val poll_a = (ignore(OSIO_.poll ([makePD 0], SOME Time.zeroTime)); false) handle OS.SysErr _ => true;
end
