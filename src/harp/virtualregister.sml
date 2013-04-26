(*  ==== VIRTUAL REGISTER ABSTRACT TYPE ====
 *                 SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  The virtual register type supplies unique pure names for virtual
 *  registers together with an efficient implementation of monomorphic sets
 *  of virtual registers.
 *
 *  Revision Log
 *  ------------
 *  $Log: virtualregister.sml,v $
 *  Revision 1.8  1996/11/28 13:41:34  matthew
 *  [Bug #1812]
 *  Adding reset function
 *
 * Revision 1.7  1996/02/26  12:48:20  jont
 * mononewmap becomes monomap
 *
 * Revision 1.6  1994/08/15  15:41:52  matthew
 * Removed hash function
 *
 *  Revision 1.5  1992/10/29  17:27:41  jont
 *  Added Map structure for mononewmaps to allow efficient implementation
 *  of lookup tables for integer based values
 *
 *  Revision 1.4  1992/08/26  13:26:39  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.3  1992/06/01  09:42:10  richard
 *  Added register Packs.
 *
 *  Revision 1.2  1992/05/18  13:30:37  richard
 *  Added `range' function.
 *
 *  Revision 1.1  1992/03/02  14:25:28  richard
 *  Initial revision
 *
 *)


require "../utils/monoset";
require "../utils/mutablemonoset";
require "../utils/monomap";

signature VIRTUALREGISTER =
  sig

    structure Set	: MONOSET
    structure Pack      : MUTABLEMONOSET
    structure Map       : MONOMAP

    sharing Set.Text = Pack.Text

    eqtype T

    sharing type T = Set.element = Pack.element = Map.object

    val new		: unit -> T
    val reset           : unit -> unit
    val order		: T * T -> bool
    val pack		: int -> T
    val unpack		: T -> int

    val pack_set	: Set.T -> Pack.T
    val unpack_set	: Pack.T -> Set.T

    val to_string	: T -> string
    val to_text		: T -> Set.Text.T

  end


