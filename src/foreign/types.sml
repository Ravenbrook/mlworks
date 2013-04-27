(*  ==== FOREIGN INTERFACE : COMMON TYPES ====
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
 *  Description
 *  -----------
 *  This contains various common type declarations used thoughout the
 *  common layers of the FI and other interfaces.  Use of this was
 *  forced since sharing constraints can only refer to typenames.  The
 *  names provided here enable the sharing constraints to be required
 *  early in signatures, so simplifying later constraints.
 *
 *  Revision Log
 *  ------------
 *  $Log: types.sml,v $
 *  Revision 1.4  1996/10/25 12:33:22  io
 *  [Bug #1547]
 *  current naming conventions
 *
 *  Revision 1.3  1996/09/20  14:48:55  io
 *  [Bug #1603]
 *  convert ByteArray to Internal.ByteArray
 *
 *  Revision 1.2  1996/05/22  12:37:04  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  13:59:10  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.5  1996/04/18  16:59:50  jont
 * initbasis becomes basis
 *
 * Revision 1.4  1996/03/28  12:55:09  matthew
 * New sharing syntax etc.
 *
 * Revision 1.3  1995/09/07  22:43:44  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.2  1995/07/18  12:41:05  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.1  1995/04/25  11:50:05  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__word8";

signature FOREIGN_TYPES =
   sig

      type 'a option = 'a option

      type word8 = Word8.word

      type word32 = Word32.word

      type address = word32

      type bytearray = MLWorks.Internal.ByteArray.bytearray

      type name = string

      type filename = string

   (* some debugging tools *)

      val debugP : string -> 'a -> 'a

   end (* signature FOREIGN_TYPES *)
