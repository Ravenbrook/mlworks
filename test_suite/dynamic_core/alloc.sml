(*
 *
 * Result: OK
 *
 * $Log: alloc.sml,v $
 * Revision 1.2  1997/10/14 12:47:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

val explode : string -> string list = MLWorks.Internal.Runtime.environment"string explode";

val str  = explode"abcde";
