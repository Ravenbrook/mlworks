(* mir_utils.sml the signature *)
(*
$Log: mir_utils.sml,v $
Revision 1.22  1997/01/03 13:55:23  matthew
Allowing more than one tail entry points

 * Revision 1.21  1996/02/23  17:23:15  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.19  1996/01/31  15:57:51  jont
 * Add functions for saving raw 32 bit values as boxed values
 *
Revision 1.18  1995/12/20  13:02:40  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.17  1995/08/24  15:57:12  daveb
Added new types for different sizes of int, words, and reals.

Revision 1.16  1995/07/25  13:00:20  jont
Add word conversion functions

Revision 1.15  1995/02/13  13:32:49  matthew
Removed NewMap from Debugger_Types

Revision 1.14  1994/07/28  12:49:34  matthew
Simplified do_app
Added do_multi_app

Revision 1.13  1994/01/19  10:42:35  matthew
Added ConvertInt exception to MirUtils

Revision 1.13  1994/01/19  10:42:35  matthew
Added ConvertInt exception

Revision 1.12  1993/08/18  16:35:31  jont
Moved some more functions here from _mir_cg.sml

Revision 1.11  1993/07/30  12:24:25  nosa
Changed type of new_do_app for local and closure variable
inspection in the debugger;
structure Option.

Revision 1.10  1993/07/14  13:07:07  jont
Added convert_long_int

Revision 1.9  1992/12/01  11:50:22  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.8  1992/10/08  10:11:20  daveb
Formatted so that I could understand what the hell was going on!

Revision 1.7  1992/09/01  11:29:20  clive
Added switches for self call optimisation

Revision 1.6  1992/08/26  14:43:48  jont
Removed some redundant structures and sharing

Revision 1.5  1992/08/07  11:31:27  clive
Added a flag to turn off tail-call optimisation

Revision 1.4  1992/08/04  14:55:23  davidt
Added extra sharing constraints.

Revision 1.3  1992/06/29  09:19:52  clive
Added type annotation information at application points

Revision 1.2  1992/05/13  09:30:59  jont
Changed to use augmented lambda calculus, and sexpressions to avoid
duplicated append operations.

Revision 1.1  1992/04/07  19:35:10  jont
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

require "../utils/sexpr";
require "../utils/map";
require "../utils/diagnostic";
require "../lambda/auglambda";
require "mir_env";

signature MIR_UTILS = sig
  structure Sexpr : SEXPR
  structure Map : MAP
  structure Diagnostic : DIAGNOSTIC
  structure Mir_Env : MIR_ENV
  structure AugLambda : AUGLAMBDA

  sharing Mir_Env.LambdaTypes = AugLambda.LambdaTypes

  datatype reg_result =
    INT of Mir_Env.MirTypes.gp_operand |
    REAL of Mir_Env.MirTypes.fp_operand

  datatype cg_result =
    ONE of reg_result |
    LIST of reg_result list

  val cg_lvar : Mir_Env.LambdaTypes.LVar *
 		Mir_Env.Lambda_Env *
	        Mir_Env.Closure_Env *
		int ->
                (reg_result * Mir_Env.MirTypes.opcode list) * int * bool

  val cg_lvar_fn : Mir_Env.LambdaTypes.LVar *
		   Mir_Env.Lambda_Env *
		   Mir_Env.Closure_Env *
		   int ->
                   reg_result * Mir_Env.MirTypes.opcode list

  val combine : ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		  Mir_Env.MirTypes.block list *
		  Mir_Env.MirTypes.tag option *
		  Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		 ) *
		 Mir_Env.MirTypes.value list *
		 Mir_Env.MirTypes.procedure list list
		) *
		((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		  Mir_Env.MirTypes.block list *
		  Mir_Env.MirTypes.tag option *
		  Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		 ) *
		 Mir_Env.MirTypes.value list *
		 Mir_Env.MirTypes.procedure list list
		) ->
		  (Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		   Mir_Env.MirTypes.block list *
		   Mir_Env.MirTypes.tag option *
		   Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		  ) *
		  Mir_Env.MirTypes.value list *
		  Mir_Env.MirTypes.procedure list list

  val contract_sexpr : Mir_Env.MirTypes.opcode list Sexpr.Sexpr ->
  			 Mir_Env.MirTypes.opcode list

  exception ConvertInt	
  (* Raised if the literal is too large for the compiling machine. *)

  exception Unrepresentable
  (* Raised if the literal is too large for the target machine. *)

  (* The int option argument to the following functions gives the size of the target type,
     where specified by a type constraint in the source. *)
  val convert_int : string * int option -> int

  val convert_long_int :
        AugLambda.LambdaTypes.Ident.SCon * int option -> AugLambda.AugLambdaExp

  val convert_word : string * int option -> int

  val convert_long_word :
        AugLambda.LambdaTypes.Ident.SCon * int option -> AugLambda.AugLambdaExp

  val destruct_2_tuple : Mir_Env.MirTypes.gp_operand ->
			   Mir_Env.MirTypes.gp_operand *
			   Mir_Env.MirTypes.gp_operand *
			   Mir_Env.MirTypes.opcode list

  val get_any_register : reg_result -> Mir_Env.MirTypes.any_register

  val get_real : reg_result ->
    Mir_Env.MirTypes.fp_operand * Mir_Env.MirTypes.opcode list

  val get_word32 :
    reg_result ->
      Mir_Env.MirTypes.gp_operand
    * Mir_Env.MirTypes.opcode list		(* extraction code *)
    * Mir_Env.MirTypes.opcode list		(* code to clean reg *)

  val gp_from_reg : Mir_Env.MirTypes.reg_operand ->
			Mir_Env.MirTypes.gp_operand

  val list_of : int * 'a -> 'a list

  val list_of_tags : int -> Mir_Env.MirTypes.tag list

  val make_closure : 'a list *
                     Mir_Env.LambdaTypes.LVar list *
                     int *
                     int *
                     Mir_Env.Lambda_Env *
                     Mir_Env.Closure_Env *
                     int ->
                     Mir_Env.MirTypes.reg_operand *
                     Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
                     Mir_Env.Closure_Env list

  val do_app : Mir_Env.MirTypes.Debugger_Types.Backend_Annotation *
		 cg_result *
		 ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		   Mir_Env.MirTypes.block list *
		   Mir_Env.MirTypes.tag option *
		   Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		  ) *
		  Mir_Env.MirTypes.value list *
		  Mir_Env.MirTypes.procedure list list
		 ) *
		 cg_result *
		 ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		   Mir_Env.MirTypes.block list *
		   Mir_Env.MirTypes.tag option *
		   Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		  ) *
		  Mir_Env.MirTypes.value list *
		  Mir_Env.MirTypes.procedure list list
		 ) ->
		   cg_result *
		   ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		     Mir_Env.MirTypes.block list *
		     Mir_Env.MirTypes.tag option *
		     Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		    ) *
		    Mir_Env.MirTypes.value list *
		    Mir_Env.MirTypes.procedure list list
		   )

  datatype CallType = 
    LOCAL of Mir_Env.MirTypes.tag * Mir_Env.MirTypes.GC.T list * Mir_Env.MirTypes.FP.T list
  | SAMESET of int (* position in closure *)
  | EXTERNAL

  val do_multi_app : Mir_Env.MirTypes.Debugger_Types.Backend_Annotation *
		     cg_result *
		     ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		       Mir_Env.MirTypes.block list *
		       Mir_Env.MirTypes.tag option *
		       Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		      ) *
		      Mir_Env.MirTypes.value list *
		      Mir_Env.MirTypes.procedure list list
		     ) *
		     cg_result *
		     ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		       Mir_Env.MirTypes.block list *
		       Mir_Env.MirTypes.tag option *
		       Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		      ) *
		      Mir_Env.MirTypes.value list *
		      Mir_Env.MirTypes.procedure list list
		     ) *
		     cg_result *
		     ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		       Mir_Env.MirTypes.block list *
		       Mir_Env.MirTypes.tag option *
		       Mir_Env.MirTypes.opcode list Sexpr.Sexpr
		      ) *
		      Mir_Env.MirTypes.value list *
		      Mir_Env.MirTypes.procedure list list
		     ) *
                     CallType *
		     int *
		     Mir_Env.MirTypes.tag list *
		     bool ->
		       cg_result *
		       ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		         Mir_Env.MirTypes.block list *
			 Mir_Env.MirTypes.tag option *
			 Mir_Env.MirTypes.opcode list Sexpr.Sexpr
			) *
			Mir_Env.MirTypes.value list *
			Mir_Env.MirTypes.procedure list list
		       ) *
		       ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		         Mir_Env.MirTypes.block list *
			 Mir_Env.MirTypes.tag option *
			 Mir_Env.MirTypes.opcode list Sexpr.Sexpr
			) *
			Mir_Env.MirTypes.value list *
			Mir_Env.MirTypes.procedure list list
		       ) *
		       ((Mir_Env.MirTypes.opcode list Sexpr.Sexpr *
		         Mir_Env.MirTypes.block list *
			 Mir_Env.MirTypes.tag option *
			 Mir_Env.MirTypes.opcode list Sexpr.Sexpr
			) *
			Mir_Env.MirTypes.value list *
			Mir_Env.MirTypes.procedure list list
		       )

    val reg_from_gp : Mir_Env.MirTypes.gp_operand ->
			Mir_Env.MirTypes.reg_operand

    val send_to_given_reg : cg_result * Mir_Env.MirTypes.GC.T ->
			      Mir_Env.MirTypes.opcode list

    val send_to_new_reg : cg_result ->
			    Mir_Env.MirTypes.gp_operand *
			    Mir_Env.MirTypes.opcode list

    val send_to_reg : cg_result ->
			Mir_Env.MirTypes.gp_operand *
			Mir_Env.MirTypes.opcode list

    val save_real_to_reg : Mir_Env.MirTypes.fp_operand *
			   Mir_Env.MirTypes.reg_operand ->
			     Mir_Env.MirTypes.opcode list

    val save_word32 : Mir_Env.MirTypes.GC.T ->
      Mir_Env.MirTypes.GC.T * Mir_Env.MirTypes.opcode list

    val save_word32_in_reg : Mir_Env.MirTypes.GC.T * Mir_Env.MirTypes.GC.T ->
      Mir_Env.MirTypes.opcode list

    val tuple_up : reg_result list ->
		     Mir_Env.MirTypes.GC.T * Mir_Env.MirTypes.opcode list

    val tuple_up_in_reg : reg_result list * Mir_Env.MirTypes.GC.T ->
			    Mir_Env.MirTypes.GC.T *
			    Mir_Env.MirTypes.opcode list

    val get_string : {lexp:AugLambda.AugLambdaExp, size:int} -> 
      string Mir_Env.LambdaTypes.Set.Set

    val lift_externals :
      ((string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map) *
      {lexp:AugLambda.AugLambdaExp, size:int} ->
      ((string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map *
       (string, Mir_Env.LambdaTypes.LVar) Map.map) *
      {lexp:AugLambda.AugLambdaExp, size:int}

    val transform_needed :
      bool * {lexp:AugLambda.AugLambdaExp, size:int} -> bool

    val needs_prim_stringeq : AugLambda.AugLambdaExp -> bool

end
