(*  ==== BASIS EXAMPLES : Roman structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This example program provides functions that can convert Roman numerals
 *  to and from integers.  It demonstrates the basic features of the String
 *  structure in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __roman.sml,v $
 *  Revision 1.3  1996/09/04 11:55:47  jont
 *  Make require statements absolute
 *
 *  Revision 1.2  1996/08/02  13:19:03  davids
 *  Removed base_ten type and associated functions.
 *
 *  Revision 1.1  1996/07/26  15:32:33  davids
 *  new unit
 *
 *)


require "roman";
require "$.basis.__string";

structure Roman : ROMAN =
  struct

    (* This type stores either the ones, tens, hundreds or thousands of a
     number. *)

    datatype numeral = I of int | X of int | C of int | M of int


    exception Numeral


    (* Convert a single digit into a character list representing the
     equivalent Roman numeral for that digit.  The parameters 'one', 'five'
     and 'ten' represent which characters should be used for the actual
     numerals, eg. #"I", #"V", #"X" for the units digit. *)

    fun digit (0, one, five, ten) = []
      | digit (1, one, five, ten) = [one]
      | digit (2, one, five, ten) = [one, one]
      | digit (3, one, five, ten) = [one, one, one]
      | digit (4, one, five, ten) = [one, five]
      | digit (5, one, five, ten) = [five]
      | digit (6, one, five, ten) = [five, one]
      | digit (7, one, five, ten) = [five, one, one]
      | digit (8, one, five, ten) = [five, one, one, one]
      | digit (9, one, five, ten) = [one, ten]
      | digit _ = []


    (* Convert an amount of a given numeral into a character list representing
     the appropriate Roman numeral.
     eg. numerals (I 9) = [#"I", #"X"] 	*)

    fun numerals (I d) = digit (d, #"I", #"V", #"X")
      | numerals (X d) = digit (d, #"X", #"L", #"C")
      | numerals (C d) = digit (d, #"C", #"D", #"M")
      | numerals (M 0) = []
      | numerals (M n) = #"M" :: numerals (M (n - 1))


    (* Give the corresponding integer value for a given Roman numeral *)

    fun value #"I" = 1
      | value #"V" = 5
      | value #"X" = 10
      | value #"L" = 50
      | value #"C" = 100
      | value #"D" = 500
      | value #"M" = 1000
      | value _    = raise Numeral


    (* Return the Roman numeral string corresponding to 'n'.  This is done
     by pulling 'n' apart into its separate digits, and working out the
     correct Roman numerals to represent each one.  These are then 
     concatenated and returned. *)

    fun intToRoman n = 
      let
	val ones = I (n mod 10)
	val tens = X ((n div 10) mod 10)
	val hundreds = C ((n div 100) mod 10)
	val thousands = M (n div 1000)
      in
	String.implode (numerals thousands @
			numerals hundreds @ 
			numerals tens @
			numerals ones)
      end
	

    (* Parse a Roman numeral string, to give an integer.  An illegal Roman
     numeral (ie. one that contains illegal characters) will give the result
     NONE.  Attempts to parse any Roman numeral string, but incorrect
     representations may give unpredictable results. *)

    fun romanToInt s = 
      let

	(* Work backwards along the string to calculate the number.  If a
	 numeral is of lesser value than the previous one then it should be
	 subtracted, otherwise it should be added.  Complete when trying to
	 look off the beginning of the string. *)

	fun addNumerals (~1, previous) = 0
	  | addNumerals (i, previous) =
	    let
	      val num = value (String.Char.toUpper (String.sub (s, i)))
	    in
	      (if num >= previous then
		 num + addNumerals (i - 1, num)
	       else
		 ~num + addNumerals (i - 1, num))
	    end
      in
        SOME (addNumerals ((String.size s) - 1, 0))
	handle Numeral => NONE
      end

  end




