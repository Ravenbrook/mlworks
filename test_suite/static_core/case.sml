(*
Test for exhaustiveness checking
*)
(*

Result: OK
 
$Log: case.sml,v $
Revision 1.1  1996/10/25 12:09:59  matthew
new unit

New test


Copyright (c) 1996 Harlequin Ltd.
*)

structure Foo =
  struct
    datatype Foo = FOO | BAR of int
    exception Boo  
  end

open Foo

fun f (FOO) = 0 | f (BAR n) = n
fun g (Foo.FOO) = 0 | g (BAR n) = n
exception Boo
fun h f = f () handle Boo => 0 | Foo.Boo => 1
