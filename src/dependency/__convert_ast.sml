(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __convert_ast.sml,v $
 * Revision 1.1  1999/02/12 10:15:58  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)

require "_convert_ast";
require "__module_dec";
require "../basics/__absyn";

structure ConvertAST =
  ConvertAST(structure ModuleDec = ModuleDec
             structure Absyn   = Absyn_ )

