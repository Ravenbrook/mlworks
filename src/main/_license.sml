(* License server implementation.
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
 *
 * $Log: _license.sml,v $
 * Revision 1.18  1999/05/13 09:49:16  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.17  1998/07/14  09:27:54  jkbrook
 *  [Bug #30435]
 *  Remove user-prompting code
 *
 *  Revision 1.16  1998/06/02  13:16:22  jkbrook
 *  [Bug #30411]
 *  Handle free copies of MLWorks
 *
 *  Revision 1.15  1998/03/17  15:43:21  jkbrook
 *  [Bug #50044]
 *  Fix problem with mixed-case licence names
 *
 *  Revision 1.14  1998/03/12  13:56:01  jkbrook
 *  [Bug #50044]
 *  Licence codes should not contain 0 or 1
 *  or lower case letters on input
 *
 *  Revision 1.13  1998/02/05  16:49:59  jont
 *  [Bug #30090]
 *  Replace uses of MLWorks.IO with print and TextIO
 *
 *  Revision 1.12  1997/08/05  18:50:00  jkbrook
 *  [Bug #30223]
 *  Shortening license codes by using base 36 for date elements and
 *  reducing CHECK_CHARS from 10 to 8
 *
 *  Revision 1.11  1997/08/01  16:47:03  jkbrook
 *  [Bug #20072]
 *  Adding edition info (e.g., student, personal) to licensing
 *
 *  Revision 1.10  1997/08/01  14:24:47  jkbrook
 *  [Bug #20073]
 *  Added datatype license_check_result for more flexible reporting
 *  of license-checking/validation results.
 *
 *  Revision 1.9  1997/07/25  15:17:44  johnh
 *  [Bug #30212]
 *  Allow user to type in license when one expires.
 *
 *  Revision 1.8  1997/07/24  16:43:24  jkbrook
 *  [Bug #20077]
 *  Adding an install-by date
 *
 *  Revision 1.7  1997/07/22  16:21:38  jkbrook
 *  [Bug #20077]
 *  License expiry should be to the nearest day
 *
 *  Revision 1.6  1997/07/18  13:27:43  johnh
 *  [Bug #20074]
 *  Improve license dialog - allow user to retry.
 *
 *  Revision 1.5  1997/01/07  14:00:09  jont
 *  [Bug #1884]
 *  Distinguish invalid licenses from expired licenses
 *
 *  Revision 1.4  1996/11/15  16:25:45  daveb
 *  Ensured that the code from promptUser is > 3 chars long before calling
 *  substring.
 *  Also mapped name to lower case before encoding, and stripped leading and
 *  trailing whitespace.
 *
 *  Revision 1.3  1996/11/13  13:59:03  daveb
 *  Made ttyComplain append a newline to the error message, as the literal
 *  no longer ends with a newline <URI://MLWrts/src/OS/Unix/license.c>.
 *
 *  Revision 1.2  1996/11/12  16:11:17  daveb
 *  Added date to the license to be stored.
 *
 *  Revision 1.1  1996/11/11  20:09:40  daveb
 *  new unit
 *  Interface to the licensing code in the runtime.
 *
 *
 *)

require "__os";
require "^.basis.__substring";
require "^.basis.__char";
require "^.basis.__text_io";
require "version";

require "license";

functor License (
  structure Version: VERSION
): LICENSE =
struct
  fun ttyComplain st = SOME true

  (* license_complain returns SOME _ whenever we want to startup a session.
     SOME true  == license is valid -- get edition from license
     SOME false == license is missing (default straight to free version), 
                   or license is corrupt but the user has chosen to start 
                   a free session
     NONE       == license is corrupt and user has chosen to exit
  *)

  fun license complain = SOME true
      
end
