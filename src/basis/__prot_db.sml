(* __prot-db.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __prot_db.sml,v $
 * Revision 1.2  1999/02/16 09:31:29  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:07:57  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "prot_db.sml";

structure NetProtDB : NET_PROT_DB =
  struct

    val netdbFun = MLWorks.Internal.Runtime.environment

    datatype entry = PROTOENT of {
          name : string,
          aliases : string list,
          protocol : int
        }

    local
      fun conc field (PROTOENT a) = field a
    in
      val name = conc #name
      val aliases = conc #aliases
      val protocol = conc #protocol
    end (* local *)

    (* Protocol DB query functions *)
    local
      type protoent = (string * string list * int)
      fun getProtEnt NONE = NONE
        | getProtEnt (SOME(name, aliases, protocol)) = SOME(PROTOENT{
              name = name, aliases = aliases, protocol = protocol
            })
      val getProtByName' : string -> protoent option = 
            netdbFun "system os getProtByName"
      val getProtByNumber' : int -> protoent option = 
            netdbFun "system os getProtByNum"
    in
      val getByName = getProtEnt o getProtByName'
      val getByNumber = getProtEnt o getProtByNumber'
    end (* local *)
  end






