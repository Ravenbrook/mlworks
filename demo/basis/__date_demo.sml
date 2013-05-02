(*  ==== BASIS EXAMPLES : DateDemo structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
