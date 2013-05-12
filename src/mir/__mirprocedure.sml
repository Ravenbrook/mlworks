(*  ==== MIR ANNOTATED PROCEDURE TYPE ====
 *               STRUCTURE
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
 *  $Log: __mirprocedure.sml,v $
 *  Revision 1.7  1995/05/30 11:00:49  matthew
 *  Removing Timer structure
 *
 *  Revision 1.6  1995/03/17  20:05:19  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.5  1993/05/18  14:34:12  jont
 *  Removed Integer parameter
 *
 *  Revision 1.4  1992/06/17  10:42:12  richard
 *  Added Timer structure to parameters.
 *
 *  Revision 1.3  1992/05/26  14:05:01  richard
 *  Added RegisterPack as a parameter to functor.
 *
 *  Revision 1.2  1992/04/27  12:45:55  richard
 *  Added Integer structure.
 *
 *  Revision 1.1  1992/02/20  15:10:50  richard
 *  Initial revision
 *
 *)


require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "__mirprint";
require "__mirtables";
require "__registerpack";
require "_mirprocedure";


structure MirProcedure_ = MirProcedure (
  structure Diagnostic =
    Diagnostic (structure Text = Text_)
  structure MirTables = MirTables_
  structure MirPrint = MirPrint_
  structure Lists = Lists_
  structure Crash = Crash_
  structure RegisterPack = RegisterPack_
)
