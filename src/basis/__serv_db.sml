(* __serv-db.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __serv_db.sml,v $
 * Revision 1.2  1999/02/16 09:31:30  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:07:58  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "serv_db.sml";

structure NetServDB : NET_SERV_DB =
  struct

    val netdbFun = MLWorks.Internal.Runtime.environment

    datatype entry = SERVENT of {
          name : string,
          aliases : string list,
          port : int,
          protocol : string
        }

    local
      fun conc field (SERVENT a) = field a
    in
      val name = conc #name
      val aliases = conc #aliases
      val port = conc #port
      val protocol = conc #protocol
    end (* local *)

    (* Server DB query functions *)
    local
      type servent = (string * string list * int * string)
      fun getServEnt NONE = NONE
        | getServEnt (SOME(name, aliases, port, protocol)) = SOME(SERVENT{
              name = name, aliases = aliases, port = port, protocol = protocol
            })
      val getServerByName' : (string  * string option) -> servent option
            = netdbFun "system os getServByName"
      val getServerByPort' : (int  * string option) -> servent option
            = netdbFun "system os getServByPort"
    in
      val getByName = getServEnt o getServerByName'
      val getByPort = getServEnt o getServerByPort'
    end (* local *)
  end

