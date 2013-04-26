(* _pervasives.sml the functor *)
(*
$Log: _pervasives.sml,v $
Revision 1.60  1997/05/19 11:14:56  jont
[Bug #30090]
Translate output std_out to print

 * Revision 1.59  1996/12/17  12:35:56  andreww
 * [Bug #1818]
 * adding builtins for floatarrays.
 *
 * Revision 1.58  1996/11/06  11:28:55  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.57  1996/10/29  16:43:25  io
 * moving String from toplevel
 *
 * Revision 1.56  1996/04/30  17:38:26  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.55  1996/04/29  13:43:13  matthew
 * Integer changes
 *
 * Revision 1.54  1996/04/19  10:50:30  matthew
 * Removing old pervasives
 *
 * Revision 1.53  1996/02/23  16:16:37  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.52  1995/09/12  12:23:13  daveb
 * Added pervasives for Word32, Int32, etc.
 *
Revision 1.51  1995/07/28  16:03:00  jont
Change mod to be int_mod

Revision 1.50  1995/07/20  15:24:53  jont
Add primitive operations on words

Revision 1.49  1995/07/14  09:36:10  jont
Adding new operations on chars

Revision 1.48  1995/05/26  14:27:13  matthew
Commenting out diagnostics

Revision 1.47  1995/04/28  11:42:19  matthew
Adding CAST and UMAP pervasives

Revision 1.46  1995/02/10  15:57:57  matthew
Adding breakpoint and step builtins

Revision 1.45  1994/11/18  11:21:45  matthew
Adding "unsafe" allocation and update functions

Revision 1.44  1994/10/06  10:15:47  matthew
Added eq function

Revision 1.43  1994/09/09  17:34:25  jont
new file

Revision 1.2  1994/02/11  15:57:55  nickh
y
Fix handling of trapping operations.

Revision 1.1  1994/01/17  16:58:32  daveb
Initial revision

Revision 1.42  1993/07/20  12:33:35  jont
Added unsafeintplus for generating large integers

Revision 1.41  1993/07/07  16:30:02  daveb
Removed EX*VAL values, since we no longer have exception environments.

Revision 1.40  1993/05/18  17:00:55  jont
Removed integer parameter

Revision 1.39  1993/03/23  12:57:48  jont
Added vector primitives

Revision 1.38  1993/03/05  11:49:32  jont
Added builtin string relationals

Revision 1.37  1992/10/02  16:24:25  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.36  1992/09/24  12:11:37  jont
Removed some redundant items from the signature

Revision 1.35  1992/08/21  14:44:43  richard
Added bytearray and unsafe update primitives.
NOTE: Bytearray stuff should raise Range exception.

Revision 1.34  1992/08/20  12:44:24  richard
Changed reference to rts/__builtin_library to pervasive directory.

Revision 1.33  1992/08/19  12:14:23  richard
Added UNSAFE_UPDATE and UNSAFE_SUB.

Revision 1.32  1992/08/17  13:34:43  jont
Added inline ordof

Revision 1.31  1992/08/07  16:16:02  davidt
String structure is now pervasive.

Revision 1.30  1992/06/19  15:48:58  jont
Added ML_REQUIRE builtin for interpreter to get builtin library

Revision 1.29  1992/06/18  16:44:53  jont
Added new builtin ML_OFFSET for computing pointers into middles of
letrec code vectors

Revision 1.28  1992/06/15  17:38:15  jont
Added various loading functions for interpreter, and tidied up

Revision 1.27  1992/06/15  11:18:48  clive
Added extra pervasive in is_fun

Revision 1.26  1992/06/12  19:23:24  jont
Added ident function to alloow type casting required by interpreter

Revision 1.25  1992/05/21  19:14:56  jont
Changed arithmetic_rshift to arshift to agree with builtin library

Revision 1.24  1992/05/20  10:29:13  clive
Added arithmetic right shift operator

Revision 1.23  1992/05/18  14:25:24  clive
Tried to neaten

Revision 1.22  1992/05/13  10:49:11  clive
Added the Bits structure

Revision 1.21  1992/03/21  14:02:02  jont
Changed makestring for Integer.makestring

Revision 1.20  1992/03/03  11:46:49  richard
Improved the method of encoding and decoding pervasives to integers.
Updated documentation which was not corrected by other programmers.

Revision 1.19  1992/03/02  17:21:24  richard
Added EQFUN pervasive and made EQ refer to it.

Revision 1.18  1992/02/19  16:59:12  clive
Incorrectly used exsize instead of exsizeval in implicit_references

Revision 1.17  1992/02/12  12:02:58  clive
New pervasive library code

Revision 1.16  1992/01/31  11:33:07  clive
Array problems - the structure was missing

Revision 1.15  1992/01/23  11:02:49  jont
Fixed inexhaustive/redundant match problem

Revision 1.14  1992/01/23  09:28:47  clive
Added the EXSUBSCRIPTVAL and EXSIZEVAL

Revision 1.13  1992/01/16  09:33:45  clive
Added arrays to the initial basis

Revision 1.12  1992/01/10  11:47:58  richard
Added a SUBSTRING pervasive as a temporary measure so that the same code
can be compiled under under both New Jersey and MLWorks.

Revision 1.11  1991/12/20  11:49:28  richard
Changed the implicit references to exception values rather than
exception names.  See corresponding change in _mir_cg.

Revision 1.10  91/12/18  15:11:37  richard
 Separated exception values from exception names.

Revision 1.9  91/12/10  13:57:58  richard
Added the EQ (equal) and NE (not equal) pervasives to the
pervasive library.

Revision 1.8  91/11/28  17:07:08  richard
Reworked those parts of the module concerned with the pervasive library.
This module can now provide the field numbers within the library of the
pervasives directly.  Also implemented an ordering on pervasives and
removed the MAKE_NEW_UNIQUE pervasive.

Revision 1.7  91/11/18  15:25:03  richard
Changed the library name of mod to modulo so that it doesn't
clash with the pervasive name when compiling.  This makes it
easier to define.

Revision 1.6  91/11/15  14:13:23  richard
Added library_name to map pervasives on to their names in the library
module.

Revision 1.5  91/11/14  16:51:53  jont
Added is_fun to determine if pervasives are functions, and hence can
be eta_abstracted during compilation.

Revision 1.4  91/11/14  14:06:54  richard
Added CALL_C and SYSTEM pervasives.

Revision 1.3  91/10/14  16:15:39  jont
Added CALL_C

Revision 1.2  91/09/16  16:57:54  davida
Corrected spelling of UNIQUE (!)

Revision 1.2  91/09/16  16:34:50  davida
Corrected spelling of UNIQUE (!)

Revision 1.1  91/08/23  10:57:13  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "^.basis.__int";
require "../utils/crash";
require "../utils/lists";
require "../utils/map";
require "../utils/diagnostic";
require "../basics/ident";
require "../main/pervasives";

functor Pervasives (
  structure Lists      : LISTS
  structure Map	       : MAP
  structure Ident      : IDENT
  structure Diagnostic : DIAGNOSTIC
  structure Crash      : CRASH
    ) : PERVASIVES =
struct
  structure Symbol = Ident.Symbol
  structure Diagnostic = Diagnostic

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
    EXOVERFLOW |
    EXRANGE |
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
    INTMOD |
    INTDIV |
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
    UNSAFE_SUB |
    UPDATE |
    UNSAFE_UPDATE |
    BYTEARRAY |
    BYTEARRAY_LENGTH |
    BYTEARRAY_SUB |
    BYTEARRAY_UNSAFE_SUB |
    BYTEARRAY_UPDATE |
    BYTEARRAY_UNSAFE_UPDATE |
    FLOATARRAY |
    FLOATARRAY_LENGTH |
    FLOATARRAY_SUB |
    FLOATARRAY_UNSAFE_SUB |
    FLOATARRAY_UPDATE |
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
    INT32PLUS |
    INT32STAR |
    INT32MINUS |
    INT32UMINUS |
    INT32ABS |
    INT32MOD |
    INT32DIV |
    INT32LESS |
    INT32GREATER |
    INT32LESSEQ |
    INT32GREATEREQ |
    INT32EQ |
    INT32NE |
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

  fun print_pervasive REF = "ref"
    | print_pervasive EXORD = "<name of Ord>"
    | print_pervasive EXCHR = "<name of Chr>"
    | print_pervasive EXDIV = "<name of Div>"
    | print_pervasive EXSQRT = "<name of Sqrt>"
    | print_pervasive EXEXP = "<name of Exp>"
    | print_pervasive EXLN = "<name of Ln>"
    | print_pervasive EXIO = "<name of Io>"
    | print_pervasive EXMATCH = "<name of Match>"
    | print_pervasive EXBIND = "<name of Bind>"
    | print_pervasive EXINTERRUPT = "<name of Interrupt>"
    | print_pervasive EXOVERFLOW = "<name of Overflow>"
    | print_pervasive EXRANGE = "<name of Range>"
    | print_pervasive MAP = "map"
    | print_pervasive UMAP = "umap"
    | print_pervasive REV = "rev"
    | print_pervasive NOT = "not"
    | print_pervasive ABS = "abs"
    | print_pervasive FLOOR = "floor"
    | print_pervasive REAL = "real"
    | print_pervasive SQRT = "sqrt"
    | print_pervasive SIN = "sin"
    | print_pervasive COS = "cos"
    | print_pervasive ARCTAN = "arctan"
    | print_pervasive EXP = "exp"
    | print_pervasive LN = "ln"
    | print_pervasive SIZE = "size"
    | print_pervasive CHR = "chr"
    | print_pervasive ORD = "ord"
    | print_pervasive CHARCHR = "char_chr"
    | print_pervasive CHARORD = "char_ord"
    | print_pervasive ORDOF = "ordof"
    | print_pervasive EXPLODE = "explode"
    | print_pervasive IMPLODE = "implode"
    | print_pervasive DEREF = "!"
    | print_pervasive FDIV = "/"
    | print_pervasive DIV = "div"
    | print_pervasive MOD = "mod"
    | print_pervasive PLUS = "+"
    | print_pervasive STAR = "*"
    | print_pervasive MINUS = "-"
    | print_pervasive HAT = "^"
    | print_pervasive AT = "@"
    | print_pervasive NE = "<>"
    | print_pervasive LESS = "<"
    | print_pervasive GREATER = ">"
    | print_pervasive LESSEQ = "<="
    | print_pervasive GREATEREQ = ">="
    | print_pervasive BECOMES = "becomes"
    | print_pervasive O = "o"
    | print_pervasive UMINUS = "~"
    | print_pervasive EQ = "inline_equality"
    | print_pervasive EQFUN = "external_equality"
    | print_pervasive LOAD_STRING = "load_string"
    | print_pervasive REALPLUS = "_real+"
    | print_pervasive INTPLUS = "_int+"
    | print_pervasive UNSAFEINTPLUS = "_unsafeint+"
    | print_pervasive UNSAFEINTMINUS = "_unsafeint-"
    | print_pervasive REALSTAR = "_real*"
    | print_pervasive INTSTAR = "_int*"
    | print_pervasive REALMINUS = "_real-"
    | print_pervasive INTMINUS = "_int-"
    | print_pervasive REALUMINUS = "_real~"
    | print_pervasive INTUMINUS = "_int~"
    | print_pervasive INTDIV = "_intdiv"
    | print_pervasive INTMOD = "_intmod"
    | print_pervasive INTLESS = "_int<"
    | print_pervasive REALLESS = "_real<"
    | print_pervasive INTGREATER = "_int>"
    | print_pervasive REALGREATER = "_real>"
    | print_pervasive INTLESSEQ = "_int<="
    | print_pervasive REALLESSEQ = "_real<="
    | print_pervasive INTGREATEREQ = "_int>="
    | print_pervasive REALGREATEREQ = "_real>="
    | print_pervasive INTEQ = "_int="
    | print_pervasive INTNE = "_int<>"
    | print_pervasive REALEQ = "_real="
    | print_pervasive REALNE = "_real<>"
    | print_pervasive STRINGEQ = "_string="
    | print_pervasive STRINGNE = "_string<>"
    | print_pervasive STRINGLT = "_string<"
    | print_pervasive STRINGLE = "_string<="
    | print_pervasive STRINGGT = "_string>"
    | print_pervasive STRINGGE = "_string>="
    | print_pervasive CHAREQ = "_char="
    | print_pervasive CHARNE = "_char<>"
    | print_pervasive CHARLT = "_char<"
    | print_pervasive CHARLE = "_char<="
    | print_pervasive CHARGT = "_char>"
    | print_pervasive CHARGE = "_char>="
    | print_pervasive INTABS = "_intabs"
    | print_pervasive REALABS = "realabs"
    | print_pervasive CALL_C = "call_c"
    | print_pervasive ARRAY_FN = "array"
    | print_pervasive LENGTH = "length"
    | print_pervasive SUB = "sub"
    | print_pervasive UPDATE = "update"
    | print_pervasive UNSAFE_SUB = "unsafe_sub"
    | print_pervasive UNSAFE_UPDATE = "unsafe_update"
    | print_pervasive BYTEARRAY = "bytearray"
    | print_pervasive BYTEARRAY_LENGTH = "bytearray_length"
    | print_pervasive BYTEARRAY_SUB = "bytearray_sub"
    | print_pervasive BYTEARRAY_UPDATE = "bytearray_update"
    | print_pervasive BYTEARRAY_UNSAFE_SUB = "bytearray_unsafe_sub"
    | print_pervasive BYTEARRAY_UNSAFE_UPDATE = "bytearray_unsafe_update"
    | print_pervasive FLOATARRAY = "floatarray"
    | print_pervasive FLOATARRAY_LENGTH = "floatearray_length"
    | print_pervasive FLOATARRAY_SUB = "floatarray_sub"
    | print_pervasive FLOATARRAY_UPDATE = "floatarray_update"
    | print_pervasive FLOATARRAY_UNSAFE_SUB = "floatarray_unsafe_sub"
    | print_pervasive FLOATARRAY_UNSAFE_UPDATE = "floatarray_unsafe_update"
    | print_pervasive VECTOR = "vector"
    | print_pervasive VECTOR_LENGTH = "vector_length"
    | print_pervasive VECTOR_SUB = "vector_sub"
    | print_pervasive EXSIZE = "<name of Size>"
    | print_pervasive EXSUBSCRIPT = "<name of Subscript>"
    | print_pervasive ANDB = "andb"
    | print_pervasive LSHIFT = "lshift"
    | print_pervasive NOTB = "notb"
    | print_pervasive ORB = "orb"
    | print_pervasive RSHIFT = "rshift"
    | print_pervasive ARSHIFT = "arshift"
    | print_pervasive XORB = "xorb"
    | print_pervasive CAST = "cast"
    | print_pervasive ALLOC_STRING = "alloc_string"
    | print_pervasive ALLOC_VECTOR = "alloc_vector"
    | print_pervasive ALLOC_PAIR = "alloc_pair"
    | print_pervasive RECORD_UNSAFE_SUB = "record_unsafe_sub"
    | print_pervasive RECORD_UNSAFE_UPDATE = "record_unsafe_update"
    | print_pervasive STRING_UNSAFE_SUB = "string_unsafe_sub"
    | print_pervasive STRING_UNSAFE_UPDATE = "string_unsafe_update"
    | print_pervasive IDENT_FN = "make_ml_value"
    | print_pervasive ML_OFFSET = "ml_value_from_offset"
    | print_pervasive ENTUPLE = "make_ml_value_tuple"
    | print_pervasive ML_CALL = "call_ml_value"
    | print_pervasive ML_REQUIRE = "ml_require"
    | print_pervasive LOAD_VAR = "load_var"
    | print_pervasive LOAD_EXN = "load_exn"
    | print_pervasive LOAD_STRUCT = "load_struct"
    | print_pervasive LOAD_FUNCT = "load_funct"
    | print_pervasive GET_IMPLICIT = "get_implicit"
    | print_pervasive WORDEQ = "_word="
    | print_pervasive WORDNE = "_word<>"
    | print_pervasive WORDLT = "_word<"
    | print_pervasive WORDLE = "_word<="
    | print_pervasive WORDGT = "_word>"
    | print_pervasive WORDGE = "_word>="
    | print_pervasive WORDPLUS = "_word+"
    | print_pervasive WORDMINUS = "_word-"
    | print_pervasive WORDSTAR = "_word*"
    | print_pervasive WORDDIV = "_worddiv"
    | print_pervasive WORDMOD = "_wordmod"
    | print_pervasive WORDORB = "word_orb"
    | print_pervasive WORDXORB = "word_xorb"
    | print_pervasive WORDANDB = "word_andb"
    | print_pervasive WORDNOTB = "word_notb"
    | print_pervasive WORDLSHIFT = "word_lshift"
    | print_pervasive WORDRSHIFT = "word_rshift"
    | print_pervasive WORDARSHIFT = "word_arshift"
    | print_pervasive INT32PLUS = "_int32+"
    | print_pervasive INT32STAR = "_int32*"
    | print_pervasive INT32MINUS = "_int32-"
    | print_pervasive INT32UMINUS = "_int32~"
    | print_pervasive INT32ABS = "_int32abs"
    | print_pervasive INT32MOD = "_int32mod"
    | print_pervasive INT32DIV = "_int32div"
    | print_pervasive INT32LESS = "_int32<"
    | print_pervasive INT32GREATER = "_int32>"
    | print_pervasive INT32LESSEQ = "_int32<="
    | print_pervasive INT32GREATEREQ = "_int32>="
    | print_pervasive INT32EQ = "_int32="
    | print_pervasive INT32NE = "_int32<>"
    | print_pervasive WORD32EQ = "_word32="
    | print_pervasive WORD32NE = "_word32<>"
    | print_pervasive WORD32LT = "_word32<"
    | print_pervasive WORD32LE = "_word32<="
    | print_pervasive WORD32GT = "_word32>"
    | print_pervasive WORD32GE = "_word32>="
    | print_pervasive WORD32PLUS = "_word32+"
    | print_pervasive WORD32MINUS = "_word32-"
    | print_pervasive WORD32STAR = "_word32*"
    | print_pervasive WORD32DIV = "_word32div"
    | print_pervasive WORD32MOD = "_word32mod"
    | print_pervasive WORD32ORB = "word32_orb"
    | print_pervasive WORD32XORB = "word32_xorb"
    | print_pervasive WORD32ANDB = "word32_andb"
    | print_pervasive WORD32NOTB = "word32_notb"
    | print_pervasive WORD32LSHIFT = "word32_lshift"
    | print_pervasive WORD32RSHIFT = "word32_rshift"
    | print_pervasive WORD32ARSHIFT = "word32_arshift"

  (*  == Library names ==
   *
   *  List of pairs relating those pervasives in the library to the names
   *  by which they are defined in the BuiltinLibrary_ structure.
   *
   *  IMPORTANT:
   *    1. Any changes to ../pervasive/__builtin_library.sml must be reflected
   *       here.
   *    2. All exceptions must have both a name _and_ a value.
   *)

  val constructor_name_list = [(REF,"ref")]

  val value_name_list =
    [(CALL_C,"call_c"),
     (EQ, "inline_equality"),
     (EQFUN,"external_equality"),
     (NE,"<>"),
     (LENGTH,"length"),
     (SUB,"sub"),
     (UPDATE,"update"),
     (UNSAFE_SUB,"unsafe_sub"),
     (UNSAFE_UPDATE,"unsafe_update"),
     (FLOOR,"floor"),
     (REAL,"real"),
     (FDIV,"/"),
     (LOAD_STRING,"load_string"),
     (AT, "@"),
     (ARCTAN, "arctan"),
     (CHR, "chr"),
     (CHARCHR, "char_chr"),
     (HAT, "^"),
     (COS, "cos"),
     (EXP, "exp"),
     (EXPLODE, "explode"),
     (IMPLODE, "implode"),
     (INTABS, "int_abs"),
     (INTEQ, "int_equal"),
     (INTGREATER, "int_greater"),
     (INTGREATEREQ, "int_greater_or_equal"),
     (INTLESS, "int_less"),
     (INTLESSEQ, "int_less_or_equal"),
     (INTUMINUS, "int_negate"),
     (INTNE, "int_not_equal"),
     (INTMINUS, "int_minus"),
     (INTSTAR, "int_multiply"),
     (INTPLUS, "int_plus"),
     (INTMOD, "int_mod"),
     (INTDIV, "int_div"),
     (UNSAFEINTPLUS, "unsafe_int_plus"),
     (UNSAFEINTMINUS, "unsafe_int_minus"),
     (LN, "ln"),
     (DEREF,"!"),
     (BECOMES,":="),
     (MAP, "map"),
     (UMAP, "umap"),
     (O, "o"),
     (NOT, "not"),
     (ORD, "ord"),
     (CHARORD, "char_ord"),
     (ORDOF, "ordof"),
     (REALABS, "real_abs"),
     (REALEQ, "real_equal"),
     (REALGREATER, "real_greater"),
     (REALGREATEREQ, "real_greater_or_equal"),
     (REALLESS, "real_less"),
     (REALLESSEQ, "real_less_or_equal"),
     (REALUMINUS, "real_negate"),
     (REALNE, "real_not_equal"),
     (REALMINUS, "real_minus"),
     (REALSTAR, "real_multiply"),
     (REALPLUS, "real_plus"),
     (REV, "rev"),
     (SIN, "sin"),
     (SIZE, "size"),
     (SQRT, "sqrt"),
     (STRINGEQ, "string_equal"),
     (STRINGNE, "string_not_equal"),
     (STRINGLT, "string_less"),
     (STRINGLE, "string_less_equal"),
     (STRINGGT, "string_greater"),
     (STRINGGE, "string_greater_equal"),
     (CHAREQ, "char_equal"),
     (CHARNE, "char_not_equal"),
     (CHARLT, "char_less"),
     (CHARLE, "char_less_equal"),
     (CHARGT, "char_greater"),
     (CHARGE, "char_greater_equal"),
     (ARRAY_FN,"array"),
     (BYTEARRAY, "bytearray"),
     (BYTEARRAY_LENGTH, "bytearray_length"),
     (BYTEARRAY_SUB, "bytearray_sub"),
     (BYTEARRAY_UNSAFE_SUB, "bytearray_unsafe_sub"),
     (BYTEARRAY_UPDATE, "bytearray_update"),
     (BYTEARRAY_UNSAFE_UPDATE, "bytearray_unsafe_update"),
     (FLOATARRAY, "floatarray"),
     (FLOATARRAY_LENGTH, "floatarray_length"),
     (FLOATARRAY_SUB, "floatarray_sub"),
     (FLOATARRAY_UNSAFE_SUB, "floatarray_unsafe_sub"),
     (FLOATARRAY_UPDATE, "floatarray_update"),
     (FLOATARRAY_UNSAFE_UPDATE, "floatarray_unsafe_update"),
     (VECTOR, "vector"),
     (VECTOR_LENGTH, "vector_length"),
     (VECTOR_SUB, "vector_sub"),
     (ANDB,"andb"),
     (LSHIFT,"lshift"),
     (NOTB,"notb"),
     (ORB,"orb"),
     (RSHIFT,"rshift"),
     (ARSHIFT,"arshift"),
     (XORB,"xorb"),
     (CAST, "cast"),
     (ALLOC_STRING, "alloc_string"),
     (ALLOC_VECTOR, "alloc_vector"),
     (ALLOC_PAIR, "alloc_pair"),
     (RECORD_UNSAFE_SUB, "record_unsafe_sub"),
     (RECORD_UNSAFE_UPDATE, "record_unsafe_update"),
     (STRING_UNSAFE_SUB, "string_unsafe_sub"),
     (STRING_UNSAFE_UPDATE, "string_unsafe_update"),
     (IDENT_FN, "make_ml_value"),
     (ML_OFFSET, "ml_value_from_offset"),
     (ENTUPLE, "make_ml_value_tuple"),
     (ML_CALL, "call_ml_value"),
     (ML_REQUIRE, "ml_require"),
     (LOAD_VAR, "load_var"),
     (LOAD_EXN, "load_exn"),
     (LOAD_STRUCT, "load_struct"),
     (LOAD_FUNCT, "load_funct"),
     (GET_IMPLICIT,"get_implicit"),
     (WORDEQ, "word_equal"),
     (WORDNE, "word_not_equal"),
     (WORDLT, "word_less"),
     (WORDLE, "word_less_equal"),
     (WORDGT, "word_greater"),
     (WORDGE, "word_greater_equal"),
     (WORDPLUS, "word_plus"),
     (WORDMINUS, "word_minus"),
     (WORDSTAR, "word_star"),
     (WORDDIV, "word_div"),
     (WORDMOD, "word_mod"),
     (WORDORB, "word_orb"),
     (WORDXORB, "word_xorb"),
     (WORDANDB, "word_andb"),
     (WORDNOTB, "word_notb"),
     (WORDLSHIFT, "word_lshift"),
     (WORDRSHIFT, "word_rshift"),
     (WORDARSHIFT, "word_arshift"),
     (INT32PLUS, "int32_plus"),
     (INT32STAR, "int32_multiply"),
     (INT32MINUS, "int32_minus"),
     (INT32UMINUS, "int32_negate"),
     (INT32ABS, "int32_abs"),
     (INT32MOD, "int32_mod"),
     (INT32DIV, "int32_div"),
     (INT32LESS, "int32_less"),
     (INT32GREATER, "int32_greater"),
     (INT32LESSEQ, "int32_less_equal"),
     (INT32GREATEREQ, "int32_greater_equal"),
     (INT32EQ, "int32_equal"),
     (INT32NE, "int32_not_equal"),
     (WORD32EQ, "word32_equal"),
     (WORD32NE, "word32_not_equal"),
     (WORD32LT, "word32_less"),
     (WORD32LE, "word32_less_equal"),
     (WORD32GT, "word32_greater"),
     (WORD32GE, "word32_greater_equal"),
     (WORD32PLUS, "word32_plus"),
     (WORD32MINUS, "word32_minus"),
     (WORD32STAR, "word32_star"),
     (WORD32DIV, "word32_div"),
     (WORD32MOD, "word32_mod"),
     (WORD32ORB, "word32_orb"),
     (WORD32XORB, "word32_xorb"),
     (WORD32ANDB, "word32_andb"),
     (WORD32NOTB, "word32_notb"),
     (WORD32LSHIFT, "word32_lshift"),
     (WORD32RSHIFT, "word32_rshift"),
     (WORD32ARSHIFT, "word32_arshift")]

  val exception_name_list =
    [(EXBIND, "Bind"),
     (EXCHR, "Chr"),
     (EXDIV, "Div"),
     (EXEXP, "Exp"),
     (EXINTERRUPT, "Interrupt"),
     (EXIO, "Io"),
     (EXLN, "Ln"),
     (EXMATCH, "Match"),
     (EXORD, "Ord"),
     (EXSQRT, "Sqrt"),
     (EXSIZE, "Size"),
     (EXSUBSCRIPT, "Subscript"),
     (EXOVERFLOW, "Overflow"),
     (EXRANGE, "Range")]

  val pervasives =
    map (fn (x,y) => x)
    (value_name_list @ exception_name_list @ constructor_name_list)

    val _ =
      map (fn x => ((print_pervasive x) 
                    handle _ => 
                      (print("*** DANGER *** Failed to find a print_pervasive in _pervasives for something\n ");
                       Crash.impossible "_pervasives - failure to print_pervasive for something")))
      pervasives

    (* We use the names for the pervasives in the map, so check that they are all unique *)
    val _ =
      Lists.reducel( fn (y,x) =>
		    let
		      val str = print_pervasive x
		    in
		      if Lists.member(str, y)
			then Crash.impossible("print_pervasive '" ^ str ^
					      "' is not unique")
		      else str::y
		    end)
      ([],pervasives)

  (* Sort the lists of pervasives with names in to the order in which they *)
  (* will be found in the actual PervasiveLibrary_ structure.  This is the *)
  (* same order as is generated by the lambda translator, and is: *)
  (* sorted values & exceptions, sorted structures. *)

    val library_contents =
      let
	fun make_cons (cons, list) =
	  map (fn (pervasive, name) =>
	         (cons (Symbol.find_symbol name), pervasive))
	      list 

	fun make_sorted (list, order) =
	  map #2
	  (Lists.qsort (fn ((id, _), (id', _)) => order (id, id')) list)
      in
	make_sorted
        (make_cons (Ident.VAR, value_name_list) @
         make_cons (Ident.EXCON, exception_name_list),
         Ident.valid_order)
      end

    (*  === FIELD NUMBERS WITHIN THE BUILTIN LIBRARY ===
     *
     *  This is a function which maps pervasives on to their positions within
     *  the BuiltinLibrary_ structure, such that a SELECT operation on
     *  BuiltinLibrary_ using the field number gives the pervasive object.
     *  Not all of the pervasives have definitions in the pervasive library,
     *  in particular, the overloaded functions are not represented, but their
     *  non-overloaded counterparts are.
     *)

    fun field_number pervasive =
      let
	fun find (_, []) =
	  Crash.impossible ("No field number for " ^ print_pervasive pervasive)
	  | find (number, pervasive'::rest) =
	    if pervasive = pervasive' then
	      number
	    else
	      find (number + 1, rest)

	val field = find (0, library_contents)

(*
	val _ = Diagnostic.output 2
	  (fn _ => ["Pervasives: Field number of " ^
		    print_pervasive pervasive ^ " is " ^
		    Int.toString field])
*)
(*
	val _ = Diagnostic.output 3
	  (fn _ =>
	   let
	     fun show (_, []) = []
	       | show (n, pervasive::pervasives) =
		 ("\n  " ^ Int.toString n ^
		  " : " ^ print_pervasive pervasive) ::
		 show (n+1, pervasives)
	   in
	     "Pervasives: library field numbers:" ::
	     (show (0, library_contents))
	   end)
*)
      in
	field
      end

    val nr_fields = length library_contents

  (*  === ENCODING, DECODING, AND ORDERING FUNCTIONS ===
   *
   *  The sort function provides a syntactic sort for a pervasive.  Pattern
   *  matching is used, and is probably the fastest method of mapping a
   *  given constructor onto an integer.  The inverse of the sort is done
   *  using a Map.T.
   *)

  local
    val sort_map = 
      let
        fun number ([],_) = []
          | number (pervasive::rest,num) = (print_pervasive pervasive,num) :: number(rest,num+1)
      in
        Map.from_list
        ((op<):string*string->bool,op =)
        (number (pervasives,1))
      end

    val sort = fn x => Map.apply sort_map (print_pervasive x)
  in
    val encode = sort

    local
      val inverse =
        Map.apply (Map.from_list
                   ( (op<) : int * int -> bool,(op=) : int * int -> bool)
                   (map (fn p => (encode p, p)) pervasives))
    in
      fun decode i =
        inverse i
        handle Map.Undefined =>
          Crash.impossible 
          ("Pervasives: Unable to find inverse of sort function for " ^ Int.toString i)
    end

    fun order (pervasive, pervasive') = (sort pervasive) < (sort pervasive')

    (* Specialized equality *)
    val eq = op= : pervasive * pervasive -> bool
  end

end
