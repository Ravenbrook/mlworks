(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: module_dec_io.sml,v $
 * Revision 1.3  1999/03/10 16:17:43  mitchell
 * [Bug #190526]
 * Move dependency precis files to object directory
 *
 *  Revision 1.2  1999/02/12  15:42:47  sml
 *  [Bug #190507]
 *  Fix require statements
 *
 *  Revision 1.1  1999/02/12  10:15:46  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "../system/__time";
require "module_dec";

signature MODULE_DEC_IO =
sig
  structure ModuleDec: MODULE_DEC

  val source_to_module_dec : 
    string * Time.time option * string -> ModuleDec.Dec * string list * bool
end
    
