(* User contexts.
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: user_context.sml,v $
 * Revision 1.14  1998/03/18 17:08:55  mitchell
 * [Bug #50062]
 * Fix context browser so contents persists in saved images, and the basis appears in the initial context for guib
 *
 * Revision 1.13  1997/10/14  12:41:21  daveb
 * [Bug #30283]
 * Added with_null_history.
 *
 * Revision 1.12  1997/07/31  12:41:38  johnh
 * [Bug #50019]
 * Modify process_result to take a UserContext.source_reference type for src.
 *
 * Revision 1.11  1997/05/01  12:40:04  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.10  1996/08/15  13:55:06  daveb
 * [Bug #1519]
 * Allowed the source field of an item to indicate that it shares the source
 * of the previous item in the history.
 *
 * Revision 1.9  1996/05/14  11:37:43  daveb
 * Added null_history and save_name_set.
 *
 * Revision 1.8  1996/04/11  15:54:32  daveb
 * Added history deletion functions, changed the type of update functions,
 * and added a preferences argument to process_result (and made it take a
 * record instead of a tuple).
 *
 * Revision 1.7  1996/02/08  13:53:23  daveb
 * The update_functions now take the list of new items as an argument.
 * Removed the old selection stuff.  Removed some detritus.
 *
 *  Revision 1.6  1996/01/17  17:16:47  matthew
 *  Adding history_item_name function
 *
 *  Revision 1.5  1995/06/06  11:22:04  daveb
 *  Added get_latest and get_n, to support history operations.
 *
 *  Revision 1.4  1995/06/05  13:54:50  daveb
 *  Added user_tool_options argument to process_result.
 *
 *  Revision 1.3  1995/05/23  15:52:52  daveb
 *  Added get_user_options.
 *
 *  Revision 1.2  1995/05/19  15:51:23  daveb
 *  Added getInitialContext.
 *
 *  Revision 1.1  1995/05/01  08:55:48  daveb
 *  new unit
 *  Separated user context code from shelltypes.sml.
 *
 *
 *)

require "../main/options";

signature USER_CONTEXT =
sig
  structure Options : OPTIONS

  type user_context_options
  type preferences
  type Context
  type Result
     
  type user_context
  type identifier

  (* A source reference stores the source of a value in the history.
     The COPY constructor is used when the same source binds several
     identifiers.  The function that saves source to files (in gui_utils)
     ignores copies.  *)
  datatype source_reference =
    STRING of string
  | COPY of string

  (* The History tool uses a list of history entries. *)
  datatype history_entry =
    ITEM of
      {index: int,              (* the number of the entry in the history *)
       id: identifier,          (* the identifier that was defined *)
       context: Context,        (* the delta context after evaluating the id *)
       result: string,          (* the printed version of the result *)
       source: source_reference}(* the source string *)
  (* If the source field is NONE, the source is assumed to be the same as
     the previous entry.  *)

  (* Each user_context contains the full incremental context used by the
     compiler, a second context containing just the identifiers defined in
     this user_context (used by the browser), a list for the history widget,
     and a map from identifiers to their source, all in the same ref so that
     they can be updated together.  This is the information returned and set
     by the [gs]et_context_info and [gs]et_user_context_info functions.

     Another reference holds a register of update functions.  These are
     called when the context is updated.  They can be used to update a
     context browser or similar tool.  The add_update_fn and remove_update_fn
     functions affect this register.  The update functions are passed NONE
     if they have to re-read the whole history, or (SOME items) when new
     items are added to an unchanged history.

     User contexts also contain the name of the context, a flag that indicates
     whether the context is constant, which file the history for that context
     has been saved in (if any) and the number of times that the context has
     been copied (which is used by the naming scheme).

     Keeping the per-user_context info in an incremental context keeps the
     option open of merging contexts.  Someday the history representation will
     change to handle modules better. *)

  val getCurrentContexts : unit -> user_context list
  val getInitialContext : unit -> user_context
  val getNewInitialContext : unit -> user_context
  val copyUserContext : user_context -> user_context

  (* This is a dummy value solely for initialising a reference in ShellTypes *)
  val dummy_context: user_context

  val makeInitialUserContext :
	Context * string * user_context_options -> user_context

  val get_saved_file_name : user_context -> string option
  val set_saved_file_name : user_context * string -> unit
  val saved_name_set : user_context -> bool

  val clear_debug_info : user_context * string -> unit
  val clear_debug_all_info : user_context -> unit

  val get_user_options : user_context -> user_context_options

  val get_context : user_context -> Context
  val get_delta : user_context -> Context

  val get_history : user_context -> history_entry list
  val null_history : user_context -> bool

  (* with_null_history u f x; modifies the u to have an empty history
     before evaluating f x, and restores the original history afterwards.
     It is primarily intended for use by <URI:/save_image.sml#saveImage>. *)
  val with_null_history : user_context -> ('a -> 'b) -> 'a -> 'b

  val delete_from_history : user_context * history_entry -> unit
  val delete_entire_history : user_context -> unit
  val remove_duplicates_from_history : user_context -> unit
  val move_context_history_to_system : user_context -> unit

  val get_latest: user_context -> history_entry option
  val get_nth: user_context * int -> history_entry option

  (* update functions are associated with an abstract key type, so that
     they can be removed later. *)
  type register_key

  val add_update_fn :
    user_context * (history_entry list option -> unit)
    -> register_key

  val remove_update_fn : user_context * register_key -> unit

  val history_entry_name : history_entry -> string option

  val is_const_context : user_context -> bool

  val set_context_name : user_context * string -> unit
  val get_context_name : user_context -> string

  val process_result :
    {src: source_reference,
     result: Result,
     user_context: user_context,
     preferences: preferences,
     options: Options.options,
     output_fn: string -> unit}
    -> unit

end;
