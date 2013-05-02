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
 *  $Log: _path_tool.sml,v $
 *  Revision 1.21  1998/03/31 16:02:58  johnh
 *  [Bug #30346]
 *  Call Capi.getNextWindowPos().
 *
 * Revision 1.20  1998/02/13  15:58:16  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.19  1998/01/30  09:34:06  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.18.2.2  1997/11/20  16:52:25  daveb
 * [Bug #30326]
 *
 * Revision 1.18.2.1  1997/09/11  20:52:00  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.18  1997/06/12  15:13:36  johnh
 * [Bug #30175]
 * Add extra arg to make_main_window.
 *
 * Revision 1.17  1997/05/16  15:36:25  johnh
 * Implementing single menu bar on Windows, and re-organising menus for Motif.
 * BUT using old menus here temporarily until we decide where they should go.
 *
 * Revision 1.16  1997/05/12  16:40:27  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.15  1997/03/21  11:04:17  johnh
 * [Bug #1965]
 * Added comment for handling NotSet exception.
 *
 * Revision 1.14  1996/11/01  11:02:08  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.13  1996/10/10  02:46:06  io
 * moving String from toplevel
 *
 * Revision 1.12  1996/08/09  15:25:58  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.11  1996/04/18  15:18:34  jont
 * initbasis moves to basis
 *
 * Revision 1.10  1996/04/12  08:58:00  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.9  1996/03/27  15:16:10  stephenb
 * Replace FileSys/FILE_SYS by OS.FileSys/OS_FILE_SYS
 *
 * Revision 1.8  1996/03/15  15:39:41  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.7  1996/03/14  11:55:42  matthew
 * Renaming resource
 *
 * Revision 1.6  1996/03/12  15:31:49  matthew
 * Adding object path entry
 *
 * Revision 1.5  1996/02/05  11:33:13  daveb
 * Capi.make_scrolllist now returns a record, with an add_items field.
 *
 *  Revision 1.4  1996/01/19  15:57:35  stephenb
 *  OS reorganisation: parameterise functor with UnixOS since all
 *  OS specific stuff has been removed from the pervasive library.
 *
 *  Revision 1.3  1996/01/12  10:48:58  daveb
 *  Replaced Capi.find_file with Capi.open_dir_dialog.
 *
 *  Revision 1.2  1995/12/15  14:34:10  jont
 *  Add signature constraint to functor result
 *
 *  Revision 1.1  1995/12/13  12:46:07  daveb
 *  new unit
 *  Extracted relevant source from the old File Tool.
 *
 *  
 *)

require "../utils/lists";
require "../main/mlworks_io";
require "../main/info";
require "../main/options";
require "../basis/os";
require "capi";
require "menus";
require "path_tool";

functor PathTool (
  structure Lists : LISTS
  structure Capi : CAPI
  structure Menus : MENUS
  structure Io: MLWORKS_IO
  structure Info: INFO
  structure Options: OPTIONS
  structure OS: OS

  sharing type Menus.Widget = Capi.Widget
  sharing type Io.Location = Info.Location.T

) : PATH_TOOL =
  struct

    structure Location = Info.Location

    type Widget = Capi.Widget

    fun objectCreate parent =
      #1 (Menus.create_dialog (parent,
                               "Set Object Path",
                               "objectPathDialog",
                               fn _ => (),
                               [Menus.OPTSEPARATOR,
                                Menus.OPTTEXT ("objectPath",
                                               Io.get_object_path,
                                               fn s => (Io.set_object_path
							(s, Location.UNKNOWN);
							true))]))
		(* XXXEXCEPTION: should handle Io.NotSet for get_object_path *)

    fun setWD parent = 
      case Capi.open_dir_dialog parent of
        SOME s => OS.FileSys.chDir s      (* XXXEXCEPTION: OS.SysErr *)
      | NONE => ()

    val sizeRef = ref NONE
    val posRef = ref NONE

    fun sourceCreate parent =
      let
        val title = "Set Source Path"

        val name = "pathTool"

        (*** Make the windows ***)
        val (shell, form, menuBar, contextLabel) =
          Capi.make_main_window 
	       {name = name, 
		title = title, 
		parent = parent, 
		contextLabel = false, 
		winMenu = true,
		pos = getOpt (!posRef, Capi.getNextWindowPos())}

        val pathLabel =
	  Capi.make_managed_widget ("pathLabel",Capi.Label,form,[])

        fun number_entries ([], _) = []
        |   number_entries (h::t, n) = (h, n) :: number_entries (t, n + 1)

        val entries = ref (number_entries (Io.get_source_path (), 1))

        val current_pos = ref (if !entries = [] then 0 else 1)

        val current_entry_selected = ref true;

        fun print_entry print_options (s, _) = s;

        fun select_fn _ (_, n) =
          if !current_pos <> n then
            (current_pos := n;
             current_entry_selected := false)
          else
            ()

        fun action_fn _ (s, _) =
          ((* set_directory s; *)
           current_entry_selected := true)

        val {scroll, list, set_items, ...} =
          Capi.make_scrolllist
            {parent = form, name = "sourcePath", select_fn = select_fn,
             action_fn = action_fn, print_fn = print_entry}

        val _ =
          let val init_dir =
                    case !entries
                    of [] => OS.FileSys.getDir() (* XXXEXCEPTION: OS.SysErr *)
                    |  ((dir, _) :: _) => dir
          in
            set_items Options.default_print_options (!entries);
            if !current_pos <> 0 then
              Capi.List.select_pos (list, 1, false)
            else ()
          end

	fun renumber_up (s, n) = (s, n + 1)

	fun renumber_down (s, n) = (s, n - 1)

	fun is_in (n:string, []) = false
	|   is_in (n, (n', _)::t) = n = n' orelse is_in (n, t)
	infix is_in

	fun add_nth ([], s, n) = [(s, n)] 
	|   add_nth (l as h::t, s, n) =
	  if n = #2 h then
	    (s, n) :: map renumber_up l
	  else
	    h :: add_nth (t, s, n) 

	fun remove_nth ([], _) = []
	|   remove_nth (h::t, n) =
	  if n = #2 h then
	    map renumber_down t
	  else
	    h :: remove_nth (t, n)

	fun get_directory () =
	  case Capi.open_dir_dialog (shell)
	  of SOME s => s
	  |  NONE => ""

        fun crash s =
	  Info.default_error' (Info.FAULT,Location.UNKNOWN,s)

	fun delete_from_source_path _ =
	  let val new_entries =
		remove_nth (!entries, !current_pos)
	      val new_source_path = map #1 new_entries
	  in
	    entries := new_entries;
	    Io.set_source_path new_source_path;
	    current_entry_selected := false;
	    set_items Options.default_print_options new_entries;
	    if !current_pos > Lists.length new_entries then
	      current_pos := Lists.length new_entries
	    else ();
	    if !current_pos <> 0 then
	      Capi.List.select_pos (list, !current_pos, false)
	    else ()
	  end

	fun insert_into_source_path _ =
	  let val dir = get_directory ()
	  in
	    if dir = "" orelse dir is_in !entries then
	      ()
	    else let
	      val new_entries =
		add_nth
		  (!entries, dir, if !current_pos = 0 then 1 else !current_pos)
	      val new_source_path = map #1 new_entries
	    in
	      current_pos := !current_pos + 1;
	      entries := new_entries;
	      Io.set_source_path new_source_path;
	      set_items Options.default_print_options new_entries;
	      Capi.List.select_pos (list, !current_pos, false)
	    end
	  end

	fun append_into_source_path _ =
	  let val dir = get_directory ()
	  in
	    if dir = "" orelse dir is_in !entries then
	      ()
	    else let
	      val new_entries =
		add_nth (!entries, dir, !current_pos + 1)
	      val new_source_path = map #1 new_entries
	    in
	      if !current_pos = 0 then current_pos := 1 else ();
	      Io.set_source_path new_source_path;
	      entries := new_entries;
	      set_items Options.default_print_options new_entries;
	      Capi.List.select_pos (list, !current_pos, false)
	    end
	  end

	fun cd_to_source_path _ =
	  ((* set_directory (#1 (Lists.nth (!current_pos - 1, !entries))); *)
	   current_entry_selected := true)

        fun storeSizePos () = 
	  (sizeRef := SOME (Capi.widget_size shell);
	   posRef := SOME (Capi.widget_pos shell))

	(* Need to handle closes correctly.  Should unmap window. *)
	fun close_window _ = 
	  (storeSizePos(); Capi.destroy shell)

        val menuspec =
          [Menus.CASCADE
	     ("action",
	      [(* Menus.PUSH
		 ("moveto", cd_to_source_path, fn _ => !current_pos <> 0),
	       *)
               Menus.PUSH ("insert", insert_into_source_path, fn _ => true),
               Menus.PUSH ("append", append_into_source_path, fn _ => true),
               Menus.PUSH
		 ("delete", delete_from_source_path, fn _ => !current_pos <> 0),
	       Menus.SEPARATOR,
               Menus.PUSH ("close", fn _ => close_window (), fn _ => true)
	      ],
              fn _ => true)]
      in
	(* third argument (boolean) here means that this window is not the podium *)
	(* Using make_menus is a temporary hack until we decide what to do with the
	 * menu items on the source path dialog.  make_menus should only be called 
	 * by the podium, and when that happens this third argument will be removed *)
        Menus.make_menus (menuBar,menuspec,false);
        Capi.Layout.lay_out
          (form, !sizeRef,
           [Capi.Layout.MENUBAR menuBar,
            Capi.Layout.SPACE,
            Capi.Layout.FIXED pathLabel,
            Capi.Layout.FLEX scroll,
            Capi.Layout.SPACE]);
	Capi.set_close_callback(form, close_window);
        Capi.initialize_toplevel shell
      end

  end;
