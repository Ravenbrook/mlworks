signature THREADS =
sig
  type 'a thread

  val fork : ('a -> 'b) -> 'a -> 'b thread
  val yield : unit -> unit

  datatype 'a result =
    Running		(* still running *)
  | Waiting		(* waiting *)
  | Sleeping		(* sleeping *)
  | Result of 'a	(* completed, with this result *)
  | Exception of exn	(* exited with this uncaught exn *)
  | Died		(* died (e.g. bus error) *)
  | Killed		(* killed *)
  | Expired		(* no longer exists (from a previous image) *)
    
  val result : 'a thread -> 'a result

  structure Internal :
    sig
      eqtype thread_id

      val id : unit -> thread_id		(* this thread *)
      val get_id : 'a thread -> thread_id	(* that thread *)

      val children : thread_id -> thread_id list
      val parent : thread_id -> thread_id

      val all : unit -> thread_id list		(* all threads *)

      val kill : thread_id -> unit		(* kill a thread *)
      val raise_in : thread_id * exn -> unit	(* raise exn in the thread *)
      val yield_to : thread_id -> unit		(* fiddle with scheduling *)

      val state : thread_id -> unit result	(* the state of that thread *)
      val get_num : thread_id -> int		(* the 'thread number' *)

      val set_handler : (unit -> unit) -> unit (* restart fn for this thread *)
	
      structure Preemption : 
	sig
	  val start : unit -> unit
	  val stop : unit -> unit
	  val on : unit -> bool
	  val get_interval : unit -> int	(* milliseconds *)
	  val set_interval : int -> unit
	end
    end
end;

(*
structure Threads : THREADS =
struct
  datatype 'a result =
    Running		(* still running *)
  | Waiting		(* waiting *)
  | Sleeping		(* sleeping *)
  | Result of 'a	(* completed, with this result *)
  | Exception of exn	(* exited with this uncaught exn *)
  | Died		(* died (e.g. bus error) *)
  | Killed		(* killed *)
  | Expired		(* no longer exists (from a previous image) *)
    
  datatype 'a thread =
    Thread of MLWorks.Internal.Value.ml_value result ref * int

  local
    fun get x =
      (MLWorks.Internal.Value.cast
       (MLWorks.Internal.Runtime.environment x)) (* : string -> 'a *)
    val identity = MLWorks.Internal.Value.cast (fn x => x)
  in
    fun result (Thread (r,i)) = MLWorks.Internal.Value.cast (!r);
      
    fun c_fork x = (get "thread fork") x (* : (unit -> 'b) -> 'b thread *)
      
    fun fork (f : 'a -> 'b) a = c_fork (fn () => f a)
      
    val yield = (get "thread yield") : unit -> unit
      
    structure Internal =
      struct
	type thread_id = unit thread

	val id = (get "thread current thread") : unit -> thread_id
	fun get_id t = MLWorks.Internal.Value.cast t : thread_id
	val children = (get "thread children") : thread_id -> thread_id list
	val parent = (get "thread parent") : thread_id -> thread_id
	val all = (get "thread all threads") : unit -> thread_id list

	val kill = (get "thread kill") : thread_id -> unit
	val raise_in = (get "thread raise") : thread_id * exn -> unit
	val yield_to = (get "thread yield to") : thread_id -> unit
	val set_handler = (get "thread set handler") : (unit -> unit) -> unit

	val get_num = (get "thread number") : thread_id -> int
	fun state t =
	  case (result t) of 
	    Running => Running
	  | Waiting => Waiting
	  | Sleeping => Sleeping
	  | Result _ => Result ()
	  | Exception e => Exception e
	  | Died => Died
	  | Killed => Killed
	  | Expired => Expired

	structure Preemption =
	  struct
	    val start = (get "thread start preemption") : unit -> unit
	    val stop = (get "thread stop preemption") : unit -> unit
	    val on = (get "thread preempting") : unit -> bool
	    val get_interval = (get "thread get preemption interval")
				: unit -> int
	    val set_interval = (get "thread set preemption interval")
				: int -> unit
	  end
      end
  end

end;

*)


fun start () = (MLWorks.Threads.Internal.Preemption.set_interval 20;
                MLWorks.Threads.Internal.Preemption.start())

(*fun start () = (Threads.Internal.Preemption.set_interval 20;
		Threads.Internal.Preemption.start ())
*)

(*
fun delay 0 = () | delay n = delay (n-1);

fun short_thread (s,n) =
  let fun loop 0 = ()
	| loop n = (output(std_out,s^"...\n");
		    delay 500000;
		    loop (n-1))
  in (output(std_out,"starting "^s^".\n");
      loop n;
      output(std_out,"finishing "^s^".\n"))
  end;

val _ = start();
val ch1 = Threads.fork short_thread("foo",3);
val ch2 = Threads.fork short_thread("bar",3);
val ch3 = Threads.fork short_thread("baz",3);
val _ = short_thread("qux",3);
*)
