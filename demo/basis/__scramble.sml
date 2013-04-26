(*  ==== BASIS EXAMPLES : Scramble structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module illustrates some of the lower level binary IO features provided
 *  by the basis library.  It defines functions to scramble and unscramble
 *  files into a different order.  It demonstrates the BinIO structure,
 *  in particular the underlying functional streams used in the BinIO.StreamIO
 *  structure.  It also demonstrates the use of the BinPrimIO, Position and
 *  Word8Array structures.
 *
 *  Revision Log
 *  ------------
 *  $Log: __scramble.sml,v $
 *  Revision 1.4  1997/01/15 15:51:58  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.3  1996/09/04  11:56:11  jont
 *  Make require statements absolute
 *
 *  Revision 1.2  1996/08/12  16:03:57  davids
 *  ** No reason given. **
 *
 *  Revision 1.1  1996/08/08  10:39:22  davids
 *  new unit
 *
 *
 *)


require "scramble";
require "$.basis.__position";
require "$.basis.__bin_prim_io";
require "$.basis.__bin_io";
require "$.basis.__io";
require "$.basis.__word8_array";
require "$.basis.__word8_vector";
require "$.basis.__word8";

structure Scramble : SCRAMBLE =
  struct

    (* Indicates that the primitive IO does not support required functions. *)
    exception Prim


    (* A Word8Vector representing the empty buffer. *)
    val emptyBuf = Word8Vector.fromList []


    (* Find the underlying reader of the instream 'strm', and perform 
     primitive level IO to jump to position 'pos'.  Then rebuild the
     instream at this point, setting the buffer to empty. *) 

    fun jumpTo (strm, pos) =
      let
	(* Pull the setPos function out of the primitive reader. *)
	val (rdr as BinPrimIO.RD {setPos = setPos, ...}, _) = 
	  BinIO.StreamIO.getReader strm
      in
	case setPos of
	  NONE => raise Prim
	| SOME doSetPos => 
	    (doSetPos pos;
	     BinIO.StreamIO.mkInstream (rdr, emptyBuf))
      end
	 

    (* Find the underlying reader of the instream 'strm', and perform
     primitive level IO to retrieve the length of the file as a Position.int.
     Then rebuild the stream at the original point, and return this along
     with the file size. *)

    fun getSize strm =
      let
	(* Pull the endPos function out of the primitive reader. *)
        val (rdr as BinPrimIO.RD {endPos = endPos, ...}, buf) = 
	  BinIO.StreamIO.getReader strm

	(* Calling getReader truncates the original stream, so rebuild it. *)
	val rebuiltStrm = BinIO.StreamIO.mkInstream (rdr, buf)
      in
	case endPos of
	  NONE => raise Prim
	| SOME getEndPos => (getEndPos (), rebuiltStrm)
      end


    (* Convert a permutation function 'f' from one that takes integers and
     returns integers to one that takes positions and returns positions. *)

    fun toPosFn f size n = 
      Position.fromInt (f (Position.toInt size) (Position.toInt n))


    (* Apply the permutation function 'f' to the instream 'instrm', reordering
     the stream into the outstream 'outstrm'.  This is done here by working
     one by one through the bytes to be outputted, and jumping about through
     'instrm' in order to find the correct byte to output at that point.  Note
     that this is normally a very inefficient way to perform binary IO. *)

    fun scrambleStream (f, instrm, outstrm, outPos, size) =
      if BinPrimIO.compare (outPos, size) <> LESS then
	()
      else
	let 
	  val jumpPos = f size outPos
	  val newInstrm = jumpTo (instrm, jumpPos)
	in
	  case BinIO.StreamIO.input1 newInstrm of
	    NONE => raise Subscript
	  | SOME (byte, _) => 
	      (BinIO.StreamIO.output1 (outstrm, byte);
	       scrambleStream (f, newInstrm, outstrm, 
			       Position.+ (outPos, 1), size))
	end


    (* Opens both 'inFile' and 'outFile' and converts them into their
     underlying functional streams 'instrm' and 'outstrm' respectively. 
     Then scramble 'instrm' into 'outstrm' using f. *)

    fun scramble f (inFile, outFile) =
      let
	val instrm = BinIO.getInstream (BinIO.openIn inFile)
	val outstrm = BinIO.getOutstream (BinIO.openOut outFile)
	val (size, instrm) = getSize instrm
      in
	(scrambleStream (toPosFn f, instrm, outstrm, Position.fromInt 0, size);
	 print "File scrambled.\n";
	 BinIO.StreamIO.closeIn instrm;
	 BinIO.StreamIO.closeOut outstrm)
      end
    handle IO.Io _ => print "File error.\n"
	 | Prim => print "Primitive IO does not support required functions.\n"
	 | Subscript => print "Permutation function out of range.\n"


    (* Output the Word8Array 'arr' to 'strm'. *)

    fun outputArray (strm, arr) =
      let
	val vec = Word8Array.extract (arr, 0, NONE)
      in
	BinIO.StreamIO.output (strm, vec)
      end


    (* Use the permutation function 'f' to permute the instream 'instrm' into
     the outstream 'outstrm'.  This is done here by filling up a buffer with
     the appropriate positions for the elements of 'instrm'.  When 'instrm' 
     has been read through completely, this is then output to 'outstrm'.  
     Note that this function inverts the effect of scrambleStream - but by
     a completely different technique. *)

    fun unscrambleStream (f, instrm, outstrm, i, size, buffer) =
      case BinIO.StreamIO.input1 instrm of
	NONE => outputArray (outstrm, buffer)
      | SOME (byte, nextStrm) => 
	  (Word8Array.update (buffer, f size i, byte);
	   unscrambleStream (f, nextStrm, outstrm, i + 1, size, buffer))
 

    (* Opens both 'inFile' and 'outFile' and converts them into their
     underlying functional streams 'instrm' and 'outstrm' respectively. 
     Then unscramble 'instrm' into 'outstrm' using f. *)

    fun unscramble f (inFile, outFile) =
      let
	val instrm = BinIO.getInstream (BinIO.openIn inFile)
	val outstrm = BinIO.getOutstream (BinIO.openOut outFile)
	val (sizePos, instrm) = getSize instrm
	val size = Position.toInt sizePos
	val newBuffer = Word8Array.array (size, Word8.fromInt 0)
      in
	(unscrambleStream (f, instrm, outstrm, 0, size, newBuffer);
	 print "File unscrambled.\n";
	 BinIO.StreamIO.closeIn instrm;
	 BinIO.StreamIO.closeOut outstrm)
      end
    handle IO.Io _ => print "File error.\n"
	 | Prim => print "Primitive IO does not support required functions.\n"
	 | Subscript => print "Permutation function out of range.\n"
	 | Size => print "File too large.\n"


    (* A permutation function that will rotate to the right by 'k' bytes. *)

    fun rotate (k : int) =
      fn size => fn m => (m + k) mod size


    (* A permutation function that will reverse elements. *)

    val reverse =
      fn size => fn m => size - m - 1


    (* A permutation function that will perform a perfect shuffle. *)

    val shuffle	=
      fn size => fn m =>
      let
	val split = (size + 1) div 2
      in
	if m < split then
	  m * 2
	else
	  (m - split) * 2 + 1
      end


    (* The number of shuffles that 'mix' does is in this arbitrary range. *)
    val minShuffles = 3
    val maxShuffles = 10


    (* This permutation function mixes up the elements in a manner similar
     to shuffling a pack of cards, using a combination of shuffles and 
     cuts (rotations).  The argument 'key' is used to try and give a different
     permutation for each integer. *)

    fun mix key =
      fn size => fn m =>
      let
	fun shuffleN (i, 0) = i
	  | shuffleN (i, n) = 
	    shuffleN (shuffle size (rotate key size i), n - 1)
      in
	shuffleN (m, minShuffles + key mod (maxShuffles - minShuffles + 1))
      end

  end
