(* tty inspector
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
 * $Log: __inspector.sml,v $
 * Revision 1.5  1995/02/14 14:07:50  matthew
 * Removing Parser structure
 *
Revision 1.4  1993/05/18  18:47:07  jont
Removed integer parameter

Revision 1.3  1993/04/21  16:00:32  matthew
Added parameter structures.  Not all used currently

Revision 1.2  1993/04/20  10:25:05  matthew
 Renames Inspector_Values to InspectorValues

Revision 1.1  1993/03/12  15:25:10  matthew
Initial revision

 *)

require "../utils/__lists";
require "../interpreter/__incremental";
require "../typechecker/__basis";
require "../typechecker/__types";
require "../interpreter/__inspector_values";
require "../main/__user_options";
require "../interpreter/__shell_types";
require "../debugger/__value_printer";

require "_inspector";

structure Inspector_ = Inspector (
                                  structure Lists = Lists_
                                  structure Incremental = Incremental_
                                  structure Basis = Basis_
                                  structure Types = Types_
                                  structure InspectorValues = InspectorValues_
                                  structure UserOptions = UserOptions_
                                  structure ShellTypes = ShellTypes_
                                  structure ValuePrinter = ValuePrinter_
                                    )

