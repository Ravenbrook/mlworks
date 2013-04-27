(*  ==== FOREIGN INTERFACE : Top Level ====
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
 *  The top-level of the Foreign Interface.  This contains common components:
 *     Utilities,  Store,  Aliens
 *  and specific interfaces
 *
 *  Revision Log
 *  ------------
 *  $Log: foreign.sml,v $
 *  Revision 1.14  1996/10/25 12:52:15  io
 *  [Bug #1547]
 *  current naming conventions
 *
 * Revision 1.13  1996/09/20  14:49:01  io
 * [Bug #1603]
 * convert ByteArray to Internal.ByteArray
 *
 * Revision 1.12  1996/08/18  21:55:32  brianm
 * Adding pointer comparison functions ...
 *
 * Revision 1.11  1996/05/24  01:19:17  brianm
 * Beta release modifications.
 *
 * Revision 1.10  1996/04/18  17:00:01  jont
 * initbasis becomes basis
 *
 * Revision 1.9  1996/03/28  14:21:12  matthew
 * Sharing changes
 *
 * Revision 1.8  1996/03/20  15:26:27  matthew
 * Language changes -- no more open in signatures
 * /
 *
 * Revision 1.7  1995/09/10  18:42:18  brianm
 * Further modification for updates and general reorganisation.
 *
 *  Revision 1.6  1995/09/07  22:43:45  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.5  1995/07/20  17:01:31  brianm
 *  adding new_object.
 *
 *  Revision 1.4  1995/07/18  12:29:23  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.3  1995/07/07  11:09:18  brianm
 *  Adding external value support - LIB-ML.
 *
 *  Revision 1.2  1995/06/25  18:35:31  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.1  1995/05/29  18:06:34  brianm
 *  new unit
 *  Top level file defining the ForeignInterface.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__word8";

signature FOREIGN_INTERFACE =
   sig

      type 'a option = 'a option

      type word32    = Word32.word
      type address   = word32
      type bytearray = MLWorks.Internal.ByteArray.bytearray
      type name      = string
      type filename  = string

      structure Store :
      sig

	 type store

	 exception ReadOnly
	 exception WriteOnly

	 datatype store_status = LOCKED_STATUS | RD_STATUS | WR_STATUS | RDWR_STATUS 

	 val storeStatus     : store -> store_status
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
      end

      structure Object :
      sig
         type ('a) object

	 datatype object_mode = LOCAL_OBJECT | REMOTE_OBJECT
	 datatype object_status = PERMANENT_OBJECT | TEMPORARY_OBJECT

	 exception OutOfBounds
	 exception ReadOnly
	 exception WriteOnly
	 exception Currency

	 val objectStatus       : ('l_type) object -> object_status
	 val objectCurrency     : ('l_type) object -> bool
	 val objectMode         : ('l_type) object -> object_mode
	 val objectSize         : ('l_type) object -> int
	 val objectLocation     : ('l_type) object -> int
	 val objectAddress      : ('l_type) object -> address
      end;
      
      structure Aliens :
      sig

	 val ensureAliens  : unit -> unit
	 val resetAliens   : unit -> unit
	 val refreshAliens : unit -> unit

      end

      structure LibML :
      sig

	val registerExternalValue   :  string * 'a -> unit
	val   deleteExternalValue   :  string -> unit

	val         externalValues   :  unit -> string list
	val   clearExternalValues   :  unit -> unit

      end

      structure C :
      sig

	 (* C STRUCTURE *)
	 structure Structure :
	 sig

	    type c_structure

	    datatype load_mode = IMMEDIATE_LOAD | DEFERRED_LOAD

	    val loadObjectFile : filename * load_mode -> c_structure
	    val fileInfo : c_structure -> (filename * load_mode)

	    val filesLoaded : unit -> filename list
	    val symbols      : c_structure -> name list

	    datatype value_type = CODE_VALUE | VAR_VALUE | UNKNOWN_VALUE

	    val symbolInfo : c_structure * name -> value_type

	 end

	 (* C TYPE *)
	 structure Type :
	 sig

	    (* C TYPE INFORMATION *)

	    (* Pointer information may be interpreted in the following ways:
	       - LOCAL_PTR     = Machine address pointing within the associated store
	       - REMOTE_PTR    = Machine address pointing outside associated store
	       - RELATIVE_PTR  = Index value accessing location within associated store
	     *)
	    datatype pointer_kind = LOCAL_PTR | RELATIVE_PTR | REMOTE_PTR

	    (* The ML type c_type provides a representation of a C type descriptor
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

            exception UnknownTypeName of string

	    val sizeOf      : c_type -> int

	    val equalType   : c_type * c_type -> bool

	    val structType   : string * (string * c_type) list -> c_type
	    val unionType    : string * (string * c_type) list -> c_type
	    val ptrType      : c_type -> c_type
	    val typeName     : string -> c_type
	    val enumType     : string * string list -> c_type

	 end


	 (* C VALUE STRUCTURE *)
	 structure Value :
	 sig

            type store         = Store.store
            type object_mode   = Object.object_mode
            type c_type        = Type.c_type

	    type c_object

	    val object : { ctype  : c_type,
			   store  : store } -> c_object

            val setObjectMode   :  c_object * object_mode -> unit

	    val objectType       :  c_object -> c_type
	    val castObjectType  :  c_object * c_type -> unit

	    val newObject  : c_object -> c_object
	    val dupObject  : c_object -> c_object
	    val tmpObject  : c_object -> c_object

	    type c_char

	    type c_short_int
	    type c_int
	    type c_long_int

	    type c_real
	    type c_double
	    type c_long_double

	    exception ForeignType
	    exception StoreAccess

	    val setChar           : c_object * c_char -> unit
	    val setUnsignedChar  : c_object * c_char -> unit
	    val setSignedChar    : c_object * c_char -> unit

	    val setShort          : c_object * c_short_int -> unit
	    val setInt            : c_object * c_int -> unit
	    val setLong           : c_object * c_long_int -> unit

	    val setUnsignedShort : c_object * c_short_int -> unit
	    val setUnsigned       : c_object * c_int -> unit
	    val setUnsignedLong  : c_object * c_long_int -> unit

	    val setWord32         : c_object * word32 -> unit

	    val setFloat          : c_object * c_real -> unit
	    val setDouble         : c_object * c_double -> unit
	    val setLongDouble    : c_object * c_long_double -> unit

	    val setString         : c_object * string -> unit

	    val setAddr           : { obj:c_object, addr:c_object } -> unit

	    val setPtrAddr       : { ptr:c_object, addr:c_object   } -> unit
	    val setPtrAddrOf    : { ptr:c_object, data:c_object   } -> unit
            val setPtrData       : { ptr:c_object, data:c_object   } -> unit
            val setPtrType       : { ptr:c_object, data:c_object   } -> unit
            val castPtrType      : { ptr:c_object, ctype:c_type } -> unit

	    val setLocalPtr      : c_object -> unit
	    val setRelativePtr   : c_object -> unit
	    val setRemotePtr     : c_object -> unit

            val isEqPtr          : c_object * c_object -> bool
            val isNullPtr        : c_object -> bool

	    val setStruct  : c_object * (c_object list) -> unit
            val setField   : { record:c_object, field:name, data:c_object } -> unit

	    val setMember  : { union:c_object, member:name } -> unit
	    val setUnion   : { union:c_object, data:c_object } -> unit

	    val setArray   : c_object * (c_object list) * int -> unit
	    val setEnum    : c_object * int -> unit


	    (* Selectors ... *)

	    val indexObject   : { array:c_object,  tgt:c_object, index:int } -> unit
	    val derefObject   : { ptr:c_object,    tgt:c_object } -> unit
	    val selectObject  : { record:c_object, tgt:c_object, field:name } -> unit
	    val coerceObject  : { union:c_object,  tgt:c_object } -> unit

	    val copyIndexObject     : c_object * int -> c_object
	    val copyDerefObject     : c_object -> c_object
	    val copySelectObject    : c_object * name -> c_object
	    val copyCoerceObject    : c_object -> c_object

	    val indexObjectType     : c_object -> c_type
	    val derefObjectType     : c_object -> c_type
	    val selectObjectType    : c_object * name -> c_type
	    val coerceObjectType    : c_object -> c_type 

	    val indexObjectSize     : c_object -> int
	    val derefObjectSize     : c_object -> int
	    val selectObjectSize    : c_object * name -> int
	    val coerceObjectSize    : c_object -> int

	    val nextArrayItem       : c_object -> unit
	    val prevArrayItem       : c_object -> unit

	    (* Getters ... *)

	    val getChar           : c_object -> c_char
	    val getUnsignedChar  : c_object -> c_char
	    val getSignedChar    : c_object -> c_char

	    val getShort          : c_object -> c_short_int
	    val getInt            : c_object -> c_int
	    val getLong           : c_object -> c_long_int

	    val getUnsignedShort : c_object -> c_short_int
	    val getUnsigned       : c_object -> c_int
	    val getUnsignedLong  : c_object -> c_long_int

	    val getWord32         : c_object -> word32

	    val getFloat          : c_object -> c_real
	    val getDouble         : c_object -> c_double
	    val getLongDouble    : c_object -> c_long_double

	    val getString         : c_object -> string

	    val getData           : c_object -> c_object
	    (* dereference pointer *)

	    val getStruct         : c_object -> c_object list
	    (* field components of a structure *)

	    val getField          : c_object * name -> c_object
	    (* field of a structure *)

	    val getUnion          : c_object -> c_object
	    val getArray          : c_object -> c_object list

	    val getEnum           : c_object -> int
	 end


	 (* C Signature *)
	 structure Signature :
	 sig
            type c_type = Type.c_type
	    type c_signature

	    datatype c_decl =
		UNDEF_DECL
	    |
		VAR_DECL of { name : name, ctype : c_type }
	    |
		FUN_DECL of { name   : name,
			      source : c_type list,
			      target : c_type }
	    |
		TYPE_DECL of { name : name,
			       defn : c_type,
			       size : int }
	    |
		CONST_DECL of { name : name, ctype : c_type }

	    val newSignature      : unit -> c_signature

	    val lookupEntry   : c_signature -> name -> c_decl
	    val defEntry      : c_signature * c_decl -> unit
	    val removeEntry   : c_signature * name -> unit

	    val showEntries   : c_signature -> c_decl list

	    val normaliseType : c_signature -> c_type -> c_type

	    val loadHeader : filename -> c_signature
	 end

	 (* C FUNCTION *)
	 structure Function :
	 sig
 
            type c_type = Type.c_type
            type c_object = Value.c_object
            type c_structure = Structure.c_structure
            type c_signature = Signature.c_signature

	    type c_function

	    val defineForeignFun : (c_structure * c_signature) -> name -> c_function

	    val call   : c_function -> (c_object list * c_object) -> unit
	 end

         structure Diagnostic :
         sig

            type store     = Store.store
            type c_type    = Type.c_type
            type c_object  = Value.c_object

	    val cTypeInfo : c_type -> string

            val viewObject : c_object -> string
            val dispObject : c_object -> c_object

	    val objectInfo : c_object ->
		       { store     : store,
			 status    : string,
			 currency  : string,
			 mode      : string,
			 langtype  : string,
			 size      : int,
			 base      : address option,
			 offset    : int
		       }

	    val objectData         : c_object -> int list
	    val objectDataHex     : c_object -> string
	    val objectDataAscii   : c_object -> string
         end
      end (* C_INTERFACE *)

      structure Diagnostic :
      sig
        type store = Store.store

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
      end
   end; (* signature FOREIGN_INTERFACE *)
