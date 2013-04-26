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
 * See exit.sml for documentation.
 *
 * Revision Log
 * ------------
 *
 * $Log: __exit.sml,v $
 * Revision 1.9  1999/05/27 10:17:45  johnh
 * [Bug #190553]
 * Fix require statements to make bootstrap compiler work.
 *
 *  Revision 1.8  1999/04/22  09:44:02  daveb
 *  Removed the equality attribute from the status type; added isSuccess.
 *
 *  Revision 1.7  1999/03/11  15:22:28  daveb
 *  [Bug #190523]
 *  Added fromStatus.
 *
 *  Revision 1.6  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Define exit structure in terms of the pervasive exit structure
 *
 *  Revision 1.5  1998/02/19  16:16:10  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.4  1997/10/08  09:59:48  johnh
 *  [Bug #20101]
 *  Add signature constraint.
 *
 *  Revision 1.3  1997/10/07  14:50:11  johnh
 *  [Bug #30226]
 *  Set a reference  in pervasive to store the exit function to call when
 *  the executable exits normally.
 *
 *  Revision 1.2  1996/05/09  14:58:15  stephenb
 *  Fix the definition of terminate so the C function actually gets called!
 *
 *  Revision 1.1  1996/04/17  15:27:39  stephenb
 *  new unit
 *  Moved from main so that the files can be distributed as part
 *  of the basis.
 *
 *  Revision 1.1  1996/04/17  15:27:39  stephenb
 *  new unit
 *  Provide an OS independent way of terminating MLWorks.
 *
 *
 *)

require "exit";
require "../system/__os_exit";

structure Exit_ : EXIT = OSExit;
