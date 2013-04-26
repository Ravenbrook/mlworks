(*
 * Copyright (c) 1995 Harlequin Ltd.
 *
 * $Log: entry.sml,v $
 * Revision 1.7  1999/02/02 16:00:25  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.6  1997/05/01  12:39:09  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.5  1996/08/06  16:14:34  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml to print
 * imperative type vars without an underscore when using value
 * polymorphism.
 *
 * Revision 1.4  1996/01/10  13:06:34  matthew
 * Simplification
 *
 *  Revision 1.3  1995/10/06  14:09:34  daveb
 *  Made searchOptions be a datatype.   Added searchContext field.
 *  Removed update function.
 *
 *  Revision 1.2  1995/09/28  23:59:10  brianm
 *  Adding is_tip function ...
 *
 *  Revision 1.1  1995/07/17  11:49:01  matthew
 *  new unit
 *  Moved from motif
 *

# Revision 1.1  1995/07/14  16:38:45  io
# new unit
# move context_browser bits over.
#
 *
 *)

(* This is auxilliary stuff from browser_tools with regard to searching
   and display
 *)


signature ENTRY =
sig

  type Entry
  type Context
  type options
  type Identifier

  (* These references control which entries are displayed. *)
  datatype BrowseOptions =
    BROWSE_OPTIONS of
    {show_sigs : bool ref,
     show_funs : bool ref,
     show_strs : bool ref,
     show_types : bool ref,
     show_exns : bool ref,
     show_vars : bool ref,
     (* show_conenvs controls whether the bodies of datatypes are
      displayed inline.  show_cons controls whether constructors
      are included in the list of values. *)
     show_conenvs : bool ref,
     show_cons : bool ref
     }

  val new_options : unit -> BrowseOptions
  val filter_entries : BrowseOptions -> Entry list -> Entry list

  datatype SearchOptions =
    SEARCH_OPTIONS of
       {showSig : bool,		(* search inside signatures *)
        showStr : bool,		(* search inside structures *)
        showFun : bool,		(* search inside functors   *)
        searchInitial : bool,	(* search initial context, used in listener *)
        searchContext : bool,	(* search user context, used in listener *)
        showType : bool}	(* show types of search results *)

  (* checks if Entry is `atomic' i.e. a value entry *)
  val is_tip : Entry -> bool
    
  val browse_entry : bool -> Entry -> Entry list

  (* basic context browser displayer *)
  val printEntry : options -> Entry -> string

  (* munged context browser displayer for use by search
     to gain access to the qualified identifiers
   *)
  val printEntry1 :
    SearchOptions * options * Entry list -> (string * string) list

  val massage : Entry -> Entry

  val context2entry : Context -> (Entry list)
    
  val get_id : Entry -> (string * bool)

  val get_entry : Identifier * Context -> Entry option

end;
