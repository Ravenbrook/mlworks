(* inspector utility function
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: inspector_values.sml,v $
 * Revision 1.13  1997/03/06 16:44:12  matthew
 * Fixing equality
 *
 * Revision 1.12  1996/08/06  15:23:25  andreww
 * [Bug #1521]
 * propagating changes to typechecker/_scheme.sml
 *
 * Revision 1.11  1995/10/19  15:46:09  matthew
 * Correcting misspelling of abbreviate.
 *
Revision 1.10  1995/10/13  23:36:45  brianm
Adding support for abbreviated strings (needed by the Graphical Inspector).

Revision 1.9  1995/10/09  22:15:57  brianm
Adding string type test.

Revision 1.8  1995/07/25  15:58:22  matthew
Adding utilities for graphical inspection

Revision 1.7  1994/03/11  13:03:46  matthew
Added inspector_method functions

Revision 1.6  1993/10/19  14:14:30  nosa
Boolean indicator for Monomorphic debugger decapsulation.

Revision 1.5  1993/04/23  14:45:28  matthew
Added DuffUserMethod exception to return failure from inspection

Revision 1.4  1993/04/21  11:50:21  matthew
Added set reference function and commented it out

Revision 1.3  1993/04/20  10:13:52  matthew
Added add_inspect_method function

Revision 1.2  1993/04/01  10:58:58  matthew
Removed printing stuff
Simplified return type

Revision 1.1  1993/03/12  15:25:50  matthew
Initial revision

 *)

signature INSPECTOR_VALUES =
  sig

    type Type
    type options

    val add_inspect_method : MLWorks.Internal.Value.T * Type -> unit
    val delete_inspect_method : MLWorks.Internal.Value.T * Type -> unit
    val delete_all_inspect_methods : unit -> unit

    exception DuffUserMethod of exn

    val get_inspector_values : options ->  bool ->
      (MLWorks.Internal.Value.T * Type) ->
      (string * (MLWorks.Internal.Value.T * Type)) list

    val type_eq : Type * Type -> bool
    val is_scalar_value : (MLWorks.Internal.Value.T * Type) -> bool
    val is_string_type : Type -> bool
    val is_ref_type : Type -> bool

(*
    exception SetReference
    val set_reference :
      (MLWorks.Internal.Value.T * Type) * (MLWorks.Internal.Value.T * Type)
      ->
      unit
*)

    val string_abbreviation : string ref

  end


