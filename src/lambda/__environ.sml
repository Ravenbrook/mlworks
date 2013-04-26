(* __environ.sml the structure *)
(*
$Log: __environ.sml,v $
Revision 1.13  1993/05/18 18:48:27  jont
Removed integer parameter

Revision 1.12  1993/03/10  15:28:12  matthew
Signature revisions

Revision 1.11  1993/01/26  09:36:18  matthew
Simplified parameter signature

Revision 1.10  1992/09/25  11:50:21  jont
Removed numerous unused structure parameters

Revision 1.9  1992/06/10  14:02:39  jont
Changed to use newmap

Revision 1.8  1992/03/23  11:00:57  jont
Added requires for __absyn and __interface (was interface)

Revision 1.7  1991/11/21  16:23:16  jont
Added copyright message

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../basics/__identprint";
require "../typechecker/__datatypes";
require "_environ";
require "__environtypes";

structure Environ_ = Environ(structure Crash = Crash_
                             structure Lists = Lists_
                             structure Datatypes = Datatypes_
                             structure IdentPrint = IdentPrint_
                             structure EnvironTypes = EnvironTypes_
                               );
