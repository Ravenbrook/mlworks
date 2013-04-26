(*  ==== FOREIGN INTERFACE : CORE INTERFACE ====
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
 *  This is the low-level foreign interface.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: core.sml,v $
 *  Revision 1.3  1996/09/05 15:15:07  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/05/20  20:39:50  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:39  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.4  1996/03/28  12:56:04  matthew
 * New sharing syntax etc.
 *
 * Revision 1.3  1995/04/19  21:57:45  brianm
 * General updating to reach prototype level for ML FI.
 *
 * Revision 1.2  1995/03/30  14:00:51  brianm
 * Added extra comment to list_content.
#
 * Revision 1.1  1995/03/27  15:30:09  brianm
 * new unit
 * Core Foreign interface (was foreign_interface.sml).
#
 *  Revision 1.2  1995/03/24  19:22:29  brianm
 *  Updated to use Word32.word values (instead of int * int) to
 *  encode addresses.
 * 
 *  Revision 1.1  1995/03/01  11:01:24  brianm
 *  new unit
 *  Foreign Interface signature
 * 
 *
 *)

require "types";

signature FOREIGN_CORE =
  sig

     structure FITypes : FOREIGN_TYPES

     type address = FITypes.address

     type foreign_object
     type foreign_value

     exception Unavailable

     datatype load_mode = LOAD_LATER | LOAD_NOW

     val load_object   : (string * load_mode) -> foreign_object
     val find_value    : (foreign_object * string) -> foreign_value

     val list_content  : foreign_object -> string list
         (* each string is space seperated - the first part is name of item *)

     val call_unit_fun : foreign_value -> unit
     val call_foreign_fun : (foreign_value * address * int * address) -> unit 

  end
