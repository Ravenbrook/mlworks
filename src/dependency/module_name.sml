(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * `module name' abstraction and related types
 *
 * $Log: module_name.sml,v $
 * Revision 1.2  1999/02/12 14:37:24  mitchell
 * [Bug #190507]
 * Fix require statements
 *
 *  Revision 1.1  1999/02/12  10:15:47  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "../basics/ident";

signature MODULE_NAME = sig

    structure Ident: IDENT

    type symbol and t and set and path
    eqtype namespace

    sharing type symbol = Ident.Symbol.Symbol

    exception ModuleNameError and PathError

    val equal: t * t -> bool
    val namespaceOf: t -> namespace
    val nameOf: t -> string
    val symbolOf: t -> symbol
    val makestring: t -> string

    val STRspace: namespace
    val SIGspace: namespace
    val FCTspace: namespace

    val create: namespace * string -> t

    val structMN: string -> t
    val sigMN: string -> t
    val functMN: string -> t

    val pathFirstModule: path -> t
    val restOfPath: path -> path option
    val pathLastModule: path -> t
    val mnListOfPath: path -> t list
    val pathOfMNList: t list -> path
    val createPathSML: string list * t -> path
    val nameOfPath: path -> string

    val memberOf: set -> t -> bool
    val singleton: t -> set
    val union: set * set -> set
    val intersection: set * set -> set
    val difference: set * set -> set
    val add: t * set -> set
    val addl: t list * set -> set
    val makeset: t list -> set
    val makelist: set -> t list
    val empty: set
    val isEmpty: set -> bool
    val fold: (t * 'a -> 'a) -> 'a -> set -> 'a
    val sameSet: set * set -> bool
    val setToString: set -> string
end




