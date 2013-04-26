(* _ident.sml the functor *)
(*
$Log: _ident.sml,v $
Revision 1.18  1995/09/08 17:42:38  daveb
Added realint_tyvar for abs and ~; removed real_tyvar and int_tyvar.

Revision 1.17  1995/07/27  16:25:22  jont
Add tyvars for dealing with overloading on ints and words

Revision 1.16  1995/07/24  15:52:38  jont
Add WORD SCon

Revision 1.15  1995/07/19  15:56:59  jont
Remove bignum references

Revision 1.14  1995/07/19  09:45:30  jont
Add special constant char type

Revision 1.13  1995/07/17  16:50:54  jont
Modify scon_eqrep function to use bignums where necessary,
and to deal with hex integers

Revision 1.12  1995/07/13  11:33:32  matthew
Moving Compiler.identifier type to Ident

Revision 1.11  1994/05/13  15:17:52  daveb
Distinguished symbols for literal tyvars.

Revision 1.10  1994/05/04  12:30:08  daveb
Added tyvars for new overloading scheme.

Revision 1.9  1993/12/03  13:20:04  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.8  1992/12/17  16:35:12  matthew
Changed int and real scons to carry a location around

Revision 1.7  1992/09/15  17:12:38  jont
Added strict less than functions for all the symbol types

Revision 1.6  1992/08/04  12:02:15  jont
Tidied up functor argument to reducing number of parameters and sharing

Revision 1.5  1992/02/27  17:30:26  jont
Added equality functions for all symbol based objects

Revision 1.4  1991/11/21  15:56:20  jont
Added copyright message

Revision 1.3  91/07/24  12:17:49  davida
Added equality of representation test on SCons

Revision 1.2  91/07/16  15:48:32  colin
Added function valid_eq which compares valids by symbol name only

Revision 1.1  91/06/07  10:55:17  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "symbol";
require "location";
require "ident";

functor Ident (structure Symbol : SYMBOL
               structure Location : LOCATION
                 ) : IDENT =
  struct
    structure Symbol = Symbol
    structure Location = Location

    (* first we have the identifiers in the core language *)
          
    datatype ValId =
      VAR of Symbol.Symbol
    | CON of Symbol.Symbol
    | EXCON of Symbol.Symbol
    | TYCON' of Symbol.Symbol

    val symbol_order = Symbol.symbol_order
    val symbol_lt = Symbol.symbol_lt

    local
      fun get_symbol(VAR s) = s
	| get_symbol(CON s) = s
	| get_symbol(EXCON s) = s
        | get_symbol(TYCON' s) = s
      val eq_symbol = Symbol.eq_symbol
    in
      fun valid_eq (TYCON' v1, TYCON' v2) = eq_symbol(v1, v2)
        | valid_eq (TYCON' _, _) = false
        | valid_eq (_, TYCON' _) = false
        | valid_eq (v1,v2) = eq_symbol(get_symbol v1, get_symbol v2)
      fun valid_order (TYCON' v1, TYCON' v2) = symbol_order(v1, v2)
        | valid_order (TYCON' _, _) = true
        | valid_order (_, TYCON' _) = false
        | valid_order (v1,v2) = symbol_order(get_symbol v1, get_symbol v2)
      fun valid_lt (TYCON' v1, TYCON' v2) = symbol_lt(v1, v2)
        | valid_lt (TYCON' _, _) = true
        | valid_lt (_, TYCON' _) = false
        | valid_lt (v1,v2) = symbol_lt(get_symbol v1, get_symbol v2)
    end

    (* the two bools are for equality and imperative attributes *)

    datatype TyVar = TYVAR of Symbol.Symbol * bool * bool

    fun tyvar_eq(TYVAR(s1,b1,c1),TYVAR(s2,b2,c2)) =
      b1 = b2 andalso c1 = c2 andalso Symbol.eq_symbol(s1,s2)
    fun tyvar_order(TYVAR(s1,_,_),TYVAR(s2,_,_)) = symbol_order(s1,s2)
    fun tyvar_lt(TYVAR(s1,_,_),TYVAR(s2,_,_)) = symbol_lt(s1,s2)

    val int_literal_tyvar =
      TYVAR(Symbol.find_symbol "int literal", true, false)
    val real_literal_tyvar =
      TYVAR(Symbol.find_symbol "real literal", true, false)
    val word_literal_tyvar =
      TYVAR(Symbol.find_symbol "word literal", true, false)
    val real_tyvar = TYVAR(Symbol.find_symbol "real", true, false)
    val wordint_tyvar = TYVAR(Symbol.find_symbol "wordint", true, false)
    val realint_tyvar = TYVAR(Symbol.find_symbol "realint", true, false)
    val num_tyvar = TYVAR(Symbol.find_symbol "num", true, false)
    val numtext_tyvar = TYVAR(Symbol.find_symbol "numtext", true, false)

    datatype TyCon = TYCON of Symbol.Symbol    
    datatype Lab = LAB of Symbol.Symbol    
    datatype StrId = STRID of Symbol.Symbol    

    fun tycon_eq(TYCON(s1),TYCON(s2)) = Symbol.eq_symbol(s1,s2)
    fun tycon_order(TYCON(s1),TYCON(s2)) = symbol_order(s1,s2)
    fun tycon_lt(TYCON(s1),TYCON(s2)) = symbol_lt(s1,s2)
    fun lab_eq(LAB s1,LAB s2) = Symbol.eq_symbol(s1,s2)
    fun lab_order(LAB s1,LAB s2) = symbol_order(s1,s2)
    fun lab_lt(LAB s1,LAB s2) = symbol_lt(s1,s2)
    fun strid_eq(STRID s1,STRID s2) = Symbol.eq_symbol(s1,s2)
    fun strid_order(STRID s1,STRID s2) = symbol_order(s1,s2)
    fun strid_lt(STRID s1,STRID s2) = symbol_lt(s1,s2)
                 
    (* and then for modules *)

    datatype SigId = SIGID of Symbol.Symbol
    datatype FunId = FUNID of Symbol.Symbol
	    
    fun sigid_eq(SIGID s1,SIGID s2) = Symbol.eq_symbol(s1,s2)
    fun sigid_order(SIGID s1,SIGID s2) = symbol_order(s1,s2)
    fun sigid_lt(SIGID s1,SIGID s2) = symbol_lt(s1,s2)
    fun funid_eq(FUNID s1,FUNID s2) = Symbol.eq_symbol(s1,s2)
    fun funid_order(FUNID s1,FUNID s2) = symbol_order(s1,s2)
    fun funid_lt(FUNID s1,FUNID s2) = symbol_lt(s1,s2)

    (* for long identifiers *)

    datatype Path = NOPATH | PATH of Symbol.Symbol * Path

    fun mkPath nil = NOPATH
      | mkPath (sym::syms) = PATH (sym,mkPath syms)

    fun followPath f =
      let
	fun follow (NOPATH,v) = v
	  | follow (PATH (sym,path),v) = follow (path,f (STRID sym, v))
      in
	follow
      end
    
    local 
      exception FollowPath'
    in
      fun followPath' (f,g) =
	let
	  fun follow (NOPATH,v) = v
	    | follow (PATH (sym,path),v) = follow (path,g (STRID sym, v))
	      
	  fun follow' (NOPATH,v) = raise FollowPath'
	    | follow' (PATH (sym,path),v) = follow (path,f (STRID sym, v))
	in
	  follow'
	end
    end
  
    fun isemptyPath NOPATH = true
      | isemptyPath _ = false

    datatype LongValId = LONGVALID of Path * ValId
    datatype LongTyCon = LONGTYCON of Path * TyCon
    datatype LongStrId = LONGSTRID of Path * StrId

    (* special constants form a pseudo identifier class as they also appear in
       the abstract syntax tree in the same way that real identifiers do *)

    datatype SCon = INT of (string * Location.T) | REAL of (string * Location.T) | STRING of string | CHAR of string | WORD of (string * Location.T)

    val ref_valid = CON (Symbol.find_symbol "ref")
    val eq_valid = VAR (Symbol.find_symbol "=")

    datatype Identifier =
      VALUE of ValId |
      TYPE of TyCon |
      STRUCTURE of StrId |
      SIGNATURE of SigId |
      FUNCTOR of FunId

    val dummy_identifier = VALUE (VAR (Symbol.find_symbol "it"))

    fun compare_identifiers (VALUE i, VALUE i') = valid_lt (i, i')
    |   compare_identifiers (VALUE _, _) = true
    |   compare_identifiers (_, VALUE _) = false
    |   compare_identifiers (TYPE i, TYPE i') = tycon_lt (i, i')
    |   compare_identifiers (TYPE _, _) = true
    |   compare_identifiers (_, TYPE _) = false
    |   compare_identifiers (STRUCTURE i, STRUCTURE i') = strid_lt (i, i')
    |   compare_identifiers (STRUCTURE _, _) = true
    |   compare_identifiers (_, STRUCTURE _) = false
    |   compare_identifiers (SIGNATURE i, SIGNATURE i') = sigid_lt (i, i')
    |   compare_identifiers (SIGNATURE _, _) = true
    |   compare_identifiers (FUNCTOR _, SIGNATURE _) = false
    |   compare_identifiers (FUNCTOR i, FUNCTOR i') = funid_lt (i, i')

  end
