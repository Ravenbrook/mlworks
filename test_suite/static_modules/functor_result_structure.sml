(*
Functor results shouldn't share new structures

Result: FAIL

$Log: functor_result_structure.sml,v $
Revision 1.2  1996/04/01 12:16:12  matthew
updating

 * Revision 1.1  1995/03/31  09:47:36  matthew
 * new unit
 * No reason given
 *

Copyright (c) 1992 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

functor Foo () = struct structure Bar = struct end end;
structure Foo1 = Foo();
structure Foo2 = Foo();
signature FOO = sig sharing Foo1 = Foo2 end;
