(*
Instantiate a free type variable during signature matching

Result: FAIL

$Log: sig_instantiate2.sml,v $
Revision 1.1  1996/09/24 10:26:58  matthew
new unit
New test


Copyright (c) 1994 Harlequin Ltd.
*)

structure A: sig val f : int -> int val g: bool -> bool end =
  struct
    val f = (fn x => x)(fn x => x)
    val g = f
  end;

