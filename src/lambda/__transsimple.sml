(*
 * $Log: __transsimple.sml,v $
 * Revision 1.7  1997/01/06 16:39:29  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.6  1996/10/22  11:11:09  matthew
 * Adding LambdaSub
 *
 * Revision 1.5  1995/04/27  15:26:23  jont
 * Fix require statements and comments
 *
 * Revision 1.4  1995/01/10  15:21:50  matthew
 * Adding Crash
 *
 * Revision 1.3  1994/10/12  10:59:21  matthew
 * Renamed simpletypes to simplelambdatypes
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

require "../utils/__lists";
require "../utils/__crash";
require "__simpleutils";
require "../main/__pervasives";
require "_transsimple";

structure TransSimple_ =  TransSimple ( structure Lists = Lists_
                                        structure Crash = Crash_
                                        structure SimpleUtils = SimpleUtils_
                                        structure Pervasives = Pervasives_)

