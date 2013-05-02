(* UnixLinkSupport the functor *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
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
 *
 * $Log: _unix_link_support.sml,v $
 * Revision 1.4  1998/10/26 15:59:46  jont
 * [Bug #70198]
 * Add support for invoking gcc and creating a unqiue stamp for a dll/so
 *
 * Revision 1.3  1998/10/23  14:44:54  jont
 * [Bug #70198]
 * Add ability to make archives (using ar)
 *
 * Revision 1.2  1998/10/21  13:47:21  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/crash";
require "../basis/__word32";
require "__os";
require "../main/link_support";

functor UnixLinkSupport (
  structure Crash : CRASH
) : LINK_SUPPORT =
  struct
    datatype target_type = DLL | EXE
    datatype linker_type = GNU | LOCAL
    fun link
      {objects, (* Full pathnames *)
       libs, (* Full pathnames *)
       target, (* Just a final component, without .exe or anything *)
       target_path, (* Where to put the target *)
       dll_or_exe,
       base, (* Default base address *)
       make_map, (* True if a link map should be produced *)
       linker (* Use the default or GNU *)
       } =
      Crash.unimplemented"Unix linker support: link"

    fun archive{archive : string, files : string list} =
      Crash.unimplemented"Unix linker support: archive"

    fun make_stamp _ = Crash.unimplemented"Unix linker support: make_stamp"

    fun gcc _ = Crash.unimplemented"Unix linker support: gcc"
  end
