(* version.sml the signature *)
(*
$Log: version.sml,v $
Revision 1.6  1998/07/17 14:55:00  jkbrook
[Bug #30436]
Update edition names

 * Revision 1.5  1998/06/11  18:51:17  jkbrook
 * [Bug #30411]
 * Need to pass version number to license-file checking code
 *
 * Revision 1.4  1998/06/11  15:08:00  johnh
 * [Bug #30411]
 * put editionStr into sig to be checked by Capi for splash screen.
 *
 * Revision 1.3  1997/03/24  18:01:00  daveb
 * [Bug #1990]
 * Replaced the version string with a function that constructs the string from
 * a datatype.  The MLW_FULL_VERSION environment/registry setting controls
 * whether the full version string is printed.
 *
 * Revision 1.2  1993/02/02  15:01:53  jont
 * Added copyright message
 *
Revision 1.1  1992/12/01  10:47:15  clive
Initial revision

Copyright (C) 1993 Harlequin Ltd
*)

signature VERSION = 
  sig
    datatype kind = MILESTONE of int
                  | ALPHA of int
                  | BETA of int
                  | FULL of int

    datatype edition = ENTERPRISE | PERSONAL | PROFESSIONAL

    val edition: unit -> edition

    val versionString : unit -> string

    val get_status : unit -> kind 
  end
