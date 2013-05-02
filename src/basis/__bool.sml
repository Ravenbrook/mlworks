(*  ==== INITIAL BASIS : Bool structure ====
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
 *  Revision Log
 *  ------------
 *  $Log: __bool.sml,v $
 *  Revision 1.6  1999/02/17 14:31:13  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.5  1997/05/27  14:24:54  matthew
 *  Adding datatypes
 *
 *  Revision 1.4  1996/10/03  14:45:53  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.3  1996/06/04  18:22:10  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.2  1996/05/07  11:55:49  io
 *  remove potential circularity conflict
 *
 *  Revision 1.1  1996/05/02  19:27:15  io
 *  new unit
 *
 *)
require "bool";
require "__pre_string_cvt";
require "__char";

structure Bool : BOOL = 
  struct
    datatype bool = datatype bool
    fun not false = true
      | not true = false
    fun toString true = "true"
      | toString false = "false"
    fun scan getc cs = 
      let val cs = PreStringCvt.skipWS getc cs
      in
        case getc cs of
          SOME (c, cs) =>
            (case Char.toLower c of
               #"t" =>
               (case PreStringCvt.splitlNC 3 (Char.contains "rueRUE") (Char.toLower) getc cs  of
                  ([#"r", #"u", #"e"], cs) => SOME (true, cs)
                | (_, _) => NONE)
             | #"f" =>
               (case PreStringCvt.splitlNC 4 (Char.contains "alseALSE") (Char.toLower) getc cs of
                  ([#"a", #"l", #"s", #"e"], cs) => SOME (false, cs)
                  | (_, _) => NONE)
             | _ => NONE)
        | NONE => NONE
      end
    fun fromString "" = NONE
      | fromString s = PreStringCvt.scanString scan s
  end
