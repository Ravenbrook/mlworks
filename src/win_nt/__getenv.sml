(*  GETENV FUNCTION - Windows NT VERSION
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
 *  $Log: __getenv.sml,v $
 *  Revision 1.6  1999/02/02 16:02:04  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.5  1998/07/03  12:32:17  mitchell
 * [Bug #30434]
 * Use Windows structure for registry access rather than Win32
 *
 * Revision 1.4  1997/03/31  12:24:14  johnh
 * [Bug #1967]
 * Included OSPath structure.
 *
 * Revision 1.3  1996/01/18  16:27:56  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, parameterise the functor with
 * the Win32 structure.
 *
 * Revision 1.2  1995/01/19  14:10:56  daveb
 * Removed Option parameter.
 *
 * Revision 1.1  1994/12/12  16:16:27  jont
 * new file
 *
 * Revision 1.1  1994/12/09  13:33:56  jont
 * new file
 *
 *)

require "_win_ntgetenv";
require "__windows";
require "__os";

structure Getenv_ = 
  Win_ntGetenv (structure OSPath = OS.Path
		structure Windows = Windows)











