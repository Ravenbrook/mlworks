(*  ==== BASIS EXAMPLES : DateDemo structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines functions to demonstrate the use of the Date structure
 *  in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __date_demo.sml,v $
 *  Revision 1.3  1997/09/30 10:00:38  daveb
 *  [Bug #30269]
 *  DATE has changed, update to use new specification.
 *
 *  Revision 1.2  1996/09/04  11:53:07  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/07/31  16:20:27  davids
 *  new unit
 *
 *
 *)


require "date_demo";
require "$.basis.__date";
require "$.system.__os";
require "$.system.__time";

structure DateDemo : DATE_DEMO =
  struct

    (* Print the date 'dt' *)

    fun printDate dt =
      (print (Date.toString dt);
       print "\n")
   

    (* Print the date at which 'file' was last modified. *)

    fun fileDate file = 
      printDate (Date.fromTimeLocal (OS.FileSys.modTime file))
      handle OS.SysErr (message, error) => 
	print ("System error:\n" ^ message ^ "\n")

      
    (* Print the current date. *)

    fun dateNow () = 
      printDate (Date.fromTimeLocal (Time.now ()))

  end
