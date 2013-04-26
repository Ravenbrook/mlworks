(* the windows structure *)
(*
 * Copyright (c) 1998 Harlequin Group plc
 *
 * See signature for details
 *
 * $Log: __windows.sml,v $
 * Revision 1.9  1999/05/27 10:20:59  johnh
 * [Bug #190553]
 * Fix require statements for bootstrap compiler.
 *
 *  Revision 1.8  1999/05/13  15:34:23  daveb
 *  [Bug #190553]
 *  Use OSExit instead of Exit.
 *
 *  Revision 1.7  1999/03/19  12:17:10  daveb
 *  [Bug #190523]
 *  Remove redundant require.
 *
 *  Revision 1.6  1999/03/19  12:13:44  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.4  1999/03/18  14:23:51  daveb
 * [Bug #190523]
 * Revised to new spec, mainly involving changes to execute functions.
 *
 * Revision 1.3  1999/02/02  16:02:09  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.2  1998/10/27  14:20:48  jont
 * [Bug #70220]
 * Add reap function
 *
 * Revision 1.1  1998/04/07  14:29:08  jont
 * new unit
 ** No reason given. **
 *
 *
 *)

require "^.rts.gen.I386.NT.keys";
require "^.rts.gen.I386.NT.statuses";
require "^.basis.__sys_word";
require "^.basis.__text_io";
require "^.basis.__bin_prim_io";
require "^.basis.__io";
require "^.basis.__char_array";
require "^.basis.__char_vector";
require "__os_exit";
require "^.basis.__word8_array";
require "^.basis.__word8_vector";
require "^.basis.__bin_stream_io";
require "__os_prim_io";
require "^.basis._imperative_io";
require "^.basis.__bit_flags";
require "windows";

structure Windows : WINDOWS =
  struct
    structure Key =
      struct
	open BitFlags
	open Keys;
      end

    val env = MLWorks.Internal.Runtime.environment

    structure Reg =
      struct
	type hkey = SysWord.word;

        val classesRoot = env"nt reg hkey classes root"
	val currentUser = env"nt reg hkey current user"
	val localMachine = env"nt reg hkey local machine"
	val users = env"nt reg hkey users"

	datatype options =
	  VOLATILE
	| NON_VOLATILE

	datatype create_result =
	  CREATED_NEW_KEY of hkey
	| OPENED_EXISTING_KEY of hkey

	val createKeyEx = env"nt reg create key ex"
 
	val openKeyEx = env"nt reg open key ex"
 
	val queryValueEx = env"nt reg query value ex"
 
	val setValueEx = env"nt reg set value ex"
 
	val closeKey = env"nt reg close key"

	val deleteKey = env"nt reg delete key"

      end
    structure DDE =
      struct
	type info = MLWorks.Internal.Value.ml_value
	(* ML has no ability to manipulate this *)

	val startDialog = env"dde start dialog"

	val executeString = env"dde send execute string"
 
	val stopDialog = env"dde stop dialog"
      end

    (* File system *)

    val fileTimeToLocalFileTime= env"Windows.fileTimeToLocalFileTime"

    val localFileTimeToFileTime = env"Windows.localFileTimeToFileTime"

    val getVolumeInformation = env"Windows.getVolumeInformation"

    (* Process creation *)

    val findExecutable = env "Windows.findExecutable"

    val openDocument = env "Windows.openDocument"

    val launchApplication = env "Windows.launchApplication"

    val hasOwnConsole = env "Windows.hasOwnConsole"

    type ('a, 'b) proc = MLWorks.Internal.Value.ml_value
    (* Type of processes created by execute.
       ML has no ability to manipulate this.
     *)
 
    val execute = env "Windows.execute" : string * string list -> MLWorks.Internal.Value.ml_value

    (* streams_of p; returns the handles for the stdOut and stdIn
       streams of the child process (in that order).
     *)
    val streams_of = env "Windows.streamsOf" :
          MLWorks.Internal.Value.ml_value ->
   	    OSPrimIO.file_desc * OSPrimIO.file_desc

    val executeNullStreams = env "Windows.executeNullStreams" :
		string * string list -> MLWorks.Internal.Value.ml_value

    val reap = env "Windows.reap" (* : ('a, 'b) proc -> OS.Process.status *)

    fun simpleExecute arg =
      let
        val proc = executeNullStreams arg
      in
        reap proc
      end
  
    local
      (* daveb, 3/1/99 -- I don't understand why JonT used functor calls here,
	 instead of just using TextIO and BinIO. *)
      structure TextIO' =
	ImperativeIO(structure StreamIO = TextIO.StreamIO
		     structure Vector = CharVector
		     structure Array = CharArray)

      structure BinIO' =
	ImperativeIO(structure StreamIO = BinStreamIO
		     structure Vector = Word8Vector
		     structure Array = Word8Array)

      (* mkStdIn raw_in; produces a full reader from
	 a Windows Handle. *)
      fun augmentRd (raw_in, name) =
        BinPrimIO.augmentReader
	  (BinPrimIO.RD
	     {readVec = SOME(fn i => MLWorks.Internal.Value.cast(MLWorks.Internal.IO.read(raw_in, i))),
	      readVecNB =NONE,
	      readArr = NONE,
	      readArrNB = NONE,
	      block = NONE,
	      canInput = SOME(fn ()=> MLWorks.Internal.IO.can_input(raw_in)>0),
	      avail = fn()=>NONE,
	      name = concat ["<child process ", name, ">"],
	      chunkSize =  1,                        (* arbitrary! *)
	      close = fn () =>
	      (raise MLWorks.Internal.IO.Io
		 {name = concat ["<child process ", name, ">"],
		  function = "close",
		  cause = Fail ("Cannot close " ^ name)}),
		 getPos = SOME(fn ()=> MLWorks.Internal.IO.seek(raw_in,0,1)
			       handle MLWorks.Internal.Error.SysErr _ => 0),
		 setPos = SOME(fn newPos => (ignore(MLWorks.Internal.IO.seek(raw_in,newPos,0));())
			       handle MLWorks.Internal.Error.SysErr _ => ()),
		 endPos = NONE,
		 verifyPos = SOME(fn ()=> MLWorks.Internal.IO.seek(raw_in,0,1)
				  handle MLWorks.Internal.Error.SysErr _ => 0),
		 ioDesc = NONE})	 (* this value cannot be redirected dynamically *)

     (* augmentWr (raw_out, name); produces a full writer from
	 a Windows Handle. *)
      fun augmentWr (raw_out, name) =
 	    BinPrimIO.augmentWriter
	    (BinPrimIO.WR
	     {writeVec = SOME
	      (MLWorks.Internal.Value.cast
	       (fn {buf,i,sz=NONE} =>
		MLWorks.Internal.IO.write(raw_out,buf,i,size buf-i)
	        | {buf,i,sz=SOME n} =>
		MLWorks.Internal.IO.write(raw_out,buf,i,n))),
	      writeVecNB = NONE,
	      writeArrNB = NONE,
	      writeArr = NONE,
	      block = NONE,
	      canOutput = SOME(fn () => true),
	      name = concat ["<child process ",  name, ">"],
	      chunkSize = 1,               (* arbitrary! *)
	      close = fn () =>
	      raise MLWorks.Internal.IO.Io
		{name = concat ["<child process ", name, ">"],
		 function = "close",
		 cause = Fail ("Cannot close " ^ name)},
	      getPos = SOME(fn ()=> MLWorks.Internal.IO.seek(raw_out,0,1)
			    handle MLWorks.Internal.Error.SysErr _ => 0),
	      setPos = SOME(fn newPos => (ignore(MLWorks.Internal.IO.seek(raw_out,newPos,0));()) 
			    handle MLWorks.Internal.Error.SysErr _ => ()),
	      endPos = NONE,
	      verifyPos = SOME(fn ()=> MLWorks.Internal.IO.seek(raw_out,0,1)
			       handle MLWorks.Internal.Error.SysErr _ => 0),
	      ioDesc=NONE})

      (* mkStdOut returns an _IN_streams; mkStdIn returns an _OUT_stream.  *)
      fun mkStdOut raw_out = augmentRd (raw_out, "StdOut")
      fun mkStdIn raw_in = augmentWr (raw_in, "StdIn")
    in
      fun binInstreamOf proc =
	let
	  val (raw_out, _) = streams_of proc
	  val stdOut = mkStdOut raw_out
	in
          BinIO'.mkInstream(BinIO'.StreamIO.mkInstream(stdOut, Word8Vector.fromList []))
	end

      fun binOutstreamOf proc =
	let
	  val (_, raw_in) = streams_of proc 
	  val stdIn = mkStdIn raw_in
	in 
          BinIO'.mkOutstream(BinIO'.StreamIO.mkOutstream(stdIn, IO.NO_BUF))
	end

      fun textInstreamOf proc =
	let
	  val (raw_out, _) = streams_of proc
	  val stdOut = mkStdOut raw_out
	  val prim_out = OSPrimIO.translateIn stdOut
	in
          TextIO'.mkInstream(TextIO'.StreamIO.mkInstream(prim_out, ""))
	end

      fun textOutstreamOf proc =
	let
	  val (_, raw_in) = streams_of proc
	  val stdIn = mkStdIn raw_in
	  val prim_in = OSPrimIO.translateOut stdIn
	in
          TextIO'.mkOutstream(TextIO'.StreamIO.mkOutstream(prim_in, IO.NO_BUF))
	end
    end

    (* The Status structure defines the possible interpretations of 
	OS.Process.status values. *)
    structure Status = Status


    val fromStatus = OSExit.fromStatus
 
    val exit = OSExit.os_exit
  end
