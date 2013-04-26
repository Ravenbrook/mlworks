(*  ==== VIRTUAL REGISTER ABSTRACT TYPE ====
 *                 FUNCTOR
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Virtual registers are implemented as integers and an IntSet structure is
 *  used to provide the efficient set implementation.
 *
 *  Revision Log
 *  ------------
 *  $Log: _virtualregister.sml,v $
 *  Revision 1.9  1996/11/28 13:45:26  matthew
 *  [Bug #1812]
 *  Adding reset function
 *
 * Revision 1.8  1994/08/15  09:40:00  matthew
 * Removed hash function
 *
 *  Revision 1.7  1993/05/18  14:41:57  jont
 *  Removed Integer parameter
 *
 *  Revision 1.6  1992/10/29  17:26:55  jont
 *  Added Map structure for mononewmaps to allow efficient implementation
 *  of lookup tables for integer based values
 *
 *  Revision 1.5  1992/06/10  17:05:01  richard
 *  Added missing require.
 *
 *  Revision 1.4  1992/06/01  09:42:08  richard
 *  Added register Packs, making `range' obsolete.
 *
 *  Revision 1.3  1992/05/18  14:13:57  richard
 *  Added `range' function.
 *  Added `int_to_text' and `int_to_string' parameters to functor.
 *
 *  Revision 1.2  1992/03/31  14:04:54  jont
 *  Added require text
 *
 *  Revision 1.1  1992/03/02  14:27:29  richard
 *  Initial revision
 *
 *)


require "../utils/text";
require "../utils/intset";
require "../utils/mutableintset";
require "../utils/intnewmap";
require "virtualregister";


functor VirtualRegister (
  structure IntSet	: INTSET
  structure SmallIntSet : MUTABLEINTSET
  structure Map         : INTNEWMAP
  structure Text	: TEXT

  val int_to_text	: int -> Text.T
  val int_to_string	: int -> string

  sharing Text = IntSet.Text = SmallIntSet.Text

) : VIRTUALREGISTER =

  struct

    structure Text = Text
    structure Set = IntSet
    structure Map = Map
    structure Pack = SmallIntSet

    type T = int

    val source = ref 0

    fun new () = (source := !source-1; !source)
    fun reset () = source := 0

    val order = op< : int * int -> bool
    fun pack r = r
    fun unpack r = r

    fun pack_set set    = Set.reduce Pack.add' (Pack.empty, set)
    fun unpack_set pack = Pack.reduce Set.add (Set.empty, pack)

    val to_string = int_to_string
    val to_text = int_to_text

  end
