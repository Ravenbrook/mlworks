(* __version.sml the structure *)
(*
$Log: __version.sml,v $
Revision 1.27  1999/03/09 15:54:47  mitchell
[Bug #190509]
Update version strings to 2.1

 * Revision 1.26  1998/08/14  14:18:33  jkbrook
 * [Bug #30477]
 * Remove extra space after edition name in version string
 *
 * Revision 1.25  1998/07/30  14:01:02  jkbrook
 * [Bug #30456]
 * Update for 2.0c0
 *
 * Revision 1.24  1998/07/17  14:53:01  jkbrook
 * [Bug #30436]
 * Update edition names
 *
 * Revision 1.23  1998/06/12  11:18:37  jkbrook
 * [Bug #30415]
 * Update version strings for 2.0b2
 *
 * Revision 1.22  1998/06/10  19:41:34  jkbrook
 * [Bug #30411]
 * Need to pass version number to license-file checking code
 *
 * Revision 1.21  1998/05/11  16:20:20  johnh
 * [Bug #30303]
 * pick up edition from runtime.
 *
 * Revision 1.20  1998/03/12  16:36:32  jkbrook
 * [Bug #30368]
 * Update version info for 2.0b0
 *
 * Revision 1.19  1998/01/12  14:39:25  jkbrook
 * [Bug #30315]
 * Updating version strings for 2.0m2
 *
 * Revision 1.18  1997/10/03  13:33:48  jkbrook
 * [Bug #30272]
 * Updating version info to 2.0m1
 *
 * Revision 1.17  1997/08/07  14:25:00  brucem
 * [Bug #30232]
 * Dont' print r0 in version string.
 *
 * Revision 1.16  1997/06/16  10:13:20  daveb
 * [Bug #30169]
 * Updated version strings for 2.0m0.
 *
 * Revision 1.15  1997/03/27  15:06:33  daveb
 * [Bug #1990]
 * Replaced the version string with a function that constructs the string from
 * a datatype.  The MLW_FULL_VERSION environment/registry setting controls
 * whether the full version string is printed.
 *
 * Revision 1.14  1996/11/12  13:00:34  jont
 * Update to release copyright string
 *
 * Revision 1.13  1996/09/04  16:12:26  jont
 * Add expiry date warning
 *
 * Revision 1.12  1996/07/04  13:57:45  jont
 * Upgrade version number again
 *
 * Revision 1.11  1996/06/27  09:50:16  jont
 * Change to be revision 11
 *
 * Revision 1.10  1994/06/23  10:18:32  nickh
 * Lots of recent changes (new runtime, new ancillaries, new code names).
 *
Revision 1.9  1994/01/28  11:11:50  daveb
Released version 8 to ts; changed version number to 9.

Revision 1.8  1993/06/02  12:49:45  richard
Revision 7 released to ts.  Changed revision to 8.

Revision 1.7  1993/05/12  14:01:43  richard
Revision 6 released to ts.  Now revision 7.

Revision 1.6  1993/03/08  18:41:32  jont
Upgraded to version 5 to indicate move to native motif mode

Revision 1.5  1993/02/02  15:02:21  jont
Added copyright message

Revision 1.4  1993/01/29  11:19:49  jont
New revision number 4

Revision 1.3  1992/12/22  13:03:17  jont
Now revision 3

Revision 1.2  1992/12/15  15:15:50  jont
Revision 2

Revision 1.1  1992/12/01  10:47:32  clive
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "version";
require "../basis/__int";
require "../system/__getenv";

structure Version_ : VERSION =
  struct
    datatype kind = MILESTONE of int 
                  | ALPHA of int 
                  | BETA of int 
                  | FULL of int 

    (* constructors must kept consistent with those in rts/sha/mlw_mklic.h *)
    (* and in alphabetical order *)

    (* Since open-sourcing MLWorks, the only edition is PROFESSIONAL *)
    datatype edition = ENTERPRISE | PERSONAL | PROFESSIONAL

    fun edition () = PROFESSIONAL

    fun current () = {major = 2, 
                      minor = 1, 
                      revision = 0, 
                      status = FULL 0,
                      edition = edition()}

    fun get_status () = #status(current())

    (* this tells us whether to print "Beta" after the main edition, 
       e.g., Personal Beta *)

    fun statusString status = 
      case status of
         BETA _ => "Beta "
       | _  => ""

    val copyright =
      "Copyright (C) 1999 Harlequin Group plc." ^
      "  All rights reserved.\n" ^
      "MLWorks is a trademark of Harlequin Group plc.\n"

    fun printEdition (edition) =
      case edition of 
          ENTERPRISE => "Enterprise"
        | PERSONAL => "Personal"
        | PROFESSIONAL => "Professional"

    fun printStatus (MILESTONE i) = "m" ^ Int.toString i
    |   printStatus (ALPHA i) = "a" ^ Int.toString i
    |   printStatus (BETA i) = "b" ^ Int.toString i
    |   printStatus (FULL i) =
      case Getenv_.get_version_setting () of
	SOME "full" => "c" ^ Int.toString i
      | _ => ""

    fun printVersion {major, minor, revision, status, edition} =
      Int.toString major ^ "." ^
      Int.toString minor ^ 
      (if (revision=0) then "" else ("r" ^ Int.toString revision)) ^
      printStatus status ^
       " " ^ printEdition edition ^ " " ^ 
       statusString status ^ 
       "Edition" 

    fun versionString () =
      "MLWorks " ^ (printVersion (current())) ^ "\n" ^ copyright

  end







