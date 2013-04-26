(*  ==== INITIAL BASIS : MONO VECTORS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  The functor MonoVectors is implemented generically using standard
 *  MLWorks vectors.
 *
 *  This is part of the extended Initial Basis.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: _mono_vector.sml,v $
 *  Revision 1.4  1997/03/03 11:38:44  matthew
 *  Removing eq attribute from elem
 *
 *  Revision 1.3  1996/05/21  11:16:48  matthew
 *  Updating
 *
 *  Revision 1.2  1996/05/17  09:39:07  matthew
 *  Moved Bits to MLWorks.Internal.Bits
 *
 *  Revision 1.1  1996/05/15  13:06:27  jont
 *  new unit
 *
 * Revision 1.2  1996/05/07  12:04:50  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.1  1996/04/18  11:38:12  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  14:58:20  matthew
 *  Changes for language revision
 *
 *  Revision 1.1  1995/03/22  20:23:51  brianm
 *  new unit
 *  New file.
 *
 *
 *)


require "mono_vector";
require "__vector";

functor MonoVector (type elem) : MONO_VECTOR =
   struct
     open Vector
     type elem = elem
     type vector = elem vector
   end

