(*
 * Bounded Buffers implementation.  Test for new MLWorks Threads mutexes.

Result: OK

 *
 * Revision Log:
 * -------------
 * $Log: mutexes.sml,v $
 * Revision 1.8  1998/06/15 12:26:41  mitchell
 * [Bug #30422]
 * newProject now requires a directory
 *
 *  Revision 1.7  1998/06/04  14:43:40  johnh
 *  [Bug #30369]
 *  Replace source path with a list of files.
 *
 *  Revision 1.6  1998/05/21  12:23:36  mitchell
 *  [Bug #50071]
 *  Replace touchAllSource by a force compile
 *
 *  Revision 1.5  1998/05/07  09:30:31  mitchell
 *  [Bug #50071]
 *  Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 *  Revision 1.4  1998/05/04  17:24:14  mitchell
 *  [Bug #50071]
 *  Replace uses of Shell.Build.loadSource by Shell.Project
 *
 *  Revision 1.3  1997/11/24  14:24:25  daveb
 *  [Bug #30323]
 *
 *  Revision 1.2  1997/11/19  21:04:27  jont
 *  [Bug #30085]
 *  Make independent of structure changes
 *
 *  Revision 1.1  1997/01/29  10:43:40  andreww
 *  new unit
 *  A test for the new mutual exclusion primitives.
 *
 *
 *
 * Copyright (C) 1997 Harlequin Ltd.
 *
 *)

Shell.Options.set (Shell.Options.ValuePrinter.maximumStrDepth,0);
(
  Shell.Project.newProject (OS.Path.fromUnixPath "/tmp");
  let
    val root_dir = OS.FileSys.getDir()
    fun concatenate s = OS.Path.concat [root_dir, "..", "src", "utils", s]
  in
    Shell.Project.setFiles (map concatenate ["__mutex.sml", "mutex.sml"])
  end;
  Shell.Project.setTargetDetails "__mutex.sml";
  Shell.Project.setTargets ["__mutex.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
)

val deadlockFlag = ref false;

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
  



in

  (*  set up the threads mechanism *)


  fun run timeLimit =
    let
      
      val _ = output:=[]
        
      val p1 = makeProducer()
      val p2 = makeConsumer()
        
        
      (*  set up the threads mechanism *)
      val _ = P.set_interval 10;
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


val testAnswer =  (run 10; 
                   if !deadlockFlag then "Deadlocked."
                     else if testOutput() then "OK" else "WRONG");
                      
