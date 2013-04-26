(*  GETENV FUNCTION - WINDOWS NT VERSIOn
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *
 *  $Log: _win_ntgetenv.sml,v $
 *  Revision 1.17  1998/07/03 12:32:17  mitchell
 *  [Bug #30434]
 *  Use Windows structure for registry access rather than Win32
 *
 * Revision 1.16  1998/02/10  15:52:48  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.15  1997/11/06  10:27:14  johnh
 * [Bug #30125]
 * Add dummy fn get_doc_dir.
 *
 * Revision 1.14  1997/03/31  14:13:49  johnh
 * [Bug #1829]
 * Removed some redundant code.
 *
 * Revision 1.13  1997/03/31  13:22:56  johnh
 * [Bug #1967]
 * Added a call to OSPath.mkCanonical.
 *
 * Revision 1.12  1997/03/31  11:02:21  daveb
 * [Bug #1990]
 * Added get_version_setting.  To prevent this printing a warning when the key
 * is not set in the registry, modified getMLWorksValue to take a fail action.
 * For existing functions, the fail action is getDefaultValue.
 *
 * Revision 1.11  1996/11/14  15:11:52  jont
 * [Bug #1763]
 * Remove get_user_name from GETENV
 *
 * Revision 1.10  1996/10/30  20:40:02  io
 * [Bug #1614]
 * remove toplevel String.
 *
 * Revision 1.9  1996/10/25  10:25:54  johnh
 * [Bug #1426]
 * Implemented Windows registry and removed redundant Win32 environment.
 *
 * Revision 1.8  1996/06/24  11:42:13  daveb
 * Replaced Getenv.get_home_dir with Getenv.get_startup_filename and
 * Getenv.get_preferences_filename.
 *
 * Revision 1.7  1996/05/01  11:56:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.6  1996/01/18  16:27:24  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, parameterise the functor with
 * the Win32 structure.
 *
 * Revision 1.5  1995/04/21  16:27:19  daveb
 * Added expand_home_dir.
 *
 * Revision 1.4  1995/04/19  11:02:56  jont
 * Add get_object_path
 *
 * Revision 1.3  1995/01/19  14:08:27  daveb
 * Moved functionality for parsing environment paths here from io.sml.
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.2  1995/01/18  14:12:45  jont
 * Add separator value to interface
 *
 * Revision 1.1  1994/12/12  16:34:15  jont
 * new file
 *
 * Revision 1.1  1994/12/09  13:36:18  jont
 * new file
 *
 *)

require "^.utils.__messages";
require "../utils/getenv";
require "^.basis.os_path";
require "windows";

functor Win_ntGetenv (structure OSPath: OS_PATH
		      structure Windows: WINDOWS): GETENV =
struct

  (* The main OS-specific element in this funciton is the character used to
      separate elements in the path. *)
  fun env_path_to_list s =
    let
      fun str_to_list (0, seperator_index, result) =
        substring (s, 0, seperator_index) :: result
      |   str_to_list (n, seperator_index, result) =
        if MLWorks.String.ordof (s, n) = ord #";" then
          str_to_list
            (n - 1, n,
             substring (s, n + 1, seperator_index - n - 1) :: result)
        else
          str_to_list (n - 1, seperator_index, result)
    in
          str_to_list (size s - 1, size s, [])
    end

  exception BadHomeName of string 

  fun expand_home_dir string = string 

  fun get_option_value option_name =
    let
      val option_length = size option_name

      fun get_value [] = NONE
      |   get_value(arg :: rest) =
        if size arg < option_length then
          get_value rest

	(* this looks like String.isPrefix to me *)
        else if substring(arg, 0, option_length) = option_name then
          if size arg - option_length = 0 then
            NONE
          else
            SOME
	      (substring(arg, option_length, size arg - option_length))
        else
          get_value rest
    in
      get_value
    end

  local
    fun close_key (SOME key) = Windows.Reg.closeKey key
      | close_key NONE = ()
    fun openKey (reg_key, reg_string) = 
	Windows.Reg.openKeyEx(reg_key, reg_string, 
                              Windows.Key.execute)
    fun warning s = Messages.output s;

    fun print_warn value_string = 
	(warning ("Software/Harlequin/MLWorks/" ^ value_string ^ 
		  " value not set in registry.\n");
	 NONE)

    fun openMLWorksKey start_key = 
      let
	val software_key = 
	  if (isSome start_key) then
	     openKey ((valOf start_key), "Software")
	  else NONE
	val harlequin_key = 
	  if (isSome software_key) then
	     openKey ((valOf software_key), "Harlequin")
	  else NONE
	val mlworks_key = 
	  if (isSome harlequin_key) then 
	     openKey ((valOf harlequin_key), "MLWorks")
	  else NONE
      in
	(software_key, mlworks_key)
      end

    fun getMLWorksValue value_string failAction = 
      let 
	val (software_key, mlworks_key) = 
          openMLWorksKey (SOME Windows.Reg.currentUser)
	val the_value = if (isSome mlworks_key) then
		Windows.Reg.queryValueEx((valOf mlworks_key), 
                                         value_string)
	   else ""
      in
	(close_key software_key;
	 if the_value = "" then 
	    (failAction value_string)
	 else 
	    SOME the_value)
      end

    fun mkCanonical (SOME s) = SOME (OSPath.mkCanonical s)
      | mkCanonical NONE = NONE

  in
    fun get_startup_dir () =
      mkCanonical (getMLWorksValue "Startup Directory" print_warn)

    fun get_source_path () =
      mkCanonical (getMLWorksValue "Source Path" print_warn)

    fun get_object_path () =
      mkCanonical (getMLWorksValue "Object Path" print_warn)

    fun get_pervasive_dir () =
      mkCanonical (getMLWorksValue "Pervasive Path" print_warn)

    fun get_version_setting () = 
      getMLWorksValue "Version Setting" (fn _ => NONE)

    fun get_doc_dir () = NONE
  end

  fun get_startup_filename () = 
    case get_startup_dir () of 
	NONE => NONE
      | SOME dir => SOME (dir ^ "/.mlworks")

  fun get_preferences_filename () =
    case get_startup_dir () of
        NONE => NONE
      | SOME dir => SOME (dir ^ "/.mlworks_preferences")

end
