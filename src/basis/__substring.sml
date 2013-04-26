(*  ==== INITIAL BASIS : structure SUBSTRING ===
 *
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * Description
 * -----------
 *  This is part of the extended Initial Basis. 
 *
 * $Log: __substring.sml,v $
 * Revision 1.11  1997/08/11 09:06:20  brucem
 * [Bug #30094]
 * Add span.
 *
 *  Revision 1.10  1996/10/03  15:05:46  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.9  1996/10/02  20:22:43  io
 *  [Bug #1630]
 *  fix typo in sub for raising Subscript
 *
 *  Revision 1.8  1996/07/29  23:40:36  io
 *  [Bug #1509]
 *  blotched checkin
 *
 *  Revision 1.7  1996/07/29  20:21:02  io
 *  [Bug #1509]
 *  typo in size check in isPrefix
 *
 *  Revision 1.6  1996/07/29  16:07:01  io
 *  [Bug #1508]
 *  Add structure String
 *
 *  Revision 1.5  1996/06/07  18:07:09  io
 *  fix split[lr] & position
 *
 *  Revision 1.4  1996/06/07  15:26:00  io
 *  fix tokens, fields
 *
 *  Revision 1.3  1996/06/04  17:56:57  io
 *  removing __pre_char
 *
 *  Revision 1.2  1996/05/23  20:06:22  io
 *  ** No reason given. **
 *
 *  Revision 1.1  1996/05/17  13:59:40  io
 *  new unit
 *
 *)

require "substring";
require "__string";

structure Substring : SUBSTRING =
  struct
    structure String = String
    datatype substring = SS of (string * int * int)
      (* (s, i, n) 
       * string
       * index
       * size
       *)
    fun base (SS arg) : string * int * int = arg
    fun string (SS arg) : string = substring arg
    fun concat ssl = (String.concat o (map string)) ssl

    fun substring (ok as (s, i, n)) : substring =
      if 0 <= i andalso 0 <= n andalso (i+n) <= size s then
        SS ok
      else
        raise Subscript	
    fun extract (s, i, NONE) = substring (s, i, size s - i)
      | extract (s, i, SOME n) = substring (s, i, n)

    fun all (s:string) : substring = SS (s, 0, size s)
    fun isEmpty (SS (_,_,0)) : bool = true
      | isEmpty _ = false
    fun getc (SS (_, _, 0)) : (char * substring) option = NONE
      | getc (SS (s, i, n)) = SOME ( (String.sub(s, i)), SS(s, i+1, n-1))
    fun first (SS (_, _, 0)) : char option = NONE
      | first (SS (s, i, n)) = SOME ( (String.sub (s, i)))
    fun triml (k:int) (SS (s, i, n)) : substring = 
      if (k < 0) then raise Subscript
      else if (k >= n) then SS(s, i+n, 0)
           else SS (s, i+k, n-k)
    fun trimr (k:int) (SS (s, i, n)) : substring = 
      if (k < 0) then raise Subscript
      else if (k >= n) then SS(s, i, 0)
           else SS (s, i, n-k)
    fun slice (SS (s, i, n), j, m: int option) : substring =
      let val m = case m of
        NONE => n - j
      | SOME m => m
      in
        if j >= 0 andalso 
          m >= 0 andalso
          j + m <= n then
          SS (s, i+j, m)
        else
          raise Subscript
      end
    
    fun sub (SS (s, i, n), j:int):char = 
      if j < 0 orelse j >= n then raise Subscript
      else  (String.sub (s, i + j))
	

    fun explode (SS(s, i, n)) : char list = 
      let
        fun aux (acc, j) = 
          if j < i then
            acc
          else
            aux ((String.sub (s, j))::acc, j-1)
      in
        aux ([], i+n-1)
      end

    fun foldl f acc (SS (s, i, n)) = 
      let
        fun aux (acc, i') = 
          if i' < i+n then
            aux (f (String.sub(s, i'), acc), i'+1)
          else
            acc
      in
        aux (acc, i)
      end
    fun foldr f acc (SS (s, i, n)) = 
      let
        fun aux (acc, i') = 
          if i' >= i then
            aux (f (String.sub (s, i'), acc), i'-1)
          else
            acc
      in
        aux (acc, i+n-1)
      end

    fun app (f: char -> unit) (SS (s, i, n)) : unit = 
      let
        fun aux j = 
          if j < i+n then 
            let in
              f ( (String.sub (s, j)));
              aux (j+1)
            end
          else ()
      in
        aux i
      end

    (* slow versions: needs work *)
    fun collate p (ss1, ss2) = 
      String.collate p (string ss1, string ss2)
    fun compare (ss1, ss2) = 
      String.compare (string ss1, string ss2)
      
    fun splitAt (ss as SS(s,ii,nn), j) = 
      if j < 0 orelse j > nn then
        raise Subscript
      else
        (SS (s, ii, j), SS (s, ii+j, nn-j))

    fun splitl p (ss as SS(s, ii, nn)) =
      let
        val sz = ii+nn
        fun scan j = 
          if j < sz andalso p (String.sub (s, j)) then
            scan (j+1)
          else
            j
        val res = (scan ii) - ii
      in
        splitAt (ss, res)
      end

    fun splitr p (ss as SS(s,ii,nn)) =
      let 
        val sz = ii+nn
        val exit = ii-1
        fun scan j = 
          if j > exit andalso p (String.sub (s, j)) then
            scan (j-1)
          else
            j
        val res = ((scan (sz-1)) - ii)+1
      in
        splitAt (ss, res)
      end

    fun isPrefix p (ss as SS(s, i, n)) =
      let
	val sz = size p
      in
	if sz > n then false
	else
	  let
	    fun scan i = 
	      if i < sz then
		String.sub(p, i) = sub(ss, i) andalso scan (i+1)
	      else
		true
	  in
	    scan 0
	  end
      end

    fun fields p (ss as SS(s,ii,nn)) =
      let
        val sz = ii+nn
        fun substr (i, j, acc) = SS (s, i, j-i) :: acc
        fun scan (i, j, acc) = 
          if j < sz then 
            (if p (String.sub (s, j)) then
               scan (j+1, j+1, substr(i, j, acc))
             else
               scan (i, j+1, acc))
          else
            substr (i, j, acc)
      in
        rev (scan (ii, ii, []))
      end

    fun translate p (SS(s, i, n)) = 
      let
        fun aux (acc, i') = 
          if i' < i+n then
            aux (p (String.sub(s,i'))::acc, i'+1)
          else
            String.concat (rev acc)
      in
        aux ([], i)
      end
      
    fun dropl (p:char -> bool) ss : substring = #2(splitl p ss)
    fun takel (p:char -> bool) ss : substring = #1(splitl p ss)
    fun taker (p:char -> bool) ss : substring = #2(splitr p ss)
    fun dropr (p:char -> bool) ss : substring = #1(splitr p ss)

    fun position t (ss as SS (s,ii, nn)) = 
      let
        val size = size t
        val sz = ii+nn-size

        fun compare (i, j) =
          if i < size then
            (if String.sub(t, i)=String.sub(s, j) then
               compare (i+1, j+1)
             else
               false)
          else
            true

        fun scan j =
          if j <= sz then
            (if compare (0, j) then 
               j
             else
               scan (j+1))
          else
            ii+nn
        val res = (scan ii) - ii
      in
        splitAt (ss, res)
      end
            
    fun tokens p (SS (s,ii,nn)) = 
      let
        val sz = ii+nn
        fun substr (acc, x, y) = 
          if x=y then acc else SS(s, x, y-x)::acc
        fun skipSep (acc,x) = 
          if x < sz then
            if p (String.sub (s, x)) then
              skipSep(acc, x+1)
            else
              aux (acc, x, x+1)
          else
            acc
        and aux (acc, x, y) =
          if y < sz then
            if p (String.sub (s, y)) then
              skipSep (substr(acc, x, y), y+1)
            else
              aux (acc, x, y+1)
          else
            substr (acc, x, y)
      in
        rev (aux ([], ii, ii))
      end

    fun size (SS (s,i,n)) = n

    exception Span

    fun span (SS(s1, i1, n1), SS(s2, i2, n2)) =
        if (s1 = s2) andalso (i1 <= i2+n2)
        then SS(s1, i1, i2+n2-i1)
        else raise Span

  end
