(*  ==== FOREIGN INTERFACE : LIBML C/ML INTERFACE ====
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
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __libml.sml,v $
 *  Revision 1.4  1996/09/05 14:41:07  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 * Revision 1.3  1996/03/20  15:17:40  matthew
 * Language revision
 *
 * Revision 1.2  1995/07/07  10:54:03  brianm
 * Adding dependencies ...
 *
 *  Revision 1.1  1995/07/07  10:45:56  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "libml";

structure LibML_ : LIB_ML =
   struct

   (* Mapping *)

     val env  = MLWorks.Internal.Runtime.environment;

     val registerExternalValue   :  string * 'a -> unit =
         fn x => env "add external ml value" x

     val deleteExternalValue   :  string -> unit =
         env "delete external ml value"

     val externalValues   :  unit -> string list =
         env "external ml value names"

     val clearExternalValues   :  unit -> unit =
         env "clear external ml values"
   end;

