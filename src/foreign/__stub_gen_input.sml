(* 
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
 * These datatypes describe the input format to the stub generator.
 * 
 * Revision log
 * ------------
 * 
 * $log$
 *
 *)


structure StubGenInput = 
struct

  datatype range = SIGNED | UNSIGNED

  datatype argUse = IN | OUT | IN_OUT

  datatype intType = SHORT | INT | LONG | BITS of int

  datatype ctype = 
      CvoidT
    | CaddrT
    | CcharT of range
    | CintT of range * intType
    | CdoubleT
    | CfloatT
    | CptrT of ctype
    | CstructT of string
    | CunionT of string
    | CarrayT of (int option * ctype)
    | CfunctionT of (cArgType list * cResultType)
    | CconstT of ctype

  and cResultType = 
      Normal of ctype
    | Exception of ctype * string * string

  and cArgType = 
      CptrAT of ctype * argUse
    | CdefaultAT of ctype

  (* Cdecl string is used to generate names in ML stubs *)
  (* CstructD string is used as a placeholder for struct names *)
  datatype cdecl =
      Cdecl of string * ctype
    | CstructD of string * (string * ctype) list
    | CunionD of string * (string * ctype) list
    | CexnD of string
    | MLcoerceD of cdecl * string

end (* struct StubGenInput *)