(*  ==== INITIAL BASIS : TextStreamIO structure ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __text_stream_io.sml,v $
 *  Revision 1.2  1999/02/02 15:58:25  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.1  1997/02/26  16:34:25  andreww
 *  new unit
 *  [Bug #1759]
 *  __stream_io.sml --> __{bin,text}_stream_io.sml
 *
 *
 *  Revision 1.5  1997/01/15  12:04:07  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/11/16  01:57:11  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.3  1996/07/18  14:54:43  andreww
 *  [Bug #1453]
 *  Bringing up to date with naming conventions.
 *  (of filenames of modules).
 *
 *  Revision 1.2  1996/06/03  10:12:56  andreww
 *  altering require constraints.
 *
 *  Revision 1.1  1996/05/30  13:53:49  andreww
 *  new unit
 *  TextStreamIO and BinStreamIO structures.
 *
 *)

require "text_stream_io";
require "_stream_io";
require "__char_vector";
require "__char_array";
require "__char";
require "__substring";
require "__text_prim_io";


structure TextStreamIO: TEXT_STREAM_IO =
struct
  local
    structure S = StreamIO(structure PrimIO = TextPrimIO
                           structure Vector = CharVector
                           structure Array = CharArray
                           val someElem = Char.chr 0);
  in

    fun inputLine (f: S.instream) =
       let
           (* the following function returns a triple:
               (l,b,g), where l is a list of characters
                              b is value of proposition "last char is newline"
                              g is the input stream at the end
            *)

         fun loop(i,g) = case S.input1 g of
            SOME(c, g') =>
              if c = Char.chr 10 then ([c],true,g') 
              else let val (l,b,g'')= loop(i+1,g') in (c::l,b,g'') end
          | NONE => ([],false,g)

         val (l,lastCharNewline,f') = loop(0,f)
       in
         (if l<>[] andalso (not lastCharNewline)
            then implode (l@[#"\n"])
          else implode l,
          f')
       end
         

     fun outputSubstr(f:S.outstream, ss:Substring.substring) =
       S.output(f,Substring.string ss)


     open S
  end

end

  



