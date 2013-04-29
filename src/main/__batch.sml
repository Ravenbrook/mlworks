(*  ==== TOP LEVEL BATCH COMPILER ====
 *          STRUCTURE AND GO!
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
 *  Revision Log
 *  ------------
 *  $Log: __batch.sml,v $
 *  Revision 1.30  1999/05/27 10:33:47  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 * Revision 1.29  1999/05/13  12:56:39  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.28  1999/02/05  14:44:14  mitchell
 * [Bug #170109]
 * Make the batch project rely on basis/__general to keep the daily build happy
 *
 * Revision 1.27  1998/01/28  10:08:46  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.26.2.3  1997/11/20  16:59:34  daveb
 * [Bug #30326]
 *
 * Revision 1.26.2.2  1997/09/17  16:24:56  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.26.2.1  1997/09/11  20:57:14  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.26  1997/05/12  16:12:40  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.25  1996/11/06  12:09:08  daveb
 * Added License parameter.
 *
 * Revision 1.24  1996/10/29  17:16:14  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.23  1996/05/16  12:49:47  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments
 *
 * Revision 1.22  1996/05/08  13:30:36  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.21  1996/04/30  09:13:29  matthew
 * Use basis integer structure
 *
 * Revision 1.20  1996/04/17  14:53:28  stephenb
 * Replace any use of MLWorks.exit by Exit.exit.
 *
 * Revision 1.19  1995/12/27  15:52:56  jont
 * Remove __option
 *
 *  Revision 1.18  1995/12/14  17:18:08  jont
 *  Reordering requires a bit
 *
 *  Revision 1.17  1995/11/20  17:26:44  daveb
 *  Removed Recompile parameter.
 *
 *  Revision 1.16  1995/06/30  16:03:30  daveb
 *  Added the Integer parameter.
 *
 *  Revision 1.15  1995/06/01  12:31:55  daveb
 *  Removed Preferences parameter.
 *
 *  Revision 1.14  1995/04/20  15:21:50  daveb
 *  Removed the FileSys parameter.
 *
 *  Revision 1.13  1995/01/17  16:54:09  daveb
 *  Replaced FileName parameter.
 *
 *  Revision 1.12  1994/12/08  17:03:22  jont
 *  Move OS specific stuff into a system link directory
 *
 *  Revision 1.11  1994/08/01  12:59:18  daveb
 *  Added Preferences argument.
 *
 *  Revision 1.10  1994/02/24  15:59:13  daveb
 *  Adding UnixFilename parameter.
 *
 *  Revision 1.9  1994/02/21  17:16:21  daveb
 *  Added Encapsulate argument.
 *
 *  Revision 1.8  1993/08/04  14:52:18  daveb
 *  Added Option parameter.
 *
 *  Revision 1.7  1993/04/28  10:03:02  richard
 *  The batch compiler now returns a status code.
 *
 *  Revision 1.6  1993/04/06  17:30:08  jont
 *  Moved user_options and version from interpreter to main
 *
 *  Revision 1.5  1993/02/24  14:39:00  jont
 *  Added Io_ structure to functor parameter
 *
 *  Revision 1.4  1992/12/04  12:30:49  richard
 *  The module table is cleared before invoking the batch compiler.
 *  The version module is a new parameter.
 *
 *  Revision 1.3  1992/11/20  13:56:48  jont
 *  Added option parameter. removed info parameter
 *
 *  Revision 1.2  1992/11/18  16:39:26  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.1  1992/09/01  13:40:46  richard
 *  Initial revision
 *
 *)

require "__toplevel";
require "__mlworks_io";
require "__encapsulate";
require "__version";
require "__proj_file";
require "__user_options";
require "../system/__mlworks_exit";
require "_batch";

(* Require basis/__general so that the daily build, which builds the batch 
   project without first building the basis project, still builds all the mos 
   it needs.  We can remove this when the process of building a project is 
   altered so that it brings all of its subprojects uptodate first. *)

require "../basis/__general";

structure Batch_ = Batch(
  structure Io = MLWorksIo_
  structure Encapsulate = Encapsulate_
  structure User_Options = UserOptions_
  structure TopLevel = TopLevel_
  structure ProjFile = ProjFile_
  structure Version = Version_
  structure Exit = MLWorksExit);

MLWorks.Internal.Runtime.modules := [];
val _ = MLWorksExit.exit (Batch_.obey (MLWorks.arguments ()));
