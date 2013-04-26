(* ==== THREADS SYNCHRONIZATION EXAMPLES : The readers-writers problem ====
 *
 * Copyright (C) 1997 Harlequin ltd.
 *
 * Description
 * -----------
 * An implementation of the classic readers-writers synchronization problem.
 * It illustrates the use of threads and mutexes.
 * This solution allows as many readers as possible to read a resource
 * at a time, but only one writer.
 *
 * Revision Log:
 * -------------
 * $Log: readers_writers.sml,v $
 * Revision 1.5  1999/03/18 13:21:22  johnh
 * [Bug #190530]
 * fix compilation problem.
 *
 *  Revision 1.4  1997/05/16  15:11:58  andreww
 *  [Bug #50000]
 *  Must set max_stack_blocks explicitly so won't overflow default stack.
 *
 *  Revision 1.3  1997/04/03  14:32:05  andreww
 *  [Bug #2017]
 *  Adjusting the copyright messages in the demo files.
 *
 *  Revision 1.2  1997/04/03  11:26:22  andreww
 *  [Bug #2017]
 *  renaming run function.
 *
 *  Revision 1.1  1997/02/06  17:51:23  andreww
 *  new unit
 *  demo for mutual exclusion primitives.
 *
 *
 *
 *)



(* Description (from "operating systems concepts" page 212):

*)




require "$.system.__time";
require "$.basis.__array";
require "$.basis.__timer";
require "$.basis.__string";
require "$.basis.__int32";
require "$.basis.__text_io";
require "$.utils.__mutex";


val deadlockFlag = ref false;

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
    
    
    
    
in    
    
  (* set up stack size: each thread will be allocated one stack block.
   * must make sure that the upper limit of stack blocks is high
   * enough.  We fork eight threads, and two exist in environment.
   *)

  val _ = MLWorks.Internal.Runtime.Memory.max_stack_blocks:=10;

  fun runReadWrite interval timeLimit  =
    let
      
      (* database *)
      
      val datum = ref 0;
      val OKtoWrite = Mutex.newBinaryMutex false;
      val OKtoRead = Mutex.newBinaryMutex false;
        
      (* status *)
        
      val writing = ref false;
      val numReaders = ref 0;    
      val status = Mutex.newBinaryMutex false;      
  (*mutex to ensure exclusive access to the  status flags*)
        

        
        
      fun empty mutex = Mutex.query mutex=[]
        
        

      (* readers *)
        
        
      fun makeReader name =
        while true do
          (
           occupySomeTime 1 "";
           Mutex.await([OKtoRead,status], fn()=> not (!writing));
           numReaders:=(!numReaders)+1;
           Mutex.signal [status,OKtoRead];
           occupySomeTime 1 ("  "^name^" is reading "^
                             (Int32.toString (!datum)^".\n"));
           safePrint ("   "^name^" has finished reading.\n");
           Mutex.wait [status];
           numReaders:=(!numReaders)-1;
           if !numReaders=0 then Mutex.signal [OKtoWrite,status] else
             Mutex.signal [status]
             )
          
          
          
          
      (* writers *)
          
      fun makeWriter name =
        while true do
          (
           occupySomeTime 1 "";
           Mutex.await([OKtoWrite,status],
                       fn()=> not(!writing) andalso !numReaders=0);
           writing:=true;
           Mutex.signal [status];
           datum := (random());
           occupySomeTime 1 (name^
                             " is writing "^(Int32.toString (!datum))^".\n");
           safePrint (name^" has finished writing.\n");
           Mutex.wait [status];
           writing:=false;
           if empty OKtoRead 
             then Mutex.signal [OKtoWrite,status]
           else Mutex.signal [OKtoRead,status]
             )
          
      
  
      val _ = outputString:=""
      val _ = writing:=false
      val _ = numReaders:=0
        
      (*  set up the threads mechanism *)
      val _ = P.set_interval interval;
      val _ = P.start();
        
      val id1 = T.fork makeWriter "Voltaire"
      val id2 = T.fork makeWriter "Tolstoy"
      val id3 = T.fork makeWriter "Hemmingway"
      val id4 = T.fork makeReader "Arthur"
      val id5 = T.fork makeReader "Betty"
      val id6 = T.fork makeReader "Charles"
      val id7 = T.fork makeReader "Diana"
        
        
      (* Deadlock detection *)
        
      val _ = deadlockFlag:=false;
        
      fun detectDeadlock () =
        if Mutex.allSleeping [id1,id2,id3,id4,id5,id6,id7]
          then deadlockFlag:=true
        else detectDeadlock()
          
      val dd = T.fork detectDeadlock ()
        
        
        
      fun checkTime timer =
        if Time.toSeconds(Timer.checkRealTimer timer)<timeLimit
          andalso not(!deadlockFlag) 
          then checkTime timer
        else (I.kill id1;
              I.kill id2;
              I.kill id3;
              I.kill id4;
              I.kill id5;
              I.kill id6;
              I.kill id7;
              if !deadlockFlag then () else I.kill dd)
               
               
      val timer = Timer.startRealTimer()
      val _ = checkTime timer
        
      val _ = if !deadlockFlag then print "Deadlock.\n" 
              else print "Finished.\n"
      val _ = print "See file read_write.out for log.\n"
      val x = TextIO.openOut "read_write.out"
    in
      TextIO.output(x,!outputString);
      TextIO.closeOut x
    end

end





