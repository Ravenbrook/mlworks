(*
Checks for a nasty bug (506) with tyvar levels

Result: FAIL
 
$Log: imptyvar3.sml,v $
Revision 1.1  1993/12/16 14:11:36  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

let 
    val x = 3
    val stack = ref [] 
  in 
    let
      fun push x = stack := (x :: !stack) 
      fun pop () = case !stack of (a::l) => (stack := l;a) | _ => raise Mod 
    in 
      push 1; 
      (pop ()) 3;
      4 
    end
end;
