(*
 * Definition of a loader format
 * Copyright (c) 1994 Harlequin Ltd.
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
