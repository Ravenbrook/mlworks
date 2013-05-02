(*  ==== FOREIGN INTERFACE : FOREIGN_OBJECT ====
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
 *  Revision Log
 *  ------------
 *  $Log: object.sml,v $
 *  Revision 1.3  1996/10/25 12:35:28  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/05/22  13:45:57  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  13:59:09  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.7  1996/04/18  16:59:37  jont
 * initbasis becomes basis
 *
 * Revision 1.6  1996/03/28  13:53:18  matthew
 * Sharing constraints
 *
 * Revision 1.5  1995/09/10  15:23:13  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.4  1995/06/25  18:20:58  brianm
 * Adding remote access, diagnostics and other facilities.
 *
 * Revision 1.3  1995/05/04  19:42:39  brianm
 * Removing restrictive eqtype constraints & introduce abstypes in
 * various implementing types.
 *
 * Revision 1.2  1995/04/20  14:42:33  brianm
 * General updating to reach prototype level for ML FI.
 *
 * Revision 1.1  1995/03/27  15:47:52  brianm
 * new unit
 *
 *)

require "types";
require "store";

signature FOREIGN_OBJECT =
   sig

     type 'a option = 'a option

     structure FITypes  : FOREIGN_TYPES

     type bytearray = FITypes.bytearray
     type address = FITypes.address

     structure FIStore : FOREIGN_STORE

     type store = FIStore.store

     exception ReadOnly
     exception WriteOnly

     type ('l_type) object

     datatype object_mode = LOCAL_OBJECT | REMOTE_OBJECT
     datatype object_status = PERMANENT_OBJECT | TEMPORARY_OBJECT

     exception OutOfBounds
     exception Currency

     val object : { lang_type : 'l_type,
                 size      : int,
                 status    : object_status,
                 mode      : object_mode,
                 currency  : bool,
                 store     : store } -> ('l_type) object

     val objectStatus       : ('l_type) object -> object_status

     val objectCurrency     : ('l_type) object -> bool
     val set_object_currency : ('l_type) object * bool -> unit

     val objectMode      : ('l_type) object -> object_mode
     val set_object_mode  : ('l_type) object * object_mode -> unit

     val object_type      : ('l_type) object -> 'l_type
     val set_object_type  : ('l_type) object * 'l_type -> unit

     val objectSize      : ('l_type) object -> int
     val set_object_size  : ('l_type) object * int -> unit  (* sets currency false *)
     val set_object_size' : ('l_type) object * int -> unit  (* leaves currency unchanged *)

     val object_value     : ('l_type) object * bytearray * int -> unit
     val object_value'    : ('l_type) object * bytearray * int -> unit
                         (* doesn't check currency *) 

     val set_object_value   : ('l_type) object * bytearray * int -> unit
     val copy_object_value  : { from : ('l_type) object,
                             to   : ('l_type) object } -> unit   
     val copy_object_value' : { from : ('l_type) object,
                             to   : ('l_type) object } -> unit   

     val new_object        : ('l_type) object -> ('l_type) object
     val dup_object        : ('l_type) object -> ('l_type) object
     val tmp_object        : ('l_type) object -> ('l_type) object

     val to_location    : ('l_type) object * address -> int
     val to_address     : ('l_type) object * int -> address

     val relative_location  : ('l_type) object * address -> int
     val relative_address   : ('l_type) object * int -> address
     
     val objectLocation   : ('l_type) object -> int

     val move_object       : ('l_type) object * int -> unit  (* sets currency false *)
     val offset_object     : ('l_type) object * int -> unit  (* sets currency false *)

     val move_object'      : ('l_type) object * int -> unit  (* leaves currency unchanged *)
     val offset_object'    : ('l_type) object * int -> unit  (* leaves currency unchanged *)

     val objectAddress      : ('l_type) object -> address

     val set_object_address  : ('l_type) object * address -> unit
     val set_object_address' : ('l_type) object * address -> unit
  
     val examine_object    : ('l_type) object * address -> unit


     (* Diagnostic tools *)

     val object_info : ('l_type -> 'l_info) -> ('l_type) object ->
		{ store    : store,
		  status    : string,
		  currency  : string,
		  mode      : string,
                  langtype  : 'l_info,
                  size      : int,
                  offset    : int,
                  base      : address option
                }

     val object_data         : ('l_type)object -> int list
     val object_data_hex     : ('l_type)object -> string
     val object_data_ascii   : ('l_type)object -> string


   (*
      The CURRENCY flag
      =================

      When currency flag is false, the object data is not to be trusted.
      When currency flag is true, the object data is probably valid (but may not be).

      Operations which change currency:
         set_object_currency

      Operations which set currency false:
         tmp_object, move_object, offset_object, set_object_address, set_object_size

      Operations which preserve currency:
         new_object, dup_object, move_object', offset_object', set_object_address', set_object_size',
         object_value', copy_object_value'(to)

      Operations which set currency true:
         examine_object, set_object_value, copy_object_value(to)

      Operations which _need_ currency set true:
         object_value, copy_object_value(from)
   *)

   end;  (* signature FOREIGN_OBJECT *) 
