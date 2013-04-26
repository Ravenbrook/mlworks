(*  ==== SPECIAL PURPOSE MAP ====
 *   ===    BALANCED TREE    ===
 *            STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  $Log: __intbtree.sml,v $
 *  Revision 1.4  1997/01/06 14:40:23  matthew
 *  Removing commented out requires
 *
 * Revision 1.3  1994/10/05  13:47:26  matthew
 * Use 2-3 trees
 *
Revision 1.2  1993/05/18  19:12:02  jont
Removed integer parameter

Revision 1.1  1992/10/29  15:15:31  jont
Initial revision

 *
 *)

require "_intb23tree";

structure IntBTree_ = IntB23Tree ();
