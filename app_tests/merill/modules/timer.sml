(*
 *
 * $Log: timer.sml,v $
 * Revision 1.2  1998/06/08 17:37:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
 

(*

 A timing function, for NJML only.  

Wrap any function call in a suspend using a unit argument function then call this
function to get timed results.

eg to time the evaluation of expression: exp
call
timer (fn () => exp)

BMM  14-11-90

 *)

structure Timer = 
struct

(*
type time = System.Timer.time
*)

fun timer f = 
    let (*val t = System.Timer.start_timer ()*)
        val answer = f ()
(*
        val non_gc_time = System.Timer.check_timer t
        val gc_time = System.Timer.check_timer_gc t
        val total = System.Timer.add_time(non_gc_time,gc_time)
*)
    in 
    ((*write_terminal ("\nExecution Time: " ^ (System.Timer.makestring non_gc_time) ^
                     "\nGarbage Collecting Time: " ^ (System.Timer.makestring gc_time) ^
                    "\nTotal Time: " ^ (System.Timer.makestring total) ^ "\n");*)
     answer)
    end 

val start_timer = (*System.Timer.start_timer*)fn _ => ()
val check_timer = (*System.Timer.check_timer*)fn _ => ()
val check_timer_gc = (*System.Timer.check_timer_gc*)fn _ => ()
val add_time = (*System.Timer.add_time*)fn _ => ()
val show_time = (*System.Timer.makestring*)fn _ => "unknown"

end (* of structure Timer *) ;
