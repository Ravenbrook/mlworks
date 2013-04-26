(*
 *
 * $Log: commonio.sml,v $
 * Revision 1.2  1998/06/08 17:26:44  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				      9/02/90.
Glasgow University and Rutherford Appleton Laboratory.

commonio.sml

this is the common IO file for NJ-ML - to give a common basic input/output functions 
*)

structure CommonIO = 
   struct 
        local (* A Log file for generating output logs. BMM 11/10/93 *)
        val Log = ref false
        val LogFile = ref "" 
        val LogStream = ref std_out
        in
	fun read i n = input(i,n)
	fun write os s = (output(os,s) ; flush_out os)
	
	
	(* These are diagnostic functions to give sensible Result displaying
	   in Interactive mode *)
	   
	fun printlength n = System.Control.Print.printLength := n
	fun printdepth n = System.Control.Print.printDepth := n

        fun interrupt () = (*can_input std_in <> 0*)false

        fun setLogFile logfile =
	   if logfile = "" 			(* No new logfile *)
	   then Log := false			(* Stop Logging *)
	   else
           if !LogFile = logfile 		(* if same log-file *)
	   then Log := true 	      		(* Start Logging *)
           else 				(* If new logfile *)
		(if !LogFile = "" then ()	(* can't close std_out *)
		 else close_out (!LogStream);	(* close existing Log stream *)
		 LogFile := logfile;		(* reset current Log File *)
		 LogStream := open_out logfile; (* open new log file *)
		 Log := true) 	        	(* Start Logging *)

	fun isLogSet () = !Log
	fun logFile () = !LogFile
        fun noLog () = (Log := false; LogFile := "" ; LogStream := std_out)

	fun closeLogFile () = close_out (!LogStream)

	val read_terminal = read std_in
	fun write_terminal s = (if (!Log) then write (!LogStream) s else () ; write std_out s)

	val read_line = input_line 
	fun read_line_terminal () = 
	    let val line = input_line std_in
            in (if !Log then write (!LogStream) line else () ; line)
	    end 

        end 

	fun newline () = write_terminal "\n" 

   end ;

