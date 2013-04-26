(*  ==== FOREIGN INTERFACE : Top Level ====
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
 *  Implementation
 *  --------------
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: __foreign.sml,v $
 *  Revision 1.8  1996/10/25 12:51:24  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 * Revision 1.7  1996/05/23  23:27:52  brianm
 * Beta release modifications.
 *
 * Revision 1.6  1996/04/18  16:55:14  jont
 * initbasis becomes basis
 *
 * Revision 1.5  1995/09/10  18:38:23  brianm
 * Further modification for updates and general reorganisation.
 *
 *  Revision 1.4  1995/09/07  22:43:38  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.3  1995/07/07  11:05:41  brianm
 *  Adding external value support - LIB-ML.
 *
 *  Revision 1.2  1995/06/15  17:02:05  brianm
 *  Adding FI diagnostics, more facilities including remote access.
 *
 *  Revision 1.1  1995/05/29  18:07:32  brianm
 *  new unit
 *  Top level file defining the ForeignInterface.
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__word8";

require "__libml";
require "__store";
require "__aliens";
require "__object";
require "__types";
require "__c_function";
require "foreign";

structure ForeignInterface : FOREIGN_INTERFACE =
   struct
      type 'a option = 'a option

      open ForeignTypes_

      structure Store = ForeignStore_
      structure Object = ForeignObject_
      structure Aliens = ForeignAliens_
      structure LibML  = LibML_

      structure C =
      struct

	 (* C STRUCT *)
	 structure Structure = CFunction_.CStructure

	 (* C TYPE *)
	 structure Type = CFunction_.CObject

	 (* C VALUE STRUCTURE *)
	 structure Value = CFunction_.CObject

	 (* C Signature *)
	 structure Signature = CFunction_.CSignature

	 (* C FUNCTION *)
	 structure Function = CFunction_

         (* C Diagnostic *)

         structure Diagnostic =  CFunction_.CObject

      end (* C_INTERFACE *)


      (* FI Diagnostic *)
      structure Diagnostic = Store

   end; (* ForeignInterface *)
