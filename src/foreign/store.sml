(*  ==== FOREIGN INTERFACE : FOREIGN_STORE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *  A _Store_ is an area of memory reserved for the purpose of
 *  reading/writing data from ML for use in foreign computations.  A
 *  store possesses a size (in 8-bit bytes) and can either be
 *  _Standard_ or _Managed_.  A Standard store generally remains
 *  fixed in size, and can only be expanded by an explicit call of
 *  function expand_store().  A Managed store, on the other hand,
 *  can be expanded automatically as needed - in principle, the memory
 *  used can be allocated as needed.
 *
 *  The use of stores helps the user programmer to control the
 *  memory mgmt.  overhead when dealing with foreign data - although a
 *  Managed store is most convenient, a Standard store of a fixed
 *  size might be all that is actually required.
 *
 *  Also associated with a store is a status field - this is
 *  provided to help the user provide low-level support for avoiding
 *  inadvertent corruption of data.
 * 
 *  
 *    - If the status is Rd then only reading is permitted, but writing is not.
 *    - If the status is Wr then only writing is permitted but reading is not.
 *    - If the status is RdWr then both reading and writing are permitted.
 *
 *  In the presence of concurrency within ML, this form of locking
 *  would have to be additionally protected by an appropriate monitor
 *
 *  Revision Log
 *  ------------
 *  $Log: store.sml,v $
 *  Revision 1.3  1996/09/06 12:36:30  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/05/20  20:39:51  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  13:59:10  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.5  1996/03/28  13:51:45  matthew
 * Sharing constraints
 *
 * Revision 1.4  1995/09/07  22:43:44  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.3  1995/06/21  15:09:41  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.2  1995/05/04  19:35:35  brianm
 *  Removing restrictive eqtype constraints & introduce abstypes in
 *  various implementing types.
 *
 *  Revision 1.1  1995/04/25  11:45:36  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.1  1995/03/27  15:47:52  brianm
 * new unit
#
 * New file.
#
 *
 *)

require "types";

signature FOREIGN_STORE =
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
     val store_origin   : store -> address
     val storeAlloc    : store -> alloc_policy
     val storeOverflow : store -> overflow_policy
     val store_content  : store -> bytearray

     exception ExpandStore

     val isStandardStore  : store -> bool
     val isEphemeralStore : store -> bool

     val expand          : (store * int) -> unit
     val expand_managed  : (store * int) -> unit

     val fresh_object_offset  : (store * int) -> int
     val adjust_store        : (store * int * int) -> unit


     (* Diagnostic tools *)

     val viewStore : store -> string
     val dispStore : store -> store

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
