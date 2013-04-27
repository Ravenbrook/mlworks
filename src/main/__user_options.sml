(*  User-visible options.
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
 *  $Log: __user_options.sml,v $
 *  Revision 1.6  1996/05/17 12:45:45  daveb
 *  Added Lists parameter.
 *  Removed obsolete Preferences parameter.
 *
 * Revision 1.5  1995/05/25  09:38:38  daveb
 * Removed Info parameter.
 *
 *  Revision 1.4  1994/08/01  08:45:09  daveb
 *  Added Preferences argument.
 *
 *  Revision 1.3  1993/12/01  15:19:23  io
 *  Added Info_
 *
 *  Revision 1.2  1993/03/05  12:01:49  matthew
 *  Structure changes
 *
 * Revision 1.1  1993/02/26  11:21:43  daveb
 * Initial revision
 * 
 *)

require "__options";
require "../utils/__lists";
require "_user_options";

structure UserOptions_ =
  UserOptions
    (structure Options = Options_
     structure Lists = Lists_);
