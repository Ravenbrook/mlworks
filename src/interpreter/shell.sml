(*  ==== COMPILER SHELL ====
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
 *  A user interface to the incremental compiler.
 *
 *  Revision Log
 *  ------------
 *  $Log: shell.sml,v $
 *  Revision 1.16  1998/01/26 18:54:44  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 * Revision 1.15.3.2  1997/11/26  13:13:10  daveb
 * [Bug #30071]
 * The Shell.Error exception is no longer needed.
 *
 * Revision 1.15.3.1  1997/09/11  20:54:58  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.15  1997/03/17  14:30:32  matthew
 * Adding Shell.Error exception
 *
 * Revision 1.14  1996/01/22  14:01:03  daveb
 * Added new constructors to Result datatype.
 *
 *  Revision 1.13  1996/01/18  14:04:36  daveb
 *  Added Result datatype.  Made the do_line function take Info.options.
 *
 *  Revision 1.12  1996/01/16  11:23:25  daveb
 *  Revised interface of shell function.  Added ShellState type to preserve
 *  state information instead of storing it internally.  Replaced the list
 *  of offsets into the source with a list of strings, each being the source of
 *  a topdec, and an extra string for any remaining source.
 *
 *  Revision 1.11  1995/09/08  14:20:49  matthew
 *  Adding flush_stream function to interface.
 *
 *  Revision 1.10  1995/03/15  14:21:44  daveb
 *  prompt_function now takes the context name string as an argument.
 *
 *  Revision 1.9  1994/03/11  17:03:35  matthew
 *   Added Exit exception
 *
 *  Revision 1.8  1993/11/25  14:24:04  matthew
 *  > Moved exception DebuggerTrapped into ShellTypes for easier use elsewhere.
 *
 *  Revision 1.7  1993/08/10  12:18:37  matthew
 *  Added stream_name parameter to Shell.shell
 *
 *  Revision 1.6  1993/04/02  12:46:37  daveb
 *  The shell's do_line function now returns the positions of any topdecs
 *  that end in the current line, and whether the current topdec is still valid.
 *
 *  Revision 1.5  1993/03/29  14:26:16  matthew
 *  shell doesn't take output function now
 *
 *  Revision 1.4  1993/03/12  11:21:55  matthew
 *  Shell takes an output function
 *
 *  Revision 1.3  1993/03/05  15:51:48  matthew
 *  Removed Context type and parameter
 *
 *  Revision 1.2  1993/03/02  18:45:59  daveb
 *  Major revision.  Now provides a shell for both TTY and X based listeners.
 *
 *  Revision 1.1  1992/09/10  12:58:03  richard
 *  Initial revision
 *
 *)

require "../main/info";

signature SHELL =
sig
  structure Info: INFO

  type ShellData	(* info used to create a shell *)
  type ShellState	(* current state of an incremental parse *)
  type Context

  exception Exit of int

  val initial_state: ShellState

  datatype Result = 
    OK of ShellState
  | ERROR of Info.error * Info.error list
  | INTERRUPT
  | DEBUGGER_TRAPPED
  | TRIVIAL

  (* The shell function creates a shell, and returns two functions.
     The first of these processes an input string, and returns a list of
     the topdecs that were successfully compiled, the string remaining after
     that point, and a result value.  This result contains error information
     if an error occurred, or a new state if no error occurred.
     The second function converts a string into a prompt.  The state 
     argument provides a line_count, which determines whether to return
     a primary or secondary prompt. *)
  val shell :
    ShellData * string * (unit -> unit) (* flush stream *)
    -> (Info.options -> string * ShellState -> string list * string * Result)
       * (string * ShellState -> string)
end;
