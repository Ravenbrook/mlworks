(* Tests that the example given in G.6 of the definition
   actually works.

Result: OK
 
$Log: replication1.sml,v $
Revision 1.1  1996/09/19 09:43:11  andreww
new unit
Test for datatype replication.


Copyright (c) 1996 Harlequin Ltd.
*)

fun reportOK true = print "Test succeeded.\n"
  | reportOK false = print "Test failed.\n"

signature MYBOOL =
  sig
    type bool
    val xor: bool * bool -> bool
  end;

structure MyBool: MYBOOL =
  struct
    datatype bool = datatype bool (*from the initial basis*)
    fun xor(true,false) = true
      | xor(false,true) = true
      | xor _ = false
  end;

val _ = reportOK(MyBool.xor(true,false));
