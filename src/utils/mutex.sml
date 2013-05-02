(*
 * MLWorks mutual exclusion primitives.  The signature.
 *
 * Revision Log:
 * -------------
 * $Log: mutex.sml,v $
 * Revision 1.2  1997/04/03 14:15:47  andreww
 * correcting spelling mistake.
 *
 *  Revision 1.1  1997/01/28  17:25:47  andreww
 *  new unit
 *  signature for new mutex functionality.
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



signature MUTEX =
sig
  exception Mutex of string
  type mutex
  val newCountingMutex: int -> mutex
  val newBinaryMutex: bool -> mutex
  val test: mutex list -> bool
  val testAndClaim : mutex list -> bool
  val wait: mutex list -> unit
  val signal: mutex list -> unit
  val query: mutex -> MLWorks.Threads.Internal.thread_id list
  val allSleeping: MLWorks.Threads.Internal.thread_id list -> bool
  val cleanUp : unit -> unit
  val critical: mutex list * ('a -> 'b)  -> 'a -> 'b
  val await: mutex list * (unit -> bool) -> unit
end 


         (* newCountingMutex counter
            returns a new counting mutex with initial value counter.

            newBinaryMutex isClaimed
            returns a new binary mutex with initial value isClaimed.

            test l
            returns true if all mutexes are free in l at the time of
            the procedure call, false otherwise.  No blocking.

            testAndClaim l
            like test, but actually claims the mutexes in l if they're
            all available, returning true.  Returns false otherwise.
            No blocking.
           
            wait l
            wait 'til all mutexes are free in l simultaneously

            signal l
            simultaneously signal that all the mutexes in l are free

            query m
            returns list of threads that are waiting on mutex m

            allSleeping l
            Returns true if every thread in l is sleeping simultaneously.
            Used for deadlock detection.

            cleanUp ()
            Kills off all threads except MLWorks' own.


            critical(l,f) a
            wait for mutexes l, apply f to a and return the result
            after signalling l

            await(l,c)
            waits until both every mutex in l is free, and
            condition c() evaluates to true, in which case
            it does *not* release the mutexes.
          *)

