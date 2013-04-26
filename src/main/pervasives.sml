(* pervasives.sml the signature *)
(*
$Log: pervasives.sml,v $
Revision 1.40  1996/12/17 12:31:26  andreww
[Bug #1818]
adding builtins for floatarrays.

 * Revision 1.39  1996/04/19  10:30:49  matthew
 * Removing some exceptions
 *
 * Revision 1.38  1995/09/12  15:09:53  daveb
 * Added pervasives for Word32, Int32, etc.
 *
Revision 1.37  1995/07/28  14:46:04  jont
Add INTMOD and INTDIV pervasives

Revision 1.36  1995/07/20  15:23:01  jont
Add primitive operations on words

Revision 1.35  1995/07/14  09:34:46  jont
Add ord and chr for char
Also add relationals on char

Revision 1.34  1995/04/28  11:39:46  matthew
Adding CAST and UMAP pervasives

Revision 1.33  1995/02/13  13:11:31  matthew
Adding breakpoint and step builtins

Revision 1.32  1994/11/18  10:43:28  matthew
Adding "unsafe" allocation and update functions

Revision 1.31  1994/10/06  10:14:40  matthew
Added eq function

Revision 1.30  1994/09/09  16:45:55  jont
Remove machine specific functions is_fun and implicit_references

Revision 1.29  1993/07/20  12:32:25  jont
Added unsafeintplus for generating large integers

Revision 1.28  1993/07/07  15:09:21  daveb
Removed EX*VAL values, since we no longer have exception environments.

Revision 1.27  1993/03/23  10:35:40  jont
Added vector primitives

Revision 1.26  1993/03/04  16:54:46  jont
Added builtin string relationals

Revision 1.25  1992/09/24  14:10:38  jont
Removed some redundant items from the signature

Revision 1.24  1992/08/20  18:18:22  richard
Added ByteArray primitives.

Revision 1.23  1992/08/19  12:17:01  richard
Added UNSAFE_UPDATE and UNSAFE_SUB.

Revision 1.22  1992/08/17  13:31:36  jont
Added inline ordof

Revision 1.21  1992/07/07  16:19:22  davida
Added pervasives (list of all constructors) to signature
(was already defined in functor).

Revision 1.20  1992/06/19  15:47:49  jont
Added ML_REQUIRE builtin for interpreter to get builtin library

Revision 1.19  1992/06/18  16:43:37  jont
Added new builtin ML_OFFSET for computing pointers into middles of
letrec code vectors

Revision 1.18  1992/06/15  15:45:46  jont
Added various loading functions for interpreter

Revision 1.17  1992/06/12  19:22:42  jont
Added ident function to alloow type casting required by interpreter

Revision 1.16  1992/05/20  10:21:41  clive
Added arithmetic right shift operator

Revision 1.15  1992/05/13  10:01:56  clive
Added the Bits structure

Revision 1.14  1992/03/03  11:43:29  richard
Updated documentation not corrected by previous modifiers.
Changed `sort' and `de_sort' to mnemonic names.

Revision 1.13  1992/03/02  15:21:24  richard
Added EQFUN.

Revision 1.12  1992/02/11  15:34:06  clive
New pervasive library code

Revision 1.11  1992/01/23  09:29:17  clive
Added the EXSUBSCRIPTVAL and EXSIZEVAL

Revision 1.10  1992/01/16  08:43:17  clive
Added arrays to the initial basis

Revision 1.9  1992/01/10  11:48:49  richard
Added a SUBSTRING pervasive as a temporary measure so that the same code
can be compiled under under both New Jersey and MLWorks.

Revision 1.8  1991/12/18  15:02:21  richard
Separated exception values from exception names.

Revision 1.7  91/11/28  17:08:51  richard
Added several functions concerned with the structure of the
pervasive library module and a function for ordering the pervasives.

Revision 1.6  91/11/15  14:14:23  richard
Added library_name to map pervasives on to their names in the library.

Revision 1.5  91/11/14  16:13:49  jont
Added is_fun to determine if pervasives are functions, and hence can
be eta_abstracted during compilation.

Revision 1.4  91/11/14  14:06:22  richard
Added CALL_C and SYSTEM.

Revision 1.3  91/10/14  16:15:00  jont
Added CALL_C

Revision 1.2  91/09/16  16:33:33  davida
Corrected spelling of UNIQUE (!)

Revision 1.1  91/08/23  10:52:03  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

signature PERVASIVES =
sig

  (* The pervasives.  Note that the exceptions have two pervasives, one for *)
  (* the exception `name' (unique) and the other for the exception value *)
  (* (packet constructor). *)

  datatype pervasive =
    REF |
    EXORD |
    EXCHR |
    EXDIV |
    EXSQRT |
    EXEXP |
    EXLN |
    EXIO |
    EXMATCH |
    EXBIND |
    EXINTERRUPT |
    EXRANGE |
    EXOVERFLOW |
    MAP |
    UMAP |
    REV |
    NOT |
    ABS |
    FLOOR |
    REAL |
    SQRT |
    SIN |
    COS |
    ARCTAN |
    EXP |
    LN |
    SIZE |
    CHR |
    ORD |
    CHARCHR |
    CHARORD |
    ORDOF |
    EXPLODE |
    IMPLODE |
    DEREF |
    FDIV |
    DIV |
    MOD |
    PLUS |
    STAR |
    MINUS |
    HAT |
    AT |
    NE |
    LESS |
    GREATER |
    LESSEQ |
    GREATEREQ |
    BECOMES |
    O |
    UMINUS |
    EQ |
    EQFUN |
    LOAD_STRING |
    REALPLUS |
    INTPLUS |
    UNSAFEINTPLUS |
    UNSAFEINTMINUS |
    REALSTAR |
    INTSTAR |
    REALMINUS |
    INTMINUS |
    REALUMINUS |
    INTUMINUS |
    INTDIV |
    INTMOD |
    INTLESS |
    REALLESS |
    INTGREATER |
    REALGREATER |
    INTLESSEQ |
    REALLESSEQ |
    INTGREATEREQ |
    REALGREATEREQ |
    INTEQ |
    INTNE |
    REALEQ |
    REALNE |
    STRINGEQ |
    STRINGNE |
    STRINGLT |
    STRINGLE |
    STRINGGT |
    STRINGGE |
    CHAREQ |
    CHARNE |
    CHARLT |
    CHARLE |
    CHARGT |
    CHARGE |
    INTABS |
    REALABS |
    CALL_C |
    ARRAY_FN |
    LENGTH |
    SUB |
    UPDATE |
    UNSAFE_SUB |
    UNSAFE_UPDATE |
    BYTEARRAY |
    BYTEARRAY_LENGTH |
    BYTEARRAY_SUB |
    BYTEARRAY_UPDATE |
    BYTEARRAY_UNSAFE_SUB |
    BYTEARRAY_UNSAFE_UPDATE |
    FLOATARRAY |
    FLOATARRAY_LENGTH |
    FLOATARRAY_SUB |
    FLOATARRAY_UPDATE |
    FLOATARRAY_UNSAFE_SUB |
    FLOATARRAY_UNSAFE_UPDATE |
    VECTOR |
    VECTOR_LENGTH |
    VECTOR_SUB |
    EXSIZE |
    EXSUBSCRIPT |
    ANDB |
    LSHIFT |
    NOTB |
    ORB |
    RSHIFT |
    ARSHIFT |
    XORB |
    (* Stuff for words *)
    WORDEQ |
    WORDNE |
    WORDLT |
    WORDLE |
    WORDGT |
    WORDGE |
    WORDPLUS |
    WORDMINUS |
    WORDSTAR |
    WORDDIV |
    WORDMOD |
    WORDORB |
    WORDXORB |
    WORDANDB |
    WORDNOTB |
    WORDLSHIFT |
    WORDRSHIFT |
    WORDARSHIFT |
    INT32EQ |
    INT32NE |
    INT32LESS |
    INT32LESSEQ |
    INT32GREATER |
    INT32GREATEREQ |
    INT32PLUS |
    INT32MINUS |
    INT32STAR |
    INT32DIV |
    INT32MOD |
    INT32UMINUS |
    INT32ABS |
    WORD32EQ |
    WORD32NE |
    WORD32LT |
    WORD32LE |
    WORD32GT |
    WORD32GE |
    WORD32PLUS |
    WORD32MINUS |
    WORD32STAR |
    WORD32DIV |
    WORD32MOD |
    WORD32ORB |
    WORD32XORB |
    WORD32ANDB |
    WORD32NOTB |
    WORD32LSHIFT |
    WORD32RSHIFT |
    WORD32ARSHIFT |
    (* Low level stuff *)
    CAST |
    ALLOC_STRING |
    ALLOC_VECTOR |
    ALLOC_PAIR |
    RECORD_UNSAFE_SUB |
    RECORD_UNSAFE_UPDATE |
    STRING_UNSAFE_SUB |
    STRING_UNSAFE_UPDATE |
    (* Associated with the interpreter only *)
    IDENT_FN |
    ML_OFFSET |
    ENTUPLE |
    ML_CALL |
    ML_REQUIRE |
    LOAD_VAR |
    LOAD_EXN |
    LOAD_STRUCT |
    LOAD_FUNCT |
    GET_IMPLICIT

  val pervasives : pervasive list   (* list of all constructors *)

  val print_pervasive : pervasive -> string

  (* Lists to determine what is actually present as a builtin  *)

  val constructor_name_list     :(pervasive * string) list
  val value_name_list           :(pervasive * string) list
  val exception_name_list       :(pervasive * string) list


  (*  === FIELD NUMBERS WITHIN THE BUILTIN LIBRARY ===
   *
   *  This is a function which maps pervasives on to their positions within
   *  the BuiltinLibrary_ structure, such that a SELECT operation on
   *  BuiltinLibrary_ using the field number gives the pervasive object.
   *  Not all of the pervasives have definitions in the pervasive library,
   *  in particular, the overloaded functions are not represented, but their
   *  non-overloaded counterparts are.
   *)

  val field_number  : pervasive -> int

  val nr_fields	    : int

  (*  === ENCODING, DECODING, AND ORDERING ===
   *
   *  `encode' and `decode' map pervasives uniquely to and from integers
   *  respectively.  `order' provides a fast ordering.
   *)

  val order	: pervasive * pervasive -> bool
  val eq	: pervasive * pervasive -> bool
  val encode	: pervasive -> int
  val decode	: int -> pervasive

end
