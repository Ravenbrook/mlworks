(*
 *
 * $Log: Env.sig,v $
 * Revision 1.2  1998/06/02 15:20:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Env.sig,v 1.2 1998/06/02 15:20:47 jont Exp $";
(************************************ Env ************************************)
(*                                                                           *)
(*  Module for Environments.                                                 *)
(*                                                                           *)
(*****************************************************************************)

signature ENV =
sig
   structure V : VAR

   type 'a env

   exception Unbound

   val empty      : 'a env
   val isempty    : 'a env -> bool
   val lookup     : V.var * 'a env -> 'a
   val bind       : V.var * 'a * 'a env -> 'a env
   val unbind     : V.var * 'a env -> 'a env
   val map        : (V.var * 'a -> V.var * 'b) -> 'a env -> 'b env
   val exists     : (V.var * 'a -> bool) -> 'a env -> bool
   val forall     : (V.var * 'a -> bool) -> 'a env -> bool
   val merge      : 'a env * 'a env -> 'a env
   val getvars    : 'a env -> V.var list
   val mkstr      : ('a -> string) -> 'a env ->
                    string * string * string * string -> string
   val mkstr2     : ('a -> string) -> 'a env -> string
   val eq         : ('a * 'a -> bool) -> 'a env * 'a env -> bool
   val le         : ('a * 'a -> bool) -> 'a env * 'a env -> bool
end

