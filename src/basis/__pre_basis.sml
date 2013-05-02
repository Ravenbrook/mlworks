(*  ==== INITIAL BASIS : PreBasis structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
