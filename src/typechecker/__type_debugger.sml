(* __type_debugger.sml. Utilities for type checking information *)
(*
* $Log: __type_debugger.sml,v $
* Revision 1.1  1993/05/11 11:06:44  matthew
* Initial revision
*
*
* Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__lists";
require "../basics/__absyn";
require "../basics/__identprint";
require "__types";

require "_type_debugger";

structure TypeDebugger_ = TypeDebugger (structure Lists = Lists_
                                        structure Types = Types_
                                        structure Absyn = Absyn_
                                        structure IdentPrint = IdentPrint_);

