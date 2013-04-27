(*  ==== INTEGER SET ABSTRACT TYPE ====
 *              SIGNATURE
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
 *  This signature describes monomorphic sets of integers with useful
 *  operations thereon.  An efficient implementation of integer sets is
 *  posssible because the special properties of integers.
 *
 *  Revision Log
 *  ------------
 *  $Log: intset.sml,v $
 *  Revision 1.6  1996/03/28 10:35:10  matthew
 *  Adding where type clause
 *
 * Revision 1.5  1992/08/04  10:32:50  jont
 * Removed unnecessary require
 *
 *  Revision 1.4  1992/05/18  13:57:54  richard
 *  Used `include' and `sharing' to specialise the MONOSET signature
 *  rather than copy it.
 *
 *  Revision 1.3  1992/05/05  10:14:24  richard
 *  Added `filter'.
 *
 *  Revision 1.2  1992/02/27  17:33:49  richard
 *  Added `equal', `subset', `reduce', and `iterate'.
 *
 *  Revision 1.1  1992/02/21  13:26:35  richard
 *  Initial revision
 *
 *)


require "monoset";

signature INTSET = MONOSET where type element = int
