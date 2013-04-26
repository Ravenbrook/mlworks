(* podium.sml the signature *)

(*
$Log: podium.sml,v $
Revision 1.7  1997/06/17 15:35:04  johnh
Automatic checkin:
changed attribute _comment to ' *  '

 * Revision 1.1  1994/07/14  15:21:35  matthew
 * new unit
 * New unit
 *
Revision 1.5  1994/07/14  15:21:35  daveb
start_x_interface now has the type ListenerArgs -> bool -> unit.

Revision 1.4  1993/04/16  14:11:32  matthew
Renamed Args to ListenerArgs

Revision 1.3  1993/03/15  17:14:36  matthew
Renamed ShellData to Args
Changed type of start_x_interface

Revision 1.2  1993/03/08  15:21:53  matthew
Changes for ShellData type

Revision 1.1  1993/03/02  17:53:32  daveb
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

signature PODIUM =
sig

  type ListenerArgs

  val start_x_interface: ListenerArgs -> bool -> unit

end;
