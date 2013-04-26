(*  ==== INITIAL BASIS : streamio functor ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: _stream_io.sml,v $
 *  Revision 1.9  1999/03/20 21:51:48  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.8  1999/02/02  15:58:37  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.7  1998/09/04  15:27:00  mitchell
 *  [Bug #30485]
 *  Fix setPos{In,Out} so that they refresh the stream in the position object
 *
 *  Revision 1.6  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Modifications to make stream_io interact better with delivery
 *
 *  Revision 1.5  1998/05/07  07:28:30  mitchell
 *  [Bug #30409]
 *  Don't terminate stream when getPosIn is called, and raise the correct exception when the stream doesn't support random access
 *
 *  Revision 1.4  1997/07/17  13:23:26  brucem
 *  [Bug #30197]
 *  Add exception handles to wrap reader exceptions as exception IO.Io.
 *  In order to report RandomAccessNotSupported correctly.
 *
 *  Revision 1.3  1996/10/03  15:14:54  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/08/22  12:43:08  andreww
 *  [Bug #1566]
 *  Forcing closeOut/closeIn to terminate system resources even when
 *  stream is terminated/truncated.
 *
 *  Revision 1.1  1996/07/18  12:29:36  andreww
 *  new unit
 *  [Bug 1453]: updated (and renamed) version of the file _streamio.sml
 *
 * Revision 1.11  1996/06/28  14:02:47  andreww
 * ensure that output and output1 raise an exception when outputting to
 * terminated streams.
 *
 * Revision 1.10  1996/06/11  10:08:08  andreww
 * Ensure outstreams are flushed before closing,
 * and that flushing closed outstreams is a no-op
 *
 * Revision 1.9  1996/06/06  12:50:03  andreww
 * Implementing closeIn, and correcting endOfStream,
 *
 * Revision 1.8  1996/06/04  15:46:03  andreww
 * debug so that input <streamname> always returns the same info
 * (i.e., not imperative input).
 *
 * Revision 1.7  1996/06/03  12:56:52  andreww
 * modifying functor argument (in line with definition).
 *
 * Revision 1.6  1996/05/22  09:34:05  matthew
 * Fixing merge problem
 *
 * Revision 1.5  1996/05/22  09:15:20  matthew
 * New Vectors
 *
 * Revision 1.4  1996/05/20  14:16:10  jont
 * signature changes
 *
 * Revision 1.3  1996/05/15  13:10:18  jont
 * pack_words moved to pack_word
 *
 * Revision 1.2  1996/04/23  11:33:46  matthew
 * Integer is now Int
 *
 * Revision 1.1  1996/04/18  11:38:43  jont
 * new unit
 *
 *  Revision 1.3  1995/05/16  14:32:37  daveb
 *  Replaced copy function with a call to Arr.copyv.
 *  Removed redundant structure definition.
 *
 *  Revision 1.1  1995/04/13  13:41:03  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "mono_array";
require "mono_vector";
require "__io";
require "prim_io";
require "stream_io";

(*
exception Io of {name: string,
                 function: string,
                 cause: exn}

exception BlockingNotSupported
exception NonBlockingNotSupported
exception TerminatedStream
exception ClosedStream;
*)

functor StreamIO(structure PrimIO : PRIM_IO
                 structure Vector : MONO_VECTOR
                 structure Array: MONO_ARRAY
                 val someElem : PrimIO.elem
               sharing type PrimIO.vector=Array.vector=Vector.vector
               sharing type PrimIO.array=Array.array
               sharing type Array.elem = PrimIO.elem = Vector.elem
                 ) : STREAM_IO =
 struct
    structure PrimIO=PrimIO
    type elem = PrimIO.elem
    type Array = PrimIO.array
    type vector = PrimIO.vector
    type pos = PrimIO.pos

    type reader = PrimIO.reader
    type writer = PrimIO.writer

    datatype buffer = Buf of {
	more     : more ref,
        data     : vector,
	basePos  : pos option,
	emptyMeansEof: bool,
	name : string
      }				

    and more = GETmore of PrimIO.reader
             | ISmore of buffer
             | NOmore
             | Truncated of unit -> unit  (* this carries the close
                                           * function, to be used to
                                           * close the primitive IO
                                           * device even after the
                                           * stream has been truncated *)

    and instream = In of {
        pos      : int,
        buffer   : buffer}

    datatype in_pos = INP of (instream ref * pos * int)

  (* NOTE: I haven't implemented check to ensure blocking reads are possible.*)

    val empty = Vector.fromList[]

    fun mkInstream(r, v) = 
	let
	  val r' as PrimIO.RD{name,getPos,...} = PrimIO.augmentReader r
	in In{pos=0, 
	      buffer=Buf{name=name,
			 emptyMeansEof=false,
			 data=v,
			 more = ref(GETmore r'),
			 basePos=SOME(valOf getPos())
                                 handle Option => NONE
                                  | IO.RandomAccessNotSupported => NONE
                                 (* SOME getPos may exist but raise an error,
                                    e.g. standard in *)}}
	end

    fun handler(Buf{name,...},function,e) = 
	     raise IO.Io{function=function,name=name,cause=e}

    fun closeBuf (Buf{more=ref NOmore,...}) = ()
      | closeBuf (Buf{more=ref(ISmore buf),...}) = closeBuf buf
      | closeBuf (b as Buf{more as ref(GETmore(PrimIO.RD{close,...})),...}) =
	    (close() handle e => handler(b,"closeIn",e); 
	     more := NOmore)
      | closeBuf (b as Buf{more as ref(Truncated closeFn),...}) =
             (closeFn() handle e => handler(b,"closeIn",e);
              more:=NOmore)

    fun closeIn (In{buffer,...}) = closeBuf buffer


    exception WouldBlock  (* not to be raised out of this module *)

    fun filbuf (doRead: PrimIO.reader -> vector, mlOp: string) 
	       (buffer as Buf{data,more,emptyMeansEof,name,basePos})=
         let val len = Vector.length data
         in if len = 0 andalso emptyMeansEof
              then {eof=true, 
                    rest=Buf{data=empty,more=more,name=name,
                             emptyMeansEof=false,basePos=basePos}}
            else case !more
                   of ISmore buf' => (*filbuf (doRead,mlOp) buf'*)
                     {eof=false, rest=buf'}
                    | NOmore => {eof=true,
                                 rest=Buf{data=empty,more=more,
                                          emptyMeansEof=true,
                                          name=name,basePos=basePos}}
                    | Truncated _ => {eof=true,
                                      rest=Buf{data=empty,more=more,
                                               emptyMeansEof=true,
                                               name=name,basePos=basePos}}
                    | m as GETmore (gm as PrimIO.RD{getPos,...}) => 
                        (let val basePos' = SOME(valOf getPos())
                                    handle Option => NONE
                                     | IO.RandomAccessNotSupported => NONE
                                      (* SOME getPos may exist but raise
                                         an exception, e.g. standard in/out *)
                             val v = doRead gm
                             val buf' = Buf{data=v, more=ref m,
                                            name=name, basePos=basePos',
                                            emptyMeansEof=true}
                        in more := ISmore buf';
                          {eof=false,
                           rest=buf'}         
                        end handle e => handler(buffer,mlOp,e))
         end
       
    fun generalizedInput (filbuf': buffer -> {eof: bool, rest: buffer}) 
	              : instream -> vector * instream =
    let fun get(In{pos,buffer as Buf{data,...}}) =
       let val len = Vector.length data
        in if pos < len
	    then (Vector.extract(data, pos, SOME (len - pos)),
		  In{pos=len,buffer=buffer})
	    else case filbuf' buffer
		  of {eof=true,rest} => (empty,In{pos=0,buffer=rest})
		   | {eof=false,rest} => get (In{pos=0,buffer=rest})
       end
     in get
    end

   fun chunk1 (PrimIO.RD{chunkSize,readVec=SOME read,...}) = read chunkSize
     | chunk1 _ = raise IO.BlockingNotSupported


   fun chunkN n (PrimIO.RD{chunkSize=1,readVec=SOME read,...}) = read n
     | chunkN n (PrimIO.RD{chunkSize=k,readVec=SOME read,...}) =
                      (* round n up to the next multiple of k *)
	               read (((n-1+k) div k) * k)
     | chunkN _ _ = raise IO.BlockingNotSupported

   val eofFilbuf = filbuf (chunk1, "endOfStream")

   fun endOfStream (In{pos,buffer as Buf{data,...}}) =
       if pos < Vector.length data then false
	   else let val {eof,rest=Buf{data,emptyMeansEof,...}}
                        = eofFilbuf buffer
           in eof orelse (emptyMeansEof
                          andalso (Vector.length data = 0))
           end
             

   val input = generalizedInput(filbuf(chunk1, "input"))

 local

(*
   fun bigchunk (arg as PrimIO.RD{getPos,endPos,...}) =
       case posDiff
        of SOME f => (chunkN (Int.max(f{hi=endPos(),lo=getPos()}, 1)) 
		      handle _ => chunk1) 
	             arg
         | NONE => chunk1 arg
*)
   fun bigchunk (arg as PrimIO.RD{getPos,endPos,...}) = chunk1 arg

   val biginput = generalizedInput(filbuf(bigchunk,"inputAll"))
		      
  in
    fun inputAll f =
	(* Try "biginput" the first time.  If that doesn't
	    get everything, treat it as unreliable and unnecessarily
	    expensive, i.e. don't waste time with "endPos" in the
	    rest of the input operations. *)
	let fun loop f = 
	       let val (s,rest) = input f
		in if Vector.length s = 0 then nil else s :: loop rest
               end
	    val (s,rest) = biginput f
         in if Vector.length s = 0 then s else Vector.concat(s :: loop rest)
        end
  end
	     
   local 
       fun nonBlockChunk (PrimIO.RD{chunkSize,readVecNB=SOME read,...})=
		      (case read chunkSize
			of NONE => raise WouldBlock
		         | SOME stuff => stuff)
         | nonBlockChunk _ = raise IO.NonblockingNotSupported

       val inpNob = generalizedInput (filbuf (nonBlockChunk, "inputNoBlock"))
    in 
      fun inputNoBlock x = SOME(inpNob x) handle WouldBlock => NONE

   end



    val input1Filbuf = filbuf(chunk1, "input1")

    fun input1(In{pos,buffer as Buf{data,...}}) =
      let
	val len = Vector.length data
      in
	if pos < len
	  then SOME(Vector.sub(data,pos), In{pos=pos+1,buffer=buffer})
	else
	  case input1Filbuf buffer of
	    {eof=true,rest} => NONE
	  | {eof=false,rest} => input1(In{pos=0,buffer=rest})
      end

    fun listInputN(In{pos,buffer as Buf{data,...}}, n) =
       let val len = Vector.length data
        in if pos + n <= len
	        then ([Vector.extract(data,pos,SOME n)],
                       In{pos=pos+n,buffer=buffer})
	    else if pos < len
		then let val hd = Vector.extract(data,pos,SOME (len-pos))
		         val (tl,f') = listInputN(In{pos=len,buffer=buffer},
						  n-(len-pos))
		      in (hd::tl,f')
		     end
	    else case filbuf (chunkN n, "inputN") buffer
		  of {eof=true,rest} => (nil,In{pos=0,buffer=rest})
		   | {eof=false,rest} => listInputN(In{pos=0,buffer=rest},n)
       end

    fun inputN(f,n) = 
	let val (vl,f') = listInputN(f,n)
         in (Vector.concat vl, f')
        end

    fun getReader' (Buf{more=ref(NOmore),...}, truncate) = 
          raise IO.ClosedStream
      | getReader' (Buf{more=ref(Truncated _),...}, truncate) = 
          raise IO.TerminatedStream
      | getReader' (Buf{more=ref(ISmore b),...}, truncate) = 
          getReader' (b, truncate)
      | getReader' (Buf{more=more as ref(GETmore (m as PrimIO.RD{close,...})), 
                        data, ...}, truncate) = 
          (if truncate then more:=(Truncated close) else ();
           (m, data))

    fun getReader(In{pos,buffer}) = 
      getReader' (buffer, true) handle e => handler(buffer,"getReader",e)


    fun getPosIn(instream as In{pos,buffer as Buf bufrec}) =
      let
        val (PrimIO.RD r,_) = getReader' (buffer, false)
      in
        case (#getPos r,#setPos r,#basePos bufrec)
          of (SOME getPos, SOME setPos,SOME psn) => INP(ref instream, psn,pos)
           | _ => raise IO.RandomAccessNotSupported
      end
      (* Any exceptions should be reported inside IO.Io *)
      handle e => raise IO.Io{name = #name bufrec,
                              function = "getPosIn",
                              cause = e}

    fun filePosIn(INP(_,p,0)) = p
      | filePosIn(INP(ref(In{pos,buffer as Buf bufrec}),p,n)) =
        let
          val (PrimIO.RD r,_) = getReader' (buffer, false)

            (* The following function finds the required
             * input function from the reader record that
             * will enable us to input exactly num elements
             * from the primitive device.  The basis spec
             * tells us that at least one of the four must
             * exist. 
             * Note that when this function is called, we
             * already know that we can read the number of bytes,
             * so blocking shouldn't occur. *)
             

          fun readN record num =
              case (#readVec r,#readVecNB r,#readArr r,#readArrNB r)
               of (SOME read,_,_,_) => ignore (read num)
                | (_,SOME read,_,_) => ignore (read num)
                | (_,_,SOME read,_) => ignore
                    let val tempBuf = Array.array(num,someElem)
                    in read{buf=tempBuf,i=0,sz=NONE}
                    end
                | (_,_,_,SOME read) => ignore
                    let val tempBuf = Array.array(num,someElem)
                    in read{buf=tempBuf,i=0,sz=NONE}
                    end
                | _ => raise IO.Io{name= #name r,
                                   function="filePosIn",
                                   cause=IO.RandomAccessNotSupported}
                     (* last case ought never to occur *)
        in
          case (#getPos r,#setPos r)
            of (SOME getPos, SOME setPos) =>
              let
                val tmpPos = getPos ()
              in
                setPos p;
                readN r n;
                let val result = getPos()
                in (setPos tmpPos;result)
                end
              end
            | _ => raise IO.Io{name = #name bufrec,
                               function="filePosIn",
                               cause=IO.RandomAccessNotSupported}
        end


    fun setPosIn(pos as INP(rs as ref(instream as In{buffer as Buf bufrec,...}),
                            _,_)) =
      let
        val fpos = filePosIn pos
        val (PrimIO.RD r,_) = getReader instream 
                                      (*this terminates the instream*)
       in
         valOf(#setPos r) fpos;
         let val newstream = mkInstream (PrimIO.RD r,Vector.fromList [])
          in (rs := newstream; newstream) end
      end
    handle Option => raise IO.Io{name= #name bufrec,
                                 function="setPosIn",
                                 cause = IO.RandomAccessNotSupported}
         | e =>
           (* The most likely candidate for `e' is IO.RandomAccessNotSupported
              Sometimes the reader has SOME getPos but will raise
              this exception e.g. standard in (with the redirection) *)
           raise IO.Io{name = #name bufrec,
                       function = "setPosIn",
                       cause = e}


    (* OUTPUT: *)

    (* Now life gets interesting...  We want to use an exit hook to close 
       output streams when the program exits.  But exit hooks are inherited
       by delivered executables.  So we may end up including lots of stuff in
       a delivered image even if it doesn't use the basis IO.  So we want to
       remove the exit hook before delivery, and reinstall it afterwards.  
       The variable exit_function_key holds a key to the installed exit 
       hook for closing streams, or NONE if the exit function is not
       installed.  When we deliver an executable we use the key to remove the
       exit function. But what establishes the hook in a delivered executable?
       It has to be reestablished only if the executable is running code that
       uses StreamIO.  Luckily, every operation on output streams already has
       to deal with a variety of stream types, e.g. terminated.  So we add
       a new case to outputter called Delivered that every open output stream's
       writer state is set to when a function is delivered.  On encountering 
       a stream in such a state we reestablish the exit function if necessary,
       and change the writer state back to what it was before delivery. *)

    datatype outputter = PUTmore of PrimIO.writer
                       | Terminated of unit -> unit    (* carries the primIO
                                                        * close function
                                                        *)
                       | Delivered of outputter
                       | NOmore


    datatype outstream = Out of {
        name     : string,
        data     : Array,
        pos      : int ref,
        mode     : IO.buffer_mode ref,
        writer   : outputter ref
      }


    val openStreams = ref []

    fun addOpenStream (s as Out{name,...}) =
          (openStreams := s :: !openStreams; s)

    fun rmOpenStream (s as Out{name,...}) =
          let fun rm [] = [] | rm (h::t) = if h=s then t else h::(rm t)
           in openStreams := rm (!openStreams) end

    datatype out_pos = OUTP of (outstream ref * pos)

    fun handler(Out{name,...},function, cause) =
                     raise IO.Io{name=name,function=function,cause=cause}

    val exit_function_key = ref NONE (* Handle to exit function if installed *)

    fun mkOutstream(w, mode) =
        let val s =
              case PrimIO.augmentWriter w
                of w' as PrimIO.WR{name,chunkSize,...} =>
                    Out{name=name,data=Array.array(chunkSize,someElem), 
                        pos=ref 0, writer=ref (PUTmore w'), mode=ref mode}
         in maybe_install_exit_function s; s end

    and flushOut' (Out{data,pos,
		       writer=ref(PUTmore(PrimIO.WR{writeArr=SOME write,...})),
                        ...}) =
       let val p = !pos
	   fun loop i = if i<p 
	        then loop(i+write{buf=data,i=i,sz=SOME(p-i)}
			  handle e => (Array.copy{src=data,si=i,len=SOME (p-i),
						dst=data,di=0};
				       pos := p-i;
				       raise e))
		else ()
	in pos := 0; (* do this first, in case of interrupt *)
	   loop 0
       end      
      | flushOut'(Out{writer=ref (Terminated _),...}) = ()
                                         (* do nothing on terminated stream*)
      | flushOut'(stream as Out{writer=w as ref (Delivered old_out),...}) = 
          (w := old_out; maybe_install_exit_function stream; flushOut' stream)
      | flushOut'(Out{writer=ref NOmore,...}) = ()
                                         (* do nothing on closed stream*)
      | flushOut' _ = raise IO.BlockingNotSupported


    and flushOut f = flushOut' f
      handle e => handler(f,"flushOut",e)

    and closeOut(f as Out{writer=w as ref(PUTmore(PrimIO.WR{close,name,...})),
                           ...})=((flushOut f;
                                   close();
                                   ignore(rmOpenStream f);
                                   w:=NOmore)
                                   handle e => handler(f,"closeOut",e))
      | closeOut(f as Out{writer=w as ref(Terminated closeFn),...})=
                                 ((closeFn();
                                   ignore(rmOpenStream f);
                                   w:=NOmore)
                                 handle e=> handler(f,"closeOut",e))
      | closeOut(f as Out{writer=w as ref(Delivered old_out),name,...})=
          (w := old_out; maybe_install_exit_function f; closeOut f)
      | closeOut _ = ()
                             (*file is already closed --- do nothing*)

    and maybe_install_exit_function s =
          ( ignore(addOpenStream s); 
            case !exit_function_key of
              SOME _ => () (* exit function already installed *)
            | NONE => 
               (* Install exit function and delivery hook *)
               (exit_function_key := 
                  SOME(MLWorks.Internal.Exit.atExit exitFunction);
                MLWorks.Deliver.add_delivery_hook delivery_hook) )

    and exitFunction () = 
      let
        fun app [] = ()
          | app ((h as Out{name, ...})::t) = 
              (if (name = "<stdOut>" orelse name = "<stdErr>")
               then flushOut h 
               else closeOut h; 
               app t)
      in
        app (!openStreams)
      end

    and delivery_hook deliverer args =
      let val open_streams = !openStreams
       in ((* Set all output stream states to delivered *)
           app (fn (s as Out{writer, name, ...}) => 
                   (flushOut s; writer := Delivered(!writer)))
               open_streams; 

           (* Remove exit function *)
           case !exit_function_key of
             NONE => ()
           | SOME k => ( MLWorks.Internal.Exit.removeAtExit(k);
                         exit_function_key := NONE);
           openStreams := [];

           let val result = deliverer args (* Deliver function *)
            in (* Restore state of output streams *)
               app (fn (s as Out{writer = writer as ref (Delivered w), ...}) =>
                       writer := w
                     | _ => (* Shouldn't happen *) ())
                   open_streams;
               openStreams := open_streams;

               (* Reinstall exit function *)
               exit_function_key :=
                       SOME(MLWorks.Internal.Exit.atExit exitFunction);
               result
           end)
      end

    (* Set up initial exit function and delivery hook *)
    val _ = exit_function_key := SOME(MLWorks.Internal.Exit.atExit exitFunction)
    val _ = MLWorks.Deliver.add_delivery_hook delivery_hook 


    fun bigoutput(f as Out{writer=ref(PUTmore
                                      (PrimIO.WR{writeVec=SOME write,...})),
                           ...},
		  buffer as {buf,i=first,sz}) =
      let
	val nelems = case sz of
	  SOME i => i
	| NONE => Vector.length buf - first
      in
	if nelems=0 then ()
	else let val written = write buffer (* may raise exception! *)
	     in bigoutput(f, {buf=buf,i=first+written,
			      sz=SOME(nelems-written)})
	     end
      end
      | bigoutput (Out{name,writer=ref NOmore,...},_) = raise IO.ClosedStream
      | bigoutput (stream as Out{name,writer=w as ref (Delivered old_out),...},
                   buffer) = 
         (w := old_out; maybe_install_exit_function stream;
          bigoutput (stream, buffer))
      | bigoutput (Out{name,writer=ref (Terminated _),...},_) 
                                             = raise IO.TerminatedStream
      | bigoutput _ = raise IO.BlockingNotSupported



    fun output(f as Out{writer=w as (ref NOmore),...}, _) =
                                    handler(f,"output",IO.ClosedStream)
      | output(f as Out{writer=w as (ref (Terminated _)),...},_) =
                                    handler(f,"output",IO.TerminatedStream)
      | output(f as Out{writer=w as (ref (Delivered old_out)),name,...},s) =
          (w := old_out; maybe_install_exit_function f;
           output(f, s))
      | output(f as Out{data,pos,...}, s)=
        let val slen = Vector.length s
          val blen = Array.length data
          val p = !pos
	  fun copy offset =
	    (Array.copyVec {src=s, si=0, len=SOME slen, dst=data, di=offset};
             pos := offset + slen)
        in if p+slen < blen
             then copy p
           else ((flushOut' f;
		  if slen < blen
                    then copy 0
                  else bigoutput(f,{buf=s,i=0,sz=SOME slen}))
		 handle e => handler(f,"output",e))
        end



    fun output1(f as Out{writer=w as (ref NOmore),...},_)=
        handler(f,"output1",IO.ClosedStream)
      | output1(f as Out{writer=w as (ref (Terminated _)),...},_) =
        handler(f,"output1",IO.TerminatedStream)
      | output1(f as Out{writer=w as (ref (Delivered old_out)),...},e) =
        (w := old_out; maybe_install_exit_function f;
         output1(f, e))
      | output1(f as Out{data,pos,...}, e) =
        let val blen = Array.length data
          val p = !pos
        in if p < blen
             then (Array.update(data,p,e); pos := p+1)
        else if p=0
               then bigoutput(f,{buf=Vector.fromList[e],i=0,sz=SOME 1})
             else (flushOut' f handle e=> handler(f,"output1",e);
                   output1(f,e))
        end



    fun getWriter(f as Out{writer=ref NOmore,...}) =
                                  handler(f,"getWriter",IO.ClosedStream)
      | getWriter(f as Out{writer=ref (Terminated _),...})=
                                  handler(f,"getWriter",IO.TerminatedStream)
      | getWriter(f as Out{writer=w as ref (Delivered old_out),...})=
          (w := old_out; maybe_install_exit_function f;
           getWriter f)
      | getWriter(f as Out{writer=writer as 
                           ref (PUTmore (w as PrimIO.WR {close,...})), 
                           mode = ref m, ...}) = 
          (flushOut' f; writer:=(Terminated close); (w, m))
                      handle e => handler(f,"getWriter",e)


    fun getPosOut (outstream as Out{writer=writer as ref w,name,...}) =
      let
        fun get_record (PUTmore(PrimIO.WR record)) = record
          | get_record (Terminated _) =
              raise IO.Io{name=name,
                          function="getPosOut",
                          cause=IO.TerminatedStream}
          | get_record (Delivered old_out) =
              (writer := old_out; maybe_install_exit_function outstream;
               get_record old_out)
          | get_record NOmore =
              raise IO.Io{name=name,
                          function="getPosOut",
                          cause=IO.ClosedStream}

        val record = get_record w
      in
         case (#getPos record)
           of (SOME getPos) => ((flushOut outstream;
                          OUTP(ref outstream,getPos()))
                          handle e =>
                           (* Most likely candidate for e is
                              RandomAccessNot Supported.
                              The reader may have SOME getOut but still raise
                              this exception, e.g. standard out *)
                          raise IO.Io{name = name,
                                      function = "getPosOut",
                                      cause = e})
            | NONE => raise IO.Io{name=name,
                                  function="getPosOut",
                                  cause=IO.RandomAccessNotSupported}
      end

                         
    fun filePosOut (OUTP(_,p)) = p

    fun setPosOut (OUTP(r as ref (outstream as Out{name,...}),fpos)) =
      let
        val (PrimIO.WR w,blkmde) = getWriter outstream
                                             (* this flushes outstream*)
      in
        valOf(#setPos w) fpos;
        ignore(rmOpenStream outstream);
        let val newstream = mkOutstream(PrimIO.WR w,blkmde)
         in (r := newstream; newstream) end
      end
    handle Option => raise IO.Io{name=name,
                                 function="setPosOut",
                                 cause=IO.RandomAccessNotSupported}
         | e =>
            (* Most likely candidate for `e' is RandomAccessNotSupported.
               Reader may raise this even if it has SOME setPos,
               e.g. standard out *)
            raise IO.Io{name = name,
                        function = "setPosOut",
                        cause = e}


    fun setBufferMode(Out{mode, ...}, bm) = mode := bm

    fun getBufferMode(Out{mode=ref m, ...}) = m


    local
      fun nonBlockChunk n (PrimIO.RD{chunkSize=k,readVecNB=SOME read,...})=
                      (* round n up to the next multiple of k *)
		      (case read (((n-1+k) div k) * k)
                        of NONE => Vector.fromList []
		         | SOME stuff => stuff)
         | nonBlockChunk _ _ = raise IO.NonblockingNotSupported


    in
      fun canInput(In{pos=pos,
                   buffer = buffer as Buf{more, data, basePos, emptyMeansEof,
                                          ...}}, i) =
        let val len = Vector.length data
        in
          if emptyMeansEof andalso (len=0) then SOME 0 else
          if (pos+i <= len) then SOME i 
          else let
            val {eof,rest} =
              filbuf (nonBlockChunk (pos+i-len),"canInput") buffer
            val remaining = pos+i-len
          in
            case canInput(In{pos=0,buffer=rest},remaining)
              of NONE => if pos=len andalso (not eof) then NONE 
                         else SOME (len-pos)
               | SOME k => if k+len-pos =0 andalso (not eof)
                          then NONE else SOME (len-pos+k)
          end
        end
    end
 end


