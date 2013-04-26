(*  ==== FOREIGN INTERFACE : C FUNCTION ====
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
 *  Revision Log
 *  ------------
 *  $Log: __c_function.sml,v $
 *  Revision 1.6  1996/10/23 16:47:44  io
 *  [Bug #1547]
 *  current naming conventions
 *
 * Revision 1.5  1996/09/20  14:48:56  io
 * [Bug #1603]
 * convert ByteArray to Internal.ByteArray
 *
 * Revision 1.4  1996/05/24  01:19:14  brianm
 * Beta release modifications.
 *
 * Revision 1.8  1996/04/18  17:05:51  jont
 * initbasis becomes basis
 *
 * Revision 1.7  1996/03/20  15:12:46  matthew
 * Language revision
 *
 * Revision 1.6  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 *  Revision 1.5  1995/09/07  22:43:38  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.4  1995/07/18  12:17:13  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.3  1995/06/26  12:01:06  brianm
 *  Adding remote access, diagnostics and other facilities.
 *
 *  Revision 1.2  1995/05/04  19:30:19  brianm
 *  Removing restrictive eqtype constraints & introduce abstypes in
 *  various implementing types.
 *
 *  Revision 1.1  1995/04/25  11:29:08  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "^.basis.__list";
require "c_signature";
require "c_structure";
require "static_bytearray";
require "aliens";
require "structure";
require "object";
require "utils";

require "__static_bytearray";
require "__c_signature";
require "__c_structure";
require "__aliens";
require "__structure";
require "__object";
require "__utils";

require "c_function";


structure CFunction_ : C_FUNCTION =
  struct

    structure StaticByteArray : STATIC_BYTEARRAY    = StaticByteArray_
    structure CSignature      : C_SIGNATURE         = CSignature_
    structure CStructure      : C_STRUCTURE         = CStructure_
    structure FIAliens        : FOREIGN_ALIENS      = ForeignAliens_
    structure FIStructure     : FOREIGN_STRUCTURE   = Structure_
    structure FIObject        : FOREIGN_OBJECT      = ForeignObject_
    structure FIUtils         : FOREIGN_UTILS       = ForeignUtils_

    structure CObject       = CSignature.CObject

    open FIUtils

    structure FITypes       = FITypes
    open FITypes

    open CStructure
    open CSignature
    open CObject

 (* Internal utilities *)

    val MLWcast  =  MLWorks.Internal.Value.cast

 (* ByteArray operators *)

    structure ByteArray  =  MLWorks.Internal.ByteArray

    type static_bytearray = StaticByteArray.static_bytearray

(*
    val null_byte     =  Word8.intToWord(0)
    val static_array  =  fn sz => StaticByteArray.array(sz,null_byte)
 *)

    val static_array  =  StaticByteArray.alloc_array
    val to_bytearray  =  StaticByteArray.to_bytearray
    val address_of    =  StaticByteArray.address_of

    val module  =  fn (c_str) => FIStructure.module(to_struct c_str)

    type foreign_item    =  FIAliens.foreign_item

    val get_item_later   =  FIAliens.get_item_later
    val get_item_now     =  FIAliens.get_item_now
 
    val call_alien_code  =  FIAliens.call_alien_code

    val examine_object    =  CObject.examine_object
    val object_value      =  CObject.object_value
    val set_object_value  =  CObject.set_object_value
    val object_address    =  CObject.object_address

    val int_to_bytearray  =  FIUtils.int_to_bytearray
    val bytearray_to_int  =  FIUtils.bytearray_to_int

    val string_to_bytearray  =  FIUtils.string_to_bytearray
    val bytearray_to_string  =  FIUtils.bytearray_to_string

    val word32_to_bytearray  =  FIUtils.word32_to_bytearray
    val bytearray_to_word32  =  FIUtils.bytearray_to_word32

  (* Exported Definitions *)

    type c_structure  = CStructure.c_structure
    type c_signature  = CSignature.c_signature

    abstype c_function =
             CFUN of { source : c_type list,
                       target : c_type,
                       code   : foreign_item }
    with

       fun defineForeignFun(c_str,c_sig) =
	   let fun value_info nm = symbolInfo(c_str,nm)
	       val value_decl = lookupEntry(c_sig)

	       val f_mod = module(c_str)
	       val (_,l_mode) = fileInfo(c_str)
	       val get_item  =
		   case l_mode of
		     IMMEDIATE_LOAD =>  get_item_later
		   |
		     DEFERRED_LOAD   =>  get_item_now

	       fun get_code nm = get_item(f_mod,nm)            

	       fun get_fun (nm) = 
		   case value_info(nm) of
		     CODE_VALUE =>
		       ( case value_decl(nm) of
			   FUN_DECL{source,target, ...} =>
			      CFUN{ source = source,
				    target = target,
				    code   = get_code(nm) }
			 |
			   _ => raise Fail "code item has wrong type"
		       )
		   | UNKNOWN_VALUE => raise Fail "unrecognised name"
		   | _ => raise Fail "non code item"
	   in
	      get_fun
	   end

       local

	  val max_call_args = 32

	  fun check_types(len,ty_lst) =
	      let fun chk_ty'(ty::ty_lst,pd::pd_lst) =
		      let val pdty = objectType(pd)
		      in
			  equalType(ty,pdty)
			  andalso
			  chk_ty'(ty_lst,pd_lst)
		      end
		    | chk_ty'(_,_) = true

		  fun chk_ty(pd_lst) =
			(length pd_lst = len)
			andalso
			chk_ty'(ty_lst,pd_lst)
	      in
		  chk_ty
	      end

	  fun check_callable_type(STRING_TYPE(_)) = true
	    | check_callable_type(ARRAY_TYPE(_)) = true
	    | check_callable_type(ty) = sizeOf(ty) <= 4

	  fun check_callable_types(ty_lst) =
		(List.all check_callable_type ty_lst)
		andalso
		(length ty_lst <= max_call_args)

	  local
	     val arg_size = sizeOf(INT_TYPE)

	     val args_buffer_size = arg_size * max_call_args

	     val args_buffer   =  static_array(args_buffer_size)
	     val args_addr     =  address_of(args_buffer,0)
	     val args_buffer'  =  to_bytearray(args_buffer)

	     fun copy_object_addr(obj,i) =
		 let val addr = object_address(obj)
		 in
		     word32_to_bytearray{src=addr,arr=args_buffer',st=i}
		 end

	     fun copy_arg_data(obj,i) =
		 case objectType(obj) of
		   STRING_TYPE(_) => copy_object_addr(obj,i)
		 |
		   ARRAY_TYPE(_)  => copy_object_addr(obj,i)
		 |
		   _ => object_value(obj,args_buffer',i)

	     val result_buffer   =  static_array(arg_size)
	     val result_addr     =  address_of(result_buffer,0)

	     val result_buffer'  =  to_bytearray(result_buffer)

	     fun copy_result_object(obj) =
		 let val addr = bytearray_to_word32{arr=result_buffer',st=0}
		 in
		     examine_object(obj,addr)
		 end

	     fun copy_tgt_data(obj) =
		 case objectType(obj) of
		   STRING_TYPE(_) => copy_result_object(obj)
		 |
		   ARRAY_TYPE(_)  => copy_result_object(obj)
		 |
		   _ => set_object_value(obj,result_buffer',0)
	  in
	     fun call_code(code,arg_list,arity,tgt) =
		 let fun wrap_args(idx,pd::pd_lst) =
			 ( copy_arg_data(pd,idx);
			   wrap_args(idx+arg_size,pd_lst)
			 )
		       | wrap_args(_) = ()
		 in

		   wrap_args(0,arg_list);
		   call_alien_code(code,args_addr,arity,result_addr);
		   copy_tgt_data(tgt)
		 end
	  end
       in
	  fun call (CFUN{source,target,code}) =
	      let val ty_lst = target :: source
	      in
		  if check_callable_types(ty_lst)
		  then let val arity  = length source
			   val chk_ty = check_types(1+arity,ty_lst)

			   fun make_call(src_pdlst,tgt_pd) =
			       let val pdlst = tgt_pd :: src_pdlst
			       in
				   if chk_ty(pdlst)
				   then call_code(code,src_pdlst,arity,tgt_pd)
				   else raise Fail "runtime type failure"
			       end
		       in
			   make_call
		       end
		  else raise Fail "infeasible calling types"
	      end
       end
    end
  end;
