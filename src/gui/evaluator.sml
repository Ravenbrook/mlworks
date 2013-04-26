(* evaluator.sml the signature *)

(*
 * $Log: evaluator.sml,v $
 * Revision 1.2  1996/02/08 14:22:09  daveb
 * Converted to a pop-up source browser for the context history.
 *
 *  Revision 1.1  1994/06/21  18:49:27  matthew
 *  new unit
 *  New unit
 *
 *  Revision 1.1  1994/06/21  18:49:27  daveb
 *  new file
 * 
 * 
 * Copyright (c) 1994 Harlequin Ltd.
 *)

signature EVALUATOR =
sig
  type ToolData
  type Widget

  val show_defn : 
      (Widget * ToolData) -> 
      bool -> 			(* is this an automatic selection or not? *)
      string * string ->	(* (source, result) *)
      unit
 
end;
