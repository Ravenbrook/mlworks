(*  ==== GENERAL PURPOSE MAP ====
 *   ===    BALACNED TREE    ===
 *            STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __btree.sml,v $
 *  Revision 1.5  1997/01/06 14:39:02  matthew
 *  Removing commented out requires
 *
 * Revision 1.4  1994/10/05  14:39:21  matthew
 * Use 2-3 trees
 *
 *  Revision 1.3  1993/05/18  19:11:23  jont
 *  Removed integer parameter
 *
 *  Revision 1.2  1992/10/02  08:17:53  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.1  1991/12/11  14:59:40  richard
 *  Initial revision
 *
 *)

require "_b23tree";

structure BTree_ = B23Tree ();
