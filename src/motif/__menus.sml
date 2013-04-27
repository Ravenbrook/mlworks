(* Motif menu bar utilites *)
(*

$Log: __menus.sml,v $
Revision 1.7  1999/03/23 14:51:11  johnh
[Bug #190536]
Add Version structure.

 * Revision 1.6  1997/11/03  14:30:38  johnh
 * [Bug #30125]
 * Add getenv structure to get help doc path.
 *
 * Revision 1.5  1996/10/30  18:27:58  daveb
 * Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.4  1996/04/30  09:24:12  matthew
 * Use basis/integer
 *
 * Revision 1.3  1995/07/26  14:11:15  matthew
 * Restructuring directories
 *
Revision 1.2  1993/03/30  16:14:24  matthew
 Added Integer structure
/

Revision 1.1  1993/03/17  16:29:13  matthew
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

require "../utils/__lists";
require "../motif/__xm";
require "../system/__getenv";
require "../main/__version";

require "_menus";

structure Menus_ = Menus(structure Lists = Lists_
			 structure Getenv = Getenv_
                         structure Xm = Xm
			 structure Version = Version_);
