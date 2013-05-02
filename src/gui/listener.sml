(* listener.sml the signature *)

(*
$Log: listener.sml,v $
Revision 1.1  1995/07/18 11:51:22  matthew
new unit
New unit

Revision 1.8  1995/07/18  11:51:22  matthew
Adding "external listener" flag

Revision 1.7  1994/03/11  17:07:58  matthew
Removed Exit exn

Revision 1.6  1993/04/16  10:46:26  matthew
Changed type of create function

Revision 1.5  1993/04/02  15:05:31  matthew
Removed Incremental structure

Revision 1.4  1993/03/19  14:57:45  matthew
create takes application exit function

Revision 1.3  1993/03/15  17:13:49  matthew
Simplified type of create
Renamed ShellData to Args

Revision 1.2  1993/03/08  15:18:43  matthew
Changes for ShellData type

Revision 1.1  1993/03/02  17:52:49  daveb
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

signature LISTENER =
sig
  type ToolData

  val create : bool -> ToolData -> unit
end;
