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
 * Test OS.Process.system.
 * Currently only tests that system is supported since this is the only
 * test I can think of that is portable across all OSes.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_process_system.sml,v $
 * Revision 1.5  1999/04/23 09:24:24  daveb
 * [Bug #190553]
 * OS.Process.status is no longer an equality type.
 *
 *  Revision 1.4  1997/11/21  10:46:09  daveb
 *  [Bug #30323]
 *
 *  Revision 1.3  1997/04/01  16:45:01  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/05/22  10:19:23  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/04/11  14:28:05  stephenb
 *  new unit
 *  Test for OS.Process.system
 *
 *)

OS.Process.isSuccess (OS.Process.system "");
