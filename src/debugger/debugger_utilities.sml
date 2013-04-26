(* debugger_utilities the signature *)
(*
$Log: debugger_utilities.sml,v $
Revision 1.6  1996/08/05 17:19:29  andreww
[Bug #1521]
Propagating changes made to typechecker/_types.sml

 * Revision 1.5  1996/07/10  08:10:21  stephenb
 * Remove root_name since it is no longer used anywhere.
 * Also removed is_suppressed_frame_names for the same reason.
 *
 * Revision 1.4  1995/04/13  13:12:29  matthew
 * Adding type generalization function
 *
# Revision 1.3  1995/03/08  10:46:55  matthew
# Making debugger platform independent
#
# Revision 1.1  1995/01/30  13:13:09  matthew
# new unit
# Renamed to debugger_utilities
#
Revision 1.10  1993/12/09  19:27:33  jont
Added copyright message

Revision 1.9  1993/03/10  16:58:33  matthew
Signature revisions

Revision 1.8  1993/03/04  13:10:30  matthew
Options & Info changes

Revision 1.7  1993/02/04  14:16:17  matthew
Removed Info substructure

Revision 1.6  1992/11/10  13:30:08  matthew
Changed Error structure to Info

Revision 1.5  1992/10/12  11:22:02  clive
Tynames now have a slot recording their definition point

Revision 1.4  1992/07/31  14:29:48  clive
Handles the propogation of types better

Revision 1.3  1992/07/21  09:59:22  clive
More work on the debugger

Revision 1.2  1992/07/16  16:54:31  clive
Added utilites for the polymorphic deduction code

Revision 1.1  1992/07/09  09:43:28  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "debugger_types";
require "^.main.options";

signature DEBUGGER_UTILITIES =
  sig
    structure Options : OPTIONS
    structure Debugger_Types : DEBUGGER_TYPES

    val slim_down_a_type : Debugger_Types.Type -> Debugger_Types.Type

    val is_type_polymorphic : Debugger_Types.Type -> bool

    val generate_recipe : Options.options ->
      Debugger_Types.Type * Debugger_Types.Type * string -> 
      Debugger_Types.Backend_Annotation

    val apply_recipe : Debugger_Types.Backend_Annotation  * Debugger_Types.Type
                             -> Debugger_Types.Type

    exception ApplyRecipe of string

    val handler_type : Debugger_Types.Type
    val setup_function_type : Debugger_Types.Type
    val is_nulltype : Debugger_Types.Type -> bool

    val close_type : Debugger_Types.Type -> Debugger_Types.Type
  end
