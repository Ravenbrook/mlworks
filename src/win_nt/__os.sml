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
 * Revision Log
 * ------------
 *
 * $Log: __os.sml,v $
 * Revision 1.9  1996/05/21 11:22:34  stephenb
 * Update to use basis conforming Path rather than the out of date
 * one that has been standing in up until now.
 *
 *  Revision 1.8  1996/05/17  09:29:57  stephenb
 *  Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 *  Revision 1.7  1996/05/08  12:30:30  stephenb
 *  Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 *  Revision 1.5  1996/04/18  15:07:10  jont
 *  initbasis becomes basis
 *
 *  Revision 1.4  1996/04/12  12:06:00  stephenb
 *  Add Process
 *
 *  Revision 1.3  1996/04/01  14:46:26  stephenb
 *  new unit
 *  OS interface as defined in latest basis.
 *
 *
 *)

require "_os";
require "__win32";
require "__os_file_sys";
require "__os_path";
require "__os_io";
require "^.basis.__os_process";

structure OS = OS
  (structure Win32 =   Win32_
   structure FileSys = OSFileSys_
   structure Path =    OSPath_
   structure Process = OSProcess_
   structure IO =      OSIO_);
