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
 *
 * $Log: __entry.sml,v $
 * Revision 1.2  1999/02/02 15:59:56  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.1  1995/07/17  11:47:10  matthew
 * new unit
 * Moved from motif
 *
 *
 *  Revision 1.1  1995/07/14  16:47:09  io
 *  new unit
 *  move context_browser bits over.
 *
 *
 *)

require "../main/__user_options";
require "../utils/__crash";
require "../basics/__identprint";
require "../typechecker/__basistypes";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__scheme";
require "../interpreter/__incremental";
require "_entry";

structure Entry_ =
  Entry (
    (*structure Lists : LISTS*)
    structure IdentPrint = IdentPrint_
    structure BasisTypes = BasisTypes_
    structure Types = Types_
    structure Valenv = Valenv_
    structure Scheme = Scheme_
    structure Crash = Crash_
    structure UserOptions = UserOptions_
    structure Incremental = Incremental_
)
