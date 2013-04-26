(*
Instantiate a free type variable during signature matching

Result: OK

$Log: sig_instantiate1.sml,v $
Revision 1.1  1996/09/24 10:27:08  matthew
new unit

New test


Copyright (c) 1994 Harlequin Ltd.
*)

structure A: sig val f : int -> int end =
  struct
    val f = (fn x => x)(fn x => (x))
  end;

