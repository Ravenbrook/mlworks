(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __module_dec.sml,v $
 * Revision 1.1  1999/02/12 10:16:00  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)

require "_module_dec";
require "__module_name";

structure ModuleDec =
  ModuleDec(structure ModuleName = ModuleName)
