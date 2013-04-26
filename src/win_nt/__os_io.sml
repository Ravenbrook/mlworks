(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_io.sml,v $
 * Revision 1.3  1996/11/08 14:25:32  matthew
 * Changing io_desc to iodesc
 *
 *  Revision 1.2  1996/06/14  08:55:54  stephenb
 *  Define iodesc in terms of Win32.file_desc.  This allows Win32.file_desc's
 *  (which don't hide their representation) to be used for testing purposes.
 *
 *  Revision 1.1  1996/04/23  14:50:31  stephenb
 *  new unit
 *
 *)

require "__win32";
require "_os_io";

structure OSIO_ = OSIO(structure Win32 = Win32_)
