(* __lambda.sml the structure *)
(*
$Log: __lambda.sml,v $
Revision 1.38  1998/01/26 18:12:56  johnh
[Bug #30071]
Merge in Project Workspace changes.

 * Revision 1.37.10.2  1997/11/26  15:46:11  daveb
 * [Bug #30071]
 *
 * Revision 1.37.10.1  1997/09/11  20:55:53  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.37  1996/04/11  15:21:56  stephenb
 * Remove Os since it is no longer needed.
 *
 * Revision 1.36  1996/03/27  10:55:44  stephenb
 * Add OS structure as the functor needs to deal with OS.SysErr exceptions
 *
 * Revision 1.35  1996/02/21  11:04:54  jont
 * Add Module and ModuleId to functor parameters
 *
 * Revision 1.34  1995/12/13  13:50:38  jont
 * Add inthashtable to functor parameter
 *
Revision 1.33  1995/09/06  09:00:06  daveb
Added MachSpec parameter.

Revision 1.32  1995/03/01  13:01:30  matthew
Added Implicit_Vector structure
Replaced LambdaUtils by Match

Revision 1.31  1995/02/07  17:10:15  matthew
Renaming Type_Utils

Revision 1.30  1994/01/14  09:42:27  nosa
Removed structure Match

Revision 1.29  1993/06/28  16:47:02  daveb
Added Basis structure.

Revision 1.28  1993/05/18  18:53:23  jont
Removed integer parameter

Revision 1.27  1993/04/05  11:30:01  matthew
 Renamed Typerep_Utils to TyperepUtils

Revision 1.26  1993/03/04  13:06:55  matthew
Options & Info changes

Revision 1.25  1993/02/18  16:48:38  matthew
Added TypeRep_Utils parameter

Revision 1.24  1992/11/26  13:12:21  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.23  1992/11/06  11:05:27  matthew
Changed Error structure to Info

Revision 1.22  1992/09/25  11:57:05  jont
Removed numerous unused structure parameters

Revision 1.21  1992/09/04  09:05:58  richard
Installed central error reporting mechanism.

Revision 1.20  1992/08/25  14:54:52  clive
Added the recording of information about exceptions

Revision 1.19  1992/08/06  15:30:09  jont
Added Valenv parameter (probably temporary)

Revision 1.19  1992/08/06  15:30:09  jont
Added Valenv parameter

Revision 1.18  1992/07/22  09:36:11  matthew
Added AbsynPrint to functor application

Revision 1.17  1992/06/10  14:37:14  jont
changed to use newmap

Revision 1.16  1992/04/13  17:01:08  clive
First version of the profiler

Revision 1.15  1992/04/08  10:03:40  jont
Added require ../utils/__text

Revision 1.14  1992/02/11  13:43:27  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.13  1992/01/23  18:07:45  jont
Added type_tuils parameter

Revision 1.12  1992/01/09  17:59:39  jont
Added diagnostic and print structures

Revision 1.11  1991/11/27  13:00:56  jont
Removed reference to match_utils

Revision 1.10  91/10/22  15:23:49  davidt
Now builds using the Crash_ structure

Revision 1.9  91/09/04  11:15:29  jont
Added lambdaoptimiser for beta reduction

Revision 1.8  91/08/23  11:53:22  jont
Added pervasives

Revision 1.7  91/08/07  17:05:17  jont
Added recognition of equality on special constants for ease of production
of code in these cases.

Revision 1.6  91/07/17  09:27:04  jont
Added LambdaSub as a parameter

Revision 1.5  91/06/27  19:00:58  jont
Added Interface for signature constraint

Revision 1.4  91/06/27  12:27:40  jont
Now requires set

Revision 1.3  91/06/24  11:50:14  jont
Added __lambdautils for service functions for lambda translation

Revision 1.2  91/06/12  18:11:00  jont
Added environprint for debugging _lambda.sml

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__intbtree";
require "../utils/__crash";
require "../utils/__print";
require "../utils/__inthashtable";
require "../basics/__absynprint";
require "../basics/__identprint";
require "../typechecker/__types";
require "../typechecker/__basis";
require "../match/__type_utils";
require "../main/__primitives";
require "../main/__pervasives";
require "../machine/__machspec";
require "../rts/gen/__implicit";
require "../debugger/__debugger_types";
require "../match/__match";
require "__environ";
require "__lambdaprint";
require "__lambdaoptimiser";
require "../main/__info";
require "../typechecker/__typerep_utils";
require "_lambda";

structure Lambda_ = Lambda (
  structure Diagnostic = Diagnostic(structure Text = Text_)
  structure Lists = Lists_
  structure IntNewMap = IntBTree_
  structure Crash = Crash_
  structure Print = Print_
  structure IntHashTable = IntHashTable_
  structure AbsynPrint = AbsynPrint_
  structure IdentPrint = IdentPrint_
  structure Types = Types_
  structure Basis = Basis_
  structure TypeUtils = TypeUtils_
  structure Primitives = Primitives_
  structure Pervasives = Pervasives_
  structure MachSpec = MachSpec_
  structure ImplicitVector = ImplicitVector_
  structure Debugger_Types = Debugger_Types_
  structure Match = Match_
  structure Environ = Environ_
  structure LambdaPrint = LambdaPrint_
  structure LambdaOptimiser = LambdaOptimiser_
  structure Info = Info_
  structure TyperepUtils = TyperepUtils_
)
