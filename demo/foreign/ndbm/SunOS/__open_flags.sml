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
 * The following are taken from /usr/include/sys/fcntlcom.h under SunOS 4.1.X.
 * 
 * Revision Log
 * -----------
 *
 * $Log: __open_flags.sml,v $
 * Revision 1.3  1997/06/30 10:44:24  stephenb
 * [Bug #30029]
 * Correct copyright.
 *
 *  Revision 1.2  1997/05/14  09:50:33  stephenb
 *  [Bug #30121]
 *  Spell "Revision Log" correctly so that the remove_log.sh script
 *  can remove the revision log when a distribution is created.
 *
 *  Revision 1.1  1997/04/29  14:51:39  stephenb
 *  new unit
 *  [Bug #30030]
 *
 *
 *)

structure OpenFlags = 
  struct
    val O_RDONLY = 0
    val O_WRONLY = 1
    val O_RDWR   = 2
    val O_CREAT  = 0x200
  end
