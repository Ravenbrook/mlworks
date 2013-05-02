(*
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
 * $Log: __file_dialog.sml,v $
 * Revision 1.9  1996/10/30 18:27:55  daveb
 * Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.8  1996/04/12  08:54:17  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.7  1996/03/27  12:18:58  stephenb
 * Update in accordance with the latest revised basis.
 * FileSys and UnixOS disappear and become Os.
 *
 * Revision 1.6  1996/01/18  10:32:41  stephenb
 * OS reorganisation: parameterise functor with UnixOS since all
 * OS specific stuff has been removed from the pervasive library.
 *
 * Revision 1.5  1995/12/13  11:02:54  daveb
 * Added FileSys parameter.
 *
 * Revision 1.4  1995/07/26  13:58:50  matthew
 * Restructuring gui directories
 *
 * Revision 1.3  1995/01/16  13:30:05  daveb
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.2  1994/12/09  10:56:45  jont
 * Move OS specific stuff into a system link directory
 *
 * Revision 1.1  1994/06/30  18:02:20  daveb
 * new file
 *
 *)

require "../main/__info";
require "../motif/__xm";
require "../system/__os";

require "_file_dialog";

structure FileDialog_ =
  FileDialog
    (structure Xm = Xm
     structure Info = Info_
     structure OS = OS)
