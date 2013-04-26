(*
Like local_datatypes1.sml, but this time wraps everything in an
enclosing structure.

Result: OK

$Log: local_datatypes4.sml,v $
Revision 1.1  1996/10/04 18:36:15  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

structure A =
struct
  structure X =
    struct 
      datatype porridge = salty | sweet
    end;
    
  structure S =
    struct
      datatype fruit = apple of X.porridge
      fun defruit (apple X.salty) = 1
        | defruit (apple X.sweet) = 2
    end;
end;
