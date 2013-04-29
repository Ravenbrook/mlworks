(*  SaveImage structure.
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Log: __save_image.sml,v $
 *  Revision 1.11  1999/05/27 10:32:57  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 *  Revision 1.10  1999/05/13  14:01:06  daveb
 *  [Bug #190553]
 *  Replaced use of basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.9  1998/05/01  11:20:44  mitchell
 *  [Bug #50071]
 *  Close project when saving guib.img
 *
 *  Revision 1.8  1998/01/26  18:34:16  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 *  Revision 1.7.2.3  1997/11/26  11:19:47  daveb
 *  [Bug #30071]
 *
 *  Revision 1.7.2.2  1997/11/20  16:54:37  daveb
 *  [Bug #30326]
 *
 *  Revision 1.7.2.1  1997/09/11  20:54:20  daveb
 *  branched from trunk for label MLWorks_workspace_97
 *
 *  Revision 1.7  1997/05/27  09:45:03  johnh
 *  [Bug #20033]
 *  Required basis/list for checking the -silent option.
 *
 *  Revision 1.6  1997/05/12  16:31:19  jont
 *  [Bug #20050]
 *  main/io now exports MLWORKS_IO
 *
 *  Revision 1.5  1997/03/20  15:52:19  matthew
 *  Moved read_dot_mlworks
 *
 *  Revision 1.4  1996/11/06  12:08:52  daveb
 *  Added License parameter.
 *
 *  Revision 1.3  1996/08/06  08:52:31  stephenb
 *  Replace any use of OldOs.mtime that ignores the time with
 *  with OS.FileSys.access.
 *
 *  Revision 1.2  1996/07/03  13:46:46  daveb
 *  Bug 1448/Support Call 35: Added remove_file_info to project and incremental,
 *  and called it from _save_image.
 *
 *  Revision 1.1  1996/05/20  15:38:00  daveb
 *  new unit
 *  Separates code for saving image from where it was entangled in _shell_structure.
 *
 *)

require "__user_context";
require "__shell_types";
require "__shell_utils";
require "__incremental";
require "../system/__getenv";
require "../system/__os";
require "../system/__mlworks_exit";
require "../basis/__list";
require "../main/__version";
require "../main/__user_options";
require "../main/__preferences";
require "../main/__mlworks_io";
require "../main/__proj_file";
require "../main/__info";

require "_save_image";

structure SaveImage_ =
  SaveImage (
    structure UserContext = UserContext_
    structure ShellTypes = ShellTypes_
    structure ShellUtils = ShellUtils_
    structure Incremental = Incremental_
    structure Getenv = Getenv_
    structure OS = OS
    structure Io = MLWorksIo_
    structure Info = Info_
    structure Exit = MLWorksExit
    structure Version = Version_
    structure UserOptions = UserOptions_
    structure Preferences = Preferences_
    structure List = List
    structure ProjFile = ProjFile_
  );
