(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
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
 *  This module contains some information necessary to generate MIR code
 *  suitable for the machine code generator.  It specifies which pervasives
 * can be generated as in-line code.
 *
 *  Revision Log
 *  $Log: machperv.sml,v $
 *  Revision 1.3  1997/01/21 11:23:19  matthew
 *  Adding options parameter
 *
 * Revision 1.2  1994/09/09  16:34:54  jont
 * Move in machine specific stuff from _pervasives.sml
 *
Revision 1.1  1993/12/17  12:55:35  io
Initial revision

Revision 1.1  1992/11/21  19:14:43  jont
Initial revision

 *)

require "../main/pervasives";


signature MACHPERV =
  sig
    structure Pervasives : PERVASIVES
    type CompilerOptions
    (*  === MACHINE CAPABILITIES ===  *)

    val is_inline : CompilerOptions * Pervasives.pervasive -> bool

    val is_fun : Pervasives.pervasive -> bool

    val implicit_references : Pervasives.pervasive -> Pervasives.pervasive list

  end
