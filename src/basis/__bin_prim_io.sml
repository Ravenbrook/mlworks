(*  ==== INITIAL BASIS : unixtextbinio structures ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __bin_prim_io.sml,v $
 *  Revision 1.4  1998/02/19 14:35:17  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.3  1997/01/15  12:03:35  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.2  1996/07/17  17:21:48  andreww
 *  [Bug #1453]
 *  Bringing up to date wrt May 30 edition of revised basis
 *
 *  Revision 1.1  1996/05/30  16:00:08  andreww
 *  new unit
 *  Revised basis BinPrimIO structure.
 *
 *
 *)

require "__word8_vector";
require "__word8_array";
require "__word8";
require "prim_io";
require "_prim_io";
require "__position";


structure BinPrimIO : PRIM_IO
                       where type array = Word8Array.array
		       where type vector= Word8Vector.vector
		       where type elem = Word8.word
		       where type pos = Position.int

                    =  PrimIO (structure A = Word8Array
                               structure V = Word8Vector
                               val someElem = 0w0 : Word8.word
                               type pos = Position.int
                               val compare = 
                                 fn (x,y) =>
                                 if  (Position.<)(x,y) then LESS
                                 else if x=y then EQUAL
                                      else GREATER)
