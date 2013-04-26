(* _runtime_env.sml the functor *)
(*
 * $Log: _runtime_env.sml,v $
 * Revision 1.9  1997/05/01 12:28:05  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.8  1996/10/10  09:17:14  matthew
 * Adding LOCAL function annotation
 *
 * Revision 1.7  1995/12/27  12:36:11  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.6  1995/11/20  16:23:48  jont
 * Distinguish data types (gc, non_gc, float) in stack offsets for the debugger
 *
 * Revision 1.5  1995/07/25  12:16:43  jont
 * Add WORD tag type
 *
 * Revision 1.4  1995/07/19  11:19:36  jont
 * Add CHAR type of special constant
 *
 * Revision 1.3  1995/02/28  12:38:30  matthew
 * Changed FunInfo types
 *
 * Revision 1.2  1995/02/01  11:39:44  matthew
 * Debugger work
 *
 * Revision 1.1  1995/01/30  12:39:07  matthew
 * new unit
 * Renamed from _runtime_env
 *
 * Revision 1.4  1994/09/22  09:59:17  matthew
 * Abstraction of debug information
 *
 * Revision 1.3  1993/11/19  10:25:31  nosa
 * Type function spills for Modules Debugger;
 * Improved Control Transfer determining in HANDLEs.
 *
 * Revision 1.2  1993/08/16  12:09:54  nosa
 * Instances for polymorphic debugger.
 *
 * Revision 1.1  1993/07/30  15:46:38  nosa
 * Initial revision
 *

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/datatypes";
require "runtime_env";

functor RuntimeEnv (structure Datatypes : DATATYPES
                      ) : RUNTIMEENV =
  struct

    type Type = Datatypes.Type
    type Tyfun = Datatypes.Tyfun
    type Instance = Datatypes.Instance

    datatype Tag = 
      CONSTRUCTOR of string
    | INT of string
    | REAL of string
    | STRING of string
    | CHAR of string
    | WORD of string
    | DYNAMIC
    | DEFAULT

    (* I'm not sure what this is meant to represent *)
    (* Something to do with spill offsets *)
    (* OFFSET1 is the spill offset as allocated by _mir_cg *)
    (* OFFSET2 is the spill offset as given by by _mach_cg *)
    (* once the stack is laid out *)
    (* Within this second option we need to know the type of spill area *)
    datatype SpillArea = GC | NONGC | FP

    datatype Offset = OFFSET1 of int | OFFSET2 of (SpillArea * int)

    datatype RuntimeInfo = RUNTIMEINFO of (Instance ref option * (Tyfun ref * Offset ref) list)

    datatype VarInfo = 
      NOVARINFO 
    | VARINFO of (string * (Type ref * RuntimeInfo ref) * Offset ref option)

    datatype FunInfo = 
      USER_FUNCTION
    | INTERNAL_FUNCTION
    | LOCAL_FUNCTION
    | FUNINFO of ((int * Type * Instance) ref list * Offset ref)

    datatype RuntimeEnv = 
      LET of (VarInfo * RuntimeEnv) list * RuntimeEnv
    | FN of string * RuntimeEnv * Offset ref * FunInfo
    | APP of RuntimeEnv * RuntimeEnv * int option
    | RAISE of RuntimeEnv
    | SELECT of int * RuntimeEnv
    | STRUCT of RuntimeEnv list
    | LIST of RuntimeEnv list
    | SWITCH of RuntimeEnv * Offset ref * int * (Tag * RuntimeEnv) list 
    | HANDLE of RuntimeEnv * Offset ref * int * int * RuntimeEnv 
    | EMPTY
    | BUILTIN

  end

