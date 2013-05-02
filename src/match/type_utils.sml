(* type_utils.sml the signature *)
(*
$Log: type_utils.sml,v $
Revision 1.9  1996/02/23 17:15:47  jont
newmap becomes map, NEWMAP becomes MAP

 * Revision 1.8  1995/05/01  10:04:41  matthew
 * Removing record_domain
 *
Revision 1.7  1995/02/07  13:46:04  matthew
Adding the_type for use by mir_cg

Revision 1.6  1992/10/12  09:50:06  clive
Tynames now have a slot recording their definition point

Revision 1.5  1992/09/09  15:51:32  jont
Added predicates for has nullary constructors and has value carrying
constructors. Should be more efficient

Revision 1.4  1992/08/06  15:38:59  jont
Anel's changes to use NewMap instead of Map

Revision 1.2  1992/01/24  23:25:26  jont
Added functionality to get valenvs from METATYNAMES and get domain
of record types

Revision 1.1  1992/01/23  12:06:25  jont
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

require "../typechecker/datatypes";

signature TYPE_UTILS =
  sig
    structure Datatypes : DATATYPES

    val get_valenv :
      Datatypes.Type -> string * (Datatypes.Ident.ValId,Datatypes.Typescheme) Datatypes.NewMap.map
    val type_from_scheme : Datatypes.Typescheme -> Datatypes.Type
    val is_vcc : Datatypes.Type -> bool
    val get_no_cons : Datatypes.Type -> int
    val get_no_vcc_cons : Datatypes.Type -> int
    val get_no_null_cons : Datatypes.Type -> int
    val has_null_cons : Datatypes.Type -> bool
    val has_value_cons : Datatypes.Type -> bool
    val get_cons_type : Datatypes.Type -> Datatypes.Type
    val is_integral2 : Datatypes.Type -> bool
    val is_integral3 : Datatypes.Type -> bool
  end
