(* This signature specifies the top-level items in the 1990 Definition Of
 * Standard ML that were removed by the revised basis.  Opening a matching
 * structure should enable almost any code written for the original
 * Definition to be compiled.
 *
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * $Log: sml90.sml,v $
 * Revision 1.2  1997/09/19 10:01:50  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *  Revision 1.1  1996/05/30  16:10:23  daveb
 *  new unit
 *  Backwards compatibility.
 *
 *
 *)

signature SML90 =
sig
  type instream
  type outstream

  exception Ord
  exception Io of string

  (* The following exceptions are all aliases for Overflow *)
  exception Abs
  exception Quot
  exception Prod
  exception Neg
  exception Sum
  exception Diff
  exception Floor

  (* The following exceptions never in fact occur *)
  exception Sqrt
  exception Exp
  exception Ln

  (* The following exception is a synonym of Div *)
  exception Mod

  (* The following exception is raised when ... *)
  exception Interrupt

  val sqrt: real -> real
  val sin: real -> real
  val cos: real -> real
  val arctan: real -> real
  val exp: real -> real
  val ln: real -> real
  val chr: int -> string
  val ord: string -> int
  val explode: string -> string list
  val implode: string list -> string

  val std_in: instream
  val open_in: string -> instream
  val input: instream * int -> string
  val lookahead: instream -> string
  val close_in: instream -> unit
  val end_of_stream: instream -> bool

  val std_out: outstream
  val open_out: string -> outstream
  val output: outstream * string -> unit
  val close_out: outstream -> unit
end

