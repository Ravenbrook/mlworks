(*
Assemblies shadowing

Result: OK

$Log: share16.sml,v $
Revision 1.3  1996/05/23 12:28:21  matthew
UPdating

 * Revision 1.2  1996/04/01  12:28:53  matthew
 * updating
 *
 * Revision 1.1  1993/05/25  12:54:29  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

structure A = struct type t = int end;

functor Foo() = struct structure A = struct end end;

signature SIG = sig structure D : sig type t end sharing D = A end;
