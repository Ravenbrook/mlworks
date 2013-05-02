(* _control_unify.sml the functor *)
(*
$Log: _control_unify.sml,v $
Revision 1.34  1997/04/22 14:09:20  andreww
[bug #1563]
altering error message for when two explicit type vars don't match

 * Revision 1.33  1996/11/06  11:33:10  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.32  1996/08/05  16:29:44  andreww
 * [Bug #1521]
 * Propagating changes made to _test.sml --- essentially these
 * require passing "use_value_polymorphism" in the correct places.
 *
 * Revision 1.31  1996/04/29  14:02:59  matthew
 * Removing MLWorks.Integer.
 *
 * Revision 1.30  1996/04/15  12:19:34  matthew
 * Improving RECORD_DOMAIN error
 *
Revision 1.29  1995/09/06  14:14:43  jont
Modify messages about "equality required by T" to
"T does not admit equality"

Revision 1.28  1995/07/28  10:05:11  jont
Add handling for word_literal_tyvar

Revision 1.27  1995/05/11  15:25:35  matthew
Improving record domain error messages

Revision 1.26  1995/02/17  12:50:28  daveb
Improved printing of overloaded type variables.

Revision 1.25  1995/02/02  14:59:24  matthew
cout -s control_unify.sml
Rationalizations

Revision 1.24  1994/05/13  15:48:49  daveb
Added space to overloading error message.

Revision 1.23  1994/05/12  13:43:52  daveb
Changed previous log message.

Revision 1.22  1994/05/04  16:47:42  daveb
The error message for the overloaded case now prints the type variable.

Revision 1.21  1993/12/17  15:49:03  matthew
Added message for record domain mismatches where records are tuples.
,

Revision 1.20  1993/12/03  16:24:48  nickh
Removed TYNAME case (redundant), changed error texts.

Revision 1.19  1993/11/30  14:41:34  nickh
Marked certain error messages as "impossible".

Revision 1.18  1993/11/25  15:36:21  nosa
Modified unified to be optionally side-effect free, returning substitutions.

Revision 1.17  1993/11/24  16:17:17  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.16  1993/04/01  16:51:39  jont
Allowed overloadin on strings to be controlled by an option

Revision 1.15  1993/03/12  18:55:08  matthew
Changed error message for record mismatch

Revision 1.14  1993/03/10  15:21:16  matthew
Options changes

Revision 1.13  1993/03/04  11:07:27  matthew
Options & Info changes

Revision 1.11  1993/02/22  15:54:46  matthew
Removed Types structure
Changed Completion interface

Revision 1.10  1993/02/08  18:36:11  matthew
Changes for BASISTYPES signature

Revision 1.9  1992/12/04  12:51:28  matthew
Error message revision

Revision 1.8  1992/11/26  17:19:39  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.7  1992/11/04  17:26:13  matthew
Changed Error structure to Info

Revision 1.6  1992/09/04  08:47:02  richard
Installed central error reporting mechanism.

Revision 1.5  1992/08/12  10:23:37  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.4  1992/07/16  12:43:47  jont
Fixed printing of records so it didn't come out backwards

Revision 1.3  1992/06/26  14:26:40  jont
Fixed string_domain to deal with unit

Revision 1.2  1991/11/21  16:44:48  jont
Added copyright message

Revision 1.1  91/06/07  11:35:03  colin
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../basis/__int";

require "../utils/crash";
require "../utils/lists";
require "../basics/identprint";
require "../main/info";
require "types";
require "unify";
require "completion";
require "basis";

require "control_unify";

(****
 In this version of control_unify all calls to the type_debugger 
 has been replaced with calls to the error handling structure.
****)

functor Control_Unify
  (structure Crash : CRASH
   structure Lists : LISTS
   structure IdentPrint : IDENTPRINT
   structure Types : TYPES
   structure Unify : UNIFY
   structure Completion : COMPLETION
   structure Basis : BASIS
    structure Info : INFO

   sharing Completion.Options = IdentPrint.Options
   sharing Basis.BasisTypes.Datatypes = Unify.Datatypes = Completion.Datatypes = Types.Datatypes
   sharing IdentPrint.Ident = Basis.BasisTypes.Datatypes.Ident
   sharing type IdentPrint.Options.options = Unify.options
     ) : CONTROL_UNIFY = 

struct
  structure Info = Info
  structure BasisTypes = Basis.BasisTypes
  structure Datatypes = BasisTypes.Datatypes
  structure Options = IdentPrint.Options
  structure Ident = IdentPrint.Ident
  structure Symbol = Ident.Symbol

  (*****
  These functions call unification and analyse the result.
  *****)

  local
    (* these two functions are identical to the functions in _scheme *)
    fun string_labels [] = ""
      | string_labels [(label,_)] = (IdentPrint.printLab label)
      | string_labels ((label,_)::labels) = 
        (IdentPrint.printLab label) ^ ", " ^ (string_labels labels)

    fun string_domain (Unify.RIGID record) = 
      "{" ^ string_labels record ^ "}"
      | string_domain (Unify.FLEX record) = 
        case record of
          [] => "{...}"
        | _ => "{" ^ (string_labels record) ^ ", ...}"

    fun to_type (Unify.RIGID record) =
      let
        val ty = 
          Lists.reducel 
          (fn (t,(lab,t')) => Types.add_to_rectype (lab,t',t))
          (Types.empty_rectype,record)
      in
        ty
      end

      | to_type (Unify.FLEX record) =
        let
          val ty = 
            Lists.reducel 
            (fn (t,(lab,t')) => Types.add_to_rectype (lab,t',t))
            (Types.empty_rectype,record)
        in
         Datatypes.METARECTYPE (ref (0,false,ty,false, false))
        end

    fun is_tuple_domain (Unify.RIGID record) =
      let
        val lablist = map #1 record
        val len = Lists.length lablist
        fun check n = 
          if n > len then true
          else
            Lists.member (Ident.LAB (Symbol.find_symbol (Int.toString n)),lablist)
            andalso
            check (n+1)
      in
        check 1
      end
      | is_tuple_domain _ = false

    fun describe (Unify.FAILED (ty,ty')) =
      [Datatypes.Err_String "\n    Type clash between\n      ",
       Datatypes.Err_Type ty,
       Datatypes.Err_String "\n    and\n      ",
       Datatypes.Err_Type ty']
      
      | describe (Unify.RECORD_DOMAIN (domain,domain')) =
        if is_tuple_domain domain andalso is_tuple_domain domain'
          then
            [Datatypes.Err_String "\n    Lengths of tuples differ:\n      ",
             Datatypes.Err_Type (to_type domain),
             Datatypes.Err_String "\n    and\n      ",  
             Datatypes.Err_Type (to_type domain')]
        else
          [Datatypes.Err_String "\n    Domains of record types differ:\n      ",
           Datatypes.Err_String (string_domain domain),
           Datatypes.Err_String "\n    and\n      ",
           Datatypes.Err_String (string_domain domain')]
	
      | describe (Unify.EXPLICIT_TYVAR (ty,ty')) =
            [Datatypes.Err_String "\n     because the type variable ",
             Datatypes.Err_Type ty,
             Datatypes.Err_String " of the first type",
             Datatypes.Err_String " has a different scope from",
             Datatypes.Err_String "\n     the type variable ",
             Datatypes.Err_Type ty',
             Datatypes.Err_String " of the second type.",
             Datatypes.Err_String 
                 "\n        (One of them probably cannot be generalized.) "]

	
      | describe (Unify.EQ_AND_IMP (eq,imp,ty)) =
	[Datatypes.Err_String "\n    ",
	 Datatypes.Err_Type ty,
	 Datatypes.Err_String (case (eq, imp) of
				 (true, false) => " does not admit equality"
			       | (true, true) => " does not admit equality and is not imperative"
			       | (false, true) => " is not imperative"
			       | _ => Crash.impossible "Control_Unify.describe EQ_AND_IMP")]
	
      | describe (Unify.CIRCULARITY (ty,ty')) =
	[Datatypes.Err_String "\n    Circular type results from unifying\n      ",
	 Datatypes.Err_Type ty,
	 Datatypes.Err_String "\n    and\n      ",
	 Datatypes.Err_Type ty']
	
      | describe (Unify.OVERLOADED (tv, ty)) =
	let
	  (* If the overloaded tyvar has a default type, we report the
	     tyvar as if it were that type.  This produces clearer error
	     messages for examples such as 2 + 3.0. *)

	  val has_default =
	    (tv = Ident.real_literal_tyvar) orelse
	    (tv = Ident.int_literal_tyvar) orelse
	    (tv = Ident.word_literal_tyvar)

	  val initial_string =
	    if has_default then
	      "\n    Type clash between "
	    else
	      "\n    Type clash between overloaded type variable "
	in
	  [Datatypes.Err_String
	     (initial_string
	      ^ IdentPrint.printTyVar tv
	      ^ " and "), 
	   Datatypes.Err_Type ty]
	end
	
      | describe Unify.OK = Crash.impossible "ControlUnify.generate_message"
      | describe (Unify.SUBSTITUTION _) = Crash.impossible "SUBSTITUTION:ControlUnify.generate_message"
  in
    fun unify
      (error_info,options as Options.OPTIONS{print_options,...})
      {
       first  : Datatypes.Type,
       second : Datatypes.Type,
       result : Datatypes.Type,
       context : BasisTypes.Context,
       error : unit -> Info.Location.T * Datatypes.type_error_atom list * Datatypes.Type
      } =
      
      case Unify.unified(options, first, second, false) of
	Unify.OK => result
      | error_code =>
          let
            val (location, err_list, result) = error ()
	    val unify_err_list = describe error_code
	    val report =
	      Completion.report_type_error
	      (options, Basis.env_of_context context,
	       err_list@unify_err_list)
          in
            (Info.error error_info
	     (Info.RECOVERABLE, location, report);
	     result)
          end
  end
end
