(* generic-sock.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell
 * Laboratories. All rights reserved.  
 *
 * $Log: __generic_sock.sml,v $
 * Revision 1.2  1999/02/16 09:31:24  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:07:49  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *
 *)

require "generic_sock.sml";
require "__pre_sock.sml";

structure GenericSock : GENERIC_SOCK =
  struct
    structure PS = PreSock

    val sockFn = MLWorks.Internal.Runtime.environment

    (* returns a list of the supported address families; this should include
     * at least:  Socket.AF.inet. *)
    fun addressFamilies () = raise Fail "GenericSock.addressFamilies"

    (* returns a list of the supported socket types; this should include at
     * least:  Socket.SOCK.stream and Socket.SOCK.dgram. *)
    fun socketTypes () = raise Fail "GenericSock.socketTypes"

    val c_socket        : (int * int * int) -> PS.socket
          = sockFn "system os socket"
    val c_socketPair    : (int * int * int) -> (PS.socket * PS.socket)
          = sockFn "system os socketPair"

    (* create sockets using default protocol *)
    fun socket (PS.AF(af, _), PS.SOCKTY(ty, _)) =
          PS.SOCK(c_socket (af, ty, 0))
    fun socketPair (PS.AF(af, _), PS.SOCKTY(ty, _)) = 
          let val (s1, s2) = c_socketPair (af, ty, 0)
           in (PS.SOCK s1, PS.SOCK s2)
          end

    (* create sockets using the specified protocol *)
    fun socket' (PS.AF(af, _), PS.SOCKTY(ty, _), prot) =
          PS.SOCK(c_socket (af, ty, prot))
    fun socketPair' (PS.AF(af, _), PS.SOCKTY(ty, _), prot) = 
          let val (s1, s2) = c_socketPair (af, ty, prot)
           in (PS.SOCK s1, PS.SOCK s2)
          end
  end

