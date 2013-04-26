(*  ==== MUTABLE MONOMORPHIC SETS ====
 *              SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This signature is a specialization of the MONOSET signature with
 *  additional functions for mutable sets.
 *
 *  Revision Log
 *  ------------
 *  $Log: mutableintset.sml,v $
 *  Revision 1.2  1996/03/28 10:34:02  matthew
 *  Adding where type clause
 *
 * Revision 1.1  1992/06/01  09:39:22  richard
 * Initial revision
 *
 *)


require "mutablemonoset";


signature MUTABLEINTSET =
  MUTABLEMONOSET where type element = int
