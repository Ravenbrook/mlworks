(* strenv.sml the structure *)

(* $Log: __strenv.sml,v $
 * Revision 1.5  1995/03/23 13:34:37  matthew
 * Removing SimpleTypes structure
 *
Revision 1.4  1995/02/02  13:27:09  matthew
Stuff

Revision 1.3  1992/08/11  18:00:18  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.2  1992/08/03  10:23:06  jont
Anel's changes to use NewMap instead of Map

Revision 1.1  1991/11/14  12:20:38  richard
Initial revision

Copyright (C) 1991 Harlequin Ltd.
*)

require "../typechecker/__datatypes";
require "../typechecker/_strenv";

structure Strenv_ = Strenv (structure Datatypes      = Datatypes_
                              )
