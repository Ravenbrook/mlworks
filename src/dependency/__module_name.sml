(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __module_name.sml,v $
 * Revision 1.1  1999/02/12 10:16:01  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)
 
require "module_name";
require "_module_name";
require "../basics/__ident";

structure ModuleName =
  ModuleName(structure Ident = Ident_) : MODULE_NAME;
