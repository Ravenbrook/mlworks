(*  ==== MONOMORPHIC SET ABSTRACT TYPE ====
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
 *  This signature describes monomorphic sets with useful operations thereon.
 *
 *  Revision Log
 *  ------------
 *  $Log: monoset.sml,v $
 *  Revision 1.4  1992/06/04 09:04:15  richard
 *  Added is_empty.
 *
 *  Revision 1.3  1992/05/05  10:14:07  richard
 *  Added `filter'.
 *
 *  Revision 1.2  1992/04/07  09:27:13  richard
 *  Corrected the type for `cardinality'.
 *
 *  Revision 1.1  1992/03/02  12:35:26  richard
 *  Initial revision
 *
 *)


require "text";


signature MONOSET =

  sig

    structure Text	: TEXT

    type T
    type element

    val empty		: T
    val singleton	: element -> T
    val add		: T * element -> T
    val remove		: T * element -> T
    val member		: T * element -> bool
    val is_empty	: T -> bool
    val equal		: T * T -> bool
    val subset		: T * T -> bool
    val intersection	: T * T -> T
    val union		: T * T -> T
    val difference	: T * T -> T
    val cardinality	: T -> int

    val reduce		: ('a * element -> 'a) -> ('a * T) -> 'a
    val iterate		: (element -> unit) -> T -> unit
    val filter		: (element -> bool) -> T -> T

    val to_list		: T -> element list
    val from_list	: element list -> T
    val to_text		: T -> Text.T

  end
