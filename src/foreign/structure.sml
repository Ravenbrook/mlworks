(*  ==== FOREIGN INTERFACE : FOREIGN_STRUCTURE ====
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
 *  $Log: structure.sml,v $
 *  Revision 1.2  1996/09/05 16:13:38  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:18  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  13:59:09  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.2  1996/03/28  12:58:55  matthew
 * New sharing syntax etc.
 *
 * Revision 1.1  1995/09/07  22:47:17  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 * Revision 1.2  1995/04/19  23:37:57  brianm
 * General updating to reach prototype level for ML FI.
#
 * Revision 1.1  1995/03/27  15:48:58  brianm
 * new unit
 * New file.
#
 *
 *)

require "types";

signature FOREIGN_STRUCTURE =
   sig

     structure FITypes : FOREIGN_TYPES

     type name = FITypes.name  
     type filename = FITypes.filename

     type foreign_module
     type fStructure

     datatype load_mode = IMMEDIATE_LOAD | DEFERRED_LOAD

     val load_object_file : filename * load_mode -> fStructure
     val file_info : fStructure -> (filename * load_mode)

     val filesLoaded : unit -> filename list
     val symbols      : fStructure -> name list

     datatype value_type = CODE_VALUE | VAR_VALUE | UNKNOWN_VALUE

     val symbol_info : fStructure * name -> value_type

     val module : fStructure -> foreign_module

   end;
