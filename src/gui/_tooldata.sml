(* Types for passing to motif tools.
 *  
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *  
 *  $Log: _tooldata.sml,v $
 *  Revision 1.22  1999/02/02 15:59:45  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.21  1998/07/09  12:50:04  johnh
 * [Bug #30400]
 * remove main_windows arg from exit_dialog.
 *
 * Revision 1.20  1998/01/27  14:10:46  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.19  1997/10/09  15:52:07  johnh
 * [Bug #30193]
 * Add option to print backtrace to system messages window.
 *
 * Revision 1.18  1997/10/03  12:25:58  johnh
 * [Bug #30137]
 * Add system message window to Usage menu.
 *
 * Revision 1.17  1997/09/30  11:21:10  johnh
 * [Bug #30244]
 * Adding dependency graph commands to Usage menu.
 *
 * Revision 1.16.2.8  1997/12/10  13:43:48  johnh
 * [Bug #30071]
 * Add save_proj_as to file menu.
 *
 * Revision 1.16.2.7  1997/12/03  11:13:00  johnh
 * [Bug #30071]
 * Improve layout of file menu.
 *
 * Revision 1.16.2.6  1997/12/02  11:43:30  johnh
 * [Bug #30071]
 * Remove old commands from the File menu.
 *
 * Revision 1.16.2.5  1997/11/24  12:16:48  johnh
 * [Bug #30071]
 * Tidy File menu and remove paths menu.
 *
 * Revision 1.16.2.4  1997/11/12  16:10:40  johnh
 * [Bug #30071]
 * Move items from Usage->GeneralPreferences to Listener->Properties.
 *
 * Revision 1.16.2.3  1997/11/11  13:35:46  johnh
 * [Bug #30244]
 * Merging dependency graph changes.
 *
 * Revision 1.16.2.2  1997/09/12  14:46:47  johnh
 * [Bug #30071]
 * Implement new Project Workspace.
 *
 * Revision 1.16  1997/06/13  09:59:30  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.15  1997/06/09  10:26:44  johnh
 * [Bug #30068]
 * Moving breakpoints_menu from GuiUtils to BreakTrace.
 *
 * Revision 1.14  1997/05/16  15:34:51  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.13  1997/05/02  17:25:23  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.12  1996/09/19  11:22:56  johnh
 * Bug #148
 * Passed list of main windows to exit_dialog function so that they can be killed.
 *
 * Revision 1.11  1996/05/14  13:57:00  daveb
 * Replaced works_menu and application_works_menu with tools_menu.
 *
 * Revision 1.10  1996/05/10  14:34:49  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.9  1996/02/23  18:01:19  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.8  1996/02/08  10:48:32  daveb
 * UserContext no longer includes a user_tool_options type.
 *
 * Revision 1.7  1996/01/23  15:23:18  daveb
 * Added tail field to edit_menu argument.
 *
 * Revision 1.6  1995/12/07  14:04:00  matthew
 * Changed interface to clipboard
 *
 * Revision 1.5  1995/11/16  13:59:59  matthew
 * Adjustments to resource names
 *
 * Revision 1.4  1995/11/15  16:51:58  matthew
 * Adding window menu
 *
 * Revision 1.3  1995/08/24  16:07:37  matthew
 * Moving exit_dialog to Menus
 *
 * Revision 1.2  1995/07/27  10:58:37  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:36:59  matthew
 * new unit
 * New unit
 *
 *  Revision 1.15  1995/07/03  16:20:18  matthew
 *  Capification
 *
 *  Revision 1.14  1995/05/29  13:56:38  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.13  1995/04/28  17:02:32  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.12  1995/03/17  11:25:00  daveb
 *  Added a Writable parameter to add_context_fn.
 *  
 *  Revision 1.11  1995/03/15  16:00:52  daveb
 *  Added current_context type, and associated functions.
 *  
 *  Revision 1.10  1994/08/01  09:56:43  daveb
 *  Moved preferences into separate structure.
 *  
 *  Revision 1.9  1994/07/14  16:01:00  daveb
 *  Changed second parameter of exit_mlworks to ApplicationData, and
 *  extended that type with a flag set to true if the GUI is launched from
 *  a TTY listener.
 *  
 *  Revision 1.8  1994/07/14  09:53:02  daveb
 *  Modified works menu to show Exit or Close, not both.
 *  
 *  Revision 1.7  1994/06/20  11:23:04  daveb
 *  Changed context refs to user_contexts.
 *  
 *  Revision 1.6  1993/11/03  18:14:29  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.5  1993/10/22  17:01:35  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.4  1993/10/12  16:25:37  matthew
 *  Merging bug fixes
 *  
 *  Revision 1.3.1.4  1993/11/03  17:52:11  daveb
 *  Copied user_options when creating new tool.
 *  
 *  Revision 1.3.1.3  1993/10/21  14:07:38  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *  
 *  Revision 1.3.1.2  1993/10/12  15:25:37  matthew
 *  Changed the Exit MLWorks function to use the quit on exit flag, rather than
 *  directly calling MLWorks.exit.
 *  
 *  Revision 1.3.1.1  1993/05/05  11:49:13  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.3  1993/05/05  11:49:13  daveb
 *  Moved exit_mlworks from _podium to _tooldata.  Added tools argument to
 *  works_menu(), removed exitApplication from TOOLDATA.
 *  
 *  Revision 1.2  1993/04/30  13:12:03  daveb
 *  Added function to create Works menu.
 *  
 *  Revision 1.1  1993/04/16  17:18:35  matthew
 *  Initial revision
 *  
 *  
 *)

require "../interpreter/shell_types";
require "../interpreter/user_context";
require "../utils/map";
require "../utils/lists";
require "../main/user_options";
require "capi";
require "menus";
require "gui_utils";

require "tooldata";

functor ToolData (
  structure ShellTypes : SHELL_TYPES
  structure UserContext : USER_CONTEXT
  structure UserOptions : USER_OPTIONS
  structure GuiUtils : GUI_UTILS
  structure Map : MAP
  structure Capi : CAPI
  structure Menus : MENUS
  structure Lists : LISTS

  sharing UserContext.Options = ShellTypes.Options
  
  sharing type Menus.Widget = Capi.Widget = GuiUtils.Widget
  sharing type UserContext.user_context = ShellTypes.user_context =
	       GuiUtils.user_context
  sharing type UserContext.Context = ShellTypes.Context
  sharing type ShellTypes.user_options = UserOptions.user_tool_options
  sharing type GuiUtils.ButtonSpec = Menus.ButtonSpec
) : TOOL_DATA =
  struct
    structure ShellTypes = ShellTypes
    structure UserContext = UserContext

    type Widget = Capi.Widget
    type ButtonSpec = Menus.ButtonSpec
    datatype Writable = WRITABLE | ALL
    type MotifContext = GuiUtils.MotifContext

    datatype current_context =
      CURRENT of
      {motif_context : MotifContext ref,
       context_register:
         ((int,
           (MotifContext -> unit)
	   * (unit -> UserOptions.user_tool_options)
	   * Writable) Map.map
          * int) ref}
  
    datatype ApplicationData =
      APPLICATIONDATA of {applicationShell : Widget, has_controlling_tty: bool}

    datatype ToolData =
      TOOLDATA of
	{args: ShellTypes.ListenerArgs,
         appdata : ApplicationData,
         current_context : current_context,
	 motif_context : MotifContext,
         tools : (string * (ToolData -> unit) * Writable) list}

    fun add_context_fn
          (CURRENT {context_register as ref (map, count), ...}, context_fn) =
      (context_register := (Map.define (map, count, context_fn), count + 1);
       count)
  
    fun remove_context_fn
          (CURRENT {context_register as ref (map, count), ...}, key) =
      context_register := (Map.undefine (map, key), count)
  
    fun set_current
          (CURRENT {motif_context, context_register = ref (map, _), ...},
           register_key,
           UserOptions.USER_TOOL_OPTIONS ({set_context, ...}, _),
           new_context) =
      if !set_context then
        let
          fun do_context (key, (f, mk_user_options, writable)) =
            if key <> register_key then
	      if writable = WRITABLE
		 andalso UserContext.is_const_context
			   (GuiUtils.get_user_context (!motif_context)) then
		()
              else
                let
                  val UserOptions.USER_TOOL_OPTIONS ({sense_context, ...}, _) =
                    mk_user_options ()
                in
                  if !sense_context then
                    f new_context
                  else
                    ()
                end
            else
              ()
        in
          motif_context := new_context;
          Map.iterate do_context map
        end
      else
        ();
  
    fun get_current (CURRENT {motif_context,  ...}) =
      !motif_context

    fun make_current motif_context =
      CURRENT
      {motif_context = ref motif_context,
       context_register = ref (Map.empty' op<, 0)}
  
    fun exit_mlworks (parent, APPLICATIONDATA {applicationShell, has_controlling_tty}) =
      Menus.exit_dialog (parent,applicationShell,has_controlling_tty)

    fun copy_args
          (ShellTypes.LISTENER_ARGS
 	     {user_context, user_options, user_preferences, prompter, mk_xinterface_fn}) =
      ShellTypes.LISTENER_ARGS
	{user_context = user_context,
	 user_options = UserOptions.copy_user_tool_options user_options,
	 user_preferences = user_preferences,
	 prompter = prompter,
	 mk_xinterface_fn = mk_xinterface_fn}

    fun copy_tooldata
	  (TOOLDATA {args, appdata, current_context, motif_context, tools}) =
      TOOLDATA {args = copy_args args, appdata = appdata,
		current_context = current_context,
		motif_context = motif_context, tools = tools}

    fun k x y = x

    (* The result of the mk_tooldata argument is data to be passed to each
       tool on creation.  It includes a list of tools to use in the menu
       itself.  The mk_tooldata argument is not applied until an
       entry is selected, so that it gets the latest shell state from a
       listener. *)
    fun tools_menu (mk_tooldata, get_user_context) =
      let 
	val tooldata = mk_tooldata ()

	val TOOLDATA {tools, appdata, ...} = tooldata
	val APPLICATIONDATA {applicationShell, ...} = appdata

	fun is_valid writable =
	  let
	    val user_context = get_user_context ()
	  in
	    not (UserContext.is_const_context user_context
		 andalso writable = WRITABLE)
	  end

        val tools_buttons =
          map
            (fn (name,toolfun,writable) =>
               Menus.PUSH (name,
			   fn _ => toolfun (copy_tooldata (mk_tooldata ())),
			   fn _ => is_valid writable))
            tools

	fun get_menu_item (w, s) = 
	   Menus.PUSH (s, fn _ => Capi.to_front w, k true)

      in

    (* The menuspec for the tools menu is different between Motif and Windows.
     * The reason for this is due to interaction between dynamic menus and storing
     * the menu references on Win32.  On Win32, the references need to be stored on
     * creation, so that they exist when invoked, but on Motif the dynamic menu items
     * are not created until they are invoked.  Solution:  on Motif, for the partially
     * dynamic tools menu to work, the whole menu is made dynamic, and on Windows, the
     * main tools need to be created first, then add the dynamic menu items below them.
     *)
	Menus.get_tools_menuspec (tools_buttons, 
				  fn _ => (map get_menu_item (Capi.get_main_windows())))
      end

    fun defPush name = (name, fn () => (), fn () => false)
    fun getPush items name default = 
      if (Lists.member (name, map (fn (s,_,_) => s) items)) then
        Lists.findp (fn (s,_,_) => (s = name)) items
      else 
	default

    fun defToggle name = (name, fn () => false, fn _ => (), fn () => false)
    fun getToggle items name default = 
      if (Lists.member (name, map (fn (s,_,_,_) => s) items)) then
        Lists.findp (fn (s,_,_,_) => (s = name)) items
      else
	default

    (* Menu item actions are changed by passing in a ButtonSpec structure including
     * the actions and sensitivity functions.  This function is used to extract
     * those actions and sensitivity functions *)

    local
      fun extractMenu (Menus.PUSH (s, act, sens)) [] = [(s, act, sens)]
        | extractMenu (Menus.PUSH (s, act, sens)) (m1 :: rest) = 
                (s, act, sens) :: extractMenu m1 rest
        | extractMenu (Menus.CASCADE (s, new_list, sens)) [] = 
		extractMenu Menus.SEPARATOR new_list
        | extractMenu (Menus.CASCADE (s, new_list, sens)) (m1 :: rest) = 
                extractMenu m1 (new_list @ rest)
        | extractMenu _ (m1 :: rest) = extractMenu m1 rest
        | extractMenu _ [] = []
    in
      fun extract (Menus.CASCADE (_, item1::rest, _)) = extractMenu item1 rest
        | extract (Menus.CASCADE (_,[],_)) = []
        | extract _ = []
    end

    val fileItems = ref []
    fun file_menu itemList = 
      let
        fun push name = Menus.PUSH
	  (getPush itemList name (getPush (!fileItems) name (defPush name)))
      in
        Menus.CASCADE ("file", 
          [push "new_proj", push "open_proj", push "save_proj", push "save_proj_as",
	   Menus.SEPARATOR,
	   push "close",
	   Menus.SEPARATOR,
	   push "setWD", push "load_proj_files", push "saveImage", 
	   Menus.SEPARATOR,
	   push "use", push "save", push "saveAs", 
	   Menus.SEPARATOR,
	   push "exit"],
	  fn _ => true)
      end

    fun set_global_file_items itemList = 
      (fileItems := itemList;
       file_menu itemList)

    val usagePushes = ref []
    val usageToggles = ref []

    fun usage_menu (pushes, toggles) = 
      let 
        fun push s = Menus.PUSH 
	  (getPush pushes s (getPush (!usagePushes) s (defPush s)))
        fun toggle s = Menus.TOGGLE 
	  (getToggle toggles s (getToggle (!usageToggles) s (defToggle s)))
      in
        Menus.CASCADE ("usage_menu", 
         [push "inspect", 
	  push "show_defn", 
	  push "duplicate",
          toggle "autoSelection",
	  Menus.SEPARATOR,
	  push "sysMessages",
          Menus.SEPARATOR,
          push "savePreferences",
          Menus.CASCADE ("general", [push "editor",
				     push "environment"], 
                          fn () => true),
          Menus.CASCADE ("tool_settings", [push "valueprinter",
                                           push "internals",
                                           push "layout",
                                           push "graph",
                                           push "insp_item",
                                           push "filterFrames",
                                           push "showFrameInfo",
                                           push "filter"],
                         fn () => false),
          Menus.SEPARATOR,
          push "search",
          push "sort",       
	  push "addBreakTrace",
          push "repeat", 
	  push "removeDuplicates",
          push "peel",
	  push "make_root",
	  push "original_root",
	  push "backtrace"], fn () => true)
      end

    fun set_global_usage_items (pushes, toggles) = 
       (usagePushes := pushes;
	usageToggles := toggles;
	usage_menu (pushes, toggles))

    fun debug_menu itemList = 
      let
        fun push s = Menus.PUSH (getPush itemList s (defPush s))
      in
        Menus.CASCADE ("debug_menu", 
         [push "abort", push "continue", push "step", push "next",
          Menus.SEPARATOR,
          push "trace", push "untrace"],
         fn () => true)
      end

    fun edit_menu
	  (widget,
	   {cut,paste,copy,delete,selection_made,edit_possible,edit_source,delete_all}) =
      let
        val (cut,can_cut) =
          case cut of
            SOME c => (c,true)
          | _ => (k (),false)

        val (paste,can_paste) =
          case paste of
            SOME p => (p,true)
          | _ => (k (),false)

        val (copy, can_copy) =
          case copy of
            SOME c => (c,true)
          | _ => (k (),false)

        val (delete,can_delete) =
          case delete of
            SOME d => (d,true)
          | _ => (k (), false)

	val es = extract (Menus.CASCADE ("dummy", edit_source, fn _ => false))
	val items = es @ 
	  (case delete_all of SOME da => [da] | NONE => [])

        fun push item = Menus.PUSH (getPush items item (defPush item))
      in
        Menus.CASCADE
        ("edit",
         [Menus.PUSH ("cut", cut,
             fn _ => can_cut andalso edit_possible () andalso selection_made()),
          Menus.PUSH ("copy", copy,
             fn _ => can_copy andalso selection_made ()),
          Menus.PUSH ("paste", paste,
             fn _ => can_paste andalso edit_possible () andalso
		     not (Capi.clipboard_empty widget)),
          Menus.PUSH ("delete", delete,
             fn _ => can_delete andalso edit_possible () andalso
		     selection_made ()),
          push "deleteAll",
          Menus.SEPARATOR,
          push "editSource"],
         k true)
      end

  end

