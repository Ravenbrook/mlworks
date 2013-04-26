(*
 *
 * $Log: time.sml,v $
 * Revision 1.2  1998/06/03 11:47:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature TIME =
sig

  val timer_start : unit -> System.Timer.timer
  val timer_read : System.Timer.timer -> real * real * real

end  (* signature TIME *)

functor Time () : TIME =
struct

   val timer_start = fn () => System.Timer.start_timer()

   val timer_read = fn timer => 	
          let val extract = fn (System.Timer.TIME {usec,sec}) =>
					 (real usec)/1.0E6+(real sec)
	      val non_gc_time = extract (System.Timer.check_timer timer)
	      val gc_time = extract (System.Timer.check_timer_gc timer)
	      val total = gc_time + non_gc_time
	   in (non_gc_time,gc_time,total) end

end  (* functor Time *)
