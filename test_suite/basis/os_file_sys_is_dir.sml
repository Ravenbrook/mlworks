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
Result: OK

 *
 * Test OS.FileSys.isDir.  All tests should return true.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_file_sys_is_dir.sml,v $
 * Revision 1.6  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.5  1997/11/21  10:45:21  daveb
 *  [Bug #30323]
 *
 *  Revision 1.4  1997/04/01  16:42:32  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1996/06/18  15:55:55  stephenb
 *  Change the "" test so that it expects an OS.SysErr exception to be raised.
 *
 *  Revision 1.2  1996/05/22  10:19:08  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/17  11:58:23  stephenb
 *  new unit
 *
 *
 *)


val a = (ignore(OS.FileSys.isDir "no such file"); false) handle OS.SysErr _ => true;

val b = (ignore(OS.FileSys.isDir ""); false) handle OS.SysErr _ => true;  

val c = OS.FileSys.isDir "basis";

val d = OS.FileSys.isDir "README" = false;
