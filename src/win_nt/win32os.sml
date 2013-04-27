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
 *
 * An interface to a misc. collection of features made available
 * on any operating system that claims to be Win32.
 *
 * Revision Log
 * ------------
 *
 *  $Log: win32os.sml,v $
 *  Revision 1.8  1998/06/05 14:24:54  mitchell
 *  [Bug #30416]
 *  Add support for CREATE_ALWAYS
 *
 *  Revision 1.7  1997/04/01  09:37:43  andreww
 *  [Bug #2004]
 *  adding FROM_CURRENT to seek_direction.
 *
 *  Revision 1.6  1997/01/15  12:19:51  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.5  1996/08/21  15:02:24  stephenb
 *  [Bug #1554]
 *  Replaces various uses of int with file_desc type.
 *
 *  Revision 1.4  1996/08/09  10:35:49  daveb
 *  [Bug #1536]
 *  Made read and write use Word8Vector.vectors instead of strings.
 *
 *  Revision 1.3  1996/07/15  16:36:13  andreww
 *  eliding standard in, out and err.
 *
 *  Revision 1.2  1996/07/04  18:02:32  andreww
 *  Altering win32 runtime environment interface.
 *
 *  Revision 1.1  1996/03/05  11:34:27  jont
 *  new unit
 *  Support for revised initial basis
 *
 *
 *)

require "^.basis.__word8_vector";

signature WIN32OS =
  sig

    datatype seek_direction = FROM_BEGIN | FROM_CURRENT | FROM_END

    datatype open_method = READ | READ_WRITE | WRITE 

    datatype open_action = CREATE_ALWAYS | OPEN_ALWAYS | OPEN_EXISTING

    type file_desc

    val open_ : string * open_method * open_action -> file_desc
    val close : file_desc -> unit
    val write : file_desc * Word8Vector.vector * int * int -> int
    val read  : file_desc * int -> Word8Vector.vector
    val seek  : file_desc * int * seek_direction -> int
    val size  : file_desc -> int
  end
