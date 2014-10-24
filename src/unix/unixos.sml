(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * An interface to a misc. collection of features made available
 * on any operating system that claims to be UNIX.
 *
 * The preferred name of this signature is UNIX, but since there is
 * a desire to have a common naming scheme for signatures, structures and
 * functors and the functor Unix has already been used (see ./_unix.sml)
 * the compromise of UNIXOS was chosen.
 *
 * This is slowly being turned into a signature that matches basis POSIX
 * signature.
 * 
 * Revision Log
 * ------------
 *
 * $Log: unixos.sml,v $
 * Revision 1.23  1999/03/22 17:02:23  mitchell
 * [Bug #30286]
 * Support for the Unix structure
 *
 * Revision 1.22  1999/03/14  11:52:51  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 * Revision 1.21  1999/03/03  14:20:12  johnh
 * Change spec of fork_execv
 *
 * Revision 1.20  1999/02/03  10:45:05  mitchell
 * [Bug #190500]
 * Add back require statements for this file - edited the wrong file!!
 *
 * Revision 1.19  1999/02/02  16:02:00  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.18  1997/11/09  17:50:59  jont
 * [Bug #30089]
 * Modify rusage to return stime and utime as basis times
 *
 * Revision 1.17  1997/05/27  13:33:29  jkbrook
 * [Bug #01749]
 * Use __sys_word for SysWord structure
 *
 * Revision 1.16  1997/01/15  12:18:12  io
 * [Bug #1892]
 * rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 * Revision 1.15  1996/11/08  14:29:13  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 * Revision 1.14  1996/10/21  15:23:50  jont
 * Remove references to basis.toplevel
 *
 * Revision 1.13  1996/08/21  10:05:25  stephenb
 * [Bug #1554]
 * Change FileSys.file_desc to a type declaration since the
 * internal details of the type are not needed by clients
 * anymore.
 *
 * Revision 1.12  1996/08/09  10:28:55  daveb
 * [Bug #1536]
 * Made read and write use Word8Vector.vectors instead of strings.
 *
 * Revision 1.11  1996/07/17  17:12:25  andreww
 * [Bug #1453]
 * provding size function on file descriptors for up-to-date
 * revised basis IO.
 *
 * Revision 1.10  1996/06/10  11:56:54  stephenb
 * Add POSIX.FileSys.{openf,creatf,creat,link,umask} and
 * POSIX>FileSys.O.*
 *
 * Revision 1.9  1996/06/07  15:03:55  andreww
 * exposing unix IO constants in signature.
 *
 * Revision 1.8  1996/05/28  11:11:01  stephenb
 * Implement POSIX.Error.{errorName,syserror}
 *
 * Revision 1.7  1996/05/16  14:12:20  stephenb
 * Introduce the Error structure, move SysErr ... etc. into it
 * and implement Error.errorMsg.
 *
 * Revision 1.6  1996/05/03  15:51:09  stephenb
 * Add file_desc type so that it can be used as the basis for the
 * various file descriptor types that are required by OS and POSIX.
 * Also started POSIXification of the structure i.e. various routines
 * that were at the top level are now embedded in sub-structures that
 * follow the signatures defined in the latest basis revision.
 *
 * Revision 1.5  1996/04/01  11:08:08  stephenb
 * Rename the Unix exception to be SysErr.  This simplifies the
 * implementation of the Unix version of the OS interface in the
 * latest basis.
 *
 * Revision 1.4  1996/01/29  16:56:36  stephenb
 * unix.c reorganisation: change vfork_XXX to fork_XXX since vfork
 * isn't important as far as the user is concerned, all they are
 * after is a cheap fork and exec.
 *
 *  Revision 1.3  1996/01/24  16:54:43  stephenb
 *  Add af+imox. af_inet, sock_stream, sock_dgram so that the
 *  editor no longer has to pass magic constants to the socket call.
 *
 *  Revision 1.2  1996/01/22  14:07:02  stephenb
 *  Fix indentation - previous version was checked in without re-indenting it.
 *
 *  Revision 1.1  1996/01/22  09:28:10  stephenb
 *  new unit
 *  OS reorganisation: separated out of the pervasive library so
 *  that only UNIX OSes need support it.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__sys_word";
require "^.basis.__word8_vector";
require "^.basis.__position";
require "__time";

signature UNIXOS =
  sig

    structure Error : sig
      type syserror
      exception SysErr of (string * syserror option)
      val toWord : syserror -> Word32.word
      val fromWord : Word32.word -> syserror
      val errorMsg : syserror -> string
      val errorName : syserror -> string
      val syserror : string -> syserror option
    end

    exception WouldBlock

    datatype sockaddr = SOCKADDR_UNIX of string
    val environment     : unit -> string list
    val rusage :
      unit ->
      {idrss    : int,            (* integral resident set size *)
       inblock  : int,            (* block input operations *)
       isrss    : int,            (* currently 0 *)
       ixrss    : int,            (* currently 0 *)
       majflt   : int,            (* page faults requiring physical I/O *)
       maxrss   : int,            (* maximum resident set size *)
       minflt   : int,            (* page faults not requiring physical I/O *)
       msgrcv   : int,            (* messages received *)
       msgsnd   : int,            (* messages sent *)
       nivcsw   : int,            (* involuntary context switches *)
       nsignals : int,            (* signals received *)
       nswap    : int,            (* swaps *)
       nvcsw    : int,            (* voluntary context switches *)
       oublock  : int,            (* block output operations *)
       stime    : Time.time,      (* system time used *)
       utime    : Time.time}      (* user time used *)

    val bind            : int * sockaddr -> int
    val getsockname     : int -> sockaddr
    val getpeername     : int -> sockaddr
    val accept          : int -> int * sockaddr
    val listen          : int * int -> unit
    val execve          : string * string list * string list -> unit
    val execv           : string * string list -> unit
    val execvp          : string * string list -> unit
    val fork_execve     : string * string list * string list * int * int * int -> int
    val fork_execv      : string * string list * int * int * int -> int
    val fork_execvp     : string * string list -> int
    val kill            : int * int -> unit

    datatype iodesc = IODESC of int

    structure FileSys : sig
      type file_desc
      val fdToWord : file_desc -> Word32.word 
      val wordToFD : Word32.word -> file_desc 
      val fdToIOD : file_desc -> iodesc
      val iodToFD : iodesc -> file_desc

      type dirstream
      val opendir   : string -> dirstream
      val readdir   : dirstream -> string option
      val rewinddir : dirstream -> unit
      val closedir  : dirstream -> unit
      val chdir     : string -> unit
      val getcwd    : unit -> string
      val stdin     : file_desc
      val stdout    : file_desc
      val stderr    : file_desc

      structure S : sig
        type mode
        val irwxo : mode
      end

      structure O : sig
        eqtype flags
        val append : flags
        val excl : flags
        val noctty : flags
        val nonblock : flags
        val sync : flags
        val trunc : flags
      end


      datatype open_mode = O_RDONLY | O_WRONLY | O_RDWR

      val openf     : string * open_mode * O.flags -> file_desc
      val createf   : string * open_mode * O.flags * S.mode -> file_desc
      val creat     : string * S.mode -> file_desc
      val umask     : S.mode -> S.mode
      val link      : { old: string, new: string} -> unit
      val mkdir     : string * S.mode -> unit
      val unlink    : string -> unit
      val rmdir     : string -> unit
      val rename    : { new: string, old: string} -> unit
      val readlink  : string -> string

      eqtype dev

      val wordToDev : SysWord.word -> dev
      val devToWord : dev -> SysWord.word

      eqtype ino

      val wordToIno : SysWord.word -> ino
      val inoToWord : ino -> SysWord.word

      structure ST : sig
        type stat
        val isDir:  stat -> bool
        val isChr:  stat -> bool
        val isBlk:  stat -> bool
        val isReg:  stat -> bool
        val isFIFO: stat -> bool
        val isLink: stat -> bool
        val isSock: stat -> bool
        val mode:   stat -> S.mode
        val ino:    stat -> ino
        val dev:    stat -> dev
        val size:   stat -> Position.int
        val mtime:  stat -> Time.time
      end

      val stat      : string -> ST.stat
      val fstat     : file_desc -> ST.stat
      val lstat     : string -> ST.stat

      datatype access_mode = A_READ | A_WRITE | A_EXEC

      val access : (string * access_mode list) -> bool
      
      val utime : (string * {actime : Time.time, modtime : Time.time} option) -> unit

    end

    structure IO : sig
      val close : FileSys.file_desc -> unit
    end

    structure Process : sig
      eqtype pid
      val pidToWord : pid -> SysWord.word
      val wordToPid : SysWord.word -> pid
    end

    structure ProcEnv : sig
      eqtype pid
      val getpid : unit -> pid
    end

    val can_input       : FileSys.file_desc -> int
    val set_block_mode  : FileSys.file_desc * bool -> unit
    val open_   : string * int * int -> FileSys.file_desc
    val read    : FileSys.file_desc * int -> Word8Vector.vector
    val write   : FileSys.file_desc * Word8Vector.vector * int * int -> int
    val seek    : FileSys.file_desc * int * int -> int
    val size    : FileSys.file_desc -> int
    val socket  : int * int * int -> FileSys.file_desc
    val connect : FileSys.file_desc * sockaddr -> unit

    datatype passwd =
      PASSWD of {dir    : string,
                 gecos  : string,
                 gid    : int,
                 name   : string,
                 passwd : string,
                 shell  : string,
                 uid    : int}
    val getpwent        : unit -> passwd
    val setpwent        : unit -> unit
    val endpwent        : unit -> unit
    val getpwuid        : int -> passwd
    val getpwnam        : string -> passwd
    val af_unix         : int
    val af_inet         : int
    val sock_stream     : int
    val sock_dgram      : int
    
    val o_rdonly        : int
    val o_wronly        : int
    val o_append        : int
    val o_creat         : int
    val o_trunc         : int
  end
