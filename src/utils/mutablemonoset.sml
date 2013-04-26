(*  ==== MUTABLE MONOMORPHIC SETS ====
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
 *  This signature is a specialization of the MONOSET signature with
 *  additional functions for mutable sets.
 *
 *  Revision Log
 *  ------------
 *  $Log: mutablemonoset.sml,v $
 *  Revision 1.2  1992/06/03 09:55:28  richard
 *  Added copy'.
 *
 *  Revision 1.1  1992/06/01  09:41:36  richard
 *  Initial revision
 *
 *)


require "monoset";


signature MUTABLEMONOSET =
  sig
    include MONOSET

    (*  === MUTATING OPERATIONS ===
     *
     *  These have the same types as their non-mutating counterparts and
     *  should be used in the same way, except that they MAY corrupt their
     *  first argument of type T.  So, after using `difference (a,b)' do not
     *  use `a' again.  `empty' will not be updated, however.
     *
     *  The copy' function makes a new copy of an object which may be mutated
     *  independently.
     *)

    val add'		: T * element -> T
    val remove'		: T * element -> T
    val intersection'	: T * T -> T
    val union'		: T * T -> T
    val difference'	: T * T -> T
    val filter'		: (element -> bool) -> T -> T

    val copy'		: T -> T
  end
