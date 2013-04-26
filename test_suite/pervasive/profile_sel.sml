(*
 * Result: OK
 * 
 * $Log: profile_sel.sml,v $
 * Revision 1.1  1996/11/28 15:55:48  nickb
 * new unit
 * Addresses MLWorks bug 1808.
 *
 * 
 * Copyright (C) 1996 the Harlequin Group Limited
*)

(* MLWorks bug 1808: if selector functions allocate at all, there
 * could be a fatal failure in the profiler. If they allocate
 * much, and cause a GC, there could be a different fatal failure in the
 * profiler.
 *)

local
  val lr : int list ref = ref []
  fun mklist (0,l) = lr := l
    | mklist (n,l) = mklist(n-1,n::l)
  val manner = MLWorks.Profile.make_manner {time = false,
					    space = true,
			                    calls = false,
					    copies = false,
					    depth = 0,
					    breakdown = []};
  fun selector _ = (mklist(10,[]);
		    manner)
  val options = MLWorks.Profile.Options {scan = 0, selector = selector}
  val (result, profile) = MLWorks.Profile.profile options (fn () => ()) ()
in
  val result = "Success"
end
