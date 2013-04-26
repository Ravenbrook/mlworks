(* __typerep_utils.sml the structure *)
(*
$Log: __typerep_utils.sml,v $
Revision 1.3  1993/05/18 18:18:24  jont
Removed integer parameter

Revision 1.2  1993/04/07  16:21:33  matthew
Added Crash structure

Revision 1.1  1993/02/19  15:30:34  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__crash";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../basics/__absyn";
require "_typerep_utils";

structure TyperepUtils_ = TyperepUtils (
                                        structure Lists = Lists_
                                        structure Crash = Crash_
                                        structure Types = Types_
                                        structure Scheme = Scheme_
                                        structure Absyn = Absyn_
                                          )
