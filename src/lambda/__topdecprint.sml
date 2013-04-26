(* __topdecprint.sml the structure *)
(*
$Log: __topdecprint.sml,v $
Revision 1.7  1996/10/31 15:55:57  io
[Bug #1614]
remove Lists

 * Revision 1.6  1995/11/22  09:15:31  daveb
 * Removed ModuleId parameter.
 *
Revision 1.5  1993/07/29  14:03:00  daveb
Added ModuleId parameter.

Revision 1.4  1992/09/16  08:40:20  daveb
Type printing routines now require Lists_ structure.

Revision 1.3  1991/07/25  17:44:06  jont
Corrected the requires to use structures. This bug should be spotted by
the compiler, but ...

Revision 1.2  91/07/22  17:28:00  davida
Added pretty-printing for signature expressions, provisionally.

Revision 1.1  91/07/10  09:36:00  jont
Initial revision


Copyright (c) 1991 Harlequin Ltd.
*)

require "__pretty";
require "../basics/__absyn";
require "../basics/__absynprint";
require "../basics/__identprint";
require "_topdecprint";

structure TopdecPrint_ = TopdecPrint(
  structure Pretty = Pretty_
  structure Absyn = Absyn_
  structure AbsynPrint = AbsynPrint_
  structure IdentPrint = IdentPrint_
  );

