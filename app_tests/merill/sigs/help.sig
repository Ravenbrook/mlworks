(*
 *
 * $Log: help.sig,v $
 * Revision 1.2  1998/06/08 17:35:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

help.sig

This file contains functions which control the access to help files.


MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     13/02/91
Glasgow University and Rutherford Appleton Laboratory.

*)

signature HELP = 
  sig
    val Help_Dir : string ref
    val Help_File : string ref
    val set_help_file : string -> unit
    val display_help : string -> unit
  end (* of signature HELP *)
  ;
