(*  ==== INITIAL BASIS : unconstrained structure Char ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __pre_char.sml,v $
 *  Revision 1.18  1999/02/17 14:34:34  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.17  1998/04/15  16:20:40  mitchell
 *  [Bug #30338]
 *  Stop bouncing quote characters in fromCString
 *
 *  Revision 1.16  1997/03/10  13:43:18  jont
 *  [Bug #0]
 *  Fix contains
 *
 *  Revision 1.15  1997/03/06  16:34:51  jont
 *  [Bug #1938]
 *  Remove uses of global usafe stuff from __pre_basis
 *
 *  Revision 1.14  1996/12/18  13:07:08  matthew
 *  Use PreStringCvt instead of StringCvt
 *
 *  Revision 1.13  1996/11/06  10:48:10  matthew
 *  Renamed __integer to __int
 *
 *  Revision 1.12  1996/10/03  14:52:47  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.11  1996/10/02  17:16:48  io
 *  [Bug #1628]
 *  move is{Hex,Oct}Digit to pre_basis
 *
 *  Revision 1.10  1996/10/01  13:11:52  io
 *  [Bug #1626]
 *  remove option type in toCString
 *
 *  Revision 1.9  1996/07/01  16:33:04  io
 *  modify isPrint, fix fromCString accum bug
 *
 *  Revision 1.8  1996/06/24  20:28:32  io
 *  new unit
 *  make Char.scanc() visible
 *
 *  Revision 1.5  1996/06/04  18:54:09  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.4  1996/05/21  22:51:57  io
 *  ** No reason given. **
 *
 *  Revision 1.3  1996/05/18  00:18:34  io
 *  fromCString
 *
 *  Revision 1.2  1996/05/16  14:21:35  io
 *  fix fromString, scan
 *
 *  Revision 1.1  1996/05/15  12:42:49  jont
 *  new unit
 *
 * Revision 1.6  1996/05/15  10:27:38  io
 * further mods to fromString, scan
 *
 * Revision 1.5  1996/05/13  17:56:33  io
 * update toString
 *
 * Revision 1.4  1996/05/13  15:22:22  io
 * complete toString
 *
 * Revision 1.3  1996/05/07  21:04:48  io
 * revising...
 *
 *)
require "__pre_basis";
require "__int";
require "__pre_string_cvt";
structure PreChar = 
  struct
    (* local *)
    val makestring : char -> string = fn c=>
      let val alloc_s = PreBasis.alloc_string (1+1)
      in MLWorks.Internal.Value.unsafe_string_update(alloc_s, 0, ord c);
        alloc_s
      end
    (* end of local *)
    type char = char
    type string = string
    val chr = chr
    val ord = ord 
    (*      = ctoi *)
    val maxOrd = 255
    val minChar : char = #"\000"
    val maxChar : char = chr maxOrd
    fun succ (c:char) = 
      if c < maxChar then
        chr ((ord c) + 1)
      else
        raise Chr
    fun pred (c:char) = 
      if c > minChar then
        chr ((ord c)-1)
      else
        raise Chr
    fun compare (c:char, d:char):order = 
      if c < d then 
        LESS 
      else if c > d then 
        GREATER 
      else EQUAL
    fun contains "" = (fn _=>false)
      | contains s =
      let
	val size = size s
      in
	fn c=>
	let
	  val ord = ord c
	  fun aux i = 
	    i < size andalso
	    (MLWorks.String.ordof(s, i) = ord orelse aux(i+1))
	in
	  aux 0
	end
      end

    fun notContains "" = (fn _=>true)
      | notContains s = 
      let
	val size = size s
      in
        fn c=>
        let
	  val ord = ord c
	  fun aux i = 
	    if i < size then
	      MLWorks.String.ordof(s, i) <> ord andalso aux (i+1)
	    else
	      true
        in
          aux 0
        end
      end
    local 
      val ascii_limit = chr 127 (* DEL *)
    in
    fun isDigit c = PreBasis.isDigit c
    fun isLower c = #"a" <= c andalso c <= #"z"
    fun isUpper c = #"A" <= c andalso c <= #"Z"
    fun isAscii c = minChar <= c andalso c <= ascii_limit
    fun isAlpha c = isLower c orelse isUpper c
    fun isAlphaNum c = isDigit c orelse isAlpha c
    fun isSpace c = PreBasis.isSpace c
    fun toLower c = 
      if isUpper c then
        chr (ord c - ord #"A" + ord #"a")
      else c
    fun toUpper c = 
      if isLower c then
        chr (ord c - ord #"a" + ord #"A")
      else c
    fun isHexDigit (c:char) = PreBasis.isHexDigit c
    fun isOctDigit (c:char) = PreBasis.isOctDigit c
      
    fun isCntrl (c:char) = #"\000" <= c andalso c <= #"\031"
      
    fun isPrint1 (c:char) : bool = #"\032" <= c andalso c < ascii_limit
      
    fun isPrint (c:char) = isPrint1 c orelse
      (c >= #"\009" andalso c <= #"\013")
      
    fun isGraph (c:char) = #"\032" <  c andalso c <  ascii_limit
    fun isPunct (c:char) : bool = isGraph c andalso not (isAlphaNum c)
  end

    fun toString (c:char) : string = 
      if isCntrl c orelse c < #"\032" then
        case c of
          #"\a" => "\\a" (* Alert 7 *)
        | #"\b" => "\\b" (* Backspace 8 *)
        | #"\t" => "\\t" (* Horizontal Tab 9 *)
        | #"\n" => "\\n" (* Linefeed 10 *)
        | #"\v" => "\\v" (* Vertical Tab 11 *)
        | #"\f" => "\\f" (* Form feed 12 *)
        | #"\r" => "\\r" (* Carriage return 13 *)
        | _ => "\\^" ^ makestring (chr (ord c + ord #"@"))
      else if isPrint c then
        case c of
          #"\\" => "\\\\"
        | #"\"" => "\\\""
        | _ => makestring c
      else (* > ascii_limit and not whitespace *)
        "\\" ^ (PreStringCvt.padLeft #"0" 3  (Int.toString (ord c)))

    fun scan getc cs = 
      case getc cs of
        SOME (#"\\", cs) =>
          (case getc cs of
             SOME (#"n", cs) => SOME (#"\n", cs)
           | SOME (#"t", cs) => SOME (#"\t", cs)
           | SOME (#"\\", cs) => SOME (#"\\", cs)
           | SOME (#"\"", cs) => SOME (#"\"", cs)
           | SOME (#"a", cs) => SOME (#"\a", cs)
           | SOME (#"b", cs) => SOME (#"\b", cs)
           | SOME (#"v", cs) => SOME (#"\v", cs)
           | SOME (#"f", cs) => SOME (#"\f", cs)
           | SOME (#"r", cs) => SOME (#"\r", cs)
           | SOME (#"^", cs) => 
               (case getc cs of
                  SOME (c, cs) => 
                    if 64 <= ord c andalso ord c <= 95 then
                      SOME (chr (ord c - 64), cs)
                    else
                      NONE
                | NONE => NONE)
           | SOME (c, cs) =>
                  if isDigit c then
                    (case PreStringCvt.getNChar 2 getc cs of
                       SOME ([d, e], cs) => 
                         if isDigit d andalso isDigit e then
                           let
                             fun convert (c,d,e) = (100 * (ord c - ord #"0") + 10 * (ord d - ord #"0") + (ord e - ord #"0"))
                             val res = convert (c, d, e)
                           in
                             if 0 <= res andalso res <= maxOrd then
                               SOME (chr res, cs)
                             else
                               NONE
                           end
                         else
                           NONE
                     | _ => NONE)
                  else
                    let
                      fun dropFormat getc cs = 
                        case getc cs of
                          SOME (#"\\", cs) => scan getc cs
                        | SOME (c, cs) => 
                            if isSpace c then
                              dropFormat getc cs
                            else
                              NONE
                        | NONE => NONE
                    in
                      dropFormat getc cs
                    end
                     | NONE => NONE)
      | SOME (c, cs) => 
(*             if isCntrl c orelse c = #"\127" orelse (not (isAscii c)) then
               NONE 
             else 
               SOME (c, cs)
 *)
             if isPrint1 c then
               SOME (c, cs)
             else (* isCntrl c orelse c = #"\127" orelse not isAscii c *)
               NONE
      | NONE => NONE

      fun fromString "" = NONE
        | fromString s = PreStringCvt.scanString scan s 

      (* See A2.5.2 Character Constants in K & R *)
      fun scanc getc cs = 
        case getc cs of
          SOME (#"\\", cs) =>
            (case getc cs of
               SOME (#"n", cs) => SOME (#"\n", cs)
             | SOME (#"t", cs) => SOME (#"\t", cs)
             | SOME (#"\\", cs) => SOME (#"\\", cs)
             | SOME (#"\"", cs) => SOME (#"\"", cs)
             | SOME (#"a", cs) => SOME (#"\a", cs)
             | SOME (#"b", cs) => SOME (#"\b", cs)
             | SOME (#"v", cs) => SOME (#"\v", cs)
             | SOME (#"f", cs) => SOME (#"\f", cs)
             | SOME (#"r", cs) => SOME (#"\r", cs)
             | SOME (#"?", cs) => SOME (#"?", cs)
             | SOME (#"'", cs) => SOME (#"'", cs)
             | SOME (#"x", cs) => 
                 (case PreStringCvt.splitl isHexDigit getc cs of
                    ("", cs) => NONE
                  | (digits, cs) =>
                      (case PreStringCvt.scanString (Int.scan PreStringCvt.HEX) digits of
                         SOME hex =>
                           if 0 <= hex andalso hex <= maxOrd then 
                             SOME (chr hex, cs)
                           else
                             NONE
                       | NONE => NONE))
             | SOME (c, cs) => 
                    if isOctDigit c then
                      (case PreStringCvt.splitlN 2 isOctDigit getc cs of
                         (s, cs) => 
                          let
			    val char_sub = chr o MLWorks.String.ordof
                            fun convert s =
                              let
                                val sz = size s
                                val (c,d,e) = 
                                  if sz = 0 then (#"0", #"0", c)
                                  else if sz = 1 then (#"0", c, char_sub(s,0))
                                  else (* sz = 2 *) 
                                    (c, char_sub(s,0), char_sub(s,1))
                              in
                                (8*8*(ord c - ord #"0") + 8*(ord d - ord #"0") + (ord e - ord #"0")) 
                              end
                            val res = convert s
                          in
                            if 0 <= res andalso res <= maxOrd then
                              SOME (chr res, cs)
                            else
                              NONE
                          end)
                    else
                      NONE
              | NONE => NONE)
        | SOME (c, cs) => 
               if isCntrl c orelse c = #"\127" orelse 
                 c = #"?" orelse 
                 c = #"\"" orelse (* \" *)
                 (not (isAscii c)) then
                 NONE 
               else 
                 SOME (c, cs)
        | NONE => NONE

        
      fun fromCString "" = NONE 
        | fromCString s = PreStringCvt.scanString scanc s 

        
      fun toCString (c:char) =
        case c of
          #"\n" => "\\n"
        | #"\t" => "\\t"
        | #"\v" => "\\v"
        | #"\b" => "\\b"
        | #"\r" => "\\r"
        | #"\f" => "\\f"
        | #"\a" => "\\a"
        | #"\\" => "\\\\"
        | #"\"" => "\\\""
        | #"?" => "\\?"
        | #"'" => "\\'"
        | _  => 
          if isPrint c then
            makestring c
          else
            "\\" ^ PreStringCvt.padLeft #"0" 3 (Int.fmt PreStringCvt.OCT (ord c))


      val op < : char * char -> bool = op <
      val op <= : char * char -> bool= op <=
      val op >  : char * char -> bool= op >
      val op >= : char * char -> bool= op >=
  end

