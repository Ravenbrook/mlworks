(*  User-visible options.
 *
 *  Copyright (C) 1992,1993 Harlequin Ltd
 *
 *  $Log: __user_options.sml,v $
 *  Revision 1.6  1996/05/17 12:45:45  daveb
 *  Added Lists parameter.
 *  Removed obsolete Preferences parameter.
 *
 * Revision 1.5  1995/05/25  09:38:38  daveb
 * Removed Info parameter.
 *
 *  Revision 1.4  1994/08/01  08:45:09  daveb
 *  Added Preferences argument.
 *
 *  Revision 1.3  1993/12/01  15:19:23  io
 *  Added Info_
 *
 *  Revision 1.2  1993/03/05  12:01:49  matthew
 *  Structure changes
 *
 * Revision 1.1  1993/02/26  11:21:43  daveb
 * Initial revision
 * 
 *)

require "__options";
require "../utils/__lists";
require "_user_options";

structure UserOptions_ =
  UserOptions
    (structure Options = Options_
     structure Lists = Lists_);
