(*  This module defines functions for saving and restarting an image.
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  $Log: save_image.sml,v $
 *  Revision 1.4  1997/10/16 08:53:04  johnh
 *  [Bug #30284]
 *  Add with_fns.
 *
 *  Revision 1.3  1997/05/27  13:46:59  johnh
 *  [Bug #20033]
 *  Added show_banner for use by _podium.
 *
 *  Revision 1.2  1996/06/24  11:51:08  daveb
 *  Removed SaveImage.preference_file_name, because Getenv.get_preferences_filename
 *  now does this job.
 *
 *  Revision 1.1  1996/05/20  12:59:09  daveb
 *  new unit
 *  Separates code for saving image from where it was entangled in _shell_structure.
 *
 *
 *)

signature SAVE_IMAGE =
sig
  type ShellData

  val showBanner: unit -> bool
  val saveImage: bool * (string -> unit) -> string * bool -> unit
  (* saveImage (is_a_tty_image, handler_fn) (filename, exec);
     saves the current image in filename.  If exec is true, it saves an
     executable; otherwise it saves an image.  
     If is_a_tty_image is true, then when the image restarts it will run
     the TTY listener; otherwise it will run the GUI. *)

  val add_with_fn: (((bool * (string -> unit)) -> (string * bool) -> unit) -> (bool * (string -> unit)) -> (string * bool) -> unit) -> unit

  val startGUI: bool -> ShellData -> unit
  (* startGUI has_controlling_tty shell_data; if the GUI is not already
     running (which is recorded in the shell_data), startGUI starts the GUI,
     using the appropriate function in the shell_data. *)
end;

