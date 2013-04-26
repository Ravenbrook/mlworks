(* inet-sock.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: inet_sock.sml,v $
 * Revision 1.2  1999/02/16 09:31:35  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:08:07  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "__host_db.sml";
require "__socket.sml";

signature INET_SOCK =
  sig
    type inet

    type 'a sock = (inet, 'a) Socket.sock
    type 'a stream_sock = 'a Socket.stream sock
    type dgram_sock = Socket.dgram sock

    type sock_addr = inet Socket.sock_addr

    val inetAF : Socket.AF.addr_family   (* DARPA internet protocols *)

    val toAddr   : (NetHostDB.in_addr * int) -> sock_addr
    val fromAddr : sock_addr -> (NetHostDB.in_addr * int)
    val any  : int -> sock_addr

    structure UDP : sig
        val socket  : unit -> dgram_sock
        val socket' : int -> dgram_sock
      end

    structure TCP : sig
        val socket  : unit -> 'a stream_sock
        val socket' : int -> 'a stream_sock

        (* tcp control options *)
        val getNODELAY : 'a stream_sock -> bool
        val setNODELAY : ('a stream_sock * bool) -> unit
      end
  end


