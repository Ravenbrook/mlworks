(* inter_envtypes.sml the signature *)
(*
$Log: inter_envtypes.sml,v $
Revision 1.15  1996/02/23 17:44:13  jont
newmap becomes map, NEWMAP becomes MAP

 * Revision 1.14  1993/07/05  13:47:34  daveb
 * Removed exception environments.  Also removed add_*_list functions.
 *
Revision 1.13  1993/04/26  16:29:01  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.12  1993/03/11  10:24:12  matthew
Signature revisions

Revision 1.11  1993/03/04  18:08:25  matthew
Options & Info changes

Revision 1.10  1993/02/04  14:32:27  matthew
Added sharing.

Revision 1.9  1992/11/25  14:47:38  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.8  1992/11/20  16:09:36  jont
Modified sharing constraints to remove superfluous structures

Revision 1.7  1992/10/13  12:52:02  richard
Added print.
Changed the type of augment_with_module so it doesn't reveal the
structure of module results.

Revision 1.6  1992/09/10  16:56:42  richard
Added augment_with_module.

Revision 1.5  1992/08/26  15:13:11  richard
Rationalisation of the MLWorks structure.

Revision 1.4  1992/08/19  10:49:54  clive
Changes to reflect pervasive_library changes

Revision 1.3  1992/08/13  14:12:16  clive
Changes to reflect lower level sharing changes

Revision 1.2  1992/06/19  16:27:52  jont
Fixed the source errors

Revision 1.1  1992/06/17  16:04:15  jont
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

require "../main/options";
require "../lambda/environtypes";

signature INTER_ENVTYPES =
  sig
    structure EnvironTypes : ENVIRONTYPES
    structure Options : OPTIONS

    datatype inter_env =
      INTER_ENV of
      (EnvironTypes.LambdaTypes.Ident.ValId, MLWorks.Internal.Value.ml_value) EnvironTypes.NewMap.map * (* VARs *)
      (EnvironTypes.LambdaTypes.Ident.StrId, MLWorks.Internal.Value.ml_value) EnvironTypes.NewMap.map * (* STRs *)
      (EnvironTypes.LambdaTypes.Ident.FunId, MLWorks.Internal.Value.ml_value) EnvironTypes.NewMap.map (* FUNs *)

    val empty_env : inter_env

    val lookup_val : EnvironTypes.LambdaTypes.Ident.ValId * inter_env -> MLWorks.Internal.Value.ml_value
    val lookup_str : EnvironTypes.LambdaTypes.Ident.StrId * inter_env -> MLWorks.Internal.Value.ml_value
    val lookup_fun : EnvironTypes.LambdaTypes.Ident.FunId * inter_env -> MLWorks.Internal.Value.ml_value

    val add_val : inter_env * (EnvironTypes.LambdaTypes.Ident.ValId * MLWorks.Internal.Value.ml_value) -> inter_env
    val add_str : inter_env * (EnvironTypes.LambdaTypes.Ident.StrId * MLWorks.Internal.Value.ml_value) -> inter_env
    val add_fun : inter_env * (EnvironTypes.LambdaTypes.Ident.FunId * MLWorks.Internal.Value.ml_value) -> inter_env

    val remove_str : inter_env * (EnvironTypes.LambdaTypes.Ident.StrId) -> inter_env

    val augment : inter_env * inter_env -> inter_env

    exception Augment
    val augment_with_module :
      inter_env * EnvironTypes.Top_Env * MLWorks.Internal.Value.T -> inter_env

    val print : Options.print_options -> ('a * string -> 'a) -> ('a * inter_env) -> 'a

  end
