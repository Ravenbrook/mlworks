(*
 * Definition of a loader format
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
 * $Log: code_module.sml,v $
 * Revision 1.3  1997/05/20 16:48:51  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.2  1994/07/19  14:40:53  jont
 * Modifications to include number of callee saves in wordsets
 *
 * Revision 1.1  1994/03/04  17:43:39  jont
 * new file
 *
 *)
 
signature CODE_MODULE =
  sig

  datatype wordset =
    WORD_SET of
    {a_names:string list,
     b:{a_clos:int, b_spills:int, c_saves:int, d_code:string} list,
     c_leafs:bool list,
     d_intercept:int list,
     e_stack_parameters:int list}
  datatype module_element =
    REAL of int * string |
    STRING of int * string |
    MLVALUE of int * MLWorks.Internal.Value.ml_value |
    WORDSET of wordset |
    EXTERNAL of int * string |
    VAR of int * string |
    EXN of int * string |
    STRUCT of int * string |
    FUNCT of int * string

  datatype Module = MODULE of module_element list

  end;
