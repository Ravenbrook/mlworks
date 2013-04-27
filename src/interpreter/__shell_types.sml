(* Types for passing to the shell and listener creation functions.
 *
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
 *
 * $Log: __shell_types.sml,v $
 * Revision 1.10  1995/04/28 10:48:07  daveb
 * Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.9  1995/03/06  18:30:36  daveb
 *  Added InterPrint parameter.
 *  
 *  Revision 1.8  1995/03/01  10:56:49  matthew
 *  Removing ValuePrinter from parameter
 *  
 *  Revision 1.7  1994/08/01  09:02:51  daveb
 *  Added Preferences argument.
 *  
 *  Revision 1.6  1994/06/17  13:34:39  daveb
 *  Added Btree argument.
 *  
 *  Revision 1.5  1993/09/02  14:13:21  daveb
 *  Added Crash parameter.
 *  
 *  Revision 1.4  1993/05/18  15:25:18  jont
 *  Removed integer parameter
 *  
 *  Revision 1.3  1993/05/04  15:13:55  matthew
 *  Added Integer substructure
 *  
 *  Revision 1.2  1993/04/06  16:07:27  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.1  1993/02/26  12:18:59  daveb
 *  Initial revision
 *  
 *
 *)

require "__user_context";
require "../main/__user_options";
require "../main/__preferences";
require "_shell_types";

structure ShellTypes_ = ShellTypes(
  structure UserContext = UserContext_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
)
