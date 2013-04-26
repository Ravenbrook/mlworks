(*  ==== INITIAL BASIS : Word structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __pre_word.sml,v $
 *  Revision 1.9  1999/02/17 14:48:40  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.8  1997/01/14  17:52:45  io
 *  [Bug #1892]
 *  rename __pre{integer,int32,real,word{,32}} to
 *         __pre_{int{,32},real,word{,32}}
 *
 *  Revision 1.7  1996/10/03  14:56:28  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.6  1996/10/03  12:56:09  io
 *  [Bug #1614]
 *  update MLWorks.String
 *
 *  Revision 1.5  1996/06/04  16:05:51  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.4  1996/05/30  11:32:43  daveb
 *  ord is now at top level.
 *
 *  Revision 1.3  1996/05/13  13:17:35  matthew
 *  Use reals for reading words
 *
 *  Revision 1.2  1996/05/10  14:40:09  matthew
 *  Adding scan function
 *
 *  Revision 1.1  1996/05/08  16:15:49  matthew
 *  new unit
 *  New stuff
 *
 * Revision 1.2  1996/04/30  15:34:54  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1996/04/18  11:35:33  jont
 * new unit
 *
 *
 * Default size words (30-bit).
 *
 *)

require "__pre_word32";
require "__pre_int32";
require "__string_cvt";

structure PreWord =
  struct
    type word = word
    val wordSize = 30

    val cast = MLWorks.Internal.Value.cast

    val toInt : word -> int =
      fn w =>
      if (cast w : int) < 0 then raise Overflow
      else cast w
    val toIntX : word -> int = cast
    val fromInt : int -> word = cast

    val realmax = 256.0 * 256.0 * 256.0 * 64.0

    val toLargeWord : word -> MLWorks.Internal.Types.word32 =
      PreWord32.fromInt o cast
    val toLargeWordX : word -> MLWorks.Internal.Types.word32 =
      MLWorks.Internal.Runtime.environment "word32 extend int to word32"
    val fromLargeWord : MLWorks.Internal.Types.word32 -> word =
      MLWorks.Internal.Runtime.environment "word32 word32 to word"
    val toLargeInt : word -> MLWorks.Internal.Types.int32 = 
      cast o toLargeWord
    val toLargeIntX : word -> MLWorks.Internal.Types.int32 =
      PreLargeInt.fromInt o cast
    val fromLargeInt : MLWorks.Internal.Types.int32 -> word = 
      fromLargeWord o cast

    val fromReal : real -> word =
      MLWorks.Internal.Runtime.environment "word real to word"
    val toReal : word -> real =
      MLWorks.Internal.Runtime.environment "word word to real"
    val orb = MLWorks.Internal.Word.word_orb
    val xorb = MLWorks.Internal.Word.word_xorb
    val andb = MLWorks.Internal.Word.word_andb
    val notb = MLWorks.Internal.Word.word_notb

    fun makeString (base,n) =
      if n = 0w0 then "0"
      else
        let
          fun make_digit digit =
            if digit >= 10 then chr (ord #"A" + digit - 10)
            else chr (ord #"0" + digit)
          fun makedigits (0w0,acc) = acc
            | makedigits (n,acc) =
              let
                val digit = toInt (n mod base)
                val n' = n div base
              in 
                makedigits (n',make_digit digit :: acc)
              end
        in
          implode (makedigits (n,[]))
        end

    fun tobase StringCvt.BIN = 0w2
      | tobase StringCvt.OCT = 0w8
      | tobase StringCvt.DEC = 0w10
      | tobase StringCvt.HEX = 0w16
      
    fun fmt radix n =
      makeString (tobase radix,n)

    fun toString n = fmt StringCvt.HEX n

    fun scan radix getc src =
      let
        val base = tobase radix
        val ibase = toInt base
        val rbase = real ibase

        fun skip_prefix src =
          case getc src of
            SOME (#"0",src') =>
              (case getc src' of
                 SOME (#"w",src'') => src''
               | _ => src)
          | _ => src

        fun isDigit a =
          if ibase <= 10
            then 
              a >= ord #"0" andalso
              a < ord #"0" + ibase
          else
            (a >= ord #"0" andalso a < ord #"0" + 10) orelse
            (a >= ord #"A" andalso a < ord #"A" + ibase - 10) orelse
            (a >= ord #"a" andalso a < ord #"a" + ibase - 10)

        exception Valof
        fun valof n =
          if n >= ord #"0" andalso n <= ord #"9"
            then n - ord #"0"
          else if n >= ord #"a" andalso n <= ord #"z"
                 then n - ord #"a" + 10
          else if n >= ord #"A" andalso n <= ord #"Z"
                 then n - ord #"A" + 10
               else raise Valof

        fun convert_digits s =
          let
            fun convert ([],acc) = acc
              | convert (c :: rest,acc) =
                convert (rest,acc * rbase + real (valof c))
            val x = convert (map ord (explode s),0.0)
          in
            if x >= realmax
              then raise Overflow
            else fromReal x
          end
        val src = skip_prefix (StringCvt.skipWS getc src)
      in
        case StringCvt.splitl (isDigit o ord) getc src of
          ("",src) => NONE
        | (digits,src) => 
            SOME (convert_digits digits,src)
      end

    val fromString = StringCvt.scanString (scan StringCvt.HEX)

    val op+ = op+ : word* word -> word
    val op- = op- : word* word -> word
    val op* = op* : word* word -> word
    val op div = op div : word* word -> word
    val op mod = op mod : word* word -> word

    val << = MLWorks.Internal.Word.word_lshift
    val >> = MLWorks.Internal.Word.word_rshift
    val ~>> = MLWorks.Internal.Word.word_arshift

    val op < = op < : word * word -> bool
    val op > = op > : word * word -> bool
    val op <= = op <= : word * word -> bool
    val op >= = op >= : word * word -> bool

    fun compare (w1,w2) =
      if w1 < w2 then LESS
      else if w1 = w2 then EQUAL
      else GREATER

    fun max (a,b) = if a > b then a else b
    fun min (a,b) = if a < b then a else b

  end

