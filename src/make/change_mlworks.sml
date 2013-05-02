(*  ==== MODIFY MLWorks ENVIRONMENT ====
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
 *  $Log: change_mlworks.sml,v $
 *  Revision 1.17  1999/05/27 13:21:21  johnh
 *  [Bug #190553]
 *  Changes to Exit structure.
 *
 *  Revision 1.16  1999/03/26  14:51:49  johnh
 *  [Bug #190523]
 *  Fix up changes to Exit structure.
 *
 *  Revision 1.15  1998/05/26  15:17:26  mitchell
 *  [Bug #30413]
 *  Moving Exit structure to pervasives
 *
 *  Revision 1.14  1998/04/22  16:32:00  jont
 *  [Bug #70107]
 *  Ensure Win32.closeIOD is available for bootstrapping under NT
 *  Also make Win32.fdToIOD fail, so we don't run out of
 *  handles c=from CreateFile.
 *
 *  Revision 1.13  1998/04/15  12:38:21  jont
 *  [Bug #70096]
 *  Modify to assign Windows.fileTimeToLocalTime to be the identity.
 *
 *  Revision 1.12  1997/11/26  15:45:34  johnh
 *  [Bug #30134]
 *  Change third arg of MLWorks.Deliver.deliver.
 *
 *  Revision 1.11  1997/11/13  10:55:02  jont
 *  [Bug #30089]
 *  Add MLWorks.Internal.Types.time for basis time
 *
 *  Revision 1.10  1997/10/09  09:11:06  johnh
 *  [Bug #30226]
 *  Add exitFn change in MLWorks.Deliver structure.
 *
 *  Revision 1.9  1997/06/16  12:13:56  jont
 *  [Bug #30101]
 *  Provide trig functions within MLWorks.Internal.Value for bootstrap process
 *
 *  Revision 1.8  1997/05/12  14:35:19  jont
 *  [Bug #20050]
 *  Provide MLWorks.Internal.IO.Io
 *
 *  Revision 1.7  1997/05/01  12:44:50  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 *  Revision 1.6  1997/03/19  14:27:13  andreww
 *  [Bug #1431]
 *  Altering calls to UnixOS etc.
 *
 *  Revision 1.5  1997/03/07  12:28:44  matthew
 *  Redefining MLWorks.Internal.environment
 *
 *  Revision 1.4  1996/05/30  15:11:18  jont
 *  Shell.Options.Compatibility has moved to Shell.Options.Language
 *
 *  Revision 1.3  1996/04/09  16:01:02  matthew
 *  Removing oldDefinition option
 *
 *  Revision 1.2  1996/04/02  13:44:02  jont
 *  Force to compile under old definition for the present
 *
 *  Revision 1.1  1996/04/01  17:00:41  jont
 *  new unit
 *  This is like change_nj.sml, but is for bootstrapping from
 *  an mlworks interactive system. It starts off requiring no
 *  environment alterations
 *
 *)

(* Now we want the new definition *)
Shell.Options.set(Shell.Options.Language.oldDefinition, false);

structure MLWorks =
  struct
    open MLWorks
    structure Deliver = 
      struct
	open Deliver
	datatype app_style = CONSOLE | WINDOWS
	type deliverer = string * (unit -> unit) * app_style -> unit
	val exitFn : (unit -> unit) ref = ref (fn () => ())
        val add_delivery_hook : (deliverer -> deliverer) -> unit =
          fn hook => ()
      end
    structure Internal = 
      struct
        open Internal
        structure Error =
          struct
            open Error
            val errorMsg:syserror ->string = fn _ => ""
            val errorName: syserror ->string = fn _ => ""
            val syserror: string -> syserror option 
              = fn _ => NONE
          end
	structure Value =
	  struct
	    open Value
	    val arctan : real -> real = Runtime.environment"real arctan"
	    val sin : real -> real = Runtime.environment"real sin"
	    val cos : real -> real = Runtime.environment"real cos"
	    val exp : real -> real = Runtime.environment"real exp"
	    val sqrt : real -> real = Runtime.environment"real square root"
	  end
        structure Runtime =
          struct
            open Runtime
            val environment =
              fn "Win32.fdToIOD" =>
	      Value.cast(fn _ => raise Error.SysErr("Unbound", NONE))
	    | s =>
              environment s handle exn as Unbound _ =>
		(case s of
		   "Windows.fileTimeToLocalFileTime" => Value.cast(fn x => x)
		 | "Win32.closeIOD" => Value.cast(fn x => ())
		 | _ => Value.cast (fn x => raise exn))
          end
	structure IO =
	  struct
	    exception Io of {name : string, function : string, cause : exn}
	    open IO
	  end
	structure Types =
	  struct
	    open Types
	    datatype time = TIME of int * int * int (* basis time *)
	  end
        structure Exit =
          struct
            type key = int
            type status = MLWorks.Internal.Types.word32
            val success : status = 0w0
            val failure : status = 0w1
            val atExit : (unit -> unit) -> key = fn _ => 0
            val removeAtExit : key -> unit = fn k => ()
            exception dummy
            val exit : status -> 'a = fn _ => raise dummy
            val terminate : status -> 'a = fn _ => raise dummy
          end
      end
  end





