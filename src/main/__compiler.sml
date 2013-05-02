(*  ==== COMPILER INTERFACE ====
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
 *  $Log: __compiler.sml,v $
 *  Revision 1.15  1998/01/30 09:43:18  johnh
 *  [Bug #30326]
 *  Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.14  1997/11/13  11:23:46  jont
 * [Bug #30089]
 * Remove unnecessary require of utils/__timer
 *
 * Revision 1.13.2.2  1997/11/20  17:12:12  daveb
 * [Bug #30326]
 *
 * Revision 1.13.2.1  1997/09/11  20:56:34  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.13  1997/05/12  15:59:02  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.12  1995/12/27  15:53:08  jont
 * Remove __option
 *
 *  Revision 1.11  1995/03/24  16:21:46  matthew
 *  Explicit Stamp structure parameter
 *
 *  Revision 1.10  1993/09/07  16:19:23  jont
 *  Added Crash and Io parameters to functor application
 *
 *  Revision 1.9  1993/08/16  10:55:23  daveb
 *  Removed spurious ".sml" from require declaration.
 *
 *  Revision 1.8  1993/08/12  17:00:57  daveb
 *  Removed Io parameter.
 *
 *  Revision 1.7  1993/07/29  14:45:26  nosa
 *  structure Option.
 *
 *  Revision 1.6  1993/05/18  19:03:01  jont
 *  Removed integer parameter
 *
 *  Revision 1.5  1993/02/09  10:06:24  matthew
 *  Added extra typechecker structures.
 *
 *  Revision 1.4  1993/02/04  15:07:22  matthew
 *  Changed functor parameter
 *
 *  Revision 1.3  1993/01/28  15:24:07  jont
 *  Added MachPrint, MirPrint and EnvironPrint structures
 *
 *  Revision 1.2  1992/10/12  15:41:38  richard
 *  Added Pervasives_ parameter.
 *
 *  Revision 1.1  1992/10/06  09:05:09  richard
 *  Initial revision
 *
 *)

require "../utils/__text";
require "../utils/_diagnostic";
require "../parser/__parser";
require "../lambda/__lambda";
require "../lambda/__lambdaoptimiser";
require "../lambda/__lambdamodule";
require "../lambda/__lambdaprint";
require "../lambda/__topdecprint";
require "../mir/__mir_cg";
require "../mir/__miroptimiser";
require "../mir/__mirprint";
require "../machine/__mach_cg";
require "../machine/__machprint";
require "../utils/__lists";
require "../utils/__crash";
require "../lambda/__environ";
require "../lambda/__environprint";
require "../typechecker/__mod_rules";
require "../typechecker/__basis";
require "../typechecker/__stamp";
require "../main/__primitives";
require "../main/__pervasives";
require "../main/__mlworks_io";
require "_compiler";

structure Compiler_ =
  Compiler (structure Parser = Parser_
            structure Lambda = Lambda_
            structure LambdaOptimiser = LambdaOptimiser_
            structure LambdaModule = LambdaModule_
            structure LambdaPrint = LambdaPrint_
            structure Environ = Environ_
            structure EnvironPrint = EnvironPrint_
            structure Mir_Cg = Mir_Cg_
            structure MirOptimiser = MirOptimiser_
            structure MirPrint = MirPrint_
            structure Mach_Cg = Mach_Cg_
            structure MachPrint = MachPrint_
            structure Mod_Rules = Module_rules_
            structure Basis = Basis_
            structure Stamp = Stamp_
            structure Primitives = Primitives_
            structure Pervasives = Pervasives_
	    structure Io = MLWorksIo_
            structure Lists = Lists_
            structure Crash = Crash_
            structure Diagnostic = Diagnostic (structure Text = Text_)
            structure TopdecPrint = TopdecPrint_);
