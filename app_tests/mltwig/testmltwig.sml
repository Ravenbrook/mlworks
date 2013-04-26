(*
 *
 * $Log: testmltwig.sml,v $
 * Revision 1.2  1998/06/10 16:55:42  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* This file compiles ML-Twig, translates the sample specification
   example.mtw to SML and loads it, and finally compiles a simple
   arithmetic expression to a sequence of instructions. *)

use "build.sml";

Main.main "example_mtw";

use "runtime.sml";
use "example_mtw.sml";

open TreeProcessor;
open TreeProcessor.User;

translate (Tree (Tree (Leaf 1,Mul,Leaf 2),Plus,Leaf 3));
