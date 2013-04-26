(*  GETENV FUNCTION - UNIX VERSION
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *
 *  $Log: __getenv.sml,v $
 *  Revision 1.3  1996/01/18 09:44:26  stephenb
 *  OS reorganisation: parameterise functor with UnixOS structure.
 *
 * Revision 1.2  1995/01/13  12:24:40  daveb
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.1  1994/12/09  13:33:56  jont
 * new file
 *
 *
 *)

require "_unixgetenv";
require "__unixos";

structure Getenv_ =
  UnixGetenv (structure UnixOS = UnixOS_)
