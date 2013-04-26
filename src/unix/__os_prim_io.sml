(*  ==== INITIAL BASIS : OS_PRIM_IO ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __os_prim_io.sml,v $
 *  Revision 1.15  1999/02/02 16:01:56  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.14  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Rename stdErr stream stdErr rather than StdOut
 *
 *  Revision 1.13  1998/02/19  21:09:49  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.12  1997/07/15  15:06:52  brucem
 *  [Bug #30197]
 *  Change exception Fail "RandomAccessNotSupported" to
 *  IO.RandomAccessNotSupported.
 *
 *  Revision 1.11  1997/07/11  11:22:55  daveb
 *  [Bug #30192]
 *  Made attempts to close stdIn etc. raise IO.Io.
 *
 *  Revision 1.10  1997/05/09  12:47:17  jont
 *  [Bug #20045]
 *  Ensure getPos for writes return position rather than size of last write
 *
 *  Revision 1.9  1997/03/24  13:19:15  andreww
 *  [Bug #1960]
 *  tidying up stdErr writer
 *
 *  Revision 1.8  1997/01/15  12:13:43  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.7  1996/11/16  01:59:05  io
 *  [Bug #1757]
 *  renamed __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.6  1996/10/21  15:22:56  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.5  1996/08/21  11:02:47  stephenb
 *  [Bug #1554]
 *  Add a call to UnixOS.fdToIOD now that file descriptors and
 *  io descriptors aren't the same type.
 *  l
 *
 *  Revision 1.4  1996/08/14  09:17:00  andreww
 *  [Bug #1537]
 *  File primIO records will return io Descriptors
 *
 *  Revision 1.3  1996/08/09  11:00:49  daveb
 *  [Bug #1536]
 *  BinPrimIO.vector no longer shares with string.
 *
 *  Revision 1.2  1996/08/05  16:05:33  andreww
 *  [Bug #1530]
 *  Ensuring that length counters are set appropriately.
 *
 *  Revision 1.1  1996/07/18  13:25:48  andreww
 *  new unit
 *  [Bug 1453]: updated wrt May 30 basis doc, and renamed from __primio.sml
 *
 *  Revision 1.15  1996/07/16  10:18:27  andreww
 *  Simplifying standard in, out and err.
 *
 *  Revision 1.14  1996/07/03  09:59:09  andreww
 *  Routing standard input/output/error through the listener.
 *
 *  Revision 1.13  1996/06/14  13:23:27  andreww
 *  correcting sets to unix blocking mode.
 *
 *  Revision 1.12  1996/06/10  09:51:29  andreww
 *  converting out-of-date IO magic numbers (which don't work under Solaris)
 *  into appropriate sums of corresponding unix constants.
 *
 *  Revision 1.11  1996/05/31  12:36:51  andreww
 *  removing text, bin structures.
 *
 *  Revision 1.10  1996/05/30  16:40:43  andreww
 *  removing too-early modifications.
 *
 *  Revision 1.9  1996/05/30  14:00:34  andreww
 *  removing TextPrimIO and BinPrimIO structures.
 *
 *  Revision 1.8  1996/05/24  11:24:37  andreww
 *  expose TextPrimIO and BinPrimIO at top-level.
 *
 *  Revision 1.7  1996/05/20  12:29:12  jont
 *  Update to latest primio signature
 *
 *  Revision 1.6  1996/05/15  13:29:41  jont
 *  __fileposint moved to __position
 *
 *  Revision 1.5  1996/05/03  15:56:18  stephenb
 *  UnixOS_.fstat has moved to UnixOS_.FileSys.fstat
 *
 *  Revision 1.4  1996/04/23  16:27:35  matthew
 *  Changing some word8s to chars
 *
 *  Revision 1.3  1996/04/18  15:23:45  jont
 *  initbasis moves to basis
 *
 *  Revision 1.2  1996/04/02  09:42:52  stephenb
 *  Replace UnixOS_.stat by UnixOS_.fstat
 *
 *  Revision 1.1  1996/02/29  16:54:11  jont
 *  new unit
 *  Moved from __unixprimio.sml for common naming scheme with NT
 *
 *  Revision 1.5  1996/01/29  08:38:41  stephenb
 *  Update wrt change in UnixOS_.write.
 *
 *  Revision 1.4  1996/01/23  13:49:00  stephenb
 *  OS reorganisation: since OS specific code is no longer in the
 *  pervasive library, any use of MLWorks.OS.Unix changes to using
 *  UnixOS structure.  Note that the UnixOS_ structure is being
 *  hardwired in rather than turning UnixPrimIO into a functor.
 *
 *  Revision 1.3  1995/09/12  09:59:23  daveb
 *  Word conversions are temporarily in abeyance.
 *
 *  Revision 1.2  1995/05/10  14:46:03  daveb
 *  Added support for blocking, seek, stat, etc.
 *
 *
 *)

require "^.basis.__word8_vector";
require "^.basis.__char_array";
require "^.basis.__char_vector";
require "^.basis.os_prim_io";
require "^.basis.__bin_prim_io";
require "^.basis.__text_prim_io";
require "^.basis.__io";
require "__unixos";

structure OSPrimIO : OS_PRIM_IO =
struct

  type bin_reader = BinPrimIO.reader
  type bin_writer = BinPrimIO.writer
  type text_reader = TextPrimIO.reader
  type text_writer = TextPrimIO.writer
  type file_desc = UnixOS_.FileSys.file_desc


  (*                                         *)
  (* Readers and Writers for Unix filesystem *)
  (*                                         *)

  val FROM_BEGINNING = 0     (* magic numbers for seek *)
  val FROM_CURRENT   = 1
  

  fun mkUnixReader
       {fd: file_desc, name: string, initialPos: BinPrimIO.pos,
        initialBlockMode: bool} =
    let
      val blockMode = ref initialBlockMode
      val pos = ref initialPos

      fun ensureBlockMode b =
	if !blockMode = b then
	  ()
	else
	  (UnixOS_.set_block_mode (fd, b);
	   blockMode := b)

      val stringsize = size

      val {size, blksize, ...} = UnixOS_.FileSys.fstat fd
    in
      BinPrimIO.augmentReader
        (BinPrimIO.RD
	   {readVec =
	      SOME (fn i =>
	              (ensureBlockMode true;
	               let val result = UnixOS_.read (fd, i)
		       in
		         pos := !pos + Word8Vector.length result;
			 result
		       end)),
            readVecNB =
	      SOME (fn i =>
	              (ensureBlockMode false;
	               let val result =
			     UnixOS_.read (fd, i)
		       in
		         pos := !pos + Word8Vector.length result;
			 SOME result
		       end)
	               handle
	                 UnixOS_.WouldBlock => NONE),
            readArr = NONE,
            readArrNB = NONE,
            block = NONE,
            canInput = SOME (fn () => UnixOS_.can_input fd <> 0),
            avail = fn() => SOME(UnixOS_.size fd - 
                                   UnixOS_.seek(fd,0,FROM_CURRENT)),
            name = name,
            chunkSize =  blksize,
            close = fn () => UnixOS_.IO.close fd,
            getPos = SOME(fn () => !pos),
            setPos = SOME(fn newPos =>
		       (ignore(UnixOS_.seek (fd, newPos,FROM_BEGINNING));
		        pos := newPos)),
            endPos = SOME(fn () => size),
            verifyPos = SOME(fn() => UnixOS_.seek(fd,0,FROM_CURRENT)),
	    ioDesc=SOME (UnixOS_.FileSys.fdToIOD fd)})
    end

  fun openRd filename =
    mkUnixReader
      {fd = UnixOS_.open_ (filename, UnixOS_.o_rdonly, 0),
       name = filename,
       initialPos = (* Position.fromDefault *) 0,
       initialBlockMode = true}






  fun mkUnixWriter
       {fd: file_desc, name: string, blocksize: int, size: int,
        initialPos: BinPrimIO.pos, initialBlockMode: bool} =
    let
      val blockMode = ref initialBlockMode
      val pos = ref initialPos

      fun ensureBlockMode b =
	if !blockMode = b then
	  ()
	else
	  (UnixOS_.set_block_mode (fd, b);
	   blockMode := b)
    in
      BinPrimIO.augmentWriter
        (BinPrimIO.WR
           {writeVec =
	      SOME (fn {buf, i, sz} => 
	              (ensureBlockMode true;
	               let
			 val nelems = case sz of
			   SOME i => i
			 | NONE => Word8Vector.length buf - i
			 val result = UnixOS_.write (fd, buf, i, nelems)
		       in
		         pos := !pos + result;
			 result
		       end)),
            writeVecNB =
	      SOME (fn {buf, i, sz} => 
	              (ensureBlockMode false;
	               let
			 val nelems = case sz of
			   SOME i => i
			 | NONE => Word8Vector.length buf - i
			 val result = UnixOS_.write (fd, buf, i, nelems)
		       in
		         pos := !pos + result;
			 SOME result
		       end)
	               handle
	                 UnixOS_.WouldBlock => NONE),
            writeArrNB = NONE,
            writeArr = NONE,
            block = NONE,
            canOutput = NONE,
            name = name,
            chunkSize = blocksize,
            close = fn () => UnixOS_.IO.close fd,
            getPos = SOME(fn () => !pos),
            setPos = SOME(fn newPos =>
		       (ignore(UnixOS_.seek (fd, newPos,FROM_BEGINNING));
		        pos := newPos)),
            endPos = SOME(fn () => size),
            verifyPos = SOME(fn() => UnixOS_.seek(fd,0,FROM_CURRENT)),
	    ioDesc=SOME (UnixOS_.FileSys.fdToIOD fd)})
    end

   
  fun openWr filename =
    let 
      val fd = UnixOS_.open_ (filename, UnixOS_.o_wronly
                                       +UnixOS_.o_creat
                                       +UnixOS_.o_trunc, 438)
			                           (* 438 = 0666 *)
      val {size, blksize, ...} = UnixOS_.FileSys.fstat fd
    in
      mkUnixWriter
        {fd = fd,
         name = filename,
	 blocksize = blksize,
	 size = size,
         initialPos = (* Position.fromDefault *) 0,
         initialBlockMode = true}
    end



  fun openApp filename =
    let 
      val fd = UnixOS_.open_ (filename, UnixOS_.o_wronly
                                       +UnixOS_.o_append
                                       +UnixOS_.o_creat, 438)
		                                   (* 438 = 0666 *)
      val {size, blksize, ...} = UnixOS_.FileSys.fstat fd
    in
      mkUnixWriter
        {fd = fd,
         name = filename,
	 blocksize = blksize,
	 size = size,
         initialPos = (* Position.fromDefault *) size,
         initialBlockMode = true}
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









  (* unix standard IO readers and writers. *)


  val terminalOut = 
    let 
      val fd = UnixOS_.FileSys.stdout
      val {blksize, ...} = UnixOS_.FileSys.fstat fd
    in
      mkUnixWriter
      {fd = fd,
       name = "<stdOut>",
       size = 0,
       blocksize = blksize,
       initialPos = 0,
       initialBlockMode = true}
    end


  val terminalErr =
    let 
      val fd = UnixOS_.FileSys.stderr
      val {blksize, ...} = UnixOS_.FileSys.fstat fd
    in
      mkUnixWriter
      {fd = fd,
       name = "<stdErr>",
       size = 0,
       blocksize = 1,
       initialPos = 0,
       initialBlockMode = true}
    end


         (* note that in the following reader and writers, getPos and setPos
          * have to handle SysErr --- this occurs when one tries to seek
          * on redirected input (for example, when creating guib.img).  In
          * this case, it is best to return default values. *)



  local
    open MLWorks.Internal.StandardIO
    val cast = MLWorks.Internal.Value.cast
  in
    val stdIn = BinPrimIO.augmentReader
      (BinPrimIO.RD
       {readVec = SOME (fn i => cast (#get(#input(currentIO()))) i),
        readVecNB =NONE,
        readArr = NONE,
        readArrNB = NONE,
        block = NONE,
        canInput = SOME(fn ()=>valOf(#can_input(#input(currentIO()))) ()
                       handle Option => raise IO.RandomAccessNotSupported),
        name = "<stdIn>",
        avail = fn()=>NONE,
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



    

  (* On Unix, text is binary *) (* HACK !!!!! *)
  (* We should do this properly *)
  fun translateIn x = MLWorks.Internal.Value.cast x
  fun translateOut x = MLWorks.Internal.Value.cast x

end


