(*
 *
 * $Log: stest.sig,v $
 * Revision 1.2  1998/06/11 12:59:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* This is just for parsing, really *)
signature STEST =
    sig
	structure N: SNAME

	type test

	val mkstr   : test -> string
	val eq      : test * test -> bool

	val True    : test
	val match   : N.name * N.name -> test
	val join    : test * test -> test
	val sigma   : test -> (N.name * N.name) list

    end
