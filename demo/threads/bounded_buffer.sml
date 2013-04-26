(* ==== THREAD SYNCHRONIZATION EXAMPLES : bounded buffers ====
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
 * An implementation of the classic producer/consumer synchronization
 * problem.  It illustrates the use of threads and mutexes.
 *
 * Revision Log:
 * -------------
 * $Log: bounded_buffer.sml,v $
 * Revision 1.4  1997/05/16 15:05:29  andreww
 * [Bug #50000]
 * Must set max_stack_blocks explicitly so won't overflow default stack.
 *
 *  Revision 1.3  1997/04/03  14:24:36  andreww
 *  [Bug #2017]
 *  Adjusting the copyright messages in the demo files.
 *
 *  Revision 1.2  1997/04/03  11:34:48  andreww
 *  [Bug #2017]
 *  renaming run functions.
 *
 *  Revision 1.1  1997/02/06  17:39:20  andreww
 *  new unit
 *  demo for mutual exclusion primitives.
 *
 *
 *
 *)

require "$.system.__time";
require "$.basis.__array";
require "$.basis.__timer";
require "$.utils.__mutex";

local
  structure T = MLWorks.Threads;
  structure I = T.Internal;
  structure P = I.Preemption;
    
    
  (* shared resource *)
    
  local
    val buffer = Array.array(10,0);
    val size = ref 0;
    val putIndex = ref 0;
    val getIndex = ref 0;
  in
    fun addToBuffer x = 
      (if !size=10 then print "data lost!\n"       (* shouldn't happen*)
       else size:= !size+1;
         Array.update(buffer,!putIndex,x);
         putIndex:=(!putIndex+1) mod 10)
         
    fun readFromBuffer () =
      (if !size=0 then print "phantom data!\n"     (*shouldn't happen*)
       else size:= !size-1;
         Array.sub(buffer,!getIndex) before
         getIndex:=(!getIndex+1) mod 10)
  end



  (* mutexes for buffer access *)

  val access = Mutex.newBinaryMutex false;
  val empty = Mutex.newCountingMutex 10;
  val full = Mutex.newCountingMutex 0;
    
    
    
  (* producer *)
    
  fun makeProducer () =
    let
      val producerData = ref 0;
        
      fun nextItem()=(!producerData) before (producerData:=(!producerData)+1);
        
      fun produce() =
        while true do
          let val item = nextItem()
          in
            Mutex.wait [empty];
            Mutex.critical([access],addToBuffer) item;
            Mutex.signal [full]
          end
    in
      produce
    end






  (* consumer *)

  val output: int list ref = ref []
    
  fun makeConsumer () =
    let
      fun processDatum x = output:= x::(!output)
      
      fun consume() =
        while true do
          let
            val _ = Mutex.wait [full];
            val datum = Mutex.critical([access],readFromBuffer)();
            val _ = Mutex.signal [empty];
          in
            processDatum datum
          end
    in
      consume
    end
  


  val deadlockFlag = ref false;


in

  (*  set up the threads mechanism *)

  (* 1. We must ensure that there is enough stack space: each thread
   *    is allocated one stack block.  We fork three threads, and have
   *    two already existing in the environment.
   *)

  val _ = MLWorks.Internal.Runtime.Memory.max_stack_blocks:=5;


  fun runProdCons interval timeLimit =
    let
      
      val _ = output:=[]
        
      val p1 = makeProducer()
      val p2 = makeConsumer()
        
        
      (*  set up the threads mechanism *)
      val _ = P.set_interval interval;
      val _ = P.start();
        
      val id1 = T.fork p1 ()
      val id2 = T.fork p2 ()
        
        
      fun detectDeadlock() =
        if Mutex.allSleeping [id1,id2]
          then deadlockFlag:=true
        else detectDeadlock()
          
      val _ = deadlockFlag:=false
      val dd = T.fork detectDeadlock ()
        
        
        
        
        
        
      fun checkTime timer =
        if !deadlockFlag then ()
        else if Time.toSeconds(Timer.checkRealTimer timer)<timeLimit
               then checkTime timer
             else (I.kill id1;
                   I.kill id2;
                   if !deadlockFlag then () else I.kill dd)
               
               
               
               
      (* set up a timer *)
               
      val timer = Timer.startRealTimer()
      val _ =  checkTime timer
        
      val _ = if !deadlockFlag then print "Deadlock.\n" 
              else print "Finished.\n"
                
    in
      ()
    end
  
  
  

  fun testOutput () =
    let
      fun testOK ([],_) = true
        | testOK (h::t,n) = h+1=n andalso testOK(t,h)
    in
      case (!output)
        of [] => true
         | (h::t) => testOK (t,h)
    end
  
end  


val testAnswer = (runProdCons 1 10; testOutput())
