(*
 *
 * $Log: sys_mlworks.sml,v $
 * Revision 1.2  1998/06/03 11:48:03  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* System dependencies.  Currently not used pervasively *)

functor NewJersey () : SYS =
  struct
    val handle_interrupt : (unit -> unit) -> unit =
      fn _ => ()
    val output_immediately : outstream * string -> unit =
      fn (str, s) => (output(str, s); flush_out str)
    val input_one_line : instream -> string = input_line
    val exception_name : exn -> string =
      MLWorks.Internal.Value.exn_name
    val sml_version : string = "MLWorks"
    val save_file : string * string -> unit = fn (file, _) => 
      Shell.saveImage (file,true)
    val date : unit -> string =
      fn () => Date.toString(Date.fromTimeLocal(Time.now ()))
    val cd : string -> unit = MLWorks.Internal.Runtime.environment
                                                       "POSIX.FileSys.chdir"
    val cwd : unit -> string = MLWorks.Internal.Runtime.environment
                                                       "POSIX.FileSys.getcwd"
    val ls : string -> unit = fn _ => (output(std_out, "ls unimplemented\n"); raise Match)
    val exit : unit -> 'a = fn () => 
      (ignore(MLWorks.Internal.Runtime.environment "system os exit" 0);raise Match)
  end
