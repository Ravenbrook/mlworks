(*  ==== SMALL INTEGER SETS ====
 *           STRUCTURE
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
 *  $Log: __smallintset.sml,v $
 *  Revision 1.5  1996/11/06 10:53:49  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 * Revision 1.4  1996/04/29  15:09:06  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.3  1993/05/18  14:59:19  jont
 * Revision integer parameter
 *
 *  Revision 1.2  1992/06/09  09:36:47  richard
 *  Removed Bit and Array parameters.
 *
 *)


require "../basis/__int";

require "__text";
require "__crash";
require "__lists";
require "_smallintset";


structure SmallIntSet_ = 
  SmallIntSet (structure Text = Text_
               structure Crash = Crash_
               structure Lists = Lists_
               val width = 16
               val lg_width = 4
               fun int_to_text int =
                 Text.from_string (Int.toString int))
