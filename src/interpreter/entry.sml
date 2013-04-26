(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
