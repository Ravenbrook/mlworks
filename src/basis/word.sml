(* 
 * Unsigned words.
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *
 * $Log: word.sml,v $
 * Revision 1.8  1999/02/17 14:42:33  mitchell
 * [Bug #190507]
 * Modify to satisfy CM constraints.
 *
 * Revision 1.7  1997/05/27  13:15:18  jkbrook
 * [Bug #01749]
 * Changed to use __large_int for synonym structure LargeInt
 *
 * Revision 1.6  1997/01/14  17:49:01  io
 * [Bug #1757]
 * rename __preword{,32} to __pre_word{,32}
 *        __pre{integer,int32} to __pre_int{,32}
 *
 * Revision 1.5  1996/10/03  15:28:18  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.4  1996/06/04  15:59:42  io
 * stringcvt -> string_cvt
 *
 * Revision 1.3  1996/05/20  09:54:37  matthew
 * Wrong type for shift quantity
 *
 * Revision 1.2  1996/05/08  14:41:27  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:47:26  jont
 * new unit
 *
 * Revision 1.3  1996/03/28  12:00:44  matthew
 * Fixing rigid type sharing problem
 *
 * Revision 1.2  1995/09/14  13:34:15  daveb
 * Added some rather crucial sharing constraints.
 *
 * Revision 1.1  1995/09/13  14:03:07  daveb
 * new unit
 * New version of word signature.
 *
 *
 *)

require "__pre_word32";
require "__pre_word";
require "__large_int";
require "__pre_int";
require "__string_cvt";

signature WORD = 
  sig
    eqtype word

    val wordSize : int

    val toLargeWord : word -> PreLargeWord.word
    val toLargeWordX : word -> PreLargeWord.word
    val fromLargeWord : PreLargeWord.word -> word

    val toLargeInt : word -> LargeInt.int
    val toLargeIntX : word -> LargeInt.int
    val fromLargeInt : LargeInt.int -> word

    val toInt : word -> PreInt.int
    val toIntX : word -> PreInt.int
    val fromInt : PreInt.int -> word

    val orb  : word * word -> word
    val xorb : word * word -> word
    val andb : word * word -> word
    val notb : word -> word

    val <<  : word * PreWord.word -> word
    val >>  : word * PreWord.word -> word
    val ~>> : word * PreWord.word -> word

    val + : word * word -> word
    val - : word * word -> word
    val * : word * word -> word
    val div : word * word -> word
    val mod : word * word -> word

    val compare : word * word -> order

    val >  : word * word -> bool
    val >= : word * word -> bool
    val <  : word * word -> bool
    val <= : word * word -> bool

    val min : word * word -> word
    val max : word * word -> word

    val fmt : StringCvt.radix -> word -> string
    val toString : word -> string
    val fromString : string -> word option
    val scan : StringCvt.radix -> (char, 'a) StringCvt.reader -> 'a -> (word * 'a) option
  end
