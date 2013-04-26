(*
Constructors can match value specifications.

Result: OK
 
$Log: constructor.sml,v $
Revision 1.3  1993/01/20 15:05:16  daveb
Moved the exception case to a separate file.

Revision 1.2  1993/01/20  11:38:10  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure bad1 :
sig
  type t 
  val X : t
end =
struct 
  datatype t = X 
end
