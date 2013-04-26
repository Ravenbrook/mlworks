(* Copyright (C) 1996 Harlequin Ltd.
 *
 * See ./unixos.sml
 *
 * Revision Log
 * ------------
 *
 * $Log: _unixos.sml,v $
 * Revision 1.29  1999/03/22 17:02:25  mitchell
 * [Bug #30286]
 * Support for the Unix structure
 *
 * Revision 1.28  1999/03/14  12:13:53  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 * Revision 1.27  1999/03/03  14:20:14  johnh
 * Change spec of fork_execv
 *
 * Revision 1.26  1997/11/09  17:51:29  jont
 * [Bug #30089]
 * Modify rusage to return stime and utime as basis times
 *
 * Revision 1.25  1997/05/27  13:33:47  jkbrook
 * [Bug #01749]
 * Use __sys_word for SysWord structure
 *
 * Revision 1.24  1997/03/18  11:04:24  andreww
 * [Bug #1431]
 * changing runtime call name of POSIX.Error.ErrorMsg/Name to make it
 * compatible with Win32 implementation.
 *
 * Revision 1.23  1997/01/15  12:22:44  io
 * [Bug #1892]
 * rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.22  1996/11/08  14:29:29  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 * Revision 1.21  1996/10/21  15:23:32  jont
 * Remove references to basis.toplevel
 *
 * Revision 1.20  1996/08/21  09:37:33  stephenb
 * [Bug #1554]
 * Redefine syserror and file_desc in terms of the newly
 * created MLWorks.Internal.Error.syserror and
 * MLWorks.Internal.IO.file_desc.
 *
 * Revision 1.19  1996/08/09  10:34:28  daveb
 * [Bug #1536]
 * Made read and write use Word8Vector.vectors instead of strings.
 *
 * Revision 1.18  1996/07/18  13:38:48  andreww
 * [Bug #1453]
 * provding size function on file descriptors for up-to-date
 * revised basis IO.
 *
 * Revision 1.17  1996/07/12  17:01:01  andreww
 * propagating changes to system calls etc. engendered by the need to dynamically
 * redirect IO through the GUI.
 *
 * Revision 1.16  1996/06/19  09:44:29  stephenb
 * Change the FileSys.dirstream type so that it holds some state to
 * indicate whether the stream is closed or not.  This is needed because
 * rewinddir doesn't give an error if you pass it a closed stream.
 *
 * Revision 1.15  1996/06/10  12:05:20  stephenb
 * Add POSIX.FileSys.{openf,creatf,creat,link,umask} and
 * POSIX>FileSys.O.*
 *
 * Revision 1.14  1996/06/07  15:03:58  andreww
 * exposing unix IO constants.
 *
 * Revision 1.13  1996/05/29  12:35:03  matthew
 * Fixing problem with SysErr
 *
 * Revision 1.12  1996/05/28  11:10:19  stephenb
 * Implement POSIX.Error.{errorName,syserror}
 *
 * Revision 1.11  1996/05/16  14:10:44  stephenb
 * Introduce the Error structure, move SysErr ... etc. into it
 * and implement Error.errorMsg.
 *
 * Revision 1.10  1996/05/08  13:53:34  matthew
 * Changes to Int structure
 *
 * Revision 1.9  1996/05/03  15:51:31  stephenb
 * Add file_desc type so that it can be used as the basis for the
 * various file descriptor types that are required by OS and POSIX.
 * Also started POSIXification of the structure i.e. various routines
 * that were at the top level are now embedded in sub-structures that
 * follow the signatures defined in the latest basis revision.
 *
 * Revision 1.8  1996/04/02  08:25:59  stephenb
 * typo fix: tmpnam -> tmpname
 *
 * Revision 1.7  1996/04/01  11:08:48  stephenb
 * Rename the Unix exception to be SysErr.  This simplifies the
 * implementation of the Unix version of the OS interface in the
 * latest basis.
 *
 * Revision 1.6  1996/03/20  12:21:33  matthew
 * Changes for language revisions
 *
 * Revision 1.5  1996/01/29  16:58:02  stephenb
 * unix.c reorganisation: change vfork_XXX to fork_XXX since vfork
 * isn't important as far as the user is concerned, all they are
 * after is a cheap fork and exec.
 *
 *  Revision 1.4  1996/01/24  16:57:25  stephenb
 *  Add af+imox. af_inet, sock_stream, sock_dgram so that the
 *  editor no longer has to pass magic constants to the socket call.
 *
 *  Revision 1.3  1996/01/23  09:52:27  stephenb
 *  Change a require to be NJSML compatible.
 *
 *  Revision 1.2  1996/01/22  14:46:04  stephenb
 *  Bind the declared exceptions to their C counterparts.
 *
 *  Revision 1.1  1996/01/22  09:27:27  stephenb
 *  new unit
 *  OS reorganisation: separated out of the pervasive library so
 *  that it only has to be supported on UNIX OSes.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__sys_word";
require "^.basis.__word8_vector";
require "^.basis.__position";
require "unixos";
require "__time";

functor UnixOS () : UNIXOS =
struct
  val env = MLWorks.Internal.Runtime.environment

  structure Error = struct
    type syserror = MLWorks.Internal.Error.syserror
    exception SysErr = MLWorks.Internal.Error.SysErr
    val toWord = Word32.fromInt
    val fromWord = Word32.toInt
    val errorMsg = MLWorks.Internal.Error.errorMsg
    val errorName = MLWorks.Internal.Error.errorName
    val syserror = MLWorks.Internal.Error.syserror
  end

  exception WouldBlock
  val would_block_ref = env "system os unix exception Would Block"
  val _ = would_block_ref := WouldBlock

  datatype sockaddr = SOCKADDR_UNIX of string
  val environment : unit -> string list = env "system os unix environment"
  val rusage :
    unit ->
      {idrss    : int,            (* integral resident set size *)
       inblock	: int,            (* block input operations *)
       isrss	: int,            (* currently 0 *)
       ixrss	: int,            (* currently 0 *)
       majflt	: int,            (* page faults requiring physical I/O *)
       maxrss	: int,            (* maximum resident set size *)
       minflt	: int,            (* page faults not requiring physical I/O *)
       msgrcv	: int,            (* messages received *)
       msgsnd	: int,            (* messages sent *)
       nivcsw	: int,            (* involuntary context switches *)
       nsignals	: int,            (* signals received *)
       nswap	: int,            (* swaps *)
       nvcsw	: int,            (* voluntary context switches *)
       oublock	: int,            (* block output operations *)
       stime	: Time.time,      (* system time used *)
       utime	: Time.time}      (* user time used *) = env "system os unix rusage"

  val getsockname : int -> sockaddr = env "system os unix getsockname"
  val getpeername : int -> sockaddr = env "system os unix getpeername"
  val accept : int -> int * sockaddr = env "system os unix accept"
  val listen : int * int -> unit = env "system os unix listen"
  val execve : string * string list * string list -> unit = env "system os unix execve"
  val execv : string * string list -> unit = env "system os unix execv"
  val execvp : string * string list -> unit = env "system os unix execvp"
  val fork_execve : string * string list * string list * int * int * int -> int  = env "system os unix fork_execve"
  val fork_execv : string * string list * int * int * int -> int = env "system os unix fork_execv"
  val fork_execvp : string * string list -> int = env "system os unix fork_execvp"



  datatype iodesc = IODESC of int


  structure FileSys = struct

    type file_desc = MLWorks.Internal.IO.file_desc
    fun fdToWord (MLWorks.Internal.IO.FILE_DESC i) = Word32.fromInt i
    fun wordToFD w = MLWorks.Internal.IO.FILE_DESC (Word32.toInt w)
    fun fdToIOD (MLWorks.Internal.IO.FILE_DESC fd) = IODESC fd
    fun iodToFD (IODESC iod) = MLWorks.Internal.IO.FILE_DESC iod

    datatype dirstream = DIRSTREAM of MLWorks.Internal.Value.T * bool
    val opendir : string -> dirstream = env "POSIX.FileSys.opendir"
    val readdir : dirstream -> string option = env "POSIX.FileSys.readdir"
    val rewinddir : dirstream -> unit = env "POSIX.FileSys.rewinddir"
    val closedir : dirstream -> unit = env "POSIX.FileSys.closedir"

    val chdir : string -> unit = env "POSIX.FileSys.chdir"
    val getcwd : unit -> string = env "POSIX.FileSys.getcwd"

    val stdin = MLWorks.Internal.IO.FILE_DESC 0
    val stdout = MLWorks.Internal.IO.FILE_DESC 1
    val stderr = MLWorks.Internal.IO.FILE_DESC 2

    structure S = struct
      type mode = int
      val irwxo = 511
    end


    structure O = struct
      type flags = int
      val append   : flags = env "POSIX.FileSys.O.append"
      val excl     : flags = env "POSIX.FileSys.O.excl"
      val noctty   : flags = env "POSIX.FileSys.O.noctty"
      val nonblock : flags = env "POSIX.FileSys.O.nonblock"
      val sync     : flags = env "POSIX.FileSys.O.sync"
      val trunc    : flags = env "POSIX.FileSys.O.trunc"
    end

    datatype open_mode = O_RDONLY | O_WRONLY | O_RDWR

    val openf : string * open_mode * O.flags -> file_desc =
      env "POSIX.FileSys.openf"

    val createf : string * open_mode * O.flags * S.mode -> file_desc =
      env "POSIX.FileSys.createf"

    val creat : string * S.mode -> file_desc = env "POSIX.FileSys.creat"

    val umask : S.mode -> S.mode = env "POSIX.FileSys.umask"

    val link : {new: string, old: string} -> unit = env "POSIX.FileSys.link"

    val mkdir : string * S.mode -> unit = env "POSIX.FileSys.mkdir"

    val rmdir : string -> unit = env "POSIX.FileSys.rmdir"

    val rename : {new: string, old: string} -> unit = env "POSIX.FileSys.rename"
    val unlink : string -> unit = env "POSIX.FileSys.unlink"

    val readlink : string -> string = env "POSIX.FileSys.readlink"


    datatype dev = DEV of int

    fun wordToDev w = DEV (SysWord.toInt w)
    fun devToWord (DEV d) = SysWord.fromInt d


    datatype ino = I_NODE of int

    fun wordToIno w = I_NODE (SysWord.toInt w)
    fun inoToWord (I_NODE i) = SysWord.fromInt i


    structure ST = struct
      type stat = 
        {dev	: dev,
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
         blocks	: int}

      val isDir:  stat -> bool = env "POSIX.FileSys.ST.isdir"
      val isChr:  stat -> bool = env "POSIX.FileSys.ST.ischr"
      val isBlk:  stat -> bool = env "POSIX.FileSys.ST.isblk"
      val isReg:  stat -> bool = env "POSIX.FileSys.ST.isreg"
      val isFIFO: stat -> bool = env "POSIX.FileSys.ST.isfifo"
      val isLink: stat -> bool = env "POSIX.FileSys.ST.islink"
      val isSock: stat -> bool = env "POSIX.FileSys.ST.issock"

      val mode : stat -> S.mode = #mode
      val ino : stat -> ino = #ino
      val dev : stat -> dev = #dev
      val size : stat -> Position.int = #size
      val mtime : stat -> Time.time = #mtime

    end

    val stat : string -> ST.stat = env "POSIX.FileSys.stat"
    val fstat : file_desc -> ST.stat = env "POSIX.FileSys.fstat"
    val lstat : string -> ST.stat = env "POSIX.FileSys.lstat"

    datatype access_mode = A_READ | A_WRITE | A_EXEC

    val access : (string * access_mode list) -> bool = env "POSIX.FileSys.access"

    local
      val utime_ : (string * Time.time * Time.time) -> unit = env "system os unix utime"
    in
      fun utime (pathName, NONE) = 
        let
          val now = Time.now ();
        in 
          utime_ (pathName, now, now)
        end
      |   utime (pathName, SOME {actime, modtime}) =
        utime_ (pathName, actime, modtime)
    end

  end

  structure IO = struct
    val close : FileSys.file_desc -> unit = MLWorks.Internal.IO.close
  end

  val can_input : FileSys.file_desc -> int = MLWorks.Internal.IO.can_input

  val set_block_mode : FileSys.file_desc * bool -> unit = 
    env "system os unix set block mode"

  val open_ : string * int * int -> FileSys.file_desc = 
    env "system os unix open"

  val read : FileSys.file_desc * int -> Word8Vector.vector = 
    MLWorks.Internal.Value.cast MLWorks.Internal.IO.read

  val write : FileSys.file_desc * Word8Vector.vector * int * int -> int = 
    MLWorks.Internal.Value.cast MLWorks.Internal.IO.write


  val seek : FileSys.file_desc * int * int-> int = MLWorks.Internal.IO.seek 

  val size : FileSys.file_desc -> int = FileSys.ST.size o FileSys.fstat

  val socket : int * int * int -> FileSys.file_desc = 
                                       env "system os unix socket"
  val connect : FileSys.file_desc * sockaddr -> unit = 
                                       env "system os unix connect"

  val bind : int * sockaddr -> int = env "system os unix bind"

    datatype passwd =
    PASSWD of {dir	: string,
	       gecos	: string,
	       gid	: int,
	       name	: string,
	       passwd	: string,
	       shell	: string,
	       uid	: int}


  val getpwent : unit -> passwd = env "system os unix getpwent"
  val setpwent : unit -> unit = env "system os unix setpwent"
  val endpwent : unit -> unit = env "system os unix endpwent"
  val getpwuid : int -> passwd = env "system os unix getpwuid"
  val getpwnam : string -> passwd = env "system os unix getpwnam"
  val kill : int * int -> unit = env "system os unix kill"

  val af_unix : int    = env "system os unix af_unix"
  val af_inet : int     = env "system os unix af_inet"
  val sock_stream : int = env "system os unix sock_stream"
  val sock_dgram  : int = env "system os unix sock_dgram"
  val o_rdonly    : int = env "system os unix o_rdonly"
  val o_wronly    : int = env "system os unix o_wronly"
  val o_append    : int = env "system os unix o_append"
  val o_creat     : int = env "system os unix o_creat"
  val o_trunc     : int = env "system os unix o_trunc"

end


