(* Copyright (c) 1996 Harlequin Ltd.

Result: FAIL

 *
 * Test that Shell.File.loadObject deals with duplicate loads ok.

 * Revision Log
 * ------------
 *
 * $Log: shell_file_load_object_3.sml,v $
 * Revision 1.3  1997/12/22 17:08:49  jont
 * [Bug #30323]
 * Convert to failing tests
 * These tests now fail because guib.img has pre-loaded versions of
 * these files.
 *
 *  Revision 1.2  1996/12/20  12:12:03  jont
 *  [Bug #0]
 *  Changed because test suite has moved out of src and into MLW
 *
 *  Revision 1.1  1996/06/24  11:01:04  stephenb
 *  new unit
 *
 *)

Shell.File.loadObject "../src/basis/__real";
Shell.File.loadObject "../src/basis/__real";
