(* pre-sock.sml
 *
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * These are some common type definitions used in the sockets library.  This
 * structure is called Sock, so that the signatures will compile.
 *
 * $Log: __pre_sock.sml,v $
 * Revision 1.3  1999/02/18 15:09:35  mitchell
 * [Bug #190507]
 * Modify to satisfy CM constraints.
 *
 *  Revision 1.2  1999/02/16  09:31:28  mitchell
 *  [Bug #190508]
 *  Improve layout
 *
 *  Revision 1.1  1999/02/15  14:07:55  mitchell
 *  new unit
 *  [Bug #190508]
 *  Add socket support to the basis library
 *
 *)

require "__string_cvt";
require "__sys_word";
require "__word";
require "__word8";
require "__word8_vector";
require "__list";
require "__general";

structure PreSock =
  struct
    type system_const = (int * string)

    exception SysConstNotFound of string

    fun findSysConst (name, l) = 
        let
          fun look [] = NONE
            | look ((sysConst : system_const)::r) = 
                if (#2 sysConst = name) then SOME sysConst else look r
        in
          look l
        end

    fun bindSysConst (name, l) = 
        case findSysConst(name, l) of
          (SOME sc) => sc
        | NONE => raise(SysConstNotFound name)

    (* the raw representation address data *)
    type addr = Word8Vector.vector

    (* the raw representation of an address family *)
    type af = system_const

    (* the raw representation of a socket (a file descriptor for now) *)
    type socket = int

    (* an internet address; this is here because it is abstract in the
     * NetHostDB and IP structures. *)
    datatype in_addr = INADDR of addr

    (* an address family *)
    datatype addr_family = AF of af

    (* socket types *)
    datatype sock_type = SOCKTY of system_const

    (* sockets are polymorphic; the instantiation of the type variables
     * provides a way to distinguish between different kinds of sockets.  *)
    datatype ('sock, 'af) sock = SOCK of socket
    datatype 'af sock_addr = ADDR of addr

    (** Utility functions for parsing/unparsing network addresses **)
    local
      structure SysW = SysWord
      structure SCvt = StringCvt
      fun toW (getc, strm) = 
          let
            fun scan radix strm = 
                (case (SysW.scan radix getc strm) of
                   NONE => NONE
                 | (SOME(w, strm)) => SOME(w, strm) )
          in
            case (getc strm) of
              NONE => NONE
            | (SOME(#"0", strm')) => 
                (case (getc strm') of
                   NONE => SOME(0w0, strm')
                 | (SOME(#"x", strm'')) => scan SCvt.HEX strm''
                 | (SOME(#"X", strm'')) => scan SCvt.HEX strm''
                 | _ => scan SCvt.OCT strm )
            | _ => scan SCvt.DEC strm
          end

      (* check that the word is representable in the given number of bits; 
       * raise Overflow if not. *)
      fun chk (w, bits) =
          if (SysW.>= (SysW.>>(0wxffffffff, Word.-(0w32, bits)), w))
          then w
          else raise General.Overflow

      (* Scan a sequence of numbers separated by #"." *)
      fun scan getc strm = 
          (case toW (getc, strm) of 
             NONE => NONE
           | SOME(w, strm') => scanRest getc ([w], strm') )

      and scanRest getc (l, strm) = 
          (case getc strm of
             SOME(#".", strm') => (case toW (getc, strm')
                   of NONE => SOME(List.rev l, strm)
                    | SOME(w, strm'') => scanRest getc (w::l, strm'')
                  (* end case *))
           | _ => SOME(List.rev l, strm) )

    in
      fun toWords getc strm = 
          (case (scan getc strm) of
             SOME([a, b, c, d], strm) => 
               SOME([chk(a, 0w8), chk(b, 0w8), chk(c, 0w8), chk(d, 0w8)], strm)
          | SOME([a, b, c], strm) =>
              SOME([chk(a, 0w8), chk(b, 0w8), chk(c, 0w16)], strm)
          | SOME([a, b], strm) =>
              SOME([chk(a, 0w8), chk(b, 0w24)], strm)
          | SOME([a], strm) =>
              SOME([chk(a, 0w32)], strm)
          | _ => NONE )

      fun fromBytes (a, b, c, d) = 
          let val fmt = Word8.fmt StringCvt.DEC
           in concat [fmt a, ".", fmt b, ".", fmt c, ".", fmt d]
          end
    end
  end; (* PreSock *)

(* We alias this structure to Socket so that the signature files will compile.
 * We also need to keep the PreSock structure visible, so that structures
 * compiled after the real Sock structure still have access to the 
 * representation types.
 *)

(* structure Socket = PreSock; *)

