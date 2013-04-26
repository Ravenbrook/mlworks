(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: module_dec.sml,v $
 * Revision 1.1  1999/02/12 10:15:45  mitchell
 * new unit
 * [Bug #190507]
 * Adding files to support CM-style dependency analysis
 *
 *)
 
require "module_name";

signature MODULE_DEC =
sig
  structure ModuleName : MODULE_NAME

  datatype Dec =
      StrDec of { name: ModuleName.t,
                  def: StrExp,
                  constraint: StrExp option
                } list
    | FctDec of { name: ModuleName.t, 
                  params: (ModuleName.t option * StrExp) list,
                  body: StrExp,
                  constraint: StrExp option
                } list
    | LocalDec of Dec * Dec
    | SeqDec   of Dec list    
    | OpenDec  of StrExp list
    | DecRef   of ModuleName.set

  and StrExp = 
      VarStrExp  of ModuleName.path
    | BaseStrExp of Dec
    | AppStrExp  of ModuleName.t * StrExp 
    | LetStrExp  of Dec * StrExp  
    | AugStrExp  of StrExp * ModuleName.set (* StrExp where ... *)
    | ConStrExp  of StrExp * StrExp   (* Constrained StrExp *)

  val display : (string -> unit) -> Dec -> unit
end






