(*
Test for exhaustiveness checking
*)
(*

Result: WARNING
 
$Log: case1.sml,v $
Revision 1.1  1996/10/25 12:10:44  matthew
new unit
New test
New Test\


Copyright (c) 1996 Harlequin Ltd.
*)

structure Foo =
  struct
    datatype Foo = FOO | BAR of int
    exception Boo  
  end

open Foo

fun g Foo.FOO = 0 | g FOO = 1 | g (BAR n) = n
