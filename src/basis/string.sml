(*  ==== INITIAL BASIS : STRINGS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: string.sml,v $
 *  Revision 1.4  1997/08/07 14:49:11  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.3  1996/10/03  15:26:55  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/17  15:53:02  io
 *  from|toCString
 *
 *  Revision 1.1  1996/05/15  12:49:32  jont
 *  new unit
 *
 * Revision 1.4  1996/05/13  13:47:47  io
 * complete toString
 *
 * Revision 1.3  1996/05/10  12:15:57  io
 * revising
 *
 * Revision 1.2  1996/05/07  09:55:14  io
 * revising...
 *
 * Revision 1.1  1996/04/18  11:46:00  jont
 * new unit
 *
 *  Revision 1.2  1995/03/17  21:20:45  brianm
 *  Added Char structure dependency - doesn't assume Char is opened.
 *
 * Revision 1.1  1995/03/08  16:25:49  brianm
 * new unit
 * New file.
 *
 *)

require "char";

signature STRING =
  sig
    structure Char : CHAR
    eqtype char
      sharing type char = Char.char
    eqtype string
    val maxSize : int
    val size : string -> int
    val sub : (string * int) -> char
    val extract : (string * int * int option) -> string 
    val concat    : string list -> string
    val ^         : string * string -> string
    val implode   : char list -> string
    val explode : string -> char list
    val translate : (char -> string) -> string -> string 
    val compare : (string * string) -> order
    val str : char -> string
    val isPrefix : string -> string -> bool
    val substring : (string * int * int) -> string
    val fields : (char -> bool) -> string -> string list
    val tokens : (char -> bool) -> string -> string list
    val collate : (char * char -> order) -> (string * string) -> order

    val map  : ( char -> char) -> string -> string
    val mapi : (int * char -> char) -> string * int * int option -> string

    val fromString : string -> string option
    val toString : string -> string

    val fromCString : string -> string option
    val toCString : string -> string

    val <= : string * string -> bool
    val <  : string * string -> bool
    val >= : string * string -> bool
    val >  : string * string -> bool
  end
