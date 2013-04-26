(*  ==== INITIAL BASIS : PreBasis structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  For miscellaneous use
 *
 *  $Log: __pre_basis.sml,v $
 *  Revision 1.4  1997/03/06 17:50:04  jont
 *  [Bug #1938]
 *  Remove uses of global usafe stuff from __pre_basis
 *
 *  Revision 1.3  1996/10/02  17:15:27  io
 *  [Bug #1628]
 *  pull is{Oct,Hex}Digit from Char to here
 *
 *  Revision 1.2  1996/09/18  14:08:11  io
 *  [Bug #1490]
 *  update maxSize
 *
 *  Revision 1.1  1996/06/05  00:32:57  io
 *  new unit
 *
 *)
structure PreBasis = 
  struct
    val maxSize = MLWorks.String.maxLen
    (* <URI:rts/src/values.h#ML_MAX_STRING>
     * <URI:pervasive/__pervasive_library.sml#maxLen>
     *)
    local
      fun unsafe_alloc_string (n:int) : string = 
	let val alloc_s = MLWorks.Internal.Value.alloc_string n
	in
	  MLWorks.Internal.Value.unsafe_string_update(alloc_s, n-1, 0);
	  alloc_s
	end
    in
      fun alloc_string (n:int) : string =
	if n > maxSize then
	  raise Size 
	else
        unsafe_alloc_string n
    end

    local
      fun rev_map f =
	let
	  fun aux(acc, []) = acc
	    | aux(acc, x :: xs) = aux(f x :: acc, xs)
	in
	  aux
	end
    in
      fun revImplode ([]:char list) : string = ""
	| revImplode cs = MLWorks.String.implode_char (rev_map ord ([], cs))
    end

    fun isSpace c = c = #" " orelse
      c >= #"\009" andalso c <= #"\013"
    (* space, newline, tab, cr, vt, ff *)      
    fun isOctDigit c = #"0" <= c andalso c <= #"7"
    fun isDigit c = #"0" <= c andalso c <= #"9"
    fun isHexDigit c = isDigit c orelse
      (#"a" <= c andalso c <= #"f") orelse
      (#"A" <= c andalso c <= #"F")
      
  end (* PreBasis *)
