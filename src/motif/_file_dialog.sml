(*
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
 *  $Log: _file_dialog.sml,v $
 *  Revision 1.38  1998/08/07 09:38:31  johnh
 *  [Bug #50096]
 *  When selecting a directory, the dialog title should be 'Directory selection dialog'.
 *
 * Revision 1.37  1998/06/01  17:23:49  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.36  1998/02/19  10:46:00  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.35  1998/01/27  16:28:02  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.34  1997/09/18  12:46:10  daveb
 * [Bug #30077]
 * Force the ScrollBarDisplayPolicy of the file list to be static, so that the
 * horizontal scrollbar is always displayed.  This is necessary for Sun's
 * implementation of Motif -- other implementations seem to get it right.
 *
 * Revision 1.33.2.2  1997/09/12  14:44:13  johnh
 * [Bug #30071]
 * Implement new Project Workspace tool.
 * Allow non-existing directories to be created.
 *
 * Revision 1.33  1997/05/02  17:17:52  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.32  1997/04/29  16:18:03  jont
 * [Bug #20024]
 * Fix saving images to files which don't exist yet.
 * Also give as good as possible warnings for other file access failures.
 * Remove all instances of silent failure where the dailog simply stays.
 *
 * Revision 1.31  1997/04/04  13:10:02  johnh
 * [Bug #2024]
 * Using OS.FileSys.isDir to check for invalid paths.
 *
 * Revision 1.30  1997/04/01  10:33:04  johnh
 * [Bug #1769]
 * Added a browse selection callback to get the selected text.
 *
 * Revision 1.29  1997/02/26  14:05:35  johnh
 * [Bug #1300]
 * Reintroduced a bug fix concerning the directory changing.
 *
 * Revision 1.28  1997/02/06  13:35:54  johnh
 * Undo last bug fixes as the Win32 equivalent fix didn't work.
 * Better to keep the functionality of the two platforms as similar as possible.
 *
 * Revision 1.26  1996/11/01  17:47:48  daveb
 * [Bug #1694]
 * Converted Xm.CompoundString.string_convert_text to standard convention.
 *
 * Revision 1.25  1996/10/09  12:02:01  io
 * moving String from toplevel
 *
 * Revision 1.24  1996/05/23  12:17:16  stephenb
 * Replace OS.FileSys.realPath with OS.FileSys.fullPath since the latter
 * now does what the former used to do.
 *
 * Revision 1.23  1996/05/17  16:09:39  daveb
 * Replaced  Os.FileSys.getDir with the string ".", added a handler for realPath
 * (needed for files that don't exist yet), and added a missing "*" to the mask.
 *
 * Revision 1.22  1996/05/01  10:34:38  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.21  1996/04/18  15:19:25  jont
 * initbasis moves to basis
 *
 * Revision 1.20  1996/04/12  08:54:55  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.19  1996/03/27  12:17:55  stephenb
 * Update in accordance with the latest revised basis.
 *
 * Revision 1.18  1996/03/15  14:37:46  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.16  1996/03/01  17:45:11  daveb
 * Removed file selection list from directory dialog.
 *
 * Revision 1.15  1996/02/26  15:24:33  matthew
 * Revisions to Xm library
 *
 * Revision 1.14  1996/01/18  10:31:10  stephenb
 * OS reorganisation: parameterise functor with UnixOS since all
 * OS specific stuff has been removed from the pervasive library.
 *
 * Revision 1.13  1996/01/12  12:16:39  daveb
 * Moved file_dialog from gui to motif.
 *
 * Revision 1.12  1996/01/12  11:50:34  daveb
 * Added separate open_dir_dialog function.
 *
 * Revision 1.11  1996/01/10  13:58:08  daveb
 * Added open_file_dialog and save_as_dialog, for compatibility with Windows.
 *
 * Revision 1.10  1995/12/13  12:16:40  daveb
 * Added mask and file_type arguments.
 *
 * Revision 1.9  1995/07/27  11:02:58  matthew
 * Moved file_dialog to gui
 *
 * Revision 1.8  1995/07/26  13:59:54  matthew
 * Restructuring gui directories
 *
 *  Revision 1.7  1995/07/03  10:53:32  matthew
 *  Capification
 *
 *  Revision 1.6  1995/05/22  15:30:47  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.5  1995/04/13  17:53:28  daveb
 *  Xm.doInput is back to taking unit.
 *  
 *  Revision 1.4  1995/04/06  15:59:59  daveb
 *  Type of Xm.doInput has changed.
 *  
 *  Revision 1.3  1995/01/16  13:56:17  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  
 *  Revision 1.2  1994/07/11  11:03:34  daveb
 *  Replaced TextString with DirSpec.
 *  
 *  Revision 1.1  1994/06/30  18:01:32  daveb
 *  new file
 *  
 *)

require "../utils/__terminal";

require "../motif/xm";
require "../main/info";
require "../basis/os";
require "../utils/__lists";

require "file_dialog";

functor FileDialog(
  structure Xm : XM
  structure Info : INFO
  structure OS : OS
) : FILE_DIALOG =
struct
  structure Location = Info.Location
  type Widget = Xm.widget

  datatype FileType = DIRECTORY | FILE 

  datatype exist = MUST_EXIST | MAY_EXIST

(* These two references store the last directory visited within the file
   selection box, and the last file system directory (ie. as set by 
   OSFileSys.chDir).  
   When the directory mask is set these references are used as follows: if
   the file system has recently changed use this new file system directory
   as the initial directory within the file selection box, otherwise use
   the last directory visited by the file selection box.  The last visited
   directory reference is only changed when the user clicks on OK. *)
  val last_visit_dir = ref "./"
  val last_filesys_dir = ref (OS.FileSys.getDir())
    handle OS.SysErr _ => ref "./"

  (* This function is copied from Capi *)
  fun send_message (parent,message) =
    let
      val dialog =
        Xm.Widget.createPopupShell ("messageDialog",
                                    Xm.Widget.DIALOG_SHELL,
                                    parent, [])
            
      val widget =
        Xm.Widget.create
        ("message", Xm.Widget.MESSAGE_BOX, dialog,
         [(Xm.MESSAGE_STRING, Xm.COMPOUND_STRING (Xm.CompoundString.createSimple message))])

      val _ =
        map 
         (fn c =>
           Xm.Widget.unmanageChild (Xm.MessageBox.getChild(widget,c)))
         [Xm.Child.CANCEL_BUTTON,
          Xm.Child.HELP_BUTTON]

      (* This really ought to reuse dialogs *)
      fun exit _ = Xm.Widget.destroy dialog
    in
      Xm.Callback.add (widget, Xm.Callback.OK, exit);
      Xm.Widget.manage widget
    end

  fun crash s =
    Info.default_error'
      (Info.FAULT,Location.UNKNOWN,s)

  fun find_files (parent, mask: string, file_type: FileType, exist, multi) =
    let
      val title = 
	case file_type of 
	  FILE      => "File Selection Dialog"
	| DIRECTORY => "Directory Selection Dialog"

      (*** Make the windows ***)
      val shell =
        Xm.Widget.createPopupShell ("fileDialog",
                                    Xm.Widget.DIALOG_SHELL,
                                    parent,
                                    [(Xm.TITLE, Xm.STRING title),
                                     (Xm.ICON_NAME, Xm.STRING title)])

      val filesys_dir = OS.FileSys.getDir()
	handle OS.SysErr _ => !last_filesys_dir

      val box = Xm.Widget.create
        ("selectionBox",
         Xm.Widget.FILE_SELECTION_BOX,
         shell, [])

      fun set_mask s =
        (Xm.Widget.valuesSet
         (box,
          [(Xm.DIR_MASK,
            Xm.COMPOUND_STRING
            (Xm.CompoundString.createSimple s))]))

      (* We now pass the complete directory in as the argument,
         so that file dialogs can be popped up in specific places. 
	 Note though that we only want the file dialog to pop up in 
	 the last visited directory when searching for files, because
	 when setting the current directory we want the file dialog
	 to initially show the current file system directory as 
	 opposed to the last visited directory. *)
      val setLastDir = (!last_filesys_dir <> filesys_dir) orelse
			((file_type = DIRECTORY) andalso (exist = MUST_EXIST))

      val _ = if setLastDir then 
	  (last_filesys_dir := filesys_dir;
	  last_visit_dir := filesys_dir;
	  set_mask(!last_filesys_dir ^ "/*" ^ mask))
	else
	  set_mask(!last_visit_dir ^ "/*" ^ mask)
      (* This used to call OS.FileSys.getDir(), but this seems to be
	 unnecessary.  If you reinstate OS.FileSys.getDir(), be sure
	 to add a handler of OS.SysErr. *)

      fun get_dir() = 
        (case Xm.Widget.valuesGet(box,[Xm.DIRECTORY]) of
           [Xm.COMPOUND_STRING filename] =>
              Xm.CompoundString.convertStringText filename
         | _ => crash "Bad values for valuesGet (get_dir)")

      val current_sel = ref NONE

      (* This pulls the selected filename out of the file selection box *)
      fun get_files () =
	if (multi) then 
	  getOpt (!current_sel, [])
	else
          (case Xm.Widget.valuesGet(box,[Xm.DIR_SPEC]) of
             [Xm.COMPOUND_STRING filename] =>
                [Xm.CompoundString.convertStringText filename]
           | _ => crash "Bad values for valuesGet (get_file)")

      (* Here we remove the Help button.  Don't remove the apply or ok buttons:
	 the behaviour of the file selection box breaks if you do. *)
      val _ =
        Xm.Widget.unmanageChild
	  (Xm.FileSelectionBox.getChild (box, Xm.Child.HELP_BUTTON))

      val _ =
	if file_type = DIRECTORY then
	  (app 
             Xm.Widget.unmanageChild
	     [Xm.Widget.parent
	        (Xm.FileSelectionBox.getChild(box,Xm.Child.LIST)),
	      Xm.FileSelectionBox.getChild(box,Xm.Child.LIST_LABEL)];
	   ())
	else if (multi) then
	  app
	    Xm.Widget.unmanageChild
	    [Xm.Widget.parent
		(Xm.FileSelectionBox.getChild(box,Xm.Child.TEXT)),
	     Xm.FileSelectionBox.getChild(box,Xm.Child.TEXT),
	     Xm.FileSelectionBox.getChild(box,Xm.Child.SELECTION_LABEL)]
	else ()

      fun filterChanged callback_data = 
	if (multi) then 
	  current_sel := NONE
	else
          let 
	    val text_w = Xm.FileSelectionBox.getChild (box, Xm.Child.TEXT)
	    val sel_text = #3 (Xm.Callback.convertList callback_data)
	  in
	    Xm.Text.setString (text_w, (Xm.CompoundString.convertStringText sel_text) ^ "/")
	  end

      fun selectionMade callback_data = 
	let 
	  val selection = 
	    map Xm.CompoundString.convertStringText (#6 (Xm.Callback.convertList callback_data))
	in
	  current_sel := SOME selection
	end

      val _ = 
	if file_type = DIRECTORY then
	  Xm.Callback.add 
	    (Xm.FileSelectionBox.getChild (box, Xm.Child.DIR_LIST),
	     Xm.Callback.BROWSE_SELECTION,
	     filterChanged)
	else if (multi) then
	  let 
	    val file_list_w = Xm.FileSelectionBox.getChild (box, Xm.Child.FILE_LIST)
	  in
	    Xm.Widget.valuesSet(file_list_w, [(Xm.SELECTION_POLICY, Xm.SELECTION_POLICY_VALUE Xm.EXTENDED_SELECT)]);
	    Xm.Callback.add
	      (Xm.FileSelectionBox.getChild (box, Xm.Child.DIR_LIST),
	       Xm.Callback.BROWSE_SELECTION,
	       fn _ => current_sel := NONE);
	    Xm.Callback.add
	      (file_list_w,
	       Xm.Callback.EXTENDED_SELECTION,
	       selectionMade)
	  end
	else ()

      val result = ref NONE
      val continue = ref true

    in
      (* Force the displayPolicy of the files list to be static, so that
       * the horizontal scroll bar is displayed correctly on Solaris.
       *)
      Xm.Widget.valuesSet
        (Xm.FileSelectionBox.getChild (box, Xm.Child.LIST),
         [(Xm.SCROLLBAR_DISPLAY_POLICY,
           Xm.SCROLLBAR_DISPLAY_POLICY_VALUE Xm.STATIC)]);
      Xm.Callback.add
        (box,
         Xm.Callback.CANCEL,
         fn _ => 
           (result := NONE;
	    continue := false;
            Xm.Widget.destroy shell));
      Xm.Callback.add
        (box,
         Xm.Callback.OK,
         fn _ => 
           let
	     val files = get_files ()
	     fun filename_ok filename =
	       ((if OS.FileSys.access(filename, []) then
		   (* The file exists, check it's correct type *)
		   case (file_type, OS.FileSys.isDir filename) of
		     (DIRECTORY, true) => true
		   | (FILE, false) => true
		   | (DIRECTORY, false) =>
		       (send_message(shell, "Directory " ^ filename ^
				     " is a file");
			false)
		   | _ =>
		       (send_message(shell, "File " ^ filename ^
				     " is a directory");
			false)
		 else
		   (* No file *)
		   case (file_type, exist) of
		     (_, MUST_EXIST) =>
		       (send_message(shell, "Path " ^ filename ^
				     " does not exist");
			false)
		   | (DIRECTORY, MAY_EXIST) =>
		       ((let 
			  val isDir = OS.FileSys.isDir filename
		        in
			  if not isDir then 
			    (send_message(shell, "Directory " ^
					  filename ^ " is a file");
			     false)
			  else 
			    true
			end)
			handle OS.SysErr _ => 
			  (OS.FileSys.mkDir filename; true))

		   | (FILE, _) =>
		       let
			 val path = OS.Path.dir filename
		       in
			 (if OS.FileSys.isDir path then
			    true
			  else
			    (send_message(shell, "Directory " ^
					  filename ^ " is a file");
			     false))
			    handle OS.SysErr _ =>
			      (send_message(shell, "Path " ^ path ^
					    " does not exist");
			       false)
		       end))
		   handle OS.SysErr _ =>
		     (send_message(shell, "Path " ^ filename ^
				   " does not exist");
		      false)
	     val ok = Lists_.forall filename_ok files
	   in
	     if ok then
		(result :=
		  SOME
		    (map OS.FileSys.fullPath files
		     handle OS.SysErr _ => files);
		     (* If the selection bos allows multiple selection this handler 
		      * is not needed as the user can not type in the selection, 
		      * otherwise this handler is needed when the file does not yet
		      * exist. *)
	        continue := false;
		last_visit_dir := get_dir();
                Xm.Widget.destroy shell)
	     else ()
	   end);
      Xm.Widget.manage box;
      Xm.Widget.manage shell;
      Xm.Widget.realize shell;
      while !continue do
        Xm.doInput ();
      !result
    end

  fun find_file (parent, mask, file_or_dir, existence) = 
    case (find_files(parent, mask, file_or_dir, existence, false)) of
      SOME [] => crash "Invalid return value from selection dialog"
    | SOME [s] => SOME s
    | SOME (a::rest) => crash "Multiple values returned from single selection box"
    | NONE => NONE

  fun open_file_dialog (parent, mask, multi) = find_files (parent, mask, FILE, MUST_EXIST, multi)
  fun open_dir_dialog parent = find_file (parent, "", DIRECTORY, MUST_EXIST)
  fun set_dir_dialog parent = find_file (parent, "", DIRECTORY, MAY_EXIST)
  fun save_as_dialog (parent, mask) = find_file (parent, mask, FILE, MAY_EXIST)
end;
