(*  ==== INITIAL BASIS :  GENERAL ====
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
 *  Implementation
 *  --------------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __general.sml,v $
 *  Revision 1.6  1997/03/20 10:30:17  andreww
 *  [Bug #1431]
 *  Removing out of date code comment.
 *
 * Revision 1.5  1996/10/22  10:15:57  andreww
 * [Bug #1682]
 * removed General from MLWorks.General
 * ,
 *
 * Revision 1.4  1996/07/03  11:32:06  andreww
 * Making top-level.
 *
 * Revision 1.3  1996/05/08  14:59:19  jont
 * Update to latest revision
 *
 * Revision 1.2  1996/04/23  13:05:35  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:26:40  jont
 * new unit
 *
 *  Revision 1.2  1995/03/31  13:47:55  brianm
 *  Adding options operators to General ...
 *
 * Revision 1.1  1995/03/16  20:57:36  brianm
 * new unit
 * New file.
 *
 * Revision 1.1  1995/03/08  16:23:04  brianm
 * new unit
 *
 *)
require "general";


(* this structure already exists at toplevel. File kept for compatibility
   with code that was written when it didn't.*)

structure General:GENERAL = General
