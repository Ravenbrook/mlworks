(* FILE SYSTEM INTERFACE *)
(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * Revision 1.2  1996/05/31 15:48:37  stephenb
 * Functor now needs OSPath_ as an argument since realPath is implemented
 * using OS.Path routines.
 *
 *  Revision 1.1  1996/05/17  09:30:39  stephenb
 *  new unit
 *  Renamed from __os_filesys in line with latest file name conventions.
 *
 *  Revision 1.1  1996/05/08  12:29:52  stephenb
 *  new unit
 *  Changed name from filesys inline with lastest filename conventions.
 *
 * Revision 1.2  1996/01/18  16:23:46  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, parameterise the functor with
 * the Win32 structure.
 *
# Revision 1.1  1995/01/25  17:16:32  daveb
# new unit
# The OS.FileSys structure from the basis.
#
 *
 *)

require "__win32";
require "__os_path";
require "_os_file_sys";

structure OSFileSys_ = 
  OSFileSys
    (structure Win32 = Win32_
     structure Path = OSPath_)
