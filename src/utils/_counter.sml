(* _counter.sml the functor *)
(*
$Log: _counter.sml,v $
Revision 1.4  1992/01/29 11:12:55  clive
Added code to compute the next value that a counter would take given
its existing value

Revision 1.3  1992/01/28  12:30:58  clive
Added a previous counter function

Revision 1.2  1991/11/21  17:00:29  jont
Added copyright message

Revision 1.1  91/06/07  15:56:28  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "counter";

functor Counter (): COUNTER =
    struct
	local 
	    val count = ref 0
	in
	    fun counter () = 
		let val ref x = count
		in
		    (count := (x + 1);
		     x)
		end 

              fun previous_count x =
                (x-1)
                
              fun next_count x =
                (x+1)

	    fun reset_counter n =
	      (count := n;
	       ())

	    fun read_counter () = !count
	      
	end
    end
