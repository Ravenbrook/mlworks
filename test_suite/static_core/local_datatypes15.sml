(*
checks that sharing of typenames isn't screwed up.

Result: OK

$Log: local_datatypes15.sml,v $
Revision 1.1  1996/10/04 18:38:07  andreww
new unit
new test.


Copyright (c) 1996 Harlequin Ltd.
*)

functor Orangutan(structure Hairy: sig type burp end
                  structure Grunty: sig type hiccup end
                  sharing type Hairy.burp = Grunty.hiccup
                  ) =
struct
end;



