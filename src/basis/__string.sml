(*  ==== INITIAL BASIS : STRINGS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __string.sml,v $
 *  Revision 1.17  1999/02/17 14:40:57  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.16  1999/02/02  15:58:20  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.15  1997/08/08  14:31:01  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.14  1997/03/06  16:45:54  jont
 *  [Bug #1938]
 *  Get rid of unsafe stuff from PreBasis where possible
 *
 *  Revision 1.13  1996/12/17  16:52:29  matthew
 *  Using PreChar instead of Char
 *
 *  Revision 1.12  1996/10/03  14:23:06  io
 *  [Bug #1614]
 *  remove some redundant requires
 *
 *  Revision 1.11  1996/10/01  13:11:27  io
 *  [Bug #1626]
 *  remove option type for Char.toCString
 *
 *  Revision 1.10  1996/07/26  10:24:56  daveb
 *  Added comment describing optimisation used in extract.
 *
 *  Revision 1.9  1996/07/25  14:31:06  daveb
 *  [Bug #1497]
 *  Extract now does bound checking for the empty string.
 *
 *  Revision 1.8  1996/07/09  12:13:31  andreww
 *  rewriting to make use of expanded toplevel.
 *
 *  Revision 1.7  1996/07/02  15:19:53  io
 *  modify isPrint, fix fromCString accum bug
 *
 *  Revision 1.6  1996/06/24  20:07:13  io
 *  unconstrain Char so that scanc can be seen by other basis routines
 *
 *  Revision 1.5  1996/06/04  17:53:50  io
 *  stringcvt->string_cvt
 *
 *  Revision 1.4  1996/05/23  20:38:11  io
 *  from|toCString
 *
 *  Revision 1.3  1996/05/16  16:58:55  io
 *  fix from, to String
 *
 *  Revision 1.2  1996/05/16  14:54:11  io
 *  remove warnings
 *
 *  Revision 1.1  1996/05/16  09:39:54  io
 *  new unit
 *
 *  Revision 1.2  1996/05/13  17:50:56  io
 *  fix explode and complete toString
 *
 *  Revision 1.1  1996/05/10  16:18:45  io
 *  new unit
 *
 *)
require "__pre_basis";
require "string";
require "__pre_char";

structure String : STRING = 
  struct
    val maxSize = PreBasis.maxSize

    val char_sub = chr o MLWorks.String.ordof

    (* miscellaneous *)
    val unsafe_concatenate : string * string -> string =
      MLWorks.Internal.Runtime.environment "string concatenate"
    (* end of miscellaneous *)

    structure Char = PreChar

    type char = Char.char
    type string = string
    val size = size

    fun sub (s, i) = 
      let val size = size s in
        if i < 0 orelse i >= size then 
          raise Subscript
        else
          char_sub(s, i)
      end

    (* Top level functions *)
    val substring: string * int * int -> string = substring
    val concat: string list -> string = concat
    val str: char -> string           = str
    val explode: string -> char list  = explode
    val implode: char list -> string  = implode

    (* basis concat is aka old style implode *)

    fun compare (x:string,y) = 
      if x<y then LESS else if x>y then GREATER else EQUAL

    fun collate (comp: (char * char) -> order) ((s1,s2):string * string) 
      : order = 
      let val s1l = explode s1
        val s2l = explode s2
        fun aux ([],[]) = EQUAL
          | aux ([], _) = LESS
          | aux (_, []) = GREATER
          | aux (x::xs, y::ys) = 
          case comp (x,y) of
            EQUAL => aux (xs, ys)
          | arg => arg
      in
        aux (s1l, s2l)
      end

    fun fields (isDelimiter:char -> bool) (s:string) : string list =
      let
        val size = size s
        fun aux (i, j, acc) = 
          let val size' = i+j in
            if (size' = size) then (MLWorks.String.substring (s, i, j) :: acc)
            else if isDelimiter (char_sub(s, size')) then
              aux (size'+1, 0, MLWorks.String.substring(s, i, j)::acc)
            else aux (i, j+1, acc)
          end
      in
        rev(aux (0, 0, []))
      end

    fun tokens (p:char -> bool) "" = []
      | tokens p s = 
      let
        val size = size s
        fun mySubstring (s, i, j, acc) =
              if j = 0 then acc else MLWorks.String.substring (s, i, j) :: acc
        fun skip i =
          if i = size then i else if p (char_sub(s, i)) then skip (i+1) else i
        fun aux (i, j, acc) =
          let 
            val size' = i+j 
          in
            if (size' = size) then mySubstring (s, i, j, acc)
            else if p (char_sub (s, size')) then
              aux (skip size', 0, mySubstring(s, i, j, acc))
            else 
              aux (i, j+1, acc)
          end
      in
        rev(aux (0, 0, []))
      end

    fun isPrefix (s:string) (t:string) = 
      let 
        val size_s = size s 
      in
        if size_s > size t then false
        else 
          let fun aux i = 
            if i < size_s then 
              char_sub(s,i) = char_sub (t, i) andalso 
              aux (i+1)
            else
              true
          in
            aux 0
          end
      end

    (* The bounds checking here uses unsigned comparisons as an optimisation.
       E.g. if size_s' > i' then we know both that size_s > i and i > 0
       (this relies on the fact that size_s > 0, which it must be). *)
    fun extract (s, i, NONE) =
      let
	val size_s = size s
	val size_s' = MLWorks.Internal.Value.cast size_s : word
	val i' = MLWorks.Internal.Value.cast i : word
      in
        if size_s' < i' then
          raise Subscript
        else
          MLWorks.String.substring (s, i, size_s - i)
      end
      | extract (s, i, SOME n) = 
      let
	val size_s = size s
	val size_s' = MLWorks.Internal.Value.cast size_s : word
	val i' = MLWorks.Internal.Value.cast i : word
	val n' = MLWorks.Internal.Value.cast n : word
      in
	if size_s' < i' orelse MLWorks.Internal.Value.cast (size_s - i) < n'
        then
	  raise Subscript
        else
          MLWorks.String.substring (s, i, n)
      end

    fun map f s =
      let
        val l = size s
        val newS = MLWorks.Internal.Value.alloc_string (l+1)
        val i = ref 0
        val _ =
          while (!i<l) do(
            MLWorks.Internal.Value.unsafe_string_update
             (newS, !i, 
              ord (f (chr(MLWorks.Internal.Value.unsafe_string_sub (s,!i)))));
            i := !i + 1 )
        val _ = MLWorks.Internal.Value.unsafe_string_update (newS, l, 0)
      in
        newS
      end

    fun check_slice (s, i, SOME j) =
      if i < 0 orelse j < 0 orelse i + j > size s
        then raise Subscript
      else j
      | check_slice (s, i, NONE) =
        let
          val l = size s
        in
          if i < 0 orelse i > l
            then raise Subscript
          else l - i
        end

    fun mapi f (st, s, l) =
      let
         val l' = check_slice (st, s, l)
         val newS = MLWorks.Internal.Value.alloc_string (l' + 1)
         val i = ref 0
         val _ =
           while (!i<l') do (
             MLWorks.Internal.Value.unsafe_string_update
               (newS, !i,
                ord (f (!i + s, 
                        chr(MLWorks.Internal.Value.unsafe_string_sub(st, !i+s )
                           )
                       )
                    )
               ) ; 
             i := !i + 1)
         val _ = MLWorks.Internal.Value.unsafe_string_update (newS, l', 0)
      in
         newS
      end
    
    fun translate _ "" = ""
      | translate (p:char -> string) (s:string) : string = 
      let 
        val size = size s 
        fun aux (i, acc) = 
          if i < size then
            aux (i+1, (p (char_sub (s, i)))::acc)
          else
            concat (rev acc)
      in
        aux (0, [])
      end

    fun toString s = translate Char.toString s
      
    fun fromString s = 
        let
          val sz = size s 
          fun getc i = 
            if i < sz then
              SOME (char_sub(s, i), i+1)
            else 
              NONE
          fun aux (i, acc) =
            if i < sz then
              case Char.scan getc i of
                SOME (c, i) => 
                  aux (i, c::acc)
              | NONE => acc
            else
              acc
        in
          case aux (0, []) of
            [] => NONE
          | xs => SOME (PreBasis.revImplode xs)
        end

    fun fromCString "" = NONE
      | fromCString s = 
      let 
        val sz = size s
        fun getc i = 
          if i < sz then
            SOME (char_sub(s, i), i+1)
          else
            NONE
        fun scan (i, acc) = 
          if i < sz then
            case PreChar.scanc getc i of
              SOME (c, i) =>
                scan (i, c::acc)
            | NONE => acc
          else
            acc
      in
        case scan (0, []) of
          [] => NONE
        | xs => SOME (PreBasis.revImplode xs)
      end
      
    fun toCString s = 
      translate Char.toCString s

    fun op^(s1, s2) = 
      if size s1 + size s2 > maxSize then raise Size 
      else unsafe_concatenate (s1, s2)

    val op< : string * string -> bool = op<
    val op<= : string * string -> bool = op<=
    val op> : string * string -> bool = op>
    val op>= : string * string -> bool = op>=

  end
