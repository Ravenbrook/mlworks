(*  ==== ENVIRONMENT PREFERENCES ====
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
 *  Revision Log
 *  ------------
 *  $Log: preferences.sml,v $
 *  Revision 1.11  1998/03/20 15:57:00  jont
 *  [Bug #30090]
 *  Modify to use TextIO instead of MLWorks.IO
 *
 * Revision 1.10  1997/10/23  13:19:58  johnh
 * [Bug #30233]
 * Change editor interface.
 *
 * Revision 1.9  1997/03/19  15:31:37  matthew
 * Adding use_relative_pathname preference
 *
 * Revision 1.8  1996/06/13  17:19:35  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.7  1996/05/21  16:11:58  daveb
 * Removed auto_output_window preference.
 *
 * Revision 1.6  1996/05/01  09:36:33  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.5  1996/04/09  15:22:51  daveb
 * Added remove_duplicates_from_context.
 *
 * Revision 1.4  1996/02/29  14:04:59  matthew
 * Adding function to read preferences from a file
 *
 * Revision 1.3  1995/06/14  12:47:12  daveb
 * Added use_debugger and use_error_browser preferences.
 *
 *  Revision 1.2  1995/06/01  11:26:22  daveb
 *  Moved user_preferences here from user_options.
 *
 *  Revision 1.1  1994/08/01  15:17:53  daveb
 *  new file
 *  
 *)

require "../basis/__text_io";

signature PREFERENCES =
sig
  (* Preferences are user-settable options that affect the whole environment.
     They are global.  Context-specific options and tool-specific options
     are defined in user_options.sml and options.sml.

     We could dispense with the strucutured versions of preferences and just
     pass round the record of global refs.  However, the current set-up
     keeps a clear distinction between those functions that can change the
     preferences and those that merely use them.  It also keeps our options
     open (as it were) if we decide to change our minds. *)

  datatype editor_options =
    EDITOR_OPTIONS of
      {editor : string ref,
       oneWayEditorName : string ref,
       twoWayEditorName : string ref,
       externalEditorCommand : string ref}

  val default_editor_options : editor_options

  datatype environment_options =
    ENVIRONMENT_OPTIONS of
      {window_debugger: 	bool ref,
       use_debugger: 		bool ref,
       use_error_browser: 	bool ref,
       use_relative_pathname:   bool ref,
       history_length: 		int ref,
       completion_menu:         bool ref,
       remove_duplicates_from_context:
				bool ref,
       full_menus:              bool ref}

  val default_environment_options : environment_options

  datatype preferences =
    PREFERENCES of
      {editor_options : editor_options,
       environment_options : environment_options}

  val default_preferences : preferences

  datatype user_preferences = USER_PREFERENCES of
    ({editor:                                         string ref,
      externalEditorCommand:                          string ref,
      oneWayEditorName:                               string ref,
      twoWayEditorName:                               string ref,
      history_length:                                 int ref,
      max_num_errors:                                 int ref,
      window_debugger:                                bool ref,
      use_debugger:                                   bool ref,
      use_error_browser:                              bool ref,
      use_relative_pathname:                          bool ref,
      completion_menu:                                bool ref,
      remove_duplicates_from_context:                 bool ref,
      full_menus:                                     bool ref}
     * (unit -> unit) list ref)
 
  val make_user_preferences: preferences -> user_preferences
  val new_preferences: user_preferences -> preferences

  val set_from_list : user_preferences * (string * string) list -> unit
  val save_to_stream : user_preferences * TextIO.outstream -> unit

end
