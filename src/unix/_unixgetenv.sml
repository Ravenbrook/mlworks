(*  GETENV FUNCTION - UNIX VERSIOn
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *
 *  $Log: _unixgetenv.sml,v $
 *  Revision 1.16  1998/02/10 15:42:38  jont
 *  [Bug #70065]
 *  Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.15  1997/11/05  10:51:45  johnh
 * [Bug #30125]
 * Add get_doc_dir.
 *
 * Revision 1.14  1997/03/27  13:41:02  daveb
 * [Bug #1990]
 * [Bug #1990]
 * Added get_version_setting.
 *
 * Revision 1.13  1997/03/25  09:30:31  daveb
 * [Bug #1979]
 * Changed expand_home_dir to read $HOME if $USER is not set.
 *
 * Revision 1.12  1996/10/29  12:51:02  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.11  1996/10/25  14:46:12  johnh
 * Added get_startup_dir dummy (used by Windows).
 *
 * Revision 1.10  1996/06/24  11:39:49  daveb
 * Replaced Getenv.get_home_dir with Getenv.get_startup_filename and
 * Getenv.get_preferences_filename.
 *
 * Revision 1.9  1996/05/15  10:48:51  stephenb
 * Update wrt UnixOS.SysErr -> UnixOS.Error.SysError change.
 *
 * Revision 1.8  1996/04/30  14:34:42  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/03/22  11:46:22  stephenb
 * Update wrt to Unix->SysErr exception name change.
 *
 * Revision 1.6  1996/01/18  09:44:52  stephenb
 * OS reorganisation: parameterise functor with UnixOS structure and
 * replace any reference to MLWorks.OS.Unix with UnixOS.
 *
 * Revision 1.5  1995/04/20  19:07:01  daveb
 * Added expand_home_dir.
 *
 * Revision 1.4  1995/04/19  11:02:12  jont
 * Add get_object_path
 *
 * Revision 1.3  1995/01/19  12:03:07  daveb
 * Moved functionality for parsing environment paths here from io.sml.
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.2  1995/01/18  14:12:17  jont
 * Add separator value to interface
 *
 * Revision 1.1  1994/12/09  13:36:18  jont
 * new file
 *
 *
 *)

require "../utils/getenv";
require "^.utils.__messages";
require "^.basis.__string";
require "unixos";

require "^.basis.__int";

functor UnixGetenv (structure UnixOS: UNIXOS): GETENV =
struct

  fun get_option_value option_name =
    let
      val option_length = size option_name

      fun get_value [] = NONE
      |   get_value(arg :: rest) =
        if size arg < option_length then
          get_value rest
        else if String.isPrefix option_name arg then
	  if size arg = option_length then
	    NONE
	  else
            SOME
	    (substring (arg, option_length, size arg - option_length))
	else
	  get_value rest
    in
      get_value
    end

  fun get_version_setting () =
    get_option_value "MLWORKS_VERSION=" (UnixOS.environment())

  fun get_source_path () =
    get_option_value "MLWORKS_SRC_PATH=" (UnixOS.environment())

  fun get_object_path () =
    get_option_value "MLWORKS_OBJ_PATH=" (UnixOS.environment())

  fun get_pervasive_dir () =
    get_option_value "MLWORKS_PERVASIVE=" (UnixOS.environment())

  fun get_doc_dir () = 
    get_option_value "MLWORKS_DOC=" (UnixOS.environment())

(* dummy function used by Win32 *)
  fun get_startup_dir () = NONE

  local
    fun get_home_dir () =
      get_option_value "HOME=" (UnixOS.environment())

    fun get_user_name () = 
      get_option_value "USER=" (UnixOS.environment())
  in
    fun get_startup_filename () =
      case get_home_dir () of
        NONE =>
          (Messages.output"Warning, no HOME variable set -- can't read .mlworks file\n";
	   NONE)
      | SOME dir =>
          SOME (dir ^ "/.mlworks")
  
    fun get_preferences_filename () =
      case get_home_dir () of
        NONE => NONE
      | SOME dir =>
          SOME (dir ^ "/.mlworks_preferences")

    exception BadHomeName of string

    fun expand_home_dir string =
      let
        val len = size string

        fun upto_slash n =
          if n = len then
            n
          else if String.sub (string, n) = #"/" then
            n
          else
            upto_slash (n+1)

        val expanded =
          if len = 0 orelse String.sub(string, 0) <> #"~" then
            string
          else
            let
              val start = upto_slash 0
  
              val name =
                if start = 1 then
                  get_user_name()
                else
                  SOME (substring (string, 1, start-1))
  
              val dir =
	        case name of
		  SOME str =>
                    ((case UnixOS.getpwnam str of
	                UnixOS.PASSWD {dir, ...} => dir)
                     handle UnixOS.Error.SysErr _ =>
                       raise BadHomeName ("~" ^ str))
	        | NONE =>
		    (* No USER variable; try HOME *)
                    case get_home_dir () of
                      NONE =>
		        (* Possibly need a better error message here *)
		        raise BadHomeName "~"
                    | SOME dir =>
                       dir 

              val rest = substring (string, start, len-start)
            in
              dir ^ rest
            end
      in
        expanded
      end
  end


  (* The main OS-specific element in this function is the character used to
      separate elements in the path. *)
  fun env_path_to_list s =
    let
      fun str_to_list (0, seperator_index, result) =
        substring (* could raise Substring *) (s, 0, seperator_index) :: result
      |   str_to_list (n, seperator_index, result) =
	if String.sub (s, n) = #":" then
          str_to_list
	    (n - 1, n,
             substring (* could raise Substring *) (s, n + 1, seperator_index - n - 1) :: result)
        else
          str_to_list (n - 1, seperator_index, result)
    in
      map
	expand_home_dir
        (str_to_list (size s - 1, size s, []))
    end

end
