(*
Bad datatype description within signature
Result: FAIL
 
$Log: dat_desc.sml,v $
Revision 1.1  1994/04/28 13:57:03  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

signature S =
  sig
    datatype Foo = Bar of Bar
      | FooBar of FooBar
    and FooBar = BarBar of Foo
 end
signature S' = S;
