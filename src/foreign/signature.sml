(*  ==== FOREIGN INTERFACE : FOREIGN_SIGNATURE ====
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
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: signature.sml,v $
 *  Revision 1.2  1996/10/25 12:36:17  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:18  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  11:46:39  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.3  1996/04/18  16:59:00  jont
 * initbasis becomes basis
 *
 * Revision 1.2  1996/03/28  14:11:22  matthew
 * Sharing changes
 *
 * Revision 1.1  1995/09/07  22:47:52  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:42:33  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.1  1995/03/27  15:48:27  brianm
 * new unit
 * New file.
 *
 *)
signature FOREIGN_SIGNATURE =
   sig

     type 'a option = 'a option

     type ('entry) fSignature

     (* foreign signature operations *)

     val newSignature      : unit -> 'entry fSignature

     val lookupEntry : 'entry fSignature * string -> ('entry)option
     val defEntry    : 'entry fSignature * (string * 'entry) -> unit
     val removeEntry   : 'entry fSignature * string -> unit

     val showEntries : 'entry fSignature -> (string * 'entry) list

   end; (* signature FOREIGN_SIGNATURE *)
