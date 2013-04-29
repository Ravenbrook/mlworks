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

signature VERSION = 
  sig
    datatype kind = MILESTONE of int
                  | ALPHA of int
                  | BETA of int
                  | FULL of int

    (* Since open-sourcing MLWorks, the only edition is PROFESSIONAL *)
    datatype edition = ENTERPRISE | PERSONAL | PROFESSIONAL

    val edition: unit -> edition

    val versionString : unit -> string

    val get_status : unit -> kind 
  end
