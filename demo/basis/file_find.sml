(*  ==== BASIS EXAMPLES : FILE_FIND signature ====
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
 *  $Log: file_find.sml,v $
 *  Revision 1.1  1996/08/02 12:17:45  davids
 *  new unit
 *
 *
 *)


signature FILE_FIND =
  sig

    (* find (filename, path)
     Search all files in the directory 'path' and its subdirectories, and
     print all occurrences that match 'filename'.  Asterisks may be used
     as wildcards in the filename - they will match with any number of
     characters. *)

    val find : string * string -> unit

  end
