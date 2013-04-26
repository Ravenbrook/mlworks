(*
Ensure compiler handles typechecker failure of strid binding in open
Result: FAIL
 
$Log: open.sml,v $
Revision 1.1  1995/08/29 15:12:04  jont
new unit


Copyright (c) 1995 Harlequin Ltd.
*)

structure S =
  struct 
    structure F :
      sig
	val x: int 
      end =
      struct
      end
    open F
  end

