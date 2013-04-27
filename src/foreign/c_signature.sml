(*  ==== FOREIGN INTERFACE : C SIGNATURES ====
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
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: c_signature.sml,v $
 *  Revision 1.2  1996/09/05 15:18:33  io
 *  [Bug #1547]
 *  update to current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:17  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.3  1996/03/28  14:14:03  matthew
 * Sharing changes
 *
 * Revision 1.2  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.1  1995/09/07  22:45:38  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:41:43  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "c_object";
require "types";

signature C_SIGNATURE =
  sig

    structure CObject : C_OBJECT

    type name      = CObject.name
    type filename
    type c_type    = CObject.c_type

  (* DECLARATION ENTRY *)

    datatype c_decl =
        UNDEF_DECL
    |
        VAR_DECL of { name : name, ctype : c_type }
    |
        FUN_DECL of { name   : name,
                      source : c_type list,
                      target : c_type }
    |
        TYPE_DECL of { name : name,
                       defn : c_type,
                       size : int }
    |
        CONST_DECL of { name : name, ctype : c_type }


    (* C Signature operations *)

    type c_signature

    val newSignature      : unit -> c_signature

    val lookupEntry : c_signature -> name -> c_decl
    val defEntry    : c_signature * c_decl -> unit
    val removeEntry   : c_signature * name -> unit

    val showEntries : c_signature -> c_decl list

    exception UnknownTypeName of string

    val normaliseType : c_signature -> (c_type -> c_type)

    val loadHeader : filename -> c_signature

  end; (* signature C_SIGNATURE *)
