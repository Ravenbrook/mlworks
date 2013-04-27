(*  ==== INITIAL BASIS : StringCvt ====
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
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __string_cvt.sml,v $
 *  Revision 1.3  1999/02/17 14:41:15  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.2  1996/10/03  14:57:20  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/06/04  15:24:36  io
 *  new unit
 *
 *  Revision 1.6  1996/05/23  12:14:57  io
 *  fix padRight
 *
 *  Revision 1.5  1996/05/15  09:05:14  io
 *  fix dropl
 *
 *  Revision 1.4  1996/05/10  11:31:01  matthew
 *  Fixing some bugs
 *
 *  Revision 1.3  1996/05/07  11:44:15  io
 *  modify to use __pre_char
 *
 *  Revision 1.2  1996/05/02  17:25:55  io
 *  add scanString.
 *
 *  Revision 1.1  1996/04/23  12:25:03  matthew
 *  new unit
 *
 *
 *)
require "string_cvt";
require "__pre_string_cvt";
structure StringCvt : STRING_CVT = PreStringCvt
