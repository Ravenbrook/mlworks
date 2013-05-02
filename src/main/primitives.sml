(* primitives.sml the signature *)
(*
$Log: primitives.sml,v $
Revision 1.8  1995/08/31 10:04:46  daveb
Added check_builtin_env, to check the result of compiling the builtin library.

Revision 1.7  1995/05/25  09:29:20  matthew
Removing redundant values

Revision 1.6  1992/08/26  12:34:33  jont
Removed some redundant structures and sharing

Revision 1.5  1992/05/14  17:16:31  clive
Tried to neaten

Revision 1.4  1992/02/12  12:01:23  clive
New pervasive library

Revision 1.3  1991/08/22  13:53:44  jont
Added associative_primitives

Revision 1.2  91/07/24  12:03:06  jont
Added commutative primitives to assist in lambda expression optimisation

Revision 1.1  91/07/10  11:21:28  jont
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

require "../lambda/environtypes";

signature PRIMITIVES = sig
  structure EnvironTypes : ENVIRONTYPES

  val values_for_builtin_library : (string * EnvironTypes.LambdaTypes.Primitive) list
  (* The values that can be used for compiling the builtin library. 
     This is used in the typechecker. *)

  val initial_env_for_builtin_library : EnvironTypes.Env
  (* An environment built from values_for_builtin_library.  This is used
     to compile the builtin library. *)

  val initial_env : EnvironTypes.Env
  (* The initial environment. *)

  val env_after_builtin : EnvironTypes.Env
  (* The environment that is installed after compiling the builtin library.
     Contains initial_env in the structure "BuiltinLibrary_". *)

  val check_builtin_env:
    {error_fn: (string -> unit),
     topenv: EnvironTypes.Top_Env}
    -> bool
  (* Checks whether an environment contains a "BuiltinLibrary_" structure
     that contains the values in initial_env.  Used to check that the
     result of compiling the builtin library file matches the compiler
     internals - see main._toplevel. *)

  val env_for_not_ml_definable_builtins : EnvironTypes.Env
  (* An environment for functions that can't be defined in ML - e.g.
     polymorphic equality and (unresolved) overloaded functions. *)

  val env_for_lookup_in_lambda : EnvironTypes.Env
  (* Maps resolved overloaded functions to their corresponding pervasives. *)

end
