(* _lambda.sml the functor *)
(*
$Log: _lambda.sml,v $
Revision 1.221  1999/02/02 16:00:44  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.220  1998/08/24  12:24:51  jont
 * [Bug #70167]
 * Ensure that overloading is resolved for polymorphic equality
 * in order to allow optimisation into monomorphic equality if possible
 *
 * Revision 1.219  1998/08/18  14:41:06  jont
 * [Bug #70068]
 * Only use resolve_ty when we have a potential overloaded operator
 *
 * Revision 1.218  1998/02/24  12:18:13  jont
 * [Bug #70075]
 * Ensure full location info given with exceptions
 *
 * Revision 1.217  1998/02/20  14:25:28  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.216  1998/02/19  18:08:30  jont
 * [Bug #70075]
 * Get exception name back into exceptions
 *
 * Revision 1.215  1998/02/17  14:01:33  mitchell
 * [Bug #30349]
 * Warn when lhs of semicolon does not have type unit
 *
 * Revision 1.214  1998/01/29  10:46:06  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.213  1997/09/18  15:50:24  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.212.2.2  1997/11/26  17:35:10  daveb
 * [Bug #30071]
 *
 * Revision 1.212.2.1  1997/09/11  20:55:56  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.212  1997/06/12  10:19:24  matthew
 * Use StandardIO instead of MLWorks.IO for dynamic redundancy messages
 *
 * Revision 1.211  1997/05/02  14:05:53  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.210  1997/04/25  16:29:55  jont
 * [Bug #20017]
 * Improve polymorphic equality on types with one vcc and no nullaries
 * Also ensure poly eq which turns out to be int32 or word32 eq is coded accordingly
 *
 * Revision 1.209  1997/02/05  13:34:23  matthew
 * Moving inline expansion of ident and not to optimizer
 *
 * Revision 1.208  1997/01/02  12:40:49  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.207  1996/11/06  11:02:11  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.206  1996/11/01  13:48:00  io
 * [Bug #1614]
 * remove toplevel String.
 *
 * Revision 1.205  1996/10/28  17:52:50  andreww
 * [Bug #1708]
 * changing syntax of datatype replication.
 *
 * Revision 1.204  1996/10/02  15:14:06  andreww
 * [Bug #1592]
 * threading locations into Absyn.LOCALexp.
 *
 * Revision 1.203  1996/09/23  12:08:01  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.201  1996/08/05  17:59:38  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml (essentially
 * just passing options rather than print_options).
 *
 * Revision 1.200  1996/08/01  12:04:49  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.199  1996/04/30  16:41:08  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.198  1996/04/29  14:21:18  matthew
 * Integer changes
 *
 * Revision 1.197  1996/04/17  10:55:59  jont
 * Remove references to environprint
 *
 * Revision 1.196  1996/04/16  15:49:15  jont
 * Limit size of default functions inlined when debugging
 *
 * Revision 1.195  1996/04/12  15:56:46  jont
 * Modifying add_binding to add beta reduced versions of the bindings
 * to reduce the amount of store used
 *
 * Revision 1.194  1996/04/09  15:41:23  matthew
 * Change to WHEREsigexp
 *
 * Revision 1.193  1996/04/09  13:51:20  stephenb
 * trans_dec.make_exbind_info: remove Io and Os.SysErr exception handlers
 * The former because it is no longer necessary to support bootstrapping
 * from SML/NJ.  The latter because Module.find_file catches it and
 * converts it into Module.NoSuchFile.
 *
 * Revision 1.192  1996/04/02  11:55:17  stephenb
 * Put Io exception back so that it is possible to bootstrap with SML/NJ.
 *
 * Revision 1.191  1996/04/01  12:54:29  stephenb
 * make_exbind_info: change Io exception to OS.SysErr
 *
 * Revision 1.190  1996/03/26  16:34:38  matthew
 * Changes to VALdec
 *
 * Revision 1.189  1996/03/20  12:39:12  matthew
 * Changed interface to typerep_utils functions
 * ,
 *
 * Revision 1.188  1996/03/13  10:45:31  jont
 * Modify make_exbind_info to handle Io exceptions that may come from failed
 * realpath operations on Win95
 *
 * Revision 1.187  1996/02/22  13:37:53  jont
 * Replacing Map with NewMap
 *
 * Revision 1.186  1996/02/21  12:01:17  jont
 * Add stuff to build more sensible exception names without
 * full pathname info.
 *
 * Revision 1.185  1996/02/09  17:12:54  jont
 * Modify range checking to cope correctly with 16 bit integers and words
 *
Revision 1.184  1995/12/27  12:47:00  jont
Removing Option in favour of MLWorks.Option

Revision 1.183  1995/12/22  17:21:02  jont
Remove references to option structure
in favour of MLWorks.Option

Revision 1.182  1995/12/14  14:36:21  jont
Remove Default type constructor and its value constructors PRESENT and ABSENT
Use MLWorks.Option.option instead

Revision 1.181  1995/11/03  16:26:16  jont
Improvements to local variable debugging mechanism

Revision 1.180  1995/10/09  15:03:39  daveb
Corrected the types given to the derived operations on small integer and
word types.  (This bug only manifested when generating debug info).

Revision 1.179  1995/09/15  12:53:03  daveb
Changed the implementation of short word and int operations to be
functions, to ensure that new LVars are created for each operation.

Revision 1.178  1995/09/06  08:54:11  daveb
Added types for different lengths of words, ints and reals.

Revision 1.177  1995/08/31  14:11:03  jont
Changes to printing of redundancy information

Revision 1.176  1995/08/22  16:07:57  jont
Fix code generation problems for equality on types with
same names as builtin types

Revision 1.175  1995/08/10  10:31:13  jont
Modifications to allow defaults to be optional in special constant matches

Revision 1.174  1995/08/03  15:36:42  jont
Change to use MLWorks.Option

Revision 1.173  1995/08/01  10:47:07  jont
Change test for overloaded name to be robust against
redefinition as another primitive
Improvements to give inline equality on arrays, bytearrays, words and chars.

Revision 1.172  1995/05/02  14:05:47  matthew
Signal an error for an unresolved record label
Remove polyvariable debugging
Remove stepping stuff

Revision 1.171  1995/04/07  13:07:25  jont
Fix over enthusiastic assumptions about META_OVERLOADED types

Revision 1.170  1995/03/28  13:06:21  matthew
Problem with match translator returning incomplete match default functions.

Revision 1.169  1995/03/27  16:52:15  jont
Remove Builtin_p and modify FindBuiltin

Revision 1.168  1995/03/01  13:03:31  matthew
Simplified Stepper and Breakpoint code

Revision 1.167  1995/02/07  17:21:33  matthew
Debugger work

Revision 1.166  1995/01/19  16:00:39  matthew
Attempting to sort out the debugger code

Revision 1.165  1994/12/06  10:40:53  matthew
Changing uses of cast

Revision 1.164  1994/10/13  11:11:58  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.163  1994/10/10  09:40:10  matthew
Lambdatypes changes

Revision 1.162  1994/09/23  12:19:04  matthew
Abstraction of debug information in lambdatypes
Various bits of tidying up

Revision 1.161  1994/09/13  14:09:18  jont
Fix constructor names so that -delivery can deal with them

Revision 1.160  1994/08/18  12:52:38  matthew
Change name of default functions

Revision 1.159  1994/07/20  14:58:25  matthew
Functions and applications take a list of parameters

Revision 1.158  1994/07/08  14:51:00  daveb
Simplified selection of overloaded primitives.

Revision 1.157  1994/06/27  16:45:08  nosa
Bindings in Match DEFAULT trees.

Revision 1.156  1994/06/27  09:51:17  nosa
Match trees alteration : nodes can now disintegrate into default trees.

Revision 1.155  1994/06/22  12:32:16  jont
Update debugger information production

Revision 1.154  1994/06/14  15:59:24  daveb
Modified resolution of overloading - some cases weren't getting caught.
Now calls Types.resolve_overloading for all variables.

Revision 1.153  1994/06/09  11:47:08  nosa
Breakpoint settings on function exits;
FUNCTION RETURN value bindings for stepper;
Tidied up a little bit.

Revision 1.152  1994/06/03  14:38:17  matthew
Added call to resolve_overloading in translation of dynamic expression

Revision 1.151  1994/05/11  15:01:51  daveb
New overloading scheme.

Revision 1.150  1994/04/25  16:39:50  jont
Fix non-generative exception problems

Revision 1.149  1994/03/18  17:55:34  matthew
Always generated debug information for exceptions.

Revision 1.148  1994/03/01  10:11:42  nosa
nongeneric weak type variable in functor_refs.

Revision 1.147  1994/02/28  07:49:45  nosa
Step and Breakpoints Debugger;
Modules Debugger : Dynamic Type Name Instantiation.

Revision 1.146  1994/02/25  15:12:34  daveb
Removed old parameter to trans_top_dec,
Made generation of debug info for setup functions obey flag.

Revision 1.145  1994/01/20  12:31:03  nosa
Dynamic pattern-redundancy reporting;
Correct Exception Pattern Matching

Revision 1.144  1993/12/17  15:19:32  matthew
 Changed so inexhaustive bindings are only reported if not at top level.

Revision 1.143  1993/12/10  11:39:25  jont
Fixed layered patterns to generate binding inexhaustive warnings when necessary

Revision 1.142  1993/12/03  16:39:03  nickh
Added location information to COERCEexp.

Revision 1.141  1993/11/29  18:10:31  daveb
Added the symbol name to the "Unresolved overloading" error message.

Revision 1.140  1993/11/25  09:32:52  matthew
Added fixity annotations to absyn.

Revision 1.139  1993/10/28  15:23:56  nickh
Merging in code change.

Revision 1.138  1993/09/22  13:31:32  nosa
Polymorphic debugger;
instances of polymorphic functions are passed round at runtime.

Revision 1.137  1993/08/24  12:12:39  matthew
Tidied up debug information stuff
Debug information for exceptions is now always generated.

Revision 1.136  1993/08/20  15:44:32  jont
Added further error message for inexhaustive binding without variables

Revision 1.135  1993/08/06  14:44:16  matthew
Added location information to matches

Revision 1.134  1993/07/30  10:34:24  nosa
Local and closure variable inspection in the debugger;
new compiler option debug_variables; changed types of constructors
LET, LETREC, LETB, and Tags.

Revision 1.133  1993/07/26  13:43:58  jont
Tidied up inexhaustive match output to remove excessive new lines

Revision 1.132  1993/07/21  15:59:45  nosa
More informative inexhaustiveness reporting

Revision 1.131  1993/07/07  16:42:14  daveb
Removed exception environments and interfaces.
Funenvs no longer have interface components.  Instead, info about functor
arguments is found in the type basis.
Exceptions are always stored in the value environment.  Matching of
exceptions against value specifications requires some extra work.

Revision 1.130  1993/05/20  12:42:12  matthew
Added code for abstractions.

Revision 1.129  1993/05/18  18:52:59  jont
Removed integer parameter

Revision 1.128  1993/05/04  12:09:10  matthew
Added case for TYPEDpat's in pat_name function.

Revision 1.127  1993/04/07  17:16:57  matthew
Renamed Typerep_Utils to TyperepUtils
Added call to TyperepUtils.convert_dynamic_type

Revision 1.126  1993/04/06  16:39:21  jont
Added code to deal with inexhaustive bindings and bindings without variables
Fixed a bug in value bindings of nullary exception constructors

Revision 1.125  1993/03/12  18:46:47  matthew
Generate error for unresolved overloaded operators

Revision 1.124  1993/03/10  16:34:24  matthew
Options changes
Signature revisions

Revision 1.123  1993/03/09  12:34:42  matthew
Options & Info changes

Revision 1.122  1993/03/01  14:17:15  matthew
Added MLVALUE lambda exp
Dynamic expressions get translated into a pair of the expression and the MLVALUE of its type

Revision 1.121  1993/02/18  16:48:26  matthew
Added TypeRep_Utils parameter and translations of dynamic and coerce expressions

Revision 1.120  1993/02/08  15:30:12  matthew
Removed ref nameset in Absyn.FunBind

Revision 1.119  1993/02/02  10:14:52  matthew
Modifications for COPYSTR.
Added caching of interfaces in structures and environments in interfaces.

Revision 1.118  1993/01/20  17:57:27  daveb
Fixed bug in matching lists in value declarations.

Revision 1.117  1993/01/14  16:39:34  nosa
Deleted label handling in lambda translator.

Revision 1.116  1993/01/08  11:36:11  daveb
Changes to support new representation of lists.

Revision 1.115  1992/12/22  14:59:19  jont
Anel's last changes

Revision 1.114  1992/12/17  17:03:20  matthew
Changed int and real scons to carry a location around

Revision 1.113  1992/12/08  18:54:59  jont
Removed a number of duplicated signatures and structures

Revision 1.112  1992/12/01  14:24:56  matthew
Changed an error message.

Revision 1.111  1992/11/30  13:23:52  daveb
Deleted some list optimisation code that crept in prematurely.

Revision 1.110  1992/11/26  13:15:09  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.109  1992/11/06  12:25:38  matthew
Changed Error structure to Info

Revision 1.108  1992/11/04  15:44:53  jont
Changes to allow IntNewMap to be used on MatchVar

Revision 1.107  1992/11/03  11:28:23  daveb
Switches now have both value-carrying and immediate constructors in the
same switch.  They also contain information about the number of each
sort of constructor in the datatype.

Revision 1.106  1992/10/12  10:02:19  clive
Tynames now have a slot recording their definition point so constructor functions can have
more information in them

Revision 1.105  1992/09/30  12:42:25  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.104  1992/09/25  11:57:15  jont
Removed and tidied up lots of instances of map, replaced various
Lists.length o NewMap.to_list with NewMap.size, generally tidied up

Revision 1.103  1992/09/22  15:19:21  clive
Better annotations

Revision 1.102  1992/09/11  16:50:34  jont
Some minor improvements in determining whether or not constructors
of various types exist

Revision 1.101  1992/09/10  10:03:34  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.100  1992/09/08  17:52:40  matthew
Changes to absyn

Revision 1.99  1992/09/07  08:14:18  clive
Datatype fred = Abs of int | ... -> val Abs <VAR> = Abs<CON> which was code-generated in the current
environment instead of the empty environment - since Abs was builtin this did not work

Revision 1.98  1992/09/04  10:16:12  richard
Installed central error reporting mechanism.

Revision 1.97  1992/08/26  12:50:22  jont
Removed some redundant structures and sharing

Revision 1.96  1992/08/26  09:07:14  clive
Added the recording of information about exceptions

Revision 1.95  1992/08/25  17:32:30  jont
Did tail recursive versions for translations of sequences of decs
and sequences of strdecs

Revision 1.94  1992/08/20  17:47:00  jont
Preserved builtin-ness across rebindings

Revision 1.93  1992/08/17  09:27:42  clive
The actual application of the functor was missed out

Revision 1.92  1992/08/13  13:15:54  davidt
Removed NewMap.domain_ordered and replaced with NewMap.rank'
which doesn't build an intermediate list.

Revision 1.91  1992/08/12  12:02:59  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.90  1992/08/06  16:07:14  jont
Anel's changes to use NewMap instead of Map

Revision 1.90  1992/08/06  16:07:14  jont
Anel's changes to use NewMap instead of Map

Revision 1.89  1992/08/05  17:36:59  jont
Removed some structures and sharing

Revision 1.88  1992/08/04  10:22:57  davidt
Put in correct type annotations for UPDATE and BECOMES optimisations.

Revision 1.87  1992/07/22  11:06:16  matthew
Changed interface to match compiler to for passing back of redundancy and exhaustiveness information

Revision 1.86  1992/07/17  13:39:21  clive
null_type_annotation is no longer a function

Revision 1.85  1992/07/06  13:17:31  clive
Generation of function call point debug information

Revision 1.84  1992/07/01  16:20:02  davida
Added LET constructor and new slot to APP.

Revision 1.83  1992/06/24  10:09:55  clive
Added an annotation for excaptions

Revision 1.82  1992/06/23  11:19:25  clive
Added an annotation slot to HANDLE

Revision 1.81  1992/06/22  15:07:55  clive
More data put into the debug slot of exceptions

Revision 1.80  1992/06/17  16:35:41  jont
Fixed problem whereby structures were being taken apart only to be rebuilt
exactly as before

Revision 1.79  1992/06/15  12:59:14  clive
LambdaExp is no longer an equality type, so replaced calls to = with LS.lambda_equality

Revision 1.78  1992/06/12  19:33:40  jont
Added ident function for type casting required by interpreter

Revision 1.77  1992/06/11  19:11:45  jont
Sorted out compare_names stuff

Revision 1.76  1992/06/11  10:40:09  clive
Added type annotations to FNexp

Revision 1.75  1992/06/10  19:40:29  jont
changed to use newmap

Revision 1.74  1992/06/03  17:39:31  jont
Moved assign_fields into environ

Revision 1.73  1992/05/26  10:30:43  jont
Added some optimisation of polymorphic equality tests, on refs
and datatypes with no value carrying constructors

Revision 1.72  1992/05/19  15:42:09  clive
Added marks to some of the abstract syntax

Revision 1.71  1992/05/15  16:12:07  clive
Added more documentation to fn's

Revision 1.70  1992/05/12  19:40:42  jont
Changed signature comparison test to check for equal before sorting,
as the implementation tends to deliver the data in order anyway

Revision 1.69  1992/05/05  13:34:16  clive
Added more useful diagnostic info

Revision 1.68  1992/04/22  14:42:53  jont
Modified APPexp translation so beta reduction is only called
when equality is being applied to a pair of values from a datatype,
one of which may be constant

Revision 1.67  1992/04/13  17:00:43  clive
First version of the profiler

Revision 1.66  1992/03/23  13:50:39  jont
Changed length for Lists.length in various places. Removed word require
from trans_top_dec since this confuses the parser

Revision 1.65  1992/03/17  18:32:32  jont
Added bool ref for add_fn_names to control addition of function names

Revision 1.64  1992/03/17  14:53:24  jont
Added function name propagation to the lambda translation

Revision 1.63  1992/03/12  14:20:56  clive
val (ref ...) = exp wasn't introducing an extra DEREF operation

Revision 1.62  1992/03/05  12:29:28  jont
Fixed problem whereby lambda expressions were being duplicated for
the two defaults in a CONS switch pair

Revision 1.61  1992/02/20  13:27:37  jont
Added show_match to control printing of match trees

Revision 1.60  1992/02/11  17:19:12  clive
New pervasive library - tried to neaten code

Revision 1.59  1992/02/05  18:10:58  jont
Fixed bug in complete_struct_with_sig whereby recursive calls
were binding variables to the result expression in what they
should have been bound to (ie it said let lv = le' in le when it
should have said let lv = le in le')

Revision 1.58  1992/02/03  16:13:04  jont
Fixed bug in open whereby exception environment and bindings weren't made

Revision 1.57  1992/01/24  23:29:54  jont
Extracted out type fiddling functions into match/type_utils

Revision 1.56  1992/01/23  18:22:29  jont
Removed some small type structure manipulation functions into
a separate file match/type_utils. Other should follow some time,
eg record_tag and constructor_tag

Revision 1.55  1992/01/09  18:57:56  jont
Fixed bug in determination of overloading from the evnironment,
instead of looking up the last part of the name in the known overloads,
we must check the path is empty, and it produces a primitive, and
then see if it's in the overloaded set

Revision 1.54  1992/01/06  13:42:34  jont
Changed LETREC to use new RECLET binding (much simpler)

Revision 1.53  1992/01/06  13:12:55  jont
Changed trans_topdec and complete_struct_from_topenv to use new
binding type

Revision 1.52  1992/01/02  13:27:05  jont
Altered exception form to be STRUCT[unique, string name]

Revision 1.51  1991/12/19  17:27:11  jont
Removed processing of REQUIRE, it should never get this far

Revision 1.50  91/11/28  17:04:40  richard
Changed the way that exception uniques are generated to be an
application of REF to unit rather than a special pervasive.  This
allows us to compile the pervasive library itself, but may need
further work.

Revision 1.49  91/11/27  13:00:29  jont
Changed Match_Utils.Qsort to Lists.qsort

Revision 1.48  91/11/26  15:12:39  jont
Improved cg_longexid and cg_longstrid to allow generation to primitives

Revision 1.47  91/11/18  15:36:51  richard
Caused the Bind and Match exceptions to use the pervasived directly
rather than trying to look up the current definitions in the environment.

Revision 1.46  91/11/14  14:41:53  jont
Fixed get_lamb_env to allow Primitive structure heads for library

Revision 1.45  91/11/14  14:01:25  jont
Allowed translation of final component of a longvalid to a primitive,
to allow creation of library

Revision 1.44  91/10/22  17:42:50  davidt
Put in an explicit Lists structure instead of having it
implicit opened in the LambdaSub structure.

Revision 1.43  91/10/22  16:13:35  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.42  91/10/22  10:45:30  davidt
Changed is_overloaded so that it works properly (this function will
probably change quite soon but this is just to get the code generator
up and running again).

Revision 1.41  91/10/21  14:35:43  jont
Modified overloaded operator detection

Revision 1.40  91/10/09  10:20:49  davidt
General tidy up, Made changes due to record selection now requiring
the total size of the record to be present as well as the index.

Revision 1.39  91/10/08  11:32:54  jont
Changed use of lambdasub.number_from to lists.number_from_by_one

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

require "../basis/__int";
require "^.basis.__string";
require "^.system.__os";

require "../utils/lists";
require "../utils/intnewmap";
require "../utils/crash";
require "../utils/print";
require "../utils/diagnostic";
require "../utils/inthashtable";
require "../typechecker/types";
require "../typechecker/typerep_utils";
require "../typechecker/basis";
require "../basics/absynprint";
require "../basics/identprint";
require "../basics/module_id";
require "../match/type_utils";
require "../main/primitives";
require "../main/pervasives";
require "../main/machspec";
require "../rts/gen/implicit";
require "../main/info";
require "../debugger/debugger_types";
require "../match/match";
require "environ";
require "lambdaprint";
require "lambdaoptimiser";

require "lambda";

(**
    The functor for translating from abstract syntax to extended
    lambda calculus.  And for defining the datatypes used.

    Last updated : Fri Mar 15 17:11:12 1991
**)

functor Lambda (
  structure Diagnostic : DIAGNOSTIC
  structure Lists : LISTS
  structure IntHashTable : INTHASHTABLE
  structure IntNewMap : INTNEWMAP
  structure Crash : CRASH
  structure Print: PRINT
  structure AbsynPrint : ABSYNPRINT
  structure IdentPrint : IDENTPRINT
  structure Types : TYPES
  structure TypeUtils : TYPE_UTILS
  structure Basis: BASIS
  structure Primitives : PRIMITIVES
  structure Pervasives : PERVASIVES
  structure MachSpec : MACHSPEC
  structure ImplicitVector : IMPLICIT_VECTOR
  structure TyperepUtils : TYPEREP_UTILS
  structure Info : INFO
  structure Debugger_Types : DEBUGGER_TYPES
  structure Match : MATCH where type Matchvar = int
  structure Environ : ENVIRON
  structure LambdaPrint: LAMBDAPRINT
  structure LambdaOptimiser: LAMBDAOPTIMISER

  sharing LambdaOptimiser.LambdaTypes =
    Environ.EnvironTypes.LambdaTypes = LambdaPrint.LambdaTypes
  sharing Types.Datatypes = TypeUtils.Datatypes = TyperepUtils.Datatypes =
	  Basis.BasisTypes.Datatypes = AbsynPrint.Absyn.Datatypes
  sharing LambdaPrint.LambdaTypes.Ident = AbsynPrint.Absyn.Ident = IdentPrint.Ident = Types.Datatypes.Ident
  sharing Match.Absyn = AbsynPrint.Absyn = TyperepUtils.Absyn
  sharing Environ.EnvironTypes = Primitives.EnvironTypes
  sharing Info.Location = AbsynPrint.Absyn.Ident.Location
  sharing Match.Options = Types.Options = AbsynPrint.Options =
    IdentPrint.Options = LambdaPrint.Options
  sharing Environ.EnvironTypes.NewMap = Types.Datatypes.NewMap
  sharing LambdaPrint.LambdaTypes.Set = AbsynPrint.Absyn.Set

  sharing type LambdaPrint.LambdaTypes.FunInfo = Debugger_Types.RuntimeEnv.FunInfo
  sharing type LambdaPrint.LambdaTypes.VarInfo = Debugger_Types.RuntimeEnv.VarInfo
  sharing type Debugger_Types.RuntimeEnv.RuntimeInfo = AbsynPrint.Absyn.RuntimeInfo
  sharing type Environ.EnvironTypes.LambdaTypes.LVar = Match.lvar
  sharing type LambdaPrint.LambdaTypes.Primitive = Pervasives.pervasive
  sharing type Environ.Structure = Types.Datatypes.Structure = AbsynPrint.Absyn.Structure
  sharing type Debugger_Types.Type = LambdaPrint.LambdaTypes.Type
    = Types.Datatypes.Type = AbsynPrint.Absyn.Type = Debugger_Types.RuntimeEnv.Type
  sharing type Types.Datatypes.InstanceInfo = AbsynPrint.Absyn.InstanceInfo
  sharing type Types.Datatypes.Instance = AbsynPrint.Absyn.Instance =
    Debugger_Types.RuntimeEnv.Instance
  sharing type LambdaPrint.LambdaTypes.Tyfun = Types.Datatypes.Tyfun
    = AbsynPrint.Absyn.Tyfun = Debugger_Types.RuntimeEnv.Tyfun
  sharing type LambdaPrint.LambdaTypes.DebuggerStr = Types.Datatypes.DebuggerStr
    = AbsynPrint.Absyn.DebuggerStr
  sharing type LambdaPrint.LambdaTypes.Structure = AbsynPrint.Absyn.Structure
) : LAMBDA =
struct
  structure Diagnostic = Diagnostic
  structure Absyn = AbsynPrint.Absyn
  structure Datatypes = Types.Datatypes
  structure BasisTypes = Basis.BasisTypes
  structure EnvironTypes = Environ.EnvironTypes
  structure LambdaTypes = EnvironTypes.LambdaTypes
  structure Ident = IdentPrint.Ident
  structure Location = Ident.Location
  structure Symbol = Ident.Symbol
  structure NewMap = Datatypes.NewMap
  structure Set = LambdaTypes.Set
  structure Debugger_Types = Debugger_Types
  structure Info = Info
  structure Options = Types.Options
  structure RuntimeEnv = Debugger_Types.RuntimeEnv

  type DebugInformation = Debugger_Types.information

(*
  datatype union = datatype Match.union
*)

  (* Some controls *)

  val do_exit_stuff = false
  val generate_moduler_debug = false
  (* Controls whether polyvariable and module debugging code is generated at all *)
  (* Switch this off for the moment -- options are disabled anyway *)
  val do_fancy_stuff = false

  val show_match = false

  (* General utils *)

  val cast : 'a -> 'b = MLWorks.Internal.Value.cast

  val unit_exp = LambdaTypes.STRUCT ([],LambdaTypes.TUPLE)

(*  fun substring (str1,str2) =
    let
      val str1 = explode str1
      val str2 = explode str2
      fun tl [] = []
        | tl (a::l) = l
      fun substring (nil,_,_) = true
        | substring (_,nil,_) = false
        | substring (x::xs,y::ys,yys) =
          if x = y then substring (xs,ys,yys)
          else substring(str1,yys,tl yys)
    in
      substring (str1,str2,tl str2)
    end
*)

  fun valid_symbol (Ident.VAR sy) = sy
    | valid_symbol (Ident.CON sy) = sy
    | valid_symbol (Ident.EXCON sy) = sy
    | valid_symbol (Ident.TYCON' sy) = sy

  (* Some utilities *)

  val function_return_string = "<function return>"

  val overload_function_string = "<overload function>"

  local
    val functor_app_string = "functor app"
  in
    val is_functor_app = String.isPrefix functor_app_string
    val new_LVar = LambdaTypes.new_LVar

    fun make_functor_app n =
      Symbol.find_symbol ("<" ^ functor_app_string ^ Int.toString n ^ ">")
  end (* local *)

  fun funny_name_p name  =
    ((substring(name,0,4) = "<if>" orelse
      substring(name,0,5) = "<seq>" orelse
      substring(name,0,6) = "<case>" orelse
      substring(name,0,8) = "<handle>")
    handle Subscript => false)

  fun valid_name valid = Symbol.symbol_name (valid_symbol valid)

  fun make_short_id name = Ident.VAR (Symbol.find_symbol name)

  fun make_longid (path,name) =
    let
      fun make_path [] = Ident.NOPATH
        | make_path (a::l) = Ident.PATH (Symbol.find_symbol a,make_path l)
    in
      Ident.LONGVALID (make_path path,make_short_id name)
    end

  fun combine_paths (Ident.NOPATH,p) = p
    | combine_paths (Ident.PATH(s,p), p') = Ident.PATH(s,combine_paths (p,p'))

  fun select_exn_unique(LambdaTypes.STRUCT([unique, _],_)) = unique
    | select_exn_unique lexp =
      LambdaTypes.SELECT({index=0, size=2,selecttype = LambdaTypes.CONSTRUCTOR}, lexp)

  fun v_order((v1, _), (v2, _)) = Ident.valid_order(v1, v2)

  fun s_order((s1, _), (s2, _)) = Ident.strid_order(s1, s2)

  fun known_order ((lab1, _, _), (lab2, _, _)) = Ident.lab_order (lab1, lab2)
(** search for a value in a list of such objects, returning it's
    position if found, or raising an exception **)

    (* Should this take account of TYFUNs? *)
  fun is_list_type (Datatypes.CONSTYPE(_, tyname)) =
    Types.tyname_eq(tyname, Types.list_tyname)
  |   is_list_type _ = false

  val dummy_var = new_LVar()
  val dummy_varexp = LambdaTypes.VAR dummy_var

  fun env_reduce (init, list) =
      Lists.reducel (fn (env, (env', _, _)) => Environ.augment_env(env, env'))
		    (init, list)

  fun denv_reduce (init, list) =
      Lists.reducel (fn (env, (_, env',_)) => Environ.augment_denv(env, env'))
		    (init, list)

  fun env_from_list env_le_list =
    env_reduce(Environ.empty_env, env_le_list)

  fun denv_from_list env_le_list =
    denv_reduce(Environ.empty_denv, env_le_list)

  fun constructor_tag (valid,ty) =
    (let
      val (location,valenv) = TypeUtils.get_valenv(TypeUtils.get_cons_type ty)
    in
       (location, NewMap.rank'(valenv, valid))
    end
       handle NewMap.Undefined =>
         Crash.impossible("constructor_tag(3): " ^ 
                          Types.debug_print_type 
                             Types.Options.default_options ty ^ "," ^
                          IdentPrint.debug_printValId valid))

        (* any old options should do when printing out the results of
           the impossible case *)


  fun record_label_offset(lab, the_type,error_info,loc) =
    let
      fun record_domain(Datatypes.RECTYPE map) = map
        | record_domain(Datatypes.METARECTYPE(ref (_,flex,
                                                   ty as Datatypes.METARECTYPE _,
                                                   _,_))) =
          if flex then
	    record_domain ty
          else
            Crash.impossible
            "contradiction between boolean and type in METARECTYPE 1"
        | record_domain(Datatypes.METARECTYPE(ref (_,flex,
                                                   ty as Datatypes.RECTYPE _,
                                                   _,_))) =
          if flex then
	    let
	      val Ident.LAB sym = lab
	      val sym_name = Symbol.symbol_name sym
	    in
	      Info.error
	      error_info
	      (Info.RECOVERABLE, loc,
	       "Unresolved record type for label: #" ^ sym_name);
	      record_domain ty
	    end
          else record_domain ty
        | record_domain _ = Crash.impossible ("record_tag(2)")

      val record_domain = record_domain the_type

(*
      fun position (head::tail, n) =
        if lab = head then n
	else position (tail, n+1)
	| position ([], _) =
	  Crash.impossible("record_tag(1)")
*)
    in
      {index = NewMap.rank record_domain lab,
       size = NewMap.size record_domain,
       selecttype = LambdaTypes.TUPLE}
    end

(*
    Representations of types.
    All nullary constructors are represented as small integers.
    All types involving precisely one constructor, which is itself value
    carrying are represented as the type of the value carried.
    All types involving more than one constructor
    have the value carrying constructors represented as pairs, of
    which field zero is the tag and field one the value.

    datatype t = a | b                Small integers
    datatype int list = [] | cons of (int * int list)
                                      One vcc
    datatype u = A | B(t)             One vcc
    datatype v = x(t) | y(u) | z      More than one vcc
*)

  (* A function to find the name of the type to which an overloaded type
     variable has been instantiated.
  *)
  fun overloaded_name (Datatypes.FUNTYPE(Datatypes.RECTYPE record_map, _)) =
    (case NewMap.range record_map of
       ty as Datatypes.META_OVERLOADED (r, tv, valid, loc) :: _ =>
	 (case Types.the_type (!r) of
	    Datatypes.CONSTYPE(_, Datatypes.TYNAME{2=s,...}) => s
	  | Datatypes.CONSTYPE(_, Datatypes.METATYNAME{2=s,...}) => s
	  | _ => Crash.impossible "overloaded_name (1)")
(*
     | Datatypes.METATYVAR _ :: _ => Crash.impossible "overloaded_name (2) METATYVAR"
     | Datatypes.TYVAR _ :: _ => Crash.impossible "overloaded_name (2) TYVAR"
     | Datatypes.METARECTYPE _ :: _ => Crash.impossible "overloaded_name (2) METARECTYPE"
     | Datatypes.RECTYPE _ :: _ => Crash.impossible "overloaded_name (2) RECTYPE"
     | Datatypes.FUNTYPE _ :: _ => Crash.impossible "overloaded_name (2) FUNTYPE"
     | Datatypes.DEBRUIJN _ :: _ => Crash.impossible "overloaded_name (2) DEBRUIJN"
*)
     | Datatypes.CONSTYPE(_, Datatypes.TYNAME{2=s,...}) :: _ => s
     | Datatypes.CONSTYPE(_, Datatypes.METATYNAME{2=s,...}) :: _ => s
     | _ => Crash.impossible "overloaded_name (2)")
  | overloaded_name
      (Datatypes.FUNTYPE
         (ty as Datatypes.META_OVERLOADED (r, tv, valid, loc), _)) =
    (case Types.the_type (!r) of
       Datatypes.CONSTYPE(_, Datatypes.TYNAME{2=s,...}) => s
     | Datatypes.CONSTYPE(_, Datatypes.METATYNAME{2=s,...}) => s
     | _ => Crash.impossible "overloaded_name (3)")
  | overloaded_name(Datatypes.FUNTYPE(Datatypes.CONSTYPE(_, tyname), _)) =
      (case tyname of
	 Datatypes.TYNAME{2=s,...} => s
       | Datatypes.METATYNAME{2=s,...} => s)
  | overloaded_name _ = Crash.impossible "overloaded_name (4)"

  (* The overloaded operations for particular sizes of numeric types are
   * defined in terms of the built-in operations.  This avoids increasing the
   * size of the rest of the compiler with unnecessary built-in operations.
   *
   * The integer operations for sizes less than the size of the default
   * check for overflow by adding the largest negative integer of that size
   * to bring the value in to the range 0 - 2^n, and then using an unsigned
   * comparison to test for overflow.
   *)

  fun mk_binop_type t =
    Datatypes.FUNTYPE
    (Datatypes.RECTYPE
     (NewMap.define'
      (NewMap.define'(NewMap.empty' Ident.lab_lt, (Ident.LAB(Symbol.find_symbol"1"), t)),
       (Ident.LAB(Symbol.find_symbol"2"), t))),
     t)

  local
    fun check_range (abs_min_int, max_word) x =
      let
        val addition =
          LambdaTypes.APP
            (LambdaTypes.BUILTIN Pervasives.UNSAFEINTPLUS,
             ([LambdaTypes.STRUCT ([LambdaTypes.VAR x,
                                    LambdaTypes.SCON
                                    (Ident.INT (abs_min_int, Location.UNKNOWN), NONE)],
                                   LambdaTypes.TUPLE)],
              []),
             NONE)

        val comparison =
	  LambdaTypes.APP
	    (LambdaTypes.BUILTIN Pervasives.WORDGT,
             ([LambdaTypes.STRUCT ([addition,
                                    LambdaTypes.SCON
                                    (Ident.INT (max_word, Location.UNKNOWN), NONE)],
                                   LambdaTypes.TUPLE)],
              []),
             NONE)
      in
        LambdaTypes.SWITCH
	  (comparison,
	   SOME {num_vccs = 0, num_imms = 2},
	   [(LambdaTypes.IMM_TAG ("", 1),
             LambdaTypes.RAISE
	       (LambdaTypes.STRUCT
	          ([LambdaTypes.BUILTIN Pervasives.EXOVERFLOW, unit_exp],
	        LambdaTypes.CONSTRUCTOR)))],
	   SOME (LambdaTypes.VAR x))
      end

    val check_range_8 = check_range ("128", "255")
    val check_range_16 = check_range ("32768", "65535")

    fun overloaded_int_op (check_range, result_type) opcode () =
      let
        val arg = LambdaTypes.new_LVar ()
        val tmp = LambdaTypes.new_LVar ()
      in
        LambdaTypes.FN
          (([arg],[]),
	   LambdaTypes.LET
	     ((tmp,
	       NONE,
               LambdaTypes.APP
                 (LambdaTypes.BUILTIN opcode,
	          ([LambdaTypes.VAR arg],[]),
		  NONE)),
	      check_range (tmp)),
           LambdaTypes.BODY,
	   "<Built in fixed size int operation>",
	   result_type,
	   RuntimeEnv.INTERNAL_FUNCTION)
    end
  in
    val int8_op =
      overloaded_int_op (check_range_8, mk_binop_type Types.int8_type)
    val int16_op =
      overloaded_int_op (check_range_16, mk_binop_type Types.int16_type)
  end

  local
    fun clamp_word mask var =
      LambdaTypes.APP
        (LambdaTypes.BUILTIN Pervasives.WORDANDB,
         ([LambdaTypes.STRUCT ([LambdaTypes.VAR var,
                                LambdaTypes.SCON
                                (Ident.WORD (mask, Location.UNKNOWN), NONE)],
                               LambdaTypes.TUPLE)],
          []),
         NONE)

    val clamp_word_8 = clamp_word "0wxff"
    val clamp_word_16 = clamp_word "0wxffff"

    fun overloaded_word_op (clamp_word, result_type) opcode () =
      let
        val arg = LambdaTypes.new_LVar ()
        val tmp = LambdaTypes.new_LVar ()
      in
        LambdaTypes.FN
          (([arg],[]),
	   LambdaTypes.LET
	     ((tmp,
	       NONE,
               LambdaTypes.APP
                 (LambdaTypes.BUILTIN opcode,
	          ([LambdaTypes.VAR arg],[]),
		  NONE)),
	      clamp_word (tmp)),
           LambdaTypes.BODY,
	   "<Built in fixed size word operation>",
	   result_type,
	   RuntimeEnv.INTERNAL_FUNCTION)
      end
  in
    val word8_op =
      overloaded_word_op (clamp_word_8, mk_binop_type Types.word8_type)
    val word16_op =
      overloaded_word_op (clamp_word_16, mk_binop_type Types.word16_type)
  end

  val derived_overload_table =
    [("_int8+", int8_op Pervasives.UNSAFEINTPLUS),
     ("_int8-", int8_op Pervasives.UNSAFEINTMINUS),
     ("_int8*", int8_op Pervasives.INTSTAR),
     ("_int8div", int8_op Pervasives.INTDIV),
     ("_int8mod", int8_op Pervasives.INTMOD),
     ("_int8~", int8_op Pervasives.INTUMINUS),
     ("_int8abs", int8_op Pervasives.INTABS),
     ("_int8<", fn () => LambdaTypes.BUILTIN Pervasives.INTLESS),
     ("_int8<=", fn () => LambdaTypes.BUILTIN Pervasives.INTLESSEQ),
     ("_int8>", fn () => LambdaTypes.BUILTIN Pervasives.INTGREATER),
     ("_int8>=", fn () => LambdaTypes.BUILTIN Pervasives.INTGREATEREQ),
     ("_word8+", word8_op Pervasives.WORDPLUS),
     ("_word8-", word8_op Pervasives.WORDMINUS),
     ("_word8*", word8_op Pervasives.WORDSTAR),
     ("_word8div", word8_op Pervasives.WORDDIV),
     ("_word8mod", word8_op Pervasives.WORDMOD),
     ("_word8<", fn () => LambdaTypes.BUILTIN Pervasives.WORDLT),
     ("_word8<=", fn () => LambdaTypes.BUILTIN Pervasives.WORDLE),
     ("_word8>", fn () => LambdaTypes.BUILTIN Pervasives.WORDGT),
     ("_word8>=", fn () => LambdaTypes.BUILTIN Pervasives.WORDGE),
     ("_int16+", int16_op Pervasives.UNSAFEINTPLUS),
     ("_int16-", int16_op Pervasives.UNSAFEINTMINUS),
     ("_int16*", int16_op Pervasives.INTSTAR),
     ("_int16div", int16_op Pervasives.INTDIV),
     ("_int16mod", int16_op Pervasives.INTMOD),
     ("_int16~", int16_op Pervasives.INTUMINUS),
     ("_int16abs", int16_op Pervasives.INTABS),
     ("_int16<", fn () => LambdaTypes.BUILTIN Pervasives.INTLESS),
     ("_int16<=", fn () => LambdaTypes.BUILTIN Pervasives.INTLESSEQ),
     ("_int16>", fn () => LambdaTypes.BUILTIN Pervasives.INTGREATER),
     ("_int16>=", fn () => LambdaTypes.BUILTIN Pervasives.INTGREATEREQ),
     ("_word16+", word16_op Pervasives.WORDPLUS),
     ("_word16-", word16_op Pervasives.WORDMINUS),
     ("_word16*", word16_op Pervasives.WORDSTAR),
     ("_word16div", word16_op Pervasives.WORDDIV),
     ("_word16mod", word16_op Pervasives.WORDMOD),
     ("_word16<", fn () => LambdaTypes.BUILTIN Pervasives.WORDLT),
     ("_word16<=", fn () => LambdaTypes.BUILTIN Pervasives.WORDLE),
     ("_word16>", fn () => LambdaTypes.BUILTIN Pervasives.WORDGT),
     ("_word16>=", fn () => LambdaTypes.BUILTIN Pervasives.WORDGE)]

  fun lookup_derived_overload s =
    SOME (Lists.assoc (s, derived_overload_table))
    handle
      Lists.Assoc => NONE

  fun domain_type_name(Datatypes.FUNTYPE(Datatypes.RECTYPE record_map, _)) =
    (case NewMap.range record_map of
       h :: _ => (true, Types.the_type h)
     | _ => (false, Types.int_type))
    | domain_type_name _ = (false, Types.int_type)

  fun domain_tyname(Datatypes.CONSTYPE(_, tyname)) = (true, tyname)
    | domain_tyname _ = (false, Types.int_tyname)

  fun check_no_vcc_for_eq(h as Datatypes.CONSTYPE _) =
    TypeUtils.has_null_cons h andalso not(TypeUtils.has_value_cons h)
    | check_no_vcc_for_eq _ = (*Crash.impossible"poly_eq type wrong"*)false

  fun check_one_vcc_and_no_nullaries(h as Datatypes.CONSTYPE _) =
    not(TypeUtils.has_null_cons h) andalso TypeUtils.get_no_vcc_cons h = 1
    | check_one_vcc_and_no_nullaries _ = false

  (* Get the tag part of the constructed value resulting from lexp *)

  fun GetConTag lexp =
    LambdaTypes.SELECT({index = 0, size = 2,selecttype=LambdaTypes.CONSTRUCTOR}, lexp)

  (* Get the value part of the constructed value resulting from lexp *)

  fun GetConVal lexp =
    LambdaTypes.SELECT ({index = 1, size = 2,selecttype=LambdaTypes.CONSTRUCTOR}, lexp)

  fun get_lamb_env(strid as Ident.STRID sy, env) =
    let
      val (env', comp, _) = Environ.lookup_strid(strid, env)
    in
      case comp of
	EnvironTypes.LAMB(lvar,_) => (env', LambdaTypes.VAR lvar)
      | EnvironTypes.PRIM prim => (env', LambdaTypes.BUILTIN prim)
      | EnvironTypes.EXTERNAL =>
	  (env',
	   LambdaTypes.APP
	     (LambdaTypes.BUILTIN Pervasives.LOAD_STRUCT,
	      ([LambdaTypes.SCON (Ident.STRING (Symbol.symbol_name sy), NONE)],[]),
	      NONE))
      | EnvironTypes.FIELD{index, size} =>
(*
	  Crash.impossible("get_lamb_env gives field looking up " ^ Symbol.symbol_name sy ^ " at " ^ Int.toString index ^ "/" ^ Int.toString size ^ " in env :-\n" ^ EnvironPrint.stringenv Options.default_print_options env ^ "\n")
*)
	  Crash.impossible "get_lamb_env gives field"
    end

  fun get_lamb_env'(strid as Ident.STRID sy, env) =
    let
      (* moduler_generated indicates if the structure was compiled with module debugging on *)
      val (env', comp, moduler_generated) = Environ.lookup_strid(strid, env)
    in
      case comp of
	EnvironTypes.LAMB (lvar,longstrid) => (env', LambdaTypes.VAR lvar, longstrid, moduler_generated)
      | EnvironTypes.PRIM prim => (env', LambdaTypes.BUILTIN prim, EnvironTypes.NOSPEC, moduler_generated)
      | EnvironTypes.EXTERNAL =>
	  (env',
	   LambdaTypes.APP
	     (LambdaTypes.BUILTIN Pervasives.LOAD_STRUCT,
	      ([LambdaTypes.SCON(Ident.STRING(Symbol.symbol_name sy), NONE)],[]),
	      NONE),
	   EnvironTypes.NOSPEC, moduler_generated)
      | EnvironTypes.FIELD _ =>
	  Crash.impossible "get_lamb_env gives field"
    end

  fun make_struct_select {index,size} =
    {index = index,size = size, selecttype = LambdaTypes.STRUCTURE}

  fun get_field_env(strid, (env, lambda)) =
    let
      val (env', field) =
        case Environ.lookup_strid(strid, env) of
          (env'', EnvironTypes.FIELD field, _) => (env'', field)
        | _ => Crash.impossible "get_field_env fails to get field"
    in
      (env', LambdaTypes.SELECT(make_struct_select field, lambda))
    end

  fun get_field_env'(strid, (env, lambda, longstrid, moduler_generated)) =
    let
      val (env', field, _) =
        case Environ.lookup_strid(strid, env) of
          (env'', EnvironTypes.FIELD field, moduler_generated) => (env'', field, moduler_generated)
        | _ => Crash.impossible "get_field_env fails to get field"
    in
      (env', LambdaTypes.SELECT(make_struct_select field, lambda), longstrid, moduler_generated)
    end

  fun cg_longvalid (longvalid, env) =
    case longvalid of
      Ident.LONGVALID(Ident.NOPATH, valid) =>
        ((case Environ.lookup_valid(valid, env) of
           EnvironTypes.LAMB(lvar,_) => LambdaTypes.VAR lvar
         | EnvironTypes.PRIM prim =>
             LambdaTypes.BUILTIN prim
         | EnvironTypes.EXTERNAL =>
             LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.LOAD_VAR,
                             ([LambdaTypes.SCON(Ident.STRING(valid_name valid), NONE)],[]),
                             NONE)
         | EnvironTypes.FIELD _ => Crash.impossible "cg_longvalid gives field")
	handle NewMap.Undefined =>
	  Crash.impossible
	    (IdentPrint.debug_printValId valid ^ " undefined in cg_longvalid"))
    | Ident.LONGVALID(path, valid) =>
        let
          val (env', lambda) =
            Ident.followPath'(get_lamb_env, get_field_env) (path, env)
        in
          (case Environ.lookup_valid(valid, env') of
            EnvironTypes.FIELD field => LambdaTypes.SELECT(make_struct_select field, lambda)
          | EnvironTypes.PRIM prim => LambdaTypes.BUILTIN prim
          | EnvironTypes.LAMB _ =>
              Crash.impossible "cg_longvalid gets lambda var at end of longvalid"
          | EnvironTypes.EXTERNAL =>
              Crash.impossible "cg_longvalid gets external at end of longvalid")
	  handle NewMap.Undefined =>
	    Crash.impossible
	      (IdentPrint.debug_printValId valid
	       ^ " undefined in cg_longvalid")
        end

  fun cg_longexid (longvalid, env) =
    case longvalid of
      Ident.LONGVALID(Ident.NOPATH, valid) =>
        (case Environ.lookup_valid(valid, env) of
           EnvironTypes.LAMB (lvar,longstrid) => (LambdaTypes.VAR lvar,longstrid)
         | EnvironTypes.PRIM prim =>
             (LambdaTypes.BUILTIN prim,
              EnvironTypes.NOSPEC)
         | EnvironTypes.EXTERNAL =>
            (LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.LOAD_VAR,
                             ([LambdaTypes.SCON(Ident.STRING(valid_name valid), NONE)],[]),
                             NONE),
             EnvironTypes.NOSPEC)
         | EnvironTypes.FIELD _ => Crash.impossible "cg_longexid gives field")
    | Ident.LONGVALID(path, valid) =>
        let
          val (env', lambda, longstrid, _) =
            Ident.followPath'(get_lamb_env', get_field_env') (path, env)
        in
         (case Environ.lookup_valid(valid, env') of
            EnvironTypes.FIELD field => LambdaTypes.SELECT(make_struct_select field, lambda)
          | EnvironTypes.PRIM prim => LambdaTypes.BUILTIN prim
          | EnvironTypes.LAMB _ =>
              Crash.impossible "cg_longexid gets lambda var at end of longvalid"
          | EnvironTypes.EXTERNAL =>
              Crash.impossible "cg_longexid gets external at end of longvalid",
          longstrid)
        end

  fun cg_longstrid (longstrid, environment) =
    case longstrid of
      Ident.LONGSTRID(Ident.NOPATH, strid as Ident.STRID sy) =>
        (case Environ.lookup_strid(strid, environment) of
           (env, EnvironTypes.LAMB (lvar,longstrid), moduler_generated) =>
             (env, LambdaTypes.VAR lvar, longstrid, moduler_generated)
         | (env, EnvironTypes.PRIM prim, moduler_generated) =>
             (env, LambdaTypes.BUILTIN prim, EnvironTypes.NOSPEC, moduler_generated)
         | (env, EnvironTypes.EXTERNAL, moduler_generated) =>
             (env,
              LambdaTypes.APP
	        (LambdaTypes.BUILTIN Pervasives.LOAD_STRUCT,
	         ([LambdaTypes.SCON(Ident.STRING(Symbol.symbol_name sy), NONE)],[]),
                 NONE),
              EnvironTypes.NOSPEC,
              moduler_generated)
         | (_, EnvironTypes.FIELD _, _) =>
             Crash.impossible "cg_longstrid gives field")
    | Ident.LONGSTRID(path, strid) =>
        let
          val (env, lambda, longstrid, moduler_generated) =
            Ident.followPath'(get_lamb_env', get_field_env') (path, environment)
        in
          case Environ.lookup_strid(strid, env) of
            (env', EnvironTypes.FIELD field, _) =>
              (env', LambdaTypes.SELECT(make_struct_select field, lambda), longstrid, moduler_generated)
          | (env', EnvironTypes.PRIM prim, _) =>
              (env', LambdaTypes.BUILTIN prim, longstrid, moduler_generated)
          | (_, EnvironTypes.LAMB _, _) =>
              Crash.impossible "cg_longstrid gets lambda var at end of longstrid"
          | (_, EnvironTypes.EXTERNAL, _) =>
              Crash.impossible "cg_longstrid gets external at end of longstrid"
        end

  val eq_prim = LambdaTypes.BUILTIN Pervasives.EQ

  fun is_eq_prim(LambdaTypes.BUILTIN Pervasives.EQ) = true
    | is_eq_prim _ = false

  fun isnt_eq_prim(LambdaTypes.BUILTIN Pervasives.EQ) = false
    | isnt_eq_prim _ = true

  val neq_prim = LambdaTypes.BUILTIN Pervasives.NE

  fun isnt_neq_prim(LambdaTypes.BUILTIN Pervasives.NE) = false
    | isnt_neq_prim _ = true

  fun let_lambdas_in_exp (bindings, lambda_exp) =
    Lists.reducer LambdaTypes.do_binding (bindings,lambda_exp)

  fun unordered_let_lambdas_in_exp (bindings, lambda_exp) =
    Lists.reducel (fn (exp, bind) => LambdaTypes.do_binding(bind, exp))
    (lambda_exp, bindings)

  (* Redundancy information *)

  fun print_redundancy_info (print_options,[], _) = Crash.impossible "print_redundancy_info:lambda"
    | print_redundancy_info (print_options,clauses, pat_exp_list) =
      let
        (* print list of patterns with indication next to them of redundant ones *)
        fun dynamic_member (_,nil) = false
          | dynamic_member (n,(n',_)::_) = n=n'
        fun static_member (_,nil) = false
          | static_member (n,(n',Match.TRUE)::_) = n=n'
          | static_member _ = false
        fun new_clauses nil = Crash.impossible "new_clauses:print_redundancy_info:lambda"
          | new_clauses (_::clauses) = clauses
        fun fetch_clause  nil = Crash.impossible "fetch_clause:print_redundancy_info:lambda"
          | fetch_clause (clause::_) = clause
        fun to_string(n, [], _, ((b,static_str),(b',dynamic_str))) =
            ((b,rev static_str), (b',rev dynamic_str))
          | to_string(n, (p,_,_)::l,clauses,((static,static_str),(dynamic,dynamic_str))) =
            let
              val pat_str = AbsynPrint.unparsePat true print_options p ^ " => ..."
            in
              if static_member (n, clauses) then
                to_string(n+1, l, new_clauses clauses,
                          ((true,"\n  " ^ pat_str::static_str),
                           (dynamic,(fetch_clause clauses,"\n      " ^ pat_str)::dynamic_str)))
              else
                if dynamic_member (n, clauses) then
                  to_string(n+1, l, new_clauses clauses,
                            ((static,(*("\n      " ^ pat_str)::*)static_str),
                             (true,(fetch_clause clauses,"\n      " ^ pat_str)::dynamic_str)))
                else
                  to_string(n+1, l, clauses,
                            ((static,(*("\n      " ^ pat_str)::*)static_str),
                             (dynamic,((n,Match.FALSE),"\n      " ^ pat_str)::dynamic_str)))
            end
      in
        to_string(1, pat_exp_list, clauses, ((false,[]), (false,[])))
      end

  fun compare_sig_env generate_moduler (Datatypes.COPYSTR (_, str), env) =
    compare_sig_env generate_moduler (str, env)
    | compare_sig_env generate_moduler (Datatypes.STR (_, _, Datatypes.ENV
                                                       (Datatypes.SE sm,
                                                        Datatypes.TE tm,
                                                        Datatypes.VE (_, vm))),
                                        EnvironTypes.ENV(v_map, s_map)) =
    NewMap.size vm + (if generate_moduler then NewMap.size tm else 0) = NewMap.size v_map andalso
    NewMap.size sm = NewMap.size s_map andalso
    (* recurse down the structure map *)
    Lists.forall
    (compare_sig_env generate_moduler)
    (Lists.zip(NewMap.range_ordered sm,
               map #1 (NewMap.range_ordered s_map)))

  fun complete_struct_with_sig (Datatypes.COPYSTR (_, str), env, lv, coerce, generate_moduler) =
    complete_struct_with_sig (str, env, lv, coerce, generate_moduler)
    | complete_struct_with_sig
      (interface as Datatypes.STR (_, _,
                                   Datatypes.ENV (Datatypes.SE sm,
                                                  Datatypes.TE tm,
                                                  Datatypes.VE (_, vm))),
       env as EnvironTypes.ENV(v_map, s_map),
       lambda_var,
       coerce,
       generate_moduler) =

   (if not coerce andalso compare_sig_env generate_moduler (interface, env)
      then (env, LambdaTypes.VAR lambda_var)
    else
      let
        (* This function matches a structure against a signature.  It produces a
         new structure consisting of lambda variables bound to selections of
	 the old structure.  It returns a lambda environment and a lambda
	 expression.*)

        val v_list = NewMap.to_list_ordered v_map
        val s_list = NewMap.to_list_ordered s_map
        val ordered_int_map = NewMap.to_list_ordered sm
        val vm =
          if generate_moduler then
            (* Augment the value environment with type constructor values *)
            let
              val dummy_scheme = Datatypes.UNBOUND_SCHEME(Datatypes.NULLTYPE,NONE)
            in
              NewMap.fold
              (fn (map,Ident.TYCON sym,_) =>
               NewMap.define (map,Ident.TYCON' sym, dummy_scheme))
              (vm,tm)
            end
          else vm

        (* Throw out unwanted elements and assign new field numbers *)
        (* v_list is the structure being filtered *)
        (* vm is the map corresponding to the constraining signature *)
        val (v_f_list,s_f_list,_) =
          let
            fun val_filter_map (v_list, [], done) = rev done
              | val_filter_map ([], z :: _, done) =
                Crash.impossible(IdentPrint.debug_printValId z ^ " missing in val_filter_map")
              | val_filter_map((x, y)::xs, second as (z :: zs), done) =
                if Ident.valid_eq (x, z)
                  then val_filter_map(xs, zs, (x, y) :: done)
                else val_filter_map(xs, second, done)

            fun str_filter_map (a_list, [], done) = rev done
              | str_filter_map ([], x :: _, done) =
                Crash.impossible(IdentPrint.printStrId x ^ " missing in str_filter_map")
              | str_filter_map((x, y)::xs, second as (z :: zs), done) =
                if Ident.strid_eq (x, z)
                  then str_filter_map(xs, zs, (x, y) :: done)
                else str_filter_map(xs, second, done)
            val domain = NewMap.domain_ordered vm
          (* For debugging *)
          (*
            fun print_list l =
              (Lists.iterate
               (fn id => print (IdentPrint.debug_printValId id ^ " "))
               l;
               print "\n")
            val _ = (print "Domain:\n";
                     print_list domain;
                     print "V_list:\n";
                     print_list (map #1 v_list))
              *)
          in
            Environ.number_envs
            (val_filter_map (v_list, domain,[]),
             str_filter_map (s_list, map #1 ordered_int_map,[]),
             [])
          end

        (* Now add lvs to be bound to the component in the old structure. *)
        val v_f_l_list =
          map (fn x => (x, new_LVar())) v_f_list
        val s_f_l_list =
          map (fn x => (x, new_LVar(), new_LVar()))
          s_f_list

        (* First lv is to be the constraint result *)
        (* Second lv is to be bound to the old structure *)

        (* make a list of the lvs in the new structure *)
        val the_structure_list =
          map (fn (_, x) => LambdaTypes.VAR x) v_f_l_list @
          map (fn (_, x, _) => LambdaTypes.VAR x) s_f_l_list

        (* Recursively restrict all remaining substructures *)
        val env_le_list =
          map complete_struct_with_sig
          (map (fn ((((_, (env, _, _)), _), _, l2), (_, inte)) =>
                (inte, env, l2, coerce, generate_moduler))
           (Lists.zip(s_f_l_list, ordered_int_map)))

        (* Generate a lambda environment that binds the remaining identifiers
	 to the new field offsets. *)
        fun keep_prims (x as EnvironTypes.PRIM _) _ = x
          | keep_prims _ x = x

        val env =
          Lists.reducel
	  (fn (env, ((v, x), f_new)) =>
           Environ.add_valid_env(env, (v, keep_prims x f_new)))
	  (Lists.reducel
           (fn (env, (((strid, _), field), (env', _))) =>
            Environ.add_strid_env(env, (strid, (env', field, generate_moduler))))
           (Environ.empty_env, (Lists.zip(s_f_list, env_le_list))),
	   v_f_list)

        fun coerce (valid as Ident.EXCON _, lexp) =
          (* If this valid is a constructor, and the corresponding valid in
	   vm is not, then we must build a value from the exception. *)
          let
            val res = NewMap.tryApply'Eq (vm, valid)
	    val (need_coerce, res') =
	      case res of
		SOME ty => (false, res)
	      | _ => (true, NewMap.tryApply' (vm, valid))
          in
            if need_coerce then
              let
                val _ = Diagnostic.output 2 (fn _ => ["coercing ",IdentPrint.debug_printValId valid])
                val is_vcc =
                  case res' of
                    SOME ty =>
                      TypeUtils.is_vcc (TypeUtils.type_from_scheme ty)
                  | _ => Crash.impossible "coerce:_lambda"
              in
                if is_vcc then
                  let
                    val lv = new_LVar()
                  in
                    LambdaTypes.FN(([lv],[]),
                                   LambdaTypes.STRUCT([lexp, LambdaTypes.VAR lv],LambdaTypes.CONSTRUCTOR),
                                   LambdaTypes.BODY,
                                   "Builtin code to construct an exception",
                                   LambdaTypes.null_type_annotation,
                                   RuntimeEnv.INTERNAL_FUNCTION)
                  end
                else LambdaTypes.STRUCT([lexp, unit_exp],LambdaTypes.CONSTRUCTOR)
              end
            else lexp
          end
          | coerce (_, lexp) = lexp

        (* Now bind the new lambda variables to the corresponding old
	 field offsets. *)
        val l1 =
          map
          (fn (((valid, EnvironTypes.FIELD f_old), _), lv) =>
           LambdaTypes.LETB
           (lv,NONE,
            coerce (valid, LambdaTypes.SELECT
                    (make_struct_select f_old, LambdaTypes.VAR lambda_var)))
            | (((valid, EnvironTypes.PRIM prim), _), lv) =>
                LambdaTypes.LETB(lv,NONE,coerce (valid,LambdaTypes.BUILTIN prim))
            |  (((_, EnvironTypes.LAMB _), _), _) =>
                 Crash.impossible "c_s_w_i(1)"
            |  (((_, EnvironTypes.EXTERNAL), _), _) =>
                 Crash.impossible "c_s_w_i(2)")
          v_f_l_list

        val l2 =
          map
          (fn ((((_, (env, EnvironTypes.FIELD f_old, _)), _), lv, lv'), le) =>
           LambdaTypes.LETB
           (lv,NONE,
            LambdaTypes.do_binding
            (LambdaTypes.LETB
             (lv',NONE,
              LambdaTypes.SELECT(make_struct_select f_old, LambdaTypes.VAR lambda_var)),
             le))
            | ((((_, (_, EnvironTypes.LAMB _, _)), _), _, _), _) =>
	        Crash.impossible "c_s_w_i (3) LAMB"
            |  ((((_, (_, EnvironTypes.PRIM _, _)), _), _, _), _) =>
                 Crash.impossible "c_s_w_i (4) PRIM"
            |  ((((_, (_, EnvironTypes.EXTERNAL, _)), _), _, _), _) =>
                 Crash.impossible "c_s_w_i (5) EXTERNAL")
          (Lists.zip(s_f_l_list, map #2 env_le_list))

        val lambdas = let_lambdas_in_exp(l1 @ l2,
                                         LambdaTypes.STRUCT (the_structure_list,LambdaTypes.STRUCTURE))
      in
        (* Return the environment (binding ids to fields in the new structure) *)
        (* and the lambda expression representing the structure itself. *)
        (env, lambdas)
      end) (* of complete_struct_with_sig *)

  fun complete_struct_from_topenv(topenv as EnvironTypes.TOP_ENV(
    EnvironTypes.ENV(mv, ms), EnvironTypes.FUN_ENV m), lv_le_list) =
  let
    val valids = NewMap.to_list_ordered mv
    val strids = NewMap.to_list_ordered ms
    val funids = NewMap.to_list_ordered m
    fun extract_op (EnvironTypes.LAMB (x,_)) = LambdaTypes.VAR x
      | extract_op (EnvironTypes.PRIM x) = LambdaTypes.BUILTIN x
      | extract_op (EnvironTypes.FIELD _) =
	Crash.impossible "extract_op problem (1)"
      | extract_op EnvironTypes.EXTERNAL =
	Crash.impossible "extract_op problem (2)"
  in
    (Environ.assign_fields topenv,
      let_lambdas_in_exp(lv_le_list,
      LambdaTypes.STRUCT((map (fn (_, x) => extract_op x) valids) @
                         (map (fn (_, (_, x, _)) => extract_op x) strids) @
			 (map (fn (_,(x, (* _, *) _, _)) => extract_op x) funids),
                         LambdaTypes.STRUCTURE)))
  end

  fun make_top_env env = EnvironTypes.TOP_ENV(env, Environ.empty_fun_env)

  fun complete_struct((env, lambda_exp: LambdaTypes.LambdaExp),
		      interface_opt,
		      coerce, generate_moduler) =
  let
    val EnvironTypes.TOP_ENV(new_env, new_fun_env) =
      Environ.assign_fields(make_top_env env)
    val result = (new_env, lambda_exp)
  in
    case interface_opt of
      NONE => result
    | SOME interface =>
        if not coerce andalso compare_sig_env generate_moduler (interface, new_env)
          then result
        else
	  let
	    val new_lv = new_LVar()
	    val (new_env', new_lambda') =
	      complete_struct_with_sig(interface, new_env, new_lv, coerce, generate_moduler)
	  in
	    (new_env',
	     LambdaTypes.do_binding(LambdaTypes.LETB(new_lv,NONE,
                                                     lambda_exp),
                                    new_lambda'))
	  end
  end

  fun interface_from_sigexp (Absyn.NEWsigexp(_, ref (SOME str))) = str
    | interface_from_sigexp (Absyn.OLDsigexp(_, ref (SOME str),_)) = str
    | interface_from_sigexp (Absyn.WHEREsigexp (sigexp,_)) = interface_from_sigexp sigexp
    | interface_from_sigexp _ = Crash.impossible "No interface structure for signature"

  (* Match utilities -- moved here from LambdaUtils *)

  type MatchEnv = (LambdaTypes.LVar * LambdaTypes.VarInfo ref option) IntNewMap.T

  val empty_match_env = IntNewMap.empty

  fun add_match_env(pair, me) = IntNewMap.define'(me, pair)
  fun lookup_match(mv, me) = IntNewMap.apply'(me, mv)

  (* These global refs will cause real trouble one of these days *)
  val functor_refs_ct : int ref = ref 0
  val functor_refs : (EnvironTypes.Foo ref * Datatypes.Structure) list ref = ref []

  fun trans_top_dec
    error_info
    (options as Options.OPTIONS
       {print_options,
        (* generate_debug_info not used here !!! *)
        compiler_options = Options.COMPILEROPTIONS
                           {generate_debug_info,
                            debug_variables,
                            generate_moduler, ...},
	compat_options = Types.Options.COMPATOPTIONS {old_definition,...},
	...},
     topdec,
     top_env as EnvironTypes.TOP_ENV(env, _),
     top_denv,
     initial_debugger_env,
     basis,batch_compiler) =
    let
      val use_value_polymorphism = not old_definition
      val generate_moduler = do_fancy_stuff andalso generate_moduler

      (* Candidates for redundant exception patterns, and dynamic redundancy code generator *)
      val redundant_exceptions_ref : (LambdaTypes.LVar * string) list ref = ref []
      val dynamic_redundancy_report_ref : (LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp) ref = ref(fn exp => exp)

      (* Any of the complex optimization steps? *)
      val variable_debug = debug_variables orelse generate_moduler

      val null_runtimeinfo = RuntimeEnv.RUNTIMEINFO (NONE,nil)

      fun dummy_instance () = (ref Datatypes.NULLTYPE, ref null_runtimeinfo)

      fun mklongvalid valid = Ident.LONGVALID (Ident.NOPATH,valid)

      fun new_tyvar_slot () = ref (RuntimeEnv.OFFSET1 0)

      (* BEGIN{MODULES DEBUGGER} *)

      fun do_moduler_debug message =
        if generate_moduler_debug then
          print ("  # " ^ message() ^ "\n")
        else
          ()

      (** lookup functions for polymorphic function determining;
          look for longvalid in the debugger environment
       **)

      fun lookup f =
        let
          fun aux (Ident.NOPATH,result) = f result
            | aux (Ident.PATH(sym,path), EnvironTypes.DENVEXP(EnvironTypes.DENV(_,strmap))) =
              aux (path, NewMap.apply strmap (Ident.STRID sym)
                   handle NewMap.Undefined =>
                     (do_moduler_debug (fn () =>"UNDEFINED 14:" ^ Symbol.symbol_name sym);
                      raise NewMap.Undefined))
            | aux (Ident.PATH(sym,path),
                   EnvironTypes.LAMBDASTREXP(selects,lv,
                                             Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE stridmap,
                                                                             Datatypes.TE tyconmap,
                                                                             Datatypes.VE(_,validmap))))) =
              (* Build up a list of selections into a structure to get to the right value *)
              let
                val offset = NewMap.size tyconmap + NewMap.size validmap
              in
                aux(path,
                    EnvironTypes.LAMBDASTREXP({index= NewMap.rank' (stridmap,Ident.STRID sym) + offset,
                                               size= NewMap.size stridmap + offset}
                                              ::selects,lv,
                    NewMap.apply stridmap (Ident.STRID sym)))
                handle NewMap.Undefined =>
                  (do_moduler_debug(fn () =>"UNDEFINED 3:" ^ Symbol.symbol_name sym);
                   raise NewMap.Undefined)
              end
            | aux (path,EnvironTypes.LAMBDASTREXP(selects,lv,Datatypes.COPYSTR(_,str))) =
              aux (path, EnvironTypes.LAMBDASTREXP(selects,lv,str))
            (* Same as for LAMBDASTREXP *)
            | aux (Ident.PATH(sym,path),
                   EnvironTypes.LAMBDASTREXP'(selects,lv,
                                              Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE stridmap,
                                                                              Datatypes.TE tyconmap,
                                                                              Datatypes.VE(_,validmap))))) =
              let
                val offset = NewMap.size tyconmap + NewMap.size validmap
              in
                aux(path,
                    EnvironTypes.LAMBDASTREXP'({index=
                                                NewMap.rank' (stridmap,Ident.STRID sym) + offset,
                                                size= NewMap.size stridmap + offset}
                    ::selects,lv,
                    NewMap.apply stridmap (Ident.STRID sym)))
                handle NewMap.Undefined =>
                  (do_moduler_debug(fn () =>"UNDEFINED 3:" ^ Symbol.symbol_name sym);
                   raise NewMap.Undefined)
              end
            | aux(path,EnvironTypes.LAMBDASTREXP'(selects,lv,Datatypes.COPYSTR(_,str))) =
              aux(path, EnvironTypes.LAMBDASTREXP'(selects,lv,str))
        in
          aux
        end

      (* Lookup a symbol in a debugger structure *)
      fun lookup_sym sym =
        let
          fun aux (EnvironTypes.DENVEXP(EnvironTypes.DENV(validmap,_))) =
            (NewMap.apply validmap (Ident.VAR sym)
             handle NewMap.Undefined =>
               (do_moduler_debug(fn () =>"UNDEFINED 5:" ^ Symbol.symbol_name sym);
                raise NewMap.Undefined))
            (* Generate a lambda expression spec for selecting the value *)
            | aux (EnvironTypes.LAMBDASTREXP(selects,lv,
                                             Datatypes.STR(_,_,
                                                           Datatypes.ENV(Datatypes.SE stridmap,
                                                                         Datatypes.TE tyconmap,
                                                                         Datatypes.VE(_,validmap))))) =
              let
                val offset = NewMap.size tyconmap
              in
                EnvironTypes.LAMBDAEXP({index= NewMap.rank' (validmap,Ident.VAR sym) + offset,
                                        size=NewMap.size validmap + NewMap.size stridmap + offset} ::
                selects,
                lv,NONE)
              end
            | aux (EnvironTypes.LAMBDASTREXP(selects,lv,Datatypes.COPYSTR(_,str))) =
              aux (EnvironTypes.LAMBDASTREXP(selects,lv,str))
            (* Same as for LAMBDASTREXP *)
            | aux (EnvironTypes.LAMBDASTREXP'(selects,lv,
                                              Datatypes.STR(_,_,
                                                            Datatypes.ENV(Datatypes.SE stridmap,
                                                                          Datatypes.TE tyconmap,
                                                                          Datatypes.VE(_,validmap))))) =
              let
                val offset = NewMap.size tyconmap
              in
                EnvironTypes.LAMBDAEXP'({index= NewMap.rank' (validmap,Ident.VAR sym) + offset,
                                         size=NewMap.size validmap + NewMap.size stridmap + offset}
                                        ::selects,lv,NONE)
              end
            | aux(EnvironTypes.LAMBDASTREXP'(selects,lv,Datatypes.COPYSTR(_,str))) =
              aux(EnvironTypes.LAMBDASTREXP'(selects,lv,str))
        in
          aux
        end

      (* Look up a long valid in a debugger environment *)
      fun dlookup_longvalid (longvalid, denv) =
        case longvalid of
          (* Short ids are just looked up in the map *)
          Ident.LONGVALID(Ident.NOPATH, valid as Ident.VAR sym) =>
            (Environ.lookup_valid'(valid, denv)
             handle NewMap.Undefined =>
               (* This seems to happen for all builtin functions *)
               (do_moduler_debug(fn () =>"UNDEFINED 13:" ^ Symbol.symbol_name sym);
                raise NewMap.Undefined))
        | Ident.LONGVALID(Ident.PATH(sym,path), valid as Ident.VAR sym') =>
            (case denv of
               (* For long ids, call the functions above *)
               EnvironTypes.DENV(_,strmap) =>
                 lookup (lookup_sym sym')
                 (path, NewMap.apply strmap (Ident.STRID sym)
                  handle NewMap.Undefined =>
                    (do_moduler_debug
                     (fn () =>
                      (* This also seems to happen for builtin/pervasive functions *)
                      "UNDEFINED 4:" ^ Symbol.symbol_name sym ^ ".." ^ Symbol.symbol_name sym' ^ "..."
                      ^ NewMap.fold (fn (str,Ident.STRID sym,_) => str ^ "," ^ Symbol.symbol_name sym) ("",strmap));
                     raise NewMap.Undefined)))
        | _ => Crash.impossible "dlookup_longvalid:lambda"

      local
        val dummy_tf = ref(Datatypes.TYFUN(Datatypes.NULLTYPE,0))
        fun fetch_nulltyfun (Datatypes.METATYNAME{1=tf as ref(Datatypes.NULL_TYFUN _), ...}) = tf
          | fetch_nulltyfun (Datatypes.METATYNAME{1=ref(Datatypes.ETA_TYFUN m), ...}) =
            fetch_nulltyfun m
          | fetch_nulltyfun _ = Crash.impossible "fetch_nulltyfun:lambda"
      in
        fun fetch_ntf (Datatypes.TYSTR(tf,_)) =
            if Types.null_tyfunp tf then
              fetch_nulltyfun(Types.meta_tyname tf)
            else
              dummy_tf
      end

      (** lookup function for dynamic type function instantiations;
          lookup the debugger environment for appropriate debugger spill
       **)

     (* Try and find the tyfun in the debugger environment *)
      (* Returns an Environ.DebuggerExp *)

      fun dlookup_tycon (tyfun,denv) =
        let
          exception Lookup

          fun denv_lookup (EnvironTypes.DENV(id_map, str_map)) =
            let
              fun lookup_id map =
                let
                  fun aux nil = NONE
                    | aux ((_,lexp as EnvironTypes.LAMBDAEXP(_,_,SOME(tyfun')))::rest) =
                      if tyfun = tyfun'
                        then SOME lexp
                      else aux rest
                    | aux (_::rest) = aux rest
                in
                  aux (NewMap.to_list map)
                end
            in
              case lookup_id id_map of
                SOME lexp => lexp
              | _ =>
                  let
                    fun strexp_lookup (EnvironTypes.DENVEXP  denv) = denv_lookup denv
                      | strexp_lookup (EnvironTypes.LAMBDASTREXP (selects,lv,str)) =
                        EnvironTypes.LAMBDAEXP(rev (str_lookup str) @ selects,lv,NONE)
                      | strexp_lookup (EnvironTypes.LAMBDASTREXP'(selects,lv,str)) =
                        EnvironTypes.LAMBDAEXP' (rev (str_lookup str) @ selects,lv,NONE)
                    fun aux nil = raise Lookup
                      | aux ((_,strexp)::rest) =
                        (strexp_lookup strexp
                         handle Lookup => aux rest)
                  in
                    aux (NewMap.to_list str_map)
                  end
            end

          and str_lookup(Datatypes.COPYSTR(_,str)) = str_lookup str
            | str_lookup(Datatypes.STR(_,_,
                                    Datatypes.ENV(Datatypes.SE se_map,
                                                  Datatypes.TE te_map,
                                                  Datatypes.VE(_,ve_map)))) =
              let
                val size' = NewMap.size te_map + NewMap.size ve_map
                val size = NewMap.size se_map + size'

                (* see if the tyfun is in the te map *)
                fun find_tyfun nil _ = NONE
                  | find_tyfun ((_,tystr)::rest) n =
                    if tyfun = fetch_ntf tystr then SOME n
                    else find_tyfun rest (n+1)
              in
                case find_tyfun (NewMap.to_list_ordered te_map) 0 of
                  (* Return required select parameters *)
                  SOME n =>
                    [{index = n, size = size}]
                | _ =>
                    let
                      (* Else lookup in the structure environment *)
                      val se_list = NewMap.to_list_ordered se_map
                      fun find_str (nil, _) = raise Lookup
                        | find_str ((_,str)::rest, n) =
                          {index = n + size', size = size} :: str_lookup str
                          handle Lookup => find_str (rest,n+1)
                    in
                      find_str (se_list, 0)
                    end
              end
        in
          denv_lookup denv
        end

      (** lookup a debugger structure **)
      fun cg_longstrid' (longstrid, denv) =
        case longstrid of
          Ident.LONGSTRID(Ident.NOPATH, strid as Ident.STRID sym) =>
            (Environ.lookup_strid'(strid, denv)
             handle NewMap.Undefined =>
               (do_moduler_debug(fn () =>"UNDEFINED 12:" ^ Symbol.symbol_name sym);
                raise NewMap.Undefined))
        | Ident.LONGSTRID(Ident.PATH(sym,path), strid as Ident.STRID sy) =>
            let
              fun insert_strid Ident.NOPATH = Ident.PATH (sy,Ident.NOPATH)
                | insert_strid (Ident.PATH (sym,path)) = Ident.PATH (sym,insert_strid path)
            in
              case denv of
                EnvironTypes.DENV(_,strmap) =>
                  lookup (fn result => result) (insert_strid path, NewMap.apply strmap (Ident.STRID sym))
                  handle NewMap.Undefined =>
                    (do_moduler_debug(fn () =>"UNDEFINED 11:" ^ Symbol.symbol_name sym);
                     raise NewMap.Undefined)
            end



      (** open a debugger environment **)
      fun open_debugger_env (debugger_strexp, denv) =
        let
          fun open_lambdastrexp LAMBDAEXP LAMBDASTREXP
            (selects,lv,
             Datatypes.STR(_,_,
                           Datatypes.ENV(Datatypes.SE stridmap,
                                         Datatypes.TE tyconmap,
                                         Datatypes.VE(_,validmap)))) =
            let
              val size_validmap = NewMap.size validmap
              val size_tyconmap = NewMap.size tyconmap
              val size = NewMap.size stridmap + size_validmap + size_tyconmap
            in
              NewMap.fold
              (fn (env, tc' as Ident.TYCON tc, tystr) =>
               Environ.add_valid_denv
               (env, (Ident.TYCON' tc, LAMBDAEXP({index=NewMap.rank' (tyconmap,tc'),
                                                   size=size}
                                                  ::selects,lv,
               SOME(fetch_ntf tystr)))))
              (NewMap.fold
               (fn (env, s, str) =>
                Environ.add_strid_denv
                 (env, (s, LAMBDASTREXP({index=NewMap.rank' (stridmap,s) + size_validmap + size_tyconmap,
                                         size=size}
                                        ::selects,lv,
                                        str))))
               ((NewMap.fold
                 (fn (env, v, _) =>
                  Environ.add_valid_denv
                  (env, (v, LAMBDAEXP({index=NewMap.rank' (validmap,v) + size_tyconmap,
                                       size=size}
                                      ::selects,lv,NONE))))
                 (denv, validmap)), stridmap), tyconmap)
            end
            | open_lambdastrexp _ LAMBDASTREXP(selects,lv,Datatypes.COPYSTR(_,str)) =
              open_debugger_env (LAMBDASTREXP(selects,lv,str), denv)
        in
          case debugger_strexp of
            EnvironTypes.DENVEXP(denv') => Environ.augment_denv(denv, denv')
          | EnvironTypes.LAMBDASTREXP args =>
              open_lambdastrexp EnvironTypes.LAMBDAEXP EnvironTypes.LAMBDASTREXP args
          | EnvironTypes.LAMBDASTREXP' args =>
              open_lambdastrexp EnvironTypes.LAMBDAEXP' EnvironTypes.LAMBDASTREXP' args
        end

      val dlookup_longvalid =
        if generate_moduler then
          fn denv => dlookup_longvalid denv
          handle NewMap.Undefined => EnvironTypes.NULLEXP
        else
          fn _ => EnvironTypes.NULLEXP

      val empty_denv = Environ.empty_denv
      val empty_dstrexp = EnvironTypes.DENVEXP empty_denv

      val cg_longstrid' =
        if generate_moduler then
          fn denv =>
          cg_longstrid' denv
          handle NewMap.Undefined => empty_dstrexp
        else
          fn _ => empty_dstrexp

      val add_valid_denv =
        if generate_moduler then
          fn arg => Environ.add_valid_denv arg
        else
          fn _ => empty_denv

      val add_strid_denv =
        if generate_moduler then
          fn arg => Environ.add_strid_denv arg
        else
          fn _ => empty_denv

      val augment_denv =
        if generate_moduler then
          fn arg => Environ.augment_denv arg
        else
          fn _ => empty_denv

      val new_dLVar =
        if generate_moduler then fn _ => new_LVar()
        else
          fn lvar => lvar

      (** accumulation of functor application refs from subrequires **)
      fun sub_functor_refs (EnvironTypes.TOP_ENV (env',fun_env)) =
        let
          val env_list =
            case env of (* presumably the parameter to trans_top_dec *)
              EnvironTypes.ENV (env,_) => NewMap.to_list env

          fun sub_functor_refs ([], env) = EnvironTypes.TOP_ENV (env,fun_env)
            | sub_functor_refs ((entry as (Ident.VAR sym,comp))::rest, env) =
              let
                val name_string = Symbol.symbol_name sym
                val new_env =
                  if is_functor_app name_string
                    then
                      case comp of
                        EnvironTypes.LAMB(lvar,_) =>
                          Environ.add_valid_env (env,entry)
                      | _ => env
                  else
                    env
              in
                sub_functor_refs (rest,new_env)
              end
            | sub_functor_refs (_::rest, env) = sub_functor_refs (rest, env)
        in
          sub_functor_refs (env_list,env')
        end

      (* Definition of overloading function *)
      val (overload_exp,overload_binding,make_env) =
        if generate_moduler then
          (cg_longvalid (mklongvalid (Ident.VAR (Symbol.find_symbol overload_function_string)),env),[],
           fn env => env)
          handle NewMap.Undefined =>
            (do_moduler_debug(fn () =>"WARNING : redefining overload function");
             let
               val lvar = new_LVar()
               val lv = new_LVar()
               val args = new_LVar()
               val new_cg = new_LVar()
               val dexp' = new_LVar()
               val instance_var = new_LVar()
               val lexp =
                 (* This is whatever the overload function is meant to do *)
                 LambdaTypes.FN
                 (([args],[]),
                  LambdaTypes.LET((new_cg,NONE,
                                   LambdaTypes.SELECT({index=0,size=3,selecttype=LambdaTypes.TUPLE},
                                                      LambdaTypes.VAR args)),
                   LambdaTypes.LET((dexp',NONE,
                                    LambdaTypes.SELECT({index=1,size=3,selecttype=LambdaTypes.TUPLE},
                                                       LambdaTypes.VAR args)),
                     LambdaTypes.LET((instance_var,NONE,
                                      LambdaTypes.SELECT({index=2,size=3,selecttype=LambdaTypes.TUPLE},
                                                         LambdaTypes.VAR args)),
                       LambdaTypes.LET((lvar,NONE,LambdaTypes.VAR dexp'),
                          LambdaTypes.SWITCH
			    (LambdaTypes.VAR lvar,
                             SOME {num_vccs=1,num_imms=1},
                             [(LambdaTypes.IMM_TAG ("ABSENT",0),
                               LambdaTypes.VAR new_cg),
                              (LambdaTypes.VCC_TAG("PRESENT",1),
                               LambdaTypes.APP
                                 (LambdaTypes.VAR new_cg,
                                  ([let
                                     val lexp = LambdaTypes.SELECT
						  ({index=1,
                                                    size=2,
                                                    selecttype=LambdaTypes.CONSTRUCTOR},
                                                   LambdaTypes.VAR lvar)
                                   in
                                     (* What is this doing? *)
                                     LambdaTypes.SWITCH
				       (LambdaTypes.VAR instance_var,
                                        NONE,
                                        [(LambdaTypes.SCON_TAG
					    (Ident.INT ("~1", Location.UNKNOWN),
					     NONE),
                                          LambdaTypes.STRUCT
					    ([LambdaTypes.INT 0, lexp],
                                          LambdaTypes.CONSTRUCTOR))],
                                        SOME
					  (LambdaTypes.STRUCT
					     ([LambdaTypes.INT 1,
                                               LambdaTypes.STRUCT
						 ([lexp,
                                                   LambdaTypes.VAR instance_var],
                                               LambdaTypes.TUPLE)],
                                               LambdaTypes.CONSTRUCTOR)))
                                    end],[]),
                                    NONE))],
				NONE))))),
                  LambdaTypes.BODY,
                  overload_function_string,Datatypes.NULLTYPE,
                  RuntimeEnv.INTERNAL_FUNCTION)
             in
               (LambdaTypes.VAR lv,
                [LambdaTypes.LETB(lv,NONE,lexp)],
                fn env =>
                Environ.add_valid_env(env,
                                      (Ident.VAR (Symbol.find_symbol overload_function_string),
                                       EnvironTypes.LAMB(lv, EnvironTypes.NOSPEC))))
             end)
        else (dummy_varexp,[],fn env => env)

      (** selects over a lambda expression **)
      fun wrap_selects (selects,lexp) =
        let
          fun aux [] = lexp
            | aux ({index,size}::rest) =
              LambdaTypes.SELECT({index = index,size = size, selecttype = LambdaTypes.TUPLE},
                                 aux rest)
        in
          aux selects
        end

      (** lambda expression for dynamic overloading determination **)
      fun dexp_to_lambda EnvironTypes.NULLEXP = LambdaTypes.INT 0
        | dexp_to_lambda (EnvironTypes.INT i) =
          LambdaTypes.STRUCT([LambdaTypes.INT 1,LambdaTypes.INT i],
                             LambdaTypes.CONSTRUCTOR)
        | dexp_to_lambda (EnvironTypes.LAMBDAEXP(selects,(lv,_),_)) =
          wrap_selects (selects,LambdaTypes.VAR lv)
        (* functor_lv is either an lvar or an int *)
        | dexp_to_lambda( EnvironTypes.LAMBDAEXP'(selects,functorlv,_)) =
          wrap_selects (selects,
                        LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
                                        ([case !functorlv of
                                           EnvironTypes.LVARFOO functorlv => LambdaTypes.VAR functorlv
                                         | EnvironTypes.INTFOO ct =>
                                             cg_longvalid(mklongvalid (Ident.VAR(make_functor_app ct)),env)],
                                         []),
                                        NONE))

      (** lambda expression for dynamic type function instantiations **)
      fun dexp_to_lambda' EnvironTypes.NULLEXP = LambdaTypes.INT (~6)(* functors without constraints *)
        | dexp_to_lambda' (EnvironTypes.INT i) = LambdaTypes.INT i
        | dexp_to_lambda' (EnvironTypes.LAMBDAEXP (selects,(lv,_),_)) =
          wrap_selects (selects,LambdaTypes.VAR lv)
        (* functor_lv is either an lvar or an int *)
        | dexp_to_lambda' (EnvironTypes.LAMBDAEXP' (selects,functorlv,_)) =
          wrap_selects
	    (selects,
             LambdaTypes.APP
	       (LambdaTypes.BUILTIN Pervasives.DEREF,
                ([case !functorlv of
                    EnvironTypes.LVARFOO functorlv => LambdaTypes.VAR functorlv
                 | EnvironTypes.INTFOO ct =>
                    cg_longvalid(mklongvalid (Ident.VAR (make_functor_app ct)),env)],[]),
                NONE))

      (* global overloading-expressions for economy of lambda code *)
      val dexps_ref :
        ({index : int, size : int} list *
         (LambdaTypes.LVar * LambdaTypes.LambdaExp)) list ref = ref []

      (** overloading determination and formation **)
      fun longvalid_dexp_to_lambda(longValId as Ident.LONGVALID(_, Ident.VAR sy),
                                   denv,new_cg,instance,instance_info) =
        let
(*
          (* make runtime instance for polymorphic debugger *)
          (* ZERO | ONE of int | TWO of int * int *)
          (* Make a lambda expression for the instanceinfo object *)
          fun instance_to_lambda Datatypes.ZERO = LambdaTypes.INT 2
            | instance_to_lambda (Datatypes.ONE i) =
              LambdaTypes.STRUCT([LambdaTypes.INT 0,LambdaTypes.INT i],LambdaTypes.CONSTRUCTOR)
            | instance_to_lambda (Datatypes.TWO (i,i')) =
              LambdaTypes.STRUCT([LambdaTypes.INT 1,
                                  LambdaTypes.STRUCT([LambdaTypes.INT i,
                                                      LambdaTypes.INT i'],
                                                     LambdaTypes.CONSTRUCTOR)],
                                 LambdaTypes.CONSTRUCTOR)
*)
          fun make_instance () =
            (case instance of
               NONE => new_cg
                 | _ => Crash.impossible "polyvariable 1")
(*
             | SOME (ref Datatypes.NO_INSTANCE) => new_cg
             | SOME _ =>
                 (LambdaTypes.APP(new_cg,
                 ([instance_to_lambda instance_info],[]),
                                  NONE)))
*)
          fun fetch_instance' () =
            case instance_info of
              Datatypes.ZERO => NONE
            | Datatypes.ONE i => SOME i
            | _ => Crash.impossible "fetch_instance':longvalid_dexp_to_lambda:lambda"

          val dexp = dlookup_longvalid (longValId,denv)
          val dexp' = dexp_to_lambda  dexp
        in
          case dexp of
            EnvironTypes.NULLEXP => make_instance()
          | EnvironTypes.INT i =>
            LambdaTypes.APP
              (new_cg,
               ([let
                 val lexp = LambdaTypes.INT i
               in
                  case fetch_instance'() of
                    NONE =>
                      LambdaTypes.STRUCT([LambdaTypes.INT 0, lexp],LambdaTypes.CONSTRUCTOR)
                  | SOME i =>
                      LambdaTypes.STRUCT([LambdaTypes.INT 1,
                                          LambdaTypes.STRUCT([lexp,
                                                              LambdaTypes.INT i],
                                                             LambdaTypes.TUPLE)],
                      LambdaTypes.CONSTRUCTOR)
               end],[]),
               NONE)
          | EnvironTypes.LAMBDAEXP' _ =>
              LambdaTypes.APP(overload_exp,
                              ([LambdaTypes.STRUCT([new_cg,dexp',
                                                    case fetch_instance'() of
                                                      NONE => LambdaTypes.INT ~1
                                                    | SOME i => LambdaTypes.INT i],
                                                   LambdaTypes.TUPLE)],
                               []),
                              NONE)
          | _ =>
              let
                fun selects(EnvironTypes.LAMBDAEXP(selects,(_,lv),_)) = (selects,lv)
                  | selects _ = Crash.impossible "selects:longvalid_dexp_to_lambda:lambda"
                val (selects,root_lv) = selects dexp
              in
                (case Lists.assoc (selects,!dexps_ref) of
                   (lv,_) =>
                     case fetch_instance'() of
                       NONE => LambdaTypes.VAR lv
                     | SOME i =>
                         LambdaTypes.APP(LambdaTypes.VAR lv,
                                         ([LambdaTypes.INT i],[]),
                                         NONE))
                   handle Lists.Assoc =>
                     let
                       val (lexp,instance') =
                         case fetch_instance'() of
                           NONE =>
                             (LambdaTypes.APP(overload_exp,
                                              ([LambdaTypes.STRUCT([wrap_selects(selects,LambdaTypes.VAR root_lv),
                                                                   dexp',LambdaTypes.INT ~1],
                                                                  LambdaTypes.TUPLE)],
                                               []),
                                              NONE),
                              NONE)
                         | instance' =>
                             (let
                               val lv = new_LVar()
                             in
                               LambdaTypes.FN
				 (([lv],[]),
                                  LambdaTypes.APP
				    (overload_exp,
                                     ([LambdaTypes.STRUCT
                                        ([wrap_selects(selects,LambdaTypes.VAR root_lv),
                                          dexp', LambdaTypes.VAR lv],
                                         LambdaTypes.TUPLE)],[]),
                                     NONE),
                                    LambdaTypes.BODY,
                                  "overload for " ^ Symbol.symbol_name sy,
                                  Datatypes.NULLTYPE,
                                  RuntimeEnv.INTERNAL_FUNCTION)
                             end,
                             instance')

                       val lv = new_LVar()
                     in
                       (dexps_ref := (selects,(lv,lexp))::(!dexps_ref); (* Update global ref *)
                        case instance' of
                          NONE => LambdaTypes.VAR lv
                        | SOME i =>
                            LambdaTypes.APP(LambdaTypes.VAR lv,
                                            ([LambdaTypes.INT i],[]),
                                            NONE))
                     end
              end
        end
        | longvalid_dexp_to_lambda _ = Crash.impossible "longvalid_dexp_to_lambda:lambda"

      (** spill formation for type function instantiation;
          essentially two components, an integer formed from the argument debugger structure to
          the functor and a type-function data structure(see _debugger_print) formed by calling the
          type function function for that uninstantiated null tyfun which is accessed via the
          corresponding argument structure to the functor
       **)

      (* This where DebuggerPrint.TYFUN objects get made *)

      fun make_type_function (EnvironTypes.LAMBDAEXP (selects, (lv,lv'),_)) =
          LambdaTypes.STRUCT ([wrap_selects (selects, LambdaTypes.VAR lv),
                               LambdaTypes.APP(wrap_selects (selects,LambdaTypes.VAR lv'),
                                               ([unit_exp],[]),
                                               NONE)],
                              LambdaTypes.TUPLE)
        | make_type_function _ =
          Crash.impossible "make_type_function:lambda"

      (* convert a debugger-structure expression to lambda code for finding it at runtime *)
      fun dstrexp_to_lambda dstrexp =
        case dstrexp of
          EnvironTypes.LAMBDASTREXP (selects, lv, Datatypes.COPYSTR(_,str)) =>
            dstrexp_to_lambda (EnvironTypes.LAMBDASTREXP(selects, lv, str))
        | EnvironTypes.LAMBDASTREXP(selects, (lv,_), str as Datatypes.STR(_,_,
                                                       Datatypes.ENV(Datatypes.SE stridmap,
                                                                     Datatypes.TE tyconmap,
                                                                     Datatypes.VE(_,validmap)))) =>
          wrap_selects(selects, LambdaTypes.VAR lv) (* the lv will be bound to structure at runtime *)
        | EnvironTypes.LAMBDASTREXP'(selects,lv,Datatypes.COPYSTR(_,str)) =>
            dstrexp_to_lambda (EnvironTypes.LAMBDASTREXP'(selects,lv,str))
        (* functor_lv is either an lvar or an int *)
        | EnvironTypes.LAMBDASTREXP'(selects,functorlv,_) =>
            (wrap_selects
             (selects,
              LambdaTypes.APP (LambdaTypes.BUILTIN Pervasives.DEREF,
                               ([case !functorlv of
                                   EnvironTypes.LVARFOO functorlv => LambdaTypes.VAR functorlv
                                 | EnvironTypes.INTFOO ct =>
                                     cg_longvalid (mklongvalid (Ident.VAR (make_functor_app ct)),env)],
                                []),
                               NONE)))
        | EnvironTypes.DENVEXP(EnvironTypes.DENV(validmap,stridmap)) =>
            let
              val validmap = NewMap.to_list_ordered validmap
            in
              LambdaTypes.STRUCT(Lists.reducer (fn ((Ident.TYCON' _,dexp),tycons) =>
                                                dexp_to_lambda' dexp::tycons
                                                | (_,tycons) => tycons)
                                 (validmap,nil) @
                                 Lists.reducer (fn ((Ident.TYCON' _,_),vars) => vars
                                                | ((_,dexp),vars) => dexp_to_lambda dexp::vars)
                                 (validmap,nil) @
                                 map (fn (_,dstrexp) => dstrexp_to_lambda dstrexp)
                                 (NewMap.to_list_ordered stridmap),
                                 LambdaTypes.TUPLE)
            end

      (** dummy lambda code for a debugger structure **)
      fun str_to_lambda(Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE stridmap,
                                                        Datatypes.TE tyconmap,
                                                        Datatypes.VE(_,validmap)))) =
        LambdaTypes.STRUCT(map (fn _ => LambdaTypes.INT(~4))
                           (NewMap.to_list_ordered tyconmap) @
                           map (fn _ => LambdaTypes.INT 0)
                           (NewMap.to_list_ordered validmap) @
                           map (fn (_,str) => str_to_lambda str)
                           (NewMap.to_list_ordered stridmap),
                           LambdaTypes.TUPLE)
        | str_to_lambda(Datatypes.COPYSTR(_,str)) = str_to_lambda str

      (** compare strs and use the result for lambda code economy **)
      fun compare_strs(Datatypes.COPYSTR (_, str), str') =
        compare_strs (str, str')
        | compare_strs(str, Datatypes.COPYSTR (_, str')) =
          compare_strs (str, str')
        | compare_strs(Datatypes.STR (_, _,Datatypes.ENV
                                      (Datatypes.SE sm,
                                       Datatypes.TE tm,
                                       Datatypes.VE (_, vm))),
                       Datatypes.STR (_, _, Datatypes.ENV
                                      (Datatypes.SE sm',
                                       Datatypes.TE tm',
                                       Datatypes.VE (_, vm')))) =
          NewMap.size vm + NewMap.size tm = NewMap.size vm' + NewMap.size tm' andalso
          NewMap.size sm = NewMap.size sm' andalso
          (* recurse down the structure map *)
          Lists.forall
          compare_strs
          (Lists.zip(NewMap.range_ordered sm,NewMap.range_ordered sm'))

      (** propagate functor-signature to functor-body type function instantiations
          and polymorphic function overloading **)
      fun merge_dexps (dint,EnvironTypes.NULLEXP,_,location) = dint
        | merge_dexps (_,EnvironTypes.LAMBDAEXP(selects,lv,SOME _),SOME tystr,_) =
          EnvironTypes.LAMBDAEXP(selects,lv,SOME(fetch_ntf tystr))
        | merge_dexps(_,EnvironTypes.LAMBDAEXP'(selects,lv,SOME _),SOME tystr,_) =
          EnvironTypes.LAMBDAEXP'(selects,lv,SOME(fetch_ntf tystr))
        | merge_dexps(_,dexp,_,_) = dexp

      (** merge two debugger-structure expressions **)
      fun merge_dstrexps(dstr,SOME(Datatypes.COPYSTR(_,str)), dstrexp, location) =
          merge_dstrexps(dstr,SOME str,dstrexp, location)
        | merge_dstrexps(debugger_str,
                         SOME(str as
                                Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE(stridmap''),
                                                                Datatypes.TE(tyconmap''),
                                                                Datatypes.VE(_,validmap'')))),
                         dstrexp, location) =
          let
            fun merge_lambdastrexps LAMBDAEXP LAMBDASTREXP(selects,lv,str' as
                                Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE stridmap,
                                                                Datatypes.TE tyconmap,
                                                                Datatypes.VE(_,validmap)))) =
             if compare_strs(str',str) then
               LAMBDASTREXP(selects,lv,str)
             else
               EnvironTypes.DENVEXP(
               let
                 val size_validmap = NewMap.size validmap
                 val size_tyconmap = NewMap.size tyconmap
                 val size = NewMap.size stridmap + size_validmap + size_tyconmap
               in
                 NewMap.fold
                 (fn (env, tc' as Ident.TYCON tc, tystr) =>
                  Environ.add_valid_denv
                  (env, (Ident.TYCON' tc, LAMBDAEXP({index=NewMap.rank' (tyconmap,tc'),
                                                                    size=size}
                                                                   ::selects,lv,
                  SOME(fetch_ntf tystr)))))
                 (NewMap.fold
                  (fn (env, s, str) =>
                   Environ.add_strid_denv
                   (env, (s,
                          merge_dstrexps(debugger_str,SOME str,
                          LAMBDASTREXP({index=NewMap.rank' (stridmap,s) + size_validmap + size_tyconmap,
                                        size=size}
                   ::selects,lv,
                   NewMap.apply' (stridmap,s)), location))))
                  ((NewMap.fold
                    (fn (env, v, _) =>
                     Environ.add_valid_denv
                     (env, (v, LAMBDAEXP({index=NewMap.rank' (validmap,v) + size_tyconmap,
                                                        size=size}
                                                       ::selects,lv,NONE))))
                    (Environ.empty_denv, validmap'')), stridmap''), tyconmap'')
               end)
              | merge_lambdastrexps _ LAMBDASTREXP(selects,lv,Datatypes.COPYSTR(_,str')) =
                merge_dstrexps (debugger_str,SOME str,LAMBDASTREXP(selects,lv,str'), location)
          in
          (case dstrexp of
             EnvironTypes.LAMBDASTREXP args =>
               merge_lambdastrexps EnvironTypes.LAMBDAEXP EnvironTypes.LAMBDASTREXP args
           | EnvironTypes.LAMBDASTREXP' args =>
               merge_lambdastrexps EnvironTypes.LAMBDAEXP' EnvironTypes.LAMBDASTREXP' args
           | EnvironTypes.DENVEXP(EnvironTypes.DENV(validmap',stridmap')) =>
              (case !debugger_str of
                 Datatypes.DSTR(stridmap,tyconmap,validmap) =>
                  EnvironTypes.DENVEXP(
                   EnvironTypes.DENV(NewMap.fold
                     (fn (map,tc' as Ident.TYCON tc,i) =>
                      NewMap.define(map,Ident.TYCON' tc,
                        merge_dexps(EnvironTypes.INT i,
                                        NewMap.apply validmap' (Ident.TYCON' tc),
                                        SOME(NewMap.apply'(tyconmap'',tc')), location)))
                     (NewMap.map (fn (v,NONE) => merge_dexps (EnvironTypes.NULLEXP,
                                             (NewMap.apply' (validmap',v)),NONE, location)
                                  | (v,SOME i) =>
                                      merge_dexps(EnvironTypes.INT i,
                                                  NewMap.apply' (validmap',v),NONE, location))
                     validmap,tyconmap),
                     NewMap.map (fn (strid,dstr) =>
                                 merge_dstrexps(ref dstr,
                                                SOME(NewMap.apply' (stridmap'',strid)),
                                                NewMap.apply' (stridmap',strid), location))
                     stridmap))
               | Datatypes.EMPTY_DSTR =>
                   EnvironTypes.DENVEXP(EnvironTypes.DENV(
                     NewMap.map (fn (Ident.TYCON' tc,dexp) =>
                                 merge_dexps(EnvironTypes.NULLEXP,dexp,
                                  SOME(NewMap.apply'(tyconmap'',Ident.TYCON tc)), location)
                                 | (_,dexp) => dexp) validmap',
                     NewMap.map (fn (strid,dstrexp) =>
                                 merge_dstrexps(debugger_str,
                                                SOME(NewMap.apply' (stridmap'',strid)),
                                                dstrexp, location))
                     stridmap'))))
          end
        | merge_dstrexps(ref Datatypes.EMPTY_DSTR, NONE, dstrexp, _) = dstrexp
        | merge_dstrexps _ = Crash.impossible "merge_dstrexps:lambda"

      (** strip type functions in structures compiled with generate_moduler for
          compatibility purposes **)
      fun strip_tyfuns(lexp,env as EnvironTypes.ENV(valid_env, strid_env)) =
        let
          val lvar = new_LVar()
          val valid_map = NewMap.to_list_ordered valid_env
          val strid_map = NewMap.to_list_ordered strid_env
          val size1 = NewMap.size valid_env
          val size2 = size1 + NewMap.size strid_env
          fun filter_vars [] _ = []
            | filter_vars ((Ident.TYCON' _,_)::vars) index = filter_vars vars (index+1)
            | filter_vars (_::vars) index =
              LambdaTypes.SELECT({index=index, size=size2,selecttype=LambdaTypes.STRUCTURE},
                                 LambdaTypes.VAR lvar)::filter_vars vars (index+1)
          fun strip_strs [] _ = []
            | strip_strs ((_,(env,_,_))::strs) index =
              strip_tyfuns(LambdaTypes.SELECT({index=size1 + index, size=size2,selecttype=LambdaTypes.STRUCTURE},
                                              LambdaTypes.VAR lvar),
                           env)::strip_strs strs (index+1)
          val vars = filter_vars valid_map 0
          val strs = strip_strs strid_map 0
          val size3 = length valid_map - length vars
          val size4 = size2 - size3
        in
          (LambdaTypes.LET((lvar,NONE,lexp),
                           LambdaTypes.STRUCT(vars @ map #1 strs,LambdaTypes.TUPLE)),
           Lists.reducel (fn (env,((strid,(_,EnvironTypes.FIELD{index, ...},_)),env')) =>
                             Environ.add_strid_env(env,(strid,(env',
                                               EnvironTypes.FIELD{index=index-size3,size=size4},false)))
                           | (env,((strid,(_,comp,_)),env')) =>
                             Environ.add_strid_env(env,(strid,(env',comp,false))))
           (Lists.reducel (fn (env,(Ident.TYCON' _,_)) => env
                            | (env,(valid,EnvironTypes.FIELD{index, ...})) =>
                                Environ.add_valid_env(env,(valid,
                                                        EnvironTypes.FIELD{index=index-size3,size=size4}))
                            | (env,valid) => Environ.add_valid_env(env,valid))
            (Environ.empty_env,valid_map),
            Lists.zip(strid_map,map #2 strs)))
        end

      (** include type functions in structures compiled without generate_moduler for
          compatibility purposes **)
      fun include_tyfuns(lexp,Datatypes.COPYSTR(_,str),env) = include_tyfuns(lexp,str,env)
        | include_tyfuns(lexp,str as Datatypes.STR(_,_,
                                            Datatypes.ENV(Datatypes.SE stridmap,
                                                          Datatypes.TE tyconmap,
                                                          Datatypes.VE(_,validmap))),
                         env as EnvironTypes.ENV(valid_env, strid_env)) =


          let
            val lvar = new_LVar()
            val size1 = NewMap.size tyconmap
            val size2 = NewMap.size validmap
            val size3 = size2 + NewMap.size stridmap
            val size4 = size3 + size1
            val tyconmap = NewMap.to_list_ordered tyconmap
            val strid_env = NewMap.to_list_ordered strid_env
            fun new_vars [] _ = []
              | new_vars (_::vars) index =
                LambdaTypes.SELECT({index=index, size=size3,selecttype=LambdaTypes.STRUCTURE},
                                   LambdaTypes.VAR lvar)::new_vars vars (index+1)
            fun prepend_tycons [] = new_vars (NewMap.to_list_ordered validmap) 0
              | prepend_tycons (_::tycons) =
                LambdaTypes.FN(([new_LVar()],[]),
                               LambdaTypes.INT 1,
                               LambdaTypes.BODY,
                               "dummy tyfun tyfun",
                               LambdaTypes.null_type_annotation,
                               RuntimeEnv.INTERNAL_FUNCTION) ::
                prepend_tycons tycons
            fun include_strs [] _ = []
              | include_strs (((_,str),(env,_,_))::strs) index =
                include_tyfuns(LambdaTypes.SELECT({index=size2 + index, size=size3,selecttype=LambdaTypes.STRUCTURE},
                                                  LambdaTypes.VAR lvar),
                               str,env)::include_strs strs (index+1)
            val strs = include_strs (Lists.zip(NewMap.to_list_ordered stridmap,map #2 strid_env)) 0
          in
            (LambdaTypes.LET((lvar,NONE,lexp),
                             LambdaTypes.STRUCT(prepend_tycons tyconmap @
                                                map #1 strs,
                                                LambdaTypes.TUPLE)),
	     Lists.reducel (fn (map,((strid,(_,EnvironTypes.FIELD{index, ...},_)),env)) =>
                              Environ.add_strid_env(map,(strid,(env,
                                           EnvironTypes.FIELD{index=index+size1,size=size4},true)))
                            | (map,((strid,(_,comp,_)),env)) =>
                              Environ.add_strid_env(map,(strid,(env,comp,true))))
            (#1(Lists.reducel (fn ((map,index),(Ident.TYCON tc,_)) =>
                            (Environ.add_valid_env(map,(Ident.TYCON' tc,
                                                 EnvironTypes.FIELD{index=index,size=size4})),index+1))
             ((EnvironTypes.ENV(NewMap.map (fn (_,EnvironTypes.FIELD{index, ...}) =>
                                               EnvironTypes.FIELD{index=index+size1,size=size4}
                                            | (_,comp) => comp) valid_env,
               NewMap.empty (Ident.strid_lt,Ident.strid_eq)),0),tyconmap)),
             Lists.zip(strid_env,map #2 strs)))
          end

      (** Dummy debugger environment **)
      fun make_dstrexp(Datatypes.COPYSTR(_,str)) = make_dstrexp str
        | make_dstrexp(str as Datatypes.STR(_,_,
                                            Datatypes.ENV(Datatypes.SE stridmap,
                                                          Datatypes.TE tyconmap,
                                                          Datatypes.VE(_,validmap)))) =
          EnvironTypes.DENVEXP(
            EnvironTypes.DENV(
                  NewMap.union
                  (NewMap.fold (fn (map,Ident.TYCON tc,_) =>
                                NewMap.define(map,Ident.TYCON' tc,EnvironTypes.INT(~5)))
                   (NewMap.empty (Ident.valid_lt,Ident.valid_eq),tyconmap),
                   NewMap.map (fn _ => EnvironTypes.NULLEXP) validmap),
                  NewMap.map (fn (_,str) => make_dstrexp str) stridmap))

      fun fetch_interface(SOME(ref(SOME interface))) = interface
        | fetch_interface(SOME _) =
          Crash.impossible "1:NONE:fetch_interface:lambda"
        | fetch_interface _ =
          Crash.impossible "2:NONE:fetch_interface:lambda"

      local
        val empty_dstr = ref Datatypes.EMPTY_DSTR
      in
        fun fetch_debugger_str (SOME debugger_str) = debugger_str
          | fetch_debugger_str NONE = empty_dstr
      end

      fun fetch_tyfun (SOME tyfun) = tyfun
        | fetch_tyfun NONE =
          Crash.impossible "NONE:fetch_tyfun:lambda"

      (* Loads of refs *)
      (** spills generation for all uninstantiated type names in a functor **)
      val tyfun_refs_ref : Datatypes.Tyfun ref list ref = ref []
      val valenv_refs_ref : Datatypes.Valenv ref list ref = ref []
      val tyfun_spills_ref : (Datatypes.Tyfun ref * RuntimeEnv.Offset ref * LambdaTypes.LambdaExp) list ref = ref []
      val tyfun_lvars_ref : (Datatypes.Tyfun ref * (LambdaTypes.LVar * LambdaTypes.LambdaExp)) list ref = ref []

      fun type_spills (denv,ty) =
	let
	  fun type_spills (Datatypes.CONSTYPE(tys,tyn)) =
	    Lists.reducel (fn (spills,ty) => spills@type_spills ty)
	    (tyname_spills (denv,tyn),
	     tys)
	    | type_spills (Datatypes.FUNTYPE(ty1,ty2)) =
	      type_spills ty1 @ type_spills ty2
	    | type_spills (Datatypes.RECTYPE map) =
	      NewMap.fold (fn (spills,_, ty) => spills@type_spills ty) (nil,map)
	    | type_spills (Datatypes.METATYVAR(ref(_,ty,_),_,_)) = type_spills ty
	    | type_spills (Datatypes.META_OVERLOADED {1=ref ty,...}) =
	      type_spills ty
	    | type_spills (Datatypes.TYVAR(ref(_,ty,_),_)) = type_spills ty
	    | type_spills (Datatypes.METARECTYPE(ref(_,_,ty,_,_))) = type_spills ty
	    | type_spills _ = nil
          in
            type_spills ty
          end
        and typescheme_spills (denv,Datatypes.SCHEME(_,(ty,_))) = type_spills (denv,ty)
          | typescheme_spills (denv,Datatypes.UNBOUND_SCHEME(ty,_)) = type_spills (denv,ty)
          | typescheme_spills _ = nil
        and tyname_spills (denv,tyname) =
            let
              fun tyname_spills
                (Datatypes.METATYNAME(tf as ref(Datatypes.NULL_TYFUN _),name,_,_,
                                      ve' as ref(Datatypes.VE(_,ve)),_)) =
                if Datatypes.NewMap.is_empty ve then
                  if Lists.member(tf,!tyfun_refs_ref) then nil
                  else
                    (tyfun_refs_ref := tf::(!tyfun_refs_ref);
                     (* do_moduler_debug (fn () => "spill for " ^ name); *)
                     [(tf,
                      (case Lists.assoc(tf,!tyfun_lvars_ref) of
                         (lv,_) => LambdaTypes.VAR lv)
                         handle Lists.Assoc =>
                           let
                             val lv = new_LVar()
                             val lexp = make_type_function (dlookup_tycon(tf,denv))
                           in
                             (tyfun_lvars_ref := (tf,(lv,lexp))::(!tyfun_lvars_ref);
                              lexp)
                           end)]
                     handle exn =>
                       (ignore(fn () =>  (* This looks suspicious.... *)
                        do_moduler_debug
                        (fn () =>
                         "WARNING dlookup_tycon:" ^
                         IdentPrint.printLongValId print_options (mklongvalid (Ident.VAR(Symbol.find_symbol name)))));
                        []))
                else
                  if Lists.member(ve',!valenv_refs_ref) then nil
                  else
                    (valenv_refs_ref := ve'::(!valenv_refs_ref);
                     NewMap.fold (fn (spills,_,tysch) => spills@typescheme_spills (denv,tysch)) (nil,ve))
                | tyname_spills (Datatypes.METATYNAME(ref(Datatypes.ETA_TYFUN tyn),_,_,_,
                                                      ve' as ref(Datatypes.VE(_,ve)),_)) =
                  tyname_spills tyn @
                  (if Lists.member(ve',!valenv_refs_ref) then nil
                   else
                     (valenv_refs_ref := ve'::(!valenv_refs_ref);
                      NewMap.fold (fn (spills,_,tysch) =>
                                   spills@typescheme_spills (denv,tysch)) (nil,ve)))
                | tyname_spills (Datatypes.METATYNAME(ref(Datatypes.TYFUN(ty,_)),_,_,_,
                                                      ve' as ref(Datatypes.VE(_,ve)),_)) =
                  type_spills (denv,ty)@
                  (if Lists.member(ve',!valenv_refs_ref) then nil
                   else
                     (valenv_refs_ref := ve'::(!valenv_refs_ref);
                      NewMap.fold (fn (spills,_,tysch) =>
                                   spills@typescheme_spills (denv,tysch)) (nil,ve)))
                | tyname_spills (Datatypes.TYNAME
                                   (_,_,_,_,
                                    ve1 as ref(Datatypes.VE(_,ve2)),_,_,
                                    ve3 as ref(Datatypes.VE(_,ve4)),_)) =
                  let
                    val (ve',ve) =
                      (*if Datatypes.NewMap.is_empty ve4 then
                      else (ve1,ve2)*) (ve3,ve4)
                  in
                    if Lists.member(ve',!valenv_refs_ref) then nil
                    else
                      (valenv_refs_ref := ve'::(!valenv_refs_ref);
                       NewMap.fold (fn (spills,_,tysch) =>
                                    spills@typescheme_spills (denv,tysch)) (nil,ve))
                  end
            in
              tyname_spills tyname
            end
      (** accumulation of spill information for a lambda
       **)
      fun null_tyfun_spills (denv,
                             (RuntimeEnv.VARINFO(name,
                                                 (ref ty,inforef as ref (RuntimeEnv.RUNTIMEINFO (i,_))),_))) =
        if Types.isFunType ty then ()
        else
          let
            val spills =
              map (fn (tf,dexp) =>(tf, ref (RuntimeEnv.OFFSET1 0),dexp))
              (type_spills (denv,ty))
          in
            (* Update the RuntimeInfo ref in the VarInfo *)
            (inforef := (RuntimeEnv.RUNTIMEINFO (i,map (fn (tf,spill,_) =>(tf,spill)) spills));
             tyfun_spills_ref := spills@(!tyfun_spills_ref))
          end
        | null_tyfun_spills _ = ()

      val null_tyfun_spills =
        if generate_moduler then null_tyfun_spills
        else
          fn _ => ()

      (** generation of spill information for a lambda
       **)
      fun make_null_tyfun_spills lexp =
	let_lambdas_in_exp(
          map (fn (_,spill,tyfun) =>
               LambdaTypes.LETB(new_LVar(),
                                SOME(ref (RuntimeEnv.VARINFO
                                                    ("null_tyfun_spill",
                                                     dummy_instance (),
                                                     SOME spill))),
                                tyfun))
	  (!tyfun_spills_ref),
	  lexp)

      (** absolute spill generation of type function data structures for lexps involving evaluation
          orders that cannot possibly be determined at compile-time
       **)
      val store_null_tyfun_spills =
        if generate_moduler then
          fn () => (!tyfun_refs_ref, !valenv_refs_ref, !tyfun_spills_ref)
        else
          fn () => ([], [], [])

      fun init_null_tyfun_spills () =
        (tyfun_refs_ref := []; valenv_refs_ref := []; tyfun_spills_ref := [])

      val restore_null_tyfun_spills =
        if generate_moduler then
          fn (old_tyfun_refs_ref,old_valenv_refs_ref,old_tyfun_spills) =>
          (tyfun_refs_ref := old_tyfun_refs_ref;
           valenv_refs_ref := old_valenv_refs_ref;
           tyfun_spills_ref := old_tyfun_spills)
        else
          fn _ => ()

      fun make_lambdalist lambdas =
        Lists.reducer
        (fn (lambda,lambdalist) => LambdaTypes.STRUCT([lambda,lambdalist],LambdaTypes.TUPLE)) (lambdas,LambdaTypes.INT(1))

      val dummy_false = ref false
      val dummy_ve = ref Datatypes.empty_valenv
      (** Need type function functions which return a full set of spills for type function
          instantiation;
          absolute spill generation because these are typically invoked from modules foreign to that
          in which it is defined
       **)
      val TYPEdec_spills =
        if generate_moduler then
          fn denvir =>
          let
            fun TYPEdec_spills nil bindings = bindings
              | TYPEdec_spills ((_,tycon as Ident.TYCON sym,_,tyf)::rest) (env,denv,bindings) =
                TYPEdec_spills rest
                let
                  val tyfun_lvar = new_LVar()
                in
                  (Environ.add_valid_env(env, (Ident.TYCON' sym,
                                               EnvironTypes.LAMB(tyfun_lvar, EnvironTypes.NOSPEC))),
                   add_valid_denv(denv, (Ident.TYCON' sym,EnvironTypes.NULLEXP)),
                   LambdaTypes.LETB(tyfun_lvar,NONE,
                                    LambdaTypes.FN(([new_LVar()],[]),
                                                   make_lambdalist
                                                   (map (fn (_,spill) => spill)
                                                    (tyname_spills (denvir,
                                                       Datatypes.METATYNAME(fetch_tyfun tyf,"",0,
                                                                  dummy_false,dummy_ve,dummy_false)))),
                                                   LambdaTypes.BODY,
                                                   (init_null_tyfun_spills();
                                                    "spills for tycon " ^ IdentPrint.printTyCon tycon),
                                                   Datatypes.NULLTYPE,
                                                   RuntimeEnv.INTERNAL_FUNCTION))::bindings)
                end
          in
            TYPEdec_spills
          end
        else
          fn _ => fn _ => fn bindings => bindings
      (** Need type function functions which return a full set of spills for type function
          instantiation;
          absolute spill generation because these are typically invoked from modules foreign to that
          in which it is defined
       **)
      val DATATYPEdec_spills =
        if generate_moduler then
          let
            fun DATATYPEdec_spills (denvir,nil,bindings) = bindings
              | DATATYPEdec_spills (denvir,(_,tycon as Ident.TYCON sym,_,tyf,_)::rest,(env,denv,bindings)) =
                let
                  val tyfun_lvar = new_LVar()
                  val new_env = Environ.add_valid_env(env, (Ident.TYCON' sym,
                                                            EnvironTypes.LAMB(tyfun_lvar, EnvironTypes.NOSPEC)))
                  val new_denv = add_valid_denv(denv, (Ident.TYCON' sym,EnvironTypes.NULLEXP))
                  val new_binding =
                    LambdaTypes.LETB(tyfun_lvar,NONE,
                                     LambdaTypes.FN
                                     (([new_LVar()],[]),
                                      make_lambdalist
                                      (map (fn (_,spill) => spill)
                                       (tyname_spills (denvir,
                                                       Datatypes.METATYNAME(fetch_tyfun tyf,"",0,
                                                                            dummy_false,dummy_ve,dummy_false)))),
                                      LambdaTypes.BODY,
                                      (init_null_tyfun_spills();
                                       "spills for tycon " ^ IdentPrint.printTyCon tycon),
                                      Datatypes.NULLTYPE,
                                      RuntimeEnv.INTERNAL_FUNCTION))
                in
                  DATATYPEdec_spills (denvir,rest,(new_env,new_denv,new_binding::bindings))
                end
          in
            DATATYPEdec_spills
          end
        else
          fn (_,_,bindings) => bindings

      (* END{MODULES DEBUGGER} *)

      fun make_binding (lv,debug_info,instance,lexp,comment,location) =
        if variable_debug
          then [LambdaTypes.LETB(lv,SOME(ref debug_info),lexp)]
        else
          (* Just bind the expression to the variable *)
          [LambdaTypes.LETB (lv,NONE,lexp)]

      val debugger_env_ref = ref initial_debugger_env

      (** Now we need a function that will translate from abstract syntax to
       lambda expressions.  This is done on the way to translating to the
       machine description directly.
       Take an Absyn.Exp and a list of substitutions, and for each type
      of expression translate into the relevant piece of lambda
        calculus.  **)


       fun trans_exp(name, x, env, denv, fnname) =

          case x of
            (** Special constants are easy! **)
            Absyn.SCONexp (sc, ref ty) => LambdaTypes.SCON (sc, Types.sizeof ty)

          (** Lambda variable lookup, except for built-in values for which we
           extract the primitive value that the Environ has for this
           built-in. What's the Type ref for? **)
          (*  This may be more than just variable lookup.
           The longValId may be a nullary type constructor,
           or an exception constructor. We must eliminate these cases first,
           before attempting code generation of a lambda variable from the
           environment.
           *)
          | Absyn.VALexp(longValId, ref ty, location, ref(instance_info,instance)) =>
              (case longValId of
                 Ident.LONGVALID(p, valid as Ident.VAR sy) =>
                   let
                     val sy_name = Symbol.symbol_name sy

		     (* Explanation *)
		     (* Overloaded names are resolved here *)
		     (* An unresolved overloaded name binds to a primitive *)
		     (* Assuming this is the correct primitive for this name *)
		     (* then the name cannot have been rebound *)
		     (* So we check firstly for a primitive *)
		     (* in the current environment, and then in *)
		     (* a special initial environment of overloaded names only *)
		     (* to ensure that we have the correct one *)
		     (* This check is probably overly conservative *)
		     (* A simple check that the primitive produced is one of the *)
		     (* overloaded primitives might well suffice *)
                     val env_ol =
                       case p of
                         Ident.NOPATH =>
                           (case Environ.lookup_valid(valid, env) of
                              EnvironTypes.PRIM prim =>
				(case Environ.overloaded_op valid of
				   SOME prim' => prim = prim'
				 | _ => false)
                            | _ => false)
                       | _ => false

		     fun error_fn (valid, loc) =
		       Info.error'
		       error_info
		       (Info.FATAL, loc,
			"Unresolved overloading for "
			^ IdentPrint.printValId print_options valid)
                     val cg =
                       if env_ol then
			 let
			   val _ = Types.resolve_overloading
			       (not old_definition, ty, error_fn)

			   val sy_name' =
			     "_" ^ (overloaded_name ty) ^ sy_name

			   (* If we're dealing with a numeric type that
			      fits in one machine word, then we use the
			      derived lambda expressions in this file.
			      Otherwise we use built-in pervasives. *)
			   (* At present, derived operations exist only
			      for 8-bit and 16-bit values, and built-in
			      operations for 32-bit and default size values. *)
			   val small_type =
			     case Types.sizeof ty
			     of NONE => true
			     |  SOME sz =>
			       sz <= MachSpec.bits_per_word

			   val cg_opt =
			     if small_type then
			       lookup_derived_overload sy_name'
			     else
			       NONE
			 in
			   case cg_opt
			   of SOME cg => cg ()
			   |  NONE =>
                             (Diagnostic.output 2
                              (fn _ =>
                               ["Overloaded operator ",sy_name,
                                " instantiated to  ",sy_name',"\n"]);
                               cg_longvalid
                                 (mklongvalid
				    (Ident.VAR (Symbol.find_symbol sy_name')),
                                  Primitives.env_for_lookup_in_lambda))
			 end
                       else
                         cg_longvalid(longValId,env)

                     val (new_cg,built_in) =
                       case cg of
                         LambdaTypes.BUILTIN prim =>
                          (if isnt_eq_prim cg andalso isnt_neq_prim cg then
			     cg
                           else
                             let
			       (* Make sure we get the optimisations of poly eq *)
			       val _ = Types.resolve_overloading
				 (not old_definition, ty, error_fn)
                               val sy_name = if is_eq_prim cg then "=" else "<>"
			       val (ok, ty') = domain_type_name ty
			       val (ok, tyname) =
				 if ok then
				   domain_tyname ty'
				 else
				   (false, Types.int_tyname)
			     in
			       if ok then
				 let
				   fun ty_to_check(arg as (_, ty')) =
				     if check_one_vcc_and_no_nullaries ty' then
				       let
(*
					 val _ = print("Found one_vcc_and_no_nullaries for " ^ Types.extra_debug_print_type ty' ^ "\n")
*)
					 val (_, map) = TypeUtils.get_valenv ty'
				       in
					 case NewMap.to_list map of
					   (_, scheme) :: _ =>
					     let
					       val ty = TypeUtils.type_from_scheme scheme
					       val ty = case ty of
						 Datatypes.FUNTYPE(ty, _) => ty (* Get type contructed over *)
					       | _ => ty
(*
					       val _ = print("Converted to " ^ Types.extra_debug_print_type ty ^ "\n")
*)
					       val (ok, tyname) = domain_tyname ty
(*
					       val _ = print((if ok then "ok" else "not ok") ^ " and tyname " ^ Types.debug_print_name tyname ^ "\n")
*)
					     in
					       if ok then
						 ty_to_check(tyname, ty)
					       else
						 arg
					     end
					 | _ => Crash.impossible"ty_to_check: bad map"
				       end
				     else
				       arg
				   val (tyname, ty') = ty_to_check(tyname, ty')
				   val (ident, changed) =
				     if Types.has_int_equality tyname orelse
				       Types.has_ref_equality tyname orelse
				       check_no_vcc_for_eq ty' then
				       (mklongvalid(Ident.VAR(Symbol.find_symbol("_int" ^ sy_name))), true)
				     else
				     if Types.has_real_equality tyname then
				       (mklongvalid(Ident.VAR(Symbol.find_symbol("_real" ^ sy_name))), true)
				     else
				     if Types.has_string_equality tyname then
				       (mklongvalid(Ident.VAR(Symbol.find_symbol("_string" ^ sy_name))), true)
				     else
				     if Types.has_int32_equality tyname then
				       (mklongvalid(Ident.VAR(Symbol.find_symbol("_int32" ^ sy_name))), true)
				     else
				       (longValId, false)
				 in
				   if changed then
				     cg_longvalid(ident, Primitives.env_for_lookup_in_lambda)
				   else
				     cg
				 end
			       else
				 cg
			     end
,true)
                       | _ => (cg,false)
                   in
                     if built_in then
                       new_cg
                     else
                       (* pass instance around at runtime *)
                       (* This is where the instance function is applied *)
                       (* The instance and instance info are defined in the typechecker *)
                       (longvalid_dexp_to_lambda (longValId,denv,new_cg,instance,instance_info))
                   end
               | Ident.LONGVALID(_, valid as Ident.CON symbol) =>
                   let
                     val (location,tag) = constructor_tag(valid, ty)
                     val lexp = LambdaTypes.INT tag
                   in
                     case Environ.FindBuiltin(longValId, env) of
		       SOME prim => LambdaTypes.BUILTIN prim
                     | _ =>
			 if TypeUtils.is_vcc ty then
			   let
			     val new_lv = new_LVar()
			   in
			     LambdaTypes.FN
			     (([new_lv],[]),
			      if TypeUtils.get_no_cons ty > 1  andalso
				not (is_list_type (TypeUtils.get_cons_type ty))
				then
				  LambdaTypes.STRUCT([lexp, LambdaTypes.VAR new_lv],LambdaTypes.CONSTRUCTOR)
			      else
				LambdaTypes.VAR new_lv,
                              LambdaTypes.BODY,
                              let
				  val cons_type = TypeUtils.get_cons_type ty
				  val typename =
				    case cons_type of
				      Datatypes.CONSTYPE(_, tyname) =>
					Types.print_name options tyname
				    | _ => Crash.impossible"lambda:bad cons type"
				  val con_name =
				    "constructor " ^ Symbol.symbol_name symbol ^
				    " of " ^ typename
				in
				  if location = "" then
				    con_name
				  else
				    con_name ^ " [" ^ location ^ "]"
				end,
			      LambdaTypes.null_type_annotation,
                              RuntimeEnv.INTERNAL_FUNCTION)
			   end
			 else
			   lexp
                   end
               | Ident.LONGVALID(_, valid as Ident.EXCON _) =>
                   let val (le,_) = cg_longexid(longValId, env)
                   in
                     if TypeUtils.is_vcc ty then
                       let
                         val lv = new_LVar()
                       in
                         LambdaTypes.FN(([lv],[]),
                                        LambdaTypes.STRUCT([le, LambdaTypes.VAR lv],LambdaTypes.CONSTRUCTOR),
                                        LambdaTypes.BODY,
                                        "Builtin code to construct an exception",
                                        LambdaTypes.null_type_annotation,
                                        RuntimeEnv.INTERNAL_FUNCTION)
                       end
                     else
                       LambdaTypes.STRUCT([le, unit_exp],LambdaTypes.CONSTRUCTOR)
                   end
               | _ => Crash.impossible "TYCON':trans_exp:lambda")

          (** Translate each record element, and bundle them up as a STRUCT.
           The ordering is done based on the names of the labels in the
           record, but these are not placed into the STRUCT.  **)
          | Absyn.RECORDexp label_exp_list  =>
             let
                (** This is a known ordering for the labels of a record.  This will
                 always result in records with the same named fields being
                 represented by a STRUCT with the same field ordering.
                 This is in fact mildly bogus. We need to translate the set of
                 expressions in the order in which they were input (ie beware of
                 side effects), bind each to lambda variables
                 **)
                val lvar_lab_lexp_list =
                  map (fn (lab, exp) =>
                       (lab, new_LVar(),
                        trans_exp (" no_name", exp, env, denv, fnname)))
                  label_exp_list
              in
                let_lambdas_in_exp(map (fn (_, lv, le) =>
                                        LambdaTypes.LETB(lv,NONE, le))
                lvar_lab_lexp_list,
                LambdaTypes.STRUCT(map (fn (_, lvar, _) =>
                                        LambdaTypes.VAR lvar)
                                   (Lists.qsort known_order lvar_lab_lexp_list),
                                   LambdaTypes.TUPLE))
              end

    | Absyn.LOCALexp (decl, exp, _) =>
        let
          val (env', denv', lambda_list) = trans_dec (decl, env, false, denv, fnname)
        in
          let_lambdas_in_exp(lambda_list,
            trans_exp(" no_name", exp, Environ.augment_env(env, env'),
                      augment_denv(denv, denv'),
                      fnname))
        end

    (** Perform the application of the result of translation **)
    | Absyn.APPexp(fun_exp, val_exp,_,annotation,_) =>
       let
          val fcn =
            trans_exp(" inline_app", fun_exp, env, denv, fnname)
          val (is_poly, is_eq) =
            case fcn of
              LambdaTypes.BUILTIN Pervasives.EQ =>
                (true, true)
            | LambdaTypes.BUILTIN Pervasives.NE =>
                (true, false)
            | _ => (false, false)

          val arg =
            let
              val arg =
                trans_exp(" no_name", val_exp, env, denv, fnname)
            in
              if is_poly then
                LambdaOptimiser.simple_beta_reduce arg
              else
                arg
            end
          val (good_arg, new_arg, absyn) =
            if is_poly then
              (case (arg, val_exp) of
                 (LambdaTypes.STRUCT([le, le' as LambdaTypes.INT _],_),
                  Absyn.RECORDexp[_, (_, valexp as Absyn.VALexp _)]) =>
                 (true, LambdaTypes.STRUCT([le', le],LambdaTypes.TUPLE), valexp)
               | (LambdaTypes.STRUCT([le' as LambdaTypes.INT _, le],_),
                  Absyn.RECORDexp[(_, valexp as Absyn.VALexp _), _]) =>
                 (true, LambdaTypes.STRUCT([le', le],LambdaTypes.TUPLE), valexp)
                | _ => (false, arg, val_exp))
            else
              (false, arg, val_exp)
          val (true_val, false_val) =
            if is_eq then (LambdaTypes.INT 1, LambdaTypes.INT 0)
            else (LambdaTypes.INT 0, LambdaTypes.INT 1)
        in
          if is_poly andalso good_arg then
            let
              val (exp_arg, tag) = case new_arg of
                LambdaTypes.STRUCT([LambdaTypes.INT tag, le],_) => (le, tag)
              | _ => Crash.impossible "Bad polyeq arg"
              val ty = case absyn of
                Absyn.VALexp(_, ref ty,_,_) => ty
              | _ => Crash.impossible "Non-val generates poly eq"
              val def1 =
                if TypeUtils.get_no_cons ty > 1 then
                  SOME false_val
                else
                  NONE
            in
              LambdaTypes.SWITCH
              (exp_arg,
               SOME {num_imms = 1,num_vccs = 0},
               [(LambdaTypes.IMM_TAG (Int.toString tag,tag), true_val)],
               def1)
            end
          else
            LambdaTypes.APP(fcn, ([arg],[]),SOME annotation)
        end

    (** Throw away the type information (for now), and just transform the
     expression. This is in fact all we need to do, the type is irrelevant **)
    | Absyn.TYPEDexp (expression, _,_) =>
        trans_exp(" no_name", expression, env, denv, fnname)
    (** Code to cope with 'catch' and 'throw' of exceptions **)
    | Absyn.RAISEexp (exp,_) =>
        LambdaTypes.RAISE(trans_exp(" no_name", exp, env, denv, fnname))
    (* Later this might want to do something with the list *)
    (* of marks, but for now we ignore them *)

    | Absyn.HANDLEexp (exp, ty, pat_exp_list,location,annotation) =>
        let
          val old_null_tyfun_spills = store_null_tyfun_spills()
          val handle_exp =
            (init_null_tyfun_spills();
             make_null_tyfun_spills(
           LambdaTypes.HANDLE(
                           trans_exp(annotation, exp, env, denv, fnname),
                           let
                             val (root, tree,redundant_clauses,not_exhaustive) =
                               Match.compile_match pat_exp_list
                           in
                             if show_match then
                               (print"Exception match tree is\n";
                                Lists.iterate
                                print 
                                (Match.unparseTree print_options tree "");
                                print "\n";
                                ())
                             else ();
            let
              val ((static_report_required,static_str),
                   (dynamic_report_required,dynamic_str)) =
                case redundant_clauses of
                  [] => ((false,nil),(false,nil))
                | _ => print_redundancy_info (print_options,
                                              redundant_clauses,
                                              pat_exp_list)
            in
              if static_report_required then
                Info.error error_info (Info.WARNING, location,
                                       Lists.reducel op ^
                                       ("Redundant patterns in match:",static_str))
              else ();
              trans_match((root, tree), env, denv, true,
                          annotation,
              	          LambdaTypes.null_type_annotation,fnname,
                	  if dynamic_report_required then
                               (length pat_exp_list,dynamic_str,location)
                          else (0,[],location))
             end
end,
                         annotation)))
          val _ = restore_null_tyfun_spills old_null_tyfun_spills
        in
          handle_exp
        end

    (** This is a function definition, so perform the pattern matching,
      and return the appropriate Lambda. **)
    | Absyn.FNexp (pat_exp_list, ty, name_string,location) =>
        let
          val (root, tree,redundant_clauses,not_exhaustive) =
            Match.compile_match pat_exp_list
          fun print_list print_fn (list, sep, start, finish) =
            case list of
              [] => start ^ finish
            | (x :: xs) =>
                Lists.reducel
                (fn (str, elem) => str ^ sep ^ print_fn elem)
                (start ^ print_fn x, xs) ^ finish
        in
           if name_string = "Sequence expression"
           then
             let val lhs_ty = #1(Types.argres(!ty))
              in if (Types.type_eq(lhs_ty, Types.empty_rectype, true, true))
                 then
                   ()
                 else
                   Info.error error_info (Info.WARNING, location,
                     "Non-final expression in a sequence has type "
                     ^ Types.print_type options lhs_ty ^ "." )
             end
           else ();

           if show_match then
             (print "Match tree is\n";
              Lists.iterate print (Match.unparseTree print_options tree "");
              print "\n";
              ())
           else
             ();
  
           (case not_exhaustive of
              SOME missing_constructors =>
                Info.error error_info
                (Info.WARNING, location,
                 print_list
                 (fn (ty, valid_list) =>
                  case valid_list of
                    [] => ("missing values of type " ^ Types.print_type options ty)
                  | _ => 
                      print_list
                      (IdentPrint.printValId print_options)
                      (valid_list, ", ",
                       "missing constructors of type " ^
                       Types.print_type options ty ^
                       " : ",
                       ""))
                 (missing_constructors, "\n", "Match not exhaustive\n", ""))
             | _ => ());

               let
                 val ((static_report_required,static_str),
                      (dynamic_report_required,dynamic_str)) =
                   case redundant_clauses of
                     [] => ((false,nil),(false,nil))
                   | _ => print_redundancy_info (print_options,
                                                 redundant_clauses,
                                                 pat_exp_list)
               in
                 if static_report_required then
                   Info.error error_info (Info.WARNING, location,
                                          Lists.reducel op ^
                                          ("Redundant patterns in match:",static_str))
                 else ();
                   trans_match((root, tree), env, denv, false,name_string,!ty,fnname,
                             if dynamic_report_required then
                               (length pat_exp_list,dynamic_str,location)
                             else (0,[],location))
               end
        end

      | Absyn.MLVALUEexp value => LambdaTypes.MLVALUE value

      (* Dynamic expressions *)
      (* info = (<a type>,<tyvar level>,<explicit tyvars>) *)
      (* the type is closed over using the level and tyvar information *)

      | Absyn.DYNAMICexp (exp,_,ref (ty,level,tyvars))=>
          (let
            (* Sort out overloadings within the type *)
            val _ =
              let
                fun error_fn (valid, loc) =
                  Info.error' error_info
                  (Info.FATAL, loc,
                   "Unresolved overloading for "
                   ^ IdentPrint.printValId print_options valid)
              in
                Types.resolve_overloading (not old_definition,ty,error_fn)
              end

            (* Translate the dynamic expression *)

            val lexpr = trans_exp (name,exp,env, denv, fnname)

            (* The type is inserted into the lambda code as a literal MLValue *)
            (* Note that this won't work with cross compilation and separate compilation *)
            val tyexpr = LambdaTypes.MLVALUE
                         (cast
                          (TyperepUtils.convert_dynamic_type (use_value_polymorphism,ty,level,tyvars)))
          in
            (* And make a pair (which will be of type Dynamic)  *)
            LambdaTypes.STRUCT([lexpr,tyexpr],LambdaTypes.TUPLE)
          end
          handle TyperepUtils.ConvertDynamicType =>
            Info.error' error_info (Info.FATAL,Location.UNKNOWN,"Free variables in dynamic type"))
      | Absyn.COERCEexp (exp,_,ref atype, _) =>
          trans_exp (name, TyperepUtils.make_coerce_expression (exp,atype),
                     env, denv, fnname)

       (* End of trans_exp *)

       (* The match translator.
         For a definition of the input supplied, see match.sml
         The match tree has six variants, handled as follows:-
         ERROR - raise match
         LEAF - bind the valids to the lambda variables associated with the match
         vars (thus updating the value environment, but not generating any code)
         and translate the expression within this new value environment
         RECORD - for each label, matchvar pair, produce a lambdavar, lambdaexp pair
                 where the lambdaexp expresses the selection of the labelled item from the
                 record, and the lambdavar is bound to it and also to the matchvar.
                 Translate the tree in this new match environment, and let_lambdas_in_exp
                 of the lambdavar, lambdaexp list and the translation of the tree.
         SCON - switch on the value of the lambda variable associated with the matchvar
                into the labelled cases or the default.
         CONSTRUCTOR - only matchvars corresponding to value carrying constructors
                   are relevant here. For each of these, the associated value is
                   SELECT(1, VAR lambda of original matchvar) (though the type of this may
                   vary, the way of acquiring it doesn't), or if the type has precisely one
                   constructor, and this is value carrying, then the value is
                   VAR lambda of original matchvar. The result is basically a switch, with
                   various possibilities according to how many constructors the type has,
                   whether all are mentioned here, whether all nullary constrcutors are
                   mentioned etc.
        *)

        and trans_match((root, tree), env, denv, is_exn, name_string, ty, fnname_info,
                        (number_of_clauses,redundant_clauses,location)) =
          let
            local
              val match_trans_count_ref : int ref = ref ~1
            in
              fun new_match_trans() =
                (match_trans_count_ref := (!match_trans_count_ref)+1;
                 !match_trans_count_ref)
            end

	    local
	      open LambdaTypes
	      fun telfun f (EXP_TAG e, e') = (EXP_TAG (f e), f e')
		| telfun f (t,e) = (t,f e)

	      fun optfun f (SOME x) = SOME (f x)
		| optfun f NONE = NONE

	      fun hashmap_find (v,env) = IntHashTable.tryLookup (env,lvar_to_int v)
	      val new_valid = new_LVar

	      fun alpha (binds,e) =
		let
		  fun aux (e as INT _) = e
		    | aux (e as SCON _) = e
		    | aux (e as MLVALUE _) = e
		    | aux (e as BUILTIN _) = e
		    | aux (e as VAR v) =
		      (case hashmap_find (v,binds) of
			 SOME e' => e'
		       | NONE => e)
		    | aux (APP (e,(el,fpel),ty)) = APP (aux e,(map aux el,map aux fpel),ty)
		    | aux (STRUCT (el,ty)) = STRUCT (map aux el,ty)
		    | aux (SWITCH (e,info,tel,opte)) =
		      SWITCH (aux e, 
			      info,
			      map (telfun aux) tel,
			      optfun aux opte)
		    | aux (HANDLE (e1,e2,s)) = HANDLE(aux e1,aux e2,s)
		    | aux (RAISE e) = RAISE (aux e)
		    | aux (SELECT (info,e)) = SELECT (info,aux e)
		    | aux (LET ((v,i,e1),e2)) =
		      let
			val v' = new_valid ()
			val e1' = aux e1
			val _ = IntHashTable.update (binds,lvar_to_int v,VAR v')
		      in
			LET((v',i,e1'),aux e2)
		      end
		    | aux (FN ((vl,fpvl),body,status,name,ty,info)) =
		      let
			val new_vl = map (fn v => (v,new_valid ())) vl
			val new_fpvl = map (fn v => (v,new_valid ())) fpvl
			val _ =
			  Lists.iterate
			  (fn (v,v') => IntHashTable.update (binds,lvar_to_int v,VAR v'))
			  (new_vl @ new_fpvl)
		      in
			FN ((map #2 new_vl,map #2 new_fpvl),aux body,status,name,ty,info)
		      end
		    | aux (LETREC (fl,el,e)) =
		      let
			val fl' = map (fn (v,info) => (new_valid(),info)) fl
			val _ =
			  Lists.iterate
			  (fn ((v,_),(v',_)) => IntHashTable.update (binds,lvar_to_int v,VAR v'))
			  (Lists.zip (fl,fl'))
		      in
			LETREC (fl',map aux el,aux e)
		      end
		in
		  aux e
		end

	      fun empty_hashmap () =
		IntHashTable.new 16

	    in
	      fun rename e = alpha (empty_hashmap () ,e)
	    end

	    local
	      open LambdaTypes
	    in
	      fun has_bounds(INT _) = false
		| has_bounds(SCON _) = false
		| has_bounds(MLVALUE _) = false
		| has_bounds(BUILTIN _) = false
		| has_bounds(VAR _) = false
		| has_bounds(APP(e,(el,fpel), _)) =
		  has_bounds e orelse Lists.exists has_bounds (el@fpel)
		| has_bounds(STRUCT(el,_)) = Lists.exists has_bounds el
		| has_bounds(SWITCH(e,info,tel,opte)) =
		  has_bounds e orelse Lists.exists has_bounds_tag_exp tel orelse
		  has_bounds_opt opte
		| has_bounds(HANDLE (e1,e2,_)) = has_bounds e1 orelse has_bounds e2
		| has_bounds(RAISE e) = has_bounds e
		| has_bounds(SELECT (_,e)) = has_bounds e
		| has_bounds(LET _) = true
		| has_bounds(FN _) = true
		| has_bounds(LETREC _) = true

	      and has_bounds_opt(SOME e) = has_bounds e
		| has_bounds_opt _ = false

	      and has_bounds_tag_exp(t, e) = has_bounds e orelse has_bounds_tag t

	      and has_bounds_tag(VCC_TAG _) = false
		| has_bounds_tag(IMM_TAG _) = false
		| has_bounds_tag(SCON_TAG _) = false
		| has_bounds_tag(EXP_TAG e) = has_bounds e

(*
	      val rename = fn e =>
		if has_bounds e then
		  (output(std_out, "Renaming because of bound variables\n");
		   rename e)
		else
		  (output(std_out, "Not renaming because no bound variables\n");
		   e)
*)

	      fun size(n, INT _) = n+1
		| size(n, SCON _) = n+1
		| size(n, MLVALUE _) = n+1
		| size(n, BUILTIN _) = n+1
		| size(n, VAR _) = n+1
		| size(n, APP(e, (el,fpel), _)) =
		  size(Lists.reducel size (n+1, (fpel @ el)), e)
		| size(n, STRUCT(el,_)) = Lists.reducel size (n+1, el)
		| size(n, SWITCH(e,info,tel,opte)) =
		  Lists.reducel size_tag_exp (size_opt(size(n+1, e), opte), tel)
		| size(n, HANDLE(e1,e2,_)) = size(size(n+1, e1), e2)
		| size(n, RAISE e) = size(n+1, e)
		| size(n, SELECT(_,e)) = size(n+1, e)
		| size(n, LET((_, _, le), le')) = size(size(n+1, le), le')
		| size(n, FN(_, le, _, _, _, _)) = size(n+1, le)
		| size(n, LETREC(_, lel, le)) = Lists.reducel size (size(n+1, le), lel)

	      and size_opt(n, SOME e) = size(n, e)
		| size_opt(n, _) = n

	      and size_tag_exp(n, (t, e)) = size(size_tag(n, t), e)

	      and size_tag(n, VCC_TAG _) = n+1
		| size_tag(n, IMM_TAG _) = n+1
		| size_tag(n, SCON_TAG _) = n+1
		| size_tag(n, EXP_TAG e) = size(n+1, e)

	    end

	    val debugging = generate_debug_info orelse generate_moduler orelse debug_variables

(*
	    val _ = output(std_out, "Debugging = " ^
			   (if debugging then "true\n" else "false\n"))
*)

	    val binding_list = ref ([] : (LambdaTypes.LVar * LambdaTypes.LambdaExp) list)
	    fun find_binding lv =
	      if debugging then
		SOME(Lists.assoc(lv, !binding_list))
		handle Lists.Assoc => NONE
	      else
		NONE

	    fun report_binding(lv, opt_e) =
(*
	      output(std_out,
		     (case opt_e of
			SOME e => "Found binding for " ^ LambdaTypes.printLVar lv ^
			  " as : " ^ LambdaPrint.string_of_lambda e
		      | NONE => "Missed binding for " ^ LambdaTypes.printLVar lv) ^
			"\n")
*)
	      ()

	    fun add_binding(lv, le) =
	      if debugging then
		let
		  val arg as (_, e) = (lv, LambdaOptimiser.simple_beta_reduce le)
(*
		  val _ =
		    output(std_out,
			   "Adding binding for " ^ LambdaTypes.printLVar lv ^
			  " as : " ^ LambdaPrint.string_of_lambda e ^ "\n")
*)
		in
		  if size(0, e) <= 200 then
		    binding_list := arg :: !binding_list
		  else
(*
		    output(std_out, "Not adding because lambda expression too large\n")
*)
		    ()
		end
	      else
		()

            val root_lambda = new_LVar()
            val excp =
              if is_exn then
                LambdaTypes.RAISE(LambdaTypes.VAR root_lambda)
              else
                LambdaTypes.RAISE(LambdaTypes.STRUCT([LambdaTypes.BUILTIN Pervasives.EXMATCH, unit_exp],LambdaTypes.CONSTRUCTOR))
            val match_env =
              add_match_env((root,(root_lambda,NONE)),empty_match_env)

            (* This crap is a relic from stepping, I think *)
	    (* the function funny_name_p has moved to the top *)

            (* Retain user name of functions where possible ... *)
            fun filter_name (name_string,fnname) =
              if funny_name_p name_string then fnname else name_string

            val fnname =
              let
                val name =
                  case fnname_info of
                    SOME (s,_) => s
                  | _ => ""
              in
                filter_name (name_string,name)
              end

            val fnname_lv = new_LVar ()

            (* Accumulate Dynamic redundancy checker for this strdec dec by SWITCHing on
               boolean expressions provided by the Match Compiler
             *)
            fun redundancy_code () =
              case redundant_clauses of
                nil => ()
              | _ =>
              let
                val redundant_clauses_lambda = new_LVar()
                val MLWorks_Internal_StandardIO_printError =
                      cg_longvalid(make_longid (["MLWorks","Internal","StandardIO"],"printError"),env)
                fun redundant_clauses_lambdas nil = nil
                  | redundant_clauses_lambdas (((_,exns),rc)::rcs) =
                    let
                      val lvar = new_LVar()
                    in
                      (lvar,exns,rc,
                       LambdaTypes.LETB
			 (lvar,
			  NONE,
                          LambdaTypes.APP
			    (LambdaTypes.BUILTIN Pervasives.REF,
                             ([LambdaTypes.SCON(Ident.STRING rc, NONE)],[]),
                             NONE)))
                      ::redundant_clauses_lambdas rcs
                    end
                val redundant_clauses = redundant_clauses_lambdas redundant_clauses
                val bindings = map (fn (_,_,_,bd) => bd) redundant_clauses
                fun make_dynamic_redundancy_report() =
                  let
                    fun report nil = LambdaTypes.SCON(Ident.STRING("\n"), NONE)
                      | report ((lvar,_,_,_)::rcs) =
                        LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.HAT,
                                        ([LambdaTypes.STRUCT([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
                                                                              ([LambdaTypes.VAR lvar],[]),
                                                                              NONE),
                                                              report rcs],
                                                             LambdaTypes.TUPLE)],
                                         []),
                                        NONE)
                  in
                    LambdaTypes.SWITCH(
                            LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.INTEQ,
                                            ([LambdaTypes.STRUCT([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
                                                                                  ([LambdaTypes.VAR redundant_clauses_lambda],[]),
                                                                                NONE),
                                                                LambdaTypes.SCON(Ident.INT("0",Location.UNKNOWN), NONE)],
                                                                LambdaTypes.TUPLE)],
                                             []),
                                            NONE),
                            SOME {num_imms = 2,num_vccs = 0},
                            [(LambdaTypes.IMM_TAG ("",1),unit_exp),
                             (LambdaTypes.IMM_TAG ("",0),
                               LambdaTypes.APP(MLWorks_Internal_StandardIO_printError,
                                ([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.HAT,
                                  ([LambdaTypes.STRUCT([LambdaTypes.SCON(Ident.STRING(
                                                      Location.to_string location ^ ": " ^ "warning" ^ ": " ^
                                                                     "Redundant patterns in match:\n"), NONE),
                                                      report redundant_clauses],
                                                      LambdaTypes.TUPLE)],
                                   []),
                                  NONE)],
                                 []),
                                NONE))],
                            NONE)
                  end
                fun redundancy_code nil = make_dynamic_redundancy_report()
                  | redundancy_code ((lvar,exns,rc,_)::rcs) =
                    let
                      (* code for an exception constructor must be free of *)
                      (* all lambda variables bound in this strdec dec *)
                      fun exn_code (exn as Ident.LONGVALID(p,s)) =
                        let
                          val (exp,longstrid) = cg_longexid(exn,env)
                          (* longstrid : (Ident.longstrid,int/lvar) option opt *)
                          val select_exp =
                            case (longstrid,exn) of
                              (EnvironTypes.STRIDSPEC (Ident.LONGSTRID(p,Ident.STRID s)),
                               Ident.LONGVALID(p',s')) =>
                              let
                                val newlongstrid =
                                  Ident.LONGVALID (combine_paths (p, combine_paths (Ident.PATH(s,Ident.NOPATH),p')),s')
                              in
                                #1(cg_longexid (newlongstrid,env))
                              end
                            | (EnvironTypes.VARSPEC lvar, _) =>
                              LambdaTypes.VAR lvar
                            | (EnvironTypes.NOSPEC, _) => exp
                        in
                          LambdaTypes.SELECT({index = 0, size = 2,selecttype=LambdaTypes.CONSTRUCTOR},
                                             select_exp)
                        end
                      fun switches (Match.==(exn1,exn2)) =
                          LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.INTEQ,
                                          ([LambdaTypes.STRUCT([exn_code exn1,exn_code exn2],
                                                               LambdaTypes.TUPLE)],
                                           []),
                                          NONE)
                        | switches (Match.&&(exn1,exn2)) =
                          LambdaTypes.SWITCH(switches exn1,
                                             SOME {num_imms = 2,num_vccs = 0},
                                             [(LambdaTypes.IMM_TAG ("",1),switches exn2),
                                              (LambdaTypes.IMM_TAG ("",0),LambdaTypes.INT 0)],
                                             NONE)
                        | switches (Match.||(exn1,exn2)) =
                          LambdaTypes.SWITCH(switches exn1,
                                             SOME {num_imms = 2,num_vccs = 0},
                                             [(LambdaTypes.IMM_TAG ("",1),LambdaTypes.INT 1),
                                              (LambdaTypes.IMM_TAG ("",0),switches exn2)],
                                             NONE)
                        | switches Match.TRUE = LambdaTypes.INT 1
                        | switches Match.FALSE = LambdaTypes.INT 0
                    in
                      LambdaTypes.LET((new_LVar(),NONE,
                       LambdaTypes.SWITCH(switches exns,
                        SOME {num_imms = 2,num_vccs = 0},
                        [(LambdaTypes.IMM_TAG ("",1),
                          LambdaTypes.STRUCT([
                           LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.BECOMES,
                           ([LambdaTypes.STRUCT([LambdaTypes.VAR lvar,
						LambdaTypes.SCON (Ident.STRING("\n  ->" ^ (String.extract (rc, 5, NONE))), NONE)],
					       (* tl(tl(tl(tl(tl(explode rc))))))), NONE)], *)
                             LambdaTypes.TUPLE)],
                            []),
                            NONE),LambdaTypes.INT 1],
                          LambdaTypes.TUPLE)),
                        (LambdaTypes.IMM_TAG ("",0),
                           LambdaTypes.STRUCT([
                            LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.BECOMES,
                             ([LambdaTypes.STRUCT([LambdaTypes.VAR redundant_clauses_lambda,
                              LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.INTMINUS,
                                ([LambdaTypes.STRUCT([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
                                                                      ([LambdaTypes.VAR redundant_clauses_lambda],[]),
                                                                    NONE),
                                               LambdaTypes.SCON(Ident.INT("1",Location.UNKNOWN), NONE)],
                                LambdaTypes.TUPLE)],
                                 []),
                                NONE)],
                            LambdaTypes.TUPLE)],[]),
                            NONE), LambdaTypes.INT 1],
                           LambdaTypes.TUPLE))],
                        NONE)),
                       redundancy_code rcs)
                    end
              in
                (dynamic_redundancy_report_ref :=
                 let
                   val dynamic_report = !dynamic_redundancy_report_ref
                 in
                   fn exp =>
                   dynamic_report
                   (LambdaTypes.LET
                    ((new_LVar(),NONE,
                     let_lambdas_in_exp
                     (LambdaTypes.LETB
                      (redundant_clauses_lambda,NONE,
                       LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                       ([LambdaTypes.SCON(Ident.INT(Int.toString number_of_clauses,
                                                                   Location.UNKNOWN), NONE)],
                                        []),
                                       NONE)) ::
                      bindings,redundancy_code redundant_clauses)),
                     exp))
                 end)
              end

            (* Tree matching function *)
            fun tr_match(tree, match_env, val_env) =
             let
               (* Sometimes the match translator returns an incomplete match *)
               (* This function ensures that all such matches have a default case *)
               fun ensure_default (LambdaTypes.SWITCH (exp,info,tel,NONE)) =
                 let
                   fun last ([],_) = Crash.impossible "ensure_default"
                     | last ([a],acc) = (rev acc,a)
                     | last (a::rest,acc) = last (rest,a::acc)
                   val (tel',(t,e)) = last (tel,[])
                 in
                   LambdaTypes.SWITCH (exp,info,tel',SOME e)
                 end
		 | ensure_default exp = exp
	       fun lvar_let_lambdas_in_exp (lambda_exp,bindings,lvar_info) =
                 let
                   (* Very horrid indeed *)
                   fun add_match_string (name, match_string) =
                     let
                       val match_string' = explode match_string
                       fun aux (#"[" ::rest,acc) =
                         (implode (rev acc)) ^ match_string ^
                         (implode( #"[" :: rest))
                         | aux (c::rest,acc) = aux (rest,c::acc)
                         | aux ([],acc) = name ^ match_string
                     in
                       aux (explode name,[])
                     end
                   val (this_lvar,this_lexp) =
                     case lvar_info of
                       SOME lvar => lvar
                     | NONE => (new_LVar(), LambdaTypes.INT 1)
                   fun do_binding nil = nil
                     | do_binding (Match.INL (ref NONE)::bindings) =
                       do_binding bindings
                     | do_binding (Match.INL (ref (SOME (lvar as ref(Match.INL(_,tree)))))::bindings) =
                       let
                         val lv =  new_LVar()
                         val match_fnname =
                             if fnname = name_string then
                               add_match_string (name_string,"<Match" ^ Int.toString(new_match_trans()) ^ ">")
                             else
                               add_match_string (name_string,
                                                 "<Match" ^ Int.toString(new_match_trans()) ^ ">")
			 val _ = lvar := Match.INR lv
			 (* Something to do with match compilation *)
			 val fnbody =
			   let
			     val old_null_tyfun_spills = store_null_tyfun_spills()
			     val tr_match =
			       (init_null_tyfun_spills();
				make_null_tyfun_spills(tr_match(tree,match_env,val_env)))
			     val _ = restore_null_tyfun_spills old_null_tyfun_spills
			   in
			     ensure_default tr_match
			   end
			 val fnexp =
			   LambdaTypes.FN(([new_LVar()],[]),
			   fnbody,
                           LambdaTypes.BODY,
			   match_fnname,
			   LambdaTypes.null_type_annotation, (* Or we could pass in the free variables and get a type *)
                           RuntimeEnv.INTERNAL_FUNCTION)
			 val _ = add_binding(lv, fnbody)
		       in
			 LambdaTypes.LETB
			 (lv, NONE,
                           (* This where default functions are created *)
                           (* It would be nice to have these take all their free variables as parameters *)
			  fnexp) :: do_binding bindings
		       end
                     | do_binding (Match.INL _::_) =
                       Crash.impossible "1:do_binding:lvar_let_lambdas_in_exp:Match_translator:_lambda.sml"
                     | do_binding (Match.INR(lvar' as ref (Match.INL (_,tree)),matchvar)::bindings) =
                       let
                         val lv =  new_LVar()
                         val match_fnname =
                           add_match_string (name_string,"<Match" ^ Int.toString(new_match_trans()) ^ ">")
			 val _ = lvar' := Match.INR lv
			 (* Something to do with match compilation *)
			 val fnbody =
			   let
			     val old_null_tyfun_spills = store_null_tyfun_spills()
			     val tr_match =
			       (init_null_tyfun_spills();
				make_null_tyfun_spills
				(case matchvar of
				   ~1 => tr_match(tree, match_env, val_env)
				 | _ =>
				     LambdaTypes.LET
				     ((this_lvar,NONE,this_lexp),
				      tr_match
				      (tree,
				       add_match_env
				       ((matchvar,(this_lvar,NONE)),
					match_env),
				       val_env))))
			     val _ = restore_null_tyfun_spills old_null_tyfun_spills
			   in
			     ensure_default tr_match
			   end
			 val fnexp =
			   LambdaTypes.FN
			   (([new_LVar()],[]),
			    fnbody,
                            LambdaTypes.BODY,
			    match_fnname,
			    LambdaTypes.null_type_annotation, (* Or we could pass in the free variables and get a type *)
			    RuntimeEnv.INTERNAL_FUNCTION)
			 val _ = add_binding(lv, fnbody)
                       in
			 LambdaTypes.LETB
			 (lv,NONE,
			  (* This where default functions are created *)
			  fnexp) :: do_binding bindings
		       end
                     | do_binding (Match.INR _::_) =
                       Crash.impossible "2:do_binding:lvar_let_lambdas_in_exp:Match_translator:_lambda.sml"
                 in
                   let_lambdas_in_exp (do_binding bindings,lambda_exp())
                 end
	       fun Tr_Default default =
		 let
		   fun Tr_Default (ref(Match.BUILT(ref(Match.INR lvar)))) =
		     let
		       val opt_e = find_binding lvar
		       val _ = report_binding(lvar, opt_e)
		     in
		       case opt_e of
			 SOME y => SOME(rename y)
		       | _ =>
			   SOME(LambdaTypes.APP(LambdaTypes.VAR lvar, ([unit_exp],[]), NONE))
		     end
		     | Tr_Default (ref(Match.BUILT(ref(Match.INL(0,tree))))) =
		       SOME
		       (init_null_tyfun_spills();
			make_null_tyfun_spills
			(tr_match(tree, match_env, val_env)))
		     | Tr_Default (ref(Match.ERROR _)) =
		       SOME excp
		     |  Tr_Default _ = Crash.impossible "1:Tr_Default:tr_match:_lambda.sml"
		 in
		   case default of
		     Match.INL (SOME default) => Tr_Default default
		   | Match.INL NONE => NONE
		   | Match.INR (ref (Match.INR lvar)) =>
		     let
		       val opt_e = find_binding lvar
		       val _ = report_binding(lvar, opt_e)
		     in
		       case opt_e of
			 SOME y => SOME(rename y)
		       | _ =>
			   SOME (LambdaTypes.APP
				 (LambdaTypes.VAR lvar, ([unit_exp],[]), NONE))
		     end
		   | Match.INR _ =>
		       Crash.impossible "2:Tr_Default:tr_match:_lambda.sml"
		 end
	     in
              case tree of
                Match.LEAF(exp, n, mv_valid_ty_list) =>
                  let
                    fun do_leaf([], env, denv) =
                      trans_exp(" match_leaf", exp, env, denv, SOME (fnname,fnname_lv))
                      | do_leaf((mv, valid, ty) :: tl, env, denv) =
                          case lookup_match(mv, match_env) of
                            (lv, NONE) =>
                             if variable_debug then
                              (* include typing and identifier information for debugger *)
                              (case valid of
                                 Ident.VAR symbol =>
                                   let
(*
				     val _ =
				       output(std_out, "Doing do_leaf for (lv, NONE) case, valid = " ^ IdentPrint.printValId print_options valid ^ "\n")
*)
                                     val dummylv = new_LVar()
                                     val debug_info =
				       RuntimeEnv.VARINFO
					 (Symbol.symbol_name symbol,
					  ty,
					  NONE)
                                   in
                                     (null_tyfun_spills (denv,debug_info);
                                      LambdaTypes.LET
                                      ((dummylv,SOME (ref debug_info),
                                        LambdaTypes.VAR lv),
                                       do_leaf(tl,
                                               Environ.add_valid_env(env,
                                                                     (valid,
                                                                      EnvironTypes.LAMB(lv,EnvironTypes.NOSPEC))),
                                               add_valid_denv(denv, (valid,EnvironTypes.NULLEXP)))))
                                   end
                               | _ =>
                                   do_leaf(tl, Environ.add_valid_env(env, (valid,
                                                                           EnvironTypes.LAMB(lv,EnvironTypes.NOSPEC))),
                                           add_valid_denv(denv, (valid,EnvironTypes.NULLEXP))))
                             else (* no variable debug *)
                               do_leaf(tl, Environ.add_valid_env(env, (valid,
                                                                       EnvironTypes.LAMB(lv,EnvironTypes.NOSPEC))),
                                       add_valid_denv(denv, (valid,EnvironTypes.NULLEXP)))
                          | (lv, SOME varinforef) =>
                              (* include typing and identifier information for debugger *)
			      (* This case should no longer happen *)
			      Crash.impossible("debug info already set for " ^
					       IdentPrint.printValId print_options valid)
                  in
                    do_leaf(rev mv_valid_ty_list, val_env, denv)
                  end

              | Match.SCON(mv, scon_tree_list, default, binding, opt_size) =>
	         let
                   fun lambda_exp() =
                     let
                       val old_null_tyfun_spills = store_null_tyfun_spills()
                     in
                        LambdaTypes.SWITCH(
	                 LambdaTypes.VAR(#1(lookup_match(mv, match_env))),
	                 NONE,
                         map (fn (scon,tree) =>
                              (LambdaTypes.SCON_TAG (scon, opt_size),
                               (init_null_tyfun_spills();
                                make_null_tyfun_spills(tr_match(tree, match_env, val_env)))))
                         scon_tree_list,
                       let
                         val default =
			   case default of
			     SOME default =>
			       Tr_Default (Match.INL(SOME default))
			   | _ => NONE
                         val _ = restore_null_tyfun_spills old_null_tyfun_spills
                       in
                         default
                       end)
                     end
	         in
		   lvar_let_lambdas_in_exp (lambda_exp,
					    case binding of
					      NONE => []
					    | SOME bd =>[Match.INL bd],
						NONE)
                 end
              | Match.CONSTRUCTOR(ty, mv, longvalid_mv_tree_list, default, binding, exception_tree) =>
                  let
                    val ORIG_LV = lookup_match(mv, match_env)
                    val orig_lv = #1 ORIG_LV
                    val lv_e = LambdaTypes.VAR orig_lv

                    val (_,type_val_env) =
                      TypeUtils.get_valenv(TypeUtils.get_cons_type ty)

                    val is_exn =
                      case longvalid_mv_tree_list of
                        {1=Ident.LONGVALID(_, Ident.EXCON _), ...} :: _ => true
                      | {1=Ident.LONGVALID(_, Ident.CON _), ...} :: _ => false
                      | _ => Crash.impossible "Match.CONS bad arg"

                    fun has_value(Ident.LONGVALID(_, valid as Ident.CON _)) =
                      (case TypeUtils.type_from_scheme(
                                                        NewMap.apply'(type_val_env, valid)) of
                         Datatypes.FUNTYPE _ => true
                       | _ => false
                           )
                      |   has_value(Ident.LONGVALID(_, Ident.VAR _)) =
                          Crash.impossible"VAR in match CONS"
                      |   has_value(Ident.LONGVALID(_, Ident.TYCON' _)) =
                          Crash.impossible"TYCON' in match CONS"
                      |   has_value(Ident.LONGVALID(_, Ident.EXCON excon)) = true
                    (* Pretend all exceptions carry values, even if only unit *)

                    val new_lv = new_LVar()
                    val new_le = GetConVal lv_e
                    val con_field = GetConTag lv_e
                    val vcc_lv_list =
                      Lists.filterp (has_value o #1) longvalid_mv_tree_list
                    (* Note we're using the same lambda variable for all the
                     vcc matchvars, since they're all going to be the same
                     expression, viz SELECT(1, original matchvar) (aka new_le) *)

                    fun tr_match'(Match.INL tree,match_env, val_env) =
                      tr_match(tree, match_env, val_env)
                      | tr_match'(Match.INR(ref(Match.INR lvar)),_, _) =
			let
			  val opt_e = find_binding lvar
			  val _ = report_binding(lvar, opt_e)
			in
			  case opt_e of
			    SOME x => rename x
			  | _ =>
			      LambdaTypes.APP(LambdaTypes.VAR lvar,
					      ([unit_exp],[]),
					      NONE)
			end
                      | tr_match'(Match.INR _, _, _) =
                        Crash.impossible "tr_match':trans_match:lambda"

                    (* mk_branch produces a (tag, code) pair, for a branch of the SWITCH. *)

                    fun mk_branch (id as Ident.LONGVALID(_, valid), mv, tree) =
                      if has_value id then
                        (LambdaTypes.VCC_TAG(valid_name valid,#2(constructor_tag(valid, ty))),
                        (* VCC_TAG isn't really accurate - will break when we
                         automatically dereference the constructor value.
                         But IMM_TAG isn't right either, as we have to know
                         where to branch from the test of the run-time tag. *)

                        if is_list_type ty then
	                  (* Now we do some bizarre stuff.  The match compiler
			     still produces a match variable for the argument
			     of cons, so we have to bind it to the expression
			     being matched.*)
	                   tr_match'(tree,
                                     add_match_env((mv, ORIG_LV), match_env),
                                     val_env)
                        else
                          LambdaTypes.do_binding
                          (* Assign lambda variable to value carried by constructor *)
                          let
                            val info = NONE
                          in
                            (LambdaTypes.LETB(new_lv, info, new_le),
                             tr_match'(tree,
                                       add_match_env((mv, (new_lv,info)), match_env),
                                       val_env))
                          end)
                      else
                        (LambdaTypes.IMM_TAG(valid_name valid,#2(constructor_tag(valid, ty))),
                         tr_match'(tree, match_env, val_env))
                    fun lambda_exp1() =
                      if TypeUtils.get_no_cons ty = 1 then
                        (* Use this instead of TypeUtils.has_value_cons ty, because
                         we want to know about explicitly mentioned constructors
		         and we want to treat all EXCONS as VCCs. *)
                        (* And at this point I give up formatting *)
                  if length vcc_lv_list <> 0 then
	            (* Handle case of only one constructor, carrying a value *)
	            (* This relies on constructor nodes only arising when *)
	            (* some constructor is actually quoted, not bad I suppose *)
	            let val (name, mv, tree) =
		          case vcc_lv_list of
	                    [x] => x
	                  | _ => Crash.impossible "list size"
	            in
		      (* Check to see if its ref (handled specially) *)
		      case Environ.FindBuiltin(name, val_env)  of
			SOME Pervasives.REF =>
			  let
			    val new_lv = new_LVar ()
			    val info = NONE
			  in
			    LambdaTypes.do_binding
			    (LambdaTypes.LETB
			     (new_lv,info,
			      LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
					      ([LambdaTypes.VAR orig_lv],[]),
					      NONE)),
			     tr_match'(tree,
				       add_match_env((mv, (new_lv,info)),
						     match_env),
				       val_env)
			     )
			  end
		      | _ =>
	                (* Ensure we pass through the value by assigning the
	                   same lambda variable to the new matchvar as we had
                           passed through in the first place. This works since
		           the constructor has no effect on the representation
		           of the value (only one constructor case) *)
			  tr_match'(tree,
				    add_match_env((mv, ORIG_LV),match_env),
				    val_env)
	            end
	          else
	            (* Only one constructor, with no value *)
	            let val tree = case longvalid_mv_tree_list of
		                     [(_, _, tree)] => tree
	                           | _ => Crash.impossible "list size"
	            in
		      (* No value to be passed through here *)
		      tr_match'(tree, match_env, val_env)
	            end
	        else
	          (* More than one constructor in this type. Must switch *)
                  let
                    val old_null_tyfun_spills = store_null_tyfun_spills()
                  in
	          LambdaTypes.SWITCH(
	            lv_e,
		    SOME{
	              num_vccs = TypeUtils.get_no_vcc_cons ty,
		      num_imms = TypeUtils.get_no_null_cons ty
		    },
                    map (fn tree=>
                             let
                               val (tag,tree) =
                                 (init_null_tyfun_spills();
                                  mk_branch tree)
                             in
                               (tag,make_null_tyfun_spills tree)
                             end) longvalid_mv_tree_list,
                  let
                    val default =
                      if length longvalid_mv_tree_list =
                        TypeUtils.get_no_cons ty then
                        NONE (* No default here if all cases ok *)
                      else Tr_Default default
                    val _ = restore_null_tyfun_spills old_null_tyfun_spills
                  in
                    default
                  end) (* end of LambdaTypes.SWITCH *)
                  end
          fun lambda_exp2() =
            let
              val info = NONE
            in
	      let_lambdas_in_exp
              ([LambdaTypes.LETB(new_lv,info,new_le)],
               let
                 val old_null_tyfun_spills = store_null_tyfun_spills()
               in
                 LambdaTypes.SWITCH
                 (select_exn_unique con_field,
		  SOME{num_vccs = 0,num_imms = 0},
                  map (fn (longvalid, mv, tree) =>
                       (LambdaTypes.EXP_TAG
                        (select_exn_unique(#1(cg_longexid(longvalid, val_env)))),
                        (init_null_tyfun_spills();
                         make_null_tyfun_spills
                         (tr_match'(tree,
                                    add_match_env((mv, (new_lv,info)),match_env),
                                    val_env)))))
                  vcc_lv_list,
                  let
                    val default = Tr_Default default
                    val _ = restore_null_tyfun_spills old_null_tyfun_spills
                  in
                    default
                  end)
               end)
            end
          fun lambda_exp3() =
            let
              val old_null_tyfun_spills = store_null_tyfun_spills()
            in
	      LambdaTypes.SWITCH(
		  select_exn_unique con_field,
                  SOME{num_vccs = 0,num_imms = 0},
                  map (fn (longvalid, _, tree) =>
                       (LambdaTypes.EXP_TAG(select_exn_unique(#1(cg_longexid(longvalid, val_env)))),
                        (init_null_tyfun_spills();
                             make_null_tyfun_spills(tr_match'(tree,match_env,val_env)))))
                  vcc_lv_list,
                  let
                    val default = Tr_Default default
                    val _ = restore_null_tyfun_spills old_null_tyfun_spills
                  in
                    default
                  end)
            end
	in
          if exception_tree then
            lvar_let_lambdas_in_exp (lambda_exp3, binding, NONE)
          else
            case is_exn of
              false => (* Not an exception constructor *)
                lvar_let_lambdas_in_exp (lambda_exp1, binding, NONE)
            | true =>
                (* Is an exception constructor *)
                lvar_let_lambdas_in_exp (lambda_exp2, binding, SOME(new_lv,new_le))
	end
      | Match.RECORD(ty, mv, lab_mv_list, tree) =>
	let
          val lab_mv_lv_list =
            if variable_debug then
              map (fn (x,y) => (x, y,
				(new_LVar(), NONE)))
              lab_mv_list
            else
              map
              (fn (x,y) => (x, y,(new_LVar(), NONE)))
              lab_mv_list
	  val le = LambdaTypes.VAR (#1(lookup_match(mv, match_env)))
	  val new_env = Lists.reducel
	    (fn (env, (_, x, y)) => add_match_env((x, y), env))
            (match_env, lab_mv_lv_list)
	  val lv_le_list =
	    map (fn (lab,_, (lv,info)) =>
		 LambdaTypes.LETB(lv,info,
                                  LambdaTypes.SELECT(record_label_offset(lab,ty,error_info,location),le)))
	    lab_mv_lv_list
	in
	  unordered_let_lambdas_in_exp
	  (lv_le_list, tr_match(tree, new_env, val_env))
	  (* Binding lambdas to selects off a record is side effect free *)
	end
      | Match.DEFAULT(default,binding) =>
          let
            fun lambda_exp() =
              case Tr_Default (Match.INL(SOME default)) of
                NONE => Crash.impossible "Match.DEFAULT:trans_match:lambda"
              | SOME lexp => lexp
          in
            lvar_let_lambdas_in_exp (lambda_exp,
                                     case binding of
                                       NONE => []
                                     | SOME bd => [Match.INL bd],
                                     NONE)
          end
     end

   (* Construct the debug_info for the function return value *)
   val debug_info = RuntimeEnv.NOVARINFO
  in
    (redundancy_code();
     LambdaTypes.FN(([root_lambda],[]),
                    let
                      val old_null_tyfun_spills = store_null_tyfun_spills()
                      val tr_match =
                        (init_null_tyfun_spills();
                         make_null_tyfun_spills
                         (null_tyfun_spills (denv,debug_info);
                          tr_match (tree, match_env,env)))
                      val _ = restore_null_tyfun_spills old_null_tyfun_spills
                    in
                      tr_match
                    end,
                    LambdaTypes.BODY,
                    name_string,ty,RuntimeEnv.INTERNAL_FUNCTION))
  end (* end of trans_match *)


  (* trans_dec should return the incremental environment from translating *)
  (* the declarations, not the overall environment from the original and the *)
  (* translation. Thus trans_dec should accumulate the increment until it *)
  (* runs out of things to do, and then return it. *)

  and trans_dec(some_dec, envir, is_toplevel, denvir, fnname) =
  let
    val excp = SOME
      (LambdaTypes.RAISE
       (LambdaTypes.STRUCT
        ([LambdaTypes.BUILTIN Pervasives.EXBIND, unit_exp],
         LambdaTypes.CONSTRUCTOR)))

    fun do_datatypeinfo_list datatypeinfo_list =
      let
        fun trans_single_datatype(_, _, _, _, v_tref_topt_list) =
          let
            (* Translate one constructor binding of a datatype into an ordinary
               VAL declaration *)
            fun munge((valid as Ident.CON sy, ref ty), _) =
              (Absyn.VALpat ((mklongvalid (Ident.VAR sy),(ref ty,ref null_runtimeinfo)),
                             Location.UNKNOWN),
               Absyn.VALexp (mklongvalid valid,ref ty,
                             Location.UNKNOWN, ref (Datatypes.ZERO, NONE)),
               Location.UNKNOWN)
              | munge _ = Crash.impossible"Absyn.DATATYPE"

                (* now translate all the bindings of a datatype into VAL decs*)
            val valdec_list = map munge v_tref_topt_list
          in
                (* translate list of VALdecs into lambda code *)
            trans_dec(Absyn.VALdec(valdec_list, [], Set.empty_set,[]),
                      Environ.empty_env, false, denvir, fnname)
          end

             (* lambda translate each datatype binding *)
        val e_l_list = map trans_single_datatype datatypeinfo_list
        val old_null_tyfun_spills = store_null_tyfun_spills()
        val _ = init_null_tyfun_spills()
        val (env, denv, spills) =
          DATATYPEdec_spills
          (denvir,datatypeinfo_list,
           (env_from_list e_l_list, denv_from_list e_l_list, nil))
        val _ = restore_null_tyfun_spills old_null_tyfun_spills
        val new_spills = Lists.reducel (fn (l1, (_, _, l2)) => l1 @ l2) ([], e_l_list)

            (*now extract the names of each datatype from datatypeinfo_list
              together with the corresponding environment from e_l_list
              and add it to env*)
      in
        (env,denv,spills @ new_spills)
      end

  in
    case some_dec of
      Absyn.VALdec (non_rec_list, rec_list, _,_) =>
      let
        fun trans_valdec(non_rec_list, rec_list) =
          let
            fun trans_individual_dec(pattern, lambda_var, location) =
            case pattern of
              Absyn.WILDpat _ => (true, true, Environ.empty_env, empty_denv, [],
                                RuntimeEnv.NOVARINFO,
                                NONE)
            | Absyn.SCONpat (scon, ref ty) =>
                let
                  val dummy_lv = new_LVar()
                in
                  (false, false, Environ.empty_env, empty_denv,
                   [LambdaTypes.LETB
		      (dummy_lv,NONE,
                       LambdaTypes.SWITCH
			 (LambdaTypes.VAR lambda_var,
                          NONE,
                          [(LambdaTypes.SCON_TAG (scon, Types.sizeof ty),
                            LambdaTypes.VAR lambda_var)],
                          excp))],
                   RuntimeEnv.NOVARINFO,NONE)
                end
            | Absyn.VALpat ((longvalid as Ident.LONGVALID(path, valid),
                             stuff as (ref ty,ref (RuntimeEnv.RUNTIMEINFO (instance,_)))),_) =>
                (case valid of
                   Ident.VAR symbol =>
                     (case path of
                        Ident.NOPATH =>
                          ((true, true, Environ.add_valid_env(Environ.empty_env, (valid,
                              EnvironTypes.LAMB(lambda_var, EnvironTypes.NOSPEC))),
                            add_valid_denv(empty_denv, (valid,
                              EnvironTypes.NULLEXP)), [],
                            RuntimeEnv.VARINFO(Symbol.symbol_name symbol,
                                               stuff,NONE),
                            instance))
                      | Ident.PATH _ => Crash.impossible
                          "Long valid with non-empty path to trans_dec")
                 | Ident.CON _ =>
                     let
                       val dummy_lv = new_LVar()
                       val tag = #2(constructor_tag(valid, ty))
                       val one_con = TypeUtils.get_no_cons ty = 1
                     in
                       (false, one_con, Environ.empty_env, empty_denv,
                        [LambdaTypes.LETB(
                            dummy_lv,NONE,
                             LambdaTypes.SWITCH(
                                  LambdaTypes.VAR lambda_var,
                                   SOME{
                                    num_imms = TypeUtils.get_no_null_cons ty,
                                    num_vccs = TypeUtils.get_no_vcc_cons ty},
                                    [(LambdaTypes.IMM_TAG (valid_name valid,tag),
                                      LambdaTypes.VAR lambda_var)],
                                    if one_con then NONE else excp
                                      ))
                        ], RuntimeEnv.NOVARINFO, NONE)
                     end
                 | Ident.EXCON excon =>
                     let
                       val lexp = LambdaTypes.VAR lambda_var
                       val dummy_lv = new_LVar()
                     in
                       (false, false, Environ.empty_env, empty_denv,
                        [LambdaTypes.LETB(dummy_lv,NONE,
                                          LambdaTypes.SWITCH(
                                                             GetConTag lexp,
                                                             SOME{num_imms = 0,
                                                                            num_vccs = 0
                                                                            },
                                           [(LambdaTypes.EXP_TAG(#1(cg_longexid (longvalid, envir))),
                                                               GetConVal lexp)],
                                                             excp
                                                             ))],
                        RuntimeEnv.NOVARINFO,
                        NONE)
                     end
                 | _ => Crash.impossible "TYCON':VALpat:trans_individual_dec:lambda"
                   )
            | Absyn.RECORDpat(lab_pat_list, flex, ref ty) =>
                let
                  val big_list =
                    map (fn (lab, pat) =>
                         (pat, new_LVar(),
                          LambdaTypes.SELECT(record_label_offset(lab,ty,error_info,location),
                                             LambdaTypes.VAR lambda_var)))
                    lab_pat_list
                  val env_list_lambda_list_list =
                    map
                    (fn (pat, lv, le) =>
                     let
                       val (has_vars, exhaustive, env, denv, lambda_list,debug_info,instance) =
                         trans_individual_dec(pat,lv, location)
                     in
                       (has_vars, exhaustive, env, denv,
                        make_binding (lv,debug_info,instance,le,"",location)
                        @ lambda_list)
                     end)
                    big_list
                in
                  (Lists.exists (fn (has_vars, _, _, _, _) => has_vars)
                   env_list_lambda_list_list,
                   Lists.forall (fn (_, exhaustive, _, _, _) => exhaustive)
                   env_list_lambda_list_list,
                   Lists.reducel (fn (env, (_, _, env', _, _)) =>
                                  Environ.augment_env(env, env'))
                   (Environ.empty_env, env_list_lambda_list_list),
                   Lists.reducel (fn (env, (_, _, _, env', _)) =>
                                  augment_denv(env, env'))
                   (empty_denv, env_list_lambda_list_list),
                   Lists.reducel
                   (fn (l1, (_, _, _, _, l2)) => l1 @ l2)
                   ([], env_list_lambda_list_list),RuntimeEnv.NOVARINFO,
                   NONE)
                end
            | Absyn.APPpat((longvalid, ref ty), pat,_,_) =>
                (case longvalid of
                   Ident.LONGVALID(_, Ident.VAR _) =>
                     Crash.impossible"APPpat of Ident.VAR"
                 | Ident.LONGVALID(_, valid as Ident.CON con) =>
                     (case Environ.FindBuiltin(longvalid, envir) of
			SOME Pervasives.REF =>
			  let
			    val new_lv = new_LVar()
			    val (has_vars, exhaustive, new_env, new_denv, new_lambda_exp,
				 debug_info,instance) =
			      trans_individual_dec(pat, new_lv, location)
			    val lexp = LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.DEREF,
						       ([LambdaTypes.VAR lambda_var],[]),
						       NONE)
			  in
			    (has_vars, exhaustive, new_env, new_denv,
			     make_binding(new_lv,debug_info,instance,lexp,
					  "Dereferencing a pattern",location)
			     @ new_lambda_exp,RuntimeEnv.NOVARINFO,
			     NONE)
			  end
		      | _ =>
			  if TypeUtils.get_no_cons ty = 1 then
			    trans_individual_dec(pat, lambda_var, location)
			  else
			    let
			      val new_lv = new_LVar()
			      val (has_vars, _, new_env, new_denv, new_lambda_exp,
				   debug_info,instance) =
				trans_individual_dec(pat, new_lv,location)
			      val lexp = LambdaTypes.VAR lambda_var
			      val tag = #2(constructor_tag(valid, ty))
			      val lexp =
				LambdaTypes.SWITCH
				(lexp,
				 SOME
				 {num_vccs = TypeUtils.get_no_vcc_cons ty,
				  num_imms = TypeUtils.get_no_null_cons ty
				  },
				 [(LambdaTypes.VCC_TAG (valid_name valid,tag),
				   if is_list_type (TypeUtils.get_cons_type ty) then
				     lexp
				   else
				     GetConVal lexp
				     )],
				 if TypeUtils.get_no_cons ty <> 1 then
				   excp (* is a tag, but not the right one *)
				 else
				   NONE)
			    in
			      (has_vars, false, new_env, new_denv,
			       make_binding(new_lv, debug_info,
					    instance,lexp,"", location)
			       @ new_lambda_exp,RuntimeEnv.NOVARINFO,
			       NONE)
			    end)

                 | Ident.LONGVALID(_, Ident.EXCON excon) =>
                     let
                       val new_lv = new_LVar()
                       val (has_vars, _, new_env, new_denv, new_lambda_exp,
                            debug_info,instance) =
                         trans_individual_dec(pat, new_lv,location)
                       val lexp = LambdaTypes.VAR lambda_var
                       val lexp = LambdaTypes.SWITCH(
                                                     GetConTag lexp,
                                                     SOME
						       {num_imms = 0,
                                                        num_vccs = 0},
                                           [(LambdaTypes.EXP_TAG(#1(cg_longexid(longvalid, envir))),
                                                              GetConVal lexp)],
                                                            excp
                                                            )
                     in
                       (has_vars, false, new_env, new_denv, (* Never exhaustive *)
                        make_binding(new_lv,debug_info,instance,lexp,"",
                                     location)
                           @ new_lambda_exp,
                        RuntimeEnv.NOVARINFO,
                        NONE)
                     end
                 | _ => Crash.impossible "TYCON':APPpat:trans_individual_dec:lambda"
                   ) (* end of case longvalid *)
            | Absyn.TYPEDpat(typed, _,_) =>
                    trans_individual_dec(typed, lambda_var, location)
            (* Just ignore the type here *)
            | Absyn.LAYEREDpat((valid, stuff as (ref ty,ref (RuntimeEnv.RUNTIMEINFO (instance,_)))), pat) =>
                (case valid of
                   Ident.VAR vid =>
                     let
                       val (_, exhaustive, env, denv, lambda,_,_) =
                         trans_individual_dec(pat, lambda_var, location)
                     in
                       (true, exhaustive, Environ.add_valid_env(env,
                                                   (valid, EnvironTypes.LAMB(lambda_var, EnvironTypes.NOSPEC))),
                        add_valid_denv(denv, (valid, EnvironTypes.NULLEXP)),
                        lambda,RuntimeEnv.VARINFO (Symbol.symbol_name vid,stuff,NONE),
                        instance)
                     end
                 | _ => Crash.impossible "LAYEREDpat with non-VAR valid")
          in
            (* This stuff needs redoing to be tail recursive over the first list *)
            case (non_rec_list, rec_list) of
              ((pat, exp, location) :: tl, _) =>
                let
                  val lvar = new_LVar()
                  val (has_vars, exhaustive, more_env, more_denv, more_lambda,debug_info,instance) =
                    trans_individual_dec(pat,lvar, location)
                  val _ =
                    if exhaustive orelse is_toplevel then ()
                    else
                      Info.error error_info (Info.WARNING, location, "Binding not exhaustive")
                  val _ =
                    if has_vars orelse is_toplevel then ()
                    else
                      (Info.error error_info (Info.WARNING, location, "Binding has no variables");
		       (if exhaustive then ()
			else
			  Info.error error_info (Info.WARNING, location,
                                                 "Possible attempt to rebind constructor name")))

                  val _ = null_tyfun_spills (denvir,debug_info)
                  val lambda = trans_exp(" pattern", exp, envir, denvir, fnname)
                  val (more_env, more_denv, updated) =
                    case (pat, lambda) of
                      (* What is this clause about ? *)
                      (* Patthern is x = builtin *)
                      (Absyn.VALpat((Ident.LONGVALID(Ident.NOPATH,valid as Ident.VAR _), _),_),
                       LambdaTypes.BUILTIN prim) =>
                      (Environ.add_valid_env(more_env, (valid,EnvironTypes.PRIM prim)),
                       add_valid_denv(more_denv, (valid,EnvironTypes.NULLEXP)),
                       true)
                     | _ => (more_env, more_denv, false)

                  val _ = map
                    (fn LambdaTypes.LETB(_,SOME(ref debug_info),_) =>
                     null_tyfun_spills (denvir,debug_info)
                  | _ => ()) more_lambda

                  val (rest_env, rest_denv, rest_lambda) = trans_valdec(tl,rec_list)

                  val new_bindings = more_lambda @ rest_lambda
                in
                 (Environ.augment_env(more_env, rest_env),
                  augment_denv(more_denv, rest_denv),
                   (if updated then
                      new_bindings
                    else
                      make_binding(lvar,debug_info,instance,lambda,"",
                                   location)
                      @ new_bindings))
                end
            | ([], []) => (Environ.empty_env, empty_denv, [])
            | ([], rec_list) =>
                let
                  val lv_pat_exp_list =
                    if variable_debug
                      then
                        map
                        (fn (pat, exp, location) =>
                         let
                           val new_lv = new_LVar()
                         in
                           ((new_lv,SOME (ref RuntimeEnv.NOVARINFO)),pat, exp, location)
                         end)
                        rec_list
                    else
                      map
                      (fn (pat, exp, location) =>  ((new_LVar(),NONE), pat, exp, location))
                      rec_list
                  (* Assign lambda_var to each expression, pattern pair *)
                  val env_le_list = map
                    (fn ((lv,SOME varinfo_ref), pat, _, location) =>
                     let
                       val (has_vars, exhaustive, env, denv, le, debug_info,instance) =
                         trans_individual_dec(pat,lv,location)
                       val _ =
                         (* Update the varinfo for this variable *)
                         (varinfo_ref := debug_info;
                          if exhaustive then ()
                          else
                            Info.error error_info (Info.WARNING, location,
                                                   "Binding not exhaustive"))
                       val _ =
                         if has_vars then ()
                         else
                           Info.error error_info (Info.WARNING, location,
                                                  "Binding has no variables")
                     in
                       (env,denv,lv,debug_info,instance,location)
                     end
                  | ((lv,NONE), pat, _, location) =>
                     let
                       val (has_vars, exhaustive, env, denv, le, debug_info,instance) =
                         trans_individual_dec(pat,lv,location)
                       val _ =
                          if exhaustive then ()
                          else
                            Info.error error_info (Info.WARNING, location,
                                                   "Binding not exhaustive")
                       val _ =
                         if has_vars then ()
                         else
                           Info.error error_info (Info.WARNING, location,
                                                  "Binding has no variables")
                     in
                       (env,denv,lv,debug_info,instance,location)
                     end)
                    lv_pat_exp_list
                  (* The exp parts resulting from this should be null *)
                  val all_env =
                    Lists.reducel Environ.augment_env (Environ.empty_env, map #1 env_le_list)
                  val all_denv =
                    Lists.reducel augment_denv (empty_denv, map #2 env_le_list)
                  (* Produce the environment including the new functions *)
                  val trans_env = Environ.augment_env(envir, all_env)
                  val trans_denv = augment_denv(denvir, all_denv)
                  fun pat_name (Absyn.VALpat ((Ident.LONGVALID (_, valid), _),_)) = valid_name valid
                    | pat_name (Absyn.WILDpat _) = "<wild>"
                    | pat_name (Absyn.LAYEREDpat ((valid, _), pat)) =
                      (case pat_name pat of
                         "<wild>" => valid_name valid
                       | name => name)
                    | pat_name (Absyn.TYPEDpat (pat,_,_)) = pat_name pat
                    | pat_name _ = Crash.impossible"Bad pat name in val rec"
                  val recletb =
                    [LambdaTypes.RECLETB(map #1 lv_pat_exp_list,
                                         map
                                         (fn (pat,exp,_) =>
                                          trans_exp(pat_name pat, exp, trans_env,
                                                    trans_denv, fnname))
                                         rec_list)]
                in
                  (all_env, all_denv, recletb)
                end
          end
      in
        trans_valdec(non_rec_list, rec_list)
      end

    | Absyn.TYPEdec typeinfo_list =>
        let
          val old_null_tyfun_spills = store_null_tyfun_spills()
          val (env, denv, spills) =
            (init_null_tyfun_spills();
             TYPEdec_spills denvir typeinfo_list (Environ.empty_env, empty_denv, nil))
          val _ = restore_null_tyfun_spills old_null_tyfun_spills
        in
          (env, denv, spills)
        end

    | Absyn.DATATYPEdec (_,datatypeinfo_list) =>
        do_datatypeinfo_list datatypeinfo_list

        (* the typechecker should have set the "constructors" field of
           the DATATYPErepl abstract syntax to point to the type environment
           of the original datatype replication. The following code simply
           uses this information to reconstruct a list of constructor bindings
           which will then be passed directly to the datatype handling routine
           "do_datatypeinfo_list". *)

    | Absyn.DATATYPErepl (location,(tycon,longtycon),constructors) =>
        let val Datatypes.VE(intRef,nameToTypeMap) = valOf (!constructors)
              handle Option => Crash.impossible 
                                  "replicating datatype with no constructors"

            fun makeConbinds nameToTypeMap =
              (* map lists of (Ident.ValId * Datatypes.Typescheme)
                 to lists of ((Ident.ValId * Absyn.Type ref) * Absyn.Ty option)
                 (Absyn.Ty option never seems to be used here.) *)
              
              map (fn (valid,Datatypes.SCHEME(_,(ty,_))) => 
                                                        ((valid,ref ty),NONE)
                    | (valid,Datatypes.UNBOUND_SCHEME(ty,_)) =>
                                                        ((valid, ref ty),NONE)
                    | _ => Crash.impossible 
                                    "constructors with overloaded typescheme")
                  (NewMap.to_list_ordered nameToTypeMap)
              
         in
           (* give empty tyvar list: they're ignored by the function anyway.*)

           do_datatypeinfo_list [([],tycon,ref Absyn.nullType,NONE,
                                  makeConbinds nameToTypeMap)]
        end



    | Absyn.ABSTYPEdec (_,datatypeinfo_list, dec) =>
        let
          val (env,denv,spills) = do_datatypeinfo_list datatypeinfo_list
          val (env',denv',spills') = trans_dec(dec, envir, false, denvir, fnname)
        in
          (Environ.augment_env (env,env'),
           augment_denv (denv,denv'),
           spills @ spills')
        end

    | Absyn.EXCEPTIONdec except_list =>
      (* Generate a lambda lv bound to (APP(ref, unit), name), and put it in
	 the value environment.  Uses of ths identifier in expressions will
         be replaced by either FN(l', STRUCT(lv, VAR(l'))) or
	 STRUCT(lv, STRUCT()) according to whether or not the exception
	 carries a value. *)
      let
	fun make_exbind_info(loc, old_name, Ident.EXCON sym) =
	  let
	    val sym_string = Symbol.symbol_name sym
	  in
	    case loc of
	        Location.UNKNOWN => old_name
	    | _ =>
		let
		  val file_loc = OS.Path.file (Location.to_string loc)
		in
		  concat [sym_string, "[", file_loc, "]"]
		end
		
	  end
	  | make_exbind_info _ = Crash.impossible "Not an excon in an exbind"

	fun do_exns([], env, denv, lambdas) =
	  (env, denv, Lists.reducel (fn (x, y) => y @ x) ([], lambdas))
	  | do_exns(ex :: exns, env, denv, lambdas) =
	  let
	    val lv = new_LVar()

	    val (v, ty, loc, exception_name) = case ex of
	      Absyn.NEWexbind((v, ref ty), _,loc,n) => (v, ty, loc, n)
	    | Absyn.OLDexbind((v, ref ty), longv,loc,n) => (v, ty, loc, n)

	    val exn_string = make_exbind_info(loc, exception_name, v)

	    val (this_lambda,longstrid) =
	      let
		val _ =
                  (* Please,please, always generate debug info for exceptions *)
                  (* Add exception info to global debugger_env *)
                  debugger_env_ref :=
                    Debugger_Types.add_debug_info
                    (!debugger_env_ref,
                     exn_string,
                     Debugger_Types.FUNINFO {ty = ty,
                                             is_leaf = false,
					     has_saved_arg=false,
                                             annotations = [],
                                             runtime_env = Debugger_Types.empty_runtime_env,
                                             is_exn = true})

		val (lambda_exp,longstrid) =
		  let
		  in
		    case ex of
		      Absyn.NEWexbind _ =>
                      (* nosa 02/94
                         Bind new exception to strdec dec-exception locally bound to redundancy-checker;
                         Possibly redundant exception in LAMB for absolute exception constructor code
                         in dynamic redundancy checker
                       *)
                        let
                          val lvar = new_LVar()
                        in
                          (redundant_exceptions_ref := (lvar,exn_string)::(!redundant_exceptions_ref);
                           (LambdaTypes.STRUCT
                            ([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                              ([unit_exp],[]),
                                              NONE),
                            LambdaTypes.SCON(Ident.STRING exn_string, NONE)],
                            LambdaTypes.CONSTRUCTOR),
                            EnvironTypes.VARSPEC lvar))
                        end
		    | Absyn.OLDexbind(_, longv,_,_) =>
                        let
                          val (exp, longstrid) = cg_longexid(longv, envir)
                        in
                          (LambdaTypes.STRUCT
                           ([select_exn_unique exp,
                             LambdaTypes.SCON(Ident.STRING exn_string, NONE)],
                            LambdaTypes.CONSTRUCTOR),
                           longstrid)
                        end
		  end
	      in
		([LambdaTypes.LETB(lv, NONE,lambda_exp)],
                 longstrid)
	      end

	    val this_env =
	      Environ.add_valid_env (Environ.empty_env,
				     (v, EnvironTypes.LAMB(lv,longstrid)))
	    val this_denv =
	      add_valid_denv (empty_denv,(v, EnvironTypes.NULLEXP))

	  in
	    do_exns(exns, Environ.augment_env(env, this_env),
                    augment_denv(denv, this_denv),
	    	    this_lambda :: lambdas)
	  end
      in
	do_exns(except_list, Environ.empty_env, empty_denv, [])
      end

(** Find the translation for the first DEC in the environment passed,
    and then, the translation of the second in the environment after
    the first.  Since the trans_dec function takes an environment in
    which to perfom the translation, this is trivial.
    The preceding comment is crap unfortunately. We must translate dec2
    in the original environment augmented by the environment generated
    by translating dec1, but must return
    the environment produced only by the translation of dec2 (ie the
    environment from translating dec1 must not be visible externally.)
**)
    | Absyn.LOCALdec (dec1, dec2) =>
      let
	val (local_env, local_denv, local_lambda) = trans_dec(dec1, envir, false, denvir, fnname)
	val (main_env, main_denv, main_lambda) =
	  trans_dec(dec2, Environ.augment_env(envir, local_env), false,
                    augment_denv(denvir, local_denv), fnname)
      in
	(main_env, main_denv, local_lambda @ main_lambda)
      end
    | Absyn.OPENdec (longStrId_list,_) =>
      (* Lookup each LongStrId in the env, bind a set of new lambda variables,
         one per valid in the new env, to expressions SELECT(field, lexp),
	 where lexp is the lambda expression corresponding to the LongStrId,
	 (which may have some field selection if the LongStrId goes more
	 than one level down) and return an environment of the valids and
	 these lambda variables, and a lvar, lexp list of the lambda
	 variables and the field selections.
       *)
       let
	 fun trans_open([], new_env, new_denv, new_lambdas) = (new_env, new_denv, new_lambdas)
	 | trans_open(longstrid :: tl, new_env, new_denv, new_lambdas) =
	   let
	     val (env as EnvironTypes.ENV(valid_env, strid_env),
		  lambda_exp, longstrid', _) =
	       cg_longstrid(longstrid, envir)
             val new_denv =
               if generate_moduler then
                 open_debugger_env (cg_longstrid'(longstrid, denvir), new_denv)
               else new_denv
	     val valid_map' = NewMap.to_list valid_env
	     val valid_map = map (fn (v, c) => (v, c, new_LVar())) valid_map'
             val strid_map' = NewMap.to_list strid_env
	     val strid_map = map
	       (fn (s, ec) => (s, ec, new_LVar())) strid_map'
             (* Full paths in LAMBs for absolute exception constructor code *)
             (* in dynamic redundancy checker *)

             val longstrid' =
               case (longstrid',longstrid) of
                 (EnvironTypes.STRIDSPEC (Ident.LONGSTRID(p,Ident.STRID s)), Ident.LONGSTRID(p',s')) =>
                   EnvironTypes.STRIDSPEC (Ident.LONGSTRID(combine_paths (p,combine_paths (Ident.PATH(s,Ident.NOPATH),p')),s'))
                | (EnvironTypes.NOSPEC,longstrid) => EnvironTypes.STRIDSPEC  longstrid
                | _ => Crash.impossible "longstrid':trans_open:lambda"

             fun identity_if_builtin (x as EnvironTypes.PRIM _,_) = x
               | identity_if_builtin (_,y) = EnvironTypes.LAMB(y,longstrid')
	     val new_v_env = Lists.reducel
	       (fn (env, (v, x, l)) =>
		Environ.add_valid_env(env, (v, identity_if_builtin(x,l))))
	       (new_env, valid_map)
	     val new_s_env = Lists.reducel
	       (fn (env, (s, (e, c, generate_moduler), l)) =>
		Environ.add_strid_env(env, (s, (e, EnvironTypes.LAMB(l,longstrid'), generate_moduler))))
	       (new_v_env, strid_map)

	     val new_v_lambdas =
               map
	       (fn (_, EnvironTypes.FIELD field, l) =>
		LambdaTypes.LETB (l, NONE,LambdaTypes.SELECT(make_struct_select field, lambda_exp))
                 | (_, EnvironTypes.PRIM prim, l) =>
                     LambdaTypes.LETB (l,NONE,LambdaTypes.BUILTIN prim)
                 | _ => Crash.impossible "Absyn.OPENdec(1)")
               valid_map
	     val new_s_lambdas = map
	       (fn (_, (_, EnvironTypes.FIELD field, _), l) =>
		LambdaTypes.LETB(l,NONE, LambdaTypes.SELECT(make_struct_select field, lambda_exp))
             | (_, (_, EnvironTypes.PRIM prim, _), l) =>
                 LambdaTypes.LETB(l, NONE,LambdaTypes.BUILTIN prim)
	       | _ => Crash.impossible "Absyn.OPENdec(2)"
		   ) strid_map
	   in
	     trans_open(tl, new_s_env, new_denv,
			new_v_lambdas @ new_s_lambdas @ new_lambdas)
	   end
       in
	 trans_open(longStrId_list, Environ.empty_env, empty_denv, [])
       end

(** Using trans_dec translate each declaration given into the proper
    form, in the environment of all the names being passed to it.
    Each declaration is translated with the environment of all
    previous declarations done to date.  At the end we return this
    full environment.  **)
    | Absyn.SEQUENCEdec dec_list =>
	trans_sequence_dec(envir, Environ.empty_env, denvir, empty_denv,
                           [], dec_list, is_toplevel, fnname)
  end

  and trans_sequence_dec(_, new_env, _, new_denv, bindings, [], _, _) =
      (new_env, new_denv, Lists.reducel (fn (x, y) => y @ x) ([], bindings))
    | trans_sequence_dec(old_env, new_env, old_denv, new_denv,
                         bindings, dec :: dec_list, is_toplevel, fnname) =
      let
	val (env, denv, lambda) = trans_dec (dec, old_env, is_toplevel, old_denv, fnname)
      in
	trans_sequence_dec(Environ.augment_env(old_env, env),
			   Environ.augment_env(new_env, env),
                           augment_denv(old_denv, denv),
			   augment_denv(new_denv, denv),
			   lambda :: bindings, dec_list, is_toplevel, fnname)
      end

  fun wrapped_trans_dec (dec, env, is_toplevel, denv, fnname) =
      (* Bind new exception locally to Dynamic redundancy checker for toplevel struct;
         Generate Dynamic redundancy checker.
         Also for the Modules Debugger bind any global lambda variables formed from
         functor parameters
       *)
    (tyfun_lvars_ref := []; (* Reset global ref *)
     dexps_ref := []; (* Reset global ref *)
     redundant_exceptions_ref := []; (* Reset global ref *)
     let
       val (env, denv, dec_bindings) = trans_dec(dec, env, is_toplevel, denv, fnname)
       val tfs_bindings =
         map (fn (_,(lvar,lexp)) =>
              LambdaTypes.LETB(lvar,NONE, lexp))
         (!tyfun_lvars_ref)
       val dexp_bindings =
         map (fn (_,(lvar,lexp)) =>
              LambdaTypes.LETB(lvar,NONE, lexp))
         (!dexps_ref)
       val redundant_exn_bindings =
         map (fn (lvar,exn_string) =>
              LambdaTypes.LETB(lvar,NONE,
                               LambdaTypes.STRUCT
                               ([LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                                 ([unit_exp],[]),
                                                 NONE),
                               LambdaTypes.SCON(Ident.STRING exn_string, NONE)],
                               LambdaTypes.CONSTRUCTOR)))
         (!redundant_exceptions_ref)
       val bindings =
         let
           val exp = (!dynamic_redundancy_report_ref) unit_exp
           val _ = dynamic_redundancy_report_ref := (fn exp => exp)
         in
           case exp of
             LambdaTypes.STRUCT([],_) => dec_bindings
           | dynamic_report =>
               LambdaTypes.LETB(new_LVar(),NONE,
                                dynamic_report) :: dec_bindings
         end
     in
       (env, denv,
        tfs_bindings @
        dexp_bindings @
        redundant_exn_bindings @
        bindings)
     end)

  fun trans_str_exp (strexp, top_env as EnvironTypes.TOP_ENV(env, fun_env),denv, fnname) =
    case strexp of
      Absyn.NEWstrexp strdec =>
        let
          val (env, denv, lv_le_list) = trans_str_dec(strdec, top_env, denv, false, fnname)
          val (EnvironTypes.TOP_ENV(env, _), lambda_exp) =
            complete_struct_from_topenv(make_top_env env, lv_le_list)
        in
          (env, lambda_exp, EnvironTypes.DENVEXP denv)
        end
    | Absyn.OLDstrexp (longstrid,_,interface) =>
        let
          val (env, lexp, _, moduler_generated) = cg_longstrid(longstrid, env)
          val ((strexp, env), dstrexp) =
            case (moduler_generated,generate_moduler) of
              (true,false) =>
                (strip_tyfuns (lexp,env),
                 empty_dstrexp)
            | (false,true) =>
                let
                  val interface = fetch_interface interface
                in
                  (include_tyfuns (lexp,interface,env),
                   make_dstrexp interface)
                end
            | (true,true) =>
                ((lexp, env),
                 cg_longstrid'(longstrid, denv))
            | (false,false) => ((lexp, env), empty_dstrexp)
        in
          (env, strexp, dstrexp)
        end

    | Absyn.APPstrexp(funid as Ident.FUNID sy, strexp, coerce, location, debugger_str) =>
        let
          val (lv, result_env as EnvironTypes.ENV(valid_env, strid_env), moduler_generated) =
            Environ.lookup_funid(funid, fun_env)
          val old_functor_refs = !functor_refs
          val _ = functor_refs := []
          val (env, arg, dstrexp) = trans_str_exp(strexp, top_env, denv, fnname)
          val Basis.BasisTypes.PHI (_, (interface, Basis.BasisTypes.SIGMA(_,interface'))) =
            Basis.lookup_funid (funid, basis)
            handle NewMap.Undefined =>
              Crash.impossible "Undefined functor id in trans_str_exp"

          val (new_env, new_arg) =
            complete_struct((env, arg), SOME interface, !coerce, generate_moduler)

          val dlvar = new_LVar()
          val new_arg =
            if generate_moduler then
              (** create unique functor application refs for debugger structure returns
               for modules debugger **)
              let_lambdas_in_exp
              (map (fn (ref (EnvironTypes.LVARFOO lv),interface) =>
                    LambdaTypes.LETB(lv,NONE,
                                     LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                                     ([str_to_lambda interface],[]),
                                                     NONE))
            | _ => Crash.impossible "1:INTFOO:functor_refs:lambda")
              (!functor_refs),
              (functor_refs := old_functor_refs;
               LambdaTypes.STRUCT([new_arg,
                                   dstrexp_to_lambda(merge_dstrexps (fetch_debugger_str debugger_str,
                                                                     SOME interface,dstrexp,
                                                                     location)),
                                   LambdaTypes.VAR dlvar],
               LambdaTypes.TUPLE)))
            else
              new_arg
          val functorexp =
            LambdaTypes.APP(
                            case lv of
                              EnvironTypes.LAMB (lv,_) => LambdaTypes.VAR lv
                            | EnvironTypes.EXTERNAL =>
                                LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.LOAD_FUNCT,
                                                ([LambdaTypes.SCON(Ident.STRING(Symbol.symbol_name sy), NONE)],[]),
                                                NONE)
                            | EnvironTypes.PRIM _ => Crash.impossible "APPstrexp(1)"
                            | EnvironTypes.FIELD _ => Crash.impossible "APPstrexp(2)",
                           ([new_arg],[]),
                            NONE)
          (* Should this be binding result_env? *)
          val ((functorexp, env), dfunctorexp) =
            case (moduler_generated,generate_moduler) of
              (** compatibility considerations for modules debugger **)
              (true,false) =>
                (strip_tyfuns (functorexp,result_env),
                 empty_dstrexp)
            | (false,true) =>
                (functor_refs := (ref (EnvironTypes.LVARFOO dlvar),interface')::(!functor_refs);
                 (include_tyfuns (functorexp,interface',result_env),
                  make_dstrexp interface'))
            | (true,true) =>
                let
                  val dlvar = ref (EnvironTypes.LVARFOO dlvar)
                in
                  (functor_refs := (dlvar,interface')::(!functor_refs);
                   (* Making a LAMBDASTREXP' *)
                   ((functorexp, env),
                    EnvironTypes.LAMBDASTREXP' ([],dlvar,interface')))
                end
            | (false,false) => ((functorexp, env), empty_dstrexp)
        in
          (result_env, functorexp, dfunctorexp)
        end
    | Absyn.LOCALstrexp(strdec, strexp) =>
        let
          val (local_env, local_denv, local_lambdas) =
            trans_str_dec(strdec, top_env, denv, false, fnname)
          val (new_env, new_lambda, new_dexp) =
            trans_str_exp(strexp,
                          Environ.augment_top_env(top_env, make_top_env local_env),
                          augment_denv (denv, local_denv),
                          fnname)
        in
          (new_env,
           let_lambdas_in_exp(local_lambdas, new_lambda),
           new_dexp)
        end
    | Absyn.CONSTRAINTstrexp (strexp,sigexp,abs,coerce,location) =>
        let
          val inte_opt = SOME (interface_from_sigexp sigexp)
          val (str_env, lambda_exp, dstrexp) =
            trans_str_exp(strexp, top_env, denv, fnname)
          val (str_env, lambda_exp) =
            complete_struct((str_env, lambda_exp),
			    inte_opt,
			    !coerce, generate_moduler)
        in
          (str_env,lambda_exp,dstrexp)
        end

  and trans_str_dec(strdec, top_env as EnvironTypes.TOP_ENV(env, _),
                    denv, is_toplevel, fnname) =
  case strdec of
    Absyn.DECstrdec dec => wrapped_trans_dec (dec, env, is_toplevel, denv, fnname)
  | Absyn.STRUCTUREstrdec struct_dec_list =>
    (case struct_dec_list of
      [] => (Environ.empty_env, empty_denv, [])
    | _ =>
    let
      fun trans_structs(aug_env, aug_denv, bindings, []) = (aug_env, aug_denv, rev bindings)
      | trans_structs(aug_env, aug_denv, bindings,
		      (strid, sigexp_opt, strexp, coerce, location, debugger_str, interface') :: rest) =
        let
          val inte_opt = case sigexp_opt of
	    NONE => NONE
          | SOME (sigexp,_) =>
	      SOME (interface_from_sigexp sigexp)
          val (str_env, lambda_exp, dstrexp) =
            trans_str_exp(strexp, top_env, denv, fnname)
          val (str_env, lambda_exp) =
            complete_struct((str_env, lambda_exp),
			    inte_opt,
			    !coerce, generate_moduler)
          val lambda_var = new_LVar()
        in
	  trans_structs
          (Environ.add_strid_env(aug_env,
				 (strid, (str_env,
					  EnvironTypes.LAMB (lambda_var,EnvironTypes.NOSPEC),generate_moduler))),
           if generate_moduler then
             add_strid_denv(aug_denv,
              (strid, merge_dstrexps (fetch_debugger_str debugger_str,
                                      SOME(fetch_interface interface'),dstrexp, location)))
           else aug_denv,
            LambdaTypes.LETB(lambda_var,NONE,lambda_exp)
            :: bindings, rest)
        end
    in
      trans_structs(Environ.empty_env, empty_denv, [], struct_dec_list)
    end)
  | Absyn.ABSTRACTIONstrdec struct_dec_list =>
    (* cut and paste from above *)
    (* so that's what they mean by "reusability" *)
    (case struct_dec_list of
      [] => (Environ.empty_env, empty_denv, [])
    | _ =>
    let
      fun trans_structs(aug_env, aug_denv, bindings, []) = (aug_env, aug_denv, rev bindings)
      | trans_structs(aug_env, aug_denv, bindings,
		      (strid, sigexp_opt, strexp, coerce, location, debugger_str, interface') :: rest) =
        let
          val inte_opt = case sigexp_opt of
	    NONE => NONE
          | SOME (sigexp,_) =>
	      SOME (interface_from_sigexp sigexp)
          val (str_env, lambda_exp, dstrexp) =
            trans_str_exp(strexp, top_env, denv, fnname)
          val (str_env, lambda_exp) =
            complete_struct((str_env, lambda_exp),
			    inte_opt,
			    !coerce, generate_moduler)
          val lambda_var = new_LVar()
        in
	  trans_structs
          (Environ.add_strid_env(aug_env,
				 (strid, (str_env,
					  EnvironTypes.LAMB(lambda_var,EnvironTypes.NOSPEC),generate_moduler))),
           if generate_moduler then
             add_strid_denv(aug_denv,
              (strid, merge_dstrexps (fetch_debugger_str debugger_str,
                                      SOME(fetch_interface interface'),dstrexp, location)))
           else aug_denv,
            LambdaTypes.LETB(lambda_var, NONE,lambda_exp)
            :: bindings, rest)
        end
    in
      trans_structs(Environ.empty_env, empty_denv, [], struct_dec_list)
    end)
  | Absyn.LOCALstrdec(strdec1, strdec2) =>
    let
      val (local_env, local_denv, local_lambda) =
        trans_str_dec(strdec1, top_env, denv, false, fnname)
      val (main_env, main_denv, main_lambda) =
	trans_str_dec
	  (strdec2,
	   Environ.augment_top_env(top_env, make_top_env local_env),
	   augment_denv(denv, local_denv), false,
	   fnname)
    in
      (main_env, main_denv, local_lambda @ main_lambda)
    end

  | Absyn.SEQUENCEstrdec strdec_list =>
      trans_sequence_strdec(top_env, Environ.empty_env,
                            denv, empty_denv, [], strdec_list, is_toplevel, fnname)

  and trans_sequence_strdec(_, new_env, _, new_denv, bindings, [], _, _) =
      (new_env, new_denv, Lists.reducel (fn (x, y) => y @ x) ([], bindings))
    | trans_sequence_strdec
	(old_env, new_env, old_denv, new_denv, bindings, decs :: dec_list, is_toplevel, fnname) =
      let
	val (env, denv, new_bindings) = trans_str_dec(decs, old_env, old_denv, is_toplevel, fnname)
      in
	trans_sequence_strdec(Environ.augment_top_env
			        (old_env, make_top_env env),
			      Environ.augment_env(new_env, env),
                              augment_denv(old_denv, denv),
                              augment_denv(new_denv, denv),
			      new_bindings :: bindings, dec_list,
			      is_toplevel, fnname)
      end

  fun trans_individual_funbind
        (funbind as
	   (funid, strid, sigexp, strexp, sigexp_opt,
            annotation_string, coerce, location, debugger_str, str),
         top_env as EnvironTypes.TOP_ENV(env, fun_env),
         top_denv) =
    let
      val interface = interface_from_sigexp sigexp
      val env = Environ.make_str_env (interface,generate_moduler)
      val lvar' = new_LVar()
      val lvar = new_dLVar lvar'
      val lvar'' = new_dLVar lvar'
      val lvar''' = new_dLVar lvar'
      val inte_opt = case sigexp_opt of
	NONE => NONE
      | SOME (sigexp,_) =>
	  SOME (interface_from_sigexp sigexp)

      val old_functor_refs = !functor_refs
      val _ = functor_refs := []
      val (str_env, lambda_exp, dstrexp) =
        trans_str_exp
	 (strexp,
	  Environ.augment_top_env
	  (top_env,
	   make_top_env(Environ.add_strid_env(Environ.empty_env,
					      (strid,
					       (env,
						EnvironTypes.LAMB(lvar',EnvironTypes.NOSPEC),
                                                generate_moduler))))),
          augment_denv
          (top_denv,
           if generate_moduler then
             let
               val str = fetch_interface str
             in
             add_strid_denv(empty_denv,
                            (strid,
                             EnvironTypes.LAMBDASTREXP([],(lvar'',lvar'),str)))
             end
           else empty_denv),
          NONE)

      val (str_env, lambda_exp) =
	complete_struct	((str_env, lambda_exp),
                         inte_opt,
                         !coerce, generate_moduler)
      val lambda_var = new_LVar()
      val lambda_var' = new_dLVar lambda_var
      val dstrexp =
        if generate_moduler then
          merge_dstrexps (fetch_debugger_str debugger_str,inte_opt,dstrexp, location)
        else empty_dstrexp

      val lambda_exp =
        if generate_moduler then
         LambdaTypes.LET((lvar',NONE,
          LambdaTypes.SELECT({index=0,size=3,selecttype=LambdaTypes.TUPLE},LambdaTypes.VAR lvar)),
            LambdaTypes.LET((lvar'',NONE,
               LambdaTypes.SELECT({index=1,size=3,selecttype=LambdaTypes.TUPLE},LambdaTypes.VAR lvar)),
            LambdaTypes.LET((lvar''',NONE,
               LambdaTypes.SELECT({index=2,size=3,selecttype=LambdaTypes.TUPLE},LambdaTypes.VAR lvar)),
            (** create unique functor application refs for debugger structure returns **)
            let_lambdas_in_exp(map (fn (ref (EnvironTypes.LVARFOO lv),interface) =>
                                    LambdaTypes.LETB(lv,NONE,
                                                     LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                                                     ([str_to_lambda interface],[]),
                                                                     NONE))
                                     | _ => Crash.impossible "2:INTFOO:functor_refs:lambda")
            (!functor_refs),
                             (functor_refs := old_functor_refs;
                              LambdaTypes.LET((lambda_var',NONE,lambda_exp),
                               LambdaTypes.LET((new_LVar(),NONE,
                                                LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.BECOMES,
                                                                ([LambdaTypes.STRUCT([LambdaTypes.VAR lvar''',
                                                                                     dstrexp_to_lambda dstrexp],
                                                                LambdaTypes.TUPLE)],
                                                                 []),
                                                                NONE)),
                                              LambdaTypes.VAR lambda_var')))))))
        else
          lambda_exp
    in
     (EnvironTypes.TOP_ENV
       (Environ.empty_env,
	Environ.add_funid_env
	(Environ.empty_fun_env,
	 (funid,
	  (EnvironTypes.LAMB(lambda_var,EnvironTypes.NOSPEC),  str_env, generate_moduler)))),
       empty_denv,
       [LambdaTypes.LETB(lambda_var,NONE,
                         LambdaTypes.FN(([lvar],[]), lambda_exp, LambdaTypes.FUNC,annotation_string,
                                        LambdaTypes.null_type_annotation,RuntimeEnv.USER_FUNCTION))])
    end

  fun trans_fun_dec([], _, _) = (make_top_env Environ.empty_env,
                                 empty_denv, [])
    | trans_fun_dec(funbind :: rest, top_env, top_denv) =
      let
        val (new_env, new_denv, new_lambda) =
	  trans_individual_funbind(funbind, top_env, top_denv)
        val (rest_env, rest_denv, rest_lambda) = trans_fun_dec(rest, top_env, top_denv)
      in
        (Environ.augment_top_env(new_env, rest_env),
         augment_denv(new_denv, rest_denv), new_lambda @ rest_lambda)
      end

  fun trans_fun_dec_list([], _, _) = (make_top_env Environ.empty_env,
                                      empty_denv, [])
    | trans_fun_dec_list((Absyn.FUNBIND funbind):: rest, top_env, top_denv) =
      let
        val (new_env, new_denv, new_lambda) = trans_fun_dec(funbind, top_env, top_denv)
        val (rest_env, rest_denv, rest_lambda) =
          trans_fun_dec_list(rest, Environ.augment_top_env(top_env, new_env),
                             augment_denv(top_denv, new_denv))
      (* The rest of the functors in the following topdecs
       can reference those defined earlier *)
      in
        (Environ.augment_top_env(new_env, rest_env),
         augment_denv(new_denv, rest_denv), new_lambda @ rest_lambda)
      end

  val old_functor_refs = !functor_refs
  val _ = functor_refs := []

  val (a,b,c) =
    case topdec of
      Absyn.STRDECtopdec (strdec,_) =>
        let
          val (new_env, new_denv, lambdas) =
            trans_str_dec(strdec, top_env, top_denv, true, NONE)
        in
          (make_top_env new_env, new_denv, lambdas)
        end
    | Absyn.SIGNATUREtopdec _ =>
        (make_top_env Environ.empty_env, empty_denv, [])
    | Absyn.FUNCTORtopdec (funbind_list,_) =>
        trans_fun_dec_list(funbind_list, top_env, top_denv)
    | Absyn.REQUIREtopdec _ =>
        Crash.impossible"trans_topdec REQUIREtopdec"

  val a = if generate_moduler then sub_functor_refs a else a

  (** create unique functor application refs for debugger structure returns for modules debugger **)
  val c = overload_binding @
    map
    (fn (ref(EnvironTypes.LVARFOO lv),interface) =>
     LambdaTypes.LETB(lv,NONE,
                      LambdaTypes.APP(LambdaTypes.BUILTIN Pervasives.REF,
                                      ([str_to_lambda interface],[]),
                                      NONE))
  | _ => Crash.impossible "3:INTFOO:functor_refs:lambda") (!functor_refs) @ c

  (** add unique functor application refs to lambda environment for modules debugger **)
  val a =
    let
      val (env,ct) =
        Lists.reducel
        (fn ((env,ct),(lv' as ref (EnvironTypes.LVARFOO lv),_)) =>
         (lv' := EnvironTypes.INTFOO ct;
          (Environ.add_valid_env(env,
                                 (Ident.VAR(make_functor_app ct),
                                  EnvironTypes.LAMB(lv,EnvironTypes.NOSPEC))),ct+1))
      | _ => Crash.impossible "4:INTFOO:functor_refs:lambda")
        ((Environ.empty_env,!functor_refs_ct),!functor_refs)
    in
      (functor_refs_ct := ct;
       Environ.augment_top_env(a, make_top_env (make_env env)))
    end

  val _ = functor_refs := (!functor_refs) @ old_functor_refs

  val result_debug_info = ! debugger_env_ref
    in
      (a, b, c, result_debug_info)
    end
end;
