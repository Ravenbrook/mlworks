(*
 *
 * Result: OK
 * 
 * $Log: update_exn.sml,v $
 * Revision 1.2  1997/10/09 11:33:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *)

exception exn_a
exception exn_b

fun test i = if i mod 2 = 0 then raise exn_a else raise exn_b

val foo = test 6 handle exn_a => print"exn_a\n" | exn_b => print"exn_b\n" | _ => print"no such exception\n"

val _ = MLWorks.Internal.Value.update_exn(exn_a, ref exn_b)

val bar = test 6 handle exn_a => print"exn_a\n" | exn_b => print"exn_b\n" | _ => print"no such exception\n"
