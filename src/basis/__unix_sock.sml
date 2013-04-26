(* unix-sock.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __unix_sock.sml,v $
 * Revision 1.2  1999/02/16 09:31:32  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:08:02  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "unix_sock.sml";
require "__pre_sock.sml";
require "__socket.sml";
require "__generic_sock.sml";
require "__option";

structure UnixSock : UNIX_SOCK =
  struct
    structure SOCK = Socket.SOCK

    val sockFn = MLWorks.Internal.Runtime.environment

    datatype unix = UNIX

    type 'a sock = (unix, 'a) Socket.sock
    type 'a stream_sock = 'a Socket.stream sock
    type dgram_sock = Socket.dgram sock

    type sock_addr = unix Socket.sock_addr

    val unixAF = Option.valOf(Socket.AF.fromString "UNIX")

    (* We should probably do some error checking on the length of the string *)
    local
      val toUnixAddr : string -> PreSock.addr = sockFn "system os toUnixAddr"
      val fromUnixAddr : PreSock.addr -> string = sockFn "system os fromUnixAddr"
    in
      fun toAddr s = PreSock.ADDR(toUnixAddr s)
      fun fromAddr (PreSock.ADDR addr) = fromUnixAddr addr
    end

    structure Strm =
      struct
        fun socket () = GenericSock.socket (unixAF, SOCK.stream)
        fun socket' proto = GenericSock.socket' (unixAF, SOCK.stream, proto)
        fun socketPair () = GenericSock.socketPair (unixAF, SOCK.stream)
        fun socketPair' proto = GenericSock.socketPair' (unixAF, SOCK.stream, proto)
      end
    structure DGrm =
      struct
        fun socket () = GenericSock.socket (unixAF, SOCK.dgram)
        fun socket' proto = GenericSock.socket' (unixAF, SOCK.dgram, proto)
        fun socketPair () = GenericSock.socketPair (unixAF, SOCK.dgram)
        fun socketPair' proto = GenericSock.socketPair' (unixAF, SOCK.dgram, proto)
      end
  end;

