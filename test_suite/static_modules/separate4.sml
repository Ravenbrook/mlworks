(*
Disallow mid-file requires

Result: FAIL
 
$Log: separate4.sml,v $
Revision 1.11  1997/11/26 13:45:58  daveb
[Bug #30323]
Removed uses of Shell.Build.loadSource.

 * Revision 1.10  1996/12/20  12:26:00  jont
 * [Bug #0]
 * Test suite location has changed
 *
 * Revision 1.9  1996/04/18  11:10:19  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.8  1996/02/23  16:18:47  daveb
 * Converted Shell structure to new capitalisation convention.
 *
Revision 1.7  1996/01/25  17:34:05  jont
More Shell modifications

Revision 1.6  1996/01/24  11:56:54  stephenb
Replace MLWorks.OS.Unix.getwd by OS.FileSys.getDir

Revision 1.5  1995/12/08  11:45:57  daveb
Shell compile commands have changed.

Revision 1.4  1995/02/24  15:21:38  jont
Modify to be only for the make system (ie not for .mo files)

Revision 1.3  1994/04/26  16:01:22  jont
Shell structure revisions

Revision 1.2  1993/08/20  13:45:28  jont
Revised for new module naming system

Revision 1.1  1993/08/04  13:12:22  jont
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

Shell.Path.setSourcePath([OS.FileSys.getDir()]);
Shell.Module.loadSource "static_modules.separate4_b";
