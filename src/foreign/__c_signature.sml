(*  ==== FOREIGN INTERFACE : C SIGNATURES ====
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
 *
 *  Revision Log
 *  ------------
 *  $Log: __c_signature.sml,v $
 *  Revision 1.4  1996/11/06 11:25:15  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.3  1996/10/25  11:12:16  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/10/18  12:31:47  brianm
 *  Fixing problems with normalise_type & size of chars ...
 *
 *  Revision 1.1  1996/05/24  01:19:14  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.4  1996/05/16  14:11:06  brianm
 * Removing dependency on Crash etc. for beta release.
 *
 * Revision 1.3  1996/04/18  16:55:45  jont
 * initbasis becomes basis
 *
 * Revision 1.2  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.1  1995/09/07  22:46:46  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:31:57  brianm
 *  new unit
 *  New file.
 *
 *)

require "^.basis.__int";

require "c_object";
require "signature";
require "types";

require "__c_object";
require "__signature";
require "__types";

require "c_signature";

structure CSignature_ : C_SIGNATURE =
  struct

    structure FISignature : FOREIGN_SIGNATURE = Signature_
    structure FITypes : FOREIGN_TYPES = ForeignTypes_
    open FITypes
      
    structure CObject = CObject_
    open CObject

    type name = CObject.name
    (* filename? *)
    type c_type = CObject.c_type

  (* Mapping *)

    type 'l_type fSignature = 'l_type FISignature.fSignature

    val extract_default  =  fn a => fn x => getOpt(x,a)

  (* Signature ENTRY *)

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

    local

       fun lookup_entry' cinfo s =
	   extract_default UNDEF_DECL (FISignature.lookupEntry (cinfo,s))

       fun normalise_type' (c_cinfo) =
	 let val lookup'  =  lookup_entry' (c_cinfo)

	       fun field_size (FIELD{size=SOME(sz), ...}, cur_offset) =
                     cur_offset + sz
		 | field_size (FIELD{ctype, ...}, cur_offset) =
		     cur_offset + sizeOf ctype

	       fun size_of_fields (flds) = foldl field_size 0 flds

	       fun variant_size (VARIANT{size=SOME(sz), ...}, cur_size) =
		     Int.max(cur_size, sz)
		 | variant_size (VARIANT{ctype, ...}, cur_size) =
		     Int.max(cur_size,sizeOf ctype)

	       fun size_of_variants (flds) = foldl variant_size 0 flds

	       fun norm_type (ty as TYPENAME{name=nm, size=NONE}) =
		      ( case lookup'(nm) of
			   TYPE_DECL{size=sz, ...} =>
			     TYPENAME{name=nm, size=SOME(sz)}
			|  UNDEF_DECL => ty
			|  _ => raise UnknownTypeName(nm)
		      )

		  | norm_type(FUNCTION_TYPE{source,target}) =
		       FUNCTION_TYPE { source=map norm_type source,
				       target=norm_type target }

		  | norm_type (POINTER_TYPE{ctype, mode}) =
		       POINTER_TYPE {ctype=norm_type(ctype), mode=mode}

		  | norm_type (STRUCT_TYPE{tag,fields,size=NONE}) =
		       let val fields' = norm_fields fields
			   val size'   = size_of_fields fields'
		       in
			   STRUCT_TYPE { tag=tag,
					 fields=fields',
					 size=SOME(size') }
		       end

		  | norm_type (UNION_TYPE{tag,variants,size=NONE,current}) =
		       let val variants' = map norm_variant variants
			   val size'     = size_of_variants variants'
			   val VARIANT{name=cur_name, ...} = current
			   val current' = lookup_variant (variants',cur_name)
		       in
			   UNION_TYPE { tag=tag,
					variants=sort_variant_list(variants'),
					size=SOME(size'),
					current=current' }
		       end

		  | norm_type (ARRAY_TYPE { length, ctype, size=NONE}) =
		       let val ctype' = norm_type ctype
			   val size'  = length * sizeOf ctype'
		       in
			   ARRAY_TYPE { length = length,
					ctype = ctype',
					size = SOME(size')
				      }
		       end

		  | norm_type (ENUM_TYPE { tag, elems, card }) =
		       ENUM_TYPE { tag=tag, elems=elems, card=length elems }

		  | norm_type (ty) = ty

	       and norm_variant (VARIANT{name,ctype,size}) =
		     let val ctype' = norm_type(ctype)
		     in 
			 VARIANT {name=name,ctype=ctype',size=SOME(sizeOf ctype')}
		     end

               and norm_fields (flds) =
   	           let val offset = ref (0)
                       fun norm_field (FIELD{name,ctype,size,padding, ...}) =
		           let val ctype'  = norm_type(ctype)
                               val size'   = sizeOf ctype'
                               val offset' = !offset
		           in 
		               offset := offset' + size';
			       FIELD { name=name,
				       ctype=ctype',
				       size=SOME(size'),
				       padding=padding,
				       offset=SOME offset' }
                           end
                  in
                      map norm_field flds   
 		  end
	   in
	       norm_type                  
	   end

       fun norm_decl cinfo =
	   let val Tnorm = normalise_type' cinfo

	       fun Dnorm (VAR_DECL {name, ctype}) =
                   VAR_DECL {name=name, ctype=Tnorm ctype}

		 | Dnorm (FUN_DECL {name, source, target}) =
		   FUN_DECL { name   = name,
			      source = map Tnorm source,
			      target = Tnorm target
			      }

		 | Dnorm (TYPE_DECL {name,defn, ...}) =
		   let val defn' = Tnorm defn
		   in
		       TYPE_DECL {name=name, defn=defn', size=sizeOf defn'}
		   end

		 | Dnorm (CONST_DECL {name, ctype}) =
		   CONST_DECL {name=name, ctype=Tnorm ctype}

                 | Dnorm (_) = UNDEF_DECL
	   in
	       Dnorm
	   end

    in

       (* C Signature operations *)

       abstype c_signature = AC of c_decl fSignature
       with

	  val newSignature : unit -> c_signature = fn () => AC (FISignature.newSignature ())
	  val lookupEntry : c_signature -> string -> c_decl =
	      fn (AC(cinfo)) => lookup_entry' (cinfo)

	  local
	     exception NameOfEntry
	  in
	     fun name_of_entry(UNDEF_DECL)             = raise NameOfEntry
	       | name_of_entry(VAR_DECL{name, ...})    = name
	       | name_of_entry(FUN_DECL{name, ...})    = name
	       | name_of_entry(TYPE_DECL{name, ...})   = name
	       | name_of_entry(CONST_DECL{name, ...})  = name
	  end

	  val defEntry    : c_signature * c_decl -> unit =
	      fn (_,UNDEF_DECL) => ()
	       | (AC(cinfo),ent) =>
		   let val str   = name_of_entry(ent)
                       val ent'  = norm_decl cinfo ent
		   in
		     FISignature.defEntry (cinfo,(str,ent'))
		   end

	  val removeEntry   : c_signature * name -> unit =
	      fn (AC(cinfo),str) => FISignature.removeEntry (cinfo,str)

	  val showEntries : c_signature -> c_decl list =
	      fn (AC(cinfo)) => map (fn (_,ent) => ent) (FISignature.showEntries cinfo)

	  local
	     exception LoadHeaderUnimplemented
	  in
	     val loadHeader : filename -> c_signature =
		 fn (_) => raise LoadHeaderUnimplemented
	  end

          val normaliseType : c_signature -> (c_type -> c_type) =
              fn (AC(cinfo)) => normalise_type' cinfo

       end
    end
  end;
