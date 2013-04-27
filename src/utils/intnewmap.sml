(*  === INTEGER MAP ===
 *           SIGNATURE
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
 *  A map is a general purpose partial function from some domain to some
 *  range, or, if you prefer, a look-up table.  For the sake of efficiency a
 *  complete order must be provided when constructing a map.
 *
 *  Notes
 *  -----
 *  This signature is intended to have more than one implementation, using
 *  association lists, balanced trees, arrays, etc.  I want to keep the
 *  signature simple and self-contained.
 *
 *  $Log: intnewmap.sml,v $
 *  Revision 1.3  1996/03/27 16:44:03  matthew
 *  Updating for new language definition
 *
 * Revision 1.2  1996/02/26  12:47:32  jont
 * mononewmap becomes monomap
 *
 * Revision 1.1  1992/10/29  14:52:19  jont
 * Initial revision
 *
 *)

require "monomap";

signature INTNEWMAP =
  sig
    include MONOMAP
  end
  where type object = int
