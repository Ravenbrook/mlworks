(* 
 * Copyright (c) 1999 Harlequin Group plc.  All rights reserved.
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