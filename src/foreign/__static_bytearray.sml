(*  ==== STATIC BYTEARRAYS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: __static_bytearray.sml,v $
 *  Revision 1.5  1997/01/15 15:03:56  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.4  1996/10/25  13:00:09  io
 * [Bug #1547]
 * current naming conventions
 *
 * Revision 1.3  1996/09/20  14:48:59  io
 * [Bug #1603]
 * convert ByteArray to Internal.ByteArray
 *
 * Revision 1.2  1996/05/19  23:35:19  brianm
 * Beta release modifications.
 *
 * Revision 1.5  1996/04/18  16:57:57  jont
 * initbasis becomes basis
 *
 * Revision 1.4  1996/03/20  15:07:32  matthew
 * Language revision
 *
 * Revision 1.3  1995/04/19  21:32:05  brianm
 * General updating to reach prototype level for ML FI.
 *
 * Revision 1.2  1995/03/24  17:58:23  brianm
 * Added address_of operator to static_bytearrays and also
 * simplified implementation (mostly casts now).
 *
 * Revision 1.1  1995/03/17  16:46:04  brianm
 * new unit
 * New file.
 *
 *)

require "../basis/__word8_array";
require "../basis/__word32";
require "../basis/__word8";
require "static_bytearray";

structure StaticByteArray_ : STATIC_BYTEARRAY =
  struct

    structure ByteArray = MLWorks.Internal.ByteArray

    type bytearray = ByteArray.bytearray

    type word8 = Word8.word

    type address = Word32.word

    datatype static_bytearray = STATIC of bytearray

    (* Mapping *)

    val MLWcast = MLWorks.Internal.Value.cast

    local
      val env = MLWorks.Internal.Runtime.environment

    in

      val mk_static_bytearray : int -> bytearray  =
            env "make static bytearray"

      val from_string : string -> static_bytearray  =
            env "static bytearray from string"

      val address_of : (static_bytearray * int) -> address =
            env "static bytearray address of"

    end

    val fill_ba  :  (bytearray * word8) -> unit  = MLWcast( ByteArray.fill )

    val sub_ba            = ByteArray.sub
    val update_ba         = ByteArray.update
    val length_ba         = ByteArray.length
    val tabulate_ba       = ByteArray.tabulate
    val to_list_ba        = ByteArray.to_list
    val to_string_ba      = ByteArray.to_string

    val unsafe_update_ba : (bytearray * int * word8) -> unit =
        MLWcast( MLWorks.Internal.Value.unsafe_bytearray_update )

 (* Exported Definitions *)

    fun array (size,item : word8) =
       let val sba = mk_static_bytearray(size)
       in
         fill_ba(sba,item);
         STATIC(sba)
       end;

    fun alloc_array(size) = STATIC(mk_static_bytearray(size))
        (* _Unsafe_ version of array above. *)

    val length   : static_bytearray -> int                 =  MLWcast( length_ba )
    val update   : static_bytearray * int * word8 -> unit  =  MLWcast( update_ba )
    val sub      : static_bytearray * int -> word8         =  MLWcast( sub_ba )

    fun from_list (list : word8 list) =
      let
	(* length is overloaded here so qualify the damn thing *)
        val sba = mk_static_bytearray (FullPervasiveLibrary_.length list)

        fun fill (_, []) = ()
          | fill (n, x::xs) =
                (unsafe_update_ba (sba, n, x); fill (n+1, xs))
      in
        fill (0, list);
        STATIC(sba)
      end

    val array_of_list = from_list

    val tabulate : (int * (int -> word8)) -> static_bytearray  =
          MLWcast( tabulate_ba )

    val to_bytearray  : static_bytearray -> bytearray  =
          MLWcast
        (* This works because MLWorks doesn't generate constructor tags
           for datatypes consisting of single entries.
         *)

    val to_list : static_bytearray -> word8 list =
          MLWcast( to_list_ba )

    val to_string : static_bytearray -> string =
          MLWcast( to_string_ba )



  end;
