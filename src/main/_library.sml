(*  ==== PERVASIVE LIBRARY UTILITIES ====
 *                FUNCTOR
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
 *  See individual function comments for documentation.
 *
 *  Revision Log
 *  ------------
 *  $Log: _library.sml,v $
 *  Revision 1.58  1998/01/30 09:45:02  johnh
 *  [Bug #30326]
 *  Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.57.2.2  1997/11/20  17:01:13  daveb
 * [Bug #30326]
 *
 * Revision 1.57.2.1  1997/09/11  20:56:58  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.57  1997/05/12  16:01:27  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.56  1997/01/21  11:52:38  matthew
 * Adding Options
 *
 * Revision 1.55  1996/12/04  16:56:18  matthew
 * Simplifications
 *
 * Revision 1.54  1996/10/10  02:42:17  io
 * moving String from toplevel
 *
 * Revision 1.53  1996/02/23  16:19:00  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.52  1995/08/11  17:09:05  daveb
 * Added new types for different sizes of ints, words, and reals.
 *
 *  Revision 1.51  1995/02/28  14:08:59  matthew
 *  Changes to DebuggerTypes.
 *
 *  Revision 1.50  1994/10/10  10:13:39  matthew
 *  Adding module annotations to lambda syntax.
 *
 *  Revision 1.49  1994/09/19  13:43:24  matthew
 *  Changes to lambdatypes
 *
 *  Revision 1.48  1994/09/09  17:11:58  jont
 *  Machine specific functions is_fun and implicit_references moved to machperv
 *
 *  Revision 1.47  1994/07/19  15:10:38  matthew
 *  Multiple args for functions and applications
 *
 *  Revision 1.46  1993/12/17  15:23:12  io
 *  Changed some require paths
 *
 *  Revision 1.45  1993/08/12  12:14:01  nosa
 *  FNs now passed closed-over type variables and
 *  stack frame-offset for runtime-instance for polymorphic debugger.
 *
 *  Revision 1.44  1993/07/29  16:27:44  nosa
 *  structure Option.
 *
 *  Revision 1.43  1993/03/10  17:07:03  matthew
 *  Signature revisions
 *
 *  Revision 1.42  1993/03/01  15:11:35  matthew
 *  Added MLVALUE lambda exp
 *
 *  Revision 1.41  1993/01/14  14:43:20  daveb
 *  Changed explicit manipulation of list representation to use new format.
 *
 *  Revision 1.40  1992/11/21  19:21:51  jont
 *  Replaced MachSpec with MachPerv
 *
 *  Revision 1.39  1992/10/26  18:20:23  daveb
 *  Minor changes to support the new type of SWITCHes.
 *
 *  Revision 1.38  1992/09/24  11:48:19  jont
 *  removed some redundant bindings
 *
 *  Revision 1.37  1992/09/03  16:40:02  richard
 *  Moved the special names out of the compiler as a whole.
 *
 *  Revision 1.36  1992/08/26  13:46:53  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.35  1992/08/19  18:37:21  davidt
 *  Now uses NewMap instead of Map.
 *
 *  Revision 1.34  1992/08/03  13:07:57  davidt
 *  Type of BUILTIN changed a little.
 *
 *  Revision 1.33  1992/07/17  14:38:30  clive
 *  null_type_annotation no longer a function
 *
 *  Revision 1.32  1992/07/01  13:42:12  davida
 *  Added LET constructor and new slot to APP.
 *
 *  Revision 1.31  1992/06/29  09:33:43  clive
 *  Added type annotation information at application points
 *
 *  Revision 1.30  1992/06/23  10:10:34  clive
 *  Added an annotation slot to HANDLE
 *
 *  Revision 1.29  1992/06/11  09:46:29  clive
 *  Made changes as LET now has a string annotation
 *
 *  Revision 1.28  1992/06/08  12:57:52  jont
 *  changed to produce lists as compilation units instead of tuples
 *
 *  Revision 1.27  1992/05/06  11:45:51  jont
 *  Modified to use augmented lambda calculus
 *
 *  Revision 1.26  1992/04/13  15:28:33  clive
 *  First version of the profiler
 *
 *  Revision 1.25  1992/02/11  11:07:19  clive
 *  New pervasive library code
 *
 *  Revision 1.24  1992/02/03  20:09:39  jont
 *  Made sure eta abstraction on builtins occurs even when there are
 *  no external references
 *
 *  Revision 1.23  1992/01/09  14:50:02  richard
 *  Removed extra set of lambda bindings wrapped around expression in
 *  build_external_environment.
 *
 *  Revision 1.22  1991/12/10  13:49:41  richard
 *  Fixed bug whereby the switch expression was not analysed for
 *  external references.
 *
 *  Revision 1.21  91/12/09  12:17:28  richard
 *  Removed redundant `.mo' extension from the name of the pervasive
 *  library.
 *  
 *  Revision 1.20  91/12/04  15:00:04  richard
 *  Added an extra SELECT operation on the pervasive library so
 *  that this can be a structure rather than a set of top-level
 *  declarations.  This means it gets sorted correctly by the
 *  compiler.
 *  
 *  Revision 1.19  91/11/28  16:33:37  richard
 *  Completely reimplemented this module, tidied it up, and documented it.
 *  The functions provided have changed quite a bit.
 *  
 *  Revision 1.18  91/11/18  15:08:03  jont
 *  Fixed builtin_implicit_set so as to know about builtins which will be
 *  eta_abstracted. Also tidied up remnants of old CALL_C stuff.
 *  
 *  Revision 1.17  91/11/15  14:13:57  richard
 *  Changed the ordering on pervasive symbols to work on the library names
 *  rather than on the printing names.
 *  
 *  Revision 1.16  91/11/14  17:08:10  jont
 *  Eta abstracted builtin functions where they aren't applied so they
 *  can be inline generated. Required by Pervasives
 *  
 *  Revision 1.15  91/11/12  16:57:09  jont
 *  Moved is_inline function out into MachPerv, which knows the real answers
 *  
 *  Revision 1.14  91/10/29  14:57:35  jont
 *  Added reference to existence of machine level div, mod, * for determining
 *  whether to inline various primitives
 *  
 *  Revision 1.13  91/10/22  18:27:34  davidt
 *  The structure LambdaSub.LambdaTypes is now called LambdaSub.LT
 *  
 *  Revision 1.12  91/10/22  16:53:23  davidt
 *  Replaced impossible exception with call to Crash.impossible.
 *  
 *  Revision 1.11  91/10/16  16:19:01  jont
 *  Added CALL_C to result of prims_in_le
 *  
 *  Revision 1.10  91/10/15  13:59:29  jont
 *  Added stuff to do with CALL_C required for garbage collection.
 *  
 *  Revision 1.9  91/10/09  15:20:30  davidt
 *  Made changes due to record selection now requiring both the total
 *  size of the record as well as the index.
 *  
 *  Revision 1.8  91/10/08  11:50:01  jont
 *  Changed use of lambdasub.number_from to lists.number_from_by_one
 *  
 *  Revision 1.7  91/09/24  15:41:14  jont
 *  Fixed bug whereby chr -> Chr and ord -> Ord correspondences were left
 *  out. Alos corrected exception raised by mod
 *  
 *  Revision 1.6  91/09/24  13:01:33  davida
 *  Fixed bug in add_pervasive_refs function.
 *  
 *  Revision 1.5  91/09/23  12:30:08  jont
 *  Added stuff to deal with implicit exceptions (eg from ADDV)
 *  
 *  Revision 1.4  91/09/18  11:29:30  jont
 *  Fixed bug whereby builtin exceptions weren't visible
 *  
 *  Revision 1.3  91/09/16  16:43:40  jont
 *  Corrected spelling of _make_new_unique
 *  
 *  Revision 1.2  91/09/09  13:34:15  davida
 *  Changed to use reduce_left from Lists, not LambdaSub.
 *  
 *  Revision 1.1  91/09/05  11:00:38  jont
 *  Initial revision
 *)

require "../utils/diagnostic";
require "../utils/lists";
require "../utils/crash";
require "../utils/map";
require "../lambda/auglambda";
require "../lambda/lambdaprint";
require "machperv";
require "mlworks_io";

require "library";

functor Library(
  structure Diagnostic  : DIAGNOSTIC
  structure Lists       : LISTS
  structure Crash       : CRASH
  structure NewMap      : MAP
  structure AugLambda   : AUGLAMBDA
  structure LambdaPrint	: LAMBDAPRINT
  structure MachPerv    : MACHPERV
  structure Io		: MLWORKS_IO

  sharing LambdaPrint.LambdaTypes = AugLambda.LambdaTypes
  sharing type MachPerv.Pervasives.pervasive = LambdaPrint.LambdaTypes.Primitive
    ) : LIBRARY =
  struct
    structure Pervasives = MachPerv.Pervasives
    structure LambdaTypes = LambdaPrint.LambdaTypes
    structure NewMap = NewMap
    structure Set = LambdaTypes.Set
    structure AugLambda = AugLambda
    structure Ident = LambdaTypes.Ident

    type CompilerOptions = MachPerv.CompilerOptions

    (*  == Change references to BUILTINs to lambda variables ==
     *
     *  Given a lambda expression and a map from pervasives to lambda
     *  variables, this function generates a new lambda expression with all
     *  references to pervasives in the map converted to lambda variables,
     *  EXCEPT if the pervasive is in line and not applied, in which case an
     *  eta-abstraction is built around it.
     *
     *  For example, BUILTIN _int+  --->  \x.APP(BUILTIN _int+, x)
     *)

    (* This shouldn't really be needed *)
    (*  Eta-abstraction over some expression. *)
    (*  Generates a new lambda-variable. *)

    fun eta_abstract (le,annotation,ty) =
      let
        val lvar = LambdaTypes.new_LVar()
      in
        LambdaTypes.FN (([lvar],[]),
                        LambdaTypes.APP (le, ([LambdaTypes.VAR lvar],[]), SOME(ty)), 
                        LambdaTypes.BODY, 
                        annotation,
                        LambdaTypes.null_type_annotation,
                        LambdaTypes.internal_funinfo)
      end

    (* Moved here from lambdasub as this was its only use *)
    (* could certainly be simplified somewhat *)
  fun apply_one_level appsub = 
    let 
      fun apopt f (SOME x) = SOME (f x)
        | apopt _ NONE     = NONE
      fun apply_tagval (LambdaTypes.EXP_TAG tagexp, value) =
        (LambdaTypes.EXP_TAG (appsub tagexp), appsub value)
        | apply_tagval (tagexp, value) =
          (tagexp, appsub value)

      fun apply (le as LambdaTypes.VAR _) = le
        | apply (LambdaTypes.FN(args, le, status, x,ty,instance)) =
        LambdaTypes.FN (args, appsub le,status, x,ty,instance) 
        | apply (LambdaTypes.LET((lv,info,lb),le)) =
        LambdaTypes.LET((lv,info,appsub lb),appsub le)
        | apply (LambdaTypes.LETREC(lvl, lel, le)) =
          LambdaTypes.LETREC (lvl, map appsub lel, appsub le)
        | apply (LambdaTypes.APP(p, (q,r), annotation)) = 
          LambdaTypes.APP(appsub p, (map appsub q, map appsub r), annotation)
        | apply (le as LambdaTypes.SCON _) = le
        | apply (le as LambdaTypes.MLVALUE _) = le
        | apply (le as LambdaTypes.INT _) = le
        | apply (LambdaTypes.SWITCH(le, info, clel, leo)) = 
          LambdaTypes.SWITCH
          (appsub le,
           info,
           map apply_tagval clel,
           apopt appsub leo)
        | apply (LambdaTypes.STRUCT (lel,ty)) = LambdaTypes.STRUCT (map appsub lel,ty)
        | apply (LambdaTypes.SELECT (fld, le)) = LambdaTypes.SELECT (fld, appsub le)
        | apply (LambdaTypes.RAISE (le)) = LambdaTypes.RAISE (appsub le)
        | apply (LambdaTypes.HANDLE (le1, le2,annotation)) = LambdaTypes.HANDLE (appsub le1, 
                                                                                 appsub le2,
                                                                                 annotation)
        | apply (le as LambdaTypes.BUILTIN _) = le
    in
      apply
    end

   fun externalise (options,expression, extern_map) =
      let
	open LambdaTypes

	fun externalise' (APP (BUILTIN pervasive, (el,fpel), ty)) =
          if MachPerv.is_inline (options,pervasive) then
            APP (BUILTIN pervasive, (map externalise' el, map externalise' fpel), ty)
          else
            APP (VAR (NewMap.apply'(extern_map, pervasive)), 
                 (map externalise' el, map externalise' fpel),
                 ty)

	  | externalise' (expression as BUILTIN pervasive) =
	    if (MachPerv.is_inline (options, pervasive) andalso 
                MachPerv.is_fun pervasive) then
	      externalise' (eta_abstract 
                            (expression,"Builtin function " ^ Pervasives.print_pervasive pervasive,
                             ref null_type_annotation))
	    else
	      VAR (NewMap.apply'(extern_map, pervasive))
	  | externalise' expression =
	    apply_one_level externalise' expression
      in
	externalise' expression
      end

    (*  === EXTRACT ALL EXTERNAL REFERENCES ===
     *
     *  The following rules are applied:
     *
     *    APP(BUILTIN pervasive, ...)  -->  pervasive if not inline
     *                                      implicits if inline
     *    BUILTIN pervasive  -->  pervasive if not inline
     *                            pervasive if not a function
     *                            implicits if inline and a function
     *    SWITCH on string  -->  STRING_EQ pervasive and its implicits
     *
     *  In the first case the pervasive is known to be a function, so the
     *  function test is not required.  Non-functions cannot make implicit
     *  references.
     *)

    fun external_references (options, expression) =
      let
	open LambdaTypes

	fun find (done, APP (BUILTIN pervasive, (el,fpel), ty)) =
	    if MachPerv.is_inline (options,pervasive) then
	      Lists.reducel find ((MachPerv.implicit_references pervasive) @ done,
                                  (fpel @ el))
	    else
	      Lists.reducel find (pervasive :: done, fpel @ el)

	  | find (done, BUILTIN pervasive) =
	    if (MachPerv.is_inline (options, pervasive) andalso
		MachPerv.is_fun pervasive) then
	      (MachPerv.implicit_references pervasive) @ done
	    else
	      pervasive :: done

	  | find (done, SWITCH (expression, info, cases, default)) =
	    let

	      fun find_case (done, (EXP_TAG expression, expression')) =
		  find (find (done, expression), expression')

		| find_case (done, (SCON_TAG (Ident.STRING _, _), expression')) =
		  let
		    val references =
		      Pervasives.STRINGEQ ::
		      (MachPerv.implicit_references Pervasives.STRINGEQ)
		  in
		    find (references @ done, expression')
		  end

		| find_case (done, (_, expression')) =
		  find (done, expression')

	      fun find_option (done, SOME expression) =
		  find (done, expression)

		| find_option (done, NONE) = done
	    in
	      Lists.reducel find_case
	      (find_option (find (done, expression), default), cases)
	    end

	  | find (done, VAR _) = done
	  | find (done, FN (_, expression,_,_,_,_)) = find (done, expression)
	  | find (done, LET ((_,_, binding),expression)) = 
	    find (find (done,binding), expression)
	  | find (done, APP (expression, (el,fpel), _)) =
	    Lists.reducel find (find (done, expression), fpel @ el)
	  | find (done, SCON _) = done
	  | find (done, MLVALUE _) = done
	  | find (done, INT _) = done
	  | find (done, SELECT (_, expression)) = find (done, expression)
	  | find (done, STRUCT (expressions,_)) =
	    Lists.reducel find (done, expressions)
	  | find (done, RAISE (expression)) = find (done, expression)
	  | find (done, HANDLE (expression, expression',_)) =
	    find (find (done, expression), expression')
	  | find (done, LETREC (_, expressions, expression')) =
	    Lists.reducel find (find (done, expression'), expressions)

      in
	Set.list_to_set (find ([], expression))
      end



    (*  === EXTRACT IMPLICIT EXTERNAL REFERENCES ===
     *
     *  The following rules are applied:
     *
     *    APP (BUILTIN pervasive, ...)  -->  implicits of the pervasive
     *    SWITCH on string  -->  implicits of STRINGEQ
     *)


    fun implicit_external_references expression =
      let
	open AugLambda

	fun find (done,
		  {lexp=APP ({lexp=BUILTIN(pervasive,_), ...}, (el,fpel),_),
		   size=_}) =
	    Lists.reducel find ((MachPerv.implicit_references pervasive) @ done,
                                fpel @ el)

	  | find (done, {lexp=SWITCH (expression, info, cases, default),
			 ...}) =
	    let

	      fun find_case (done, (EXP_TAG expression, expression')) =
		  find (find (done, expression), expression')

		| find_case (done, (SCON_TAG (Ident.STRING _, _), expression')) =
		  let
		    val references =
		      MachPerv.implicit_references Pervasives.STRINGEQ
		  in
		    find (references @ done, expression')
		  end

		| find_case (done, (_, expression')) =
		  find (done, expression')

	      fun find_option (done, SOME expression) =
		  find (done, expression)

		| find_option (done, NONE) = done
	    in
	      Lists.reducel find_case
	      (find_option (find (done, expression), default), cases)
	    end

	  (* The rest of the cases are uninteresting, except LETREC which is *)
	  (* just cute. *)

	  | find (done, {lexp=BUILTIN pervasive, ...}) = done
	  | find (done, {lexp=VAR _, ...}) = done
	  | find (done, {lexp=FN (_, expression,_,_), ...}) =
	    find (done, expression)
	  | find (done, {lexp=LET ((_,_, binding), expression),...}) =
	    find (find (done, binding), expression)
	  | find (done, {lexp=APP (expression, (el,fpel),_), ...}) =
	    Lists.reducel find (find (done, expression), fpel @ el)
	  | find (done, {lexp=SCON _, ...}) = done
	  | find (done, {lexp=MLVALUE _, ...}) = done
	  | find (done, {lexp=INT _, ...}) = done
	  | find (done, {lexp=SELECT (_, expression), ...}) =
	    find (done, expression)
	  | find (done, {lexp=STRUCT expressions, ...}) =
	    Lists.reducel find (done, expressions)
	  | find (done, {lexp=RAISE (expression), ...}) = find (done, expression)
	  | find (done, {lexp=HANDLE (expression, expression'), ...}) =
	    find (find (done, expression), expression')
	  | find (done, {lexp=LETREC (_, expressions, expression'), ...}) =
	    Lists.reducel find (find (done, expression'), expressions)

      in
	Set.list_to_set (find ([], {lexp=expression, size=0}))
      end

    (*  === BUILD EXTERNAL ENVIRONMENT ===
     *
     *  This function calls `external_references' to find out which external
     *  pervasives are actually needed by the expression.  If there are any,
     *  then it makes a new lambda variable which is the pervasive library
     *  structure (obtained by applying LOAD_LIBRARY to its name), then makes
     *  a new lambda variable for each pervasive needed by SELECTing from the
     *  first variable.
     *
     *  The original lambda expression is then transformed by converting the
     *  external pervasives into their equivalent lambda variables, and this
     *  is then wrapped in a LET expression containing the variable
     *  definitions.
     *)

    fun build_external_environment (options, expression) =
      let
	val external_pervasives = external_references (options,expression)

	val _ = Diagnostic.output 1
	  (fn _ =>
	   "Library: External pervasives:" ::
	   (map (fn p => " " ^ Pervasives.print_pervasive p)
	    (Set.set_to_list external_pervasives)))
      in

	(* If there are no external references then there is no need to *)
	(* reference the library at all. *)

	if Set.empty_setp external_pervasives then
	  (NewMap.empty (Pervasives.order,Pervasives.eq),
	   externalise(options, expression, NewMap.empty (Pervasives.order,Pervasives.eq)))
	else

	  let
	    val library_lvar = LambdaTypes.new_LVar()
	    val library_binding =
              let
                open LambdaTypes
              in
                (library_lvar,
		 SELECT
		 ({index = 0, size = 2,selecttype=TUPLE},
		   APP (BUILTIN Pervasives.LOAD_STRING,
			([SCON (Ident.STRING Io.builtin_library_name, NONE)],[]),
			NONE)))
              end

	    fun make_bindings (bindings, map, []) =
	        (bindings, map)
	      | make_bindings (bindings, map, pervasive::pervasives) =
		let
		  val lvar = LambdaTypes.new_LVar()
		  val select =
		    LambdaTypes.SELECT
		    ({index = Pervasives.field_number pervasive,
		      size = Pervasives.nr_fields,
                      selecttype = LambdaTypes.STRUCTURE},
		     LambdaTypes.VAR library_lvar)
(*
                  (* REMOVE BEFORE CHECKING IN *)
                  val select =
                    LambdaTypes.SELECT
                    ({index=0,
                      size=2,
                      selecttype=LambdaTypes.TUPLE},
                     select)
*)
		  val map' =
		    NewMap.define(map, pervasive, lvar)
		in
		  make_bindings ((lvar, select)::bindings,
				 map',
				 pervasives)
		end

	    val (bindings, map) =
	      make_bindings ([], NewMap.empty (Pervasives.order,Pervasives.eq),
			     Set.set_to_list external_pervasives)


            fun wrap_lets (expression, vas) = 
              let
                fun nest ((var,arg),body) = LambdaTypes.LET((var, NONE, arg),body)
              in
                foldl nest expression (rev vas)
              end

	    val expression' =
	      wrap_lets
	      (externalise (options, expression, map), library_binding::bindings)

	    val _ = Diagnostic.output 3
	      (fn _ =>
	       ["Library: Externalised lambda expression:\n",
		LambdaPrint.string_of_lambda expression'])

	  in
	    (map, expression')
	  end

      end

  end

