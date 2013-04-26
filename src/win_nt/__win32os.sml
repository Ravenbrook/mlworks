(* Copyright (C) 1996 Harlequin Ltd.
 *
 * An interface to a misc. collection of features made available
 * on any operating system that claims to be Win32.
 *
 * Revision Log
 * ------------
 *
 *  $Log: __win32os.sml,v $
 *  Revision 1.2  1996/08/21 13:43:28  stephenb
 *  [Bug #1554]
 *  Replaces various uses of int with file_desc type.
 *
 *  Revision 1.1  1996/02/29  16:50:36  jont
 *  new unit
 *  Support for revised initial basis
 *
 *
 *)

require "_win32os";

structure Win32OS_ = Win32OS();
