(*  ==== BASIS EXAMPLES : FileFind structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides a function that will search through directories to
 *  find all matches with a given filename or pattern.  It illustrates the
 *  OS structure in the basis library - specifically the OS.FileSys and the
 *  OS.Path structures.
 *
 *  Revision Log
 *  ------------
 *  $Log: __file_find.sml,v $
 *  Revision 1.2  1996/09/04 11:53:17  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/02  11:40:06  davids
 *  new unit
 *
 *
 *)


require "file_find";
require "__match";
require "$.system.__os";


structure FileFind : FILE_FIND =
  struct


    (* Test whether file is a directory that isn't "." or ".." or a link. *)

    fun isChildDir file =
      OS.FileSys.isDir file 
      andalso not (OS.FileSys.isLink file)
      andalso file <> "."
      andalso file <> ".."


    (* Check contents of a directory to find all files of name 'filename' *)

    fun checkDir (filename, path) =
      let
        val oldPath = OS.FileSys.getDir ()	  
        val dir = OS.FileSys.openDir path	 
	val _ = OS.FileSys.chDir path
	val fileList = checkFile (filename, dir)  
	val _ = OS.FileSys.chDir oldPath	  
	val _ = OS.FileSys.closeDir dir	
      in
        fileList
      end

    (* Check each file in directory 'dir' to see if it matches 'searchFile'.
     Check any subdirectories by a recursive call to checkDir. *)

    and checkFile (searchFile, dir) =
      case (OS.FileSys.readDir dir) of

	(* If at end of directory then return an empty list. *)
	"" => []
      | file =>
	  
	  (* If file is a child directory then it must be searched as well. *)
	  if isChildDir file then
	    checkDir (searchFile, file) @
	    checkFile (searchFile, dir) 
	  else
	  
	    (* If file matches 'searchFile, add current path to the list. *)
	    if Match.match (file, searchFile) then 
	      OS.FileSys.fullPath file :: 
	      checkFile (searchFile, dir)
	    else
	      checkFile (searchFile, dir)


    (* Search all files in the directory 'path' and its subdirectories, and
     print all occurrences that match 'filename'.  Make sure user is returned
     to original directory even if OS.SysErr has been raised. *)

    fun find (filename, path) = 
      let
	fun fileFind () =
	  let
	    val userPath = OS.FileSys.getDir ()
	    fun display path = print ("\nFile: " ^ OS.Path.file path ^ 
				      "\nDir:  " ^ OS.Path.dir path ^ "\n")
	  in 
	    app display (checkDir (filename, path))
	    handle OS.SysErr (message, error) => 
	      (print ("System error whilst searching directory " ^
		      OS.FileSys.getDir () ^ "\n" ^ message ^ "\n");
	       OS.FileSys.chDir userPath)
	  end
      in
	fileFind ()
	handle OS.SysErr _ => print ("Directory error.\n")
      end

  end


