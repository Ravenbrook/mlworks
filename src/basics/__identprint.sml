(* __identprint.sml the structure *)
(*
$Log: __identprint.sml,v $
Revision 1.4  1993/03/03 18:29:44  matthew
Options & Info changes

Revision 1.3  1992/11/25  18:55:07  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1991/11/21  15:54:11  jont
Added copyright message

Revision 1.1  91/06/07  10:52:40  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../main/__options";
require "__ident";
require "_identprint";

structure IdentPrint_ = 
  IdentPrint (
    structure Ident = Ident_
    structure Options = Options_
  )
