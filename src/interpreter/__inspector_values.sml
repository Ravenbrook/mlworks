(* inspector utilities
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
 * $Log: __inspector_values.sml,v $
 * Revision 1.6  1995/10/13 23:53:30  brianm
 * Adding ValuePrinter_ dependency ...
 *
Revision 1.5  1994/06/09  15:59:25  nickh
New runtime directory structure.

Revision 1.4  1993/05/18  15:14:12  jont
Removed integer parameter

Revision 1.3  1993/04/20  10:23:38  matthew
Renamed Inspector_Values to InspectorValues

Revision 1.2  1993/04/01  11:02:51  matthew
Removed ValuePrinter structure

Revision 1.1  1993/03/12  15:26:29  matthew
Initial revision

 *)

require "../utils/__lists";
require "../utils/__crash";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__scheme";
require "../rts/gen/__tags";
require "../debugger/__value_printer";

require "_inspector_values";

structure InspectorValues_ = InspectorValues(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Types = Types_
  structure Valenv = Valenv_
  structure Scheme = Scheme_
  structure Tags = Tags_
  structure ValuePrinter = ValuePrinter_
					     )
