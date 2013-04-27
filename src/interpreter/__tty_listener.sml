(*  TTY Listener.
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
 *  $Log: __tty_listener.sml,v $
 *  Revision 1.10  1997/03/14 14:43:08  matthew
 *  Removing ActionQueue
 *
 * Revision 1.9  1995/05/25  10:29:49  daveb
 * Added Preferences parameter.
 *
 *  Revision 1.8  1995/04/28  12:11:40  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.7  1995/03/02  15:38:27  daveb
 *  Removed List and TopLevel parameters.
 *  
 *  Revision 1.6  1994/12/08  17:30:03  jont
 *  Move OS specific stuff into a system link directory
 *  
 *  Revision 1.5  1993/05/20  09:53:32  matthew
 *  Added Unix structure
 *  
 *  Revision 1.4  1993/04/06  16:07:49  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.3  1993/03/30  10:29:47  matthew
 *  Added ActionQueue (used by .mlworks facility)
 *  
 *  Revision 1.2  1993/03/09  13:31:29  matthew
 *  Structure changes
 *  
 *  Revision 1.1  1993/03/01  17:41:31  daveb
 *  Initial revision
 *  
 *
 *)

require "../debugger/__ml_debugger";
require "__shell_types";
require "__shell";
require "__user_context";
require "../main/__user_options";
require "../main/__preferences";
require "_tty_listener";

structure TTYListener_ = TTYListener (
  structure Ml_Debugger = Ml_Debugger_
  structure ShellTypes = ShellTypes_
  structure UserContext = UserContext_
  structure Shell = Shell_
  structure Preferences = Preferences_
  structure UserOptions = UserOptions_
);
