(* _types.sml the functor *)
(*
$Log: _types.sml,v $
Revision 1.122  1998/02/19 16:32:51  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.121  1997/04/25  16:28:32  jont
 * [Bug #20017]
 * Add has_int32_equality function
 *
 * Revision 1.120  1996/12/18  16:38:04  andreww
 * [Bug #1818]
 * Adding new floatarray type name.
 *
 * Revision 1.119  1996/11/06  13:38:56  andreww
 * [Bug #1711]
 * Punning real tyname equality attribute with old_definition option.
 *
 * Revision 1.118  1996/11/06  11:33:49  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.117  1996/10/29  14:01:39  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.116  1996/10/04  15:40:11  andreww
 * [Bug #1592]
 * Threading extra level argument through tynames.
 *
 * Revision 1.115  1996/08/05  14:16:31  andreww
 * [Bug #1521]
 * Prevent type variables being distinguished as imperative when using
 * value polymorphism.
 *
 * Revision 1.114  1996/05/24  11:52:45  matthew
 * Improving tyfun_strip
 *
 * Revision 1.113  1996/05/23  15:02:28  matthew
 * Removing Crash.impossible in type_copy
 *
 * Revision 1.112  1996/05/07  10:35:05  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.111  1996/04/30  17:44:13  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.110  1996/04/29  13:27:21  matthew
 * Integer changes
 *
 * Revision 1.109  1996/03/08  12:07:14  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.108  1996/02/22  11:14:27  jont
 * Replacing Map with NewMap
 *
 * Revision 1.107  1995/12/27  11:28:05  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.106  1995/12/05  12:10:02  jont
Modify has_free_imptyvars to return the offending tyvar if it exists
Add type_occurs to find if such a type occurs within another more
complicated type

Revision 1.105  1995/11/03  10:17:06  matthew
Extended check on free type variables to include non-imperative tyvars.
These shouldn't occur with normal semantics and should be caught with
value-polymorphism semantics.

Revision 1.104  1995/10/18  13:58:27  matthew
Removing a compiler fault that can happen with error recoveru

Revision 1.103  1995/09/11  11:11:31  daveb
Added types for different lengths of words, ints and reals.

Revision 1.102  1995/08/22  16:09:12  jont
Add has_int_equality, has_real_equality, has_string_equality

Revision 1.101  1995/08/01  10:43:49  jont
Add bytearray to has_ref_equality

Revision 1.100  1995/07/28  14:27:20  jont
Sort out resolve_overloading to handle word types

Revision 1.99  1995/07/27  16:41:31  jont
Add word_typep and wordint_typep

Revision 1.98  1995/07/26  13:35:07  jont
Fix word_type to refer to word_tyname

Revision 1.97  1995/07/24  15:55:53  jont
Add word literal support

Revision 1.96  1995/07/21  13:18:03  jont
Add word_type and word_tyname

Revision 1.95  1995/07/19  10:26:42  jont
Add Ident.CHAR to type_of function

Revision 1.94  1995/07/13  13:14:22  jont
Add char type for new revised basis

Revision 1.93  1995/05/02  10:11:02  matthew
Removing special case for printing bytearray type

Revision 1.92  1995/04/10  11:04:14  matthew
Added simplify_type function

Revision 1.91  1995/04/06  12:56:19  matthew
stuff

Revision 1.90  1995/04/05  09:52:17  jont
Ensure that arrays have reference semantics with respect to equality

Revision 1.89  1995/03/17  17:24:22  matthew
Fixing problem with printing flexible record types.
Use NewMap.map more.

Revision 1.87  1995/02/17  11:40:12  daveb
Improved printing of overloaded type variables.

Revision 1.86  1995/02/02  14:35:45  matthew
Removing debug stuff

Revision 1.85  1994/10/13  10:28:10  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.84  1994/09/22  11:44:27  matthew
Abstraction of debug information
Tidying up

Revision 1.83  1994/08/31  16:12:07  matthew
Minor efficiency improvements to copy_type

Revision 1.82  1994/05/13  15:20:56  daveb
Fixed type_of: integer literals were assigned int_tyvar instead of
int_literal_tyvar.

Revision 1.81  1994/05/11  14:41:21  daveb
New overloading scheme.

Revision 1.80  1994/05/04  14:20:42  jont
Fix tyfun_strip to ensure arity preserved
Fixed typos in debug_print_type and friends

Revision 1.79  1994/04/27  15:56:29  jont
Added functions for checking for uninstantiated tyvars

Revision 1.78  1994/02/28  09:00:37  nosa
Changed Datatypes.instance to Datatypes.Instance.

Revision 1.77  1993/11/30  11:10:20  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.76  1993/11/25  11:56:02  nickh
Added hooks to print types with a set of remembered type variables.

Revision 1.75  1993/11/24  18:56:40  nickh
Bug fixes 481 and 489: constypes with multiple metarectypes were
printing poorly, and the 26th, 52nd, etc type variables were printing
incorrectly.

Revision 1.74  1993/11/24  10:13:53  nickh
Patch up silent failure in RCS.

Revision 1.73  1993/11/23  16:54:27  nickh
Fixed the way record types are printed (killed a space and improved
tail-recursion).

Revision 1.72  1993/11/16  20:40:34  jont
Made app_subst substitute for instantiated META_OVERLOADED types, which result
from top level resolution of overloading

Revision 1.71  1993/09/27  11:04:26  jont
Merging in bug fixes

Revision 1.70  1993/09/03  11:11:09  nosa
Instances for METATYVARs and TYVARs and DEBRUIJNs;
function all_tyvars that returns all METATYVAR- and TYVAR- refs
for polymorphic debugger.

Revision 1.69.1.2  1993/09/23  15:35:00  jont
Added make_true for doing equality_principal algorithm

Revision 1.69.1.1  1993/08/23  13:51:05  jont
Fork for bug fixing

Revision 1.69  1993/08/23  13:51:05  jont
Improved type_copy and associated functions

Revision 1.68  1993/08/03  12:24:14  matthew
Changed printing of overloaded types.

Revision 1.67  1993/07/30  15:11:00  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger;
structure Option.

Revision 1.66  1993/07/29  17:27:07  jont
Extra extra information debug_print_type

Revision 1.65  1993/06/11  14:20:03  matthew
 Fixed some problems with type printing

Revision 1.64  1993/06/04  09:37:51  matthew
Fixed type circularity check

Revision 1.63  1993/05/20  15:07:20  matthew
Removed debuggery
Changed debug_print_name a little.

Revision 1.62  1993/05/18  18:20:43  jont
Removed integer parameter

Revision 1.61  1993/05/05  15:47:18  matthew
Corrected name of vector_tyname
Changed tyname_copy to handle flexible names not in the mapping.

Revision 1.60  1993/04/26  17:55:59  daveb
Added print_tyvars and make_tyvars.

Revision 1.59  1993/04/08  16:14:37  matthew
Added closed_type_equalityp for getting equality attributes of
closed types.

Revision 1.58  1993/03/31  12:27:42  jont
Fixed bug in tyname_strip which didn't remove the simple TYFUN(CONSTYPE) case
This caused completion to fail

Revision 1.57  1993/03/09  17:24:59  jont
Added string_or_num_typep for spotting overloading of relationals to strings.

Revision 1.56  1993/03/04  10:10:16  matthew
Options & Info changes

Revision 1.55  1993/03/02  16:24:02  matthew
Rationalised use of Mapping structure

Revision 1.54  1993/03/01  11:04:16  matthew
Added vector and bytearray tynames

Revision 1.53  1993/02/25  16:03:24  matthew
Added array_tyname

Revision 1.52  1993/02/18  16:49:29  matthew
Added dynamic type definition

Revision 1.51  1993/02/01  14:49:21  matthew
Added sharing

Revision 1.50  1992/12/22  15:32:40  jont
Anel's last changes

Revision 1.49  1992/12/16  15:25:26  jont
Allow make_new_type to deal with METATYVAR returned by other failures

Revision 1.48  1992/12/09  10:11:18  matthew
Fixed type printing.

Revision 1.47  1992/11/28  16:43:10  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.46  1992/11/26  20:03:12  daveb
Fixed typo in type_strip.

Revision 1.45  1992/11/25  17:08:59  jont
Improved type_eq by stripping rubbish off types before matching

Revision 1.44  1992/10/30  15:13:58  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.43  1992/10/27  12:12:49  jont
Fixes to print flexible records properly

Revision 1.42  1992/10/12  11:15:08  clive
Tynames now have a slot recording their definition point

Revision 1.41  1992/09/25  14:51:53  jont
Changed type of Map.fold

Revision 1.40  1992/09/25  12:31:16  jont
Removed simpletypes and its structures, they're in datatypes

Revision 1.39  1992/09/16  08:38:26  daveb
Improved printing of types, including placing of brackets.
Meta status of types, etc., only printed when do_debug is true

Revision 1.38  1992/09/11  10:26:08  jont
Improved versions of tyfun_eq and tyname_eq

Revision 1.37  1992/09/08  13:34:08  jont
Removed has_a_new_name, no longer needed. Recoded meta_tyname

Revision 1.36  1992/09/02  13:40:04  jont
Stuff to understand type functions properly

Revision 1.35  1992/08/28  16:00:13  davidt
Fixed bug in tyname_copy which copied too much stuff.

Revision 1.34  1992/08/28  00:46:25  jont
Ensured new names propagated through tyfuns and tynames

Revision 1.33  1992/08/27  19:38:34  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.32  1992/08/27  15:30:33  davidt
Added Anel's changes, and changed some stuff to do better
equality checking of valenvs etc.

Revision 1.31  1992/08/17  10:09:29  clive
Simple hack-fix to the print_name failing on most of its possible inputs

Revision 1.30  1992/08/14  10:41:30  davidt
Changed tyvars function to take a tuple of arguments.
l with Lists.reducel.

Revision 1.29  1992/08/13  15:34:00  jont
Fixed copy_metatyname and new_metatyname to duplicate the
valenv ref as well as all the other refs

Revision 1.28  1992/08/13  10:20:12  clive
Changed the tuple-type printing to use *

Revision 1.27  1992/08/11  13:27:37  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.26  1992/08/10  16:53:02  matthew
Changed eq_attrib so it follows META chains.

Revision 1.25  1992/08/06  17:43:41  jont
Anel's changes to use NewMap instead of Map

Revision 1.24  1992/07/28  14:49:24  jont
Removed use of Array parameter to allow pervasive Array to be used

Revision 1.23  1992/07/27  11:47:35  richard
Added ml_value_tyname.

Revision 1.22  1992/07/21  09:02:42  clive
Fixed the string_types function - if didn't bracket a funtype with a funtype as its first
argument

Revision 1.21  1992/07/16  18:43:45  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.20  1992/07/04  17:16:00  jont
Anel's changes for improved structure copying

Revision 1.19  1992/06/16  14:07:26  jont
Modifications to sort out unification of flexible record types in order
to provide full information to the lambda translation

Revision 1.17  1992/05/05  14:09:25  jont
Anel's fixes

Revision 1.16  1992/04/13  13:37:29  jont
Fixed bug in type matching shown up my _miropttypes

Revision 1.15  1992/04/01  14:51:37  jont
Added new function tyvar_equalityp for where the equality attribute is
significant. The previous function type_equalityp now ignores the
equality attribute of type variables

Revision 1.14  1992/02/11  10:14:28  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.13  1992/01/27  20:11:32  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.12  1992/01/24  16:02:11  jont
Updated to allow valenv in METATYNAME

Revision 1.11  1992/01/23  15:50:34  jont
Added value giving tyfun_id_counter at end of defining pervasives

Revision 1.10  1992/01/15  12:07:19  clive
Added the array type

Revision 1.9  1992/01/14  16:41:11  jont
Changed ref unit in valenv to ref int to assist encoder

Revision 1.8  1992/01/14  11:50:15  jont
Changed comparison with ref_tyname to use tyname_eq, in order to assist
separate compilation system

Revision 1.7  1992/01/07  19:21:14  colin
Added pervasive_tyname_count giving tyname id of first tyname after
the pervasives have been defined and added code to reset tyname counter
prior to defining the pervasives.

Revision 1.6  1992/01/07  16:19:42  colin
Removed last argument to calls to make_tyname
Removed no_of_cons

Revision 1.5  1991/11/19  17:11:14  jont
Removed inexhaustive matches

Revision 1.4  91/07/12  14:15:22  colin
Made eq tynames print with a [t] otherwise an [f] in print_name
This makes debugging easier than before ;-)

Revision 1.3  91/06/18  15:42:00  colin
Added functions (isFunType) to check for a funtype and (argres) to extract
argument and result types.

Revision 1.2  91/06/17  17:16:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing circular data structures.

Revision 1.1  91/06/07  11:39:10  colin
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

require "^.basis.__int";
require "^.basis.__list";

require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../basics/identprint";
require "datatypes";
require "stamp";
require "types";

functor Types (
  structure Lists : LISTS
  structure Print : PRINT
  structure Crash : CRASH
  structure Datatypes : DATATYPES
  structure Stamp : STAMP
  structure IdentPrint : IDENTPRINT

  sharing IdentPrint.Ident = Datatypes.Ident
  sharing type Datatypes.Stamp = Stamp.Stamp
  sharing type Datatypes.StampMap = Stamp.Map.T

) : TYPES =
  struct
    structure Datatypes = Datatypes
    structure Options = IdentPrint.Options

    val do_debug = false
    val generate_moduler_debug = false

    (****
     In this functor all operations on the three mutually recursive data
     structures Types, Tyname and Tyfun are declared.  See the structure 
     Datatypes for the datatype declarations.
     ****)

    open Datatypes

    type PrintTypeOptions = {show_eq_info : bool
                             }

    val debug_print_options = {show_eq_info = true}

    fun show_eq ({show_eq_info, ...}: PrintTypeOptions) = show_eq_info

      (* note that in the following, level is an integer reference.
         See DATATYPEdec case for check_dec in typechecker/_core_rules.sml
         for an explanation. *)

    fun make_tyname (n,eq,pname,location,level) = 
      TYNAME (Stamp.make_stamp (),pname,n,ref eq, ref empty_valenv,location,
              ref false,ref empty_valenv,level)

    fun tyname_arity (TYNAME (_,_,n,_,_,_,_,_,_)) = n
      | tyname_arity (METATYNAME (_,_,n,_,_,_)) = n

    (****
     Used in maximising equality - rules 19 and 20.
     ****)

    fun tyname_make_false (TYNAME (_,_,_,r,_,_,_,_,_)) = (r := false; false)
      | tyname_make_false (METATYNAME (ref tyfun,_,_,r,_,_)) =
	case tyfun of
	  ETA_TYFUN tyname => tyname_make_false tyname
      | NULL_TYFUN _ =>
	  (r := false; false)
      | TYFUN _ => Crash.impossible "Types.make_false"

    (****
     make_false is used in maximising equality - rules 19 and 20.
     ****)
    and make_false (TYFUN (_)) = Crash.impossible "Types.make_false"
      | make_false (ETA_TYFUN (tyname)) = tyname_make_false tyname
      | make_false (NULL_TYFUN (_)) = false

    (****
     make_true is used in maximising equality - rules 19 and 20.
     ****)
    fun make_true (TYNAME (_,_,_,r,_,_,_,_,_)) = r := true
      | make_true (METATYNAME (ref tyfun,_,_,r,_,_)) =
	case tyfun of
	  ETA_TYFUN tyname => make_true tyname
      | NULL_TYFUN _ =>
	  r := true
      | TYFUN _ => Crash.impossible "Types.make_true"

    val _ = Stamp.reset_counter 0

      (* NOTE: if you're going to add a new tyname, put it at the end of
         the list.  This will ensure that the stamps of the old tynames
         will remain unchanged (and so avoid strange types like
         "bool char" for "bool list" in the decapsulation process.) *)

    val bool_tyname = make_tyname (0,true,"bool",NONE,0)
    val int_tyname = make_tyname (0,true,"int",NONE,0)
    val word_tyname = make_tyname (0,true,"word",NONE,0)
    val int8_tyname = make_tyname (0,true,"int8",NONE,0)
    val word8_tyname = make_tyname (0,true,"word8",NONE,0)
    val int16_tyname = make_tyname (0,true,"int16",NONE,0)
    val word16_tyname = make_tyname (0,true,"word16",NONE,0)
    val int32_tyname = make_tyname (0,true,"int32",NONE,0)
    val word32_tyname = make_tyname (0,true,"word32",NONE,0)
    val int64_tyname = make_tyname (0,true,"int64",NONE,0)
    val word64_tyname = make_tyname (0,true,"word64",NONE,0)
    val real_tyname = make_tyname (0,false,"real",NONE,0)
    val float32_tyname = make_tyname (0,true,"float32",NONE,0)
    val string_tyname = make_tyname (0,true,"string",NONE,0)
    val char_tyname = make_tyname (0,true,"char",NONE,0)
    val list_tyname = make_tyname (1,true,"list",NONE,0)
    val ref_tyname = make_tyname (1,true,"ref",NONE,0)
    val exn_tyname = make_tyname (0,false,"exn",NONE,0)
    val ml_value_tyname = make_tyname (0,true,"ml_value",NONE,0)
    val array_tyname = make_tyname (1,true,"array",NONE, 0)
    val vector_tyname = make_tyname (1,true,"vector",NONE, 0)
    val bytearray_tyname = make_tyname (0,true,"bytearray", NONE, 0)
    val dynamic_tyname = make_tyname (0,false,"dynamic",NONE,0)
    val typerep_tyname = make_tyname (0,false,"type_rep",NONE,0)
    val floatarray_tyname = make_tyname (0,true,"floatarray", NONE, 0)

      (* it is important that the following is exactly the reference
         to the equality attribute reference in real_tyname: we don't
         just want its value:  we want to share this reference with
         the oldDefinition option, so that whenever we set one, we
         "set the other" automatically. *)

    val real_tyname_equality_attribute =
      let
        val eqRef = (fn (TYNAME(_,_,_,eqRef,_,_,_,_,_)) => eqRef
                      | _ => Crash.impossible
                          "types: accessing real tyname attribute") real_tyname
      in
        eqRef
      end


    fun tyname_sizeof (TYNAME {2 = "int8", ...}) = SOME 8
    |   tyname_sizeof (TYNAME {2 = "word8", ...}) = SOME 8
    |   tyname_sizeof (TYNAME {2 = "int16", ...}) = SOME 16
    |   tyname_sizeof (TYNAME {2 = "word16", ...}) = SOME 16
    |   tyname_sizeof (TYNAME {2 = "int32", ...}) = SOME 32
    |   tyname_sizeof (TYNAME {2 = "word32", ...}) = SOME 32
    |   tyname_sizeof (TYNAME {2 = "int64", ...}) = SOME 64
    |   tyname_sizeof (TYNAME {2 = "word64", ...}) = SOME 64
    |   tyname_sizeof (TYNAME {2 = "float32", ...}) = SOME 32
    |   tyname_sizeof _ = NONE

    val pervasive_stamp_count = Stamp.read_counter ()

    (****
     For determining the constructors associated with a Constype.
     ****)

    fun tyname_conenv (TYNAME {5 = ref conenv,...}) = conenv
    | tyname_conenv (METATYNAME _) = 
      Crash.impossible "Types.tyname_conenv METATYNAME"

    (****
     NullTyfun is raised by the function apply. This function 
     is never applied in other functors before doing the necessary tests 
     to determine whether the function they are applied to is NULL_TYFUN.
     Thus NullTyfun is not in the signature matching this functor.
     ****)

    exception NullTyfun
    exception WrongArity

    val int_type = CONSTYPE ([],int_tyname)
    val word_type = CONSTYPE ([],word_tyname)
    val int8_type = CONSTYPE ([],int8_tyname)
    val word8_type = CONSTYPE ([],word8_tyname)
    val int16_type = CONSTYPE ([],int16_tyname)
    val word16_type = CONSTYPE ([],word16_tyname)
    val int32_type = CONSTYPE ([],int32_tyname)
    val word32_type = CONSTYPE ([],word32_tyname)
    val int64_type = CONSTYPE ([],int64_tyname)
    val word64_type = CONSTYPE ([],word64_tyname)
    val real_type =  CONSTYPE ([],real_tyname)
    val float32_type =  CONSTYPE ([],float32_tyname)
    val string_type = CONSTYPE ([],string_tyname)
    val char_type = CONSTYPE ([],char_tyname)
    val bool_type = CONSTYPE ([],bool_tyname)
    val exn_type =  CONSTYPE ([],exn_tyname)
    val ml_value_type = CONSTYPE ([],ml_value_tyname)
    val dynamic_type = CONSTYPE ([],dynamic_tyname) 
    val typerep_type = CONSTYPE ([],typerep_tyname)

    (* Return the size of a numeric SCON *)

    fun sizeof (CONSTYPE ([],tyname)) = tyname_sizeof tyname
    |   sizeof (META_OVERLOADED (ref ty, _, _, _)) = sizeof ty
    |   sizeof _ = NONE


    (* Return the type of a SCON *)

    fun type_of (Ident.INT (_, loc)) =
	  META_OVERLOADED
	    (ref NULLTYPE, Ident.int_literal_tyvar,
	     Ident.VAR (Ident.Symbol.find_symbol ""),
	     loc)
      | type_of (Ident.REAL (_, loc)) =
	  META_OVERLOADED
	    (ref NULLTYPE, Ident.real_literal_tyvar,
	     Ident.VAR (Ident.Symbol.find_symbol ""),
	     loc)
      | type_of (Ident.STRING _) = string_type
      | type_of(Ident.CHAR _) = char_type
      | type_of(Ident.WORD (_, loc)) =
	  META_OVERLOADED
	    (ref NULLTYPE, Ident.word_literal_tyvar,
	     Ident.VAR (Ident.Symbol.find_symbol ""),
	     loc)

    fun cons_typep (CONSTYPE _) = true
      | cons_typep _ = false 

    (****
     the_type determines the type that a flexible type has been instantiated
     to; or if it is uninstantiated the flexible type itself.
     ****)

    fun the_type (atype as (METATYVAR (ref (_,NULLTYPE,_),_,_))) = atype
      | the_type (METATYVAR (ref (_,atype,_),_,_)) = the_type atype
      | the_type (atype as (META_OVERLOADED {1=ref NULLTYPE,...})) = atype
      | the_type (META_OVERLOADED {1=ref atype,...}) = the_type atype
      | the_type (METARECTYPE (ref (_,true,atype as METARECTYPE _,_,_))) = the_type atype
      | the_type (atype as METARECTYPE (ref (_,true,_,_,_))) = atype
      | the_type (METARECTYPE (ref (_,false,atype,_,_))) = atype
      | the_type (atype) = atype

    fun check_debruijns([], _) = true
      | check_debruijns(DEBRUIJN(n, _, _,_) :: t, n') =
	n = n' andalso check_debruijns(t, n+1)
      | check_debruijns _ = false

    fun valid_to_string (Ident.VAR(sym)) = Ident.Symbol.symbol_name(sym)
      | valid_to_string (Ident.CON(sym)) = Ident.Symbol.symbol_name(sym)
      | valid_to_string (Ident.EXCON(sym)) = Ident.Symbol.symbol_name(sym)
      | valid_to_string _ = Crash.impossible "valid_to_string:types"

    fun tyfun_strip(ETA_TYFUN (METATYNAME {1=ref tyfun, ...})) 
                                                = tyfun_strip tyfun
      | tyfun_strip(TYFUN (ty, i)) =
        (case simplify_type ty of
           ty' as CONSTYPE (types, tyname) => 
             if tyname_arity tyname = i andalso check_debruijns(types, 0) 
               then
                 (case tyname of
                    METATYNAME{1=ref tyfun, ...} => tyfun_strip tyfun
                  | tyname => ETA_TYFUN tyname)
             else TYFUN (ty',i)
                  | ty' => TYFUN (ty',i))
      | tyfun_strip tyfun = tyfun
        
    and tyname_strip (METATYNAME{1=ref(ETA_TYFUN tyname), ...}) = tyname_strip tyname
      | tyname_strip(tyname as METATYNAME{1=ref(TYFUN(CONSTYPE(types, tyname'), i)), ...})=
	if tyname_arity tyname = i andalso check_debruijns(types, 0) 
          then tyname_strip tyname'
	else tyname
      | tyname_strip tyname = tyname
 
    and has_ref_equality tyname =
      tyname_eq(ref_tyname, tyname) orelse
      tyname_eq(array_tyname, tyname) orelse
      tyname_eq(bytearray_tyname, tyname) orelse
      tyname_eq(floatarray_tyname, tyname)

    and has_int_equality tyname =
      tyname_eq(tyname, int_tyname) orelse
      tyname_eq(tyname, int8_tyname) orelse
      tyname_eq(tyname, int16_tyname) orelse
      tyname_eq(tyname, char_tyname) orelse
      tyname_eq(tyname, word8_tyname) orelse
      tyname_eq(tyname, word16_tyname) orelse
      tyname_eq(tyname, word_tyname)

    and has_real_equality tyname =
      (tyname_eq(tyname, real_tyname) orelse
       tyname_eq(tyname, float32_tyname))

    and has_string_equality tyname =
      tyname_eq(tyname, string_tyname) orelse
      tyname_eq(tyname, int64_tyname) orelse
      tyname_eq(tyname, word64_tyname)

    and has_int32_equality tyname =
      tyname_eq(tyname, int32_tyname) orelse
      tyname_eq(tyname, word32_tyname)

    (* We might be able to use this instead of type_strip *)
    (* Currently used for type printing *)
        
    and simplify_type (ty as METATYVAR(ref(_, ty',_), _, _)) =
      (case ty' of
	 NULLTYPE => ty
       | _ => simplify_type ty')
      | simplify_type(ty as META_OVERLOADED {1=ref ty',...}) =
	(case ty' of
	   NULLTYPE => ty
	 | _ => simplify_type ty')
      | simplify_type (METARECTYPE (ref (i,b1,ty,eq,imp))) =
        if b1 then simplify_type ty
        (* We could update the ref here *)
        else METARECTYPE (ref (i,b1,simplify_type ty,eq,imp))
      | simplify_type (RECTYPE map) =
        RECTYPE (NewMap.map simplify_type_map map)
      | simplify_type (FUNTYPE (ty1,ty2)) =
        FUNTYPE (simplify_type ty1,simplify_type ty2)
      | simplify_type(ty as CONSTYPE(l, METATYNAME{1 = ref tyfun, ...})) =
	(case tyfun of
	   NULL_TYFUN _ => ty
	 | _ => simplify_type(apply (tyfun, l)))
      | simplify_type ty = ty

    and simplify_type_map(_, ty) = simplify_type ty

    and type_strip(ty as METATYVAR(ref(_, ty',_), _, _)) =
      (case ty' of
	 NULLTYPE => ty
       | _ => type_strip ty')
      | type_strip(ty as META_OVERLOADED {1=ref ty',...}) =
	(case ty' of
	   NULLTYPE => ty
	 | _ => type_strip ty')
      (* Should this leave uninstantiated metarecs alone? *)
      | type_strip(METARECTYPE(ref{3 = ty, ...})) = type_strip ty
      | type_strip(ty as CONSTYPE(l, METATYNAME{1 = ref tyfun, ...})) =
	(case tyfun of
	   NULL_TYFUN _ => ty
	 | _ => type_strip(apply (tyfun, l)))
      | type_strip ty = ty

    (****
     type_equalityp determines the equality attribute of a type.
     ****)

    and type_equalityp (TYVAR (_,Ident.TYVAR (_,eq,_))) = eq
      | type_equalityp (METATYVAR (ref (_,NULLTYPE,_),eq,_)) = eq
      | type_equalityp (METATYVAR (ref (_,t,_),_,_)) = type_equalityp t
      | type_equalityp (META_OVERLOADED _) = true
      | type_equalityp (METARECTYPE (ref (_,_,t,_,_))) = type_equalityp t
      | type_equalityp (CONSTYPE ([],n)) = eq_attrib n
      | type_equalityp (CONSTYPE (tylist as h::t,n)) =
	has_ref_equality n
	orelse
	((eq_attrib n) andalso (List.all type_equalityp tylist))
      | type_equalityp (RECTYPE amap) = NewMap.forall type_equalityp_forall amap
      | type_equalityp (FUNTYPE _) = false
      | type_equalityp (DEBRUIJN _) = true
      | type_equalityp NULLTYPE = true
  
    and type_equalityp_forall(_, ty) = type_equalityp ty

    (* exactly the same as above, but eq attribs of debruijns are noticed *)
    and closed_type_equalityp (TYVAR (_,Ident.TYVAR (_,eq,_))) = eq
      | closed_type_equalityp (METATYVAR (ref (_,NULLTYPE,_),eq,_)) = eq
      | closed_type_equalityp (METATYVAR (ref (_,t,_),_,_)) = closed_type_equalityp t
      | closed_type_equalityp (META_OVERLOADED _) = true
      | closed_type_equalityp (METARECTYPE (ref (_,_,t,_,_))) = closed_type_equalityp t
      | closed_type_equalityp (CONSTYPE ([],n)) = eq_attrib n
      | closed_type_equalityp (CONSTYPE (tylist as h::t,n)) =
	has_ref_equality n
	orelse
	((eq_attrib n) andalso (List.all closed_type_equalityp tylist))
      | closed_type_equalityp (RECTYPE amap) =
	NewMap.forall closed_type_equalityp_forall amap
      | closed_type_equalityp (FUNTYPE _) = false
      | closed_type_equalityp (DEBRUIJN (_,eq,_,_)) = eq
      | closed_type_equalityp NULLTYPE = true
  
    and closed_type_equalityp_forall(_, ty) = closed_type_equalityp ty

    and eq_attrib (TYNAME (_,_,_,ref eq,_,_,_,_,_)) = eq
      | eq_attrib (METATYNAME (ref (NULL_TYFUN _),_,_,ref eq,_,_)) = eq
      | eq_attrib (METATYNAME (ref tyfun,_,_,_,_,_)) = equalityp tyfun

    and equalityp (TYFUN (atype,a)) = type_equalityp atype
      | equalityp (ETA_TYFUN (tyname)) = eq_attrib tyname
      | equalityp (NULL_TYFUN (_)) = false

    (* Equality between types *)

    and tyfun_eq(tyfun, tyfun') =
      let
        val tyfun = tyfun_strip tyfun
        val tyfun' = tyfun_strip tyfun'
      in
        (* MLWorks.IO.output (MLWorks.IO.std_out, string_tyfun tyfun ^ "&" ^ string_tyfun tyfun' ^ "\n"); *)
        tyfun_eq' (tyfun,tyfun')
      end

    and tyfun_eq' (t as TYFUN (atype,a),t' as TYFUN (atype',a')) =
      (a = a' andalso type_eq (atype,atype',false,false))
      | tyfun_eq' (t as ETA_TYFUN(tyname as TYNAME{1=tyname_id, ...}),
		   t' as ETA_TYFUN(tyname' as TYNAME{1=tyname_id', ...})) = 
        Stamp.stamp_eq(tyname_id, tyname_id')
      | tyfun_eq' (t as NULL_TYFUN (id,_),t' as NULL_TYFUN (id',_)) = id = id'
      | tyfun_eq' (tyfun,tyfun') = false

    and tyname_eq(tyname, tyname') =
      tyname_eq'(tyname_strip tyname, tyname_strip tyname')

    and tyname_eq' (t as TYNAME (id,_,_,_,_,_,_,_,_),
                    t' as TYNAME (id',_,_,_,_,_,_,_,_)) =
      (*Stamp.stamp_eq (id,id')*) id = id'

      | tyname_eq' (t as METATYNAME{1=ref tyfun, 3=arity, 4=eq, ...},
		   t' as METATYNAME{1=ref tyfun', 3=arity', 4=eq', ...}) = 
        tyfun_eq (tyfun,tyfun')
      | tyname_eq' (t,t') = 
        false

    and type_eq' (t as TYVAR (_,Ident.TYVAR (sym,eq,imp)),
		 t' as TYVAR (_,Ident.TYVAR (sym',eq',imp')),
		 eq_matters,imp_matters) =
      (sym = sym') 
      andalso
      (if eq_matters then eq = eq' else true)
      andalso
      (if imp_matters then imp = imp' else true)
      | type_eq' (t as FUNTYPE(ty1,ty2),t' as FUNTYPE(ty1',ty2'),
                 eq_matters,imp_matters) = 
        type_eq (ty1,ty1',eq_matters,imp_matters)
        andalso
        type_eq (ty2,ty2',eq_matters,imp_matters)
      | type_eq' (t as CONSTYPE(l,name as METATYNAME{1=ref (NULL_TYFUN _),...}),
                 t' as CONSTYPE(l',name' as METATYNAME{1=ref (NULL_TYFUN _),
                                                      ...}),
		 eq_matters,imp_matters) =
        let
          fun collect ([],[]) = true
            | collect ([],h::t) = false
            | collect (h::t,[]) = false
            | collect (h::t,h'::t') = 
              type_eq (h,h',eq_matters,imp_matters) andalso collect (t,t')
        in
          tyname_eq (name,name') andalso collect (l,l')
        end
      | type_eq' (t as CONSTYPE (tylist,name as METATYNAME 
			        {1=ref(NULL_TYFUN _), ...}),
		 t' as CONSTYPE (tylist',name'),
		 eq_matters,imp_matters) =
	let 
	  fun collect ([],[]) = true
	    | collect ([],h::t) = false
	    | collect (h::t,[]) = false
	    | collect (h::t,h'::t') = 
	      (type_eq (h,h',eq_matters,imp_matters)) andalso (collect (t,t'))
	in
	  (tyname_eq (name,name')) andalso (collect (tylist,tylist'))
	end
      | type_eq' (t as CONSTYPE (tylist,name),
		 t' as CONSTYPE (tylist',
			         name' as METATYNAME{1=ref(NULL_TYFUN _),...}),
		 eq_matters,imp_matters) =
	let 
	  fun collect ([],[]) = true
	    | collect ([],h::t) = false
	    | collect (h::t,[]) = false
	    | collect (h::t,h'::t') = 
	      (type_eq (h,h',eq_matters,imp_matters)) andalso (collect (t,t'))
	in
	  (tyname_eq (name,name')) andalso (collect (tylist,tylist'))
	end
      | type_eq' (t as CONSTYPE ([],tyname),t' as CONSTYPE ([],tyname'),_,_) =
	tyname_eq (tyname,tyname')
      | type_eq' (ty as CONSTYPE (tylist as h::t,tyname),
		 ty' as CONSTYPE (tylist' as h'::t',tyname'),
		 eq_matters,imp_matters) = 
	let 
	  fun collect ([],[]) = true
	    | collect ([],h::t) = false
	    | collect (h::t,[]) = false
	    | collect (h::t,h'::t') = 
	      (type_eq (h,h',eq_matters,imp_matters)) andalso (collect (t,t'))
	in
	  (tyname_eq (tyname,tyname')) andalso (collect (tylist,tylist'))
	end
      | type_eq' (t as RECTYPE amap,t' as RECTYPE amap',eq_matters,imp_matters)=
	NewMap.eq (fn (x,y) => type_eq (x,y,eq_matters,imp_matters)) (amap, amap')
      | type_eq' (t as DEBRUIJN (d,eq,imp,_),t' as DEBRUIJN (d',eq',imp',_),
		 eq_matters,imp_matters) =
	d = d'
	andalso
	if eq_matters then eq = eq' else true
	andalso
	if imp_matters then imp = imp' else true
      | type_eq' (NULLTYPE,NULLTYPE,_,_) = true
      | type_eq' (METATYVAR (t as ref (_,NULLTYPE,_),_,_),
		  METATYVAR (t' as ref (_,NULLTYPE,_),_,_),_,_) = 
	(t = t')
      | type_eq' (META_OVERLOADED {1 = t as ref NULLTYPE,...}, 
		  META_OVERLOADED {1 = t' as ref NULLTYPE,...},_,_) = 
	(t = t')
      | type_eq' (ty,ty',_,_) = 
	false

    and type_eq(ty, ty', eq_matters, imp_matters) =
      let
	val ty = type_strip ty
	val ty' = type_strip ty'
      in
	type_eq'(ty, ty', eq_matters, imp_matters)
      end

    (* Printing functions *)
    and string_tyfun (TYFUN (aty,n)) = 
      concat ["LAMBDA{", Int.toString n, "}.", extra_debug_print_type aty]
      | string_tyfun (ETA_TYFUN aname) = 
	concat ["ETA{", Int.toString (tyname_arity aname), "}.", debug_print_name aname]
      | string_tyfun (NULL_TYFUN (id,_)) = 
	concat ["NULL_TYFUN", Stamp.string_stamp id]

    and print_name' show_eq_info
                    (tyname as TYNAME (stamp,name,_,ref eq,_,_,_,_,_)) =
      let
        val real_name =
	  (*
          if tyname_eq (tyname,bool_tyname) then "bool"
          else if tyname_eq (tyname,real_tyname) then "real"
          else if tyname_eq (tyname,int_tyname) then "int"
          else if tyname_eq (tyname,string_tyname) then "string"
          else if tyname_eq (tyname,exn_tyname) then "exn"
          else *) name
      in
	real_name ^ 
        (if show_eq_info then
           if eq then "[t]" else "[f]"
         else "") 
      end
      | print_name' show_eq_info
                    (METATYNAME (ref (NULL_TYFUN id),name,_,ref eq,_,_)) = 
        name ^ (if show_eq_info then
                  if eq then "[t]" else "[f]"
                else "")
      | print_name' show_eq_info (METATYNAME (ref tyfun,name,_,_,_,_)) =
        name ^ (if show_eq_info then
                  if equalityp tyfun then "[t]" else "[f]"
                else "")
	   
    and print_name options t = 
      let val Options.OPTIONS{print_options=Options.PRINTOPTIONS
                              {show_eq_info,...},...}=options
        in
          print_name' show_eq_info t
      end

    and debug_print_ve (ve as ref(VE(_,map))) =
      if generate_moduler_debug then
        "VE%" ^
        NewMap.fold 
        (fn (str,v,t) => 
         str^"\n" ^ valid_to_string v ^ ":" ^
         (case t of
            SCHEME (_,(t,_))=>"SCHEME:" ^ extra_debug_print_type t
          | UNBOUND_SCHEME (t,_)=>"UNBOUND_SCHEME:" ^ extra_debug_print_type t
          | OVERLOADED_SCHEME _ => "OVERLOADED_SCHEME"))
        ("",map) ^
        "]"
      else ""
        
    (* A more verbose tyname printer *)
    and debug_print_name (TYNAME (id,name,_,ref eq,ve,location,_,_,_)) =
      "TYNAME" ^ Stamp.string_stamp id ^ "(" ^ name ^ ")" ^
      (if eq then "[t]" else "[f]") ^ debug_print_ve ve
      | debug_print_name (METATYNAME (tf as ref (NULL_TYFUN (id,_)),name,_,ref eq,ve,_)) = 
        "METATYNAME" ^  Stamp.string_stamp id ^ "(" ^ name ^ ")" ^ (if eq then "[t]" else "[f]") ^
        debug_print_ve (ve)
      | debug_print_name (METATYNAME (ref tyfun,name,_,_,ve,_)) =
	"METATYNAME{" ^ string_tyfun tyfun ^ "}" ^ "(" ^ name ^ ")" ^ debug_print_ve ve
	   
    and make_string n =
      let 
	val rep =  (n-1) div 26
	val char_no = 97 + ((n-1) mod 26)
	fun rep_chars (~1,c,s) = s
	    | rep_chars (rep,c,s) = rep_chars (rep-1,c,c^s)
      in
	rep_chars (rep,(str o chr) char_no,"")
      end
	
    and find_depth (_,0,[]) = 0
      | find_depth (t,n,t'::ts') = if type_eq (t,t',true,true)
				     then
				       n
				   else
				     find_depth (t,n-1,ts')
      | find_depth (_,_,_) = Crash.impossible "Types.find_depth" 
	
    and string_metatyvar (options,t as (METATYVAR (_,eq,imp)),depth,metastack)=
      let 
        val Options.OPTIONS{compat_options=
                            Options.COMPATOPTIONS{old_definition,...},...}=
          options
	val how_deep = find_depth (t,depth,metastack)
	val meta_str = if do_debug then "meta-" else ""
	val (alpha,new_depth,new_metas) = 
	  if how_deep = 0
	    then
	      (meta_str ^ (make_string (depth+1)),depth+1,t::metastack)
	  else
	    (meta_str ^ (make_string how_deep),depth,metastack)
	val eq_bit = if eq then "'" else ""
	val imp_bit = if imp andalso old_definition then "_" else ""
      in
	("'"^ eq_bit ^ imp_bit ^ alpha,new_depth,new_metas)
      end 
      | string_metatyvar (_,depth,metastack,_) =
	Crash.impossible "Types.string_metatyvar"    
	  
    and string_debruijn (options,depth,eq,imp) =
      let
        val Options.OPTIONS{compat_options=
                            Options.COMPATOPTIONS{old_definition,...},...}=
          options
      in
        "'" ^ (if eq then "'" else "") ^ 
        (if imp andalso old_definition then "_" else "") ^
        (if do_debug then "deb-" else "") ^ make_string (depth+1)
      end
    
    and string_constype (options,t as (CONSTYPE ([],name)),depth,stack,
                         acc_string,_) = 
      if acc_string = "" then
	(print_name options name,depth,stack)
      else
	("(" ^ acc_string ^ ")" ^ (print_name options name),depth,stack)

      |  string_constype (options,CONSTYPE ([h],name),depth,stack,
                          acc_string,extras) =
	  let 
	    val (s,depth,stack) = string_types (options,h,depth,stack,extras)
	  in
	    if acc_string = ""
              then 
                if is_a_function_type h
                  then
                    (concat ["(",s,") ",print_name options name],depth,stack)
                else
                  (concat [s," ",print_name options name],depth,stack)
	    else
	      (concat ["(", acc_string, ", ", s, ") ", 
                        print_name options name],
	       depth,stack)
	  end

	| string_constype (options,CONSTYPE (h::t,name),depth,stack,
                           acc_string,extras) =
	  let 
	    val (s,depth,stack) = string_types (options,h,depth,stack,extras)
	  in
	    if acc_string = "" then 
	      string_constype (options,CONSTYPE (t, name),depth,stack,s,extras)
	    else
	      string_constype (options,CONSTYPE (t,name),
			       depth,stack,acc_string ^ ", " ^ s,extras)
	  end
      | string_constype _ = Crash.impossible "Types.string_constype"
	
    and is_a_function_type (FUNTYPE _) = true
      | is_a_function_type (METATYVAR 
                            (ref (_,NULLTYPE,_),_,_)) = false
      | is_a_function_type (METATYVAR (ref (_,ty,_),_,_)) = 
        is_a_function_type ty
      | is_a_function_type _ = false

    and is_a_record_type (RECTYPE _) = true
      | is_a_record_type _ = false

    and string_rectype (options,amap,flexible,depth,stack,extras) =
	let
          val Options.OPTIONS
            {print_options=Options.PRINTOPTIONS{show_eq_info,...},...}=options
	  val stack_ref = ref stack
	  val depth_ref = ref depth
	  fun print_member t =
	    let 
	      val (s,new_depth,new_stack) =
		string_types(options,t,!depth_ref,!stack_ref,extras)
	    in
	      (stack_ref := new_stack;
	       depth_ref := new_depth;
	       s)
	    end
	  val len = NewMap.size amap
	  val is_a_tuple =
            not flexible andalso
	    let
	      fun check_elem 0 = true
		| check_elem n =
		  case NewMap.tryApply'(amap, Ident.LAB(Ident.Symbol.find_symbol
							(Int.toString
							 n))) of
		    NONE => false
		  | _ => check_elem(n-1)
	    in
	      len > 1 andalso check_elem len
	    end
	  fun print_as_a_tuple acc 0 = acc
	    | print_as_a_tuple acc n = 
	      let 
		val element_type =
		  NewMap.apply'(amap, Ident.LAB (Ident.Symbol.find_symbol
						 (Int.toString n)))
		val element_string =
		  if is_a_function_type element_type then
		    "(" ^ print_member element_type ^ ")"
		  else print_member element_type
	      in 
		if n = 1 then (element_string :: acc) else
		  print_as_a_tuple (" * " :: element_string :: acc) (n-1)
	      end
	in
	  if len = 0 then
	    (* for the empty tuple, "()" is wrong.  "unit" can be
	     * redefined, but it's what people usually expect to see. *)
            if show_eq_info then ("unit[t]",depth, stack)
	    else ("unit",depth,stack)
	  else
	    if is_a_tuple then 
	      (concat ("(" :: (print_as_a_tuple [")"] len)),
	       !depth_ref, !stack_ref)
	    else
	      (* not a tuple, so print labels *)
	      let
		val named_list =
		  map
		  (fn (lab,ty) => concat [IdentPrint.printLab lab,
					   ": ", print_member ty])
		  (NewMap.to_list_ordered amap)
		fun commas (_,[]) = 
		  Crash.impossible "Types.string_type.commas passed nil.\n"
		  | commas (acc,l as [x]) = rev ((if flexible then ", ...}" else "}")::x::acc)
		  | commas (acc,x::(xs as (y::ys))) =
		    commas (", "::x::acc, xs)
		val list_with_commas = commas (["{"],named_list)
	      in
		(concat list_with_commas,!depth_ref,!stack_ref)
	      end
	end
      
    and string_types (options,t as (METATYVAR (ref(_,NULLTYPE,_),_,_)),depth,stack,_) =
      string_metatyvar (options,t,depth,stack)
      | string_types (options,METATYVAR (ref(_,t,_),_,_),depth,stack,extras)=
	string_types (options,t,depth,stack,extras)
      | string_types (options,META_OVERLOADED (ref NULLTYPE, tv, _, _),
                      depth,stack,extras) =
	((IdentPrint.printTyVar tv),depth,stack)
      | string_types (options,META_OVERLOADED {1=ref t,...},depth,stack,
                      extras) =
	string_types (options,t,depth,stack,extras)
      | string_types (options,METARECTYPE (ref (_,true,t as METARECTYPE _,_,_)), depth,stack,extras) =
	string_types (options,t,depth,stack,extras)
      | string_types (options,METARECTYPE (ref (_,true,RECTYPE amap,_,_)),depth,stack,extras) =
	string_rectype (options,amap,true,depth,stack,extras)
      | string_types (options,METARECTYPE (ref (_,true,_,_,_)),depth,stack,
                      extras) =
        Crash.impossible "Types.string_types: bad METARECTYPE"
      | string_types (options,METARECTYPE (ref(_,false,t,_,_)),depth,stack,
                      extras) =
	string_types (options,t,depth,stack,extras)
      | string_types (options,DEBRUIJN (n,n',n'',_),depth,stack,_)=
	(string_debruijn (options,n,n',n''),depth,stack)
      | string_types (options,TYVAR (_,t),depth,stack,_) =
	((IdentPrint.printTyVar t),depth,stack)
      | string_types (options,NULLTYPE,depth,stack,_) = 
        ("Nulltype ",depth,stack)
      | string_types (options,FUNTYPE (a,r),depth,stack,extras)=
	let
	  val (s,d,m) = string_types (options,a,depth,stack,extras)
	  val (s',d',m') = string_types (options,r,d,m,extras)
	in
	  ((if is_a_function_type a
	      then "(" ^ s ^ ")"
	    else s)
	      ^ " -> " ^ s',d',m')
	end
      | string_types (options,t as (CONSTYPE (_,_)),depth,stack,extras)=
	string_constype (options,t,depth,stack,"",extras)
      | string_types (options,RECTYPE amap,depth,stack,extras)=
        string_rectype (options,amap,false,depth,stack,extras)

    and print_type options t =
      #1 (string_types (options,t,0,[],""))
                        

    and debug_print_type options t
                  = #1 (string_types (options,t,0,[],""))

      (****
       When applying type functions the argument types must be substituted for
       the debruijns.  Previously debruijns were substituted for type 
       variables when type functions were made.  See the function 
       make_tyfun.
       ****)

    and app_subst (DEBRUIJN (d,_,_,_),array_of_types) =
      MLWorks.Internal.Array.sub (array_of_types,d)
      | app_subst (RECTYPE (amap),array_of_types) =
	RECTYPE(NewMap.map (fn (_, x) => app_subst (x,array_of_types)) amap)
      | app_subst (FUNTYPE (atype,atype'),array_of_types) =
	FUNTYPE (app_subst (atype,array_of_types),
		 app_subst (atype',array_of_types))
      | app_subst (CONSTYPE (atylist,atyname),array_of_types) =
	let
	  val new_ty_list =
	    map (fn x => app_subst (x,array_of_types)) atylist
	in
	  case atyname of
	    TYNAME _ => CONSTYPE(new_ty_list, atyname)
	  | METATYNAME{1=ref(NULL_TYFUN _), ...} =>
	      CONSTYPE(new_ty_list, atyname)
	  | METATYNAME{1=ref tyfun, ...} =>
	      apply(tyfun, new_ty_list)
	end
      | app_subst (NULLTYPE,array_of_types) = NULLTYPE 
      (* for signature matching in funbinds *)
      | app_subst (ty as METATYVAR (ref (_,NULLTYPE,_),_,_),array_of_types) =
	ty
      | app_subst (METATYVAR (ref (_,ty,_),_,_),array_of_types) = 
	app_subst (ty,array_of_types)
      | app_subst (ty as META_OVERLOADED{1=ref ty',...}, array_of_types) =
	(case ty' of
	   NULLTYPE => ty
	 | _ => app_subst(ty', array_of_types))
      | app_subst (ty as METARECTYPE _,_) = ty
      | app_subst (ty as TYVAR _,_) = ty

    and apply (TYFUN (atype,0),[]) = atype
      | apply (TYFUN (atype,arity),tylist) =
      if arity = length tylist
	then app_subst (atype,MLWorks.Internal.Array.arrayoflist (tylist))
      else raise WrongArity
      | apply (ETA_TYFUN (name as METATYNAME {1=ref (NULL_TYFUN _), ...}),
	       tylist) =
        CONSTYPE (tylist,name)
      | apply (ETA_TYFUN (METATYNAME {1=ref tyfun, ...}),tylist) =
	apply (tyfun,tylist)
      | apply (ETA_TYFUN (tyname),tylist) =
	CONSTYPE (tylist,tyname)
      | apply (NULL_TYFUN _,_) = raise NullTyfun


    and print_bool true = "true"
      | print_bool false = "false"

    and extra_debug_print_type(METATYVAR(ref (i, ty,_), b1, b2)) =
      "METATYVAR(ref(" ^ Int.toString i ^ ", " ^ extra_debug_print_type ty ^
      "), " ^ print_bool b1 ^ ", " ^ print_bool b2 ^ ")"
      | extra_debug_print_type(META_OVERLOADED(ref ty, tyvar, _, _)) =
	"META_OVERLOADED(ref " ^ extra_debug_print_type ty ^ ", " ^
	IdentPrint.printTyVar tyvar ^ ")"
      | extra_debug_print_type(TYVAR(ref (i,_,_), tyvar)) =
	"TYVAR(ref " ^ Int.toString i ^ ", " ^
	IdentPrint.printTyVar tyvar ^ ")"
      | extra_debug_print_type(METARECTYPE(ref(i, b1, ty, b2, b3))) =
	"METARECTYPE(ref(" ^ Int.toString i ^ ", " ^
	print_bool b1 ^ ", " ^ extra_debug_print_type ty ^ ", " ^ print_bool b2 ^
	", " ^ print_bool b3 ^ "))"
      | extra_debug_print_type(RECTYPE map) =
	NewMap.string
	IdentPrint.printLab
	extra_debug_print_type
	{start="RECTYPE(", domSep=", ", itemSep="", finish=")"}
	map
      | extra_debug_print_type(FUNTYPE(ty1, ty2)) =
	"FUNTYPE(" ^ extra_debug_print_type ty1 ^ ", " ^ extra_debug_print_type ty2 ^ ")"
      | extra_debug_print_type(CONSTYPE(ty_list, tyname)) =
	"CONSTYPE(" ^ concat(map extra_debug_print_type ty_list) ^ ", " ^
	debug_print_name tyname ^ ")"
      | extra_debug_print_type(DEBRUIJN(i, b1, b2,_)) =
	"DEBRUIJN(" ^ Int.toString i ^ ", " ^ print_bool b1 ^
	", " ^ print_bool b2 ^ ")"
      | extra_debug_print_type NULLTYPE = "NULLTYPE"

    (****
     Used in Realise to determine whether a tyname has been instantiated 
     before meta_tyname (tyfun) is called.
     ****)

    fun null_tyfunp(NULL_TYFUN _) = true
      | null_tyfunp(ETA_TYFUN(METATYNAME{1=ref tyfun, ...})) =
	null_tyfunp tyfun
      | null_tyfunp _ = false

    fun resolve_overloading
      (default_overloads, ty, error_fn) =
      let
        fun resolve_ty
              (META_OVERLOADED
	       (r as ref NULLTYPE, tv, valid, loc)) =
	  if default_overloads then
            if tv = Ident.int_literal_tyvar then
              (r := int_type)
            else if tv = Ident.real_tyvar orelse
	       tv = Ident.real_literal_tyvar then
              (r := real_type)
            else if tv = Ident.word_literal_tyvar then
              (r := word_type)
            else if tv = Ident.num_tyvar then
              (r := int_type)
            else if tv = Ident.numtext_tyvar then
              (r := int_type)
            else if tv = Ident.wordint_tyvar then
              (r := int_type)
            else if tv = Ident.realint_tyvar then
              (r := int_type)
            else
              ()
          else
	    if tv = Ident.int_literal_tyvar then
	      r := int_type
	    else if tv = Ident.real_literal_tyvar then
	      r := real_type
	    else if tv = Ident.word_literal_tyvar then
	      r := word_type
            else
	      error_fn (valid, loc)
	  | resolve_ty (META_OVERLOADED {1=ref ty,...}) =
	    resolve_ty ty
	  | resolve_ty (METATYVAR (ref (_,ty,_),_,_)) =
	    resolve_ty ty
	  | resolve_ty (METARECTYPE (ref (_,true,ty as METARECTYPE _,_,_))) =
	    resolve_ty ty
	  | resolve_ty (METARECTYPE (ref (_,_,ty,_,_))) =
	    resolve_ty ty
	  | resolve_ty (RECTYPE amap) =
	    (ignore(NewMap.map resolve_ty_map amap); ())
	  | resolve_ty (FUNTYPE(arg, res)) =
	    (resolve_ty arg;
	     resolve_ty res)
	  | resolve_ty (CONSTYPE (tylist, tyname)) =
	    app resolve_ty tylist
	  | resolve_ty ty = ()

	and resolve_ty_map(_, ty) = resolve_ty ty
      in
        resolve_ty ty
      end

    (****
     imperativep determine the imperative attribute of a type.
     ****)

    fun imperativep (TYVAR (_,Ident.TYVAR (_,_,imp))) = imp
      | imperativep (METATYVAR (ref (_,NULLTYPE,_),_,imp)) = imp
      | imperativep (METATYVAR (ref (_,t,_),_,_)) = imperativep t
      | imperativep (META_OVERLOADED _) = true
      | imperativep (METARECTYPE (ref (_,_,t,_,_))) = imperativep t
      | imperativep (CONSTYPE (tylist,METATYNAME{1=ref tyfun, ...})) =
	(imperativep (apply (tyfun,tylist)) handle NullTyfun => true)
      | imperativep (CONSTYPE ([],n)) = true
      | imperativep (CONSTYPE (tylist as h::t,n)) =
	  List.all imperativep tylist
      | imperativep (RECTYPE amap) = NewMap.forall imperativep_forall amap
      | imperativep (FUNTYPE (a,r)) = (imperativep a) andalso (imperativep r)
      | imperativep (DEBRUIJN (_,_,imp,_)) = imp 
      | imperativep NULLTYPE = true

    and imperativep_forall(_, ty) = imperativep ty

    fun get_type_from_lab' (lab,RECTYPE amap) = NewMap.apply' (amap, lab)
      | get_type_from_lab' (lab,METARECTYPE (ref(_,_,t,_,_))) =
	get_type_from_lab' (lab,t)
      | get_type_from_lab' (lab,_) = Crash.impossible "Types.get_type_from_lab"

    and get_type_from_lab (lab,atype) = 
      get_type_from_lab' (lab,atype)

    fun add_to_rectype (lab,value,RECTYPE(amap)) =
      RECTYPE(NewMap.define'(amap, (lab,value)))
      | add_to_rectype (lab,value,_) = Crash.impossible "Types.add_to_rectype"

    val empty_rectype = RECTYPE(NewMap.empty' Ident.lab_lt)
      
    fun rectype_domain (RECTYPE(amap)) =
      NewMap.domain amap
      | rectype_domain _ = Crash.impossible "Types.rectype_domain"

    fun rectype_range (RECTYPE(amap)) =
      NewMap.range amap
      | rectype_range _ = Crash.impossible "Types.rectype_range"

    fun make_tyvars n =
      let
        fun name n =
          if n < 26 then
            (str o chr) (ord #"a" + n)
          else
            (str o chr) (ord #"a" + (n mod 26)) ^ name (n div 26)

        fun make_tyvar n =
          TYVAR (ref (0,NULLTYPE,NO_INSTANCE), 
                 Ident.TYVAR (Ident.Symbol.find_symbol ("'" ^ name n),
                                                    true,
                                                    true))

        fun make_tyvars' (list, 0) = list
          | make_tyvars' (list, n) =
            make_tyvars' (make_tyvar (n-1) :: list, n-1)
      in
        make_tyvars' ([], n)
      end

    fun print_tyvars _ [] = ""
      | print_tyvars options [tyvar] =
                     debug_print_type options tyvar
      | print_tyvars options l =
        let 
          fun print_tyvars' options [] = [")"]
            | print_tyvars' options [tyvar] =
              [debug_print_type options tyvar ,")"]
            | print_tyvars' options (tyvar::tyvars) =
              debug_print_type options tyvar
                   :: ", " :: (print_tyvars' options tyvars)
        in
          concat ("(" :: print_tyvars' options l)
        end

    local
	  
      (****
       In making a type function debruijns are used as place holders for type
       variables.
       ****)

      fun make_substlist ([],n,list_acc) = list_acc
	| make_substlist (h::t,n,list_acc) =
	  let
	    val new_debruijn = DEBRUIJN (n,true,true,NONE) (* arbitrary choice *)
	  in
	    make_substlist (t,n+1,(h,new_debruijn)::list_acc)
	  end
	
      fun subst (_,[]) = Crash.impossible "Types.subst 1"
	| subst (atyvar as TYVAR (_,Ident.TYVAR (id,eq,imp)),
		 (Ident.TYVAR (id',eq',imp'),adebruijn)::t) =
	  if id = id'
	    then 
	      adebruijn
	  else
	    subst (atyvar,t)
	| subst (_,_) = Crash.impossible "Types.subst 2"
	  
      fun make_new_type (tyvar as TYVAR (_,atyvar),substlist) =
	subst (tyvar,substlist)
	| make_new_type (RECTYPE (amap),substlist) =
	  RECTYPE (NewMap.map (fn (_, x) => 
                               make_new_type (x,substlist)) amap)
	| make_new_type (FUNTYPE (atype,atype'),substlist) =
	  FUNTYPE (make_new_type (atype,substlist),
		   make_new_type (atype',substlist))
	| make_new_type (CONSTYPE (atylist,atyname),substlist) =
	  CONSTYPE (map
		    (fn x => make_new_type (x,substlist))
		    atylist,atyname)
	| make_new_type (NULLTYPE,substlist) = NULLTYPE 
	| make_new_type (ty as METATYVAR _, _) = ty
	| make_new_type (ty, substlist) =
	  Crash.impossible("Types.make_new_type with type = " ^
			   debug_print_type Options.default_options ty ^ "\n")
            (* use default_options because this error should never occur *)
	  
    in
      
      fun make_tyfun ([],atype) = TYFUN (atype,0)
	| make_tyfun (tyvarlist,atype) =
	  let
	    val substlist = make_substlist (tyvarlist,0,[])
	  in 
	    TYFUN (make_new_type (atype,substlist),
                   length tyvarlist)
	  end
    end
  
    (****
     eta-convertible type function
     ****)

    fun make_eta_tyfun (tyname) = ETA_TYFUN (tyname)

    (****
     Follow the pointers to the last uninstantiated METATYNAME.
     ****)
    fun meta_tyname(ETA_TYFUN(meta as METATYNAME{1=ref(NULL_TYFUN _),
						 ...})) = meta
      | meta_tyname(ETA_TYFUN(METATYNAME{1=ref tyfun, ...})) =
	meta_tyname tyfun
      | meta_tyname _ = Crash.impossible "Types.meta_tyname"

    fun arity (TYFUN (atype,a)) = a
      | arity (ETA_TYFUN (t)) = tyname_arity t 
      | arity (NULL_TYFUN (_)) = 0
	
    fun int_typep (CONSTYPE ([],name)) =
      tyname_eq(name,int_tyname) orelse
      tyname_eq(name,int8_tyname) orelse
      tyname_eq(name,int16_tyname) orelse
      tyname_eq(name,int32_tyname) orelse
      tyname_eq(name,int64_tyname)
      | int_typep (META_OVERLOADED {1=ref t,...}) = int_typep t
      | int_typep _ = false

    fun real_typep (CONSTYPE ([],name)) =
      tyname_eq(name,real_tyname) orelse
      tyname_eq(name,float32_tyname)
      | real_typep (META_OVERLOADED {1=ref t,...}) = real_typep t
      | real_typep _ = false

    fun word_typep (CONSTYPE ([],name)) =
      tyname_eq(name,word_tyname) orelse
      tyname_eq(name,word8_tyname) orelse
      tyname_eq(name,word16_tyname) orelse
      tyname_eq(name,word32_tyname) orelse
      tyname_eq(name,word64_tyname)
      | word_typep (META_OVERLOADED {1=ref t,...}) = word_typep t
      | word_typep _ = false

    fun num_typep (ty as CONSTYPE ([],_)) =
      real_typep ty orelse int_typep ty orelse word_typep ty
      | num_typep (META_OVERLOADED {1=ref t,...}) = num_typep t
      | num_typep _ = false

    fun num_or_string_typep(ty as CONSTYPE([], name)) =
      tyname_eq(name, string_tyname) orelse
      tyname_eq(name, char_tyname) orelse
      num_typep ty
      | num_or_string_typep (META_OVERLOADED {1=ref t,...}) =
      num_or_string_typep t
      | num_or_string_typep _ = false

    fun wordint_typep ty = int_typep ty orelse word_typep ty

    fun realint_typep ty = int_typep ty orelse real_typep ty

    fun tyvar_equalityp (TYVAR (_,Ident.TYVAR (_,eq,_))) = eq
      | tyvar_equalityp (METATYVAR (ref (_,NULLTYPE,_),eq,_)) = eq
      | tyvar_equalityp (METATYVAR (ref (_,t,_),eq,_)) = 
                             tyvar_equalityp t
      | tyvar_equalityp t = 
        Crash.impossible ("tyvar_equalityp "^
                          (debug_print_type Options.default_options t))
                    (* see above for the "false" argument" *)

    (***
     Test if a type occurs within another type
     Used for finding xact location of free imperative type variable errors
     ***)

    fun type_occurs(ty, ty') =
      ((*output(std_out, "type_occurs checking ty1 = " ^
	Types.extra_debug_print_type ty ^ "\nwith ty2 = " ^
	Types.extra_debug_print_type ty' ^ "\n");*)
       type_eq(ty', ty, true, true) orelse occurs_in(ty, ty'))

    and occurs_in(ty, METATYVAR(ref(_, ty', _), _, _)) =
      type_occurs(ty, ty')
      | occurs_in(ty, META_OVERLOADED(ref ty', _, _, _)) =
	type_occurs(ty, ty')
      | occurs_in(ty, TYVAR(ref(_, ty', _), _)) = type_occurs(ty, ty')
      | occurs_in(ty, METARECTYPE(ref{3=ty', ...})) = type_occurs(ty, ty')
      | occurs_in(ty, RECTYPE lab_ty_map) =
	List.exists
	(fn ty' => type_occurs(ty, ty'))
	(NewMap.range lab_ty_map)
      | occurs_in(ty, FUNTYPE(ty', ty'')) =
	type_occurs(ty, ty') orelse type_occurs(ty, ty'')
      | occurs_in(ty, CONSTYPE(ty_list, _)) =
	List.exists
	(fn ty' => type_occurs(ty, ty'))
	ty_list
      | occurs_in(_, DEBRUIJN _) = false
      | occurs_in(_, NULLTYPE) = false

    (****
     Test for presence of imperative type variables.
     ****)
    (* This also checks for non-imperative tyvars, a check that is necessary *)
    (* for value-polymorphism and doesn't affect normal semantics *)
    fun has_free_imptyvars (ty as METATYVAR (ref (_,NULLTYPE,_),_,_)) =
      SOME ty
      | has_free_imptyvars (METATYVAR (ref (_,ty,_),_,_)) = has_free_imptyvars ty
      | has_free_imptyvars (ty as TYVAR (_,Ident.TYVAR (_,_,_))) =
	SOME ty
      | has_free_imptyvars (METARECTYPE (ref (_,true,t as METARECTYPE _,_,
                                              imp))) = has_free_imptyvars t
      | has_free_imptyvars (ty as METARECTYPE (ref (_,true,_,_,imp))) =
	SOME ty
      | has_free_imptyvars (METARECTYPE (ref (_,false,ty,_,_))) = 
	has_free_imptyvars ty
      | has_free_imptyvars (RECTYPE amap) = 
	NewMap.fold
	(fn (NONE, _, ty) => has_free_imptyvars ty
         | (found, _, _) => found)
	(NONE, amap)
      | has_free_imptyvars (FUNTYPE (arg,res)) = 
	(case has_free_imptyvars arg of
	   NONE => has_free_imptyvars res
	 | x => x)
      | has_free_imptyvars (CONSTYPE (tylist,name)) =
	let 
	  fun collect ([]) = NONE
	    | collect (h::t) =
	      case has_free_imptyvars h of
		NONE => collect t
	      | x => x
	in
	  collect (tylist)
	end
      | has_free_imptyvars _ = NONE
	
    (****
     Determine whether a type function is eta-convertible.
     ****)

    fun has_a_name (ETA_TYFUN (METATYNAME {1=ref(NULL_TYFUN _), ...})) = true
      | has_a_name (ETA_TYFUN (METATYNAME {1=ref tyfun, ...})) =
        has_a_name tyfun
      | has_a_name (ETA_TYFUN tyname) = true
      | has_a_name _ = false

    fun name (ETA_TYFUN (meta as METATYNAME {1=ref(NULL_TYFUN _),...})) = meta
      | name (ETA_TYFUN (METATYNAME {1=ref tyfun,...})) = name tyfun
      | name (ETA_TYFUN tyname) = tyname
      | name tyfun = Crash.impossible ("Types.name " ^ string_tyfun tyfun)

    (****
     Copying of Tynames, Types and Tyfuns - used when signatures are copied.
     ****)

    fun create_tyname_copy rigid level =
      let
        fun copy (tyname_copies,
                  METATYNAME (ref (NULL_TYFUN (id,tf)),printname,arity,
                              ref eq, ref ve,ref is_abs)) =
        (case Stamp.Map.tryApply'(tyname_copies,id) of
	   SOME _ => tyname_copies
	 | NONE =>
             let
               val newname =
                 if rigid
                   then TYNAME (Stamp.make_stamp(),printname,arity,ref eq,
                                ref ve,NONE,ref is_abs,
                                ref empty_valenv,level)
                 else METATYNAME (ref (NULL_TYFUN (Stamp.make_stamp (),tf)),
                                  printname,arity,ref eq, ref ve,ref is_abs)
             in
               Stamp.Map.define(tyname_copies, id, newname)
             end)

          | copy (tyname_copies,
                  METATYNAME {1 = ref (ETA_TYFUN (meta as 
                                                  METATYNAME {1 = ref tyfun,
                                                              ...})),...}) =
            copy (tyname_copies,meta)
          | copy (tyname_copies,METATYNAME _) = tyname_copies
          (* Need to copy the tynames too *)
          | copy (tyname_copies,TYNAME (id, name,arity, ref eq, ref ve1,
                                        loc, ref bool2, ref ve2,level)) =
            Stamp.Map.define (tyname_copies, id,
                              TYNAME (Stamp.make_stamp (), name, arity, 
                                      ref eq, ref ve1,loc, ref bool2, 
                                      ref ve2,level))
      in
        copy
      end

    fun type_has_unbound_tyvars(METATYVAR (ref (_,ty,_),_,_)) = 
        type_has_unbound_tyvars ty
      | type_has_unbound_tyvars (METARECTYPE (ref (_,false,ty,_,_))) = 
        type_has_unbound_tyvars ty
      | type_has_unbound_tyvars (RECTYPE amap) =
	NewMap.exists type_has_unbound_tyvars_exists amap
      | type_has_unbound_tyvars (FUNTYPE (ty,ty')) =
	type_has_unbound_tyvars ty orelse type_has_unbound_tyvars ty'
      | type_has_unbound_tyvars (CONSTYPE (l, name)) = 
	List.exists type_has_unbound_tyvars l orelse
	tyname_has_unbound_tyvars name
      | type_has_unbound_tyvars (ty as (TYVAR _)) = false
      | type_has_unbound_tyvars (ty as (DEBRUIJN _)) = false
      | type_has_unbound_tyvars ty = true

    and type_has_unbound_tyvars_exists(_, ty) = type_has_unbound_tyvars ty

    and tyname_has_unbound_tyvars (tyname as METATYNAME {1 = ref (NULL_TYFUN _), ...}) =
      false
      | tyname_has_unbound_tyvars (METATYNAME {1 = ref (ETA_TYFUN meta), ...}) =
	tyname_has_unbound_tyvars meta
      | tyname_has_unbound_tyvars (METATYNAME{1=ref tyfun, ...}) =
	tyfun_has_unbound_tyvars tyfun
      | tyname_has_unbound_tyvars tyname = false

    and tyfun_has_unbound_tyvars (ETA_TYFUN (METATYNAME {1=ref(NULL_TYFUN _), ...})) =
      false
      | tyfun_has_unbound_tyvars (ETA_TYFUN (METATYNAME{1 = ref tyfun, ...})) =
	tyfun_has_unbound_tyvars tyfun
      | tyfun_has_unbound_tyvars (TYFUN(CONSTYPE([], tyname), a)) =
	tyfun_has_unbound_tyvars(ETA_TYFUN tyname)
      | tyfun_has_unbound_tyvars (TYFUN(ty, a)) = type_has_unbound_tyvars ty
      | tyfun_has_unbound_tyvars tyfun = false

    fun type_copy (METATYVAR (ref (_,ty,_),_,_),tyname_copies) = type_copy (ty,tyname_copies)
      | type_copy (METARECTYPE (ref (_,false,ty,_,_)),tyname_copies) = type_copy (ty,tyname_copies)
      | type_copy (METARECTYPE (ref (_,true,ty,_,_)),tyname_copies) = Crash.impossible "Types.type_copy"
      | type_copy (RECTYPE amap,tyname_copies) =
	RECTYPE(NewMap.map (fn (_, ty) => type_copy(ty,tyname_copies)) amap)
      | type_copy (FUNTYPE (ty,ty'),tyname_copies) = FUNTYPE(type_copy (ty,tyname_copies), type_copy (ty',tyname_copies))
      | type_copy (CONSTYPE ([], name),tyname_copies) =
        CONSTYPE([], tyname_copy (name,tyname_copies))
      | type_copy (CONSTYPE (l, name),tyname_copies) =
        CONSTYPE(map (fn ty => type_copy (ty,tyname_copies)) l, tyname_copy (name,tyname_copies))
      | type_copy (ty as (TYVAR _),tyname_copies) = ty
      | type_copy (ty as (DEBRUIJN _),tyname_copies) = ty
      | type_copy (META_OVERLOADED {1=ref ty, ...},tyname_copies) = ty
      | type_copy (NULLTYPE, tyname_copies) = NULLTYPE

    and tyname_copy (tyname as METATYNAME {1 = ref (NULL_TYFUN (id,_)), ...},tyname_copies) =
      Stamp.Map.apply_default'(tyname_copies, tyname, id)
      | tyname_copy (METATYNAME {1 = ref (ETA_TYFUN meta), ...},tyname_copies) =
        tyname_copy (meta,tyname_copies)
      | tyname_copy (METATYNAME(ref tyfun, name, a, ref eq, ref ve,ref is_abs),tyname_copies) =
        METATYNAME(ref (tyfun_copy (tyfun,tyname_copies)), name, a, ref eq, ref ve,ref is_abs)
      | tyname_copy (tyname as TYNAME {1=id,...},tyname_copies) =
        Stamp.Map.apply_default'(tyname_copies, tyname, id)

    and tyfun_copy (ETA_TYFUN (meta as METATYNAME {1=ref (NULL_TYFUN _), ...}),tyname_copies) =
      ETA_TYFUN (tyname_copy (meta,tyname_copies))
      | tyfun_copy (ETA_TYFUN (METATYNAME {1 = ref tyfun, ...}), tyname_copies) = tyfun_copy (tyfun,tyname_copies)
      | tyfun_copy (ETA_TYFUN tyname,tyname_copies) = ETA_TYFUN (tyname_copy (tyname,tyname_copies))
      | tyfun_copy (TYFUN (CONSTYPE ([], tyname), a),tyname_copies) = tyfun_copy(ETA_TYFUN tyname,tyname_copies)
      | tyfun_copy (TYFUN(ty, a),tyname_copies) = TYFUN(type_copy (ty,tyname_copies), a)
      | tyfun_copy (tyfun,tyname_copies) = tyfun

(*
    val type_copy = fn (ty,copies) => (output(std_out,debug_print_type ty ^ "\n"); type_copy (ty,copies))
*)

    fun tyvars (tyvarlist, METATYVAR (ref (_,NULLTYPE,_),_,_)) = tyvarlist
      | tyvars (tyvarlist, METATYVAR (ref (_,atype,_),_,_)) = 
	tyvars (tyvarlist, atype)
      | tyvars (tyvarlist, TYVAR (_,tyvar)) = tyvar :: tyvarlist
      | tyvars (tyvarlist, METARECTYPE (ref (_,_,atype,_,_))) =
	tyvars (tyvarlist, atype)
      | tyvars (tyvarlist, RECTYPE amap) = 
	NewMap.fold
	tyvars_fold
	(tyvarlist, amap)
      | tyvars (tyvarlist, FUNTYPE (atype,atype')) = 
	tyvars (tyvars (tyvarlist, atype), atype')
      | tyvars (tyvarlist, CONSTYPE (tylist,_)) =
        Lists.reducel tyvars (tyvarlist, tylist)
      | tyvars (tyvarlist, _) = tyvarlist
	
    and tyvars_fold(tyvarlist, _, ty) = tyvars(tyvarlist, ty)

    local
     fun tyvars (tyvarlist, METATYVAR (tyvar as ref(_,NULLTYPE,_),_,_)) = tyvar::tyvarlist
       | tyvars (tyvarlist, TYVAR (tyvar as ref(_,NULLTYPE,_),_)) = tyvar :: tyvarlist
       | tyvars (tyvarlist, METATYVAR (tyvar as ref(_,ty,_),_,_)) = 
         tyvars (tyvarlist,ty)
       | tyvars (tyvarlist, TYVAR (tyvar as ref(_,ty,_),_)) = 
         tyvars (tyvarlist,ty)
       | tyvars (tyvarlist, METARECTYPE (ref (_,_,atype,_,_))) =
         tyvars (tyvarlist, atype)
       | tyvars (tyvarlist, RECTYPE amap) = 
         NewMap.fold
         tyvars_fold
         (tyvarlist, amap)
       | tyvars (tyvarlist, FUNTYPE (atype,atype')) = 
         tyvars (tyvars (tyvarlist, atype), atype')
       | tyvars (tyvarlist, CONSTYPE (tylist,_)) =
         Lists.reducel tyvars (tyvarlist, tylist)
       | tyvars (tyvarlist, DEBRUIJN(_,_,_,SOME tyvar)) = tyvar::tyvarlist
       | tyvars (tyvarlist, _) = tyvarlist

     and tyvars_fold(tyvarlist, _, ty) = tyvars(tyvarlist, ty)

   in
     fun all_tyvars ty = tyvars(nil,ty)
   end

   fun isFunType ty =
     case the_type ty of 
       FUNTYPE _ => true
     | _ => false

   exception ArgRes
    
   fun argres ty =
     case the_type ty of
       FUNTYPE ar => ar
     | _ => raise ArgRes

   type seen_tyvars = Type list * int

   val no_tyvars : seen_tyvars = ([],0)

   fun print_type_with_seen_tyvars (options,t,(stack,depth)) =
     let
       val (s,depth,stack) =
	 string_types (options,t,depth,stack,"")
     in
       (s,(stack,depth))
     end

   (* What is this stuff for ? *)
   (* It only gets activated with module debugging on *)

   local
     val tyfun_instantiations : Tyfun list ref = ref [] (* GLOBAL REF *)

     (* many GLOBAL REFs *)
     val ves : (Valenv ref * Valenv ref) list ref = ref []
     val tys1 : ((int * Type * Instance) ref
                 * (int * Type * Instance) ref) list ref = ref []
     val tys2 : (Type ref * Type ref) list ref = ref []
     val tys3 : ((int * bool * Type * bool * bool) ref
                 * (int * bool * Type * bool * bool) ref) list ref = ref []
     val tfs : (Tyfun ref * Tyfun ref) list ref = ref []

     fun copy_type(CONSTYPE(tys,tyn)) =
       CONSTYPE(Lists.reducel
                (fn (tys,ty) => copy_type ty ::tys) (nil, tys),
                copy_tyname tyn)
       | copy_type (FUNTYPE(ty1,ty2)) = FUNTYPE(copy_type ty1,copy_type ty2)
       | copy_type (RECTYPE(map)) =
         RECTYPE(NewMap.fold
		 (fn (map, lab, ty) => NewMap.define'(map, (lab,copy_type ty)))
		 (NewMap.empty' Ident.lab_lt, map))
       | copy_type (tyv as METATYVAR(ty1 as ref(n,ty,i),b1,b2)) =
         (METATYVAR(Lists.assoc(ty1,!tys1),b1,b2)
          handle Lists.Assoc => 
            (tys1 := (ty1,ty1)::(!tys1);
             ty1 := (n,copy_type ty,i);
             tyv))
       | copy_type
         (ovty as META_OVERLOADED
          (ty1 as ref(ty),tv,valid,loc)) =
         (META_OVERLOADED(Lists.assoc(ty1,!tys2),tv,valid,loc)
          handle Lists.Assoc =>
            (tys2 := (ty1,ty1)::(!tys2);
             ty1 := copy_type ty;
             ovty))
       | copy_type (tyv as TYVAR(ty1 as ref(n,ty,i),id)) =
         (TYVAR(Lists.assoc(ty1,!tys1),id)
          handle Lists.Assoc =>
            (tys1 := (ty1,ty1)::(!tys1);
             ty1 := (n,copy_type ty,i);
             tyv))
       | copy_type (recty as METARECTYPE(ty1 as ref(n,b1,ty,b2,b3))) =
         (METARECTYPE(Lists.assoc(ty1,!tys3))
          handle Lists.Assoc =>
            (tys3 := (ty1,ty1)::(!tys3);
             ty1 := (n,b1,copy_type ty,b2,b3);
             recty))
       | copy_type ty = ty
     and copy_typescheme (SCHEME(n,(ty,i))) = SCHEME(n,(copy_type ty,i))
       | copy_typescheme (UNBOUND_SCHEME(ty,i)) = UNBOUND_SCHEME(copy_type ty,i)
       | copy_typescheme sch = sch
     and copy_tyname
       (m as METATYNAME(tf as ref(NULL_TYFUN(_)),name,n,b,
                        ve' as ref(VE(n',ve)),abs)) =
       (METATYNAME(tf,name,n,b,Lists.assoc(ve',!ves),abs)
        handle Lists.Assoc =>
          let
            val map =
              (ves := (ve',ve')::(!ves);
               NewMap.map (fn (valid,sch) => copy_typescheme sch) ve)
          in
            (ve' := VE(n',map);
             METATYNAME(tf,name,n,b,ve',abs))
          end)
       | copy_tyname (METATYNAME(tf as ref(ETA_TYFUN(tyn)),name,n,b,
                                 ve' as ref(VE(n',ve)),abs)) =
         let
           val (tf1,tf_encountered) =
             (Lists.assoc(tf,!tfs),true)
             handle Lists.Assoc =>
               (tf,false)
           val (ve'',ve_encountered) =
             (Lists.assoc(ve',!ves),true)
             handle Lists.Assoc =>
               (ve',false)
           val _ =
             if tf_encountered then ()
             else
               tfs := (tf,tf1)::(!tfs)
           val _ =
             if ve_encountered then ()
             else
               ves := (ve',ve'')::(!ves)
           val _ =
             if tf_encountered then ()
             else
               tf1 := ETA_TYFUN(copy_tyname tyn)
           val _ =
             if ve_encountered then ()
             else
               ve'' := VE(n',NewMap.map (fn (valid,sch) => copy_typescheme sch) ve)
         in
           METATYNAME(tf1,name,n,b,ve'',abs)
         end
       | copy_tyname (METATYNAME(tf as ref(TYFUN(ty,n)),name,n',b,
                                 ve' as ref(VE(n'',ve)),abs)) =
         let
           val (tf1,tf_encountered) =
             (Lists.assoc(tf,!tfs),true)
             handle Lists.Assoc =>
               (tf,false)
           val (ve'',ve_encountered) =
             (Lists.assoc(ve',!ves),true)
             handle Lists.Assoc =>
               (ve',false)
           val _ =
             if tf_encountered then ()
             else
               tfs := (tf,tf1)::(!tfs)
           val _ =
             if ve_encountered then ()
             else
               ves := (ve',ve'')::(!ves)
           val _ =
             if tf_encountered then ()
             else
               tf1 := TYFUN(copy_type ty,n)
           val _ =
             if ve_encountered then ()
             else
               ve'' := VE(n'', NewMap.map (fn (valid,sch) => copy_typescheme sch) ve)
         in
           METATYNAME(tf1,name,n',b,ve'',abs)
         end
       | copy_tyname (TYNAME(id,s,n,b,ve1 as ref(VE(n1,ve2)),s',
                             abs,ve3 as ref(VE(_,ve4)),lev)) =
         (TYNAME(id,s,n,b,ve1,s',abs,Lists.assoc(ve1,!ves),lev)
          handle Lists.Assoc =>
            let
              val ve'' = ref(VE(n1,NewMap.empty (Ident.valid_lt, 
                                                 Ident.valid_eq)))
              val map =
                (ves := (ve1,ve'')::(!ves);
                 NewMap.map (fn (valid,sch) => copy_typescheme sch) ve2)
            in
              (ve'' := VE(n1,map);
               TYNAME(id,s,n,b,ve1,s',abs,ve'',lev))
            end)
     val dummy_false = ref false
     val dummy_ve = ref empty_valenv
     val dummy_tf = ref (TYFUN(NULLTYPE,0))

     fun copy_tyfun tyf =
       (dummy_tf := tyf;
        ves := [];
        tys1 := [];
        tys2 := [];
        tys3 := [];
        tfs := [];
        case copy_tyname(METATYNAME(dummy_tf,"",0,dummy_false,dummy_ve,
                                    dummy_false)) of
          METATYNAME(ref(tf),_,_,_,_,_) => tf
        | _ => Crash.impossible "copy_tyfun:generate_moduler:core_rules")
   in
     fun update_tyfun_instantiations tyf =
       (tyfun_instantiations := copy_tyfun tyf :: (!tyfun_instantiations);
        length (!tyfun_instantiations))

     fun fetch_tyfun_instantiation tyfun =
       Lists.nth(tyfun-1,rev(!tyfun_instantiations))
   end

   exception CombineTypes

   (* The idea of this function is to combine two types, which should match each other *)
   (* And to return a composite type maximizing the constructor information available *)
   (* This is just used for printing values, so we could probably discard more information *)

   fun combine_types (t1,t2) =
     let
       val t1 = type_strip t1
       val t2 = type_strip t2
       fun empty_valenvp (VE (_,amap)) = NewMap.is_empty amap
       fun aux (NULLTYPE,t) = t
         | aux (t,NULLTYPE) = t
         | aux (METATYVAR (ref (_,t1,_),_,_),t2) = aux (t1,t2)
         | aux (t1,METATYVAR (ref (_,t2,_),_,_)) = aux (t1,t2)
         | aux (META_OVERLOADED (ref t1,_,_,_),t2) = aux (t1,t2)
         | aux (t1,META_OVERLOADED (ref t2,_,_,_)) = aux (t1,t2)
         | aux (TYVAR (ref (_,t1,_),_),t2) = aux (t1,t2)
         | aux (t1,TYVAR (ref (_,t2,_),_)) = aux (t1,t2)
         | aux (METARECTYPE (ref (_,_,t1,_,_)),t2) = aux (t1,t2)
         | aux (t1,METARECTYPE (ref (_,_,t2,_,_))) = aux (t1,t2)
         | aux (RECTYPE map1,RECTYPE map2) =
	   if NewMap.size map1 <> NewMap.size map2 then
	     raise Lists.Zip (* Not sure if this can happen *)
	   else
	     RECTYPE
	     (NewMap.fold
	      (fn (map, lab, ty) =>
	       case NewMap.tryApply'(map, lab) of
		 SOME ty' => NewMap.define'(map, (lab, aux(ty, ty')))
	       | _ => raise CombineTypes)
	      (map1, map2))
(*
           let
             val assoc1 = Mapping.assoc map1
             val assoc2 = Mapping.assoc map2
             fun merge (((lab1,ty1),(lab2,ty2))::rest,map) =
               if lab1 = lab2 then
		 merge (rest,Mapping.add ((lab1,aux (ty1,ty2)),map,Ident.lab_order))
               else
		 raise CombineTypes
	       | merge ([],map) = map
           in
             RECTYPE(merge(Lists.zip (assoc1,assoc2),NewMap.empty' Ident.lab_lt))
           end
*)
         | aux (FUNTYPE (arg1,res1),FUNTYPE (arg2,res2)) =
           FUNTYPE (aux (arg1,arg2),aux (res1,res2))
         (* Note that the two type constructors need not be the same here *)
         (* If not, what should we do? *)
         | aux (CONSTYPE (tl1,tyname1),CONSTYPE (tl2,tyname2)) =
           CONSTYPE (map aux (Lists.zip (tl1,tl2)),
                     tyname_aux (tyname1,tyname2))
         | aux (DEBRUIJN t1,t2) = t2
         | aux (t1,DEBRUIJN t2) = t1
         | aux _ = raise CombineTypes
       and tyname_aux (tyname1 as TYNAME (_,_,_,_,_,_,_,ref ve1,_),
                       tyname2 as TYNAME (_,_,_,_,_,_,_,ref ve2,_)) =
         if empty_valenvp ve1 then tyname2 else tyname1
         | tyname_aux (tyname1 as TYNAME _,tyname2) = tyname1
         | tyname_aux (tyname1,tyname2 as TYNAME _) = tyname2
         | tyname_aux (tyname1 as METATYNAME (_,_,_,_,ref ve1,_),
                       tyname2 as METATYNAME (_,_,_,_,ref ve2,_)) =
           if empty_valenvp ve1 then tyname2 else tyname1
     in
       aux (t1,t2) 
       handle Lists.Zip => raise CombineTypes
     end

   (* Stamps *)

   val stamp_num = Stamp.stamp
   val make_stamp = Stamp.make_stamp
  end
