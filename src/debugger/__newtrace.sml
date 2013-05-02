(*  Tracing utility
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
 *  $Log: __newtrace.sml,v $
 *  Revision 1.5  1996/06/21 08:52:30  stephenb
 *  Replace old utils/lists with basis/list.
 *
 * Revision 1.4  1995/03/08  11:00:38  matthew
 * Adding StackInterface structure
 *
Revision 1.3  1995/02/21  11:01:23  matthew
Added ShellTypes and DebuggerUtilities

Revision 1.2  1994/06/09  15:48:14  nickh
New runtime directory structure.

Revision 1.1  1993/05/07  10:44:55  matthew
Initial revision

 *
 *)

require "../basis/__list";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../main/__user_options";
require "../rts/gen/__tags";
require "../interpreter/__incremental";
require "../interpreter/__shell_types";
require "__value_printer";
require "../machine/__stack_interface";
require "__debugger_utilities";

require "_newtrace";

structure Trace_ = Trace (structure List = List
                          structure Tags = Tags_
                          structure Types = Types_
                          structure Scheme = Scheme_
                          structure UserOptions = UserOptions_
                          structure Incremental = Incremental_
                          structure ShellTypes = ShellTypes_
                          structure ValuePrinter = ValuePrinter_
                          structure StackInterface = StackInterface_
                          structure DebuggerUtilities = DebuggerUtilities_
                            );
