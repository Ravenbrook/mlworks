(* net-db.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: net_db.sml,v $
 * Revision 1.2  1999/02/16 09:31:36  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:08:09  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "__string_cvt";

signature NET_DB =
  sig
    eqtype net_addr
    type addr_family
    type entry
    val name      : entry -> string
    val aliases   : entry -> string list
    val addrType  : entry -> addr_family
    val addr      : entry -> net_addr
    val getByName : string -> entry option
    val getByAddr : (net_addr * addr_family) -> entry option

    val scan       : (char, 'a) StringCvt.reader 
                       -> (net_addr, 'a) StringCvt.reader
    val fromString : string -> net_addr option
    val toString   : net_addr -> string
  end







