(* ==== INITIAL BASIS : OS_PRIM_IO for Win32 ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __os_prim_io.sml,v $
 *  Revision 1.20  1999/02/02 16:02:07  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.19  1998/07/29  13:24:27  mitchell
 *  [Bug #30450]
 *  Modify routine that adds CRs so that it doesn't fail if output only partially succeeds
 *
 *  Revision 1.18  1998/06/05  14:24:54  mitchell
 *  [Bug #30416]
 *  Use CREATE_ALWAYS when opening a file for writing
 *
 *  Revision 1.17  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Rename stdErr stream stdErr rather than stdOut
 *
 *  Revision 1.16  1998/04/21  10:53:11  jont
 *  [Bug #70107]
 *  Ensure that close closes the io descriptor as well as the file handle
 *
 *  Revision 1.15  1998/02/19  16:23:41  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.14  1997/07/16  15:24:49  brucem
 *  [Bug #30197]
 *  Change exception Fail "RandomAccessNotSupported" to IO.RandomAccessNotSupported.
 *
 *  Revision 1.13  1997/07/11  11:21:07  daveb
 *  [Bug #30192]
 *  Made attempts to close stdIn etc. raise IO.Io.
 *
 *  Revision 1.12  1997/05/09  12:48:11  jont
 *  [Bug #20045]
 *  Ensure getPos for writes return position rather than size of last write
 *
 *  Revision 1.11  1997/03/24  13:25:16  andreww
 *  [Bug #1960]
 *  making stdIO readers/writers uniform wrt unix ones.
 *
 *  Revision 1.10  1997/01/15  12:14:06  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.9  1996/11/16  02:05:04  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.8  1996/11/08  14:24:26  matthew
 *  [Bug #1661]
 *  Changing io_desc to iodesc
 *
 *  Revision 1.7  1996/10/21  15:24:19  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.6  1996/08/22  10:33:16  stephenb
 *  [Bug #1554]
 *  As part of the fix iodesc and file_desc are no longer the same
 *  so add a call to Win32.fdToIOD in the necessary places.
 *
 *  Revision 1.5  1996/08/20  10:45:31  andreww
 *  [Bug #1558]
 *  Adjusting win32 open so that it doesn't create a file when
 *  reading.
 *
 *  Revision 1.3  1996/08/09  13:30:48  daveb
 *  [Bug #1536]
 *  Word8Vector.vector no longer shares with string.
 *
 *  Revision 1.2  1996/08/05  16:04:11  andreww
 *  [Bug #1530]
 *  Ensuring that length counters are set appropriately.
 *
 *  Revision 1.1  1996/07/18  16:07:09  andreww
 *  new unit
 *  renaming file __primio.sml -> __os_prim_io.sml
 *
 *  Revision 1.13  1996/07/16  13:48:14  andreww
 *  simplifying standard in, out and err.
 *
 *  Revision 1.12  1996/07/04  18:05:10  andreww
 *  Altering interface with win32 runtime environment
 *
 *  Revision 1.11  1996/07/03  12:19:48  andreww
 *  redirecting standard input/output to Window listeners.
 *
 *  Revision 1.10  1996/05/30  14:02:31  andreww
 *  Removing TextPrimIO and BinPrimIO structures.
 *
 *  Revision 1.9  1996/05/30  12:45:33  andreww
 *  adding bin to text converters.
 *
 *  Revision 1.8  1996/05/24  11:54:09  andreww
 *  extracting TextPrimIO and BinPrimIO structures
 *
 *  Revision 1.7  1996/05/20  16:55:32  jont
 *  Changes for new signatures
 *
 *  Revision 1.6  1996/05/15  14:08:50  jont
 *  __fileposint moved to __position
 *
 *  Revision 1.5  1996/05/07  08:58:39  stephenb
 *  Make stdErr write to stderr rather than stdout.
 *
 *  Revision 1.4  1996/05/01  15:23:05  matthew
 *  Fixing sharing problem
 *
 *  Revision 1.3  1996/04/18  15:25:46  jont
 *  initbasis moves to basis
 *
 *  Revision 1.2  1996/03/13  18:43:24  jont
 *  Reinstate signature constraint commented out during debugging
 *
 *  Revision 1.1  1996/03/05  16:03:29  jont
 *  new unit
 *  Support for revised initial basis
 *
 *
 *)

require "^.basis.__word8";
require "^.basis.__word8_array";
require "^.basis.__word8_vector";
require "^.basis.__char";
require "^.basis.__char_array";
require "^.basis.__char_vector";
require "^.basis.os_prim_io";
require "^.basis.__text_prim_io";
require "^.basis.__bin_prim_io";
require "^.basis.__io";
require "__win32os";
require "__win32";

structure OSPrimIO : OS_PRIM_IO =
struct

  type bin_reader = BinPrimIO.reader
  type bin_writer = BinPrimIO.writer
  type text_reader = TextPrimIO.reader
  type text_writer = TextPrimIO.writer 
  type file_desc = Win32_.file_desc


  (* It isn't clear what should be done if it the call
   * to Win32_.fdToIOD fails.  Decided against propagating
   * the error and instead just returning NONE in this case.
   *)
  fun fdToIOD fd =
    SOME (Win32_.fdToIOD fd)
    handle MLWorks.Internal.Error.SysErr _ => NONE



  fun mkWin32Reader
       {fd: file_desc, name: string, initialPos: BinPrimIO.pos, 
        checkSize : bool} =
    let
      val pos = ref initialPos

      val stringsize = size

(*
      val {size, blksize, ...} = Win32OS_.stat fd (* Extent and blocksize *)
*)
      val blksize = 1024 (* Temporary *)
      val size = if checkSize then Win32OS_.size fd else 1
      val ioDesc = fdToIOD fd
    in
      BinPrimIO.augmentReader
        (BinPrimIO.RD
	   {readVec =
	      SOME (fn i =>
	              (let val result = Win32OS_.read (fd, i)
		       in
		         pos := !pos + Word8Vector.length result;
			 result
		       end)),
            readVecNB = NONE,
(* Can Win32 do non-blocking read?
	      SOME (fn i =>
	              (let val result =
			     Win32OS_.read (fd, i)
		       in
		         pos := !pos + stringsize result;
			 SOME result
		       end)
	               handle
	                 Win32OS_.WouldBlock => NONE),
*)

            readArr = NONE,
            readArrNB = NONE,
            block = NONE,
            canInput = NONE,
            avail = fn()=>NONE,
            name = name,
            chunkSize =  blksize,
            close =
	    fn () => (case ioDesc of
			NONE => Win32OS_.close fd
		      | SOME iod => Win32_.closeIOD iod),
	    getPos = SOME(fn () => !pos),
            setPos = SOME(fn newPos =>
		       (ignore(Win32OS_.seek (fd, newPos,Win32OS_.FROM_BEGIN));
		        pos := newPos)),
            endPos = SOME(fn () => size),
            verifyPos = NONE,
	    ioDesc = ioDesc})
    end



  fun openRd filename =
    mkWin32Reader
      {fd = Win32OS_.open_ (filename, 
                            Win32OS_.READ, 
                            Win32OS_.OPEN_EXISTING),
       name = filename,
       initialPos = 0, checkSize = true}



  fun mkWin32Writer
       {fd: file_desc, name: string, blocksize: int, size: int,
        initialPos: BinPrimIO.pos} =
    let
      val pos = ref initialPos
      val ioDesc = fdToIOD fd

    in
      BinPrimIO.augmentWriter
        (BinPrimIO.WR
           {writeVec =
	      SOME (fn {buf, i, sz} => 
	              (let
			 val nelems = case sz of
			   SOME i => i
			 | NONE => Word8Vector.length buf - i
			 val result = Win32OS_.write (fd, buf, i, nelems)
		       in
		         pos := !pos + result;
			 result
		       end)),
(* Can Win32 do non-blocking write?
	      SOME (fn {data, first, nelems} => 
	              (let
			 val result = Win32OS_.write (fd, data, first, nelems)
		       in
		         pos := result;
			 SOME result
		       end)
	               handle
	                 Win32OS_.WouldBlock => NONE),
*)
            writeVecNB = NONE,
            writeArrNB = NONE,
            writeArr = NONE,
            block = NONE,
            canOutput = NONE,
            name = name,
            chunkSize = blocksize,
            close =
	    fn () => (case ioDesc of
			NONE => Win32OS_.close fd
		      | SOME iod => Win32_.closeIOD iod),
            getPos = SOME(fn () => !pos),
            setPos = SOME(fn newPos =>
            (ignore(Win32OS_.seek (fd, newPos,Win32OS_.FROM_BEGIN));
		        pos := newPos)),
            endPos = SOME(fn () => size),
            verifyPos = NONE,            (* needs to change! use seek*)
	    ioDesc = ioDesc})
    end
   
  fun openWr filename =
    let 
      val fd = Win32OS_.open_ (filename, Win32OS_.WRITE, Win32OS_.CREATE_ALWAYS)
(*
      val {size, blksize, ...} = Win32OS_.stat fd
*)
      val blksize = 1024 (* Temporary *)
      val size = Win32OS_.size fd
    in
      mkWin32Writer
        {fd = fd,
         name = filename,
	 blocksize = blksize,
	 size = size,
         initialPos = 0}
    end

  fun openApp filename =
    let 
      val fd = Win32OS_.open_ (filename, Win32OS_.READ_WRITE,
                               Win32OS_.OPEN_ALWAYS)
      val _ = Win32OS_.seek (fd, 0, Win32OS_.FROM_END)
(*
      val {size, blksize, ...} = Win32OS_.stat fd
*)
     val blksize = 1024 (* Temporary *)
      val size = Win32OS_.size fd
    in
      mkWin32Writer
        {fd = fd,
         name = filename,
	 blocksize = blksize,
	 size = size,
         initialPos = size}
    end





   (*                                                    *)
   (* Standard Input, Standard Output and Standard Error *)
   (*                                                    *)

   (* note that the functions for getPos and setPos have cases where
    * they handle the MLWorks.Internal.Error.SysErr exception.  This is
    * needed when an illegal seek occurs ... for example, when standard
    * in has been redirected from a pipe --- as is the case when
    * guib is being loaded.  I just ignore it. *)

  local
    open MLWorks.Internal.StandardIO
    val cast = MLWorks.Internal.Value.cast
  in
    val stdIn =  BinPrimIO.augmentReader
      (BinPrimIO.RD
       {readVec = SOME (fn i => cast (#get(#input(currentIO()))) i),
        readVecNB =NONE,
        readArr = NONE,
        readArrNB = NONE,
        block = NONE,
        canInput = SOME(fn ()=>valOf(#can_input(#input(currentIO()))) ()
                       handle Option => raise IO.RandomAccessNotSupported),
        avail = fn()=>NONE,
        name = "<stdIn>",
        chunkSize =  1,                        (* arbitrary! *)
        close = fn () =>
          raise IO.Io
                  {name = "<stdIn>",
                   function = "close",
                   cause = Fail "Cannot close stdIn"},
        getPos = SOME(fn ()=> valOf(#get_pos(#input(currentIO())))()
                      handle Option => raise IO.RandomAccessNotSupported
                           | MLWorks.Internal.Error.SysErr _ => 0),
        setPos = SOME(fn newPos => valOf(#set_pos(#input(currentIO()))) newPos
                      handle Option => raise IO.RandomAccessNotSupported
                           | MLWorks.Internal.Error.SysErr _ => ()),
        endPos = NONE,
        verifyPos = SOME(fn ()=> valOf(#get_pos(#input(currentIO())))()
                      handle Option => raise IO.RandomAccessNotSupported
                           | MLWorks.Internal.Error.SysErr _ => 0),
        ioDesc = NONE}) (* this value cannot be redirected dynamically*)
      
    val stdOut =
      BinPrimIO.augmentWriter
      (BinPrimIO.WR
       {writeVec = SOME (fn s => #put(#output(currentIO())) (cast s)),
       writeVecNB = NONE,
       writeArrNB = NONE,
       writeArr = NONE,
       block = NONE,
       canOutput = SOME(fn () => valOf(#can_output(#output(currentIO())))()
                        handle Option => true),
       name = "<stdOut>",
       chunkSize = 1,               (* arbitrary! *)
       close = fn () =>
         raise IO.Io
                 {name = "<stdOut>",
                  function = "close",
                  cause = Fail "Cannot close stdOut"},
       getPos = SOME(fn ()=> valOf(#get_pos(#output(currentIO())))()
                 handle Option => raise IO.RandomAccessNotSupported
                      | MLWorks.Internal.Error.SysErr _ => 0),
       setPos = SOME(fn newPos => valOf(#set_pos(#output(currentIO()))) newPos
                     handle Option => raise IO.RandomAccessNotSupported
                          | MLWorks.Internal.Error.SysErr _ => ()),
       endPos = NONE,
       verifyPos = SOME(fn ()=> valOf(#get_pos(#output(currentIO())))()
                 handle Option => raise IO.RandomAccessNotSupported
                      | MLWorks.Internal.Error.SysErr _ => 0),
       ioDesc=NONE})   
      
    val stdErr =
      BinPrimIO.augmentWriter
      (BinPrimIO.WR
       {writeVec = SOME (fn s => #put(#error(currentIO())) (cast s)),
       writeVecNB = NONE,
       writeArrNB = NONE,
       writeArr = NONE,
       block = NONE,
       canOutput = SOME(fn ()=> valOf(#can_output(#error(currentIO())))()
                       handle Option => raise IO.RandomAccessNotSupported),
       name = "<stdErr>",
       chunkSize = 1,               (* arbitrary! *)
       close = fn () =>
         raise IO.Io
                 {name = "<stdErr>",
                  function = "close",
                  cause = Fail "Cannot close stdErr"},
       getPos = SOME(fn () => valOf(#get_pos(#error(currentIO()))) ()
                       handle Option => raise IO.RandomAccessNotSupported
                            | MLWorks.Internal.Error.SysErr _ => 0),
       setPos = SOME(fn newPos => valOf(#set_pos(#error(currentIO()))) newPos
                       handle Option => raise IO.RandomAccessNotSupported
                            | MLWorks.Internal.Error.SysErr _ => ()),
       endPos = NONE,
       verifyPos = SOME(fn () => valOf(#get_pos(#error(currentIO()))) ()
                       handle Option => raise IO.RandomAccessNotSupported
                            | MLWorks.Internal.Error.SysErr _ => 0),
       ioDesc=NONE})   
      
  end




  (* On Win32, text isn't binary: but the only difference appears    *)
  (* to be that line feeds in text become linefeeds+carriage returns *)
  (* in binary mode.  Therefore conversion should simply remove      *)
  (* carriage returns.                                               *)

  (* NOTE: the reader/writer operations return the number of chars   *)
  (* that they read from/wrote to the in/outstream.  I'm assuming    *)
  (* that they always read/write the required number of chars.  The  *)
  (* library spec suggests that any k less than the required number  *)
  (* can do, but I don't quite know what this means.  Thus I subtract*)
  (* the number of carriage returns from the total.                  *)



  fun translateIn (x : BinPrimIO.reader) : TextPrimIO.reader = 
    let
       val BinPrimIO.RD({name= n,
                         chunkSize=cS,
                         readVec=rV,
                         readArr=rA,
                         readVecNB=rVNB,
                         readArrNB=rANB,
                         block= b,
                         canInput=cI,
                         avail=av,
                         getPos=gP,
                         setPos=sP,
                         endPos=eP,
                         verifyPos=vP,
                         close=c,
                         ioDesc=iD}) = x

       val CR = 13



       (* following functions remove CRs in VECTORS *)
       (* if vector only contains CRs, must reinput,*)
       (* otherwise end-of-stream signalled falsely *)
       local
         fun removeCRinVector v f = 
           if (Word8Vector.length v) = 0 then
	     CharVector.fromList []    (*propagate EOS*)
           else 
             case (Word8Vector.foldr (fn (w,l)=> 
                                      let val i = (Word8.toInt w)
                                      in if i=CR then l
                                         else (Char.chr i)::l
                                      end) [] v)
               of [] => removeCRinVector (f()) f           (* reinput *)
                | l =>  CharVector.fromList l
       in

         fun rVconv NONE = NONE
           | rVconv (SOME f) = SOME(fn args => removeCRinVector (f args)
                                                (fn () => f args))

         (* for nonblocking input, have to propagate "input blocks"    *)
         (* signals.  Use the block exception for this.                *)

         fun rVNBconv NONE = NONE
           | rVNBconv (SOME f) = 
             SOME(fn args => case (f args)
                               of NONE => NONE
                                | (SOME v) => 
                                    let exception block
                                    in
                                      SOME(removeCRinVector v
                                           (fn () => case (f args)
                                                       of NONE => raise block
                                                        | (SOME v) => v))
                                      handle block => NONE
                                    end)
       end






         (* following functions remove CRs in ARRAYS *)
         (* again, problem with having to reinput    *)

       local
         (* in following, src is the source Binary array, size is the *)
         (* size of input data, trg is the target character array and *)
         (* more is the function that reloads the array in case CR    *)
         (** removal empties src.                                     *)

         fun removeCRinArray src size trg posn more= 
           let 
             fun removeCR i j s = 
               if i>= size then (size-s,j)
               else let val k=(Word8.toInt(Word8Array.sub(src,i)))
                     in if k=CR then removeCR (i+1) j (size-1)
                        else (CharArray.update(trg,j,Char.chr k);
                             removeCR (i+1) (j+1) size)
                    end
           in 
             if size=0 then 0 else              (* propagate eos condition   *)
               case (removeCR 0 posn size)      (* otherwise remove CRs.     *)
                 of (CRs,0)=>removeCRinArray    (* if removing CRs empties   *)
                         src (more()) trg       (* array, reinput and repeat *)
                         posn more              
                  | (CRs,k)=> k-CRs             (* ow, return number of chars*)
           end
       in
         fun rAconv NONE=NONE
           | rAconv (SOME f) =
             SOME(fn (args as {buf=a,i=p,sz=s}) => 
                  let
                    val len = case s
                                of NONE=> CharArray.length a-p
                                 | (SOME z)=> z

                    val b = Word8Array.array(len,Word8.fromInt 0)
                  in
                    removeCRinArray b (f {buf=b,i=0,sz=NONE}) a p
                                      (fn () => f {buf=b,i=0,sz=NONE})
                  end)


         fun rANBconv NONE=NONE
           | rANBconv (SOME f) = 
             SOME(fn (args as {buf=a,i=p,sz=s}) => 
                  let
                    val len = case s
                                of NONE=> CharArray.length a-p
                                 | (SOME z)=> z

                    val b = Word8Array.array(len,Word8.fromInt 0)

                    exception block
                                
                    fun more () = case (f {buf=b,i=0,sz=NONE})
                                    of NONE=> raise block
                                     | (SOME k)=> k


                  in
                    SOME(removeCRinArray b (more ()) a p more)
                    handle block => NONE
                  end)
       end
    in
      TextPrimIO.RD({name=n,
                     chunkSize=cS,
                     readVec=rVconv rV,
                     readArr=rAconv rA,
                     readVecNB=rVNBconv rVNB,
                     readArrNB=rANBconv rANB,
                     block= b,
                     canInput=cI,
                     avail=av,
                     getPos=gP,
                     setPos=sP,
                     endPos=eP,
                     verifyPos=vP,
                     close=c,
                     ioDesc=iD})
    end



  (* NOW, to translate binary writers into text writers.  The translator *)
  (* should only involve adding CRs after or before line feeds.  No need *)
  (* for complicated re-outputs.                                         *)
  (* (Though perhaps chunk size efficiency should be considered?)        *)


  fun translateOut (x : BinPrimIO.writer) : TextPrimIO.writer = 
    let
      val BinPrimIO.WR({name = n,
                        chunkSize=cS,
                        writeVec=wV,
                        writeArr=wA,
                        writeVecNB=wVNB,
                        writeArrNB=wANB,
                        block=b,
                        canOutput=cO,
                        endPos=eP,
                        getPos=gP,
                        setPos=sP,
                        verifyPos=vP,
                        close=c,
                        ioDesc=iD})=x

      val LF = 10
      val CR = 13
      val LFcode=Word8.fromInt LF
      val CRcode=Word8.fromInt 13

      local
                            (* the following functions do the conversions *)
                            (* for the two write vector operations        *)
                            (* Convert text writes to binary writes.      *)

        fun addCRtoVec v = 
          let val CRs = ref 0
              val v'= Word8Vector.fromList (CharVector.foldr
                                    (fn (c,l)=> if Char.ord c=LF then
                                       (CRs:=(!CRs)+1;CRcode::LFcode::l) else
                                       Word8.fromInt (Char.ord c)::l)
                                    [] v)
           in
             (!CRs,v')
          end

        fun CRs_actually_outputV
              (CRs, augmented_vector, amount_output) =
          if Word8Vector.length(augmented_vector) = amount_output
          then CRs
          else (* Now things get messy - for now let's assume there were no
                  CRs in the original vector *)
            Word8Vector.foldli
              (fn (_, c, CRs) => if Word8.toInt c = CR then CRs + 1 else CRs)
              0
              (augmented_vector, 0, SOME amount_output)

        fun CRs_actually_outputA
              (CRs, augmented_array, amount_output) =
          if Word8Array.length(augmented_array) = amount_output
          then CRs
          else (* Now things get messy - for now let's assume there were no
                  CRs in the original vector *)
            Word8Array.foldli
              (fn (_, c, CRs) => if Word8.toInt c = CR then CRs + 1 else CRs)
              0
              (augmented_array, 0, SOME amount_output)

      in
            fun wVconv NONE=NONE
              | wVconv (SOME f) =
                SOME(fn {buf=v,i=p,sz=(s:int option)} =>
                     let val (CRs,v')=addCRtoVec (CharVector.extract(v,p,s))
                         val real_out = f{buf=v',i=0, sz=NONE}
                       in real_out-(CRs_actually_outputV(CRs, v', real_out))
                     end)
                     

            fun wVNBconv NONE=NONE
              | wVNBconv (SOME f) =
                SOME(fn {buf=v,i=p,sz=(s:int option)}=>
                     let val (CRs,v') = addCRtoVec (CharVector.extract(v,p,s))
                     in
                       case f{buf=v',i=0,sz=NONE}
                              of NONE=> NONE
                               | (SOME k) => 
                                   SOME(k-CRs_actually_outputV(CRs, v', k))
                     end)

            fun wAconv NONE=NONE
              | wAconv (SOME f) =
                SOME(fn {buf=a,i=p,sz=(s:int option)}=>
                     let val (CRs,v) = addCRtoVec (CharArray.extract(a,p,s))
                         val a'= Word8Array.array(Word8Vector.length v,
                                                  Word8.fromInt 0)
                      in
                        (Word8Array.copyVec{src=v,si=0,len=NONE,dst=a',di=0};
                         let val amount_output = f{buf=a',i=0,sz=NONE}
                          in amount_output - 
                               CRs_actually_outputA(CRs, a', amount_output) end)
                     end)


            fun wANBconv NONE=NONE
              | wANBconv (SOME f) =
                SOME(fn {buf=a,i=p,sz=(s:int option)}=>
                     let val (CRs,v) = addCRtoVec (CharArray.extract(a,p,s))
                         val a'= Word8Array.array(Word8Vector.length v,
                                                  Word8.fromInt 0)
                      in
                        (Word8Array.copyVec{src=v,si=0,len=NONE,dst=a',di=0};
                         case f{buf=a',i=0,sz=NONE}
                           of NONE=> NONE
                            | (SOME k) => SOME (k-CRs_actually_outputA(CRs, a', k)))
                     end)
      end




    in
      TextPrimIO.WR({name=n,
                     chunkSize=cS,
                     writeVec=wVconv wV,
                     writeArr=wAconv wA,
                     writeVecNB=wVNBconv wVNB,
                     writeArrNB=wANBconv wANB,
                     block=b,
                     canOutput=cO,
                     endPos=eP,
                     getPos=gP,
                     setPos=sP,
                     verifyPos=vP,
                     close=c,
                     ioDesc=iD})
    end

  fun openString s =
    let
      val pos = ref 0
      val len = size s
        
      fun stringReadVec i = 
        if !pos>=len then "" else
        (CharVector.extract(s,!pos,if !pos+i>=len
                                    then (pos:=len;NONE)
                                  else (pos:=(!pos+i);SOME i)))

      fun stringReadArr {buf,i,sz} =
        if !pos>=len then 0 else
        let val startPos = !pos
          val num_elems = case sz
                            of NONE => (pos:=len;
                                        len-startPos)
                             | (SOME n) =>
                                 if !pos+n>=len then
                                   (pos:=len;
                                    len-startPos)
                                 else (pos:=(!pos+n); n)
        in
          CharArray.copyVec {src=s, si= !pos, len=SOME num_elems,
                             dst=buf, di=i};
          num_elems
        end
      
    in
      TextPrimIO.RD
      {readVec=SOME(stringReadVec),
       readArr=SOME(stringReadArr),
       readVecNB=SOME(SOME o stringReadVec),
       readArrNB=SOME(SOME o stringReadArr),
       block=NONE,
       canInput=SOME(fn ()=> !pos< (len-1)),
       avail=fn()=> SOME(len-(!pos)),
       name="<stringIn>",
       chunkSize=1,
       close=fn () => pos:=len-1,
       getPos=SOME(fn()=> !pos),
       setPos=SOME(fn i => pos:=i),
       endPos=SOME(fn()=> len-1),
       verifyPos=SOME(fn() => !pos),
       ioDesc=NONE}
    end



end
