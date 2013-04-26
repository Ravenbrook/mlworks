(* LINK_SUPPORT the signature *)
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
 * $Log: link_support.sml,v $
 * Revision 1.4  1998/10/26 16:51:28  jont
 * [Bug #70198]
 * Add support for invoking gcc and creating a unqiue stamp for a dll/so
 *
 * Revision 1.3  1998/10/23  15:33:59  jont
 * [Bug #70198]
 * Add ability to make archives (using ar)
 *
 * Revision 1.2  1998/10/21  13:47:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../basis/__word32";

signature LINK_SUPPORT =
  sig
    datatype target_type = DLL | EXE
    datatype linker_type = GNU | LOCAL
    val link :
      {objects : string list, (* Full pathnames *)
       libs : string list, (* Full pathnames *)
       target : string, (* Just a final component, without .exe or anything *)
       target_path : string, (* Where to put the target *)
       dll_or_exe : target_type,
       base : Word32.word, (* Default base address *)
       make_map : bool, (* True if a link map should be produced *)
       linker : linker_type (* Use the default or GNU *)
       } -> unit

    val archive : {archive : string, files : string list} -> unit

    val make_stamp : string -> string

    val gcc : string -> unit

  end
