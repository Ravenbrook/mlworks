(*  ==== BASIS EXAMPLES : FileFind structure ====
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


