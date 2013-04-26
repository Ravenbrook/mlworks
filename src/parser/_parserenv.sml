(* _parserenv.sml the functor *)
(*
$Log: _parserenv.sml,v $
Revision 1.22  1998/02/19 16:34:03  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.21  1997/05/01  13:17:36  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.20  1996/10/25  13:21:55  andreww
 * [Bug #1686]
 * adding type constructor environment to parser env.
 *
 * Revision 1.19  1996/03/19  14:30:10  matthew
 * Adding unique_augment_pE
 *
 * Revision 1.18  1996/02/23  16:55:26  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.17  1995/04/12  13:26:39  matthew
 * Adding exception raising long valid lookup
 *
Revision 1.16  1995/02/06  13:20:58  matthew
Improving lookup error messages

Revision 1.15  1994/10/13  10:26:00  matthew
Added option-returning tryLookupValid

Revision 1.14  1994/10/06  09:35:40  matthew
Remove uses of Map.empty'

Revision 1.13  1993/12/03  12:49:00  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.12  1993/04/26  16:13:54  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.11  1993/02/17  17:38:55  matthew
Changed to generate errors when an unbound signature,structure,functor or constructor
name is used.

Revision 1.10  1992/10/27  18:55:32  jont
Modified to use less than functions for maps

Revision 1.9  1992/08/26  13:02:32  matthew
Changed error parameter to addValid etc.

Revision 1.8  1992/08/18  17:20:27  davidt
Removed Symbol structure from result and changed everything to use NewMap.

Revision 1.7  1992/08/05  16:24:35  jont
Removed some structures and sharing

Revision 1.6  1992/03/30  11:23:32  matthew
Added some more exception handlers

Revision 1.5  1992/02/27  17:34:08  jont
Changed to use equality functions for all maps, and to remove
use of exceptions to detect seen

Revision 1.4  1991/12/17  15:56:57  jont
Added addFixity for updating a fixity env for the benefit of the
encapsulator

Revision 1.3  91/11/21  16:36:37  jont
Added copyright message

Revision 1.2  91/07/11  16:39:33  colin
Made lookupStrId, lookupFunId and lookupSigId return empty environment
if Lookup fails

Revision 1.1  91/06/07  16:18:00  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "parserenv";
require "../utils/lists";
require "../utils/map";
require "../basics/ident";

(* parser environment stuff *)

functor ParserEnv
  (structure Lists : LISTS
   structure Map   : MAP
   structure Ident : IDENT
     ) : PARSERENV =
  struct
    structure Map = Map
    structure Ident = Ident
    structure Symbol = Ident.Symbol

    datatype Fixity = LEFT of int | RIGHT of int | NONFIX

    datatype
      pFE = FE of (Symbol.Symbol,Fixity) Map.map
    and
      pVE = VE of (Symbol.Symbol,Ident.ValId) Map.map
    and 
      pTE = TE of (Ident.TyCon,pVE) Map.map
    and
      pSE = SE of (Ident.StrId,pE) Map.map
    and
      pE = E of (pFE * pVE * pTE * pSE)
      
    datatype
      pF = F of (Ident.FunId,pE) Map.map
    and
      pG = G of (Ident.SigId,pE * Ident.TyCon list) Map.map
      
    datatype pB = B of (pF * pG * pE)

    val empty_pFE = FE(Map.empty (Symbol.symbol_lt,Symbol.eq_symbol))
    val empty_pVE = VE(Map.empty (Symbol.symbol_lt,Symbol.eq_symbol))
    val empty_pTE = TE(Map.empty (Ident.tycon_lt,Ident.tycon_eq))
    val empty_pSE = SE(Map.empty (Ident.strid_lt,Ident.strid_eq))
    val empty_pE  = E(empty_pFE,empty_pVE,empty_pTE,empty_pSE)

      (* the following is the parser type constructor environment
         for the builtin datatypes: bool, list and ref. *)
         
    local
      val true_sym = Symbol.find_symbol "true"
      val false_sym = Symbol.find_symbol "false"
      val bool_sym = Symbol.find_symbol "bool"
      val ref_sym = Symbol.find_symbol "ref"
      val cons_sym = Symbol.find_symbol "::"
      val nil_sym = Symbol.find_symbol "nil"
      val list_sym = Symbol.find_symbol "list"


      val bool_pVE = VE (Map.from_list (Symbol.symbol_lt,Symbol.eq_symbol)
                         [(true_sym,Ident.CON true_sym),
                          (false_sym, Ident.CON false_sym)])
      val ref_pVE = VE (Map.from_list (Symbol.symbol_lt,Symbol.eq_symbol)
                         [(ref_sym,Ident.CON ref_sym)])
      val list_pVE = VE (Map.from_list (Symbol.symbol_lt,Symbol.eq_symbol)
                         [(cons_sym,Ident.CON cons_sym),
                          (nil_sym,Ident.CON nil_sym)])

      val builtins_pTE = TE(Map.from_list (Ident.tycon_lt,Ident.tycon_eq)
                            [(Ident.TYCON bool_sym,bool_pVE),
                             (Ident.TYCON ref_sym, ref_pVE),
                             (Ident.TYCON list_sym, list_pVE)])
    in
      val builtins_pE = E(empty_pFE,empty_pVE,builtins_pTE,empty_pSE)
    end




    fun augment_pE (E(FE fe,VE ve,TE te,SE se),
                    E(FE fe',VE ve',TE te',SE se')) =
      E(FE (Map.union (fe,fe')), VE (Map.union (ve,ve')),
        TE (Map.union (te,te')), SE (Map.union (se,se')))
      
    fun unique_augment_pE ((valid_fn,strid_fn),E(FE fe,VE ve,TE te,SE se), 
                           E(FE fe',VE ve',TE te',SE se')) =
      E(FE (Map.union (fe,fe')), 
        VE (Map.merge (fn (x,a,b) => (ignore(valid_fn a);b))(ve,ve')),
        TE (Map.merge (fn (x,a,b) => b)             (te,te')),
        SE (Map.merge (fn (x,a,b) => (ignore(strid_fn x);b))(se,se')))
      
    val empty_pF = F(Map.empty (Ident.funid_lt,Ident.funid_eq))
    val empty_pG = G(Map.empty (Ident.sigid_lt,Ident.sigid_eq))
    val empty_pB = B (empty_pF,empty_pG,empty_pE)

    fun augment_pF (F map,F map') =
      F (Map.union (map,map'))

    fun augment_pG (G map,G map') =
      G (Map.union (map,map'))

    fun augment_pB (B(F f,G g,pE),B(F f',G g',pE')) =
      B (F (Map.union (f,f')), G (Map.union (g,g')), (augment_pE (pE,pE')))

    fun remove_str (B(f, g, E(fE, vE, tE, SE sE)), strid) =
      B(f, g, E(fE, vE, tE, SE(Map.undefine(sE, strid))))

    fun lookupFixity (sym, E (FE map,_,_,_)) =
      Map.apply_default'(map, NONFIX, sym)
      
    exception Lookup = Map.Undefined

    exception LookupStrId of Symbol.Symbol

    (* This one raises LookupStrId if it can't find a structure Id *)
    fun lookupValId ((syms,sym),pe) =
      let
        fun follow ([],pe) = pe
          | follow (sym ::strids,E(_,_,_,SE map)) =
            case Map.tryApply'(map,Ident.STRID sym) of
              SOME pe' => follow (strids,pe')
            | _ => raise LookupStrId sym
        val (E (_,VE map,_,_)) = follow (syms,pe)
      in
        Map.tryApply'(map, sym)
      end

    fun tryLookupValId ((syms,sym),pe) =
      let
        fun follow ([],pe) = SOME pe
          | follow (sym ::strids,E(_,_,_,SE map)) =
            case Map.tryApply'(map,Ident.STRID sym) of
              SOME pe' => follow (strids,pe')
            | _ => NONE
      in
        case follow (syms,pe) of
          SOME (E (_,VE map,_,_)) => Map.tryApply'(map, sym)
        | _ => NONE
      end

    (* This one raises LookupStrId if it can't find a structure Id *)
    fun lookupTycon (Ident.LONGTYCON(path,tycon),pe) =
      let
        fun follower (strId as Ident.STRID sym,E(_,_,_,SE map)) = 
            case Map.tryApply'(map, strId)
              of SOME pe' => pe'
               | _ => raise LookupStrId sym
        val (E (_,_,TE map,_)) = Ident.followPath follower (path,pe)
      in
        Map.tryApply'(map, tycon)
      end



    fun lookupStrId ((syms,sym),pe) =
      let
        fun aux ([],pe) = pe
          | aux ((s::ss),E (_,_,_,SE map)) =
            (case Map.tryApply' (map,Ident.STRID s) of
               SOME pe => aux (ss,pe)
             | _ => raise LookupStrId s)
      in
        aux (syms@[sym],pe)
      end

    fun lookupFunId (funid, B(F map,_,_)) = 
      Map.apply'(map, funid)

    fun lookupSigId (sigid,B(_,G map,_)) = 
      Map.apply'(map, sigid)

    fun make_pFE (syms, fixity) =
      let
        fun f (res, sym) = Map.define(res, sym, fixity)
      in
        FE (Lists.reducel f (Map.empty (Symbol.symbol_lt,Symbol.eq_symbol), syms))
      end

    exception Seen

    fun addFixity((symbol, fixity), FE map) =
      FE (Map.define(map, symbol, fixity))

    fun addValId (f, valid, VE map) =
      let
	val sym =
	  case valid of
	    Ident.VAR sym => sym
	  | Ident.CON sym => sym 
	  | Ident.EXCON sym => sym
	  | Ident.TYCON' sym => sym
      in
	VE(Map.combine f (map, sym, valid))
      end

    fun addTyCon (f, tycon, ve, TE map) =
	TE(Map.combine f (map, tycon, ve))


    fun addStrId (f, strid, pe, SE map) =
      SE(Map.combine f (map, strid, pe))

    fun addFunId (f, funid, pe, F map) =
      F(Map.combine f (map, funid, pe))

    fun addSigId (f, sigid, pe, tycons, G map) =
      G(Map.combine f (map, sigid, (pe,tycons)))
  end;
