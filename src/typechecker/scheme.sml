(* scheme.sml the signature *)
(*
$Log: scheme.sml,v $
Revision 1.33  1997/05/01 12:55:51  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.32  1996/08/06  13:24:17  andreww
 * [Bug #1521]
 * Propagating changes to _types.sml and _completion.sml
 * and dividing the dynamic_generalises function into two:
 * one for sml'90 and one for sml'96 (to take into account the
 * differences in treatment of "imperative" variables.
 *
 * Revision 1.31  1996/07/03  15:21:35  jont
 * Change check for free imperative type variables to return
 * the full type as well as the type variable
 *
 * Revision 1.30  1996/03/19  15:53:17  matthew
 * Adding option for value polymorphism
 *
 * Revision 1.29  1995/12/27  11:31:43  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.28  1995/12/18  12:30:51  matthew
Adding error info stuff.

Revision 1.27  1995/12/04  10:54:50  jont
Modify has_free_imptyvars to return the offending tyvar if it exists

Revision 1.26  1995/11/02  10:37:11  matthew
Exporting control of value polymorphism

Revision 1.25  1995/05/11  11:14:53  matthew
Removing value from Mismatch exception

Revision 1.24  1995/03/24  15:00:11  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.23  1995/01/17  13:19:22  matthew
Rationalizing debugger

Revision 1.22  1994/05/11  14:26:44  daveb
New overloading scheme.

Revision 1.21  1994/02/01  20:40:46  nosa
generate_moduler compiler option required in type variable instantiation.

Revision 1.20  1993/09/16  13:28:01  nosa
Typechecker now records instances in closed-over type variables
for polymorphic debugger.

Revision 1.19  1993/04/20  09:39:33  matthew
Added generalises_map and apply_instantiation functions

Revision 1.18  1993/04/07  10:55:00  matthew
Added check_closure and generalises functions

Revision 1.17  1993/04/01  16:44:38  jont
Allowed overloadin on strings to be controlled by an option

Revision 1.16  1993/03/04  10:20:38  matthew
Options & Info changes

Revision 1.15  1993/02/22  10:40:51  matthew
Added completion_env to scheme_generalises

Revision 1.14  1993/02/08  13:15:42  matthew
Removed open Datatypes, Changes for BASISTYPES signature

Revision 1.13  1993/02/01  14:20:25  matthew
Removed Datatypes substructure

Revision 1.12  1993/01/06  12:39:19  jont
Anel's last changes

Revision 1.11  1992/12/18  15:45:56  matthew
Propagating options to signature matching error messages.

Revision 1.10  1992/12/01  15:48:08  matthew
Changed handling of overloaded variable errors.

Revision 1.9  1992/10/30  15:25:54  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.8  1992/08/27  19:54:28  davidt
Yet more changes to get structure copying working better.

Revision 1.7  1992/08/13  17:07:52  davidt
Changed tyvars function to take a tuple of arguments.

Revision 1.6  1992/07/16  18:54:40  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.5  1992/07/04  17:16:05  jont
Anel's changes for improved structure copying

Revision 1.4  1992/06/16  15:47:43  clive
Added the printing of the name of the relevant identifier in a couple of error messages

Revision 1.3  1991/11/21  16:53:33  jont
Added copyright message

Revision 1.2  91/11/19  12:19:10  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:02  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:06  colin
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

(* The type Typescheme (defined in datatypes.sml) corrersponds to the
class TypeScheme of semantic objects defined by the Definition (page
17). This module provides functions that operate on typeschemes, and
some basic type schemes.  All the functions are as described in the
specification of the typechecker, and are all simple *)

require "../utils/set";
require "../main/options";
require "../typechecker/datatypes";

signature SCHEME =
  sig
    structure Set : SET
    structure Options : OPTIONS
    structure Datatypes : DATATYPES

    type error_info 
    type print_options

    exception EnrichError of string
    
    val instantiate  : int * Datatypes.Typescheme * Datatypes.Ident.Location.T * bool 
      -> Datatypes.Type * (Datatypes.InstanceInfo * Datatypes.Instance ref option)
    val make_scheme :  
      (Datatypes.Type list 
       * (Datatypes.Type * (Datatypes.Instance ref * Datatypes.Instance ref option ref) option))
      -> Datatypes.Typescheme

    val unary_overloaded_scheme :
      Datatypes.Ident.ValId * Datatypes.Ident.TyVar -> Datatypes.Typescheme
    val binary_overloaded_scheme :
      Datatypes.Ident.ValId * Datatypes.Ident.TyVar -> Datatypes.Typescheme
    val predicate_overloaded_scheme :
      Datatypes.Ident.ValId * Datatypes.Ident.TyVar -> Datatypes.Typescheme

    val equalityp : Datatypes.Typescheme -> bool
    val schemify : 
      (error_info * Options.options * Datatypes.Ident.Location.T) ->
      (int * bool * Datatypes.Typescheme * Datatypes.Ident.TyVar Set.Set * bool) ->
      Datatypes.Typescheme 
    val schemify' : 
      (int * bool * Datatypes.Typescheme * Datatypes.Ident.TyVar Set.Set * bool) ->
      Datatypes.Typescheme 
    val string_scheme : Datatypes.Typescheme -> string
    val typescheme_eq : Datatypes.Typescheme * Datatypes.Typescheme -> bool 

    (* check we can close over all type variables *)
    val check_closure : (bool * Datatypes.Type * int * Datatypes.Ident.TyVar Set.Set) -> bool

    exception Mismatch

    val SML90_dynamic_generalises: MLWorks.Internal.Dynamic.type_rep
                                  * MLWorks.Internal.Dynamic.type_rep -> bool
    val SML96_dynamic_generalises: MLWorks.Internal.Dynamic.type_rep
                                  * MLWorks.Internal.Dynamic.type_rep -> bool

    val generalises : bool -> Datatypes.Type * Datatypes.Type -> bool
    val generalises_map : bool -> Datatypes.Type * Datatypes.Type -> (int * Datatypes.Type) list
    val apply_instantiation : Datatypes.Type * (int * Datatypes.Type) list -> Datatypes.Type

    val scheme_generalises :
      Options.options ->
      Datatypes.Ident.ValId * Datatypes.Env * int * Datatypes.Typescheme * Datatypes.Typescheme ->
      bool

    val gather_tynames : Datatypes.Typescheme -> Datatypes.Tyname list
    val has_free_imptyvars : Datatypes.Typescheme -> (Datatypes.Type *Datatypes.Type) option
    val scheme_copy : Datatypes.Typescheme * (Datatypes.Tyname) Datatypes.StampMap -> Datatypes.Typescheme
    val tyvars : Datatypes.Ident.TyVar list * Datatypes.Typescheme -> Datatypes.Ident.TyVar list
  end

signature TYPESCHEME = SCHEME
