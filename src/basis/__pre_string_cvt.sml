(*  ==== INITIAL BASIS : Unconstrinaed StringCvt structure ====
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
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __pre_string_cvt.sml,v $
 *  Revision 1.7  1999/02/17 14:38:43  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.6  1998/02/19  16:15:03  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.5  1997/03/06  16:23:03  jont
 *  [Bug #1938]
 *  Remove uses of global usafe stuff from __pre_basis
 *
 *  Revision 1.4  1997/02/20  14:09:19  matthew
 *  Adding EXACT to realfmt
 *
 *  Revision 1.3  1996/12/18  12:29:28  matthew
 *  Adding PreStringCvt structure
 *
 *  Revision 1.2  1996/10/03  14:40:54  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/06/04  15:15:47  io
 *  new unit
 *  stringcvt->string_cvt
 *
 *)
require "__pre_basis";
structure PreStringCvt = 
  struct
    datatype radix = BIN | OCT | DEC | HEX
    datatype realfmt = 
      EXACT
    | SCI of int option
    | FIX of int option
    | GEN of int option
      
    type cs = int
    type ('a,'b) reader = 'b -> ('a * 'b) option
      
    (* copy src string from indices src_x to src_y inclusive to dest_x offset in dest string *)
    fun copyFrom (src, dest, src_x, src_y, dest_x) = 
      let
        fun aux x = 
          if x <= src_y then
            (MLWorks.Internal.Value.unsafe_string_update 
             (dest, x+dest_x, MLWorks.String.ordof(src, x));
             aux (x+1))
          else
            dest
      in
        aux src_x
      end
    (* copy src char to a string at its x and y indices inclusive *)
    fun fillFrom (c:char, dest:string, dest_x:int, dest_y:int) =
      let fun aux i = 
        if i <= dest_y then
          (MLWorks.Internal.Value.unsafe_string_update (dest, i, ord c);
           aux (i+1))
        else dest
      in
        aux dest_x
      end
    fun padLeft (c:char) (i:int) (s:string) : string = 
      let
        val size = size s
        val pad = i - size
      in
        if pad > 0 then
          let val alloc_s = PreBasis.alloc_string (i+1)
          in
            ignore(fillFrom (c, alloc_s, 0, pad-1));
            ignore(copyFrom (s, alloc_s, 0, size-1, pad)); 
            alloc_s
          end
        else
          s
      end
    fun padRight (c:char) (i:int) (s:string) : string = 
      let
        val size = size s
        val pad = i - size
      in
        if pad > 0 then
          let
            val alloc_s = PreBasis.alloc_string(i+1)
          in
            ignore(copyFrom (s, alloc_s, 0, size-1, 0)); 
            ignore(fillFrom (c, alloc_s, size, i-1));
            alloc_s
          end
        else
          s
      end
    
    fun scanList f (cs:char list) = 
      let fun aux ([]:char list) = NONE
            | aux (c::cs) = SOME (c, cs)
      in
        case f aux cs of
          SOME (c,_) => SOME c
        | NONE => NONE
      end
    fun scanString f (s:string) = 
      let val size = size s
        fun aux i = 
          if i < size then
            SOME (chr(MLWorks.String.ordof(s, i)), i+1)
          else
            NONE
      in
        case f aux 0 of
          SOME (x,_) => SOME x
        | NONE => NONE
      end
    fun skipWS f s = 
      let fun aux cs = 
        case f cs of
          SOME (c, cs') =>
            if PreBasis.isSpace c then
              aux cs'
            else
              cs
        | NONE => cs
      in
        aux s
      end
    fun dropl p f src = 
      let
        fun aux cs = 
          case f cs of
            SOME (c, cs') =>
              if p c then
                aux cs'
              else
                cs
          | NONE => cs
      in
        aux src
      end
    fun splitl (p:char -> bool) f src = 
      let
        fun aux (acc, cs) = 
          case f cs of
            SOME (c, cs') => 
              if p c then
                aux (c::acc, cs')
              else
                (PreBasis.revImplode acc, cs)
          | NONE => (PreBasis.revImplode acc, cs)
      in
        aux ([], src)
      end
    fun takel p f src =
      let
        fun aux (acc, cs) = 
          case f cs of
            SOME (c, cs) => 
              if p c then 
                aux (c::acc, cs)
              else
                acc
          | NONE => acc
      in
        PreBasis.revImplode (aux ([], src))
      end
    
    fun getNChar (n:int) getc cs = 
      let 
        fun aux (i, acc, cs) =
          if i < n then
            (case getc cs of
               SOME (c, cs) => aux (i+1, c::acc, cs)
             | NONE => ([], cs))
          else
            (acc, cs)
      in
        case aux (0, [], cs) of
          ([], _) => NONE
        | (acc, cs) => SOME (rev acc, cs)
      end
    fun splitlN (n:int) (p:char -> bool) getc cs = 
      let
        fun aux (count, acc, cs) = 
          if count < n then
            (case getc cs of
               SOME (c, cs') => 
                 if p c then 
                   aux (count+1, c::acc, cs')
                 else
                   (PreBasis.revImplode acc, cs)
             | NONE => (PreBasis.revImplode acc, cs))
          else
            (PreBasis.revImplode acc, cs)
      in
        aux (0, [], cs)
      end
    fun splitlNC (n:int) (p:char -> bool) (f:char -> char)  getc cs = 
      let fun aux (count, acc, cs) = 
        if count < n then
          (case getc cs of
             SOME (c, cs') =>
               if p c then
                 aux (count+1, f c::acc, cs')
               else
                 (acc, cs)
           | NONE => (rev acc, cs))
        else
          (rev acc, cs)
      in
        aux (0, [], cs)
      end
  end (* StringCvt *)

