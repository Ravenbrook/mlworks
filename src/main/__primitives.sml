(* __primitives.sml the structure *)
(*
$Log: __primitives.sml,v $
Revision 1.3  1991/10/22 15:11:30  davidt
Now builds using the Crash_ structure.

Revision 1.2  91/08/23  11:43:26  jont
Added __pervasives

Revision 1.1  91/07/10  11:28:48  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__set";
require "../basics/__ident";
require "../basics/__symbol";
require "../lambda/__environtypes";
require "../lambda/__lambdatypes";
require "../lambda/__environ";
require "__pervasives";
require "_primitives";

structure Primitives_ =
  Primitives(structure Crash = Crash_
	     structure Lists = Lists_
	     structure Set = Set_
	     structure Symbol = Symbol_
	     structure Ident = Ident_
	     structure EnvironTypes = EnvironTypes_
	     structure LambdaTypes = LambdaTypes_
	     structure Environ = Environ_
	     structure Pervasives = Pervasives_);
