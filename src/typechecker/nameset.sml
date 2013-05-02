(* nameset.sml the signature *)
(*
$Log: nameset.sml,v $
Revision 1.21  1996/10/04 16:04:07  andreww
[Bug #1592]
Adding extra "level" argument to nameset_rigid_copy, nameset_copy
and new_names_from_scratch.

 * Revision 1.20  1995/03/24  15:08:45  matthew
 * Use Stamp instead of Tyname_id etc.
 *
Revision 1.19  1994/01/05  12:05:06  matthew
Added --
 remove_strname -- delete a strname from a nameset
 simple_copy -- make a duplicate nameset

Revision 1.18  1993/12/09  19:37:48  jont
Added copyright message

Revision 1.17  1993/05/20  12:50:10  jont
Added nameset_rehash to deal with the effects of sharing and realisation

Revision 1.16  1993/04/08  11:46:23  matthew
Added nameset_rigid_copy

Revision 1.15  1993/03/17  18:25:36  matthew
BasisTypes & Nameset signature changes

Revision 1.14  1993/03/04  10:32:30  matthew
Options & Info changes

Revision 1.13  1993/02/08  17:56:20  matthew
Removed open Datatypes, Changes for BASISTYPES signature

Revision 1.12  1993/02/01  14:21:00  matthew
Added sharing.

Revision 1.11  1992/11/25  19:54:20  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.10  1992/10/30  15:55:25  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.9  1992/10/27  12:13:05  jont
Rempoved unused functions from the signature

Revision 1.8  1992/08/11  17:39:26  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.7  1992/07/17  10:21:08  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.6  1992/07/04  17:16:04  jont
Anel's changes for improved structure copying

Revision 1.5  1992/06/30  10:27:14  jont
Changed to imperative implementation of namesets with hashing

Revision 1.4  1992/02/11  10:08:06  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1991/11/21  18:19:47  jont
Added copyright message

Revision 1.2  91/11/19  12:19:01  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:58  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:44:28  colin
Initial revision

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
*)

(* The type Nameset corresponds to the class NameSet of semantic
objects as defined in the Definition (p31): a pair of sets of
structure names and type names respectively, representing those names
free in a semantic object. There are many functions defined on
NameSets in the Definition, and these are all defined and implemented
in this module. *)

require "../typechecker/datatypes";
require "../main/options";

signature NAMESET = 
  sig
    structure Datatypes : DATATYPES
    structure Options : OPTIONS

    type Nameset

    val empty_nameset : unit -> Nameset
    val union : Nameset * Nameset -> Nameset
    val intersection : Nameset * Nameset -> Nameset
    val add_tyname : Datatypes.Tyname * Nameset -> Nameset
    val add_strname : Datatypes.Strname * Nameset -> Nameset
    val member_of_tynames : Datatypes.Tyname * Nameset -> bool
    val member_of_strnames : Datatypes.Strname * Nameset -> bool
    val tynames_in_nameset : Datatypes.Tyname list * Nameset -> Nameset
    val remove_tyname : Datatypes.Tyname * Nameset -> Nameset
    val remove_strname : Datatypes.Strname * Nameset -> Nameset
    val nameset_eq : Nameset * Nameset -> bool
    val emptyp : Nameset -> bool
    val no_tynames : Nameset -> bool
    val diff : Nameset * Nameset -> Nameset
    val initial_nameset : Nameset
    val initial_nameset_for_builtin_library : Nameset
    val string_nameset : Options.print_options -> Nameset -> string
    val simple_copy : Nameset -> Nameset


      (* NB, in the next three functions, the int argument is
         simply the level to be assigned to any new TYNAMES. *)

    val nameset_copy :
      Nameset * 
      Datatypes.Strname Datatypes.StampMap * 
      Datatypes.Tyname Datatypes.StampMap -> int ->
      Nameset * Datatypes.Strname Datatypes.StampMap * 
      Datatypes.Tyname Datatypes.StampMap

    val nameset_rigid_copy :
      Nameset * 
      Datatypes.Strname Datatypes.StampMap *
      Datatypes.Tyname Datatypes.StampMap -> int -> 
      Nameset * Datatypes.Strname Datatypes.StampMap *
      Datatypes.Tyname Datatypes.StampMap

    val nameset_rehash : Nameset -> unit

    val new_names_from_scratch :
      Nameset -> int ->
      Nameset * 
      Datatypes.Strname Datatypes.StampMap *
      Datatypes.Tyname Datatypes.StampMap

(* these 3 functions added 6.6.91 by nickh to enable the spec-encoding
and decoding of namesets *)

    val tynames_of_nameset : Nameset -> Datatypes.Tyname list
    val strnames_of_nameset : Nameset -> Datatypes.Strname list
    val nameset_of_name_lists : 
      Datatypes.Tyname list * 
      Datatypes.Strname list -> 
      Nameset
  end


