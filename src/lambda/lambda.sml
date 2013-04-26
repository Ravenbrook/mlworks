(* lambda.sml the signature *)
(*
$Log: lambda.sml,v $
Revision 1.28  1995/02/13 15:12:42  matthew
Removed Options structure from Debugger_Types

Revision 1.27  1994/02/28  07:10:26  nosa
Debugger environments for Modules Debugger.

Revision 1.26  1994/02/25  12:51:15  daveb
removing old parameter to trans_top_dec.

Revision 1.25  1993/06/25  08:36:08  daveb
Added BasisTypes structure.

Revision 1.24  1993/03/10  16:29:26  matthew
Signature revisions

Revision 1.23  1993/03/09  13:05:14  matthew
Options & Info changes
Absyn changes

Revision 1.22  1993/02/01  16:20:04  matthew
Added sharing constraints

Revision 1.21  1992/11/04  15:47:04  matthew
Changed Error structure to Info

Revision 1.20  1992/09/23  15:10:46  jont
Removed add_fn_names (obsolete)

Revision 1.19  1992/09/10  09:17:36  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.18  1992/09/02  14:21:54  richard
Installed central error reporting mechanism.

Revision 1.17  1992/08/26  12:21:36  jont
Removed some redundant structures and sharing

Revision 1.16  1992/08/25  14:45:08  clive
Added the recording of information about exceptions

Revision 1.15  1992/08/05  16:58:49  jont
Removed some structures and sharing

Revision 1.14  1992/03/17  18:31:34  jont
Added bool ref for add_fn_names to control addition of function names

Revision 1.13  1992/02/20  12:23:14  jont
Added show_match to control printing of match trees

Revision 1.12  1992/01/09  16:59:01  jont
Added diagnostic parameter

Revision 1.11  1992/01/06  12:54:16  jont
Changed trans_topdec and complete_struct_from_topenv to use new
binding type

Revision 1.10  1991/07/11  10:34:27  jont
New LETREC with expression in it again.

Revision 1.9  91/07/09  15:52:41  jont
More trouble with Regbind

Revision 1.8  91/07/09  13:49:57  jont
Removed trans_str_dec from signature. Regbind problems (temporarily?)
gone away

Revision 1.7  91/07/08  17:07:07  jont
Changed environments to top environments to cope with functors

Revision 1.6  91/06/26  12:59:46  jont
Removed superfluous definitions, all except trans_str_dec, as the functor
fails to compile if I remove this as well.

Revision 1.5  91/06/19  13:41:00  jont
Removed trans_exp, trans_dec, trans_match from signature,
as these should not be needed externally. Eventually there
will only be a trans_top_dec function I suspect.

Revision 1.4  91/06/17  13:12:00  jont
Added trans_str_exp.
Removed subs from parameter list for trans_dec

Revision 1.3  91/06/13  10:41:00  jont
Added trans_strdec

Revision 1.2  91/06/11  16:55:11  jont
Abstracted out the types from the functions

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basics/absyn";
require "../main/info";
require "../main/options";
require "../typechecker/basistypes";
require "environtypes";

signature LAMBDA = sig
  structure Absyn: ABSYN
  structure EnvironTypes: ENVIRONTYPES
  structure Info : INFO
  structure Options : OPTIONS
  structure BasisTypes : BASISTYPES

  type DebugInformation

  sharing Info.Location = Absyn.Ident.Location

  sharing Absyn.Ident = EnvironTypes.LambdaTypes.Ident

  sharing type Absyn.Type = EnvironTypes.LambdaTypes.Type = BasisTypes.Datatypes.Type

  val trans_top_dec :
    Info.options ->
    Options.options * Absyn.TopDec * 
    EnvironTypes.Top_Env * EnvironTypes.DebuggerEnv * 
    DebugInformation * BasisTypes.Basis * bool ->
    EnvironTypes.Top_Env * EnvironTypes.DebuggerEnv * 
    EnvironTypes.LambdaTypes.binding list * DebugInformation
end
