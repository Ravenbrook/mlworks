(* generic-sock.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: generic_sock.sml,v $
 * Revision 1.2  1999/02/16 09:31:33  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:08:03  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "__socket.sml";

signature GENERIC_SOCK =
  sig
    val addressFamilies : unit -> Socket.AF.addr_family list
    (* returns a list of the supported address families; this should include
     * at least:  Socket.AF.inet. *)

    val socketTypes : unit -> Socket.SOCK.sock_type
    (* returns a list of the supported socket types; this should include at
     * least:  Socket.SOCK.stream and Socket.SOCK.dgram.  *)

    (* create sockets using default protocol *)
    val socket : (Socket.AF.addr_family * Socket.SOCK.sock_type)
          -> ('a, 'b) Socket.sock
    val socketPair : (Socket.AF.addr_family * Socket.SOCK.sock_type)
          -> (('a, 'b) Socket.sock * ('a, 'b) Socket.sock)

    (* create sockets using the specified protocol *)
    val socket' : (Socket.AF.addr_family * Socket.SOCK.sock_type * int)
          -> ('a, 'b) Socket.sock
    val socketPair' : (Socket.AF.addr_family * Socket.SOCK.sock_type * int)
          -> (('a, 'b) Socket.sock * ('a, 'b) Socket.sock)
  end


