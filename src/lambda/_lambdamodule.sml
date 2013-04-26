(*  ==== LAMBDA ENVIRONMENT/MODULE TRANSLATION ====
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
 *  Notes
 *  -----
 *  This code was move here from the compiler top level.
 *
 *  Revision Log
 *  ------------
 *  $Log: _lambdamodule.sml,v $
 *  Revision 1.17  1996/11/22 11:50:18  matthew
 *  Tidying
 *
 * Revision 1.16  1996/09/20  14:43:18  andreww
 * [Bug #1577]
 * Removing TE from environment ENV : it is redundant now!
 *
 * Revision 1.14  1996/03/28  10:32:40  matthew
 * Adding where type clause
 *
 * Revision 1.13  1995/08/11  17:01:30  daveb
 * Replaced uses of LamdaTypes.Option.opt with MLWorks.Option.option.
 *
 *  Revision 1.12  1995/01/11  13:32:03  matthew
 *  Debugger changes
 *
 *  Revision 1.11  1994/10/10  09:18:38  matthew
 *  Lambdatypes changes
 *
 *  Revision 1.10  1994/09/19  13:27:13  matthew
 *  Abstraction of debug information in lambdatypes
 *
 *  Revision 1.9  1994/02/28  07:54:27  nosa
 *  generate_moduler compiler option in strenvs and funenvs for compatibility purposes.
 *
 *  Revision 1.8  1994/01/19  12:41:40  nosa
 *  Paths in LAMBs for dynamic pattern-redundancy reporting
 *
 *  Revision 1.7  1993/07/08  13:46:36  nosa
 *  Type of constructor LETB has changed for local and closure
 *  variable inspection in the debugger.
 *
 *  Revision 1.6  1993/07/06  13:15:14  daveb
 *  Removed exception environments and interfaces.
 *
 *  Revision 1.5  1993/03/10  15:40:10  matthew
 *  Signature revisions
 *
 *  Revision 1.4  1993/01/14  14:34:26  daveb
 *  Changed explicit manipulation of list representations to use new format.
 *
 *  Revision 1.3  1992/10/28  10:19:13  jont
 *  Changed to use less than functions for maps. Fixed a bug whereby funid_order
 *  was used as an equality function
 *
 *  Revision 1.2  1992/10/05  08:22:36  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.1  1992/10/01  13:50:47  richard
 *  Initial revision
 *
 *)

require "../utils/crash";
require "../utils/lists";

require "environ";
require "lambdamodule";

functor LambdaModule (structure Environ	: ENVIRON
                      structure Lists	: LISTS
                      structure Crash	: CRASH

) : LAMBDAMODULE =
  struct
    structure EnvironTypes = Environ.EnvironTypes
    structure LambdaTypes = EnvironTypes.LambdaTypes
    structure Map = EnvironTypes.NewMap
    structure Ident = LambdaTypes.Ident

    fun ident(x as EnvironTypes.FIELD {index, ...}) = (true,x)
      | ident(x as EnvironTypes.PRIM _) = (false,x)
      | ident _ = Crash.impossible"External env not field"

    fun replace_ident(x, lvar) = lvar

    fun get_field_from_funenv(comp, (* _, *) _, _) = ident comp

    fun replace_field_in_funenv((_, env, gm), lvar) =
      (lvar, env, gm)

    fun get_field_from_strenv(_, comp, _) = ident comp

    fun replace_field_in_strenv((env, _, gm), lvar) = (env, lvar, gm)

    fun let_lambdas_in_exp(lv_le_list, lambda_exp) =
      Lists.reducer LambdaTypes.do_binding (lv_le_list, lambda_exp)

    fun extract_op (EnvironTypes.LAMB (x,_)) = LambdaTypes.VAR x
      | extract_op (EnvironTypes.PRIM x) = LambdaTypes.BUILTIN x
      | extract_op _ = Crash.impossible "extract_op problem"

    fun do_env([], _, le) = le
      | do_env(x :: xs, extract_fn, le) =
        let
          val lexp = extract_op(extract_fn x)
        in
          LambdaTypes.STRUCT([lexp, do_env(xs, extract_fn, le)],LambdaTypes.TUPLE)
        end


    val generate_moduler_debug = true


    fun pack (topenv as EnvironTypes.TOP_ENV
              (EnvironTypes.ENV(mv, ms),
               EnvironTypes.FUN_ENV m), decls_list) =
      let
        val valids = Map.to_list_ordered mv
        val strids = Map.to_list_ordered ms
        val funids = Map.to_list_ordered m
      in
        (Environ.assign_fields topenv,     (* allocate fields of an imaginary
                                              record for the various non-primitive
                                              ids *)
        (let_lambdas_in_exp                (* convert bindings in decls_list
                                              into a lambda expression which
                                              binds them explicitly using
                                              LETs and LETRECs *)
         (decls_list,
          do_env(valids, fn (_, x) => x,
                 do_env(strids, fn (_, (_, x, _)) => x,
                        do_env(funids, fn (_, (x, (* _, *) _, _)) => x,
                               LambdaTypes.INT 1))))))
                                        (* initial lambda expression for
                                           recursive construction of the
                                           nested LETs is INT 1. *)
      end



    fun unpack (EnvironTypes.TOP_ENV (EnvironTypes.ENV (val_map,struct_map),
                                      EnvironTypes.FUN_ENV fun_env),
                lambda_expression) =
      let
        val fun_list = Map.to_list_ordered fun_env
        val val_list = Map.to_list_ordered val_map
        val struct_list = Map.to_list_ordered struct_map
        val main_lvar = LambdaTypes.new_LVar()
        val var_main_lvar = LambdaTypes.VAR main_lvar

        fun get_new_binding_and_env(bindings, env, get_field, replace_field,
                                    x, start_lvar) =
          let
            fun sub_fun(bindings, env, [], finish_lvar) = (bindings, env, finish_lvar)
              | sub_fun(bindings, env, (x, y) :: rest, entry_lvar) =
                let
                  val (really_is_a_field, field) = get_field y
                  val lvar = LambdaTypes.new_LVar()
                  val lvar'' = LambdaTypes.new_LVar()
                in
                  sub_fun
                  (let
                    val bindings =
                      LambdaTypes.LETB(lvar'', NONE,LambdaTypes.SELECT
                                       ({index=1, size=2,selecttype=LambdaTypes.TUPLE}, entry_lvar)) ::
                      bindings
                    (* Note reverse order, we'll reverse it later *)
                   in
                     if really_is_a_field then
                       LambdaTypes.LETB
                       (lvar, NONE,
                        LambdaTypes.SELECT({index=0, size=2,selecttype=LambdaTypes.TUPLE},
                                           entry_lvar)) ::
                       bindings
                     else
                       (* No need to bind for a builtin *)
                       bindings
                   end,
                   Map.define
                   (env, x,
                    if really_is_a_field then
                      replace_field(y, EnvironTypes.LAMB(lvar,EnvironTypes.NOSPEC))
                    else y),
                   rest, LambdaTypes.VAR lvar'')
                end
          in
            sub_fun(bindings, env, x, start_lvar)
          end

        val main_binding =
          LambdaTypes.LETB(main_lvar, NONE, lambda_expression)

        val (bindings, val_env, finish_lvar) =
          get_new_binding_and_env([], Map.empty(Ident.valid_lt,Ident.valid_eq),
                                  ident, replace_ident, val_list,
                                  var_main_lvar)
        val (bindings, struct_env,finish_lvar) =
          get_new_binding_and_env(bindings,
                                   Map.empty(Ident.strid_lt,Ident.strid_eq),
                                   get_field_from_strenv,
                                   replace_field_in_strenv, struct_list,
                                   finish_lvar)
        val (bindings, fun_env,finish_lvar) =
          get_new_binding_and_env(bindings,
                                   Map.empty(Ident.funid_lt,Ident.funid_eq),
                                   get_field_from_funenv,
                                   replace_field_in_funenv, fun_list,
                                   finish_lvar)

        val new_fun_env =
          EnvironTypes.FUN_ENV fun_env

        val new_val_env =
          EnvironTypes.ENV(val_env, struct_env)
      in
        (EnvironTypes.TOP_ENV(new_val_env, new_fun_env),
         main_binding :: rev bindings)
      end

  end;
