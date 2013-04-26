(*
Cover

Result: OK

$Log: cover5.sml,v $
Revision 1.3  1996/05/23 12:23:14  matthew
Shell.Options change

 * Revision 1.2  1996/04/01  11:53:22  matthew
 * updating
 *
 * Revision 1.1  1993/06/01  14:07:41  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
Shell.Options.set (Shell.Options.Language.oldDefinition,true);

structure A = struct type t = int end;
signature SIG = sig structure B : sig type t end sharing B = A end;
functor Foo(structure C : SIG) = struct end;
functor Foo(structure C : sig structure B : sig type t end sharing B = A end) = struct end;
