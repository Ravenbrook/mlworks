(*  ==== INTEGER SET ABSTRACT TYPE ====
 *              SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This signature describes monomorphic sets of integers with useful
 *  operations thereon.  An efficient implementation of integer sets is
 *  posssible because the special properties of integers.
 *
 *  Revision Log
 *  ------------
 *  $Log: intset.sml,v $
 *  Revision 1.6  1996/03/28 10:35:10  matthew
 *  Adding where type clause
 *
 * Revision 1.5  1992/08/04  10:32:50  jont
 * Removed unnecessary require
 *
 *  Revision 1.4  1992/05/18  13:57:54  richard
 *  Used `include' and `sharing' to specialise the MONOSET signature
 *  rather than copy it.
 *
 *  Revision 1.3  1992/05/05  10:14:24  richard
 *  Added `filter'.
 *
 *  Revision 1.2  1992/02/27  17:33:49  richard
 *  Added `equal', `subset', `reduce', and `iterate'.
 *
 *  Revision 1.1  1992/02/21  13:26:35  richard
 *  Initial revision
 *
 *)


require "monoset";

signature INTSET = MONOSET where type element = int
