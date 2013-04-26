(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test Timer.  Each test result should be true.  Currently only does
 * minimal testing.
 *
 * Revision Log
 * ------------
 *
 * $Log: timer.sml,v $
 * Revision 1.5  1999/05/12 14:58:28  daveb
 * [Bug #190554]
 * The signature has changed.
 *
 *  Revision 1.4  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.3  1997/11/21  10:50:17  daveb
 *  [Bug #30323]
 *
 *  Revision 1.2  1997/11/19  20:06:27  jont
 *  [Bug #30085]
 *  Add tests for totalRealTimer and totalCPUTimer
 *
 *  Revision 1.1  1996/10/10  11:26:23  stephenb
 *  new unit
 *
 *)


local 
  fun fib n = if n<2 then 1 else fib(n-1) + fib(n-2);

  val totalRealTime = Timer.startRealTimer()
  val totalCPUTime  = Timer.startCPUTimer()
  val totReal = Timer.totalRealTimer()
  val totCPU = Timer.totalCPUTimer()
in

  val a = Time.<= (Timer.checkRealTimer totalRealTime, Timer.checkRealTimer totalRealTime);

  val b = Time.< (((Timer.checkRealTimer totalRealTime) before (ignore(fib 25); ())), Timer.checkRealTimer totalRealTime);

  val c = Time.<= (Timer.checkRealTimer totReal, Timer.checkRealTimer totReal);

  val d = Time.<= (Timer.checkRealTimer totalRealTime, Timer.checkRealTimer totReal);

  val e = Time.<= (Timer.checkGCTime totalCPUTime, Timer.checkGCTime totalCPUTime);
 
  val f = Time.<= (Timer.checkGCTime totCPU, Timer.checkGCTime totCPU);

  val g = Time.<= (Timer.checkGCTime totalCPUTime, Timer.checkGCTime totCPU);

  local
    val op <= = fn ({usr=usr1, sys=sys1}, {usr=usr2, sys=sys2})
	=> Time.<= (usr1, usr2) andalso Time.<= (sys1, sys2);

    fun cput1 < cput2 = (cput1 <= cput2) andalso (cput1 <> cput2);

  in

    val h = (Timer.checkCPUTimer totalCPUTime) <= (Timer.checkCPUTimer totalCPUTime);

    val i = ((Timer.checkCPUTimer totalCPUTime) before (ignore(fib 25); ())) < (Timer.checkCPUTimer totalCPUTime);
  
    val j= (Timer.checkCPUTimer totCPU) <= (Timer.checkCPUTimer totCPU);

    val k = (Timer.checkCPUTimer totalCPUTime) <= (Timer.checkCPUTimer totCPU);

    local
      val ctmr = Timer.startCPUTimer ()

    in
      val l = (Timer.checkCPUTimer ctmr) <= (Timer.checkCPUTimer ctmr);
  
      val m = ((Timer.checkCPUTimer ctmr) before (ignore(fib 25); ())) < (Timer.checkCPUTimer ctmr);

    end

  end

end
