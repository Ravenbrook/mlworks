(*  ==== FOREIGN INTERFACE : C_STORE ====
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
 *  The C interface version of the internal FOREIGN_STORE signature.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: c_store.sml,v $
 *  Revision 1.2  1996/09/06 12:37:08  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/19  13:59:08  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.5  1996/03/28  13:56:53  matthew
 * Sharing constraints
 *
 * Revision 1.4  1995/09/07  22:43:42  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.3  1995/06/15  15:19:54  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.2  1995/05/04  19:42:15  brianm
 *  Removing restrictive eqtype constraints & introduce abstypes in
 *  various implementing types.
 *
 *  Revision 1.1  1995/04/25  11:46:37  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "types";

signature C_STORE =
   sig

     structure FITypes : FOREIGN_TYPES
     type bytearray = FITypes.bytearray
     type address = FITypes.address

     type store

     exception ReadOnly
     exception WriteOnly

     datatype store_status = LOCKED_STATUS | RD_STATUS | WR_STATUS | RDWR_STATUS 

     val storeStatus  : store -> store_status
     val setStoreStatus : (store * store_status) -> unit

     datatype alloc_policy = ORIGIN | SUCC | ALIGNED_4 | ALIGNED_8

     datatype overflow_policy = BREAK | EXTEND | RECYCLE

     val store : { alloc    : alloc_policy,
                    overflow : overflow_policy,
                    status   : store_status,
                    size     : int } -> store

     val storeSize     : store -> int
     val storeAlloc    : store -> alloc_policy
     val storeOverflow : store -> overflow_policy

     exception ExpandStore

     val isStandardStore  : store -> bool
     val isEphemeralStore : store -> bool

     val expand  : (store * int) -> unit

     (* Debugging tools *)

     val storeInfo : store ->
	    { kind     : string,
              origin   : address,
	      status   : string,
	      alloc    : string,
	      overflow : string,
	      size     : int,
	      top      : int,
              free     : int }

     val storeData :
	 { store : store,
	   start  : int,
	   length : int } -> int list

     val storeDataHex :
	 { store : store,
	   start  : int,
	   length : int } -> string

     val storeDataAscii :
	 { store : store,
	   start  : int,
	   length : int } -> string

     val diffAddr : address -> address -> int
     val incrAddr : address * int -> address

   end;
