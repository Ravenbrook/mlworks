(* mir_env.sml the signature *)
(*
$Log: mir_env.sml,v $
Revision 1.16  1997/05/01 12:37:02  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.15  1995/12/04  11:48:56  matthew
 * Adding Map type
 *
Revision 1.14  1994/10/11  15:26:28  matthew
Make lookup_in_closure return an Option value

Revision 1.13  1993/03/10  17:13:29  matthew
Signature revisions

Revision 1.12  1993/02/01  16:41:28  matthew
Added sharing

Revision 1.11  1992/10/30  12:08:58  jont
Changed to use LambdaTypes.Map

Revision 1.10  1992/08/19  18:03:06  davidt
Mir_Env now uses NewMap instead of Map.

Revision 1.9  1992/07/21  11:37:21  jont
Removed is_in_lambda_env and is_in_closure_env, not needed

Revision 1.8  1991/09/05  16:34:15  jont
Added augment_lambda_env

Revision 1.7  91/09/02  11:36:00  jont
Removed translations from primitives to HARP

Revision 1.6  91/08/30  15:48:48  jont
Removed Prim_Calc and associated items, now explicit in mir_cg

Revision 1.5  91/08/23  13:39:33  jont
Changed to use pervasives

Revision 1.4  91/08/15  11:12:06  jont
Updated for later version of HARP

Revision 1.3  91/07/30  17:28:29  jont
Added closure environment

Revision 1.2  91/07/26  14:20:58  jont
Added empty_lambda_env

Revision 1.1  91/07/25  11:15:03  jont
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

require "../lambda/lambdatypes";
require "mirtypes";

signature MIR_ENV =
  sig
    structure LambdaTypes : LAMBDATYPES
    structure MirTypes : MIRTYPES
    type 'a Map 
    sharing type MirTypes.Debugger_Types.Type = LambdaTypes.Type

    datatype Lambda_Env =
      LAMBDA_ENV of (MirTypes.any_register) Map
    val empty_lambda_env : Lambda_Env

    datatype Closure_Env = CLOSURE_ENV of int Map
    val empty_closure_env : Closure_Env
      
    val add_lambda_env:
      (LambdaTypes.LVar * MirTypes.any_register) * Lambda_Env -> Lambda_Env
    val lookup_lambda: LambdaTypes.LVar * Lambda_Env -> MirTypes.any_register option
    val augment_lambda_env:  Lambda_Env * Lambda_Env -> Lambda_Env
    val add_closure_env:
      (LambdaTypes.LVar * int) * Closure_Env -> Closure_Env
    val lookup_in_closure: LambdaTypes.LVar * Closure_Env -> int option
  end;
