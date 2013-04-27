(* completion.sml the signature *)
(*
$Log: completion.sml,v $
Revision 1.10  1996/08/05 13:37:33  andreww
[Bug #1521]
Propagating changes to _types.sml

 * Revision 1.9  1995/04/11  09:54:33  matthew
 * Adding cached completion functions
 *
Revision 1.8  1994/06/17  13:55:08  daveb
Removed complete_tycons and print_name.  Nothing uses them.

Revision 1.7  1993/11/24  15:43:19  nickh
Added function to report a type error as a list of types and strings.
Also changed the treatment of unbound type variables in completion;
they need to test equal on separate calls to print_type_with_seen_tyvars,
so we need to retain the ref cell.

Revision 1.6  1993/03/04  10:16:57  matthew
Options & Info changes

Revision 1.5  1993/02/22  15:04:50  matthew
Uncurried print_type, added print_name

Revision 1.4  1993/02/01  14:20:58  matthew
Added sharing

Revision 1.3  1992/11/24  17:02:59  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1991/11/21  16:50:17  jont
Added copyright message

Revision 1.1  91/06/07  11:42:27  colin
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
require "../main/options";

(**** Long type constructor name completion ****)

signature COMPLETION =
sig
  structure Datatypes : DATATYPES
  structure Options : OPTIONS

  type Cache

  val empty_cache : unit -> Cache
  val print_type : (Options.options * Datatypes.Env * Datatypes.Type) -> string
  val cached_print_type : 
    (Options.options * Datatypes.Env * Datatypes.Type * Cache)
      -> (string * Cache)

  val report_type_error :
    (Options.options * Datatypes.Env * Datatypes.type_error_atom list) 
    -> string

end;
