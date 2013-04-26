(*  ==== INITIAL BASIS : structure Char ====
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
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __char.sml,v $
 *  Revision 1.7  1999/02/17 14:31:32  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.6  1996/06/24  10:36:13  io
 *  unconstrain Char so that scanc can be seen by other basis routines
 *
 *  Revision 1.5  1996/06/04  18:54:09  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.4  1996/05/21  22:51:57  io
 *  ** No reason given. **
 *
 *  Revision 1.3  1996/05/18  00:18:34  io
 *  fromCString
 *
 *  Revision 1.2  1996/05/16  14:21:35  io
 *  fix fromString, scan
 *
 *  Revision 1.1  1996/05/15  12:42:49  jont
 *  new unit
 *
 * Revision 1.6  1996/05/15  10:27:38  io
 * further mods to fromString, scan
 *
 * Revision 1.5  1996/05/13  17:56:33  io
 * update toString
 *
 * Revision 1.4  1996/05/13  15:22:22  io
 * complete toString
 *
 * Revision 1.3  1996/05/07  21:04:48  io
 * revising...
 *
 *)
require "char";
require "__pre_char";
structure Char : CHAR = PreChar
