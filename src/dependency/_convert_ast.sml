(* 
 * This file includes parts which are Copyright (c) 1995 AT&T Bell 
 * Laboratories. All rights reserved.  
 *
 * $Log: _convert_ast.sml,v $
 * Revision 1.3  1999/02/18 15:09:36  mitchell
 * [Bug #190507]
 * Improve handling of top-level opens.
 *
 *  Revision 1.2  1999/02/12  15:42:49  sml
 *  [Bug #190507]
 *  Fix require statements
 *
 *  Revision 1.1  1999/02/12  10:15:51  mitchell
 *  new unit
 *  [Bug #190507]
 *  Adding files to support CM-style dependency analysis
 *
 *)
 
require "../basics/absyn";
require "module_dec";
require "../basis/__list";

functor ConvertAST(  
  structure ModuleDec: MODULE_DEC
  structure Absyn  : ABSYN
  sharing Absyn.Ident = ModuleDec.ModuleName.Ident ) =
struct
  structure ModuleDec = ModuleDec
  structure Absyn   = Absyn
  structure ModuleName = ModuleDec.ModuleName
  structure Ident   = ModuleName.Ident
  structure Symbol  = Ident.Symbol

  open ModuleDec;

  fun strid_to_mn (Ident.STRID sym) =
      ModuleName.structMN(Symbol.symbol_name sym)

  fun sigid_to_mn (Ident.SIGID sym) =
      ModuleName.sigMN(Symbol.symbol_name sym)

  fun funid_to_mn (Ident.FUNID sym) =
      ModuleName.functMN(Symbol.symbol_name sym)

  fun ast_path_to_path (path, suffix) = 
      let fun build (Ident.NOPATH) = suffix
            | build (Ident.PATH(sym, ast_path)) =
               (ModuleName.structMN (Symbol.symbol_name sym)) :: (build (ast_path))
       in ModuleName.pathOfMNList (build path) end

  fun long_str_to_path (Ident.LONGSTRID(ast_path, Ident.STRID sym)) =
      ast_path_to_path(ast_path, [ModuleName.structMN(Symbol.symbol_name sym)])  

  fun long_sig_to_path (Ident.LONGSTRID(ast_path, Ident.STRID sym)) =
      ast_path_to_path(ast_path, [ModuleName.sigMN(Symbol.symbol_name sym)])  

  fun mk_aug_str_exp (AugStrExp(strexp, set1), set2) =
        AugStrExp(strexp, ModuleName.union(set1, set2))
    | mk_aug_str_exp (strexp, set) = AugStrExp(strexp, set)

  fun dec_seq_to_dec (decs: Dec list): Dec =
    let fun merge (DecRef r1 :: DecRef r2 :: rest) =
              merge(DecRef(ModuleName.union(r1,r2)) :: rest)
          | merge ((h as DecRef set) :: rest) = 
              if ModuleName.isEmpty(set) 
              then (merge rest)
              else h :: (merge rest)
          | merge (h :: rest) = h :: (merge rest)
          | merge [] = []
     in case merge decs of
        [] => DecRef(ModuleName.empty)
      | [dec] => dec
      | dl => SeqDec dl
    end

  fun mod_ref_set (mod_names: ModuleName.set, accum: Dec list): Dec list =
    if ModuleName.isEmpty(mod_names) then accum
    else 
      case accum of
        [] => [DecRef mod_names]
      | (DecRef other_refs) :: tail =>
          (DecRef (ModuleName.union(mod_names, other_refs))) :: tail
      | _ => (DecRef mod_names) :: accum

  fun dec_ref (path, accum) =
    case path of
      Ident.NOPATH => accum
    | Ident.PATH (strid,_) =>
        let val mn = ModuleName.structMN(Symbol.symbol_name strid)
         in case accum of
              [] => [DecRef (ModuleName.singleton mn)]
            | (DecRef other_refs) :: tail =>
                (DecRef (ModuleName.add (mn, other_refs))) :: tail
            | _ => (DecRef (ModuleName.singleton mn)) :: accum
        end

  fun mod_ref (path: Ident.Path, set: ModuleName.set) : ModuleName.set =
    case path of
      Ident.NOPATH => set
    | Ident.PATH(h, p) => ModuleName.add (ModuleName.structMN(Symbol.symbol_name h), set)

  fun local_dec(bind: Dec list, body: Dec list, accum: Dec list) : Dec list =
    case (bind, body) of
      ([], []) => accum
    | ([], [DecRef names]) => mod_ref_set(names, accum)
    | ([DecRef names], []) => mod_ref_set(names, accum)
    | ([DecRef names1], [DecRef names2]) => 
        mod_ref_set(ModuleName.union(names1, names2), accum)
    | args => (LocalDec(SeqDec bind, SeqDec body)) :: accum

  fun cvt_exp (ast : Absyn.Exp, accum : Dec list) : Dec list  =
    case ast of
      Absyn.SCONexp _ => accum
    | Absyn.VALexp (Ident.LONGVALID(path, valid), _, _, _) =>
        ( case path of
            Ident.NOPATH => accum
          | Ident.PATH (s, path') => 
              let val mod_name = ModuleName.structMN(Symbol.symbol_name s) 
               in case accum of 
                    [] => [DecRef (ModuleName.singleton mod_name)]
                  | (DecRef other_refs) :: tail =>
                      (DecRef (ModuleName.add(mod_name, other_refs))) :: tail
                  | _ => (DecRef (ModuleName.singleton mod_name)) :: accum
              end )
    | Absyn.RECORDexp arg => List.foldr cvt_exp accum (map #2 arg)
    | Absyn.LOCALexp (dec, exp, _) =>
        local_dec (do_dec(dec, []), cvt_exp(exp, []), accum)
    | Absyn.APPexp(function, argument, _,_,_) =>
        cvt_exp (function, cvt_exp (argument, accum))
    | Absyn.TYPEDexp (exp, constraint, _) =>
        cvt_exp (exp, mod_ref_set (cvt_ty (constraint, ModuleName.empty), accum))
    | Absyn.HANDLEexp (exp, _, rules, _, _) =>
        cvt_exp (exp, List.foldr cvt_rule accum rules)
    | Absyn.RAISEexp (exp, _) => cvt_exp (exp, accum)
    | Absyn.FNexp (rules, _, _, _) => List.foldr cvt_rule accum rules
    | Absyn.DYNAMICexp (exp, _,_) => cvt_exp (exp, accum)
    | Absyn.COERCEexp (exp, constraint, _,_) =>
        cvt_exp (exp, mod_ref_set (cvt_ty (constraint, ModuleName.empty), accum))
    | _ => accum  
    
  and cvt_rule ((pat: Absyn.Pat, exp: Absyn.Exp, _), 
                accum: Dec list): Dec list =
    mod_ref_set (cvt_pat (pat, ModuleName.empty), cvt_exp (exp, accum))

  and cvt_dec (ast: Absyn.Dec): Dec =
    dec_seq_to_dec (do_dec(ast, []))

  and do_dec (ast: Absyn.Dec, accum: Dec list): Dec list =
    case ast of
      Absyn.VALdec (arg1, arg2, _, _) =>
        List.foldr cvt_vb (foldr cvt_vb accum arg1) arg2
    | Absyn.TYPEdec arg => 
        mod_ref_set (List.foldr cvt_tb ModuleName.empty arg, accum)
    | Absyn.DATATYPEdec (_, arg) =>
        mod_ref_set (List.foldr cvt_db ModuleName.empty arg, accum)
    | Absyn.DATATYPErepl (_, (_, Ident.LONGTYCON(path,_)), _) => 
        dec_ref (path,accum)
    | Absyn.ABSTYPEdec (_, arg, body) =>
        mod_ref_set (List.foldr cvt_db ModuleName.empty arg, (cvt_dec body)::accum)
    | Absyn.EXCEPTIONdec arg =>
        mod_ref_set (List.foldr cvt_eb ModuleName.empty arg, accum)
    | Absyn.LOCALdec (binding_dec, body_dec) =>
        local_dec (do_dec (binding_dec, []), 
                   do_dec (body_dec, []), accum)
    | Absyn.OPENdec ([], _) => accum
    | Absyn.OPENdec (arg as (Ident.LONGSTRID(_,Ident.STRID(str)))::t, _) =>
        (OpenDec (map (VarStrExp o long_str_to_path) arg)) :: accum
    | Absyn.SEQUENCEdec arg => List.foldr do_dec accum arg

  and cvt_vb ((pat: Absyn.Pat, exp: Absyn.Exp, _), accum: Dec list) =
    mod_ref_set (cvt_pat (pat, ModuleName.empty), cvt_exp (exp, accum))

  and cvt_tb ((_, _, ty: Absyn.Ty, _), accum: ModuleName.set): ModuleName.set =
    cvt_ty (ty, accum)

  and cvt_tyoption (NONE: Absyn.Ty option, accum: ModuleName.set): ModuleName.set = accum
    | cvt_tyoption (SOME ty, accum) = cvt_ty (ty, accum)

  and cvt_db ((_,_,_,_,tyl), accum: ModuleName.set): ModuleName.set =
     List.foldr cvt_tyoption accum (map #2 tyl) 

  and cvt_eb (ast: Absyn.ExBind, accum: ModuleName.set): ModuleName.set = 
    case ast of
      Absyn.NEWexbind (_, tyoption, _, _) => 
        cvt_tyoption (tyoption, accum)
    | Absyn.OLDexbind (_, Ident.LONGVALID(path,_), _, _) => 
        mod_ref (path, accum)

  and cvt_pat (ast: Absyn.Pat, accum: ModuleName.set): ModuleName.set =
    case ast of
      Absyn.WILDpat _ => accum
    | Absyn.SCONpat _ => accum
    | Absyn.VALpat ((Ident.LONGVALID(path,_), _), _) => mod_ref(path, accum)
    | Absyn.RECORDpat (def, _, _) => List.foldr cvt_pat accum (map #2 def)
    | Absyn.APPpat ((Ident.LONGVALID(path,_),_), arg, _, _) =>
        cvt_pat (arg, mod_ref(path, accum))
    | Absyn.TYPEDpat(pattern, constraint, _) =>
        cvt_pat (pattern, cvt_ty (constraint, accum))
    | Absyn.LAYEREDpat ((_, _), pattern) => cvt_pat (pattern, accum)
    
  and cvt_ty (ast: Absyn.Ty, accum: ModuleName.set): ModuleName.set =
    case ast of
      Absyn.TYVARty _ => accum
    | Absyn.RECORDty arg => List.foldr cvt_ty accum (map #2 arg)
    | Absyn.APPty (args, Ident.LONGTYCON(path,_), _) =>
        mod_ref (path, List.foldr cvt_ty accum args)
    | Absyn.FNty (ty1, ty2) => cvt_ty (ty2, cvt_ty(ty1, accum))


  and cvt_strexp (ast: Absyn.StrExp): StrExp =
    case ast of
      Absyn.NEWstrexp strdec => BaseStrExp(cvt_strdec strdec)
    | Absyn.OLDstrexp (longstrid, _, _) => VarStrExp (long_str_to_path longstrid)
    | Absyn.APPstrexp (funid, strexp, _,_,_) => 
        AppStrExp(funid_to_mn funid, cvt_strexp strexp)
    | Absyn.CONSTRAINTstrexp (strexp, sigexp, _,_,_)  =>
        ConStrExp (cvt_strexp strexp, cvt_sigexp sigexp)
    | Absyn.LOCALstrexp (strdec, strexp) =>
        LetStrExp (cvt_strdec strdec, cvt_strexp strexp) 

  and cvt_strdec (ast: Absyn.StrDec): Dec =
    case ast of
      Absyn.DECstrdec dec => cvt_dec dec
    | Absyn.STRUCTUREstrdec arg => StrDec (List.map cvt_strb arg)
    | Absyn.ABSTRACTIONstrdec arg => StrDec (List.map cvt_strb arg)
    | Absyn.LOCALstrdec (strdec1, strdec2) =>
        ( case cvt_strdec strdec1 of
            decs1 as DecRef set =>
              if ModuleName.isEmpty(set) 
              then cvt_strdec strdec2
              else LocalDec (decs1, cvt_strdec strdec2)
          | decs1 => 
              LocalDec (decs1, cvt_strdec strdec2) )
    | Absyn.SEQUENCEstrdec arg => dec_seq_to_dec (map cvt_strdec arg)

  and cvt_strb (strid: Ident.StrId, optsig, strexp: Absyn.StrExp, _,_,_,_) =
      {name=strid_to_mn strid, 
       def= cvt_strexp strexp, 
       constraint=
         case optsig of
           NONE => NONE
         | SOME (sigexp: Absyn.SigExp,_) => SOME (cvt_sigexp sigexp)}

  and cvt_sigexp (ast: Absyn.SigExp): StrExp =
    case ast of
      Absyn.NEWsigexp (spec, _) => BaseStrExp (dec_seq_to_dec(cvt_spec (spec, [])))
    | Absyn.OLDsigexp (Ident.SIGID s, _, _) => 
        VarStrExp(long_sig_to_path(Ident.LONGSTRID(Ident.NOPATH, Ident.STRID s)))
    | Absyn.WHEREsigexp (sigexp, whspecs) =>
        let fun f ((_, longtycon, ty, _), accum) = cvt_ty (ty, accum)
         in mk_aug_str_exp (cvt_sigexp sigexp, 
                            List.foldr f ModuleName.empty whspecs)
        end

  and cvt_spec (ast: Absyn.Spec, accum: Dec list): Dec list =
    case ast of
      Absyn.VALspec (arg, _) =>
        let val mod'ref'set = List.foldr cvt_ty ModuleName.empty (map #2 arg)
         in mod_ref_set (mod'ref'set, accum)
        end
    | Absyn.TYPEspec _ => accum
    | Absyn.EQTYPEspec _ => accum
    | Absyn.DATATYPEspec specs =>
        let fun cvt ((_, tyopt,_), accum) = cvt_tyoption(tyopt, accum)
            val mod'ref'set =
                  List.foldr (fn (l, acc) => List.foldr cvt acc l) 
                             ModuleName.empty (map #3 specs)
         in mod_ref_set (mod'ref'set, accum)
        end
    | Absyn.DATATYPEreplSpec (_, _, Ident.LONGTYCON(path, _), _) => 
        dec_ref(path, accum)
    | Absyn.EXCEPTIONspec arg =>
        mod_ref_set (List.foldr cvt_tyoption ModuleName.empty (map #2 arg),
                     accum)
    | Absyn.STRUCTUREspec arg =>
        StrDec (
          List.map 
            (fn (id, sign) => {name=strid_to_mn id, 
                               def=cvt_sigexp sign, constraint=NONE})
            arg ) :: accum
    | Absyn.SHARINGspec (spec, arg) =>
        let fun f (Absyn.STRUCTUREshareq l, accum) =
                  List.foldr (fn (Ident.LONGSTRID(path,_), acc) =>
                                mod_ref(path, acc)) accum l
              | f (Absyn.TYPEshareq l, accum) =
                  List.foldr (fn (Ident.LONGTYCON(path,_), acc) =>
                                mod_ref(path, acc)) accum l
            val set = List.foldr f ModuleName.empty (map #1 arg) 
         in cvt_spec (spec, mod_ref_set(set, accum))
        end
    | Absyn.LOCALspec (spec1, spec2) =>
        local_dec(cvt_spec (spec1, []), cvt_spec (spec2, []), accum)
    | Absyn.OPENspec (arg, _) => (OpenDec (map (VarStrExp o long_str_to_path) arg)) :: accum
    | Absyn.INCLUDEspec (sigexp, _) =>
        (OpenDec [cvt_sigexp sigexp] :: accum)
    | Absyn.SEQUENCEspec arg => (dec_seq_to_dec (List.foldr cvt_spec [] arg)) :: accum

  fun cvt_sigb ((id, sigexp, _), accum: Dec list): Dec list =
    StrDec [{name = sigid_to_mn id,
             def = cvt_sigexp sigexp,
             constraint = NONE}] :: accum

  fun cvt_sigbs (Absyn.SIGBIND(sigbs), accum: Dec list): Dec list =
    List.foldr cvt_sigb accum sigbs

  fun cvt_funb (funid, strid, sigexp, strexp, sigexpb_opt, _, _, _, _, _) =
    { name = funid_to_mn funid,
      params = [(SOME (strid_to_mn strid), cvt_sigexp sigexp)],
      body = cvt_strexp strexp,
      constraint = case sigexpb_opt of
                     NONE => NONE
                   | SOME (sigexp,_) => SOME (cvt_sigexp sigexp) }

  fun cvt_funbs (Absyn.FUNBIND(funbinds), accum: Dec list): Dec list =
    FctDec (map cvt_funb funbinds) :: accum

  fun cvt_topdec (ast : Absyn.TopDec, accum : Dec list) : Dec list =
    case ast of
      Absyn.STRDECtopdec(str_dec, _) =>  cvt_strdec(str_dec) :: accum
    | Absyn.SIGNATUREtopdec(sigbinds, _) =>
        List.foldr cvt_sigbs accum sigbinds
    | Absyn.FUNCTORtopdec(funbinds, _) =>
        List.foldr cvt_funbs accum funbinds
    | Absyn.REQUIREtopdec(_, _) => accum

  fun convert (ast: Absyn.TopDec) : Dec =
    dec_seq_to_dec (cvt_topdec(ast, []))
end



