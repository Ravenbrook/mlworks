(*  ==== FOREIGN INTERFACE : C FUNCTION ====
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
 *  This provides the function calling interface for C.
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: c_function.sml,v $
 *  Revision 1.6  1996/09/03 13:48:49  io
 *  [Bug #1547]
 *  update to current naming conventions
 *
 * Revision 1.5  1996/05/24  01:19:16  brianm
 * Beta release modifications.
 *
 * Revision 1.4  1996/03/28  14:17:05  matthew
 * Sharing changes
 *
 * Revision 1.3  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 *  Revision 1.2  1995/09/07  22:43:42  brianm
 *  Modifications for reorganisation & documentation.
 *
 *  Revision 1.1  1995/04/25  11:47:30  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "types";
require "c_signature";
require "c_object";
require "c_structure";

signature C_FUNCTION =
  sig

    structure CSignature   : C_SIGNATURE
    structure CStructure   : C_STRUCTURE
    structure CObject      : C_OBJECT
    structure FITypes      : FOREIGN_TYPES

    type name   = FITypes.name 
    type c_type = CObject.c_type

    type c_structure = CStructure.c_structure

    type c_signature = CSignature.c_signature

    type c_object = CObject.c_object

    type c_function

    val defineForeignFun : (c_structure * c_signature) -> (name -> c_function)

    val call  : c_function -> (c_object list * c_object) -> unit

  end; (* signature C_FUNCTION *)
