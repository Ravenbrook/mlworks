(*
 *
 * $Log: __stream.sml,v $
 * Revision 1.2  1998/06/08 13:01:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*    	    Jo: A concurrent constraint programming language
		     (programming for the 1990s)

    Implementation of a character stream as input to lexical analyser

		Andrew Wilson:  6th November 1990

			the structure

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)

require "stream";
require "__lowlevel";



structure Stream: STREAM =
struct
  val buffer = ref ""
  val maxPos = ref 0
  val posn = ref 0
  val putBuff = ref []: string list ref
  val streamOpen = ref false
  val stdInBuffer = ref ""
  val stream = ref LowLevel.stdIn

  exception Eof
  exception StreamUnopen



  fun openStream(fileName, len) =
      let
	val strm = if fileName = "" then LowLevel.stdIn
				    else (stdInBuffer:=(!buffer);
                                          LowLevel.openIn fileName)
       in
          (stream:=strm;
	   buffer:=(if (strm=LowLevel.stdIn andalso !stdInBuffer<>"")
                     then let val b = !stdInBuffer in (stdInBuffer:="";b)
                       end
                   else LowLevel.inputN(!stream,1));
           maxPos:=size(!buffer)-1;
           posn:=0;
           streamOpen:=true)
      end



  fun flushStdIn() = (LowLevel.flushStdIn();
                      if !stream=LowLevel.stdIn then buffer:="\n"
                      else stdInBuffer:="\n")
                      



  fun putSymbol(x) =
     if !streamOpen then putBuff:=x::(!putBuff)
		     else raise StreamUnopen




  fun nextSymbol(EolIsEof) =
     (if not(!streamOpen) then raise StreamUnopen
      else
       case !putBuff of
	 a::b => (putBuff:=b; a)
 	| nil => 
           if (!posn)<=(!maxPos) 
             then (posn:=(!posn)+1; 
                   str(chr(stringSub((!buffer,!posn-1)))))
	     else if !stream=LowLevel.stdIn andalso
                     LowLevel.noStdInput() andalso EolIsEof then raise Eof
               else (buffer:= LowLevel.inputN(!stream,1);
                   if (!buffer)="" then raise Eof
                   else (posn:=1; str(chr(stringSub(!buffer,0))))
                  )
      ) handle Ordof => raise Eof
	   
end





