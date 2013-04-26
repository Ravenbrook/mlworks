(* Error Browser *)

(*
 * $Log: error_browser.sml,v $
 * Revision 1.8  1999/02/02 15:59:47  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.7  1997/05/16  15:36:08  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.6  1996/05/08  13:50:49  daveb
 * Made create return a close function.
 *
 * Revision 1.5  1996/02/23  11:12:23  daveb
 * Added the error_to_string function.
 *
 * Revision 1.4  1996/02/22  16:57:53  daveb
 * Added close_action.
 *
 * Revision 1.3  1996/01/25  14:45:00  daveb
 * Removed action_message parameter from create.
 *
 * Revision 1.2  1995/09/22  11:04:51  daveb
 * Changed edit_action parameter to return both a quit_fn and a clean_fn, with
 * each new call to edit_error calling the previous clean_fn.  (This is used
 * to remove highlighting in the evaluator).
 *
 *  Revision 1.1  1994/06/21  13:00:22  matthew
 *  new unit
 *  New unit
 *
 *  Revision 1.2  1994/06/21  13:00:22  daveb
 *  Revised interface.
 * 
 * Copyright (c) 1994 Harlequin Ltd.
 *)

signature ERROR_BROWSER =
sig
  type Widget
  type error
  type location
  type ToolData
  type user_context

  val error_to_string: error -> string
  (* error_to_string returns a single line version of an error message. *)

  val create:
    {parent: Widget,
     errors: error list,
     file_message: string,
     editable: location -> bool,
     edit_action: location -> {quit_fn: unit -> unit, clean_fn: unit -> unit},
       (* quit_fn is executed when the Close or Redo actions are selected.
	  clean_fn is executed when the Edit action is selected next. *)
     close_action: unit -> unit,
     redo_action: unit -> unit,
	(* the following two fields are used to make the tools menu *)
     mk_tooldata: unit -> ToolData,
     get_context: unit -> user_context}
    -> (unit -> unit)
   (* Returns a close function *)
end;
