(* typerep_utils.sml the signature *)
(*
$Log: typerep_utils.sml,v $
Revision 1.3  1996/03/19 16:04:51  matthew
Changed type of Scheme functions

 * Revision 1.2  1993/04/07  16:23:16  matthew
 * Removed print_typerep and make_typerep_expression
 * Added convert_dynamic_type
 *
Revision 1.1  1993/02/19  16:47:22  matthew
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
require "../basics/absyn";

signature TYPEREP_UTILS =
  sig
    structure Datatypes : DATATYPES
    structure Absyn : ABSYN

    val make_coerce_expression : Absyn.Exp * Datatypes.Type -> Absyn.Exp

    exception ConvertDynamicType
    val convert_dynamic_type : (bool * Datatypes.Type * int * Absyn.Ident.TyVar Absyn.Set.Set) -> Datatypes.Type
  end

