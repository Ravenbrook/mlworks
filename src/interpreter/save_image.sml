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

