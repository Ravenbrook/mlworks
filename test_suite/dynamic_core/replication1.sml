(* Tests that replicated datatypes share the same constructors
   with their originals.

Result: OK
 
$Log: replication1.sml,v $
Revision 1.1  1996/09/20 12:41:42  andreww
new unit
Tests for datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

fun reportOK true = print "Test succeeded.\n"
  | reportOK false = print "Test failed.\n"

datatype fruit = apple | banana;
datatype yoghurt = datatype fruit;

val _ = let val x = apple:yoghurt val y = apple:fruit in
            reportOK(x = y)
        end;
