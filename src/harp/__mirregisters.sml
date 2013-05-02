(*  ==== MIR VIRTUAL REGISTER MODEL ===
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
 *  $Log: __mirregisters.sml,v $
 *  Revision 1.7  1995/03/17 19:56:46  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.6  1992/02/07  11:25:51  richard
 *  Changed Table to BTree to improve performance.
 *
 *  Revision 1.5  1992/01/03  15:54:32  richard
 *  Added Option module to dependencies.
 *
 *  Revision 1.4  1991/11/29  11:57:05  richard
 *  Tidied up documentation.
 *
 *  Revision 1.3  91/10/15  15:04:07  richard
 *  Added Table Lists and Crash to dependencies.
 *  
 *  Revision 1.2  91/10/09  13:49:05  richard
 *  Added MachSpec to arguments
 *  
 *  Revision 1.1  91/09/18  11:58:32  jont
 *  Initial revision
 *)


require "../utils/__lists";
require "../utils/__crash";
require "../machine/__machspec";
require "__mirtypes";
require "_mirregisters";


structure MirRegisters_ = MirRegisters(
  structure MirTypes = MirTypes_
  structure MachSpec = MachSpec_
  structure Lists = Lists_
  structure Crash = Crash_
)
