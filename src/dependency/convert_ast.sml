(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: convert_ast.sml,v $
 * Revision 1.2  1999/02/18 15:09:36  mitchell
 * [Bug #190507]
 * Improve handling of top-level opens.
 *
 *  Revision 1.1  1999/02/12  10:15:42  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "../basics/absyn";
require "module_dec";

signature CONVERT_AST =
sig
  structure ModuleDec: MODULE_DEC
  structure Absyn  : ABSYN

  val convert: Absyn.TopDec -> ModuleDec.Dec 
end
