(* match.sml the signature *)
(*
$Log: match.sml,v $
Revision 1.32  1997/05/01 15:35:30  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.31  1995/12/11  16:06:30  jont
 * Add some comments to clarify some of the interface
 *
Revision 1.30  1995/09/05  15:02:40  daveb
Added optional size information to SCONs.

Revision 1.29  1995/08/10  10:28:42  jont
Modifications to allow defaults to be optional in special constant matches

Revision 1.28  1995/08/03  14:55:51  jont
Remove Option in favour of MLWorks.Option

Revision 1.27  1995/01/09  12:25:44  matthew
Tidying up

Revision 1.26  1994/09/14  12:46:27  matthew
Abstraction of debug information

Revision 1.25  1994/06/28  10:15:44  nosa
Matchvars in special constructors.

Revision 1.24  1994/06/27  16:43:28  nosa
Bindings in Match DEFAULT trees.

Revision 1.23  1994/06/27  09:46:44  nosa
Exhaustiveness and Redundancy Checking Revision.

Revision 1.22  1994/06/21  09:19:52  nosa
Spurious redundancy Bug Fix by removing side-effects in exhaustiveness checking.

Revision 1.21  1994/02/21  20:41:53  nosa
Type function spills for Modules Debugger.

Revision 1.20  1994/01/17  10:42:02  nosa
Dynamic pattern-redundancy reporting;
Correct Exception Pattern Matching

Revision 1.18  1993/08/12  09:25:44  nosa
Compilation instances paired in type refs for polymorphic debugger.

Revision 1.17  1993/08/06  14:39:50  matthew
Added location information to matches

Revision 1.16  1993/07/30  10:43:21  nosa
Type information in LEAFs for local and closure variable inspection
in the debugger; structure Option.

Revision 1.15  1993/07/21  15:01:53  nosa
More informative inexhaustiveness reporting

Revision 1.14  1993/03/09  12:12:13  matthew
Options & Info changes
Absyn changes

Revision 1.13  1993/02/01  16:36:37  matthew
Added sharing constraint

Revision 1.12  1993/01/12  11:31:46  nosa
Deleted label handling in lambda translator.

Revision 1.10  1992/11/04  15:19:11  jont
Changes to allow IntNewMap to be used on MatchVar

Revision 1.9  1992/09/24  09:09:07  clive
Allowed the compiler to change the order of the clauses if it could prove them to be disjoint
 Allowed the system to choose the order for looking at tuple elements (used to be left to right)

Revision 1.8  1992/07/22  09:37:46  matthew
Changed interface to match compiler to for passing back of redundancy and exhaustiveness information

Revision 1.7  1992/01/24  11:26:47  jont
Removed superfluous space from middle of a longid which NJ erroneously
failed to notice (but we did!)

Revision 1.6  1992/01/23  13:42:09  jont
Removed open datatypes

Revision 1.5  1992/01/22  19:38:05  jont
Removed exception impossible (now done by Crash.impossible)

Revision 1.4  1991/11/21  16:34:09  jont
Added copyright message

Revision 1.3  91/11/19  12:16:38  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:12:23  jont
Added comments for DRA on functions

Revision 1.2  91/06/24  13:50:17  colin
Changed match tree to give LongValIds rather than ValIds in CONSTRUCTOR
nodes - needed to code generate longexcons where the path must be kept

Revision 1.1  91/06/07  11:06:27  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* The match compiler. For efficient pattern-matching, one must match
against all patterns in a set simultaneously, rather than
sequentially. This means that pattern-matches (which occur in all
function expressions and exception handlers in ML) must be transformed
into lambda calculus by a special algorithm. The function
compile_match in this module performs the difficult part of this
transformation: from match expressions to match trees (the other part,
match-trees to lambda-calculus, is done in codegen/cg). The essential
algorithm and datastructures used are as described by Philip Wadler in
"Efficient Compilation of Pattern-Matching", chapter 5 of "The
Implementation of Functional Programming Languages", Simon L.
Peyton-Jones, Prentice-Hall 1987.

Unfortunately, neither Wadler's algorithm nor this (modified) version
is capable of handling the full generality of ML pattern-matching, so
it does not identify all cases of redundancy and exhuastiveness *)

require "../basics/absyn" ;
require "../main/options" ;

signature MATCH =
  sig
    structure Options : OPTIONS
    structure Absyn : ABSYN

    eqtype Matchvar
    eqtype lvar

    val to_Matchvar : int -> Matchvar
    val from_Matchvar : Matchvar -> int

    datatype ('a, 'b) union = INL of 'a | INR of 'b

    datatype Constructors =
      CON1 of int list
    | CON2 of Absyn.Ident.LongValId * Matchvar
    | SCON1 of string list
    | SCON2 of string * Matchvar
    | REC of (Absyn.Ident.Lab * Matchvar) list

    datatype 'env Tree =
        LEAF of Absyn.Exp * int * (Matchvar * Absyn.Ident.ValId * (Absyn.Type ref * Absyn.RuntimeInfo ref)) list
      | SCON of Matchvar * (Absyn.Ident.SCon * 'env Tree) list
	* 'env DefaultTree ref option *
        ((int * 'env Tree),lvar) union ref option ref option
	* int option
      | CONSTRUCTOR of
          Absyn.Type * Matchvar
	  * (Absyn.Ident.LongValId * Matchvar
	     * ('env Tree,((int * 'env Tree),lvar) union ref) union) list
	  * ('env DefaultTree ref option,((int * 'env Tree),lvar) union ref) union *
	  (((int * 'env Tree),lvar) union ref option ref,
	   ((int * 'env Tree),lvar) union ref * Matchvar) union list * bool
      | RECORD of Absyn.Type * Matchvar
	* (Absyn.Ident.Lab * Matchvar) list * 'env Tree
      | DEFAULT of 'env DefaultTree ref *
        ((int * 'env Tree),lvar) union ref option ref option

    and 'env DefaultTree =
      UNBUILT of ('env -> 'env Tree)
      * ((int * 'env Tree),lvar) union ref option ref * 'env * bool
      | UNBUILT' of ('env -> 'env Tree)
        * ((int * 'env Tree),lvar) union ref option ref * 'env * bool
      | BUILT of ((int * 'env Tree),lvar) union ref
      | ERROR of (Absyn.Type * Absyn.Ident.ValId list) list -> unit

    (* NB, UNBUILT & UNBUILT' above are only used internally *)
    (* by the match compiler, and should never occur outside *)

    datatype expression =
      && of expression * expression |
      || of expression * expression |
      == of Absyn.Ident.LongValId * Absyn.Ident.LongValId |
      TRUE |
      FALSE

    val compile_match :
      (Absyn.Pat * Absyn.Exp * Absyn.Ident.Location.T) list ->
      Matchvar *
      (int * Constructors) list list Tree *
      (int * expression) list *
      (Absyn.Type * Absyn.Ident.ValId list) list option

    val unparseTree : Options.print_options -> '_env Tree -> string -> string list

  end
