(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: __import_export.sml,v $
 * Revision 1.1  1999/02/12 10:15:59  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)

require "__module_dec";
require "_import_export";
require "../lambda/__environprint" ;
require "../main/__info" ;

structure ImportExport =
  ImportExport(structure ModuleDec = ModuleDec
               structure EnvironPrint = EnvironPrint_
               structure Info = Info_)










