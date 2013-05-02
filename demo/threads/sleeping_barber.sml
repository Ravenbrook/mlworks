(* ==== THREADS SYNCHRONIZATION EXAMPLES : the sleeping barber problem ====
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
 * (from "Operating Systems Concepts", 4th Ed. Silberschatz and Galvin
 * Addison-Wesley 1994, page 212):
 *
 * A barbershop consists of a waiting room with n chairs, and the barber
 * room containing the barber chair.  If there are no customers to be served,
 * the barber goes to sleep.  If a customer enters the barbershop and all
 * the chairs are occupied, then the customer leaves the shop.  If the
 * barber is busy, but chairs are available,then the customer sits in one
 * of the free chairs.  If the barber is asleep, the customer wakes up
 * the barber.
 *
 * Revision Log:
 * -------------
 * $Log: sleeping_barber.sml,v $
 * Revision 1.5  1999/03/18 13:21:25  johnh
 * [Bug #190530]
 * fix compilation problem.
 *
 *  Revision 1.4  1997/05/16  15:16:48  andreww
 *  [Bug #50000]
 *  Must set max_stack_blocks explicitly so won't overflow default stack.
 *
 *  Revision 1.3  1997/04/03  14:29:39  andreww
 *  [Bug #2017]
 *  Adjusting the copyright messages in the demo files.
 *
 *  Revision 1.2  1997/04/03  11:55:42  andreww
 *  [Bug #2017]
 *  renaming run function, making sure each variable is reinitialized
 *  every run.
 *
 *  Revision 1.1  1997/02/06  17:48:06  andreww
 *  new unit
 *  demo for mutual exclusion primitives.
 *
 *
 *
 *)






require "$.system.__time";
require "$.basis.__array";
require "$.basis.__timer";
require "$.basis.__string";
require "$.basis.__int32";
require "$.basis.__text_io";
require "$.utils.__mutex";


local

  structure T = MLWorks.Threads;
  structure I = T.Internal;
  structure P = I.Preemption;
    
    
  (* The output device *)
    
  val output = Mutex.newBinaryMutex false;
  val outputString = ref "";
    
  fun safePrint message = 
    Mutex.critical([output], fn()=>outputString:=(!outputString^message))()
    
  fun unsafePrint message = outputString := (!outputString)^message
    
    
  fun flushOutput () = while (Mutex.query output <>[]) do ()
    
    
    




  (* functions to pass away the time *)


  fun random() =
    let
      val timeString = Time.fmt 4 (Time.now())
      val number = case (rev(String.tokens (fn c => c= #".") timeString))
                     of [] => 0
                      | (h::_) => valOf(Int32.fromString h)
    in
      number mod 1971
    end;
    
    
  fun occupySomeTime scale message =
    let
      val timeToPass = Time.fromMilliseconds (random()*scale)
      val _ = safePrint message
      val timer = Timer.startRealTimer()
      fun passTime() = if Time.<(Timer.checkRealTimer timer,timeToPass)
                         then passTime()
                       else ()
    in
      passTime()
    end;
    
    

  (* the barbershop: the total number of chairs available *)
  val LIMIT = 4;
    
  val numChairs = ref LIMIT;
    
    
  fun makeBarber (chairs,barber,customer,custom,output) =
    let
      val barberSleeping = ref true
        
      fun barbering() =
        while true do
          (Mutex.wait [custom,output];              (* wait for some custom. *)
           if !barberSleeping 
             then (unsafePrint "The barber has woken up.\n";
                   barberSleeping:=false)
           else ();
             Mutex.signal [barber,output]; (* signal that barber is ready. *)
             Mutex.wait [customer];        (* wait for customer to say "me!"*)
             occupySomeTime 1 "The barber is busy.\n";
             safePrint "The barber has finished.\n";
             Mutex.signal [customer];          (* tell customer "finished". *)
             if !numChairs<LIMIT then () else 
               (safePrint "The barber has fallen asleep.\n";
                barberSleeping:=true)
               )
    in
      barbering
    end
  




  fun makeCustomer name (chairs,barber,customer,custom,output) =
    let
      val inShop = ref false
        
      fun sillyMessage() = 
        case (random() mod 10)
          of 0 => name^" is buying a packet of fags.\n"
           | 1 => name^" is pondering lambda optimization.\n"
           | 2 => name^" is enjoying a black cherry flavoured yoghurt.\n"
           | 3 => name^" is chatting to a dining philosopher.\n"
           | 4 => name^" has just proved a difficult theorem.\n"
           | 5 => name^" is window-shopping.\n"
           | 6 => name^" is buying lunch.\n"
           | 7 => name^" has gone swimming.\n"
           | 8 => name^" is avoiding the team dinner.\n"
           | 9 => name^" is playing some guitar.\n"
           | _ => ""
            
            

      fun customering() =
        while true do
          (occupySomeTime 2 (sillyMessage());
           Mutex.critical([output],fn ()=>
                          (Mutex.signal [custom];
                           unsafePrint (name^" has entered the shop.\n");
                           inShop:=true)
                          )();
           Mutex.critical
           ([chairs], fn()=>
            if !numChairs=0
              then (Mutex.wait [custom,output];
                    unsafePrint (name^" has left the crowded shop.\n");
                    inShop:=false;
                    Mutex.signal [output])
            else numChairs:=(!numChairs-1)
              )();
           if !inShop
             then (Mutex.wait [barber];
                   Mutex.signal [customer];
                   safePrint(name^" is getting a hair cut.\n");
                   Mutex.wait [customer,output];
                   unsafePrint (name^" has a new hairstyle.\n");
                   Mutex.signal [output];
                   Mutex.wait ([chairs,custom,output]);
                   numChairs:=(!numChairs+1);
                   unsafePrint (name^" has left the shop.\n");
                   inShop:=false;
                   Mutex.signal [chairs,output]
                   )
           else ())
    in
      customering
    end                      
  
  





in
  (*  set up the threads mechanism *)

   (* 1. Ensure we have enough stack blocks to give one to each thread.
    * The environment already runs two, and we fork another 8.
    *)

    val _ = MLWorks.Internal.Runtime.Memory.max_stack_blocks:=10;


    fun runBarber interval timeLimit  =
      let
        
        val chairs = Mutex.newBinaryMutex false;
        val _ = numChairs:= LIMIT;
        val barber = Mutex.newBinaryMutex true;          (* barber unatainable
                                                          while sleeping *)
        val customer = Mutex.newBinaryMutex false;
        val custom = Mutex.newCountingMutex 0;
      
        val deadlockFlag = ref false;

        
        val _ = outputString:=""
          
        val  b = makeBarber(chairs,barber,customer,custom,output)
        val p1 = makeCustomer "    Jon" (chairs,barber,customer,custom,output)
        val p2 = makeCustomer "   Dave" (chairs,barber,customer,custom,output)
        val p3 = makeCustomer "Matthew" (chairs,barber,customer,custom,output)
        val p4 = makeCustomer "Stephen" (chairs,barber,customer,custom,output)
        val p6 = makeCustomer " Andrew" (chairs,barber,customer,custom,output)
        val p7 = makeCustomer "     Jo" (chairs,barber,customer,custom,output)
        val p8 = makeCustomer "   John" (chairs,barber,customer,custom,output)
          
          
          
        (*  set up the threads mechanism *)
        val _ = P.set_interval interval;
        val _ = P.start();
          
        val bid = T.fork b ()
        val id1 = T.fork p1 ()
        val id2 = T.fork p2 ()
        val id3 = T.fork p3 ()
        val id4 = T.fork p4 ()
        val id6 = T.fork p6 ()
        val id7 = T.fork p7 ()
        val id8 = T.fork p8 ()
          
          
        (* set up deadlock detector *)
          
          
        val _ = deadlockFlag:=false;
          
        fun detectDeadlock () =
          if Mutex.allSleeping [bid,id1,id2,id3,id4,id6,id7,id8]
            then deadlockFlag:=true
          else detectDeadlock()
            
        val dd = T.fork detectDeadlock ()
          
          
          
        fun checkTime timer =
          if Time.toSeconds(Timer.checkRealTimer timer)<timeLimit
            andalso not (!deadlockFlag)
            then checkTime timer
               else (I.kill bid;
                     I.kill id1;
                     I.kill id2;
                     I.kill id3;
                     I.kill id4;
                     I.kill id6;
                     I.kill id7;
                     I.kill id8;
                     if !deadlockFlag then () else I.kill dd)
                 
                 
                 
        (* set up a timer *)
        val timer = Timer.startRealTimer()
        val _ = checkTime timer
          
        (* wait for program to finish *)
          
        val _ = if !deadlockFlag then print "Deadlock.\n"
                else print "Finished.\n"
        val _ = print "See file barber.out for log.\n"
                  
        val x = TextIO.openOut "barber.out";
      in
        TextIO.output(x,!outputString);
        TextIO.closeOut x
      end
end




