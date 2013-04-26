(* enc_sub.sml the signature *)
(*
$Log: enc_sub.sml,v $
Revision 1.6  1996/02/26 11:21:22  jont
Remove newhashtable

 * Revision 1.5  1992/09/21  10:56:09  clive
 * Changed hashtables to a single structure implementation
 *
Revision 1.4  1992/07/24  15:37:32  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.3  1992/03/19  14:01:58  jont
Added some more hashtables

Revision 1.2  1992/03/16  16:21:44  jont
Added hash tables for encoding of common types (fun, rec, cons) and also
metatynames.

Revision 1.1  1992/01/22  16:03:10  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/diagnostic";
require "../typechecker/datatypes";

signature ENC_SUB =
sig
  structure Diagnostic : DIAGNOSTIC
  structure DataTypes : DATATYPES

  val type_same : DataTypes.Type * DataTypes.Type -> bool
  val tyname_same : DataTypes.Tyname * DataTypes.Tyname -> bool
  val type_hash : DataTypes.Type -> int
  val tyname_hash : DataTypes.Tyname -> int
  val tyfun_hash : DataTypes.Tyfun -> int
  val type_from_scheme : DataTypes.Typescheme -> DataTypes.Type
  val tyname_valenv_same : DataTypes.Valenv * DataTypes.Valenv -> bool
  val tyname_valenv_hash : DataTypes.Valenv -> int
end
