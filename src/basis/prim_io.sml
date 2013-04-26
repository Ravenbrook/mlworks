(*  ==== INITIAL BASIS : PRIM_IO ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: prim_io.sml,v $
 *  Revision 1.4  1996/11/08 14:32:00  matthew
 *  [Bug #1661]
 *  Changing io_desc to iodesc
 *
 *  Revision 1.3  1996/10/03  15:23:44  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/07/17  12:23:40  andreww
 *  [Bug #1453]
 *  Bringing IO up to date wrt new basis definition.
 *
 *  Revision 1.1  1996/05/20  11:28:10  jont
 *  new unit
 *
 *
 *)

require "../system/__os";

signature PRIM_IO =
  sig

    type  array
    type  vector
    type  elem
    type  pos

    val compare : (pos * pos) -> order

    datatype reader
      = RD of {
	  name : string, 
	  chunkSize : int, 
	  readVec : (int -> vector) option, 
          readArr : ({buf : array, i : int, sz : int option} -> int) option, 
	  readVecNB : (int -> vector option) option, 
	  readArrNB : ({buf : array, i : int, sz : int option} -> int option) option, 
	  block : (unit -> unit) option, 
	  canInput : (unit -> bool) option, 
          avail : unit -> int option,
	  getPos : (unit -> pos) option, 
	  setPos : (pos -> unit) option,
	  endPos : (unit -> pos) option,
          verifyPos : (unit -> pos) option,
	  close : unit -> unit, 
	  ioDesc : OS.IO.iodesc option
        }

    datatype writer
      = WR of {
	  name : string, 
	  chunkSize : int, 
	  writeVec : ({buf : vector, i : int, sz : int option} -> int) option, 
	  writeArr : ({buf : array, i : int, sz : int option} -> int) option, 
	  writeVecNB : ({buf : vector, i : int, sz : int option} -> int option) option, 
	  writeArrNB : ({buf : array, i : int, sz : int option} -> int option) option, 
	  block : (unit -> unit) option, 
	  canOutput : (unit -> bool) option, 
	  getPos : (unit -> pos) option, 
	  setPos : (pos -> unit) option, 
	  endPos : (unit -> pos) option,
          verifyPos : (unit -> pos) option,
	  close : unit -> unit,
	  ioDesc : OS.IO.iodesc option
	}

    val augmentReader : reader -> reader

    val augmentWriter : writer -> writer

  end
