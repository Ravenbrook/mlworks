(*
 * $Log: __project.sml,v $
 * Revision 1.10  1999/02/11 13:44:27  mitchell
 * [Bug #190507]
 * Require new dependency files, but ignore them for now.
 *
 * Revision 1.9  1999/02/02  16:01:01  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.8  1998/10/21  10:42:56  jont
 * [Bug #70196]
 * Add link support (though not used yet)
 *
 * Revision 1.7  1998/01/28  14:34:40  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.6  1997/10/20  17:28:02  jont
 * [Bug #30089]
 * Remove OldOs and add OS
 *
 * Revision 1.5.2.5  1997/11/26  15:46:21  daveb
 * [Bug #30071]
 *
 * Revision 1.5.2.4  1997/11/20  17:00:15  daveb
 * [Bug #30326]
 *
 * Revision 1.5.2.3  1997/10/29  13:31:39  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove OldOs.
 *
 *
 * Revision 1.5.2.2  1997/09/17  15:49:16  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.5.2.1  1997/09/11  20:56:31  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.5  1997/05/12  16:05:27  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.4  1996/03/26  13:08:02  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.3  1995/12/07  17:03:06  daveb
 * Added header.
 *
 *  
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *)

require "../main/__encapsulate";
require "../main/__compiler";
require "../main/__proj_file";
require "../utils/__btree.sml";
require "../utils/__crash.sml";
require "../utils/__lists";
require "../utils/_diagnostic";
require "../utils/__text";
require "../system/__os";
require "../make/__depend";
require "../basics/__module_id";
require "../system/__os";
require "__options";
require "__mlworks_io";
require "_project";
require "../dependency/__module_dec_io.sml";
require "../dependency/__import_export.sml";

structure Project_ =
  Project (
    structure Encapsulate = Encapsulate_;
    structure Compiler = Compiler_;
    structure ProjFile = ProjFile_;
    structure NewMap = BTree_;
    structure Crash = Crash_;
    structure ModuleId = ModuleId_;
    structure OS = OS;
    structure Io = MLWorksIo_;
    structure Depend = Depend_;
    structure Options = Options_;
    structure Lists = Lists_;
    structure ModuleDecIO = ModuleDecIO;
    structure ImportExport = ImportExport;
    structure Diagnostic =
      Diagnostic (structure Text = Text_)
  );
