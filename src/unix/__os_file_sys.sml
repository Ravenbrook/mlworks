(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: __os_file_sys.sml,v $
 * Revision 1.2  1996/05/23 12:02:00  stephenb
 * Functor application now requires a OSPath_ argument for the implementation
 * of realPath.
 *
 *  Revision 1.1  1996/05/17  09:27:04  stephenb
 *  new unit
 *  Renamed from __os_filesys in line with latest file name conventions.
 *
 *  Revision 1.1  1996/05/08  12:27:00  stephenb
 *  new unit
 *  Changed name from filesys inline with lastest filename conventions.
 *
 * Revision 1.2  1996/01/18  09:53:02  stephenb
 * OS reorganisation: parameterise functor with UnixOS since OS
 * specific stuff is no longer in the pervasive library.
 *
# Revision 1.1  1995/01/25  17:17:53  daveb
# new unit
# The OS.FileSys structure from the basis.
#
 *
 *)

require "__unixos";
require "__os_path";
require "_os_file_sys";

structure OSFileSys_ = 
  OSFileSys
    (structure UnixOS = UnixOS_
     structure Path = OSPath_)
