(*  ==== ENVIRONMENT PREFERENCES ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: _preferences.sml,v $
 *  Revision 1.15  1998/03/20 15:58:07  jont
 *  [Bug #30090]
 *  Modify to use TextIO instead of MLWorks.IO
 *
 * Revision 1.14  1997/10/30  13:25:52  johnh
 * [Bug #30233]
 * Change editor interface.
 *
 * Revision 1.13  1997/03/19  16:50:20  matthew
 * Adding use_relative_pathname preference
 *
 * Revision 1.12  1996/11/06  11:29:00  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.11  1996/10/29  16:35:01  io
 * moving String from toplevel
 *
 * Revision 1.10  1996/06/15  16:41:21  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.9  1996/05/21  16:12:15  daveb
 * Removed auto_output_window preference.
 *
 * Revision 1.8  1996/05/01  09:38:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/04/29  14:59:55  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.6  1996/04/11  14:58:55  daveb
 * Added remove_duplicates_from_context.
 *
 * Revision 1.5  1996/02/29  14:14:15  matthew
 * Adding function to read preferences from a file
 *
 * Revision 1.4  1995/06/14  12:50:06  daveb
 * Added use_debugger and use_error_browser preferences.
 *
 *  Revision 1.3  1995/05/26  10:07:03  daveb
 *  Moved user_preferences here from user_options.
 *
 *  Revision 1.2  1994/08/02  16:37:46  daveb
 *  Added +%l arguments to default editor commands.
 *  
 *  Revision 1.1  1994/08/01  15:17:37  daveb
 *  new file
 *  
 *)

require "^.basis.__int";
require "../basis/__text_io";
require "preferences";
require "info";

functor Preferences (
  structure Info: INFO
): PREFERENCES =
struct
  datatype editor_options =
    EDITOR_OPTIONS of
      {editor : string ref,
       oneWayEditorName : string ref,
       twoWayEditorName : string ref,
       externalEditorCommand : string ref}


  val default_editor_options =
    EDITOR_OPTIONS
      {editor = ref "External",
       oneWayEditorName = ref "Vi",
       twoWayEditorName = ref "Emacs",
       externalEditorCommand = ref "xterm -name VIsual -e vi +%l %f"}

  datatype environment_options =
    ENVIRONMENT_OPTIONS of
      {history_length: 		int ref,
       window_debugger: 	bool ref,
       use_debugger: 		bool ref,
       use_error_browser : 	bool ref,
       use_relative_pathname:   bool ref,
       completion_menu:         bool ref,
       remove_duplicates_from_context:
				bool ref,
       full_menus:		bool ref}

  val default_environment_options =
    ENVIRONMENT_OPTIONS
      {window_debugger = ref true,
       use_debugger = ref true,
       use_error_browser  = ref true,
       use_relative_pathname = ref false,
       history_length = ref 20,
       completion_menu = ref true,
       remove_duplicates_from_context = ref false,
       full_menus = ref false}

  datatype preferences =
    PREFERENCES of
      {editor_options : editor_options,
       environment_options : environment_options}

  val default_preferences =
    PREFERENCES
      {editor_options = default_editor_options,
       environment_options = default_environment_options}

  datatype user_preferences = USER_PREFERENCES of
    ({editor:                                         string ref,
      externalEditorCommand:                          string ref,
      oneWayEditorName:				      string ref,
      twoWayEditorName:				      string ref,
      history_length:                                 int ref,
      max_num_errors:                                 int ref,
      window_debugger:                                bool ref,
      use_debugger:                                   bool ref,
      use_error_browser:                              bool ref,
      use_relative_pathname:                          bool ref,
      completion_menu:                                bool ref,
      remove_duplicates_from_context:		      bool ref,
      full_menus:                                     bool ref}
    * (unit -> unit) list ref)

  fun make_user_preferences
    (PREFERENCES
       {editor_options = EDITOR_OPTIONS
          {editor, externalEditorCommand, oneWayEditorName, twoWayEditorName},
        environment_options = ENVIRONMENT_OPTIONS
          {window_debugger, history_length,
           use_debugger, use_error_browser, use_relative_pathname,
           completion_menu, full_menus,
	   remove_duplicates_from_context}}) =
    USER_PREFERENCES
      ({editor                   = editor,
        externalEditorCommand    = externalEditorCommand,
        oneWayEditorName         = oneWayEditorName,
        twoWayEditorName         = twoWayEditorName,
        history_length           = history_length,
        max_num_errors           = Info.max_num_errors,
        window_debugger          = window_debugger,
        use_debugger             = use_debugger,
        use_error_browser        = use_error_browser,
        use_relative_pathname    = use_relative_pathname,
        completion_menu          = completion_menu,
        remove_duplicates_from_context = remove_duplicates_from_context,
        full_menus               = full_menus},
       ref nil)

  fun new_editor_options (USER_PREFERENCES (r, _)) =
    EDITOR_OPTIONS
      {editor = #editor r,
       externalEditorCommand = #externalEditorCommand r,
       oneWayEditorName = #oneWayEditorName r,
       twoWayEditorName = #twoWayEditorName r}

  fun new_environment_options (USER_PREFERENCES (r, _)) =
    ENVIRONMENT_OPTIONS
      {history_length = #history_length r,
       window_debugger = #window_debugger r,
       use_debugger = #use_debugger r,
       use_error_browser = #use_error_browser r,
       use_relative_pathname = #use_relative_pathname r,
       completion_menu = #completion_menu r,
       remove_duplicates_from_context = #remove_duplicates_from_context r,
       full_menus = #full_menus r}


  fun new_preferences user_preferences =
    PREFERENCES
      {editor_options    = new_editor_options user_preferences,
       environment_options = new_environment_options user_preferences }

  fun set_from_list (USER_PREFERENCES (r,_),items) =
    let
      fun do_one (component,value) =
        let
          (* Not much error checking here *)
          fun get_bool "false" = false
            | get_bool _ = true
          fun get_int s =
            let
              fun scan ([],acc) = acc
                | scan (c :: rest,acc) =
                  scan (rest, ord c - ord #"0" + (10 * acc))
            in
              scan (explode s,0)
            end
        in
          case component of
            "editor" => (#editor r) := value
          | "externalEditorCommand" => (#externalEditorCommand r) := value
          | "oneWayEditorName" => (#oneWayEditorName r) := value
          | "twoWayEditorName" => (#twoWayEditorName r) := value
          | "history_length" => (#history_length r) := get_int value
          | "max_num_errors" => (#max_num_errors r) := get_int value
          | "window_debugger" => (#window_debugger r) := get_bool value
          | "use_debugger" => (#use_debugger r) := get_bool value
          | "use_error_browser" => (#use_error_browser r) := get_bool value
          | "completion_menu" => (#completion_menu r) := get_bool value
          | "remove_duplicates_from_context" =>
	       (#remove_duplicates_from_context r) := get_bool value
          | "full_menus" => (#full_menus r)  := get_bool value
          | _ => ()
        end
    in
      app do_one items 
    end
                  
  fun save_to_stream (USER_PREFERENCES (r,_),outstream) =
    let
      fun out (component,value) = TextIO.output (outstream,component ^ " " ^ value ^ "\n")
      fun write_bool true = "true"
        | write_bool false = "false"
      val write_int = Int.toString
    in
      out ("editor", !(#editor r));
      out ("externalEditorCommand", !(#externalEditorCommand r));
      out ("oneWayEditorName", !(#oneWayEditorName r));
      out ("twoWayEditorName", !(#twoWayEditorName r));
      out ("history_length", write_int (!(#history_length r)));
      out ("max_num_errors", write_int (!(#max_num_errors r)));
      out ("window_debugger", write_bool (!(#window_debugger r)));
      out ("use_debugger", write_bool (!(#use_debugger r)));
      out ("use_error_browser", write_bool (!(#use_error_browser r)));
      out ("completion_menu", write_bool (!(#completion_menu r)));
      out ("remove_duplicates_from_context",
	   write_bool (!(#remove_duplicates_from_context r)));
      out ("full_menus", write_bool (!(#full_menus r)))
    end
end
