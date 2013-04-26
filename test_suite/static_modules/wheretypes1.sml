(*
Tests that where type instantiation does not maximise equality.
Example due to Frank Pfenning.

Result: OK

$Log: wheretypes1.sml,v $
Revision 1.1  1996/11/04 15:51:39  andreww
new unit
test.


Copyright (C) 1996 Harlequin Ltd

*)


      signature FOO =
      sig
  	  type ind (* parameter type *)
  	  datatype foobar = One of ind
      end;
  
     functor Foo (type ind')
  	  :> FOO where type ind = ind' =
       struct
  	  type ind = ind'
  	  datatype foobar = One of ind
       end;
  
     structure IntFoo :> FOO where type ind = int
 	  = Foo (type ind' = int);
  
