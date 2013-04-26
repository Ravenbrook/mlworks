(*  ==== FOREIGN INTERFACE : C DATA/TYPE STRUCTURES ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: __c_object.sml,v $
 *  Revision 1.8  1996/11/06 11:25:22  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.7  1996/10/25  11:51:32  io
 *  [Bug #1547]
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.6  1996/10/18  12:07:34  brianm
 *  Fixing problems with normalise_type & size of chars ...
 *
 *  Revision 1.5  1996/09/20  14:48:58  io
 *  [Bug #1603]
 *  convert ByteArray to Internal.ByteArray
 *
 *  Revision 1.4  1996/08/20  00:51:23  brianm
 *  Adding pointer comparison functions ...
 *
 *  Revision 1.3  1996/08/19  10:52:32  daveb
 *  [Bug #1551]
 *  Fixed offset problem in get_string.
 *
 *  Revision 1.2  1996/05/24  01:19:14  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  13:59:06  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.11  1996/05/01  11:48:18  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.10  1996/04/30  15:03:06  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.9  1996/04/18  16:56:02  jont
 * initbasis becomes basis
 *
 * Revision 1.8  1996/02/15  12:29:19  brianm
 * Modifications due to byte-ordering considerations.
 *
 *  Revision 1.7  1995/09/10  17:46:44  brianm
 *  Further modification for updates and general reorganisation.
 *
 *  Revision 1.5  1995/09/07  22:43:38  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.4  1995/07/20  23:07:25  brianm
 *  adding new_object.
 *
 *  Revision 1.3  1995/07/18  12:17:12  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.2  1995/06/26  10:40:45  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.1  1995/04/25  11:28:19  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.1  1995/03/27  15:49:53  brianm
 * new unit
 * New file.
 *
 *)

require "^.basis.__int";
require "^.basis.__list";
require "^.utils.__lists";

require "types";
require "structure";
require "object";
require "utils";
require "c_store";

require "__types";
require "__structure";
require "__object";
require "__utils";
require "__store";   (* Matches signature constraint C_STORE *)

require "c_object";

structure CObject_ : C_OBJECT = 
   struct

     structure Lists = Lists_
     structure FIStructure  : FOREIGN_STRUCTURE  = Structure_
     structure FIObject     : FOREIGN_OBJECT   = ForeignObject_
     structure FIUtils      : FOREIGN_UTILS    = ForeignUtils_
     structure CStore       : C_STORE          = ForeignStore_

     open FIUtils
     open FIObject

     structure CStore = CStore
     structure FITypes = CStore.FITypes

     open CStore
     open FITypes

   (* Mapping *)

     (* This stuff should be converted to use Basis word8array material
      * but not done so due to lack of time and
      * uncertainty wrt runtime repercussions
      *)
       
     (* Internal ByteArray operators *)

     structure ByteArray  = MLWorks.Internal.ByteArray

     val bytearray    =  ByteArray.array
 
     val sub_ba       =  ByteArray.sub
     val update_ba    =  ByteArray.update
     val find_ba      =  ByteArray.find_default
     val subarray_ba  =  ByteArray.subarray

     val from_string  =  ByteArray.from_string
     val to_string    =  ByteArray.to_string

     val unsafe_sub_ba      =  MLWorks.Internal.Value.unsafe_bytearray_sub
     val unsafe_update_ba   =  MLWorks.Internal.Value.unsafe_bytearray_update

     (* OBJECT operators *)

     type 'a object  =  'a FIObject.object

     val object'               =    FIObject.object

     val object_address        =    FIObject.objectAddress
     val object_location       =    FIObject.objectLocation

     val to_address            =    FIObject.to_address
     val to_location           =    FIObject.to_location

     val move_object           =    FIObject.move_object
     val offset_object         =    FIObject.offset_object
     val examine_object        =    FIObject.examine_object

     val set_object_address'   =    FIObject.set_object_address'

     val new_object'           =    FIObject.new_object
     val dup_object'           =    FIObject.dup_object
     val tmp_object'           =    FIObject.tmp_object

     val copy_object_value     =    FIObject.copy_object_value
     val copy_object_value'    =    FIObject.copy_object_value'  (* non-checking version *)

     val objectType           =    FIObject.object_type
     val set_object_type       =    FIObject.set_object_type

     val object_size           =    FIObject.objectSize
     val set_object_size       =    FIObject.set_object_size'


     (* Modified OBJECT operators *)

     val object_value      =  FIObject.object_value
     val object_value'     =  FIObject.object_value'
     val set_object_value  =  FIObject.set_object_value 

     (* Implementation Utilities *)

     fun new(ref(x)) = ref(x)

  (* C TYPE STRUCTURE *)
 
     (* Pointer information may be interpreted in the following ways:
        - LOCAL_PTR     = Machine address pointing within the associated store
        - REMOTE_PTR    = Machine address pointing outside associated store
        - RELATIVE_PTR  = Index value accessing location within associated store
      *)
     datatype pointer_kind  = LOCAL_PTR | RELATIVE_PTR | REMOTE_PTR

     (* A representation of C type's in ML ...

	The ML type c_type provides a representation of a C type descriptor
	as an ML value.
     *)
     datatype c_type =
        VOID_TYPE
     |
        CHAR_TYPE           | UNSIGNED_CHAR_TYPE | SIGNED_CHAR_TYPE
     |
        SHORT_TYPE          | INT_TYPE           | LONG_TYPE
     |
        UNSIGNED_SHORT_TYPE | UNSIGNED_INT_TYPE  | UNSIGNED_LONG_TYPE
     |
        FLOAT_TYPE          | DOUBLE_TYPE        | LONG_DOUBLE_TYPE
     |
        STRING_TYPE   of { length : int }
     |
        TYPENAME      of { name : name,
                           size : int option }
     |
        FUNCTION_TYPE of { source : c_type list,
                           target : c_type
                         }
     |
        POINTER_TYPE  of { ctype : c_type, mode : pointer_kind }
     |
        STRUCT_TYPE   of { tag    : name option,
                           fields : c_field list,
                           size   : int option }
     |
        UNION_TYPE    of { tag      : name option,
                           variants : c_variant list,
                           size     : int option,
                           current  : c_variant }
     |
        ARRAY_TYPE    of { length : int, ctype : c_type, size : int option }
     |
        ENUM_TYPE     of { tag   : name option,
                           elems : name list,
                           card  : int }

     and  c_variant = VARIANT of { name  : name,
                                   ctype : c_type,
                                   size  : int option }

     and  c_field   = FIELD of { name    : name,
                                 ctype   : c_type,
                                 size    : int option,
                                 padding : int,
                                 offset  : int option }

     local
	fun lookup_itemlist p (ni_lst, nm) = 
	  valOf (* could raise Option *) (List.find (p nm) ni_lst)

	fun find_field   nm (FIELD{name, ...}) =  (name = nm)

	fun find_variant nm (VARIANT{name, ...}) =  (name = nm)
     in
        val lookup_variant  = lookup_itemlist find_variant
        val lookup_field    = lookup_itemlist find_field
     end


     fun variant_name (VARIANT{name, ...}) = name
     fun field_name   (FIELD{name, ...}) = name

     (* Size constants *)
     val char_size                = 4
     val short_int_size           = 2
     val int_size                 = 4
     val long_int_size            = 4
     val real_size                = 4

     local
       val unsigned_short_int_size  = short_int_size
       val unsigned_int_size        = int_size
       val unsigned_long_int_size   = long_int_size

       val double_size              = real_size
       val long_double_size         = real_size

       val pointer_size             = int_size
       val enum_size                = int_size
       val void_size                = 0

       fun pad_size_of (CHAR_TYPE             ,_)   = int_size
         | pad_size_of (UNSIGNED_CHAR_TYPE    ,_)   = int_size
         | pad_size_of (SIGNED_CHAR_TYPE      ,_)   = int_size
         | pad_size_of (SHORT_TYPE            ,_)   = int_size
         | pad_size_of (UNSIGNED_SHORT_TYPE   ,_)   = int_size
         | pad_size_of (_, size) = size

       fun padding_adjustment(_,_,_) = 0
     in

       exception UnknownTypeName of string

       fun sizeOf(VOID_TYPE)             = void_size

         | sizeOf(CHAR_TYPE)             = char_size
         | sizeOf(UNSIGNED_CHAR_TYPE)    = char_size
         | sizeOf(SIGNED_CHAR_TYPE)      = char_size

         | sizeOf(SHORT_TYPE)            = short_int_size
         | sizeOf(INT_TYPE)              = int_size
         | sizeOf(LONG_TYPE)             = long_int_size

         | sizeOf(UNSIGNED_SHORT_TYPE)   = unsigned_short_int_size
         | sizeOf(UNSIGNED_INT_TYPE)     = unsigned_int_size
         | sizeOf(UNSIGNED_LONG_TYPE)    = unsigned_long_int_size

         | sizeOf(FLOAT_TYPE)            = real_size
         | sizeOf(DOUBLE_TYPE)           = double_size
         | sizeOf(LONG_DOUBLE_TYPE)      = long_double_size

         | sizeOf(STRING_TYPE{length})   = length  (* includes null sentinel *)
         
         | sizeOf(TYPENAME{size=SOME(size), ...}) = size          

         | sizeOf(TYPENAME{name, ...}) = raise UnknownTypeName(name)

         | sizeOf(POINTER_TYPE _)  = pointer_size

         | sizeOf(FUNCTION_TYPE _) = pointer_size

         | sizeOf(STRUCT_TYPE{size=SOME(size), ...}) = size

         | sizeOf(STRUCT_TYPE{fields, ...}) = size_of_struct(fields)

         | sizeOf(UNION_TYPE{size=SOME(size), ...}) = size

         | sizeOf(UNION_TYPE{variants, ...}) = size_of_union(variants)

         | sizeOf(ARRAY_TYPE { size=SOME(size), ... }) = size

         | sizeOf(ARRAY_TYPE { length, ctype, ... }) = length * sizeOf(ctype)

         | sizeOf(ENUM_TYPE _) = enum_size

       and size_of_field (FIELD{size=SOME sz, ...},cur_offset) = sz + cur_offset
         | size_of_field (FIELD{ctype, ...}, cur_offset) =
           let val new_size    = sizeOf ctype
               val pad_size    = pad_size_of (ctype,new_size)
           in
               pad_size + cur_offset
           end

       and size_of_struct fld_lst = foldl size_of_field 0 fld_lst

       and size_of_variant(VARIANT{size=SOME(size), ctype, ...}, cur_size) =
	 Int.max (size,cur_size)
         | size_of_variant(VARIANT{size, ctype, ...}, cur_size) = 
	 Int.max (sizeOf ctype,cur_size)

       and size_of_union(vnt_lst) = foldl size_of_variant 0 vnt_lst
     end


     local
        fun variant_leq (VARIANT{name=nm1, ...}, VARIANT{name=nm2, ...}) =
            (nm1 <= nm2)
     in
        fun sort_variant_list(vnt_l) =
            if Lists.check_order variant_leq vnt_l
            then vnt_l
            else Lists.msort variant_leq vnt_l
     end;

     local
       fun equal_type'
             ( TYPENAME{name=nm1, ...}
             , TYPENAME{name=nm2, ...}
             ) = (nm1 = nm2)

         | equal_type'
             ( POINTER_TYPE{ctype=cty1, ...}
             , POINTER_TYPE{ctype=cty2, ...}
             ) = equal_type'(cty1,cty2)

         | equal_type'
             ( STRUCT_TYPE{tag=SOME(tg1), ...}
             , STRUCT_TYPE{tag=SOME(tg2), ...}
             ) = (tg1 = tg2)

         | equal_type'
             ( STRUCT_TYPE{tag=NONE,fields=fld_lst1, ...}
             , STRUCT_TYPE{tag=NONE,fields=fld_lst2, ...}
             ) = equal_fields(fld_lst1,fld_lst2)

         | equal_type'
             ( UNION_TYPE{tag=SOME(tg1), ...}
             , UNION_TYPE{tag=SOME(tg2), ...}
             ) = (tg1 = tg2)

         | equal_type'
             ( UNION_TYPE{tag=NONE,variants=vnt_lst1, ...}
             , UNION_TYPE{tag=NONE,variants=vnt_lst2, ...}
             ) = equal_variants(vnt_lst1,vnt_lst2)

         | equal_type'(cty1,cty2) = (cty1 = cty2)    

       and equal_variants (vl1, vl2) = 
           if (length vl1 = length vl2)
           then let val vl1' = sort_variant_list(vl1)
                    val vl2' = sort_variant_list(vl2)
                in
                   equal_variants'(vl1',vl2')
                end
           else false

       and equal_variants' 
             ( VARIANT{name=nm1, ctype=cty1, ...}::vnt_lst1
             , VARIANT{name=nm2, ctype=cty2, ...}::vnt_lst2
             ) = (nm1 = nm2) andalso equal_type'(cty1,cty2)
                             andalso equal_variants'(vnt_lst1,vnt_lst2)

         | equal_variants'([],[])  = true

         | equal_variants'(_,_)    = false

       and equal_fields
             ( FIELD{name=nm1, ctype=cty1, ...}::fld_lst1
             , FIELD{name=nm2, ctype=cty2, ...}::fld_lst2
             ) = (nm1 = nm2) andalso equal_type'(cty1,cty2)
                             andalso equal_fields(fld_lst1,fld_lst2)

         | equal_fields([],[])  = true

         | equal_fields(_,_)    = false
     in

       fun equalType(cty1,cty2) =
             (cty1 = cty2) orelse equal_type'(cty1,cty2)

     end

     local
       fun mk_field (str,ty) =
           FIELD { name    = str,
                   ctype   = ty,
                   size    = NONE,
                   padding = 0,
                   offset  = NONE }

       fun mk_variant (str,ty) =
           VARIANT { name    = str,
                     ctype   = ty,
                     size    = NONE }
     in

       fun structType (nm,flds) =
	   STRUCT_TYPE { tag    = SOME(nm),
 		         fields = map mk_field flds, 
		         size   = NONE
		       }

       fun unionType (nm,vnts) =
	     let val variants' = sort_variant_list(map mk_variant vnts)
	     in
		 UNION_TYPE { tag      = SOME(nm),
			      variants = variants',
			      size     = NONE,
			      current  = hd variants'
			    }
	     end

       fun ptrType (ty) =
           POINTER_TYPE { ctype = ty, mode = LOCAL_PTR }

       fun typeName (nm) =
           TYPENAME { name = nm,
                      size = NONE
                    }

       fun enumType (nm,elem_lst) =
           ENUM_TYPE { tag   = SOME(nm),
                       elems = elem_lst,
                       card  = length elem_lst
                     }
     end


  (* C VALUE STRUCTURE *)

     type c_object  =  c_type object

     val object_mode      : c_object -> object_mode         =  objectMode
     val setObjectMode  : c_object * object_mode -> unit  =  set_object_mode

     val examine_object   : c_object * address -> unit  =  examine_object
     val object_address   : c_object -> address         =  object_address

     val object_value     : c_object * bytearray * int -> unit  =  object_value
     val set_object_value : c_object * bytearray * int -> unit  =  set_object_value

     type c_char   =  int

     type c_short_int = int
     type c_int       = int
     type c_long_int  = int

     type c_real         = real
     type c_double       = real
     type c_long_double  = real

     exception ForeignType
     exception StoreAccess

     val newObject : c_object -> c_object =
	 fn (obj) =>
	   let val new_object   =  new_object'(obj)
	       val new_ctype =  objectType(obj)
	   in
	     set_object_type(new_object,new_ctype);
	     new_object
	   end

     val dupObject : c_object -> c_object =
	 fn (obj) =>
	   let val new_object   =  dup_object'(obj)
	       val new_ctype =  objectType(obj)
	   in
	     set_object_type(new_object,new_ctype);
	     new_object
	   end

     val tmpObject : c_object -> c_object =
	 fn (obj) =>
	   let val new_object   =  tmp_object'(obj)
	       val new_ctype =  objectType(obj)
	   in
	     set_object_type(new_object,new_ctype);
	     new_object
	   end

     fun object{ctype,store} =
	 let val object_size = sizeOf(ctype)
	 in
	     object'{ lang_type  =  ctype,
  		      status     =  PERMANENT_OBJECT,
		      size       =  object_size,
		      mode       =  LOCAL_OBJECT,
		      currency   =  true,
		      store      =  store }
	 end

     fun copy_object_info{from=src_pd,to=tgt_pd} =
         let val from_type = objectType(src_pd)
             val from_size = object_size(src_pd)
         in
           set_object_type(tgt_pd,from_type);
           set_object_size(tgt_pd,from_size);
           copy_object_value{from=src_pd,to=tgt_pd}
         end


     (* Object extraction/insertion utilities *)

     local
	val data_buffer = bytearray(sizeOf(LONG_DOUBLE_TYPE),0)
	(* To cut down on allocation, a fixed data buffer is used
	   for passing small items such as characters, integers and
	   reals (of various standard sizes).

	   !! NOT THREAD-SAFE !!
	 *)


        val half_int = int_size div 2

     in

	fun f_object_value(obj) =
	      ( object_value(obj,data_buffer,0);
		data_buffer
	      )

	fun f_object_value'(obj) =
	      ( object_value'(obj,data_buffer,0);
		data_buffer
	      )

	fun set_int'(obj,i) =
	  ( int_to_bytearray{len=int_size,arr=data_buffer,src=i,st=0};
	    set_object_value(obj,data_buffer,0)
	  ) handle _ => raise StoreAccess

	fun get_int'(obj)  =
	    bytearray_to_int{arr=f_object_value(obj),st=0,len=int_size}

        fun get_int2' (hi_ref,lo_ref) =
            let fun get2 (obj) =
                    let val ba = f_object_value (obj)
                    in
		        hi_ref := bytearray_to_int {arr=ba,st=0,len=half_int} ;
		        lo_ref := bytearray_to_int {arr=ba,st=half_int,len=half_int}
                    end
            in
                get2
            end

	fun set_word32'(obj,wd) =
	  ( word32_to_bytearray{arr=data_buffer,src=wd,st=0};
	    set_object_value(obj,data_buffer,0)
	  ) handle _ => raise StoreAccess

	fun get_word32'(obj)  =  bytearray_to_word32{arr=f_object_value(obj),st=0}

	fun set_char'(obj,ch) =
	    if (0 <= ch) andalso (ch < 256)
	    then ( update_ba(data_buffer,0,ch);
		   set_object_value(obj,data_buffer,0)
		 )
	    else raise StoreAccess

	fun get_char'(obj) =
	    ( object_value(obj,data_buffer,0);
	      sub_ba(data_buffer,0)
	    )

	fun get_signed_char'(obj) =
	    let val ch = get_char'(obj)
	    in
		if (ch < 128) then ch else (ch - 256)
	    end

	fun address_to_bytearray(addr) =
	      ( word32_to_bytearray{arr=data_buffer,src=addr,st=0};
		data_buffer
	      )

	fun bytearray_to_address(ba)  =  bytearray_to_word32{arr=ba,st=0}

	local
	   val real_size = sizeOf(LONG_DOUBLE_TYPE)
	in
	   fun get_real'(obj) =
	       let val buffer   = f_object_value(obj)
		   val repn_str = bytearray_to_string{arr=buffer,st=0,len=real_size}
	       in
		 MLWorks.Internal.Value.string_to_real repn_str
	       end
	end

	fun set_real'(obj,r) =
	    let val real_str = MLWorks.Internal.Value.real_to_string r
	    in
		string_to_bytearray{arr=data_buffer,src=real_str,st=0};
		set_object_value(obj,data_buffer,0)
	    end

	local

	   fun zerop (i) = (i = 0)

	   fun find_string_end(length,buffer) = find_ba (zerop,length-1) buffer

           val cache_size   = ref 256
           val string_cache = ref (bytearray (!cache_size,0))

           fun get_buffer (len) =
               if len <= !cache_size then !string_cache else
               let val new_cache = bytearray (len,0)
               in
 		   string_cache := new_cache ;
		   cache_size   := len ;
		   new_cache
               end

	in

	   fun get_string' (obj,length) =
	       let val buffer = get_buffer (length)
	       in
		   object_value(obj,buffer,0);
		   let val end_idx = find_string_end(length,buffer)
		       val str_buf = subarray_ba(buffer,0,end_idx+1)
		   in
		       to_string(str_buf)
		   end
	       end

	   fun setString' (obj,length,str) =
               if (size(str) <= length)
               then set_object_value(obj,from_string(str),0)
               else raise StoreAccess
	end
     end

     (* Setters ... *)

     fun setUnsignedChar(obj,ch) =
         case objectType(obj) of
           CHAR_TYPE          => set_char'(obj,ch)
         |
           UNSIGNED_CHAR_TYPE => set_char'(obj,ch)
         |
           _ => raise ForeignType

     val setChar = setUnsignedChar

     fun setSignedChar(obj,ch) =
         case objectType(obj) of
           CHAR_TYPE        => set_char'(obj,(ch mod 256))
         |
           SIGNED_CHAR_TYPE => set_char'(obj,(ch mod 256))
         |
           _ => raise ForeignType

     fun setShort(obj,i) =
         case objectType(obj) of
           SHORT_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setInt(obj,i) =
         case objectType(obj) of
           INT_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setLong(obj,i) =
         case objectType(obj) of
           LONG_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setUnsignedShort(obj,i) =
         case objectType(obj) of
           UNSIGNED_SHORT_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setUnsigned(obj,i) =
         case objectType(obj) of
           UNSIGNED_INT_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setUnsignedLong(obj,i) =
         case objectType(obj) of
           UNSIGNED_LONG_TYPE  => set_int'(obj,i)
         |
           _ => raise ForeignType

     fun setWord32(obj,wd) =
         case objectType(obj) of
           UNSIGNED_INT_TYPE  => set_word32'(obj,wd)
         |
           _ => raise ForeignType

     fun setEnum(obj,i) =
         case objectType(obj) of
           ENUM_TYPE{card, ...} =>
             (
              (if (0 <= i) andalso (i < card)
               then set_int'(obj,i)
               else raise ForeignType
              ) handle Option => raise ForeignType
             )
         |
           _ => raise ForeignType


     fun setFloat(obj,r) =
         case objectType(obj) of
           FLOAT_TYPE  => set_real'(obj,r)
         |
           _ => raise ForeignType

     fun setDouble(obj,r) =
         case objectType(obj) of
           DOUBLE_TYPE  => set_real'(obj,r)
         |
           _ => raise ForeignType

     fun setLongDouble(obj,r) =
         case objectType(obj) of
           LONG_DOUBLE_TYPE  => set_real'(obj,r)
         |
           _ => raise ForeignType

 
     fun setString(obj, str) =
         case objectType(obj) of
           STRING_TYPE{length}  => setString' (obj,length,str)
         |
           _ => raise ForeignType


     fun setLocalPtr(ptr_object) =
         case objectType(ptr_object) of
           POINTER_TYPE{mode=RELATIVE_PTR, ctype} =>
              let val rel_ptr = f_object_value(ptr_object)
                  val idx     = bytearray_to_int{arr=rel_ptr,st=0,len=int_size}
                  val addr    = to_address(ptr_object,idx)
                  val ba      = address_to_bytearray(addr)          
              in
                  set_object_type(ptr_object,POINTER_TYPE{ctype=ctype,mode=LOCAL_PTR});
                  set_object_value(ptr_object,ba,0);
		  ()
              end
         |
           POINTER_TYPE(_) => ()
         |
           _ => raise ForeignType


     fun setRelativePtr(ptr_object) =
         case objectType(ptr_object) of
           POINTER_TYPE{mode=LOCAL_PTR, ctype} =>
              let val abs_ptr = f_object_value(ptr_object)
                  val addr    = bytearray_to_address(abs_ptr)
                  val idx     = to_location(ptr_object,addr)
              in
                  set_int'(ptr_object,idx);
                  set_object_type(ptr_object,POINTER_TYPE{ctype=ctype,mode=LOCAL_PTR});
		  ()
              end
         |
           POINTER_TYPE(_) => ()
         |
           _ => raise ForeignType


     fun setRemotePtr(ptr_object) =
         case objectType(ptr_object) of
           POINTER_TYPE{mode=REMOTE_PTR, ...} => ()
         |
           POINTER_TYPE{mode=LOCAL_PTR, ctype} =>
             ( set_object_type(ptr_object,POINTER_TYPE{ctype=ctype,mode=REMOTE_PTR}) )
         |
           POINTER_TYPE{mode, ctype} =>
             ( setLocalPtr(ptr_object);
               set_object_type(ptr_object,POINTER_TYPE{ctype=ctype,mode=REMOTE_PTR})
             )
         |
           _ => raise ForeignType

     local
         fun set_array'(elem_object,rel_offset,contents,buf) =
             let fun doit([]) = ()
                   | doit(p::pl) =
                     ( object_value(p,buf,0);
                       set_object_value(elem_object,buf,0);
                       offset_object(elem_object,rel_offset);
                       doit(pl)
                     )
             in
                doit(contents)
             end
     in
       (* length is overloaded here and so the horrid qualification *)
         fun setArray(obj,contents,st) =
             case objectType(obj) of
                ARRAY_TYPE{length,ctype,size} =>
                  if (st + FullPervasiveLibrary_.length contents > length)
                  then raise StoreAccess
                  else let val elem_size   =  sizeOf ctype
                           val elem_object    =  dup_object'(obj)
                           val init_posn   =  st * elem_size
                           val elem_buffer =  bytearray(elem_size,0)
                       in
                           set_object_type(elem_object,ctype);
                           set_object_size(elem_object,elem_size);
                           offset_object(elem_object,init_posn);
                           set_array'(elem_object,elem_size,contents,elem_buffer);
                           set_object_currency(obj,true)
                       end
             |
                _ => raise ForeignType
     end

     local
        fun set_struct'(fld_object,fld_lst,object_lst) =
            let fun doit(offset,FIELD{size, ...}::fld_lst,p::pl) =
                    ( offset_object(fld_object,offset);
                      copy_object_info{from=p,to=fld_object};
                      doit(valOf size,fld_lst,pl)
                    )
                  | doit(_,_::_,_) = raise ForeignType
                  | doit(_,_,_)    = ()
            in
                doit(0,fld_lst,object_lst)
            end
     in
         fun setStruct(obj,items) =
             case objectType(obj) of
               STRUCT_TYPE{fields, ...} =>
                  if (length fields <> length items)
                  then raise StoreAccess
                  else ( set_struct'(dup_object'(obj),fields,items);
			 set_object_currency(obj,true)
                       )
             |
                _ => raise ForeignType

	 fun setField{record=obj,field=name,data} =
	     case objectType(obj) of
	       STRUCT_TYPE{fields, ...} =>
		  let val FIELD{ctype, offset, ...} = lookup_field(fields,name)
		  in
		      if not(equalType(objectType(data),ctype))
                      then raise StoreAccess
                      else let val size   = sizeOf(ctype)
			       val offset = valOf offset
			       val obj'   = dup_object'(obj)
			   in
			       set_object_type(obj',ctype);
			       set_object_size(obj',size);
			       offset_object(obj',offset);
			       copy_object_value{from=data,to=obj'}
			   end
		  end
	     |
		_ =>  raise ForeignType
     end

     fun setUnion{union=obj,data} =
         case objectType(obj) of
           UNION_TYPE{current=variant, ...} =>
              let val VARIANT{ctype, ...} = variant
              in
                  if not(equalType(objectType(data),ctype))
                  then raise StoreAccess
                  else copy_object_value{from=data,to=obj}
              end
         |
            _ => raise ForeignType

     fun setMember{union=obj,member} =
         case objectType(obj) of
           UNION_TYPE{tag,variants,size, ...} =>
              let val current'  = lookup_variant(variants,member)
                  val union_ty' = UNION_TYPE { tag=tag,
					       variants=variants,
					       size=size,
					       current=current' }
              in
                  set_object_type(obj,union_ty')
              end
         |
            _ => raise ForeignType

     fun indexObject{array=src_pd,tgt=tgt_pd,index=idx} =
         case objectType(src_pd) of
           ARRAY_TYPE{length,ctype, ...} =>
              if (0 <= idx) andalso (idx < length)
              then let val elem_size = sizeOf(ctype)
                       val base_posn = object_location(src_pd)
                       val abs_posn  = base_posn + (idx * elem_size)
                   in
                       set_object_type(tgt_pd,ctype);
                       set_object_size(tgt_pd,elem_size);          
                       move_object(tgt_pd,abs_posn);
		       set_object_currency(tgt_pd,true)
                   end
              else raise StoreAccess
         |
            _ => raise ForeignType

     fun derefObject{ptr=src_pd,tgt=tgt_pd} =
         case objectType(src_pd) of
           POINTER_TYPE{ctype, mode=RELATIVE_PTR} =>
              let val item_size = sizeOf(ctype)
                  val rel_ptr   = f_object_value(src_pd)
                  val loc_posn  = bytearray_to_int{arr=rel_ptr,st=0,len=int_size}
              in
                  set_object_type(tgt_pd,ctype);
                  set_object_size(tgt_pd,item_size);               
                  move_object(tgt_pd,loc_posn);
		  set_object_currency(tgt_pd,true)
              end
         |
           POINTER_TYPE{ctype, mode=LOCAL_PTR} =>
              let val item_size = sizeOf(ctype)
                  val loc_ptr   = f_object_value(src_pd)
                  val addr      = bytearray_to_address(loc_ptr)
                  val loc_posn  = to_location(src_pd,addr)
              in
                  set_object_type(tgt_pd,ctype);
                  set_object_size(tgt_pd,item_size);               
                  move_object(tgt_pd,loc_posn);
		  set_object_currency(tgt_pd,true)
              end
         |
           POINTER_TYPE{ctype, mode=REMOTE_PTR} =>
              let val item_size = sizeOf(ctype)
                  val far_ptr   = f_object_value(src_pd)
                  val addr      = bytearray_to_word32{arr=far_ptr,st=0}
              in
                  set_object_type(tgt_pd,ctype);
                  set_object_size(tgt_pd,item_size);               
                  examine_object(tgt_pd,addr)
              end
         |
            _ => raise ForeignType

     fun selectObject{record=src_pd,tgt=tgt_pd,field=name} =
	 case objectType(src_pd) of
	   STRUCT_TYPE{fields, ...} =>
	     let val field     =  lookup_field(fields,name)
		 val FIELD{offset,ctype, ...}  =  field
		 val obj_size  =  sizeOf(ctype)
		 val fld_posn  =  valOf offset
                 val src_posn  =  object_location(src_pd)
                 val abs_posn  =  fld_posn + src_posn
	     in
		 set_object_type(tgt_pd,ctype);
		 set_object_size(tgt_pd,obj_size);
		 move_object(tgt_pd,abs_posn);
		 set_object_currency(tgt_pd,true)
	     end
	 |
	    _ => raise ForeignType

     fun coerceObject{union=src_pd,tgt=tgt_pd} =
         case objectType(src_pd) of
           UNION_TYPE{current=variant, ...} =>
              let val VARIANT{ctype, ...} = variant
                  val new_size = sizeOf(ctype)
              in
                  set_object_type(tgt_pd,ctype);
                  set_object_size(tgt_pd,new_size);
		  set_object_currency(tgt_pd,objectCurrency(src_pd))
              end
         |
            _ => raise ForeignType


     fun copyIndexObject(obj,idx) =
         let val new_object = newObject(obj)
         in
             indexObject{array=obj,tgt=new_object,index=idx};
             new_object
         end

     fun copyDerefObject(obj) =
         let val new_object = newObject(obj)
         in
             derefObject{ptr=obj,tgt=new_object};
             new_object
         end

     fun copySelectObject(obj,name) =
         let val new_object = newObject(obj)
         in
             selectObject{record=obj,tgt=new_object,field=name};
             new_object
         end

     fun copyCoerceObject(obj) =
         let val new_object = newObject(obj)
         in
             coerceObject{union=obj,tgt=new_object};
             new_object
         end

     fun setAddr {obj,addr} =
         let val object_addr = get_word32'(addr)
         in
             set_object_address'(obj,object_addr);
	     set_object_currency(obj,true)
         end

     local

        fun set_addr(ptr_object,addr_object) =
            if object_size(addr_object) = object_size(ptr_object)
            then copy_object_value'{from=addr_object,to=ptr_object}
            else raise StoreAccess

        fun set_addr_of(ptr_object,val_object) =
            let val addr = object_address(val_object)
                val ba   = address_to_bytearray(addr)
            in
                set_object_value(ptr_object,ba,0)
            end

     in

       fun setPtrAddr{ptr=ptr_object,addr=addr_object} =
            case objectType(ptr_object) of
              POINTER_TYPE{mode=LOCAL_PTR, ...}  => set_addr(ptr_object,addr_object)
            |
              POINTER_TYPE{mode=REMOTE_PTR, ...} => set_addr(ptr_object,addr_object)
            |
              _ => raise ForeignType

        fun setPtrAddrOf{ptr=ptr_object,data=val_object} =
            case objectType(ptr_object) of
              POINTER_TYPE{mode=LOCAL_PTR, ...} => set_addr_of(ptr_object,val_object)
            |
              POINTER_TYPE{mode=REMOTE_PTR, ...} => set_addr_of(ptr_object,val_object)
            |
              POINTER_TYPE{mode=RELATIVE_PTR, ...} =>
                 let val loc_posn = object_location(val_object)
                 in
                     set_int'(ptr_object,loc_posn)
                 end
            |
              _ => raise ForeignType
     end

     fun setPtrData{ptr=src_object,data=from_object} =
         let val to_object  = copyDerefObject(src_object)
         in
             copy_object_info{from=from_object,to=to_object}
         end

     fun setPtrType{ptr=src_object,data=from_object} =
         case objectType(src_object) of
            POINTER_TYPE{mode, ...} =>
	       let val ty       = objectType(from_object)
		   val ptr_type = POINTER_TYPE{mode=mode,ctype=ty}
		   val ptr_size = sizeOf(ptr_type)
	       in
		   set_object_type(src_object,ptr_type);
		   set_object_size(src_object,ptr_size)
	       end
          |
            _ => raise ForeignType

     fun castPtrType{ptr=src_object,ctype} =
         case objectType(src_object) of
            POINTER_TYPE{mode, ...} =>
	       let val ptr_type' = POINTER_TYPE{mode=mode,ctype=ctype}
		   val ptr_size' = sizeOf(ptr_type')
	       in
		   set_object_type(src_object,ptr_type');
		   set_object_size(src_object,ptr_size')
	       end
          |
            _ => raise ForeignType


     local
        val hi = ref 0
        val lo = ref 0

        val get_int = get_int2' (hi,lo)

        fun is_int_eq (int1,int2) =
            let val _ = get_int (int1)
                val h1 = !hi
                val l1 = !lo

                val _ = get_int (int2)
                val h2 = !hi
                val l2 = !lo
            in
                (h1 = h2) andalso (l1 = l2)
            end

        fun ptr_kind (ptr_obj) =
            case objectType (ptr_obj) of
              POINTER_TYPE {mode=LOCAL_PTR, ...}    => REMOTE_PTR
            | POINTER_TYPE {mode=REMOTE_PTR, ...}   => REMOTE_PTR
            | POINTER_TYPE {mode=RELATIVE_PTR, ...} => RELATIVE_PTR
            | _ => raise ForeignType

     in

        fun isEqPtr (ptr1,ptr2) =
            if ptr_kind(ptr1) = ptr_kind(ptr2)
            then is_int_eq (ptr1,ptr2)
            else false

        fun isNullPtr (ptr_obj) =
            case objectType (ptr_obj) of
              POINTER_TYPE {mode=RELATIVE_PTR, ...} => false
            | POINTER_TYPE (_) =>             
                 let val _ = get_int (ptr_obj)
                 in
                     (!hi = 0) andalso (!lo = 0)
                 end
            | _ => raise ForeignType

     end


     fun indexObjectLocation(obj,idx) =
         case objectType(obj) of
           ARRAY_TYPE{length,ctype, ...} =>
              if (0 <= idx) andalso (idx < length)
              then let val elem_size = sizeOf(ctype)
                       val rel_posn  = idx * elem_size
                   in
                       object_location(obj) + rel_posn
                   end
              else raise StoreAccess
         |
            _ => raise ForeignType

     fun derefObjectLocation(obj) =
         case objectType(obj) of
           POINTER_TYPE{mode=RELATIVE_PTR, ...} => get_int'(obj)
         |
           POINTER_TYPE{mode=LOCAL_PTR, ...} =>
              let val loc_ptr   = f_object_value(obj)
                  val addr      = bytearray_to_address(loc_ptr)
                  val loc_posn  = to_location(obj,addr)
              in
                  loc_posn
              end
         |
            _ => raise ForeignType

     fun selectObjectLocation(obj,name) =
         case objectType(obj) of
           STRUCT_TYPE{fields, ...} =>
             let val field = lookup_field(fields,name)
                 val FIELD{offset, ...} = field
                 val rel_posn = valOf offset
             in
                 object_location(obj) + rel_posn
             end
         |
            _ => raise ForeignType

     val coerceObjectLocation = object_location


     fun indexObjectType(obj) =
         case objectType(obj) of
           ARRAY_TYPE{ctype, ...} => ctype 
         |
            _ => raise ForeignType

     fun derefObjectType(obj) =
         case objectType(obj) of
           POINTER_TYPE{ctype, ...} => ctype
         |
            _ => raise ForeignType

     fun selectObjectType(obj,name) =
         case objectType(obj) of
           STRUCT_TYPE{fields, ...} =>
             let val FIELD{ctype, ...} = lookup_field(fields,name)
             in
                 ctype
             end
         |
            _ => raise ForeignType

     fun coerceObjectType(obj) =
         case objectType(obj) of
           UNION_TYPE{current, ...} =>
              let val VARIANT{ctype, ...} = current
              in
                  ctype
              end
         |
            _ => raise ForeignType


     fun indexObjectSize(obj)        = sizeOf(indexObjectType(obj))
     fun derefObjectSize(obj)        = sizeOf(derefObjectType(obj))
     fun selectObjectSize(obj,name)  = sizeOf(selectObjectType(obj,name))
     fun coerceObjectSize(obj)       = sizeOf(coerceObjectType(obj))

     fun nextArrayItem(obj) = offset_object(obj,object_size(obj))
     fun prevArrayItem(obj)  = offset_object(obj,~(object_size(obj)))
         

     (* Getters ... *)

     fun getUnsignedChar(obj) =
         case objectType(obj) of
           CHAR_TYPE          => get_char'(obj)
         |
           UNSIGNED_CHAR_TYPE => get_char'(obj)
         |
           _ => raise ForeignType

     val getChar = getUnsignedChar

     fun getSignedChar(obj) =
         case objectType(obj) of
           CHAR_TYPE        => get_signed_char'(obj)
         |
           SIGNED_CHAR_TYPE => get_signed_char'(obj)
         |
           _ => raise ForeignType


     fun getShort(obj) =
         case objectType(obj) of
           SHORT_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getInt(obj) =
         case objectType(obj) of
           INT_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getLong(obj) =
         case objectType(obj) of
           LONG_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getUnsignedShort(obj) =
         case objectType(obj) of
           UNSIGNED_SHORT_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getUnsigned(obj) =
         case objectType(obj) of
           UNSIGNED_INT_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getUnsignedLong(obj) =
         case objectType(obj) of
           UNSIGNED_LONG_TYPE  => get_int'(obj)
         |
           _ => raise ForeignType

     fun getWord32(obj) =
         case objectType(obj) of
           UNSIGNED_INT_TYPE  => get_word32'(obj)
         |
           _ => raise ForeignType

     fun getEnum(obj) =
         case objectType(obj) of
           ENUM_TYPE{card, ...} =>
             let val i = get_int'(obj)
             in
                if (0 <= i) andalso (i < card)
                then i
                else raise ForeignType
             end
         |
           _ => raise ForeignType

     fun getFloat(obj) =
         case objectType(obj) of
           FLOAT_TYPE  => get_real'(obj)
         |
           _ => raise ForeignType

     fun getDouble(obj) =
         case objectType(obj) of
           DOUBLE_TYPE  => get_real'(obj)
         |
           _ => raise ForeignType

     fun getLongDouble(obj) =
         case objectType(obj) of
           LONG_DOUBLE_TYPE  => get_real'(obj)
         |
           _ => raise ForeignType

     fun getString(obj) =
	 case objectType(obj) of
	   STRING_TYPE{length}  => get_string'(obj,length)
	 |
	   _ => raise ForeignType

     val getData = copyDerefObject

     fun getStruct(obj) =
         case objectType(obj) of
           STRUCT_TYPE{fields, ...} =>
             let fun doit(fld::fld_lst,pl) =
                     let val FIELD{offset,ctype, ...} = fld
                         val new_object   =  newObject obj
                         val rel_posn  =  valOf offset
                         val size      =  sizeOf ctype
                     in
                         set_object_type(new_object,ctype);
                         set_object_size(new_object,size);
                         offset_object(new_object,rel_posn);
                         doit(fld_lst,new_object::pl)
                     end
                   | doit([],object_lst) = rev object_lst
             in
                 doit(fields,[])
             end
         |
            _ => raise ForeignType

     val getField = copySelectObject

     val getUnion = copyCoerceObject

     local
         fun get_array'(obj,len,rel_offset) =
             let fun doit(k,rel_posn,pl) =
                     if (k < 0) then rev pl else
                     let val new_object = newObject(obj)
                     in
                       offset_object(new_object,rel_posn);
                       doit(k-1,rel_posn + rel_offset,new_object::pl)
                     end
             in
                doit(len-1,object_location(obj),[])
             end
     in
         fun getArray(obj) =
             case objectType(obj) of
                ARRAY_TYPE{length,ctype, ...} =>
                  let val elem_size   =  sizeOf ctype
                      val elem_object    =  dup_object'(obj)
                  in
                      set_object_type(elem_object,ctype);
                      set_object_size(elem_object,elem_size);
                      get_array'(elem_object,length,elem_size)
                  end
             |
                _ => raise ForeignType
     end

     val objectType : c_object -> c_type  =  objectType

     fun castObjectType(obj,ctype) =
       ( set_object_size(obj,sizeOf ctype);
         set_object_type(obj,ctype)
       )

     (* Diagnostic tools *)

     local

        fun str_ptr_mode(LOCAL_PTR)     = "local"
          | str_ptr_mode(RELATIVE_PTR)  = "relative"
          | str_ptr_mode(REMOTE_PTR)    = "remote"

        fun str_field_list (sep,FIELD{name=name', ...}::nml') =
	    let fun doit(FIELD{name, ...}::nml,strl) = doit(nml,name::sep::strl)
                  | doit(_,strl) = rev strl
            in
                concat (doit(nml',[name']))
            end
          | str_field_list (_,[]) = ""

        fun str_current(VARIANT{name, ...}) = name

     in

	fun cTypeInfo(VOID_TYPE)             = "VOID_TYPE" 

	  | cTypeInfo(CHAR_TYPE)             = "CHAR_TYPE"
	  | cTypeInfo(UNSIGNED_CHAR_TYPE)    = "UNSIGNED_CHAR_TYPE"
	  | cTypeInfo(SIGNED_CHAR_TYPE)      = "SIGNED_CHAR_TYPE"

	  | cTypeInfo(SHORT_TYPE)            = "SHORT_TYPE"
	  | cTypeInfo(INT_TYPE)              = "INT_TYPE"
	  | cTypeInfo(LONG_TYPE)             = "LONG_TYPE"

	  | cTypeInfo(UNSIGNED_SHORT_TYPE)   = "UNSIGNED_SHORT_TYPE"
	  | cTypeInfo(UNSIGNED_INT_TYPE)     = "UNSIGNED_INT_TYPE"
	  | cTypeInfo(UNSIGNED_LONG_TYPE)    = "UNSIGNED_LONG_TYPE"

	  | cTypeInfo(FLOAT_TYPE)            = "FLOAT_TYPE"
	  | cTypeInfo(DOUBLE_TYPE)           = "DOUBLE_TYPE"
	  | cTypeInfo(LONG_DOUBLE_TYPE)      = "LONG_DOUBLE_TYPE"

	  | cTypeInfo(STRING_TYPE{length})   = "STRING_TYPE[" ^ Int.toString length ^ "]"

	  | cTypeInfo(TYPENAME{name, ...}) = "TYPENAME[" ^ name ^ "]"

	  | cTypeInfo(FUNCTION_TYPE{source,target}) =
	    "FUNCTION_TYPE[" ^ c_type_info_list(source) ^ ";" ^ cTypeInfo(target) ^ "]"

	  | cTypeInfo(POINTER_TYPE{ctype,mode}) =
	    "POINTER_TYPE[" ^ str_ptr_mode(mode) ^ ";" ^ cTypeInfo(ctype) ^ "]"

	  | cTypeInfo(STRUCT_TYPE{tag=NONE, fields, ...}) =
	    "STRUCT_TYPE[<none>;" ^ str_field_list (",",fields) ^ "]"

	  | cTypeInfo(STRUCT_TYPE{tag=SOME(name), fields, ...}) =
	    "STRUCT_TYPE[" ^ name ^ ";" ^ str_field_list(",",fields) ^ "]"

	  | cTypeInfo(UNION_TYPE{tag=NONE, current, ...}) =
	    "UNION_TYPE[<none>;" ^ str_current(current) ^ "]"

	  | cTypeInfo(UNION_TYPE{tag=SOME(name), current, ...}) =
	    "UNION_TYPE[" ^ name ^ ";" ^ str_current(current) ^ "]"

	  | cTypeInfo(ARRAY_TYPE { length, ctype, ... }) =
            "ARRAY_TYPE[" ^ cTypeInfo(ctype) ^ "," ^ Int.toString length ^ "]"

	  | cTypeInfo(ENUM_TYPE{tag=NONE, ...}) =
	    "ENUM_TYPE[<none>]"

	  | cTypeInfo(ENUM_TYPE{tag=SOME(name), ...}) =
	    "ENUM_TYPE[" ^ name ^ "]"

        and c_type_info_list(cty::[])   = cTypeInfo(cty)
          | c_type_info_list(cty::ctyl) = cTypeInfo(cty) ^ "," ^ c_type_info_list(ctyl)
          | c_type_info_list([]) = ""

        val objectInfo = fn (object : c_object) => object_info cTypeInfo object

	val objectData         : c_object -> int list  = object_data
	val objectDataHex     : c_object -> string    = object_data_hex
	val objectDataAscii   : c_object -> string    = object_data_ascii

        fun viewObject object =
            let val { store, status, currency, mode, langtype, size, base, offset } =
                    objectInfo object

                val data = objectDataHex object
            in
	      concat [ "\n\n",
                            "   Object (", mode, ", ", status, ", ", currency, ")\n",
                            "       type      = ", langtype, "\n",
                            "       size      = ", Int.toString(size), "\n",
                (case base of
                   NONE =>  ""
                 | SOME(addr) =>
                            "       position  = " ^  word32_to_hex(addr) ^ "\n"),
                            "       offset    = ", Int.toString(offset), "\n",
                            "       data      = 0x[", data, "]\n",
                            "\n\n" ]
            end

	val dispObject = disp viewObject

     end
       

   end; (* signature C_OBJECT *)
