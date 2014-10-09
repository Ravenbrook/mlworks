(*  New Jersey emulation of runtime environment
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  $Log: nj_env.sml,v $
 *  Revision 1.1  1996/01/23 10:41:34  matthew
 *  new unit
 *  Emulation of runtime environment
 *
 *)


local
    (* A handful of environment functions that we need *)
    (* We only need the functions that actually get called by the
    compiler here *)

    (* http://www.standardml.org/Basis/os-process.html#SIG:OS_PROCESS.getEnv:VAL *)
    fun environment () : string list =
	(print "D: os unix environment called\n";
	 Posix.ProcEnv.environ ())

    (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.chDir:VAL *)
    val setwd = OS.FileSys.chDir

    (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.getDir:VAL *)
    val getwd = OS.FileSys.getDir

    (* http://www.standardml.org/Basis/os-file-sys.html#SIG:OS_FILE_SYS.realPath:VAL *)
    val realpath = OS.FileSys.realPath


    (* stat is a pain to emulate *)
    local
	(* layouts must match definitions in unix/_unixos.sml *)
	structure S = struct
	    type mode = int
	  end
	datatype dev = DEV of int
	datatype ino = I_NODE of int
	structure ST =
	  struct
	    type stat = {dev	: dev,
			 ino	: ino,
			 mode	: S.mode,
			 nlink	: int,
			 uid	: int,
			 gid	: int,
			 rdev	: int,
			 size	: Position.int,
			 atime	: Time.time,
			 mtime	: Time.time,
			 ctime	: Time.time,
			 blksize: int,
			 blocks : int,
			 (* append the original object at the end *)
			 (* hoping that the layout will actually be *)
			 (* at the end *)
			 zzwrapped : Posix.FileSys.ST.stat
			}
	  end
	structure P = Posix.FileSys
	structure PE = Posix.ProcEnv
	fun wrap (s:P.ST.stat) : ST.stat =
	    {dev       = DEV (SysWord.toInt (P.devToWord (P.ST.dev s))),
	     ino       = I_NODE (SysWord.toInt (P.inoToWord (P.ST.ino s))),
	     mode      = SysWord.toInt (P.S.toWord (P.ST.mode s)),
	     nlink     = P.ST.nlink s,
	     uid       = SysWord.toInt (PE.uidToWord (P.ST.uid s)),
	     gid       = SysWord.toInt (PE.gidToWord (P.ST.gid s)),
	     rdev      = 0,
	     size      = P.ST.size s,
	     atime     = P.ST.atime s,
	     mtime     = P.ST.mtime s,
	     ctime     = P.ST.ctime s,
	     blksize   = 4096,  (* used as buffer size for mkUnixWriter *)
	     blocks    = ((P.ST.size s) div 512) + 1,
	     zzwrapped = s
	    }

    in
    fun stat (pathname:string) : ST.stat = wrap (P.stat pathname)
    fun fstat (fd) : ST.stat = wrap (P.fstat fd)
    fun isdir (s:ST.stat) = P.ST.isDir (#zzwrapped s)
    fun mkdir (pathname:string, mode:S.mode):unit =
	P.mkdir (pathname, P.S.fromWord (SysWord.fromInt mode))
    end

    local
	exception Openf
	structure P = Posix.FileSys
	structure W = Word
	fun bit (pos) = W.toInt (W.<< (0w1, W.fromInt pos))
	fun anyp (i, mask) = not (W.andb (W.fromInt i, W.fromInt mask) = 0w0)
	fun flag (i, mask, f) = if anyp (i, mask) then f else P.O.flags []
    in
    val o_rdonly = bit 0
    val o_wronly = bit 1
    val o_append = bit 2
    val o_creat  = bit 3
    val o_trunc  = bit 4
    fun open_ (pathname:string, flags:int, perms:int) : P.file_desc =
	let val omode = (if anyp (flags, o_rdonly) then P.O_RDONLY
			 else if anyp (flags, o_wronly) then P.O_WRONLY
			 else raise Openf)
	    val oflags = P.O.flags [flag (flags, o_append, P.O.append),
				    flag (flags, o_trunc, P.O.trunc)]
	    val operms = P.S.fromWord (Word32.fromInt perms)
	in
	    if anyp (flags, o_creat)
	    then P.createf (pathname, omode, oflags, operms)
	    else P.openf (pathname, omode, oflags)
	end
    end

    (* http://www.smlnj.org/doc/SMLofNJ/pages/unsafe.html#SIG:UNSAFE.cast:VAL *)
    type T = int ref
    val tcast : 'a -> T = Unsafe.cast

    val env_refs = ref [] : (string * T) list ref

    fun add_env_function (name,f) =
	env_refs := (name,tcast f) :: !env_refs

    (* These may be all we need *)
    val _ =
	(add_env_function ("system os unix environment",environment);
	 add_env_function ("system os unix setwd",setwd);
	 add_env_function ("system os unix getwd",getwd);
	 add_env_function ("system os unix realpath",realpath);
	 add_env_function ("POSIX.FileSys.fstat", fstat);
	 add_env_function ("POSIX.FileSys.stat", stat);
	 add_env_function ("POSIX.FileSys.ST.isdir", isdir);
	 add_env_function ("POSIX.FileSys.mkdir", mkdir);
	 add_env_function ("system os unix open", open_);
	 add_env_function ("system os unix o_rdonly", o_rdonly);
	 add_env_function ("system os unix o_wronly", o_wronly);
	 add_env_function ("system os unix o_append", o_append);
	 add_env_function ("system os unix o_creat", o_creat);
	 add_env_function ("system os unix o_trunc", o_trunc);
	 add_env_function ("OS.FileSys.fullPath", OS.FileSys.fullPath);
	 add_env_function ("POSIX.FileSys.getcwd", Posix.FileSys.getcwd);
	 add_env_function ("POSIX.FileSys.access", Posix.FileSys.access);
	 add_env_function ("POSIX.FileSys.unlink", Posix.FileSys.unlink);
	 add_env_function ("OS.FileSys.modTime", OS.FileSys.modTime);
	 add_env_function ("Time.toReal", Time.toReal);
	 add_env_function ("Time.fromReal", Time.fromReal);
	 add_env_function ("Time.-", Time.-);
	 add_env_function ("Time.+", Time.+);
	 add_env_function ("real split", Real.split)
	)

    exception UnimplementedEnv of string
    fun unimplemented name =
	(TextIO.output (TextIO.stdOut, "unimplemented env function: "
				       ^ name ^ "\n");
	 raise UnimplementedEnv name)

in
fun nj_environment name =
    let
	fun trap _ = unimplemented ("Environment function " ^ name)
	fun lookup [] = tcast trap
	  | lookup ((name', f)::rest) =
	    if name' = name then f else lookup rest
    in
	TextIO.print ("D: nj_environment lookup: " ^ name ^ "\n");
	lookup (!env_refs)
    end
end
