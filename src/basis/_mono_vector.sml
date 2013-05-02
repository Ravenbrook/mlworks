(*  ==== INITIAL BASIS : MONO VECTORS ====
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
 *  The functor MonoVectors is implemented generically using standard
 *  MLWorks vectors.
 *
 *  This is part of the extended Initial Basis.
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: _mono_vector.sml,v $
 *  Revision 1.4  1997/03/03 11:38:44  matthew
 *  Removing eq attribute from elem
 *
 *  Revision 1.3  1996/05/21  11:16:48  matthew
 *  Updating
 *
 *  Revision 1.2  1996/05/17  09:39:07  matthew
 *  Moved Bits to MLWorks.Internal.Bits
 *
 *  Revision 1.1  1996/05/15  13:06:27  jont
 *  new unit
 *
 * Revision 1.2  1996/05/07  12:04:50  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.1  1996/04/18  11:38:12  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  14:58:20  matthew
 *  Changes for language revision
 *
 *  Revision 1.1  1995/03/22  20:23:51  brianm
 *  new unit
 *  New file.
 *
 *
 *)


require "mono_vector";
require "__vector";

functor MonoVector (type elem) : MONO_VECTOR =
   struct
     open Vector
     type elem = elem
     type vector = elem vector
   end

