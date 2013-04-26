(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __module_dec_io.sml,v $
 * Revision 1.1  1999/02/12 10:16:01  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)

require "../parser/__parser";
require "../main/__options";
require "__convert_ast";
require "_module_dec_io";

structure ModuleDecIO =
  ModuleDecIO (structure ConvertAST = ConvertAST
               structure Options = Options_
               structure Parser = Parser_)


