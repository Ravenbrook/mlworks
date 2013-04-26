(* __runtime_env.sml the structure *)
(*
$Log: __runtime_env.sml,v $
Revision 1.2  1995/12/27 15:50:29  jont
Remove __option

 * Revision 1.1  1995/01/30  12:39:34  matthew
 * new unit
 * Renamed from __runtime_env
 *
# Revision 1.2  1994/09/13  09:36:19  matthew
# Abstraction of debug information
#
# Revision 1.1  1993/07/30  15:47:27  nosa
# Initial revision
#

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/__datatypes";
require "_runtime_env";


structure RuntimeEnv_ = RuntimeEnv(structure Datatypes = Datatypes_);
