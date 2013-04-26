(*  ==== MOTIF LIBRARY INTERFACE ====
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
 *
 *  Revision Log
 *  ------------
 *  $Log: __xm.sml,v $
 *  Revision 1.4  1996/10/30 18:28:04  daveb
 *  Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.3  1996/05/07  16:16:27  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.2  1996/04/18  15:19:18  jont
 * initbasis moves to basis
 *
 * Revision 1.1  1995/05/05  11:40:25  matthew
 * new unit
 * New unit
 *
 *  Revision 1.4  1995/05/05  11:40:25  daveb
 *  Changed require statements to use generic module id syntax.
 *
 *  Revision 1.3  1995/04/20  19:55:37  daveb
 *  Made this depend on basis/__lists.sml instead of utils/__lists.sml.
 *
 *  Revision 1.2  1993/04/05  14:44:55  daveb
 *  Added Lists_ parameter.
 *
 *  Revision 1.1  1993/01/13  14:35:44  richard
 *  Initial revision
 *
 *)

require "^.basis.__list";
require "_xm";

structure Xm = Xm (
  structure List = List
)
