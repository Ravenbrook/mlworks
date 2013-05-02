(* type_debugger.sml. Utilities for type checking information *)
(*
* $Log: type_debugger.sml,v $
* Revision 1.2  1996/08/05 16:36:01  andreww
* [Bug #1521]
* Propagating changes made to _types.sml:
* need to pass use_value_polymorphism flag to the print typevars
* functions.
*
 * Revision 1.1  1993/05/11  12:50:07  matthew
 * Initial revision
 *
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
*)

require "../basics/absyn";
require "../main/options";
signature TYPE_DEBUGGER =
  sig
    structure Options : OPTIONS
    structure Absyn: ABSYN
    val gather_vartypes :
      Absyn.TopDec ->
      (Absyn.Ident.ValId * Absyn.Type * Absyn.Ident.Location.T) list
    val print_vartypes :
      Options.options ->
      (Absyn.Ident.ValId * Absyn.Type * Absyn.Ident.Location.T) list -> unit
  end

