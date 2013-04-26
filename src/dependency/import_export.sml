(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * Compute the imports and exports for one SML source file.
 *
 * $Log: import_export.sml,v $
 * Revision 1.2  1999/02/18 15:09:36  mitchell
 * [Bug #190507]
 * Improve handling of top-level opens.
 *
 *  Revision 1.1  1999/02/12  10:15:44  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "module_dec";
require "module_name";

signature IMPORT_EXPORT = sig
    structure ModuleName: MODULE_NAME
    structure ModuleDec : MODULE_DEC
    sharing ModuleName = ModuleDec.ModuleName

    (* env is an opaque type carrying information about symbols *)
    type env

    type context

    val mkBaseLookup: context -> ModuleName.t -> env

    val imports:
	ModuleDec.Dec *
	'info *				(* null info *)
	(ModuleName.t -> env * 'info) *	(* get env and info for global sym. *)
	('info * 'info -> 'info) *	(* combine information *)
	string                          (* source name *)
	->
	(ModuleName.t -> env) * 'info * (unit -> ModuleName.set)

    (* The third part of the result from `imports' is a thunk for
     * calculating the exports of the compilation unit.  The algorithm
     * for this doesn't suffer from the restriction of not allowing
     * top-level open, so it suits the needs of the autoloader.
     * However, for dependency analysis it is useless, because we
     * need to know exports in advance.  In this case one has to use
     * the following separate function (which does not allow
     * top-level open): *)
    val exports: ModuleDec.Dec * string -> ModuleName.set

    exception Undefined of ModuleName.t
    and IllegalToplevelOpen
    and InternalError of string

end



