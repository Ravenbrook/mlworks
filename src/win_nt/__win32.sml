(* Copyright (C) 1996 Harlequin Ltd.
 *
 * See ./win32.sml
 *
 * Revision Log
 * ------------
 *
 * $Log: __win32.sml,v $
 * Revision 1.1  1996/01/22 09:33:46  stephenb
 * new unit
 * OS reorganisation: The pervasive library no longer supports
 * NT specific stuff (or OS specific stuff for that matter), instead
 * it has been factored out to the Win32 structure.
 *
 *
 *)

require "_win32";

structure Win32_ = Win32();
