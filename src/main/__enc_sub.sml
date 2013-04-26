(* __enc_sub.sml the structure *)
(*
$Log: __enc_sub.sml,v $
Revision 1.6  1996/02/22 14:18:40  jont
Remove __map parameter

 * Revision 1.5  1992/03/19  12:44:20  clive
 * Changed hashtables to a single structure implementation
 *
Revision 1.4  1992/03/19  12:44:20  jont
Added some more hashtables

Revision 1.3  1992/03/16  13:13:09  jont
Added hash tables for encoding of common types (fun, rec, cons) and also
metatynames.

Revision 1.2  1992/02/11  13:17:16  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.1  1992/01/22  16:31:14  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "../typechecker/__datatypes";
require "_enc_sub";

structure Enc_Sub_ = Enc_Sub(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Diagnostic = Diagnostic(structure Text = Text_)
  structure DataTypes = Datatypes_
)
