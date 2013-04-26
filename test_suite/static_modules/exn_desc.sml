(*
Bad exception description within signature
Result: FAIL
 
$Log: exn_desc.sml,v $
Revision 1.1  1994/04/28 13:56:42  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

signature S = sig exception Foo of Bar end
signature S' = S;
