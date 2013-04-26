(*  ==== INITIAL BASIS : unixtextbinio structures ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __text_prim_io.sml,v $
 *  Revision 1.6  1999/02/02 15:58:23  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.5  1998/02/19  14:28:23  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.4  1996/11/16  01:53:15  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.3  1996/07/17  17:24:57  andreww
 *  [Bug #1453]
 *  Bringing up to date wrt May 30 edition of revised basis
 *
 *  Revision 1.2  1996/06/05  14:18:18  andreww
 *  pruning requirements.
 *
 *  Revision 1.1  1996/05/30  16:03:54  andreww
 *  new unit
 *  Revised basis TextPrimIO structure.
 *
 *
 *)

require "__char_vector";
require "__char_array";
require "__char";
require "prim_io";
require "_prim_io";
require "__position";

structure TextPrimIO : PRIM_IO
                       where type array = CharArray.array
		       where type vector = CharVector.vector
		       where type elem = Char.char

                    =  PrimIO (structure A = CharArray
                               structure V = CharVector
                               val someElem = Char.chr 0
                               type pos = Position.int
                               val compare =
                                 fn (x,y) =>
                                 if Position.<(x,y) then LESS
                                 else if x=y then EQUAL
                                      else GREATER)






