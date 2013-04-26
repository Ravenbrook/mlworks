(* Copyright (C) 1996 Harlequin Ltd.
 *
 * See ./unixos.sml
 *
 * Revision Log
 * ------------
 *
 * $Log: __unixos.sml,v $
 * Revision 1.2  1996/01/23 09:46:56  stephenb
 * Change the require to be compatible with NJSML.
 *
 *  Revision 1.1  1996/01/22  09:25:20  stephenb
 *  new unit
 *  OS reorganisation: used to be part of the pervasive library
 *  but now separated out so only UNIX platforms need support it.
 *
 *
 *)

require "../unix/_unixos";

structure UnixOS_ = UnixOS();
