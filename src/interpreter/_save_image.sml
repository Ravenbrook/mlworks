(*  This module defines functions for saving and restarting an image.
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
 *  $Log: _save_image.sml,v $
 *  Revision 1.40  1999/05/27 10:33:21  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 *  Revision 1.39  1999/05/13  14:00:32  daveb
 *  [Bug #190553]
 *  Replaced use of basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.38  1998/07/14  09:37:27  jkbrook
 *  [Bug #30435]
 *  Remove license-prompting
 *
 *  Revision 1.37  1998/06/08  15:33:15  jkbrook
 *  [Bug #30411]
 *  Get edition info from license if present before printing banner
 *  in tty listener
 *
 *  Revision 1.36  1998/06/03  16:29:56  mitchell
 *  [Bug #70125]
 *  Zap history when saving image
 *
 *  Revision 1.35  1998/05/01  10:55:09  mitchell
 *  [Bug #50071]
 *  Close project when saving guib.img
 *
 *  Revision 1.34  1998/04/24  11:48:30  johnh
 *  [Bug #30229]
 *  Group compiler options to allow more flexibility.
 *
 *  Revision 1.33  1998/03/26  12:31:11  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.32  1998/03/18  17:13:48  mitchell
 *  [Bug #50062]
 *  Fix context browser so contents persists in saved images, and the basis appears in the initial context for guib
 *
 *  Revision 1.31  1998/02/19  19:38:29  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.30  1998/02/10  15:38:43  jont
 *  [Bug #70065]
 *  Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 *  Revision 1.29  1998/01/26  18:45:04  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 *  Revision 1.28  1997/12/10  10:38:14  johnh
 *  [Bug #30185]
 *  Source path not printed - causes main-windows to break and is also inconsistent if
 *  -source-path is specified with a different path.
 *
 *  Revision 1.27  1997/10/16  11:22:58  johnh
 *  [Bug #30284]
 *  Add with_fns.
 *
 *  Revision 1.26  1997/10/14  12:39:03  daveb
 *  [Bug #30283]
 *  Made saveImage clear the user input history before saving the image.
 *
 *  Revision 1.25  1997/10/06  18:30:49  jkbrook
 *  [Bug #30213]
 *  Legal option list printed by invalid-argument error message
 *  should be consistent with those printed by -help
 *
 *  Revision 1.24.2.3  1997/11/26  11:24:34  daveb
 *  [Bug #30071]
 *
 *  Revision 1.24.2.2  1997/11/20  16:58:37  daveb
 *  [Bug #30326]
 *
 *  Revision 1.24.2.1  1997/09/11  20:54:23  daveb
 *  branched from trunk for label MLWorks_workspace_97
 *
 *  Revision 1.24  1997/05/27  13:48:29  johnh
 *  [Bug #20033]
 *  Added -no-banner option.
 *
 *  Revision 1.23  1997/05/12  16:31:00  jont
 *  [Bug #20050]
 *  main/io now exports MLWORKS_IO
 *
 *  Revision 1.22  1997/04/29  15:11:48  matthew
 *  [Bug #20028]
 *  Enlarging scope of with_standard_streams
 *
 *  Revision 1.21  1997/04/24  17:10:48  jont
 *  [Bug #20016]
 *  Fix typo in usage message
 *
 *  Revision 1.20  1997/04/24  16:56:57  jont
 *  [Bug #20016]
 *  Document -silent in usage message
 *
 *  Revision 1.19  1997/03/27  14:48:18  daveb
 *  [Bug #1990]
 *  Version.version_string is now Version.versionString, and a function instead
 *  of a constant.
 *
 *  Revision 1.18  1997/03/24  16:23:40  daveb
 *  [Bug #1966]
 *  Unset update functions for user context options and user preferences before
 *  saving the image, so that the image doesn't access non-existent windows when
 *  it restarts.
 *
 *  Revision 1.17  1997/03/20  17:33:34  matthew
 *  Moved read_dot_mlworks
 *
 *  Revision 1.16  1996/12/19  14:42:23  jont
 *  [Bug #1852]
 *  Include help info that -mono must be first arg
 *
 *  Revision 1.15  1996/11/06  12:03:25  daveb
 *  Revised licensing scheme to allow registration-style licensing.
 *
 *  Revision 1.14  1996/10/30  15:17:18  io
 *  [Bug #1614]
 *  removing toplevel String.
 *
 *  Revision 1.13  1996/10/17  12:54:52  jont
 *  Add license server stuff
 *
 *  Revision 1.12.2.2  1996/10/08  12:21:20  jont
 *  Add call to initialise license
 *
 *  Revision 1.12.2.1  1996/10/07  16:06:06  hope
 *  branched from 1.12
 *
 *  Revision 1.12  1996/09/04  13:31:11  daveb
 *  [Bug #1587]
 *  save_image now expands its filename argument.
 *
 *  Revision 1.11  1996/09/04  10:48:42  jont
 *  [Bug #1393]
 *  Add -mono to help message
 *
 *  Revision 1.10  1996/08/06  09:16:10  stephenb
 *  Replace any use of OldOs.mtime that ignores the time with
 *  with OS.FileSys.access.
 *
 *  Revision 1.9  1996/07/22  09:30:03  jont
 *  Fix problem where -no-init was interpreted as -tty and vice versa.
 *
 *  Revision 1.8  1996/07/19  14:30:12  jont
 *  Add control of compilation message printing
 *
 *  Revision 1.7  1996/07/12  09:54:53  jont
 *  Sort out problems with bad environment variable settings
 *
 *  Revision 1.6  1996/07/11  12:04:36  jont
 *  Add a no-init command line option to prevent spurious reading of .mlworks
 *  and .mlworks_preferences for situations such as the test suite
 *
 *  Revision 1.5  1996/07/03  13:38:30  daveb
 *  Bug 1448/Support Call 35: Added remove_file_info to project and incremental,
 *  and called it from _save_image.
 *
 *  Revision 1.4  1996/06/24  11:32:10  daveb
 *  Replaced Getenv.get_home_dir with Getenv.get_startup_filename and
 *  Getenv.get_preferences_filename.
 *
 *  Revision 1.3  1996/05/30  13:19:46  daveb
 *  The Interrupt exception is no longer at top level.
 *
 *  Revision 1.2  1996/05/22  12:59:19  daveb
 *  Combined the Debugging and Variable Info modes.
 *
 *  Revision 1.1  1996/05/20  15:43:20  daveb
 *  new unit
 *  Separates code for saving image from where it was entangled in _shell_structure.
 *
 *
 *)


require "../basis/list";
require "../utils/mlworks_exit";
require "../utils/getenv";
require "../basis/os";
require "../basis/__text_io";
require "^.utils.__messages";
require "shell_types";
require "user_context";
require "shell_utils";
require "incremental";
require "../main/info";
require "../main/version";
require "../main/mlworks_io";
require "../main/user_options";
require "../main/preferences";
require "../main/proj_file";
require "save_image";

functor SaveImage
  (structure Info : INFO
   structure Io : MLWORKS_IO
   structure Getenv : GETENV
   structure OS : OS
   structure Preferences : PREFERENCES
   structure UserOptions : USER_OPTIONS
   structure UserContext : USER_CONTEXT
   structure ShellTypes : SHELL_TYPES
   structure Exit : MLWORKS_EXIT
   structure Version : VERSION
   structure ShellUtils : SHELL_UTILS
   structure Incremental : INCREMENTAL
   structure List : LIST
   structure ProjFile : PROJ_FILE

   sharing UserOptions.Options = UserContext.Options = ShellTypes.Options
   sharing type ShellUtils.ShellData = ShellTypes.ShellData
   sharing type Preferences.preferences = UserContext.preferences
   sharing type UserOptions.user_context_options =
                UserContext.user_context_options
   sharing type UserContext.user_context = ShellTypes.user_context
   sharing type UserOptions.user_tool_options = ShellTypes.user_options
   sharing type UserContext.Context = ShellTypes.Context
   sharing type Preferences.user_preferences = ShellTypes.user_preferences
   sharing type Io.Location = Info.Location.T
  ): SAVE_IMAGE =
struct
  type ShellData = ShellTypes.ShellData

  (* with_no_update_functions sets the update function lists of the User
     Context and the User Preferences to empty lists.  If this were not
     done, attempts to set options in a .mlworks file would cause the
     functions to try to update windows that no longer exist, and MLWorks
     would crash.  The Tool Context doesn't need to be cleared in this
     way, as it is always copied when a new tool is created, and so the
     update functions are specific to each tool. *)
  fun with_no_update_functions shell_data f x =
    let
      val UserOptions.USER_CONTEXT_OPTIONS(_, update_ref1) =
        UserContext.get_user_options (ShellTypes.get_user_context shell_data)
      val Preferences.USER_PREFERENCES (_, update_ref2) =
        ShellTypes.get_user_preferences shell_data
      val old_option_fns = !update_ref1
      val old_preference_fns = !update_ref2
      val _ = update_ref1 := [];
      val _ = update_ref2 := []

      val result =
	f x
	handle exn =>
	  (update_ref1 := old_option_fns;
	   update_ref2 := old_preference_fns;
	   raise exn)
    in
      update_ref1 := old_option_fns;
      update_ref2 := old_preference_fns;
      result
    end

  fun update_print_messages(shell_data, b) =
    let
      val UserOptions.USER_CONTEXT_OPTIONS({print_messages, ...}, _) =
        UserContext.get_user_options (ShellTypes.get_user_context shell_data)
    in
      print_messages := b
    end

  fun select_optimizing shell_data =
    let
      val user_context_options =
        UserContext.get_user_options (ShellTypes.get_user_context shell_data)
    in
      UserOptions.select_optimizing user_context_options
    end

  fun select_debugging shell_data =
    let
      val user_context_options =
        UserContext.get_user_options (ShellTypes.get_user_context shell_data)
    in
      UserOptions.select_debugging user_context_options
    end

  fun set_user_preference (f, shell_data) =
    let val Preferences.USER_PREFERENCES (user_preferences, _) =
      ShellTypes.get_user_preferences shell_data
    in
      (f user_preferences) := true
    end

  fun clear_user_preference (f, shell_data) =
    let val Preferences.USER_PREFERENCES (user_preferences, _) =
      ShellTypes.get_user_preferences shell_data
    in
      (f user_preferences) := false
    end


  fun get_mk_xinterface_fn (ShellTypes.SHELL_DATA{mk_xinterface_fn,...}) =
    mk_xinterface_fn

  fun get_x_running (ShellTypes.SHELL_DATA{x_running,...}) = x_running

  val gui_message = "The MLWorks GUI is already running\n"

  fun startGUI has_controlling_tty shell_data =
    if get_x_running shell_data then
      print gui_message
    else
      (get_mk_xinterface_fn shell_data)
      (ShellTypes.get_listener_args shell_data)
      has_controlling_tty

  (* Use the standard streams *)

  fun with_standard_streams f =
    let
      val oldIO = MLWorks.Internal.StandardIO.currentIO()
      val _ = MLWorks.Internal.StandardIO.resetIO();
      val result = (f() handle exn =>
		    (MLWorks.Internal.StandardIO.redirectIO oldIO; raise exn))
    in
      MLWorks.Internal.StandardIO.redirectIO oldIO;
      result
    end

  fun get_mk_tty_listener (ShellTypes.SHELL_DATA{mk_tty_listener,...}) =
    mk_tty_listener

  (*
   * I don't understand why the following uses OS.FileSys.access
   * (previously OldOs.mtime) to determine if the file exists and
   * then calls TextIO.openIn to open the file.  Currently
   * an exception is raised if there is any problem reading the
   * file, but no warning is given if the file cannot be opened!
   * Also the one call to set_preferences doesn't seem to catch
   * the Io exeption - stephenb
   *)
  fun set_preferences (_, false) = ()
    | set_preferences (shell_data as ShellTypes.SHELL_DATA{user_preferences, ...}, _) =
      case Getenv.get_preferences_filename () of
        NONE => ()
      | SOME pathname =>
          if OS.FileSys.access (pathname, []) handle OS.SysErr _ => false then
            let
              val user_options =
                UserContext.get_user_options
                (ShellTypes.get_user_context shell_data)

              val instream = TextIO.openIn pathname
              (* XXXEXCEPTION: should handle Io exception -- unlikely but possible *)

              fun parse2 ([],acc) = implode (rev acc)
                | parse2 (#"\n" ::rest,acc) = implode (rev acc)
                | parse2 (a::rest,acc) = parse2 (rest,a::acc)

              fun parse1 ([],acc) = (implode (rev acc),"")
                | parse1 (#" " ::rest,acc) =
                  (implode (rev acc),parse2 (rest,[]))
                | parse1 (a::rest,acc) = parse1 (rest,a::acc)

              fun loop acc =
                let
                  val line = TextIO.inputLine instream
                in
                  if line = "" then rev acc
                  else loop (parse1 (explode line,[])::acc)
                end

              val items = loop []
                handle
                exn =>
                  (TextIO.closeIn instream;
                   raise exn)
            in
              TextIO.closeIn instream;
              Preferences.set_from_list (user_preferences,items);
              UserOptions.set_from_list (user_options,items)
            end
          else
            ()

  val show_banner = ref true
  fun showBanner () = !show_banner

  local
    fun message s =
    (Messages.output s;
     Messages.output"\n")

    val usage =
" Usage:  mlworks [options]\n" ^
" Options:\n" ^
"   -gui  Start the MLWorks Graphical User Interface directly.  This is the\n" ^
"    default.\n" ^
"   -tty    Start MLWorks in text mode.\n" ^
(*
"   -short-menus\n" ^
"           When running the motif interface, hide advanced and experimental\n" ^
"           features.  This is the default.\n" ^
"   -full-menus\n" ^
"           When running the motif interface, make all features of the interface\n" ^
"           available, including advanced and experimental features.\n" ^
*)
"   -debug-mode\n" ^
"           Start MLWorks with debugging mode on.\n" ^
"   -optimize-mode\n" ^
"           Start MLWorks with optimizing mode on.\n" ^
"   -no-init\n" ^
"           Ignore any .mlworks or .mlworks_preferences files.\n" ^
"   -mono\n" ^
"           Attempt to start for a monochrome display (motif only)\n" ^
"   -silent\n" ^
"           Turn off printing of messages about using, loading or\n" ^
"           compiling files.  Also suppresses the MLWorks prompt.\n" ^
"   -stack n\n" ^
"           Set initial maximum number of stack blocks to n.\n" ^
"   -help   Display this message and exit."
    (* Argument parsing.  The second parameter is the current set of
       arguments, which is modified as the list is traversed. *)
    fun parse set_state (shell_data, arguments) =
      let
        fun parse' ([], r) = r
          | parse' ("-tty" :: t, (_, init)) = parse' (t, (true, init))
          | parse' ("-gui" :: t, (_, init)) = parse' (t, (false, init))
          | parse' ("-no-init" :: t, (tty, _)) = parse' (t, (tty, false))
          | parse' ("-full-menus" :: t, r) =
            (if set_state then
               set_user_preference (#full_menus, shell_data)
             else
               ();
               parse' (t, r))
          | parse' ("-short-menus" :: t, r) =
            (if set_state then
               clear_user_preference (#full_menus, shell_data)
             else
               ();
               parse' (t, r))
          | parse' ("-debug-mode" :: t, r) =
            (if set_state then
               select_debugging shell_data
             else
               ();
               parse' (t, r))
          | parse' ("-optimize-mode" :: t, r) =
            (if set_state then
               select_optimizing shell_data
             else
               ();
               parse' (t, r))
          | parse'("-source-path" :: path :: rest, r) =
            (if set_state then
               Io.set_source_path_from_string
               (path, Info.Location.FILE "Command Line")
             else
               ();
               parse'(rest, r))
          | parse'("-object-path" :: path :: rest, r) =
            (if set_state then
               Io.set_object_path(path, Info.Location.FILE "Command Line")
             else
               ();
               parse'(rest, r))
          | parse'("-pervasive-dir" :: dir :: rest, r) =
            (if set_state then
               Io.set_pervasive_dir (dir, Info.Location.FILE "Command Line")
             else
               ();
               parse'(rest, r))
          | parse'("-silent" :: t, r) =
            (if set_state then
               update_print_messages(shell_data, false)
             else
               ();
               parse'(t, r))
          | parse'("-verbose" :: t, r) =
            (if set_state then
               update_print_messages(shell_data, true)
             else
               ();
               parse'(t, r))
          | parse' ("-help" :: _, r) =
            (message usage;
             ignore(Exit.exit Exit.failure);
             (false, false) (* dummy value *))
	  | parse' ("-no-banner" :: t, r) =
	    (show_banner := false;
	     parse'(t,r))	
          | parse' (s :: t, r) =
            (message
             ("Invalid argument " ^ s ^ ".\n" ^
              "Valid arguments are: -tty -gui -debug-mode -optimize-mode -no-init -mono -silent -stack n -help.");
             ignore(Exit.exit Exit.failure);
             (false, false) (* dummy value *))
      in
        parse'(arguments, (false, true))
      end

    fun make_new_shell_data
      (ShellTypes.SHELL_DATA
       {get_user_context,
        user_options,
        user_preferences,
        prompter,
        debugger,
        profiler,
        exit_fn,
        x_running,
        mk_xinterface_fn,
        mk_tty_listener}) =
      ShellTypes.SHELL_DATA
      {get_user_context = get_user_context,
       user_options = user_options,
       user_preferences = user_preferences,
       prompter = prompter,
       debugger = debugger,
       profiler = profiler,
       exit_fn = exit_fn,
       x_running = false,
       mk_xinterface_fn = mk_xinterface_fn,
       mk_tty_listener = mk_tty_listener}

    fun make_no_prompter_shell_data
      (ShellTypes.SHELL_DATA
       {get_user_context,
        user_options,
        user_preferences,
        prompter,
        debugger,
        profiler,
        exit_fn,
        x_running,
        mk_xinterface_fn,
        mk_tty_listener}) =
      ShellTypes.SHELL_DATA
      {get_user_context = get_user_context,
       user_options = user_options,
       user_preferences = user_preferences,
       prompter = fn _ => "",
       debugger = debugger,
       profiler = profiler,
       exit_fn = exit_fn,
       x_running = false,
       mk_xinterface_fn = mk_xinterface_fn,
       mk_tty_listener = mk_tty_listener}


    fun main (is_a_tty_image, arguments) =
      let
        val shell_data = make_new_shell_data (!ShellTypes.shell_data_ref)

        (* Set things from env *)

	val silent = List.exists (fn "-silent" => true | _ => false) arguments

        val _ =
          let
	    (* Don't print the default source path as this causes main-windows
	     * to break and also will be inconsistent with an user-specified
	     * source path (ie. specified from the command line.
	     *)
            val _ = Io.set_source_path_from_env
              ((Info.Location.FILE "<Initialisation code>"), true)

            val _ = Io.set_pervasive_dir_from_env
              (Info.Location.FILE "<Initialisation code>")
          in
            ()
          end
        handle Info.Stop _ => Exit.exit Exit.failure

        (* Set the preferences before reading the command line args *)
        (* The fact that the option refs modified by this call to
         set_preferences and the option refs modified by parse are in
         fact _one and the same_ is obscure but true (as of now)
         *)

        val (_, init) = parse false (shell_data, arguments)

        val _ = set_preferences(shell_data, init)
        (* XXXEXCEPTION: should handle Io *)

        (* Parse arguments.  Default is gui.  This may override some env stuff *)
        val (tty, _) = parse true (shell_data, arguments)
        val tty = tty orelse is_a_tty_image

	val shell_data =
	  if silent andalso tty then
	    make_no_prompter_shell_data shell_data
	  else
	    shell_data

        val _ =
	  if init then
	    let
	      val ShellTypes.SHELL_DATA {get_user_context,
					 user_options,
					 user_preferences,
					 debugger,
					 ...} = shell_data
	      val error_info = Info.make_default_options ()
	    in
	      ShellUtils.read_dot_mlworks shell_data
	    end
	  else ()

        val _ = ShellTypes.shell_data_ref := shell_data

        val mk_tty_listener = get_mk_tty_listener shell_data

        val listener_args = ShellTypes.get_listener_args shell_data
      in
        if tty then
          (if showBanner() then message (Version.versionString ()) else ();
           mk_tty_listener listener_args)
        else
          (startGUI false shell_data;
           0  (* exit status *))
      end
    handle
    (* Handle eg. interrupts during starting interface *)
    MLWorks.Interrupt => 0

  in
    fun saveImage' (is_a_tty_image, handler_fn) (filename, do_exec_save) =
      let

	val expanded_file =
	  Getenv.expand_home_dir filename

	val save_fn =
          if do_exec_save then
            MLWorks.Internal.execSave
          else
            MLWorks.Internal.save

	fun restart () =
           with_standard_streams
           (fn () => main (is_a_tty_image, MLWorks.arguments ()))

	val shell_data as
	      ShellTypes.SHELL_DATA {get_user_context, ...} =
		!ShellTypes.shell_data_ref

        (* This is just a temporary crude mechanism for detecting when we
           are saving guib.img *)
        fun saving_guib() =
            let val size = size(filename)
             in substring(filename, size - 8, 8) = "guib.img"
                andalso ((size = 8)
                         orelse let val c = substring(filename, size - 9, 1)
                                 in (c = "/" orelse c = "\\") end)
            end
            handle _ => false

      in
	Incremental.remove_file_info ();

        if (saving_guib())        
        then
          (print"Saving guib.img\n";
           UserContext.move_context_history_to_system(get_user_context());
           ProjFile.close_proj())
        else ();

        ignore(
          with_no_update_functions
            shell_data
            (UserContext.with_null_history (get_user_context ()) save_fn)
            (expanded_file, restart))
      end
      handle
        MLWorks.Internal.Save msg => handler_fn msg
      | Getenv.BadHomeName s =>
	  handler_fn ("Invalid home name: " ^ s)

    val save_image_fn = ref saveImage'

    fun add_with_fn withFn =
      let val new_save_fn = withFn (!save_image_fn)
      in
	save_image_fn := new_save_fn
      end

    fun saveImage arg1 arg2 =
      let val save_image = (!save_image_fn)
      in
	save_image_fn := saveImage';
	save_image arg1 arg2 handle exn => (save_image_fn := save_image; raise exn);
	save_image_fn := save_image
      end

  end

end

