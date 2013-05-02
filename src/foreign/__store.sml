(*  ==== FOREIGN INTERFACE : FOREIGN_STORE ====
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
 *
 *  Revision Log
 *  ------------
 *  $Log: __store.sml,v $
 *  Revision 1.5  1996/11/06 11:25:04  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.4  1996/10/25  12:57:21  io
 *  current naming conventions
 *
 *  Revision 1.3  1996/09/20  14:57:40  io
 *  [Bug #1603]
 *  convert ByteArray to Internal.ByteArray
 *
 *  Revision 1.2  1996/05/19  16:12:16  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  13:59:07  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.9  1996/05/13  10:02:07  matthew
 * Changes to basis.
 *
 * Revision 1.8  1996/05/01  11:41:39  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/04/30  14:59:08  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.6  1996/04/18  16:57:16  jont
 * initbasis becomes basis
 *
 * Revision 1.5  1995/09/12  16:23:04  daveb
 * Word conversion functions have changed.
 *
 *  Revision 1.4  1995/09/07  22:43:41  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.3  1995/06/21  16:31:53  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.2  1995/05/04  19:23:38  brianm
 *  Removing restrictive eqtype constraints & introduce abstypes in
 *  various implementing types.
 *
 *  Revision 1.1  1995/04/25  11:35:59  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "^.basis.__int";
require "^.basis.__word32";

require "static_bytearray";
require "types";
require "utils";

require "__static_bytearray";
require "__types";
require "__utils";

require "store";

structure ForeignStore_ : FOREIGN_STORE =
   struct

     structure StaticByteArray : STATIC_BYTEARRAY = StaticByteArray_
     structure FIUtils : FOREIGN_UTILS = ForeignUtils_
     structure FITypes : FOREIGN_TYPES = ForeignTypes_

   (* Mapping *)

     open FITypes

     structure ByteArray = MLWorks.Internal.ByteArray

     type static_bytearray  = StaticByteArray.static_bytearray

     val static_array       = StaticByteArray.alloc_array

     val static_addr        = StaticByteArray.address_of

     val to_bytearray : static_bytearray -> bytearray  =
           StaticByteArray.to_bytearray

     val copy_ba'           = ByteArray.copy
     val copy_ba  =
         fn (src,src_st,len,tgt,tgt_st) =>
            copy_ba'(src,src_st,src_st+len,tgt,tgt_st)

     val sub_bytearray  =  ByteArray.subarray
     val length_ba      =  ByteArray.length
     val to_list        =  ByteArray.to_list

     val disp                 =  FIUtils.disp
     val sep_list             =  FIUtils.sep_items

     val word32_to_hex        =  FIUtils.word32_to_hex
     val bytearray_to_hex     =  FIUtils.bytearray_to_hex
     val bytearray_to_string  =  FIUtils.bytearray_to_string

     val addrToInt          =  Word32.toIntX
     val intToAddr          =  Word32.fromInt
     val pl32               =  Word32.+
     val mi32               =  Word32.-

     infix 6 pl32 mi32


   (* Implementation auxiliaries *)

     fun static_copy(src_sba,st,len,dest_sba,offset) =
         let val src_ba    = to_bytearray(src_sba)
             val dest_ba   = to_bytearray(dest_sba)
         in 
             copy_ba(src_ba,st,len,dest_ba,offset)
         end


     fun addr_plus(a,i)    = a pl32 (intToAddr i)
     fun addr_minus(a1,a2) = addrToInt(a1 mi32 a2)

   (* Exported Definitions *)

     datatype store_status = LOCKED_STATUS | RD_STATUS | WR_STATUS | RDWR_STATUS 

     datatype alloc_policy = ORIGIN | SUCC | ALIGNED_4 | ALIGNED_8

     datatype overflow_policy = BREAK | EXTEND | RECYCLE

     abstype store =
              STORE of
                {
                     origin : address ref,
                     status : store_status ref,
                      alloc : alloc_policy,
                   overflow : overflow_policy,
                       size : int ref,
                        top : int ref,
                    content : static_bytearray ref
                }
     with
	fun storeAlloc(STORE{alloc, ...})         =  alloc
	fun storeOverflow(STORE{overflow, ...})   =  overflow
	fun store_origin(STORE{origin, ...})       = !origin
	fun storeSize(STORE{size, ...})           = !size

	fun storeStatus(STORE{status, ...}) = !status
	fun setStoreStatus(STORE{status, ...}, new_status) = (status := new_status)

	fun store_content(STORE{content, ...}) = to_bytearray(!content)

	fun isStandardStore(STORE{alloc=ORIGIN, ...})    =  false
	  | isStandardStore(STORE{overflow=BREAK, ...})  =  true
	  | isStandardStore(_)  =  false

	fun isEphemeralStore(STORE{alloc=ORIGIN, ...})      =  false
	  | isEphemeralStore(STORE{overflow=RECYCLE, ...})  =  true
	  | isEphemeralStore(_)  =  false


	exception ReadOnly
	exception WriteOnly

	local
	   fun round_up(size,base) =
	       let val spill = (size mod base)
	       in
		   size + (base - spill)
	       end

	   fun round_down(size,base) =
	       let val spill = (size mod base)
	       in
		   size - spill
	       end

	   fun adjust_size_up(ORIGIN,    size) = size
	     | adjust_size_up(SUCC,     size) = size
	     | adjust_size_up(ALIGNED_4, size) = round_up(size,4)
	     | adjust_size_up(ALIGNED_8, size) = round_up(size,8)

	   fun adjust_size_down(ORIGIN,    size) = size
	     | adjust_size_down(SUCC,     size) = size
	     | adjust_size_down(ALIGNED_4, size) = round_down(size,4)
	     | adjust_size_down(ALIGNED_8, size) = round_down(size,8)
	in
	   val adjust_store_size       = adjust_size_up
	   val adjust_object_size_above = adjust_size_up
	   val adjust_object_size_below = adjust_size_down
	end

	fun store {alloc,overflow,status,size} =
	    let val size' = adjust_store_size(alloc,size)
		val store = static_array(size')
		val addr  = static_addr(store,0)
	    in
		STORE{ origin   =  ref(addr),
			status   =  ref(status),
			alloc    =  alloc,
			overflow =  overflow,
			size     =  ref(size'),
			top      =  ref(0),
			content  =  ref(store)
		      }
	    end

	exception ExpandStore

	local
	   val min_expand = 512
	   val max_expand = min_expand * min_expand

	   fun adjust_increment(n) = Int.min(max_expand, Int.max(n,min_expand))

	   fun expand_content(STORE{origin,content,size,alloc, ...},increment) =
	       let val new_size  = adjust_store_size(alloc,!size + increment)
		   val new_store = static_array(new_size)
		   val new_addr  = static_addr(new_store,0)
	       in
		   static_copy(!content,0,!size,new_store,0);
		   content := new_store;
		   size := new_size;
		   origin := new_addr
	       end

	   fun expand_store(store,increment') =
	       let val increment = adjust_increment(increment')
	       in
		   case storeStatus(store) of
		      RDWR_STATUS => expand_content(store,increment)
		   |
		      WR_STATUS   => expand_content(store,increment)
		   |
		      _      => raise ExpandStore
	       end

	   fun expand_store'(store,space_required) =
	       let val size = storeSize(store)
		   val increment = Int.min(2 * space_required, size)
	       in
		   expand_store(store,increment)
	       end
	in

	   fun expand(store,increment) =
	       if isStandardStore(store) 
	       then expand_store(store,increment)
	       else expand_store'(store,increment)

	   fun expand_managed(store,space_required) =
	       if isStandardStore(store) 
	       then raise ExpandStore
	       else expand_store'(store,space_required)

	end



	(* ==== OVERFLOW & ALLOCATION MANAGEMENT ====


	In general we have the following relationships holding:

	  %--- .. ---%---------------%---- .. ----%--------%---------
	  %          %    OBJECT     %            % free   %     
	  %          %               %            % space  %     
	  %--- .. ---%---------------%---- .. ----%--------%---------
	  0          |---obj_size---> ^            ^       ^
		     ^                |            |       |
		     |                |            |       |
	  offset ---/                 |            |       |
				      |            |       |
	  obj_end -------------------/             |       |
						   |       |
	  top (= next_offset) --------------------/        |
							   |
	  store_size ------------------------------------/

	So:

	       0 <= offset < obj_end = offset + obj_size
			   <= top = next_offset
			   <= store_size

               free_space = store_size - top

               Each object : offset <= i < obj_end 


	When objects are either originally allocated or (conceptually)
	moved, this may cause:

	   - allocation of (some) remaining free space in the store
	     to be used by an object.

	   - overflow of the store by consuming all remaining
	     free space.  This may lead to an ML exception being
	     raised or to the store being extended in some way.

	In either case the object has a putative value for the index just
	beyond the end, called new_obj_end.

	  The store needs allocation iff:   new_obj_end > top
	  The store has overflowed iff:     new_obj_end > store_size

	*)

	local

	   fun adjust_next_top( ORIGIN, _ ) = 0
	     | adjust_next_top( _, next_top )  = next_top

	in

	   fun fresh_object_offset(store,obj_size) =
	       let val STORE{alloc,top,size,overflow, ...} = store
		   val new_offset = !top
		   val new_obj_end' = new_offset + obj_size
		   val new_obj_end = adjust_object_size_above(alloc,new_obj_end')
		   val free_space = !size - new_obj_end
	       in 
		   ( if free_space < 0
		     then case overflow of
			    EXTEND   =>
			      ( expand(store,~free_space);
				top := adjust_next_top(alloc,new_obj_end)
			      )
			  | RECYCLE  => top := 0
			  | BREAK    => raise ExpandStore
		     else top := adjust_next_top(alloc,new_obj_end)
		   );
		   new_offset
	       end

	   fun adjust_store(store,obj_offset,obj_size) =
	       let val STORE{top, ...} = store
		   val next_offset = !top
		   val new_obj_end = obj_offset + obj_size
		   val remaining_space = next_offset - new_obj_end
	       in 
		   if remaining_space < 0
		   then ignore( fresh_object_offset(store,obj_size) )
		   else ()
	       end
	end

        (* Diagnostic tools *)
        local
           fun push_if b x stk = if b then x :: stk else stk

           fun str_kind(store) =
               let val strl = push_if (isStandardStore store) "standard" []
                   val strl = push_if (isEphemeralStore store) "ephemeral" strl
               in
                   if strl = [] then "non-standard" else
		     concat (sep_list ", " strl)
               end

           fun str_status(LOCKED_STATUS)  = "LOCKED_STATUS (locked - no access)"
             | str_status(RD_STATUS)      = "RD_STATUS (read-only access)"
             | str_status(WR_STATUS)      = "WR_STATUS (write-only access)"
             | str_status(RDWR_STATUS)    = "RDWR_STATUS (read/write access)"

           fun str_alloc(ORIGIN)  =
                 "ORIGIN     (allocate objects at the origin)"
             | str_alloc(SUCC)   =
                 "SUCC      (allocate objects at the top end)"
             | str_alloc(ALIGNED_4)  =
                 "ALIGNED_4  (allocate objects at the top end - 4-byte aligned)"
             | str_alloc(ALIGNED_8)  =
                 "ALIGNED_8  (allocate objects at the top end - 8-byte aligned)"
  
           fun str_overflow(BREAK) =
                 "BREAK    (raise exception on overflow)"
             | str_overflow(EXTEND) =
                 "EXTEND   (extend store on overflow)"
             | str_overflow(RECYCLE) =
                 "RECYCLE  (restart at origin on overflow)"
        in

	   fun storeInfo (store) =
               let val STORE{origin, status, alloc, overflow, size, top, ...} = store
                   val size = !size
                   val top  = !top
               in
		   { kind     = str_kind(store),
                     origin   = !origin,
		     status   = str_status(!status),
		     alloc    = str_alloc(alloc),
		     overflow = str_overflow(overflow),
		     size     = size,
		     top      = top,
		     free     = (size - top) }
               end

	   fun storeData {store, start, length} =
               let val data = store_content(store)
                   val ba = sub_bytearray(data,start,(start + length))
               in
                   to_list(ba)
               end

	   fun storeDataHex {store, start, length} =
               let val data = store_content(store)
               in
                   bytearray_to_hex{arr=data,st=start,len=length}
               end

	   fun storeDataAscii {store, start, length} =
               let val data = store_content(store)
               in
                   bytearray_to_string{arr=data,st=start,len=length}
               end


           fun viewStore (store) =
	       let val { kind, origin, status, alloc, overflow, size, top, free } =
		       storeInfo store
	       in
		 concat [ "\n\n",
			       "   Store (", kind, ", ", status, ")\n",
			       "          alloc      = ", alloc, "\n",
                               "          overflow   = ", overflow, "\n",
			       "          origin     = ", word32_to_hex(origin), "\n",
			       "          top (size) = ", Int.toString top,
                                          " (", Int.toString size, ")", "\n",
			       "          free = (size - top) = ",
                                          Int.toString free, "\n",
			       "\n\n" ]
	       end

           val dispStore = disp viewStore

	   fun diffAddr a1 a2 = addr_minus(a1,a2)

	   val incrAddr = addr_plus
        end

     end
   end;
