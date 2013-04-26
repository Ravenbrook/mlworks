(* __host-db.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __host_db.sml,v $
 * Revision 1.2  1999/02/16 09:31:25  mitchell
 * [Bug #190508]
 * Improve layout
 *
 *  Revision 1.1  1999/02/15  14:07:52  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *
 *)

require "host_db.sml";
require "__pre_sock.sml";
require "__string_cvt";
require "__sys_word";
require "__word8";
require "__word8_vector";
require "__list";

structure NetHostDB : NET_HOST_DB =
  struct
    structure SysW = SysWord

    val netdbFun = MLWorks.Internal.Runtime.environment

    type in_addr = PreSock.in_addr
    type addr_family = PreSock.addr_family

    datatype entry = HOSTENT of {
          name : string,
          aliases : string list,
          addrType : addr_family,
          addrs : in_addr list
        }

    local
      fun conc field (HOSTENT a) = field a
    in
      val name = conc #name
      val aliases = conc #aliases
      val addrType = conc #addrType
      val addrs = conc #addrs
      val addr = List.hd o addrs
    end (* local *)

    (* Host DB query functions *)
    local
      type hostent = (string * string list * PreSock.af * PreSock.addr list)
      fun getHostEnt NONE = NONE
        | getHostEnt (SOME(name, aliases, addrType, addrs)) = SOME(HOSTENT{
              name = name, aliases = aliases,
              addrType = PreSock.AF addrType,
              addrs = List.map PreSock.INADDR addrs
            })
      val getHostByName' : string -> hostent option = 
            netdbFun "system os getHostByName"
      val getHostByAddr' : PreSock.addr -> hostent option = 
            netdbFun "system os getHostByAddr"
    in
      val getByName = getHostEnt o getHostByName'
      fun getByAddr (PreSock.INADDR addr) = getHostEnt(getHostByAddr' addr)
    end (* local *)

    fun scan getc strm = 
        let
          fun w2b w = Word8.fromLargeWord(SysW.toLargeWord w)
          fun getB (w, shft) = SysW.andb(SysW.>>(w, shft), 0wxFF)
          fun mkAddr (a, b, c, d) = PreSock.INADDR(Word8Vector.fromList[
                  w2b a, w2b b, w2b c, w2b d
                ])
        in
          case (PreSock.toWords getc strm) of
            SOME([a, b, c, d], strm) =>
              SOME(mkAddr(a, b, c, d), strm)
          | SOME([a, b, c], strm) =>
              SOME(mkAddr(a, b, getB(c, 0w8), getB(c, 0w0)), strm)
          | SOME([a, b], strm) =>
              SOME(mkAddr(a, getB(b, 0w16), getB(b, 0w8), getB(b, 0w0)), strm)
          | SOME([a], strm) =>
              SOME(mkAddr(getB(a, 0w24), getB(a, 0w16), getB(a, 0w8), getB(a, 0w0)), strm)
          | _ => NONE
        end

    val fromString = StringCvt.scanString scan

    fun toString (PreSock.INADDR addr) = 
        let fun get i = Word8Vector.sub(addr, i)
         in PreSock.fromBytes(get 0, get 1, get 2, get 3)
        end

    val getHostName : unit -> string = netdbFun "system os getHostName"
  end









