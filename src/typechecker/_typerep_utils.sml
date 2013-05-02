(* _typerep_utils.sml the functor *)
(*
$Log: _typerep_utils.sml,v $
Revision 1.18  1997/05/01 15:40:12  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.17  1996/11/06  11:33:44  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.16  1996/08/06  11:54:31  andreww
 * [Bug #1521]
 * propagating changes made to
 * _types.sml
 *
 * Revision 1.15  1996/04/29  14:03:27  matthew
 * Removing MLWorks.Integer.
 *
 * Revision 1.14  1996/03/19  16:05:28  matthew
 * Changed type of Scheme functions
 *
 * Revision 1.13  1996/03/08  12:08:45  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.12  1996/02/21  17:04:24  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.11  1995/12/27  12:09:43  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.10  1995/12/18  12:29:27  matthew
Passing error info to schemify

Revision 1.9  1995/01/17  14:04:04  matthew
Debugger changes

Revision 1.8  1994/02/21  22:53:21  nosa
Changed Datatypes.instance to Datatypes.Instance.

Revision 1.7  1993/11/24  17:40:18  matthew
Added absyn annotations

Revision 1.6  1993/09/16  14:56:18  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.5  1993/05/18  18:18:09  jont
Removed integer parameter

Revision 1.4  1993/04/08  08:28:32  matthew
Removed a lot of rubbish
Added convert_dynamic_type to do closure
Simplified lambda code for coercion

Revision 1.3  1993/03/09  12:25:04  matthew
Absyn changes

Revision 1.2  1993/03/02  17:34:29  matthew
empty_rec_type to empty_rectype

Revision 1.1  1993/02/19  15:32:00  matthew
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

(* This functor does the business of converting a type into an absyn
 expression that constructs the corresponding representation value *)

require "../basis/__int";

require "../utils/lists";
require "../utils/crash";
require "../typechecker/types";
require "../typechecker/scheme";
require "../basics/absyn";

require "typerep_utils";

functor TyperepUtils (
                      structure Lists : LISTS
                      structure Crash : CRASH
                      structure Types : TYPES
                      structure Scheme :SCHEME
                      structure Absyn : ABSYN

                      sharing Absyn.Ident = Types.Datatypes.Ident
                      sharing Absyn.Set = Scheme.Set
                      sharing Types.Datatypes = Scheme.Datatypes

                      sharing type Absyn.Type = Types.Datatypes.Type
                      sharing type Absyn.Instance = Types.Datatypes.Instance
                      sharing type Absyn.InstanceInfo = Types.Datatypes.InstanceInfo
                        ) : TYPEREP_UTILS =
  struct
    structure Datatypes = Types.Datatypes
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol
    structure Location = Ident.Location
    structure Absyn = Absyn

    fun make_tuple_exp exps =
      let fun do_one ((index,l),exp) =
        (index+1,(Ident.LAB (Symbol.find_symbol(Int.toString index)),exp) :: l)
        val (_,result) = Lists.reducel do_one ((0,[]),exps)
      in
        Absyn.RECORDexp result
      end

    val dynamic_path =
      Ident.PATH (Symbol.find_symbol "MLWorks",
                  Ident.PATH (Symbol.find_symbol "Internal",
                              Ident.PATH(Symbol.find_symbol "Dynamic",
                                         Ident.NOPATH)))

    val coerce_id = Ident.LONGVALID(dynamic_path,Ident.VAR(Symbol.find_symbol"coerce"))

    val coerce_type = Datatypes.FUNTYPE(Types.add_to_rectype
                                     (Ident.LAB (Symbol.find_symbol "1"),
                                      Types.dynamic_type,
                                      Types.add_to_rectype
                                      (Ident.LAB (Symbol.find_symbol "2"),
                                       Types.typerep_type,
                                       Types.empty_rectype)),
                                     Types.ml_value_type)

    fun make_coerce_expression (exp,atype) =
      Absyn.APPexp (Absyn.VALexp (coerce_id,ref coerce_type, 
                                  Location.UNKNOWN, 
                                  ref(Datatypes.ZERO,NONE)),
                    make_tuple_exp [exp,Absyn.MLVALUEexp (MLWorks.Internal.Value.cast atype)],
                    Location.UNKNOWN,
                    ref Types.ml_value_type,
                    false)

    exception ConvertDynamicType

    fun convert_dynamic_type (use_value_polymorphism,ty,level,tyvars) =
      if Scheme.check_closure (use_value_polymorphism,ty,level,tyvars)
        then
          case Scheme.schemify'(level,
                                true,
                                Datatypes.UNBOUND_SCHEME (ty,NONE),
                                tyvars,
                                true) of
            Datatypes.SCHEME(_,(scheme_type,_)) => scheme_type
          | Datatypes.UNBOUND_SCHEME (scheme_type,_) => scheme_type
          | _ => Crash.impossible "convert_dynamic_type"
      else 
        raise ConvertDynamicType
  end;
