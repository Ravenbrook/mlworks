(*  === INTEGER MAP ===
 *           SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  A map is a general purpose partial function from some domain to some
 *  range, or, if you prefer, a look-up table.  For the sake of efficiency a
 *  complete order must be provided when constructing a map.
 *
 *  Notes
 *  -----
 *  This signature is intended to have more than one implementation, using
 *  association lists, balanced trees, arrays, etc.  I want to keep the
 *  signature simple and self-contained.
 *
 *  $Log: intnewmap.sml,v $
 *  Revision 1.3  1996/03/27 16:44:03  matthew
 *  Updating for new language definition
 *
 * Revision 1.2  1996/02/26  12:47:32  jont
 * mononewmap becomes monomap
 *
 * Revision 1.1  1992/10/29  14:52:19  jont
 * Initial revision
 *
 *)

require "monomap";

signature INTNEWMAP =
  sig
    include MONOMAP
  end
  where type object = int
