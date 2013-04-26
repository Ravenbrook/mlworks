(*
 * Copyright (c) 1994 Harlequin Ltd.
 * $Log: file_dialog.sml,v $
 * Revision 1.9  1998/05/21 13:50:27  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.8  1998/01/27  16:28:24  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.7.2.2  1997/09/12  14:44:13  johnh
 * [Bug #30071]
 * Implement new Project Workspace tool.
 * Allow non-existing directories to be created.
 *
 * Revision 1.7  1997/05/01  12:48:35  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.6  1996/01/12  12:37:08  daveb
 * new unit
 * Moved here from the gui directory.  Windows no longer uses this file.
 *
 * Revision 1.4  1996/01/12  11:41:42  daveb
 * Added separate open_dir_dialog function.
 *
 * Revision 1.3  1996/01/10  13:57:16  daveb
 * Added open_file_dialog and save_as_dialog, for compatibility with Windows.
 *
 * Revision 1.2  1995/12/12  17:52:04  daveb
 * Added mask and file_type arguments.
 *
 * Revision 1.1  1995/07/27  11:14:38  matthew
 * new unit
 * Moved from library
 *
 * Revision 1.1  1995/07/03  11:05:18  matthew
 * new unit
 * New unit
 *
 * Revision 1.5  1995/07/03  11:05:18  matthew
 * Removing applicationShell parameter
 *
 * Revision 1.4  1995/04/06  16:04:30  daveb
 * Added an applicationShell parameter to the file dialog creation function.
 *
 * Revision 1.2  1995/01/13  16:21:39  daveb
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.1  1994/06/30  18:00:22  daveb
 * new file
 *
 * 
 *)

signature FILE_DIALOG =
  sig
    type Widget

    val open_file_dialog : Widget * string * bool -> string list option
    val open_dir_dialog : Widget -> string option
    val set_dir_dialog : Widget -> string option
    val save_as_dialog : Widget * string -> string option
  end;
