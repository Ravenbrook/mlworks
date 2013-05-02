(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
 *              FUNCTOR
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
 * Revision Log
 * $Log: _machperv.sml,v $
 * Revision 1.21  1997/01/24 11:05:45  matthew
 * Adding version options
 *
 * Revision 1.20  1997/01/20  15:08:30  matthew
 *  Adding inline multiply
 *
 * Revision 1.19  1996/12/19  13:14:40  andreww
 * [Bug #1818]
 * adding FloatArray primitives.
 *
 * Revision 1.18  1996/04/19  15:37:28  matthew
 * New exceptions
 *
 * Revision 1.17  1996/02/09  14:43:52  jont
 * Modify sized integer operations to raise overflow
 *
 * Revision 1.16  1996/01/31  16:40:31  jont
 * Set int32uminus to be inline
 *
 * Revision 1.15  1995/09/12  12:23:30  daveb
 * Added pervasives for Word32, Int32, etc.
 *
 * Revision 1.14  1995/07/28  15:33:00  jont
 * Handle INTMOD and INTDIV
 *
 * Revision 1.13  1995/07/25  14:40:51  jont
 * Add EXOVERFLOW
 *
 * Revision 1.12  1995/07/20  15:25:59  jont
 * Add primitive operations on words
 *
 * Revision 1.11  1995/07/14  09:37:54  jont
 * Add new operations on chars
 *
 * Revision 1.10  1995/04/28  11:48:14  matthew
 * Adding CAST and UMAP primitives
 *
 * Revision 1.9  1995/02/10  15:58:35  matthew
 * Adding GET_IMPLICIT builtin
 *
 * Revision 1.8  1994/11/24  10:24:45  matthew
 * Adding new pervasives
 *
 * Revision 1.7  1994/09/09  16:38:50  jont
 * Move in machine specific stuff from _pervasives.sml
 *
 * Revision 1.6  1993/12/17  15:14:06  io
 * moved machperv to main/
 *
 * Revision 1.5  1993/07/20  12:33:54  jont
 * Added unsafeintplus for generating large integers
 *
 * Revision 1.4  1993/07/07  15:06:15  daveb
 * Removed EX*VAL values, since we no longer have exception environments.
 *
 * Revision 1.3  1993/03/23  10:35:35  jont
 * Added vector primitives
 *
 * Revision 1.2  1993/03/04  17:09:12  jont
 * Added builtin string relationals
 *
 * Revision 1.1  1992/11/21  19:24:41  jont
 * Initial revision
 *
 *)

require "../main/pervasives";
require "../main/options";
require "../main/machperv";

functor MachPerv (
  structure Pervasives	: PERVASIVES
  structure Options : OPTIONS
) : MACHPERV =

struct
  structure Pervasives = Pervasives
  type CompilerOptions = Options.compiler_options

  (*  === MACHINE CAPABILITIES ===  *)

  fun is_inline (Options.COMPILEROPTIONS {sparc_v7,...}, b) =
    let
      val inline_multiply = not sparc_v7
    in
      case b of
        Pervasives.REF =>  true
      | Pervasives.EXORD => false
      | Pervasives.EXCHR => false
      | Pervasives.EXDIV => false
      | Pervasives.EXSQRT => false
      | Pervasives.EXEXP => false
      | Pervasives.EXLN => false
      | Pervasives.EXIO => false
      | Pervasives.EXMATCH => false
      | Pervasives.EXBIND => false
      | Pervasives.EXINTERRUPT => false
      | Pervasives.EXRANGE => false
      | Pervasives.EXOVERFLOW => false
      | Pervasives.MAP => false
      | Pervasives.UMAP => false
      | Pervasives.REV => false
      | Pervasives.NOT => false
      | Pervasives.ABS => true
      | Pervasives.FLOOR => true
      | Pervasives.REAL => true
      | Pervasives.SQRT => true
      | Pervasives.SIN => false
      | Pervasives.COS => false
      | Pervasives.ARCTAN => false
      | Pervasives.EXP => false
      | Pervasives.LN => false
      | Pervasives.SIZE => true
      | Pervasives.CHR => true
      | Pervasives.ORD => true
      | Pervasives.CHARCHR => true
      | Pervasives.CHARORD => true
      | Pervasives.ORDOF => true
      | Pervasives.EXPLODE => false
      | Pervasives.IMPLODE => false
      | Pervasives.DEREF => true
      | Pervasives.FDIV => true
      | Pervasives.DIV => false
      | Pervasives.MOD => false
      | Pervasives.PLUS => false
      | Pervasives.STAR => false
      | Pervasives.MINUS => false
      | Pervasives.HAT => false
      | Pervasives.AT => false
      | Pervasives.NE => false
      | Pervasives.LESS => false
      | Pervasives.GREATER => false
      | Pervasives.LESSEQ => false
      | Pervasives.GREATEREQ => false
      | Pervasives.BECOMES => true
      | Pervasives.O => false
      | Pervasives.UMINUS => false
      | Pervasives.EQ => true
      | Pervasives.EQFUN => false
      | Pervasives.LOAD_STRING => true
      | Pervasives.REALPLUS => true
      | Pervasives.INTPLUS => true
      | Pervasives.UNSAFEINTPLUS => true
      | Pervasives.UNSAFEINTMINUS => true
      | Pervasives.REALSTAR => true
      | Pervasives.INTSTAR => inline_multiply
      | Pervasives.REALMINUS => true
      | Pervasives.INTMINUS => true
      | Pervasives.REALUMINUS => true
      | Pervasives.INTUMINUS => true
      | Pervasives.INTDIV => false
      | Pervasives.INTMOD => false
      | Pervasives.INTLESS => true
      | Pervasives.REALLESS => true
      | Pervasives.INTGREATER => true
      | Pervasives.REALGREATER => true
      | Pervasives.INTLESSEQ => true
      | Pervasives.REALLESSEQ => true
      | Pervasives.INTGREATEREQ => true
      | Pervasives.REALGREATEREQ => true
      | Pervasives.INTEQ => true
      | Pervasives.INTNE => true
      | Pervasives.REALEQ => true
      | Pervasives.REALNE => true
      | Pervasives.STRINGEQ => false
      | Pervasives.STRINGNE => false
      | Pervasives.STRINGLT => false
      | Pervasives.STRINGLE => false
      | Pervasives.STRINGGT => false
      | Pervasives.STRINGGE => false
      | Pervasives.CHAREQ => true
      | Pervasives.CHARNE => true
      | Pervasives.CHARLT => true
      | Pervasives.CHARLE => true
      | Pervasives.CHARGT => true
      | Pervasives.CHARGE => true
      | Pervasives.INTABS => true
      | Pervasives.REALABS => true
      | Pervasives.CALL_C => true
      | Pervasives.ARRAY_FN => true
      | Pervasives.LENGTH => true
      | Pervasives.SUB  => true
      | Pervasives.UPDATE => true
      | Pervasives.UNSAFE_SUB  => true
      | Pervasives.UNSAFE_UPDATE => true
      | Pervasives.BYTEARRAY => true
      | Pervasives.BYTEARRAY_LENGTH => true
      | Pervasives.BYTEARRAY_SUB  => true
      | Pervasives.BYTEARRAY_UPDATE => true
      | Pervasives.BYTEARRAY_UNSAFE_SUB  => true
      | Pervasives.BYTEARRAY_UNSAFE_UPDATE => true
      | Pervasives.FLOATARRAY => true
      | Pervasives.FLOATARRAY_LENGTH => true
      | Pervasives.FLOATARRAY_SUB  => true
      | Pervasives.FLOATARRAY_UPDATE => true
      | Pervasives.FLOATARRAY_UNSAFE_SUB  => true
      | Pervasives.FLOATARRAY_UNSAFE_UPDATE => true
      | Pervasives.VECTOR => false
      | Pervasives.VECTOR_LENGTH => true
      | Pervasives.VECTOR_SUB => true
      | Pervasives.EXSIZE => false
      | Pervasives.EXSUBSCRIPT => false
      | Pervasives.ANDB => true
      | Pervasives.LSHIFT => true
      | Pervasives.NOTB => true
      | Pervasives.ORB => true
      | Pervasives.RSHIFT => true 
      | Pervasives.ARSHIFT => true 
      | Pervasives.XORB => true 
      | Pervasives.IDENT_FN => false
      | Pervasives.ML_OFFSET => true
      | Pervasives.ENTUPLE => false
      | Pervasives.ML_CALL => true
      | Pervasives.ML_REQUIRE => false
      | Pervasives.CAST => true
      | Pervasives.ALLOC_STRING => true
      | Pervasives.ALLOC_VECTOR => true
      | Pervasives.ALLOC_PAIR => true
      | Pervasives.RECORD_UNSAFE_SUB => true
      | Pervasives.RECORD_UNSAFE_UPDATE => true
      | Pervasives.STRING_UNSAFE_SUB => true
      | Pervasives.STRING_UNSAFE_UPDATE => true
      | Pervasives.LOAD_VAR => true
      | Pervasives.LOAD_EXN => true
      | Pervasives.LOAD_STRUCT => true
      | Pervasives.LOAD_FUNCT => true
      | Pervasives.GET_IMPLICIT => true
      | Pervasives.WORDEQ => true
      | Pervasives.WORDNE => true
      | Pervasives.WORDLT => true
      | Pervasives.WORDLE => true
      | Pervasives.WORDGT => true
      | Pervasives.WORDGE => true
      | Pervasives.WORDPLUS => true
      | Pervasives.WORDMINUS => true
      | Pervasives.WORDSTAR => inline_multiply
      | Pervasives.WORDDIV => false
      | Pervasives.WORDMOD => false
      | Pervasives.WORDORB => true
      | Pervasives.WORDXORB => true
      | Pervasives.WORDANDB => true
      | Pervasives.WORDNOTB => true
      | Pervasives.WORDLSHIFT => true
      | Pervasives.WORDRSHIFT => true
      | Pervasives.WORDARSHIFT => true
      | Pervasives.INT32EQ => true
      | Pervasives.INT32NE => true
      | Pervasives.INT32LESS => true
      | Pervasives.INT32LESSEQ => true
      | Pervasives.INT32GREATER => true
      | Pervasives.INT32GREATEREQ => true
      | Pervasives.INT32PLUS => true
      | Pervasives.INT32MINUS => true
      | Pervasives.INT32STAR => inline_multiply
      | Pervasives.INT32DIV => false
      | Pervasives.INT32MOD => false
      | Pervasives.INT32ABS => true
      | Pervasives.INT32UMINUS => true
      | Pervasives.WORD32EQ => true
      | Pervasives.WORD32NE => true
      | Pervasives.WORD32LT => true
      | Pervasives.WORD32LE => true
      | Pervasives.WORD32GT => true
      | Pervasives.WORD32GE => true
      | Pervasives.WORD32PLUS => true
      | Pervasives.WORD32MINUS => true
      | Pervasives.WORD32STAR => inline_multiply
      | Pervasives.WORD32DIV => false
      | Pervasives.WORD32MOD => false
      | Pervasives.WORD32ORB => true
      | Pervasives.WORD32XORB => true
      | Pervasives.WORD32ANDB => true
      | Pervasives.WORD32NOTB => true
      | Pervasives.WORD32LSHIFT => true
      | Pervasives.WORD32RSHIFT => true
      | Pervasives.WORD32ARSHIFT => true
    end

  (*  === EXTRACT IMPLICIT REFERENCES OF PERVASIVE ===
   *
   *  Maps a pervasive onto the list of pervasives it references implicitly
   *  (such as exceptions).
   *
   *  NOTE: At the moment the contents of the list must match what Mir_Cg
   *  expects.
   *
   *  This is the machine-specific bit of this file.
   *)

  (* The MIR uses this to determine when to generate
   * exception-handling code, as well as what information to keep in
   * closures. *)

  fun implicit_references Pervasives.INTPLUS          = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INTSTAR          = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INTMINUS         = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INTUMINUS        = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INTABS           = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INT32PLUS        = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INT32STAR        = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INT32MINUS       = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INT32UMINUS      = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.INT32ABS         = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.DIV              = [Pervasives.EXOVERFLOW,Pervasives.EXDIV]
    | implicit_references Pervasives.INTDIV           = [Pervasives.EXOVERFLOW,Pervasives.EXDIV]
    | implicit_references Pervasives.INT32DIV         = [Pervasives.EXOVERFLOW,Pervasives.EXDIV]
    | implicit_references Pervasives.WORDDIV          = [Pervasives.EXDIV]
    | implicit_references Pervasives.WORD32DIV        = [Pervasives.EXDIV]
    | implicit_references Pervasives.REALPLUS         = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.REALSTAR         = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.REALMINUS        = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.REALUMINUS       = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.REALABS          = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.FDIV             = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.MOD              = [Pervasives.EXDIV]
    | implicit_references Pervasives.INTMOD           = [Pervasives.EXDIV]
    | implicit_references Pervasives.INT32MOD         = [Pervasives.EXDIV]
    | implicit_references Pervasives.WORDMOD          = [Pervasives.EXDIV]
    | implicit_references Pervasives.WORD32MOD        = [Pervasives.EXDIV]
    | implicit_references Pervasives.FLOOR            = [Pervasives.EXOVERFLOW]
    | implicit_references Pervasives.SQRT             = [Pervasives.EXSQRT]
    | implicit_references Pervasives.EXP              = [Pervasives.EXEXP]
    | implicit_references Pervasives.LN               = [Pervasives.EXLN]
    | implicit_references Pervasives.ORD              = [Pervasives.EXORD]
    | implicit_references Pervasives.ORDOF            = [Pervasives.EXORD]
    | implicit_references Pervasives.CHR              = [Pervasives.EXCHR]
    | implicit_references Pervasives.CHARCHR          = [Pervasives.EXCHR]
    | implicit_references Pervasives.ARRAY_FN         = [Pervasives.EXSIZE]
    | implicit_references Pervasives.SUB              = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.UPDATE           = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.BYTEARRAY        = [Pervasives.EXSIZE]
    | implicit_references Pervasives.BYTEARRAY_SUB    = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.BYTEARRAY_UPDATE = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.FLOATARRAY        = [Pervasives.EXSIZE]
    | implicit_references Pervasives.FLOATARRAY_SUB    = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.FLOATARRAY_UPDATE = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.VECTOR_SUB       = [Pervasives.EXSUBSCRIPT]
    | implicit_references Pervasives.EQ	              = [Pervasives.EQFUN]
    | implicit_references _	                      = []
    
  fun is_fun Pervasives.REF = true
    | is_fun Pervasives.EXORD = false
    | is_fun Pervasives.EXCHR = false
    | is_fun Pervasives.EXDIV = false
    | is_fun Pervasives.EXSQRT = false
    | is_fun Pervasives.EXEXP = false
    | is_fun Pervasives.EXLN = false
    | is_fun Pervasives.EXIO = false
    | is_fun Pervasives.EXMATCH = false
    | is_fun Pervasives.EXBIND = false
    | is_fun Pervasives.EXINTERRUPT = false
    | is_fun Pervasives.EXRANGE = false
    | is_fun Pervasives.EXOVERFLOW = false
    | is_fun Pervasives.MAP = true
    | is_fun Pervasives.UMAP = true
    | is_fun Pervasives.REV = true
    | is_fun Pervasives.NOT = true
    | is_fun Pervasives.ABS = true
    | is_fun Pervasives.FLOOR = true
    | is_fun Pervasives.REAL = true
    | is_fun Pervasives.SQRT = true
    | is_fun Pervasives.SIN = true
    | is_fun Pervasives.COS = true
    | is_fun Pervasives.ARCTAN = true
    | is_fun Pervasives.EXP = true
    | is_fun Pervasives.LN = true
    | is_fun Pervasives.SIZE = true
    | is_fun Pervasives.CHR = true
    | is_fun Pervasives.ORD = true
    | is_fun Pervasives.CHARCHR = true
    | is_fun Pervasives.CHARORD = true
    | is_fun Pervasives.ORDOF = true
    | is_fun Pervasives.EXPLODE = true
    | is_fun Pervasives.IMPLODE = true
    | is_fun Pervasives.DEREF = true
    | is_fun Pervasives.FDIV = true
    | is_fun Pervasives.DIV = true
    | is_fun Pervasives.MOD = true
    | is_fun Pervasives.INTMOD = true
    | is_fun Pervasives.INTDIV = true
    | is_fun Pervasives.PLUS = false
    | is_fun Pervasives.STAR = false
    | is_fun Pervasives.MINUS = false
    | is_fun Pervasives.HAT = true
    | is_fun Pervasives.AT = true
    | is_fun Pervasives.NE = true
    | is_fun Pervasives.LESS = false
    | is_fun Pervasives.GREATER = false
    | is_fun Pervasives.LESSEQ = false
    | is_fun Pervasives.GREATEREQ = false
    | is_fun Pervasives.BECOMES = true
    | is_fun Pervasives.O = true
    | is_fun Pervasives.UMINUS = false
    | is_fun Pervasives.EQ = true
    | is_fun Pervasives.EQFUN = true
    | is_fun Pervasives.LOAD_STRING = false
    | is_fun Pervasives.REALPLUS = true
    | is_fun Pervasives.INTPLUS = true
    | is_fun Pervasives.UNSAFEINTPLUS = true
    | is_fun Pervasives.UNSAFEINTMINUS = true
    | is_fun Pervasives.REALSTAR = true
    | is_fun Pervasives.INTSTAR = true
    | is_fun Pervasives.REALMINUS = true
    | is_fun Pervasives.INTMINUS = true
    | is_fun Pervasives.REALUMINUS = true
    | is_fun Pervasives.INTUMINUS = true
    | is_fun Pervasives.INTLESS = true
    | is_fun Pervasives.REALLESS = true
    | is_fun Pervasives.INTGREATER = true
    | is_fun Pervasives.REALGREATER = true
    | is_fun Pervasives.INTLESSEQ = true
    | is_fun Pervasives.REALLESSEQ = true
    | is_fun Pervasives.INTGREATEREQ = true
    | is_fun Pervasives.REALGREATEREQ = true
    | is_fun Pervasives.INTEQ = true
    | is_fun Pervasives.INTNE = true
    | is_fun Pervasives.REALEQ = true
    | is_fun Pervasives.REALNE = true
    | is_fun Pervasives.STRINGEQ = true
    | is_fun Pervasives.STRINGNE = true
    | is_fun Pervasives.STRINGLT = true
    | is_fun Pervasives.STRINGLE = true
    | is_fun Pervasives.STRINGGT = true
    | is_fun Pervasives.STRINGGE = true
    | is_fun Pervasives.CHAREQ = true
    | is_fun Pervasives.CHARNE = true
    | is_fun Pervasives.CHARLT = true
    | is_fun Pervasives.CHARLE = true
    | is_fun Pervasives.CHARGT = true
    | is_fun Pervasives.CHARGE = true
    | is_fun Pervasives.INTABS = true
    | is_fun Pervasives.REALABS = true
    | is_fun Pervasives.CALL_C = true
    | is_fun Pervasives.ARRAY_FN = true
    | is_fun Pervasives.LENGTH = true
    | is_fun Pervasives.SUB = true
    | is_fun Pervasives.UPDATE =true
    | is_fun Pervasives.UNSAFE_SUB = true
    | is_fun Pervasives.UNSAFE_UPDATE =true
    | is_fun Pervasives.BYTEARRAY = true
    | is_fun Pervasives.BYTEARRAY_LENGTH = true
    | is_fun Pervasives.BYTEARRAY_SUB = true
    | is_fun Pervasives.BYTEARRAY_UPDATE =true
    | is_fun Pervasives.BYTEARRAY_UNSAFE_SUB = true
    | is_fun Pervasives.BYTEARRAY_UNSAFE_UPDATE = true
    | is_fun Pervasives.FLOATARRAY = true
    | is_fun Pervasives.FLOATARRAY_LENGTH = true
    | is_fun Pervasives.FLOATARRAY_SUB = true
    | is_fun Pervasives.FLOATARRAY_UPDATE =true
    | is_fun Pervasives.FLOATARRAY_UNSAFE_SUB = true
    | is_fun Pervasives.FLOATARRAY_UNSAFE_UPDATE = true
    | is_fun Pervasives.VECTOR = true
    | is_fun Pervasives.VECTOR_LENGTH = true
    | is_fun Pervasives.VECTOR_SUB = true
    | is_fun Pervasives.EXSIZE = false
    | is_fun Pervasives.EXSUBSCRIPT =false
    | is_fun Pervasives.ANDB = true
    | is_fun Pervasives.LSHIFT = true
    | is_fun Pervasives.NOTB = true
    | is_fun Pervasives.ORB = true
    | is_fun Pervasives.RSHIFT = true
    | is_fun Pervasives.ARSHIFT = true
    | is_fun Pervasives.XORB = true
    | is_fun Pervasives.CAST = true
    | is_fun Pervasives.ALLOC_STRING = true
    | is_fun Pervasives.ALLOC_VECTOR = true
    | is_fun Pervasives.ALLOC_PAIR = true
    | is_fun Pervasives.RECORD_UNSAFE_SUB = true
    | is_fun Pervasives.RECORD_UNSAFE_UPDATE = true
    | is_fun Pervasives.STRING_UNSAFE_SUB = true
    | is_fun Pervasives.STRING_UNSAFE_UPDATE = true
    | is_fun Pervasives.WORDEQ = true
    | is_fun Pervasives.WORDNE = true
    | is_fun Pervasives.WORDLT = true
    | is_fun Pervasives.WORDLE = true
    | is_fun Pervasives.WORDGT = true
    | is_fun Pervasives.WORDGE = true
    | is_fun Pervasives.WORDPLUS = true
    | is_fun Pervasives.WORDMINUS = true
    | is_fun Pervasives.WORDSTAR = true
    | is_fun Pervasives.WORDDIV = true
    | is_fun Pervasives.WORDMOD = true
    | is_fun Pervasives.WORDORB = true
    | is_fun Pervasives.WORDXORB = true
    | is_fun Pervasives.WORDANDB = true
    | is_fun Pervasives.WORDNOTB = true
    | is_fun Pervasives.WORDLSHIFT = true
    | is_fun Pervasives.WORDRSHIFT = true
    | is_fun Pervasives.WORDARSHIFT = true
    | is_fun Pervasives.INT32EQ = true
    | is_fun Pervasives.INT32NE = true
    | is_fun Pervasives.INT32LESS = true
    | is_fun Pervasives.INT32LESSEQ = true
    | is_fun Pervasives.INT32GREATER = true
    | is_fun Pervasives.INT32GREATEREQ = true
    | is_fun Pervasives.INT32PLUS = true
    | is_fun Pervasives.INT32MINUS = true
    | is_fun Pervasives.INT32STAR = true
    | is_fun Pervasives.INT32DIV = true
    | is_fun Pervasives.INT32MOD = true
    | is_fun Pervasives.INT32UMINUS = true
    | is_fun Pervasives.INT32ABS = true
    | is_fun Pervasives.WORD32EQ = true
    | is_fun Pervasives.WORD32NE = true
    | is_fun Pervasives.WORD32LT = true
    | is_fun Pervasives.WORD32LE = true
    | is_fun Pervasives.WORD32GT = true
    | is_fun Pervasives.WORD32GE = true
    | is_fun Pervasives.WORD32PLUS = true
    | is_fun Pervasives.WORD32MINUS = true
    | is_fun Pervasives.WORD32STAR = true
    | is_fun Pervasives.WORD32DIV = true
    | is_fun Pervasives.WORD32MOD = true
    | is_fun Pervasives.WORD32ORB = true
    | is_fun Pervasives.WORD32XORB = true
    | is_fun Pervasives.WORD32ANDB = true
    | is_fun Pervasives.WORD32NOTB = true
    | is_fun Pervasives.WORD32LSHIFT = true
    | is_fun Pervasives.WORD32RSHIFT = true
    | is_fun Pervasives.WORD32ARSHIFT = true
    (* Associated with the interpreter only *)
    | is_fun Pervasives.IDENT_FN = true
    | is_fun Pervasives.ML_OFFSET = true
    | is_fun Pervasives.ENTUPLE = true
    | is_fun Pervasives.ML_CALL = true
    | is_fun Pervasives.ML_REQUIRE = true
    | is_fun Pervasives.LOAD_VAR = false
    | is_fun Pervasives.LOAD_EXN = false
    | is_fun Pervasives.LOAD_STRUCT = false
    | is_fun Pervasives.LOAD_FUNCT = false
    | is_fun Pervasives.GET_IMPLICIT = true

end
