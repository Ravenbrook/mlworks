(*  ==== INITIAL BASIS : MONO ARRAYS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *  
 *  Implementation
 *  --------------
 *  The functor MonoArrays is implemented genericlly using standard MLWorks
 *  arrays.
 *
 *  This is part of the extended Initial Basis.
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: _mono_array.sml,v $
 *  Revision 1.5  1999/03/20 21:27:17  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.4  1997/03/03  11:34:51  matthew
 *  Removing eqtype from elem
 *
 *  Revision 1.3  1996/05/21  11:18:35  matthew
 *  Updating.
 *
 *  Revision 1.2  1996/05/17  09:38:50  matthew
 *  Moved Bits to MLWorks.Internal.Bits
 *
 *  Revision 1.1  1996/05/15  13:04:44  jont
 *  new unit
 *
 * Revision 1.2  1996/05/07  12:03:45  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.1  1996/04/18  11:38:06  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  14:57:28  matthew
 *  Changes for new language definition
 *
 *  Revision 1.1  1995/03/22  20:23:25  brianm
 *  new unit
 *  New file.
 *
 *
 *)


require "mono_array";
require "__array";
require "_mono_vector";

functor MonoArray(type elem) : MONO_ARRAY =
  struct
    open Array
    structure Vector = MonoVector (type elem = elem)
    type vector = Vector.vector
    type elem = elem
    type array = elem array
  end
