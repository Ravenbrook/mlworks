(* Copyright (c) 1996 Harlequin Ltd.

Result: FAIL

 *
 * Test what Shell.File.loadObject does when given a non-existent file.

 * Revision Log
 * ------------
 *
 * $Log: shell_file_load_object_0.sml,v $
 * Revision 1.1  1996/04/19 14:32:47  stephenb
 * new unit
 * 
 *)

Shell.File.loadObject "nosuchfile";
