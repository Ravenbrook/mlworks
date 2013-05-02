(* runtime_env.sml the signature *)
(*
 * $Log: runtime_env.sml,v $
 * Revision 1.9  1997/05/01 12:28:44  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.8  1996/10/10  09:16:51  matthew
 * Adding LOCAL function annotation
 *
 * Revision 1.7  1995/12/27  12:34:21  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.6  1995/11/20  16:23:22  jont
 * Distinguish data types (gc, non_gc, float) in stack offsets for the debugger
 *
 * Revision 1.5  1995/07/25  12:15:42  jont
 * Add WORD tag type
 *
 * Revision 1.4  1995/07/19  11:18:57  jont
 * Add CHAR type of special constant
 *
 * Revision 1.3  1995/02/28  12:38:20  matthew
 * Changes to FunInfo type
 *
 * Revision 1.2  1995/02/01  11:39:36  matthew
 * Debugger work
 *
 * Revision 1.1  1995/01/30  12:38:40  matthew
 * new unit
 * Renamed from runtime_env
 *
 * Revision 1.4  1994/09/22  09:58:45  matthew
 * Abstraction of debug information
 *
 * Revision 1.3  1993/11/19  10:24:42  nosa
 * Type function spills for Modules Debugger;
 * Improved Control Transfer determining in HANDLEs.
 *
 * Revision 1.2  1993/08/16  12:09:40  nosa
 * Instances for polymorphic debugger.
 *
 * Revision 1.1  1993/07/30  15:45:14  nosa
 * Initial revision
 *

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


signature RUNTIMEENV =
  sig

    type Type
    type Tyfun
    type Instance

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
      NOVARINFO |
      VARINFO of (string * (Type ref * RuntimeInfo ref) * Offset ref option)

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
