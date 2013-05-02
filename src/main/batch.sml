(*  ==== TOP LEVEL BATCH COMPILER ====
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
 *
 *  Revision Log
 *  ------------
 *  $Log: batch.sml,v $
 *  Revision 1.6  1999/05/27 10:38:43  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 * Revision 1.5  1999/05/13  09:43:45  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.4  1996/05/08  13:30:54  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.3  1996/04/17  14:24:14  stephenb
 * Change obey signature to return a list of Exit.status instead
 * of a raw int status.
 *
 * Revision 1.2  1993/04/28  10:02:03  richard
 * The batch compiler now returns a status code.
 *
 *  Revision 1.1  1992/09/01  12:23:39  richard
 *  Initial revision
 *
 *)

require "../utils/mlworks_exit";

signature BATCH =
  sig
    structure Exit : MLWORKS_EXIT

    val obey : string list -> Exit.status
  end;
