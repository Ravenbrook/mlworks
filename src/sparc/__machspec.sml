(*   ==== MACHINE SPECIFICATION ====
 *              STRUCTURE
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Revision Log
 *  ------------
 *  $Log: __machspec.sml,v $
 *  Revision 1.10  1997/01/02 15:35:15  matthew
 *  Deleting Lists structure
 *
 * Revision 1.9  1995/12/27  15:54:42  jont
 * Remove __option
 *
Revision 1.8  1994/07/29  15:27:01  matthew
Need Lists structure

Revision 1.7  1993/08/16  09:51:50  daveb
Removed spurious ".sml" from require declarations.

 *  Revision 1.6  1992/11/21  19:36:44  jont
 *  Removed pervasives
 *  
 *  Revision 1.5  1992/09/15  11:04:16  clive
 *  Checked and corrected the specification for the floating point registers
 *  
 *  Revision 1.4  1992/01/03  15:38:30  richard
 *  Added Option module to dependencies.
 *  
 *  Revision 1.3  1991/11/14  16:48:08  jont
 *  Changed require of pervasives.sml to require of __pervasives.sml
 *  
 *  Revision 1.2  91/11/12  16:53:09  jont
 *  Added Pervasives to the parameter list
 *  
 *  Revision 1.1  91/10/07  11:48:14  richard
 *  Initial revision
 *)


require "../utils/__crash";
require "../utils/__set";
require "__machtypes";
require "_machspec";


structure MachSpec_ = MachSpec(
  structure MachTypes = MachTypes_
  structure Set = Set_
  structure Crash = Crash_
)
