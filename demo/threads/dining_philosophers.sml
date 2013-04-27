(* ==== THREADS SYNCHRONIZATION EXAMPLES : the dining philosophers problem ====
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
 *
 * Description
 * -----------
 * An implementation of the classic dining philosophers synchronization
 * problem.  It illustrates the use of threads and mutexes.
 *
 * Revision Log:
 * -------------
 * $Log: dining_philosophers.sml,v $
 * Revision 1.5  1999/03/18 13:21:23  johnh
 * [Bug #190530]
 * fix compilation problem.
 *
 *  Revision 1.4  1997/05/16  15:15:13  andreww
 *  [Bug #50000]
 *  Must set max_stack_blocks explicitly so won't overflow default stack.
 *
 *  Revision 1.3  1997/04/03  14:28:05  andreww
 *  [Bug #2017]
 *  Adjusting the copyright messages in the demo files.
 *
 *  Revision 1.2  1997/04/03  11:24:53  andreww
 *  [Bug #2017]
 *  renaming run functions.
 *
 *  Revision 1.1  1997/02/06  17:33:38  andreww
 *  new unit
 *  example demo for the mutual exclusion primitives.
 *
 *
 *
 *)

require "$.system.__time";
require "$.basis.__timer";
require "$.basis.__string";
require "$.basis.__int32";
require "$.basis.__text_io";
require "$.utils.__mutex";


local
  structure T = MLWorks.Threads;
  structure I = T.Internal;
  structure P = I.Preemption;
    

  (* the shared data: five chopsticks *)

  val chopstick1 = Mutex.newBinaryMutex false;
  val chopstick2 = Mutex.newBinaryMutex false;
  val chopstick3 = Mutex.newBinaryMutex false;
  val chopstick4 = Mutex.newBinaryMutex false;
  val chopstick5 = Mutex.newBinaryMutex false;
    
  (* plus a mutex for the output device *)
    
  val output = Mutex.newBinaryMutex false;
  val outputString = ref "";
    
  fun safePrint message = Mutex.critical([output], fn()=>
                                         outputString:=(!outputString^message))()
    
    
  fun unsafePrint message = outputString := (!outputString)^message
    
    
  fun flushOutput () = while (Mutex.query output <>[]) do ()
    
    
    
  fun random() =
    let
      val timeString = Time.fmt 4 (Time.now())
      val number = case (rev(String.tokens (fn c => c= #".") timeString))
                     of [] => 0
                      | (h::_) => valOf(Int32.fromString h)
    in
      number mod 1971
    end;
    
    
    
    
  fun occupySomeTime message =
    let
      val timeToPass = Time.fromMilliseconds (random())
      val _ = safePrint message
      val timer = Timer.startRealTimer()
      fun passTime() = if Time.<(Timer.checkRealTimer timer,timeToPass)
                         then passTime()
                       else ()
    in
      passTime()
    end;
    
    





  (* the philosophers *)

  fun philosopher (name,chopsticks,chopstickNames) =
    let
      fun sillyMessage() = 
        case (random() mod 5)
          of 0 => ""
           | 1 => name^" has burped.\n"
           | 2 => ""
           | 3 => name^" is throwing up.\n"
           | 4 => name^" has just proved a difficult theorem.\n"
           | _ => ""
            
      fun philosophize ():unit =
        while true do
          (
           occupySomeTime (name^" is thinking.\n");
           safePrint (name^" is hungry.\n");
           Mutex.wait ([output]@chopsticks);
           unsafePrint (name^" has picked up chopsticks "
                        ^chopstickNames^" and is eating heartily.\n");
           Mutex.signal [output];
           occupySomeTime (sillyMessage());
           Mutex.critical
            ([output],
             fn () => (Mutex.signal chopsticks;
                       unsafePrint (name^" has put down chopsticks "
                                    ^chopstickNames^".\n")))()
            )
    in
      philosophize
    end;
    
    
    
  val deadlockFlag = ref false;
  
in
  
  (*  set up the threads mechanism *)
  
  (* 1. set up enough stack blocks to give one to each thread.
   * The environment already runs 2 threads, and we fork a further
   * 6.
   *)

  val _ = MLWorks.Internal.Runtime.Memory.max_stack_blocks:=8;



  fun runPhilosophers intervals timeLimit =
    let
      (* open output file *)
      
      val _ = outputString := ""
        
      val p1 = philosopher("Russell",[chopstick1,chopstick2],"1 and 2");
      val p2 = philosopher("  Godel",[chopstick2,chopstick3],"2 and 3");
      val p3 = philosopher(" Kleene",[chopstick3,chopstick4],"3 and 4");
      val p4 = philosopher("  Frege",[chopstick4,chopstick5],"4 and 5");
      val p5 = philosopher(" Church",[chopstick5,chopstick1],"5 and 1");
        
        
      (*  set up the threads mechanism *)
      val _ = P.set_interval intervals;
      val _ = P.start();
        
      (* start the philosophers philosophizing *)
        
      val id1 = T.fork p1 ()
      val id2 = T.fork p2 ()
      val id3 = T.fork p3 ()
      val id4 = T.fork p4 ()
      val id5 = T.fork p5 ()
        
        
      fun detectDeadlock() =
        if Mutex.allSleeping [id1,id2,id3,id4,id5]
          then deadlockFlag:=true
        else detectDeadlock()
          
      val _ = deadlockFlag:=false
      val dd = T.fork detectDeadlock ()
        
        
        
        
        
      fun checkTime timer =
        if Time.toSeconds(Timer.checkRealTimer timer)<timeLimit
          andalso not (!deadlockFlag)
          then checkTime timer
             else (I.kill id1;
                   I.kill id2;
                   I.kill id3;
                   I.kill id4;
                   I.kill id5;
                   if !deadlockFlag then () else I.kill dd)
               
               
               
               
      (* set up a timer *)
      val timer = Timer.startRealTimer()
      val _ = checkTime timer
        
      (* reset all mutexes *)

      val _ = if Mutex.test [chopstick1] then () 
              else Mutex.signal [chopstick1];
      val _ = if Mutex.test [chopstick2] then () 
              else Mutex.signal [chopstick2];
      val _ = if Mutex.test [chopstick3] then () 
              else Mutex.signal [chopstick3];
      val _ = if Mutex.test [chopstick4] then () 
              else Mutex.signal [chopstick4];
      val _ = if Mutex.test [chopstick5] then () 
              else Mutex.signal [chopstick5];

      (* finish *)

      val _ = if !deadlockFlag then print "Deadlock.\n" 
              else print "Finished.\n"
                
      val _ = print "See file philosophers.out for log.\n"

      (* open output file *)
                
      val out = TextIO.openOut "philosophers.out";
        
    in
      TextIO.output(out,!outputString);
      TextIO.closeOut out
    end
end
