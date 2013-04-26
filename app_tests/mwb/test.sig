(*
 *
 * $Log: test.sig,v $
 * Revision 1.2  1998/06/11 12:56:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature TEST =
    sig
	structure N: NAME

	type test

	val mkstr   : test -> string
	val makstr  : test * (string list) -> string
	val eq      : test * test -> bool
	val names : test -> N.name list
	val domain : test -> N.name list
	val free_names: test * int -> N.name list
(*	val substitute : N.name * N.name * test -> test *)

	val beta_reduce : test -> (N.name list * int) -> test

	val True    : test
	val match   : N.name * N.name -> test
	val join    : test * test -> test

	val implies : test * test -> bool
	val sigma   : test -> (N.name * N.name) list
    end
