(*
 * MLWorks mutual exclusion primitives.
 *
 * Revision Log:
 * -------------
 * $Log: __mutex.sml,v $
 * Revision 1.1  1997/01/29 10:27:54  andreww
 * new unit
 * new mutual exclusion primitives.
 *
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)



require "mutex.sml";



structure Mutex : MUTEX =
struct
  structure T = MLWorks.Threads;
  structure I = T.Internal;
  structure P = I.Preemption;

  exception Mutex of string;

  (* note that the Threads.result datatype is not an equality type
     (since exceptions don't admit equality) *)

  fun state_eq(T.Died,T.Died) = true
    | state_eq(T.Running,T.Running) = true
    | state_eq(T.Sleeping,T.Sleeping) = true
    | state_eq(T.Exception _,T.Exception _) = true
    | state_eq(T.Expired,T.Expired) = true
    | state_eq(T.Killed,T.Killed) = true
    | state_eq(T.Result _,T.Result _) = true
    | state_eq(T.Waiting,T.Waiting) = true
    | state_eq _ = false




  abstype mutex = COUNTING of {counter: int, waiting: I.thread_id list} ref
                |   BINARY of {claimed: bool, waiting: I.thread_id list} ref
  with
    fun newCountingMutex size = 
      COUNTING (ref {counter=
                  (if size<0
                     then raise Mutex "initial counter must be greater than 0"
                   else size),
                  waiting=[]})
        

    fun newBinaryMutex flag = BINARY (ref {claimed=flag, waiting=[]})



      (* wait l
         1. enters critical section.
         tests if all mutexes in l are free:
           If so, it claims them all, and stops, exiting the critical section.
           Otherwise we have to sleep, exiting the critical section.
           If we are dead or killed, we can't sleep --- so we just exit
           the critical section until next time round the loop. *)


    fun wait mutices =
      let
        val self = I.id()

        fun allFree [] = true
          | allFree (COUNTING(m as ref{counter,waiting})::rest) =
          if counter=0 then (m:={counter=counter,
                                 waiting=waiting@[self]};
                             false)
          else allFree rest
          | allFree (BINARY(m as ref{claimed,waiting})::rest) =
            if claimed then (m:={claimed=claimed,
                                 waiting=waiting@[self]};
                             false)
            else allFree rest
              
              
        fun claimAll [] = ()
          | claimAll (COUNTING(m as ref{counter,waiting})::rest) =
                      (m:={counter=counter-1,waiting=waiting};
                       claimAll rest)
          | claimAll (BINARY(m as ref{claimed,waiting})::rest) =
                      (m:={claimed=true,waiting=waiting};
                       claimAll rest)
      in
        P.enter_critical_section();
        if allFree mutices
          then (
                claimAll mutices;
                P.exit_critical_section()
                )
          else (
                T.sleep(self);      (*self-sleep leaves critical section*)
                wait mutices
                )    (* when thread is next wakened, at least one mutex
                        may be free: still need to check the rest though. *)
      end

      
      
    (* returns true if mutexes are all available, false otherwise. *)

      
    fun test mutices =
      let
        fun allFree [] = true
          | allFree (COUNTING(ref{counter,...})::rest) =
          counter>0 andalso allFree rest
          | allFree (BINARY(ref{claimed,...})::rest) =
          not claimed andalso allFree rest
      in
        (P.enter_critical_section();
         allFree mutices before (P.exit_critical_section()))
      end
    
    


    (* tests and claims mutices if all free, returing true,
     otherwise returns false *)

    fun testAndClaim mutices =
      let
        fun allFree [] = true
          | allFree (COUNTING(ref{counter,...})::rest) =
          counter>0 andalso allFree rest
          | allFree (BINARY(ref{claimed,...})::rest) =
          not claimed andalso allFree rest

        fun claimAll [] = ()
          | claimAll (COUNTING(m as ref{counter,waiting})::rest) =
                      (m:={counter=counter-1,waiting=waiting};
                       claimAll rest)
          | claimAll (BINARY(m as ref{claimed,waiting})::rest) =
                      (m:={claimed=true,waiting=waiting};
                       claimAll rest)
      in
        (P.enter_critical_section();
         (if allFree mutices then (claimAll mutices; true)
          else false) before (P.exit_critical_section())
        )
      end




    fun signal mutices =
       let
         fun wakeAll [] = ()
           | wakeAll (h::t) =
              (if state_eq(I.state h,T.Sleeping)  (* thread may be dead*)
                 then T.wake h
               else ();
               wakeAll t)


         fun releaseAll [] = ()
           | releaseAll (COUNTING(m as ref{counter,waiting})::rest) =
                (wakeAll waiting;
                 m:={counter=counter+1,waiting=[]};
                 releaseAll rest)
           | releaseAll (BINARY(m as ref{claimed,waiting})::rest) =
                (wakeAll waiting;
                 m:={claimed=false,waiting=[]};
                 releaseAll rest)

       in
         P.enter_critical_section();
         releaseAll mutices;
         P.exit_critical_section()
       end

      
    fun query (COUNTING(ref{counter,waiting})) = waiting
      | query (BINARY(ref{claimed,waiting})) = waiting



    fun allSleeping mutices =
      let
        fun allAsleep [] = true
          | allAsleep (h::t) = state_eq(I.state h,T.Sleeping)
                               andalso allAsleep t

      in
        P.enter_critical_section();
        allAsleep mutices before
        (P.exit_critical_section())
      end


    (* the following restores a clean thread state *)

    fun cleanUp () =
      let
        fun kill [] = P.exit_critical_section()
          | kill (h::t) = 
            (if I.get_num h>1 then I.kill h else (); kill t)
          
      in
        P.enter_critical_section();
        kill(I.all());
        P.exit_critical_section()
      end

  end



  (* Higher-level synchronization devices. *)

  fun critical (mutices,f) x =
    let val _ = wait mutices
        val result = f x
        val _ = signal mutices
    in
      result
    end handle e => (signal mutices; raise e)



      (* note that the following does *not* release mutexes when the
         awaited condition is satisifed. *)

  fun await(mutices,condition) =
    (wait mutices;
     if (condition() handle e => (signal mutices; raise e)) then ()
     else await((signal mutices;mutices),condition)
    )
end;

