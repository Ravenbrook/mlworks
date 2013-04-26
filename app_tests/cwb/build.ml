(*
 *
 * $Log: build.ml,v $
 * Revision 1.2  1998/06/02 15:13:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(* 	$Id: build.ml,v 1.2 1998/06/02 15:13:36 jont Exp $	 *)
val uses = map (fn s => use ("src/" ^ s));

val _ = uses ["common.ml"];

(* Hashing code from the SML/NJ Library, version 0.1 *)  
val _ = uses ["hash-string.sml",				       
               "hash-key-sig.sml",				       
               "hash-table-sig.sml",				       
               "hash-table.sml"];				       

(* slightly hacked from SML-NJ library, version 0.1 *)
val _ = uses ["name-sig.sml","name.sml"]

val _ = uses ["SortedList.sig","SortedList.str"];

structure SL = SL();

val _ = uses ["Var.sig","Var.str"];

structure V = Var ();

val _ = uses ["Env.sig","Env.str"];

structure E = Env(structure V=V; structure SL=SL);

val _ = uses ["Trie.sig","Trie.str"];

structure Trie = Trie( );

(* slightly perverse way to do this? If there is an argument, use it,  *)
(* else use "both". Then check that we haven't got nonsense,	       *)
(* i.e. something other than ccs or sccs; if we have, use "both".      *)

(* MLA -- Remove stuff with argv *)

val wb = let val version = "both"
	 in if version = "ccs" orelse version = "sccs" then version
	    else "both"
	 end;

(*
val wb = let val version = 
             if not(null(tl(System.Unsafe.CInterface.argv())))
		 then hd(tl(System.Unsafe.CInterface.argv()))
	     else "both"
	 in if version = "ccs" orelse version = "sccs" then version
	    else "both"
	 end;
*)

(* need to have both of these fns defined here, even though only one   *)
(* may be "really' defined. *)
val  ccs_cwb = fn () => ();
val sccs_cwb = fn () => ();

case wb of
    "ccs"  => use "make_ccs.ml"
  | "sccs" => use "make_sccs.ml"
  |  _     => (use "make_ccs.ml";use"make_sccs.ml");

(* the run-time command line argument is ignored if we only compiled   *)
(* one version of the workbench (with no error message?!), but if we   *)
(* compiled both, then it determines which top fn we use at runtime.   *)
fun top s =
    case wb of
        "ccs" => 
          (ccs_cwb()
           handle _ => print "\nSorry! An ML exception has been raised.\n")
      | "sccs" => 
          (sccs_cwb()
           handle _ => print "\nSorry! An ML exception has been raised.\n")
      | _ => 
           (if s="sccs" then sccs_cwb() else ccs_cwb()
           handle _ => print "\nSorry! an ML exception has been raised.\n")

(* exportedfun calls top with argument the second commandline arg,     *)
(* i.e. the first one that isn't "cwb"! If none, uses ccs as default.  *)
fun exportedfun (_::s::_,_) = top s
  | exportedfun _ = top "ccs";

(* exportFn ("cwb", exportedfun); *)
