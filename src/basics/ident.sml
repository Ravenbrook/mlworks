(* ident.sml the signature *)
(*
$Log: ident.sml,v $
Revision 1.17  1996/10/04 13:15:29  matthew
[Bug #1636]
Removing IDENTCLASS

 * Revision 1.16  1995/09/08  17:42:00  daveb
 * Added realint_tyvar for abs and ~; removed real_tyvar and int_tyvar.
 *
Revision 1.15  1995/07/27  16:25:00  jont
Add tyvars for dealing with overloading on ints and words

Revision 1.14  1995/07/24  15:51:48  jont
Add WORD SCon

Revision 1.13  1995/07/19  15:17:53  jont
Remove scon_eqrep from interface

Revision 1.12  1995/07/19  09:42:11  jont
Add special constant char type

Revision 1.11  1995/07/13  11:35:10  matthew
Moving Compiler.identifier type to Ident

Revision 1.10  1994/05/04  12:29:40  daveb
Added tyvars for new overloading scheme.

Revision 1.9  1993/12/03  11:39:48  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.8  1992/12/17  16:33:29  matthew
Changed int and real scons to carry a location around

Revision 1.7  1992/09/15  17:09:40  jont
Added strict less than functions for all the symbol types

Revision 1.6  1992/02/27  17:27:20  jont
Added equality functions for all symbol based objects

Revision 1.5  1991/11/21  15:58:49  jont
Added copyright message

Revision 1.4  91/11/19  12:16:18  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.3.1.1  91/11/19  11:06:04  jont
Added comments for DRA on functions

Revision 1.3  91/07/24  12:16:49  davida
Added equality of representation test on SCons

Revision 1.2  91/07/16  15:48:43  colin
Added function valid_eq which compares valids by symbol name only

Revision 1.1  91/06/07  10:56:14  colin
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

(*

This module defines types for each class of identifier in SML (see
chapters 2 and 3 of the Definition). `Var', `Con', and `Excon' are
treated as subtypes (value constructors) of a `ValId' type, which
makes the type of a VarEnv much simpler.

Each type is simply an encapsulation of a Symbol (see
basics/symbol.sml), with the exception of TyVars, which also have
imperative and equality attributes (which could be determined from the
symbol name, but which are required so often that it is much cheaper
to evaluate them when the symbol is read and keep them separateyl).

Each type is provided with an ordering function (which is simply
symbol-order).

ValId's also have an equality function valid_eq, which tests equality
of the symbol names only. This is used in ValEnv's, when one must keep
only the most recently bound identifier class for any symbol.

Also defined here is the notion of a Path, which is essentially a
symbol list used to locate objects within structures, and a few
functions to manipulate them.

Finally, the values ref_valid and eq_valid are the ValId's for "ref"
and "=" respectively.

*)

require "symbol";
require "location";

signature IDENT =
  sig
    structure Symbol : SYMBOL
    structure Location : LOCATION

    (* first we have the identifiers in the core language *)
          
    datatype ValId =
      VAR of Symbol.Symbol
    | CON of Symbol.Symbol
    | EXCON of Symbol.Symbol
    | TYCON' of Symbol.Symbol

    val valid_eq : ValId * ValId -> bool
    val valid_order : ValId * ValId -> bool
    val valid_lt : ValId * ValId -> bool

    (* the two bools are for equality and imperative attributes *)

    datatype TyVar = TYVAR of Symbol.Symbol * bool * bool

    val tyvar_eq : TyVar * TyVar -> bool
    val tyvar_order : TyVar * TyVar -> bool
    val tyvar_lt : TyVar * TyVar -> bool

    val int_literal_tyvar : TyVar
    val real_literal_tyvar : TyVar
    val word_literal_tyvar : TyVar
    val real_tyvar : TyVar
    val wordint_tyvar : TyVar
    val realint_tyvar : TyVar
    val num_tyvar : TyVar
    val numtext_tyvar : TyVar

    datatype TyCon = TYCON of Symbol.Symbol    
    datatype Lab = LAB of Symbol.Symbol    
    datatype StrId = STRID of Symbol.Symbol    

    val tycon_eq : TyCon * TyCon -> bool
    val tycon_order : TyCon * TyCon -> bool 
    val tycon_lt : TyCon * TyCon -> bool 
    val lab_eq : Lab * Lab -> bool
    val lab_order : Lab * Lab -> bool
    val lab_lt : Lab * Lab -> bool
    val strid_eq : StrId * StrId -> bool
    val strid_order : StrId * StrId -> bool
    val strid_lt : StrId * StrId -> bool

    (* and then for modules *)

    datatype SigId = SIGID of Symbol.Symbol
    datatype FunId = FUNID of Symbol.Symbol

    val sigid_eq : SigId * SigId -> bool
    val sigid_order : SigId * SigId -> bool
    val sigid_lt : SigId * SigId -> bool
    val funid_eq : FunId * FunId -> bool
    val funid_order : FunId * FunId -> bool
    val funid_lt : FunId * FunId -> bool

    (* for long identifiers *)

    (* we define Path as a concrete datatype so as to have a constructor for
       an empty path which is useful for pattern matching against. This
       constructor should be only used for this purpose - in all other cases
       the functions followPath and followPath' should be used rather than
       explicitly destructuring the paths *)

    datatype Path = NOPATH | PATH of Symbol.Symbol * Path

    val followPath : (StrId * 'a -> 'a) -> Path * 'a -> 'a
    val followPath' : 
      ((StrId * 'a -> 'b) * (StrId * 'b -> 'b)) -> Path * 'a -> 'b
    val mkPath : Symbol.Symbol list -> Path
    val isemptyPath : Path -> bool

    datatype LongValId = LONGVALID of Path * ValId
    datatype LongTyCon = LONGTYCON of Path * TyCon
    datatype LongStrId = LONGSTRID of Path * StrId

    (* special constants form a pseudo identifier class as they also appear in
       the abstract syntax tree in the same way that real identifiers do *)

    datatype SCon = INT of (string * Location.T) | REAL of (string * Location.T) | STRING of string | CHAR of string | WORD of (string * Location.T)

    val ref_valid : ValId
    val eq_valid  : ValId

    datatype Identifier =
      VALUE of ValId |
      TYPE of TyCon |
      STRUCTURE of StrId |
      SIGNATURE of SigId |
      FUNCTOR of FunId

    val dummy_identifier: Identifier
    val compare_identifiers : Identifier * Identifier -> bool

  end

