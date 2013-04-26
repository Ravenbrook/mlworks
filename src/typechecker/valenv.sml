(* valenv.sml the signature *)
(*
$Log: valenv.sml,v $
Revision 1.17  1995/03/24 15:00:45  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.16  1995/02/06  11:01:10  matthew
Changing lookup exceptions

Revision 1.15  1994/05/09  16:14:02  daveb
Added resolve_overloads function.

Revision 1.14  1993/02/19  10:38:18  matthew
Moved enrichment code to _realise

Revision 1.13  1993/02/01  14:20:23  matthew
Added sharing

Revision 1.12  1992/12/18  15:46:12  matthew
Propagating options to signature matching error messages.
,

Revision 1.11  1992/10/30  15:29:53  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.10  1992/08/27  20:00:12  davidt
Yet more changes to get structure copying working better.

Revision 1.9  1992/08/27  11:36:52  davidt
Added Anel's changes, and changed some stuff to do better
equality checking of valenvs etc.

Revision 1.8  1992/08/11  16:30:12  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.7  1992/08/03  09:36:38  jont
Anel's changes to use NewMap instead of Map

Revision 1.6  1992/07/16  18:49:49  jont
Changed to use btrees for renaming of tynames and strnames.

Revision 1.5  1992/07/04  17:16:08  jont
Anel's changes for improved structure copying

Revision 1.4  1992/02/11  09:59:21  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1991/11/21  16:56:32  jont
Added copyright message

Revision 1.2  91/11/19  12:19:38  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:16  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:47:02  colin
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

(*

A ValEnv is a mapping from ValId's to typeschemes. It is used for
VarEnv's and ExConEnv's (as defined on p17 of the Definition). This
module defines the basic operations on ValEnv's used in the
Definition, plus one or two others to do things like convert a ValEnv
into a string (for debugging)

*)

require "../typechecker/datatypes";

signature VALENV =
  sig
    structure Datatypes : DATATYPES
    type Options
    type ErrorInfo

    exception LookupValId of Datatypes.Ident.ValId

    val initial_ve : Datatypes.Valenv
    val initial_ve_for_builtin_library : Datatypes.Valenv
    val initial_ee : Datatypes.Valenv      
    val lookup : Datatypes.Ident.ValId * Datatypes.Valenv -> Datatypes.Typescheme
    val add_to_ve : Datatypes.Ident.ValId * Datatypes.Typescheme * Datatypes.Valenv -> Datatypes.Valenv
    val ve_plus_ve : Datatypes.Valenv * Datatypes.Valenv -> Datatypes.Valenv 
    val ve_domain : Datatypes.Valenv -> Datatypes.Ident.ValId list
    val string_valenv : int * Datatypes.Valenv -> string 
    (* Warning! Valenv_eq ignores the constructor status of the identifiers *)
    val valenv_eq : Datatypes.Valenv * Datatypes.Valenv -> bool 
    val dom_valenv_eq : Datatypes.Valenv * Datatypes.Valenv -> bool 
    val empty_valenvp : Datatypes.Valenv -> bool
    val tyvars : Datatypes.Valenv -> Datatypes.Ident.TyVar list

    val resolve_overloads : ErrorInfo -> Datatypes.Env * Options -> unit
    
    val ve_copy :
      Datatypes.Valenv * Datatypes.Tyname Datatypes.StampMap ->
      Datatypes.Valenv
  end;
