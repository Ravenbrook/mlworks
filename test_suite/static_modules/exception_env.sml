(*

Result: FAIL

$Log: exception_env.sml,v $
Revision 1.1  1993/07/08 09:33:03  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd.

This is taken from Stefan Kahrs' paper, "Mistakes and
Ambiguities in the Definition of Standard ML".
It illustrates a bug in the semantics to do with
exception environments.
*)

signature EXC =
sig
  exception A of int
end;

structure S = 
struct
  exception B of int
  val A = fn x => B(x+1)
end;

structure T: EXC =
struct
  exception A of int
  open S
end;

(* (fn T.A x => x) (T.A 0); *)
