(*  ==== MOTIF LIBRARY INTERFACE ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __xm.sml,v $
 *  Revision 1.4  1996/10/30 18:28:04  daveb
 *  Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.3  1996/05/07  16:16:27  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.2  1996/04/18  15:19:18  jont
 * initbasis moves to basis
 *
 * Revision 1.1  1995/05/05  11:40:25  matthew
 * new unit
 * New unit
 *
 *  Revision 1.4  1995/05/05  11:40:25  daveb
 *  Changed require statements to use generic module id syntax.
 *
 *  Revision 1.3  1995/04/20  19:55:37  daveb
 *  Made this depend on basis/__lists.sml instead of utils/__lists.sml.
 *
 *  Revision 1.2  1993/04/05  14:44:55  daveb
 *  Added Lists_ parameter.
 *
 *  Revision 1.1  1993/01/13  14:35:44  richard
 *  Initial revision
 *
 *)

require "^.basis.__list";
require "_xm";

structure Xm = Xm (
  structure List = List
)
