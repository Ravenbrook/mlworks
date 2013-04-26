(* ==== THREADS SYNCHRONIZATION EXAMPLES: cigarette smokers problem ====
 *
 * Copyright (C) 1997 Harlequin Ltd.
 *
 * Description
 * -----------
 * (from "Operating Systems Concepts", 4th Ed. Silberschatz and Galvin
 * Addison-Wesley 1994, page 212):
 *
 * Consider a system with three smoker processes and one agent process.
 * Each smoker continuously rolls a cigarette and then smokes it.  But
 * to roll and smoke a cigarette, the smoker needs three ingredients:
 * tobacco, paper and matches.  One of the smoker processes has paper,
 * another has tobacco, and the third has matches.  The agent has an
 * infinite supply of all three materials.  The agent places two of the
 * ingredients on the table.  The smoker who has the remaining ingredient
 * then makes and smokes a cigarette, signaling the agent on completion.
 * The agent then puts out another two of the three ingredients, and the
 * cycle repeats.
 *
 * Revision Log:
 * -------------
 * $Log: cigarette_smokers.sml,v $
 * Revision 1.5  1999/03/18 13:21:20  johnh
 * [Bug #190530]
 * fix compilation problem.
 *
 *  Revision 1.4  1997/05/16  15:13:52  andreww
 *  [Bug #50000]
 *  Must set max_stack_blocks explicitly so won't overflow default stack.
 *
 *  Revision 1.3  1997/04/03  14:26:21  andreww
 *  [Bug #2017]
 *  Adjusting the copyright messages in the demo files.
 *
 *  Revision 1.2  1997/04/03  11:55:21  andreww
 *  [Bug #2017]
 *  renaming run functions.
 *
 *  Revision 1.1  1997/02/06  17:35:10  andreww
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
require "$.basis.__list";
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
    
    
  val deadlockFlag = ref false;
    
in    
  (* must set max limit of stack blocks high enough to give one block
   * to each thread.  2 threads already exist in the environment, and
   * we create a further 5.
   *)
    
  val _ = MLWorks.Internal.Runtime.Memory.max_stack_blocks:=7;

    
  fun runSmokers interval timeLimit  =
    let
      val paper = Mutex.newBinaryMutex true;
      val tobacco = Mutex.newBinaryMutex true;
      val matches = Mutex.newBinaryMutex true;
      val smoked = Mutex.newBinaryMutex true;
        
        
      fun makeSmoker (name,item1,item2) =
        let
          fun smoking() =
            while true do
              (
               Mutex.wait [item1,item2];
               occupySomeTime 1 (name^" has lit up.\n");
               Mutex.signal [smoked]
               )
        in
          smoking
        end
      
      
      
      fun makeAgent() =
        let
          fun supply() =
            while true do
              (
               let val (mesg,items) = 
                 case (random() mod 3)
                   of 0 => ("paper and matches",[paper,matches])
                    | 1 => ("paper and tobacco",[paper,tobacco])
                    | 2 => ("matches and tobacco",[matches,tobacco])
                    | _ => ("",[])
                     
               in
                 safePrint ("The agent has supplied "^mesg^".\n");
                 Mutex.signal items;
                 Mutex.wait [smoked]
               end
               )
        in
          supply
        end
      
      
      
    (*  set up the threads mechanism *)
  
      val _ = outputString:=""
        
      val p1 = makeAgent ()
      val p2 = makeSmoker ("The Marlboro man",matches,tobacco)
      val p3 = makeSmoker ("Humphrey Bogart",paper,matches)
      val p4 = makeSmoker ("The man in the Iron Lung",paper,tobacco)
        
        
      (*  set up the threads mechanism *)
      val _ = P.set_interval interval;
      val _ = P.start();
        
      val id1 = T.fork p1 ()
      val id2 = T.fork p2 ()
      val id3 = T.fork p3 ()
      val id4 = T.fork p4 ()
        
        
        
        
      (* Deadlock detection *)
        
      val _ = deadlockFlag:=false;
        
      fun detectDeadlock () =
        if Mutex.allSleeping [id1,id2,id3,id4]
          then deadlockFlag:=true
        else detectDeadlock()
          
      val dd = T.fork detectDeadlock ()
        
        
        
        
        
      (* set up a timer *)
        
      fun checkTime timer =
        if Time.toSeconds(Timer.checkRealTimer timer)<timeLimit
          andalso not (!deadlockFlag)
               then checkTime timer
             else (I.kill id1;
                   I.kill id2;
                   I.kill id3;
                   I.kill id4;
                   if !deadlockFlag then () else I.kill dd)
               
               
      val timer = Timer.startRealTimer()
      val _ = checkTime timer
        
      val _ = if !deadlockFlag then print "Deadlock.\n" 
              else print "Finished.\n"
      val _ = print "See file smokers.out for log.\n"
      val x = TextIO.openOut "smokers.out"
    in
      TextIO.output(x,!outputString);
      TextIO.closeOut x
    end
end




