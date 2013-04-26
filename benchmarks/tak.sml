(* $Log: tak.sml,v $
 * Revision 1.1  1997/01/07 12:46:39  matthew
 * new unit
 * New unit
 * *)

(* Copyright (C) 1996, The Harlequin Group Limited *)

use "utils/benchmark";

structure Tak =
  struct
    fun tak (x,y,z) = 
      if x <= y 
        then z
      else tak (tak (x-1,y,z), tak(y-1,z,x), tak(z-1,x,y))
    fun tak_test() =
      tak(18,12,6)
  end;

test "simple tak" 500 Tak.tak_test ()
