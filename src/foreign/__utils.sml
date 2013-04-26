(*  ==== FOREIGN INTERFACE : UTILITIES ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __utils.sml,v $
 *  Revision 1.8  1997/05/21 16:54:31  jont
 *  [Bug #30090]
 *  Replace MLWorks.IO with TextIO where applicable
 *
 *  Revision 1.7  1996/11/06  12:16:40  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.6  1996/11/04  17:03:51  jont
 *  [Bug #1725]
 *  Remove unsafe string operations introduced when String structure removed
 *
 *  Revision 1.5  1996/10/23  16:21:03  io
 *  current naming conventions
 *
 *  Revision 1.4  1996/09/20  14:48:50  io
 *  [Bug #1603]
 *  convert ByteArray to Internal.ByteArray
 *
 *  Revision 1.3  1996/05/28  09:20:24  jont
 *  Fix bad reference to MLWorks.Bits
 *
 *  Revision 1.2  1996/05/22  13:38:18  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:38  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.9  1996/05/17  09:56:49  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.8  1996/05/01  11:39:24  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/04/30  14:51:47  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.6  1996/04/18  17:06:56  jont
 * initbasis becomes basis
 *
 * Revision 1.5  1996/02/14  16:51:29  brianm
 * Additions to allow for different data repn's (e.g. endianness).
 *
 *  Revision 1.4  1995/09/12  10:39:29  daveb
 *  Changed name of run-time function.
 *
 *  Revision 1.3  1995/09/09  13:29:38  brianm
 *  Further modification for updates and general reorganisation.
 *
 *  Revision 1.2  1995/06/25  14:18:20  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.1  1995/04/25  11:40:13  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "../basis/__int";
require "../basis/__string";
require "types";
require "__types";
require "utils";


structure ForeignUtils_ : FOREIGN_UTILS =
   struct

      structure FITypes : FOREIGN_TYPES = ForeignTypes_

      structure Bits = MLWorks.Internal.Bits

      open FITypes

      structure ByteArray = MLWorks.Internal.ByteArray

   (* Mapping *)

      val MLWcast         =  MLWorks.Internal.Value.cast : 'a -> 'b
      val MLWenvironment  =  MLWorks.Internal.Runtime.environment;

      fun env s = MLWcast(MLWenvironment s);
      
      (* ByteArray operations *)

      val bytearray     =  ByteArray.array

      val sub_bytearray =  ByteArray.subarray
      val to_list       =  ByteArray.to_list
      val sub_ba        =  MLWorks.Internal.Value.unsafe_bytearray_sub
      val update_ba     =  MLWorks.Internal.Value.unsafe_bytearray_update
      val copy_ba'      =  ByteArray.copy
      val copy_ba  =
          fn (src,src_st,len,tgt,tgt_st) =>
             copy_ba'(src,src_st,src_st+len,tgt,tgt_st)

      (* Word32 Operators *)

      val word32_repn   : word32 -> bytearray  =  env "word32 word to bytearray";
      val word32_abstr  : bytearray -> word32  =  env "word32 bytearray to word";

      (* Bit operators *)

      val rshift  =  Bits.rshift
      val andb    =  Bits.andb
      val lshift  =  Bits.lshift

   (* Implementation auxiliaries *)

      fun mask_lower(i) = andb(i,255)

      fun get_upper_bits(i) = rshift(i,8)


   (* Exported Definitions *)


      (* Deferred elements *)

      type 'a box =  'a option ref

      fun getBox(df)       = valOf(!df)
      fun setBox(rval)(a)  = rval := SOME(a)

      fun extractBox(rval)     = !rval
      fun updateBox(rval)(optv) = rval := optv 

      fun resetBox(rval)   = rval := NONE

      fun newBox(rval)     = ref(!rval)
      fun makeBox(v)           = ref(SOME(v))
      fun voidBox()            = ref(NONE)

      fun someBox(rval)    = isSome(!rval)


      fun disp view_fn x =
	let
	  val str = view_fn(x)
	in
	  print str;
	  x
	end

      fun sep_items sep =
	  let fun doit(x::y,r) = doit(y,x::sep::r)
		| doit([],r) = rev r
	  in
              fn []       => []
               | (h :: t) => doit(t,[h])
	  end

      fun term_items sep =
	  let fun doit(x::y,r) = doit(y,x::sep::r)
		| doit([],r) = rev (sep :: r)
	  in
              fn []       => []
               | (h :: t) => doit(t,[h])
	  end


      local

	 (* integer mapping - standard byte order *)
	 fun int_to_bytearray{src,len,arr=ba,st} =
	     let fun doit(k,idx,n) =
		     if (k < 1) then () else
		     let val lwb = mask_lower(n)
			 val upb = get_upper_bits(n)
		     in
		       update_ba(ba,idx,lwb);
		       doit(k-1,idx-1,upb)
		     end
	     in
		 doit(len,st+len-1,src)
	     end

	fun bytearray_to_int{arr=ba,st,len} =
	    let fun doit(k,idx,v) =
		    if (k < 1) then v else
		    let val lwb = sub_ba(ba,idx)
			val new_v = lshift(v,8) + lwb
		    in
			doit(k-1,idx+1,new_v)
		    end
	    in
		doit(len,st,0)
	    end

	 (* integer mapping - reversed byte order *)
	 fun int_to_bytearray_rev{src,len,arr=ba,st} =
	     let fun doit(k,idx,n) =
		     if (k < 1) then () else
		     let val lwb = mask_lower(n)
			 val upb = get_upper_bits(n)
		     in
		       update_ba(ba,idx,lwb);
		       doit(k-1,idx+1,upb)
		     end
	     in
		 doit(len,st,src)
	     end

	fun bytearray_to_int_rev{arr=ba,st,len} =
	    let fun doit(k,idx,v) =
		    if (k < 1) then v else
		    let val lwb = sub_ba(ba,idx)
			val new_v = lshift(v,8) + lwb
		    in
			doit(k-1,idx-1,new_v)
		    end
	    in
		doit(len,st+len-1,0)
	    end

     in
        val is_big_endian : bool = (env "big endian flag" ())

        val int_to_bytearray =
            if is_big_endian then int_to_bytearray
                             else int_to_bytearray_rev
 
        val bytearray_to_int =
            if is_big_endian then bytearray_to_int
                             else bytearray_to_int_rev
     end

     fun string_to_bytearray{src=str,arr=ba,st} =
         let val size' = size(str) - 1
             fun doit(k,idx) =
                 if (k < 0) then () else
                 let val byte = ord(String.sub(str,k))
                 in
                   update_ba(ba,idx,byte);
                   doit(k-1,idx-1)
                 end
         in
             doit(size',st+size')
         end
         
     fun bytearray_to_string{arr=ba,st,len} =
       let
	 val len' = len - 1
	 fun doit(k, idx, acc) =
	   if (k < 0) then
	     String.implode acc
	   else
	     let
	       val byte = sub_ba(ba,idx)
	     in
	       doit(k-1, idx-1, chr byte :: acc)
	     end
       in
	 doit(len', st+len', [])
       end

     fun word32_to_bytearray{src=wd,arr=ba,st} =
         let val src_ba = word32_repn( wd )
         in
             copy_ba(src_ba,0,4,ba,st)
         end

     fun bytearray_to_word32{arr=ba,st} =
         let val wd_repn = bytearray(4,0)
         in
           copy_ba(ba,st,4,wd_repn,0);
           word32_abstr( wd_repn )
         end

     local
        val a = ord #"A"

        fun hex_digit(i) =
            if 0 <= i andalso i <= 9 then
	      Int.toString i
	    else
	      (str o chr) (a + (i-10))

        fun hex_byte(i,strl) =
            let val hi = andb(rshift(i,4),15)
                val lo = andb(i,15)
            in
                hex_digit(lo) :: hex_digit(hi) :: strl
            end

        fun hex_byte'(i,strl) =
            let val hi = andb(rshift(i,4),15)
                val lo = andb(i,15)
            in
                " " :: hex_digit(lo) :: hex_digit(hi) :: strl
            end

        fun loop(f) =
            let fun doit([],strl)   = strl
	          | doit(i::l,strl) = doit(l, f(i,strl))
            in
                doit
            end
     in
	fun word32_to_hex (wd) =
            let val loopf = loop hex_byte
                val ba    = word32_repn(wd)
                val data  = loopf(to_list(ba),["x", "0"])
            in
                concat (rev data)
            end

	fun bytearray_to_hex {arr,st,len} =
            let val loopf = loop hex_byte'
                val ba    = sub_bytearray(arr,st,st+len)
                val data  = loopf(to_list(ba),[])
            in
                if data = nil then
		  ""
		else
		  (concat o rev o tl) data
            end
     end

     local
       val peek_mem : (address * bytearray * int * int) -> unit = 
             env "bytearray peek memory"
     in
       fun peek_memory {loc, arr, start, len} =
             peek_mem(loc,arr,start,len)
             handle _ => raise Fail("peek_memory")
     end
   end;
