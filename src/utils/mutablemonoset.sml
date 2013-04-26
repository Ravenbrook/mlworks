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
 *  $Log: mutablemonoset.sml,v $
 *  Revision 1.2  1992/06/03 09:55:28  richard
 *  Added copy'.
 *
 *  Revision 1.1  1992/06/01  09:41:36  richard
 *  Initial revision
 *
 *)


require "monoset";


signature MUTABLEMONOSET =
  sig
    include MONOSET

    (*  === MUTATING OPERATIONS ===
     *
     *  These have the same types as their non-mutating counterparts and
     *  should be used in the same way, except that they MAY corrupt their
     *  first argument of type T.  So, after using `difference (a,b)' do not
     *  use `a' again.  `empty' will not be updated, however.
     *
     *  The copy' function makes a new copy of an object which may be mutated
     *  independently.
     *)

    val add'		: T * element -> T
    val remove'		: T * element -> T
    val intersection'	: T * T -> T
    val union'		: T * T -> T
    val difference'	: T * T -> T
    val filter'		: (element -> bool) -> T -> T

    val copy'		: T -> T
  end
