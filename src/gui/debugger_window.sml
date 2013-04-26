(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 $Log: debugger_window.sml,v $
 Revision 1.2  1996/05/29 12:54:25  daveb
 make_debugger_window now returns a pair of functions.  The second of these
 is to be run at the end of the evaluation, and clears the windows, etc.
 This reduces flicker (Bug 1065), and stops the debugger from always popping
 to the top.

 * Revision 1.1  1995/06/15  15:00:49  matthew
 * new unit
 * New unit
 *
Revision 1.11  1995/06/15  15:00:49  daveb
Hid details of WINDOWING type in ml_debugger.

Revision 1.10  1995/03/20  14:52:31  matthew
stuff

Revision 1.9  1995/01/13  15:39:56  daveb
Replaced Option structure with references to MLWorks.Option.

Revision 1.8  1993/12/09  19:35:26  jont
Added copyright message

Revision 1.7  1993/08/09  16:20:15  nosa
Inspector invocation in debugger-window.

Revision 1.6  1993/08/06  10:53:08  nosa
New option ShowFrameInfo in debugger window.

Revision 1.5  1993/06/02  01:59:17  nosa
Changed Option.T to Option.opt.

Revision 1.4  1993/05/12  14:53:33  matthew
Added message function

Revision 1.3  1993/05/07  17:00:18  matthew
Added quit and continue functions

Revision 1.2  1993/04/30  13:13:51  matthew
Changed type of window creation

Revision 1.1  1993/03/25  12:56:45  matthew
Initial revision

*)
signature DEBUGGERWINDOW =
  sig
    type Widget
    type ToolData

    type debugger_window

    val make_debugger_window : 
      Widget * string * ToolData ->
      debugger_window * (unit -> unit)
    (* make_debugger_window (parent, str, tooldata); creates a debugger
       window.  Returns two functions.  The first should be passed to
       ML_Debugger.ml_debugger, which will use it to start a debugging
       session.  The second should be called at the end of an evaluation;
       it resets assorted state. *)
  end;
