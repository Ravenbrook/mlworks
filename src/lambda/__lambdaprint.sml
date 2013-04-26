(* __lambdaprint.sml the structure *)
(*
$Log: __lambdaprint.sml,v $
Revision 1.11  1995/02/13 12:31:39  matthew
Changes to Debugger_Types

Revision 1.10  1993/05/18  15:50:10  jont
Removed integer parameter

Revision 1.9  1992/07/20  13:40:05  clive
Changed to depend on debugger_types and not types

Revision 1.8  1992/06/11  08:42:19  clive
Needed to add type annotation to Fnexps

Revision 1.7  1992/03/23  11:11:16  jont
Added Integer parameter to the functor application

Revision 1.6  1991/08/23  17:05:53  davida
_Removed_ code to print names of builtins from
initial environment in main/primitives -
Jon decided he'd do it instead!!

Revision 1.5  91/08/22  15:18:55  davida
Added code to print names of builtins from
initial environment in main/primitives.

Revision 1.4  91/07/19  16:45:15  davida
New version using custom pretty-printer

Revision 1.3  91/06/26  16:30:20  jont
Added Lists structure to parameter list

Revision 1.2  91/06/12  19:27:00  jont
Reflect split of lambda into lamdatypes and lambda

Copyright (c) 1991 Harlequin Ltd.
*)

require "_lambdaprint";
require "../utils/__lists";
require "../basics/__identprint";
require "../debugger/__debugger_types";
require "__pretty";
require "__lambdatypes";

structure LambdaPrint_ = LambdaPrint (
  structure Lists = Lists_
  structure Pretty = Pretty_
  structure IdentPrint = IdentPrint_
  structure DebuggerTypes = Debugger_Types_
  structure LambdaTypes = LambdaTypes_);
   

