(*  ==== FOREIGN INTERFACE : C_STRUCTURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __c_structure.sml,v $
 *  Revision 1.2  1996/09/05 16:10:07  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:14  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.2  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.1  1995/09/07  22:46:18  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:32:46  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "types";
require "structure";

require "__types";
require "__structure";

require "c_structure";

structure CStructure_ : C_STRUCTURE =
   struct

     structure FITypes   : FOREIGN_TYPES   = ForeignTypes_
     structure FIStructure : FOREIGN_STRUCTURE = Structure_

     structure FITypes = FITypes
     open FITypes

     open FIStructure

     type fStructure = fStructure


     val FIload_object_file  = FIStructure.load_object_file
     val FIfile_info     = FIStructure.file_info
     val FIsymbols       = FIStructure.symbols
     val FIsymbol_info   = FIStructure.symbol_info

     abstype c_structure = AC of fStructure
     with
         val to_struct    : c_structure -> fStructure = (fn (AC(x)) => x)

         val loadObjectFile : filename * load_mode -> c_structure =
             fn (fnm,lm) => AC(FIload_object_file(fnm,lm))

         val fileInfo    : c_structure -> (filename * load_mode) =
             fn (AC(cinfo)) => FIfile_info(cinfo)

         val symbols      : c_structure -> name list =
             fn (AC(cinfo)) => FIsymbols(cinfo)

         val symbolInfo  : c_structure * name -> value_type =
             fn (AC(cinfo),nm) => FIsymbol_info(cinfo,nm)
     end

   end;
