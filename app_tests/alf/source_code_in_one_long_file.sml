(*
 *
 * $Log: source_code_in_one_long_file.sml,v $
 * Revision 1.2  1998/06/01 09:03:21  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

    

datatype DEPENDENCIES = 
            Deps of (string * string) list *     (* Assoc list in backtrack *)
                    string list *     (* Compound notions *)
                    string list *     (* Yet unknown notions *)
                    (string * string list) list *   
                       (* Compound notion --> [Yet unknown notions] *)
                    (string * (string list * string list)) list
                       (* Any notion --> [notions in context (and type)],[notions in definition] *)
				;

fun get_YN_names (Deps(_,_,YN,_,_)) = YN;


fun substract x [] = []
 |  substract x (y::l) = if x = y then l else y::(substract x l) ;




fun update_delete x (Deps(DN,CN,YN,DO,DDO)) =  
      let fun del (x'::l) x = if x = x' then l else x'::del l x
          |   del [] _ = []
          fun del_DDO x ((y,(T,E))::l) = 
                if x = y then del_DDO x l
                else (y,(del T x,del E x))::del_DDO x l
          |   del_DDO _ [] = []
          fun del_DO x ((y,T)::l) = 
                if x = y then del_DO x l
                else (y,del T x)::del_DO x l
          |   del_DO _ [] = []
          val newCN = substract x CN
          val newYN = substract x YN
          val newDO = del_DO x DO
          val newDDO = del_DDO x DDO
      in Deps(DN,newCN,newYN,newDO,newDDO)
      end
  ;
(******** Term, type and context datatypes ************)

datatype EXP =
 Var of string
|Expl of string * string list
|Can of string * string list
|Impl of string * string list
|App of EXP * EXP list
|Lam of string list * EXP
|Let of (string * EXP) list * EXP
;

datatype TYP =
 Sort of string
|TExpl of string * string list
|TLet of (string * EXP) list * string * string list    (* i ett eftersom bara TExpl kan ha subst *)
|Elem of string * EXP
|Prod of DECL list * TYP

and DECL = 
 Arr of TYP
|Dep of string * TYP ;(*************************************************************************)
(*             Miscellenous functions                                    *)
(*************************************************************************)

fun mem [] _ = false
|   mem (a::l) b = a = b orelse mem l b
    ;

fun add x l = if mem l x then l else x::l ;

fun union ([],l) = l
 |  union (l,[]) = l
 |  union (x1::l1,x2::l2) = add x1 (add x2 (union (l1,l2))) ;

fun map_union f [] = []
|   map_union f (x::l) = union (f x,map_union f l) ;                                          (* 'a * 'b -> 'a *)

fun snd (_, y) = y;

fun is_in_the_term l (Expl(s,_)) = if mem l s then [s] else []
|   is_in_the_term l (Can(s,_)) = if mem l s then [s] else []
|   is_in_the_term l (Impl(s,_)) = if mem l s then [s] else []
|   is_in_the_term l (App(e,al)) = 
      union (is_in_the_term l e,map_union (is_in_the_term l) al)
|   is_in_the_term l (Lam(_,e))  = is_in_the_term l e
|   is_in_the_term l (Let(vb,e))  = 
      union (is_in_the_term l e,map_union (is_in_the_term l) (map snd vb))
|   is_in_the_term l e           = [] ;

fun is_in_the_type l (Elem (s,e)) = is_in_the_term l e
|   is_in_the_type l (TExpl(c,_)) = if mem l c then [c] else []
|   is_in_the_type l (TLet(vb,c,_)) = 
      if mem l c then union([c],map_union (is_in_the_term l) (map snd vb))
      else map_union (is_in_the_term l) (map snd vb)
|   is_in_the_type l (T as Prod(argt,t)) =
      union (is_in_the_type l t,map_union (is_in_the_type l) 
            (map (fn Arr t => t | Dep(x,t) => t) argt))
|   is_in_the_type l _ = []
    ;


fun retrieve [] x = [x]
|   retrieve ((y,e)::l) x = if x = y then e else retrieve l x ;

fun retreive_undefined l (x::dl) YN = 
      union(if mem YN x then [x] else retrieve l x,retreive_undefined l dl YN)
|   retreive_undefined l [] _ = [];

(*********** dependency_graph.ml ************)
exception circular_definition;


fun change_to L x (y::l) = 
       if x = y then union(L,l) 
       else union([y],change_to L x l)
|   change_to L _ [] = []
;


fun change_DO_list x DL ((y,L)::l) =
      if x = y then (x,DL)::change_DO_list x DL l
      else (y,change_to DL x L)::change_DO_list x DL l
|   change_DO_list x DL [] = []
;
exception Name_not_in_dep_list of string;

fun change_DDO_list x L ((y,(T,E))::l) = 
      if x = y then (x,(T,L))::l
      else (y,(T,E))::change_DDO_list x L l
|   change_DDO_list x L [] = raise Name_not_in_dep_list x
;


fun Tupdate_refine x t (Deps(DN,CN,YN,DO,DDO)) =
      let val L = is_in_the_type (CN @ YN) t
          val DL = retreive_undefined DO L YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = x::CN
              val newYN = substract x YN
              val newDO = change_DO_list x DL DO
              val newDDO = change_DDO_list x L DDO
          in Deps(DN,newCN,newYN,newDO,newDDO)
          end
      end
;

fun filter p nil       = nil            (* ('a -> bool) -> 'a list -> 'a list *)
  | filter p (x :: xs) =
       if p x then x :: filter p xs
       else             filter p xs;

(* minus L X computes L\X *)
fun minus A []     = A
 |  minus A (y::B) = minus (substract y A) B ;

fun not_allowed_recursion DL x (true,l) = mem (minus DL (x::l)) x
|   not_allowed_recursion DL x (false,_) = mem DL x
;

fun update_refine x e recursion_allowed (Deps(DN,CN,YN,DO,DDO)) =
      let val L = is_in_the_term (CN @ YN) e
          val DL = retreive_undefined DO (filter (not o mem (snd recursion_allowed)) L) YN
      in if not_allowed_recursion DL x recursion_allowed then raise circular_definition
         else
          let val newCN = x::CN
              val newYN = substract x YN
              val newDO = change_DO_list x DL DO
              val newDDO = change_DDO_list x L DDO
          in Deps(DN,newCN,newYN,newDO,newDDO)
          end
      end
;

datatype CONEXP =
 ID of string
|APP of CONEXP * CONEXP list
|LAM of string list * CONEXP
|LET of CONDEF_SUBST * CONEXP 
and CONDEF_SUBST =
     SNAME of string
   | GSUBST of (string * CONEXP) list
   | COMP of CONDEF_SUBST * CONDEF_SUBST
;



datatype CONTYP =
 TID of string
|TLET of CONDEF_SUBST * string
|SORT of string
|ELEM of CONEXP
|PROD of CONDECL list * CONTYP

and CONDECL =
     ARR of CONTYP
   | DEP of string * CONTYP ;

datatype CON_GROUND_CONTEXT =
     CNAME of string
   | GCON of (string * CONTYP) list;
datatype CONDEF_CONTEXT = DCON of CON_GROUND_CONTEXT list;


datatype CONTEXT = Con of (string * TYP) list;


datatype GROUND_CONTEXT =
  CName of string * string list
| GCon of (string * TYP) list;
datatype DEF_CONTEXT = DCon of GROUND_CONTEXT list * string list;


(********** functions to create new names *************)
val qsym = "?";
fun isqsym s = s = qsym;

fun visible_name name = 
      let fun isvisible (s::l) = not (isqsym s)
          |   isvisible l = true
      in isvisible (explode name)
      end
;(****************************************************************************)
(**************  FUNCTIONS TO CHANGE DEPENDENCY GRAPH  **********************)
(****************************************************************************)

fun inscratch c (Deps(VN,CN,YN,DO,DDO)) = mem CN c orelse mem YN c;

datatype CONSTRUCTORS = ConTyp of string * TYP * DEF_CONTEXT * int;
		     
(* the type and pattern_context are computed *)
datatype DEFINITION = Expr of EXP
                    | Case of EXP * TYP * (EXP * DEFINITION) list;

datatype PATTERN = IDef of EXP * DEFINITION * TYP * CONTEXT * int;
		    

(************ primitive definition datatypes *****************)

datatype PRIMITIVES = CTyp of string * TYP * DEF_CONTEXT * int * CONSTRUCTORS list
                         (* Canonical definitions *)
                    | ITyp of string * TYP * DEF_CONTEXT * int * PATTERN list
                          (* Implicit definitions with pattern *)
		    ;  (* names in context *)


datatype DEF_SUBST =
  SName of string
| GSubst of (string * EXP) list
| Comp of DEF_SUBST * DEF_SUBST
;  

datatype ABBREVIATIONS = TDef of string * TYP * DEF_CONTEXT * int
                       | EDef of string * EXP * TYP * DEF_CONTEXT * int
                       | SDef of string * DEF_SUBST * DEF_CONTEXT * DEF_CONTEXT * int
                       | CDef of string * DEF_CONTEXT * int 
;

datatype DEF_KIND = Set_Kind | Constr_Kind of string | Impl_Kind 
                  | Exp_Abbr | Type_Abbr | Context_Abbr | Subst_Abbr



datatype DEF_ID = C_id of string * int
                | Con_id of string * int
                | I_id of string * int
                | P_id of string * int
                | E_id of string * int
                | T_id of string * int
                | DC_id of string * int
                | DS_id of string * int
                ;datatype INFO = Info of EXP list * (string * DEF_KIND) list * (DEF_ID list * int) * string list
               (* symboltable & global names - abbreviation kinds & new definitions & history command*)
              ;

datatype U_TYP = DT of TYP
               | TUnknown
               ;
        	      ;

datatype U_CONSTRUCTORS = UConTyp of string * U_TYP * DEF_CONTEXT;
datatype PATH = P of string * int list;

datatype WDEFINITION = WUnknown
                     | WExpr of EXP
                     | WCase of  EXP * TYP * WAITING_PATTERN list
and      WAITING_PATTERN = WPatt of PATH * DEF_CONTEXT * CONTEXT * EXP * WDEFINITION * TYP
                         ;


(**** ?????????????????
datatype U_DEF_SUBST =
  U_SName of string
| U_GSubst of (string * U_EXP) list
| U_Comp of U_DEF_SUBST * U_DEF_SUBST
;***********************)

datatype U_PRIMITIVES = UCTyp of string * U_TYP * DEF_CONTEXT * U_CONSTRUCTORS list
                      | UITyp of string * U_TYP * DEF_CONTEXT * WAITING_PATTERN list;


(************** scratch area datatypes ******************)

datatype U_EXP = D of EXP
               | Unknown
	       ;


datatype U_ABBREVIATIONS = UTDef of string * U_TYP * DEF_CONTEXT
                         | UEDef of string * U_EXP * TYP * DEF_CONTEXT
                         | USDef of string * DEF_SUBST * DEF_CONTEXT * DEF_CONTEXT  (* ?????? *)
                         | UCDef of (string * DEF_CONTEXT)
;

datatype ENV_CONSTRAINT = EE of (EXP * EXP * TYP * DEF_CONTEXT)
                         | TT of (TYP * TYP * DEF_CONTEXT)
;

datatype SCRATCH_AREA = Scratch of (U_PRIMITIVES list *
                                    U_ABBREVIATIONS list *
                                    ENV_CONSTRAINT list * 
                                    DEPENDENCIES);

datatype BACKTRACK_INFO = Back of U_PRIMITIVES list *
                                  U_ABBREVIATIONS list *
                                  DEPENDENCIES
                        ;

(************************************************************)
(*************** ENVIRONMENT DATATYPES **********************)
(************************************************************)

datatype ENV = Env of (PRIMITIVES list * 
                       ABBREVIATIONS list *
                       INFO *         (* Information of environment *)
                       SCRATCH_AREA *
                       BACKTRACK_INFO)      (* backtracking information *)
                ;
fun get_deps      (Env(_,_,_,Scratch(_,_,_,deps),_))       = deps;
  
fun in_scratch_area c env = inscratch c (get_deps env);
exception May_complete_context_before_use of string;

datatype ENV_KIND = Abbr of ABBREVIATIONS
                  | Prim of PRIMITIVES
                  | Constr of string * CONSTRUCTORS
                  | Patt of PATTERN
                  | UAbbr of U_ABBREVIATIONS
                  | UPrim of U_PRIMITIVES
                  | UConstr of string * U_CONSTRUCTORS
                  | UPatt of WAITING_PATTERN
		  ;   
exception look_up_abbr_error of string;
fun get_abbrs     (Env(_,abbrs,_,_,_))                     = abbrs;

fun look_up_abbr name env =
      let fun look_up name ((abbr as TDef(name',_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as EDef(name',_,_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as CDef(name',_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as SDef(name',_,_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name [] = raise look_up_abbr_error name
      in look_up name (get_abbrs env)
      end
;
fun get_defs      (Scratch(_,defs,_,_))                    = defs;

fun look_up_u_abbr_in_scratch name scratch =
      let fun look_up name ((abbr as UTDef(name',_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as UEDef(name',_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as UCDef(name',_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as USDef(name',_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name [] = raise look_up_abbr_error name
      in look_up name (get_defs scratch)
      end
;
fun get_scratch   (Env(_,_,_,scratch,_))                   = scratch;
fun get_back_abbrs (Env(_,_,_,_,Back(_,defs,_)))           = defs;

fun look_up_back_abbr name env =
      let fun look_up name ((abbr as UTDef(name',_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as UEDef(name',_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as UCDef(name',_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name ((abbr as USDef(name',_,_,_))::abbrs) = 
                 if name = name' then abbr else look_up name abbrs
          |   look_up name [] = raise look_up_abbr_error name
      in look_up name (get_back_abbrs env)
      end
;

fun look_up_u_abbr name env =
      look_up_u_abbr_in_scratch name (get_scratch env)
      handle look_up_abbr_error _ => look_up_back_abbr name env
;

fun look_up_def name env =
      if visible_name name then
        Abbr (look_up_abbr name env)
        handle (look_up_abbr_error name) => UAbbr (look_up_u_abbr name env)
      else UAbbr (look_up_u_abbr name env)
;   
exception Not_A_Context_Definition of string;

fun look_up_defcontext name env = 
      case (look_up_def name env) of
        (Abbr (CDef(_,DefC,_))) => DefC
      | (UAbbr (UCDef(_,DefC))) => DefC
      | _ => raise Not_A_Context_Definition name
;

fun unfold_defcontext DefC env =
      let fun unfold_defcont (DCon (C,_)) = unfold C
          and unfold ((CName (name,_))::l) = 
                if visible_name name andalso in_scratch_area name env 
                  then raise May_complete_context_before_use name
                else unfold_defcont (look_up_defcontext name env) @ unfold l
          |   unfold ((GCon C)::l) = C @ unfold l
          |   unfold [] = []
      in Con (unfold_defcont DefC)
      end
;

fun fst (x, _) = x;
exception type_from_context_error of string;
    
fun type_from_context x DefC env =
     let fun gettype x [] = raise type_from_context_error x
          |  gettype x ((x',A)::l) = if x = x' then A else gettype x l
         val (Con C) = unfold_defcontext DefC env
     in gettype x C
     end
 ;

fun get_context_of_def name env =
      case (look_up_def name env) of
        (UAbbr (UEDef(_,_,_,DefC))) => DefC
      | (UAbbr (UTDef(_,_,DefC))) => DefC
      | (UAbbr (UCDef(_,DefC))) => DefC
      | (Abbr (EDef(_,_,_,DefC,_))) => DefC
      | (Abbr (TDef(_,_,DefC,_))) => DefC
      | (Abbr (CDef(_,DefC,_))) => DefC
      | _ => raise look_up_abbr_error name
;
exception look_up_name_error of string;


(*********** functions to look up a name **************)

fun get_kind_of s [] = (false,Set_Kind)
|   get_kind_of s ((s',kind)::l) = if s = s' then (true,kind) else get_kind_of s l
;
fun get_id_kind name (Env(_,_,Info(_,names,_,_),_,_))  = get_kind_of name names;

fun is_exp_kind Set_Kind = true
|   is_exp_kind (Constr_Kind _) = true
|   is_exp_kind Impl_Kind = true
|   is_exp_kind Exp_Abbr = true
|   is_exp_kind _ = false
;
exception Name_already_defined of string;


(************ environment.ml ******************)
exception Not_A_Subst_Definition of string;

fun look_up_defsubst name env = 
      case (look_up_def name env) of
        (UAbbr (USDef(_,DefS,DefC1,DefC2))) => (DefS,DefC1,DefC2)
      | (Abbr (SDef(_,DefS,DefC1,DefC2,_))) => (DefS,DefC1,DefC2)
      | _ => raise Not_A_Subst_Definition name
;
    

fun defcontext_names (DCon (_,I)) = I;

fun rest [] I = []
 |  rest ((x,Var y)::l) I = if x = y then rest l I        (* ALSO : removes trivial substitutions *)
                            else if mem I x then (x,Var y)::rest l I
                                 else rest l I
 |  rest ((x,e)::l) I = if mem I x then (x,e)::rest l I
                        else rest l I;

(* application of a substitution to an expression *)
fun component [] s = Var s
 |  component ((y,e)::subst) s = if s = y then e else component subst s ;

fun rest1 L [] = L
 |  rest1 L (x::A) = substract_rest x (rest1 L A)
and substract_rest x [] = []
 |  substract_rest x ((y,f)::A) = if y = x then A 
                 else (y,f)::(substract_rest x A) ;


fun occurs [] x = false
 |  occurs (y::A) x = if x = y then true else occurs A x ;


(* a gensym function *)
fun prime x =  x ^"'" ;
fun gensym I x = if occurs I x then gensym I (prime x) else x ;

fun substract_subst (x,e) [] = []
 |  substract_subst (x,e) ((y,f)::A) = if x = y then A 
				     else (y,f)::(substract_subst (x,e) A) ;

(* minus L X computes L\X *)

fun minus_subst A []     = A
 |  minus_subst A ((y,f)::B) = minus_subst (substract_subst (y,f) A) B ;

fun plus_subst A L = L@(minus_subst A L) ;

fun fun_Let ([],e)        = e
 |  fun_Let (L1,Let(L,e)) = Let(L1@L,e)
 |  fun_Let (L1,e)        = Let(L1,e) ;local fun len' n nil       = n
        | len' n (_ :: xs) = len' (n+1) xs
in fun len xs = len' 0 xs end;

fun fun_Lam (L1,Lam(L,e)) = Lam(L1@L,e)
 |  fun_Lam ([],e)        = e
 |  fun_Lam (L1,e)        = Lam(L1,e) ;
exception take_error;


fun take 1 (a::l) = ([a],l)
|   take n (a::l) = let val (first,rest) = take (n-1) l
                    in (a::first,rest)
                    end
|   take _ [] = raise take_error
;

(* plus_subst, no common identifiers *)

fun fun_App (App(e,A),B) = App(e,A@B)
 |  fun_App (e,[])       = e
 |  fun_App (e,A)        = App(e,A) ;
(************ prelude.ml ******************)
exception zip_error;

fun zip ([],[]) = [] 
|   zip (a::l,b::l1) = (a,b)::zip(l,l1)
|   zip _ = raise zip_error
;


fun inst I vb (Var s)        = component vb s
 |  inst I vb (Expl(s,l))    = fun_Let(rest vb l,Expl(s,l))
 |  inst I vb (Impl(c,l))    = fun_Let(rest vb l,Impl(c,l))
 |  inst I vb (Can(c,l))     = fun_Let(rest vb l,Can(c,l))
 |  inst I vb (App(e,A))     = 
       simplereduce I (fun_App(inst I vb e,map (inst I vb) A))
 |  inst I vb (Lam(L,e))     = let val (I1,vb1,L1) = rename (I,vb,L) in 
                                        fun_Lam(L1,inst I1 vb1 e)
                                end
 |  inst I vb (Let(X,Expl(s,l)))     = 
       fun_Let(rest (comp_subst I vb X) l,Expl(s,l))
 |  inst I vb (Let(X,Impl(s,l)))     = 
       fun_Let(rest (comp_subst I vb X) l,Impl(s,l))
 |  inst I vb (Let(X,Can(s,l)))     = 
       fun_Let(rest (comp_subst I vb X) l,Can(s,l))
 |  inst I vb (Let(X,e))     = Let(comp_subst I vb X,e)

and inst_subst I vb []         = []
 |  inst_subst I vb ((x,e)::X) = (x,inst I vb e)::(inst_subst I vb X)

and comp_subst I vb L          = plus_subst vb (inst_subst I vb L)

and rename (I,vb,[]) = (I,vb,[])
 |  rename (I,vb,x::L) = 
     let val vb1 = substract_rest x vb 
     in if occurs I x then 
            let val x1 = gensym I (prime x)
                val I' = x1::I
                val (I1,vb2,L1) = rename (I',plus_subst [(x,Var x1)] vb1,L) 
            in (I1,vb2,x1::L1)
            end
       else let val (I1,vb2,L1) = rename (x::I,vb1,L) 
            in (I1,vb2,x::L1)
            end
     end

and simplereduce I (App(Lam(vl,e),argl)) = simplereduce I (betareduce I vl e argl)
|   simplereduce I (Let(S,Expl(s,l)))    = fun_Let(rest S l,Expl(s,l))
|   simplereduce I (Let(S,Impl(s,l)))    = fun_Let(rest S l,Impl(s,l))
|   simplereduce I (Let(S,Can(s,l)))    = fun_Let(rest S l,Can(s,l))
|   simplereduce I (Let(S,e))            = simplereduce I (inst I S e)
(* we know that e has to be a compound expression *)
|   simplereduce I (App(Let(S,Expl(s,l)),argl)) = 
      fun_App(fun_Let(rest S l,Expl(s,l)),argl)
|   simplereduce I (App(Let(S,Impl(s,l)),argl)) = 
      fun_App(fun_Let(rest S l,Impl(s,l)),argl)
|   simplereduce I (App(Let(S,Can(s,l)),argl)) = 
      fun_App(fun_Let(rest S l,Can(s,l)),argl)
|   simplereduce I (App(Let(S,e),argl))  = simplereduce I (fun_App(inst I S e,argl))
|   simplereduce I e                     = e

and betareduce I vl e argl =
      let val n = len vl
          val k = len argl
      in if n = k then (inst I (zip (vl,argl)) e)
         else if n > k then
                 let val (k_of_vl,rest) = take k vl
                 in (inst I (zip (k_of_vl,argl)) (fun_Lam(rest,e)))
                 end
              else let val (n_of_argl,rest) = take n argl
                   in fun_App(inst I (zip (vl,n_of_argl)) e,rest)
                   end
      end
;


fun unfold_defsubst (SName name) env I = 
      let val (DefS,DefC1,_) = look_up_defsubst name env
      in unfold_defsubst DefS env (defcontext_names DefC1)
      end
|   unfold_defsubst (GSubst S) _ _ = S
|   unfold_defsubst (Comp (DefS1,DefS2)) env I =
       let val S1 = unfold_defsubst DefS1 env I
           val S2 = unfold_defsubst DefS2 env I
       in rest (comp_subst I S2 S1) I
       end
;

fun look_up_symbol (Can(c,l)::sym) c' = 
       if c = c' then Can(c,l) else look_up_symbol sym c'
|   look_up_symbol (Impl(c,l)::sym) c' = 
       if c = c' then Impl(c,l) else look_up_symbol sym c'
|   look_up_symbol (Expl(c,l)::sym) c' = 
       if c = c' then Expl(c,l) else look_up_symbol sym c'
|   look_up_symbol (Var x::sym) c' = 
       if x = c' then Var x else look_up_symbol sym c'
|   look_up_symbol (_::sym) c' = look_up_symbol sym c'
|   look_up_symbol [] c' = Var c'
;

fun local_names_of (Expl(_,l)) = l
|   local_names_of (Impl(_,l)) = l
|   local_names_of (Can(_,l)) = l
|   local_names_of _ = []
;
;

fun convert_exp I env symbols (ID s) = look_up_symbol ((map Var I)@symbols) s
|   convert_exp I env symbols (APP(f,argl)) =
      App(convert_exp I env symbols f,map (convert_exp I env symbols) argl)
|   convert_exp I env symbols (LAM(vl,e)) =
      Lam(vl,convert_exp I env ((map Var vl)@symbols) e)
|   convert_exp I env symbols (LET(S,e)) =
      let val e' =  convert_exp I env symbols e
      in fun_Let(unfold_defsubst (convert_DefS I S symbols env) env (local_names_of e'),e')
      end
and convert_subst I env symbols ((x,e)::l) = 
      (x,convert_exp I env symbols e)::convert_subst I env symbols l
|   convert_subst _ _ _ [] = []
and convert_DefS I (SNAME name) sym env = SName name
|   convert_DefS I (GSUBST s) sym env = GSubst (convert_subst I env sym s)
|   convert_DefS I (COMP (DefS1,DefS2)) sym env =
      Comp(convert_DefS I DefS1 sym env,convert_DefS I DefS2 sym env)
;

(*********** convert.ml *************)
exception Only_ground_terms_can_be_types of EXP;



fun fill_in_quest_marks n e =
      let fun create_argt 0 = []
          |   create_argt n = (Var qsym)::create_argt (n-1)
          val argt = create_argt n
          fun fill_first_App (App(e,A),B) = App(e,B@A)
          |   fill_first_App (e,[])       = e
          |   fill_first_App (e,A)        = App(e,A) ;
      in fill_first_App(e,argt)
      end
;
exception Elem_type_not_Sort of EXP * TYP;


fun get_sort e (Sort s) = (s,e)
|   get_sort e (Prod(argt,Sort s)) = (s,fill_in_quest_marks (len argt) e)
|   get_sort e t = raise Elem_type_not_Sort (e,t)
;

fun get_type_def_of name env =
      case (look_up_def name env) of
        (UAbbr (UTDef(_,def,_))) => def
      | (Abbr (TDef(_,def,_,_))) => DT def
      | _ => raise look_up_abbr_error name
;

fun fun_TLet ([],c,l) = TExpl(c,l)
|   fun_TLet (vb,c,l) = TLet(vb,c,l)
;
      

(* Computation of free variables in terms and types. Could be done with
   get_subset_fidents, but maybe this more efficient? *)

fun is_free_in_term x (Var s)  = x = s
 |  is_free_in_term x (Expl(s,l))  = false
 |  is_free_in_term _ (Impl(s,l))   = false
 |  is_free_in_term _ (Can(s,l))   = false
 |  is_free_in_term x (App(e1,A))    = 
      (is_free_in_term x e1) orelse (map_is_free_in_term x A)
 |  is_free_in_term x (Lam([],e))     = is_free_in_term x e
 |  is_free_in_term x (Lam(y::L,e))     = 
      if x = y then false else is_free_in_term x (Lam(L,e))
 |  is_free_in_term x (Let(X,e))     = 
      (map_is_free_in_term x (map snd X)) orelse (is_free_in_term x (Lam(map fst X,e)))
and map_is_free_in_term _ [] = false
 |  map_is_free_in_term x (e::A) = 
      (is_free_in_term x e) orelse (map_is_free_in_term x A) ;


(************ term.ml ******************)
exception FreeIdentsType;

fun is_free_in_type x (Sort s)         = false
 |  is_free_in_type x (Elem (s,e))         = is_free_in_term x e
 |  is_free_in_type x (TExpl(c,l)) = mem l x
 |  is_free_in_type x (TLet(vb,c,l)) = mem (minus l (map fst vb)) x
 |  is_free_in_type x (Prod([Dep (s,e1)],e2))  = 
is_free_in_type x e1 orelse (if x = s then false else is_free_in_type x e2)
 |  is_free_in_type x (Prod((Dep (s,e1))::D1,e2))  = 
is_free_in_type x e1 orelse (if x = s then false else is_free_in_type x (Prod(D1,e2)))
 |  is_free_in_type x (Prod([Arr e1],e2))  = 
is_free_in_type x e1 orelse is_free_in_type x e2
 |  is_free_in_type x (Prod((Arr e1)::D1,e2))  = 
is_free_in_type x e1 orelse is_free_in_type x (Prod(D1,e2))
 |  is_free_in_type x _ = raise FreeIdentsType;
exception exp_error;

(* we do not need it in the following, because the functionality of a type is 
   constant under instantiation *)


fun simple_Prod ([Arr u],e) = Prod ([Arr u],e)
 |  simple_Prod ([Dep(x,t)],e) = 
       if is_free_in_type x e then Prod([Dep(x,t)],e) 
       else Prod([Arr t],e) 
 |  simple_Prod ((Arr u)::L,e) = 
       (case (simple_Prod (L,e)) of
         (Prod(L1,e1)) => Prod ((Arr u)::L1,e1) 
        | _ => raise exp_error)
 |  simple_Prod ((Dep(x,t))::L,e) =
       (case (simple_Prod (L,e)) of
         (Prod(L1,e1)) =>
            if is_free_in_type x (Prod(L1,e1)) then Prod((Dep(x,t))::L1,e1)
            else Prod((Arr t)::L1,e1)
       | _ => raise exp_error)
 |  simple_Prod _ = raise exp_error
;

fun inst_type I vb (Sort s) = Sort s
 |  inst_type I vb (Elem (s,e)) = Elem (s,inst I vb e)
 |  inst_type I vb (TExpl(s,l)) = fun_TLet(rest vb l,s,l)
 |  inst_type I vb (TLet(S,s,l)) = fun_TLet(rest (comp_subst I vb S) l,s,l)
 |  inst_type I vb (Prod([],t)) = inst_type I vb t
 |  inst_type I vb (Prod(L,v)) =
      let val (I1,vb1,L1) = rename_type (I,vb,L) 
      in simple_Prod(L1,inst_type I1 vb1 v) 
      end 
and rename_type (I,vb,[]) = (I,vb,[])
 |  rename_type (I,vb,(Arr u)::L) = 
      let val (I1,vb1,L1) = rename_type (I,vb,L) 
      in (I1,vb1,(Arr (inst_type I vb u))::L1)
      end
 |  rename_type (I,vb,(Dep (x,u))::L) = 
      let val vb1 = substract_rest x vb 
      in if occurs I x then 
           let val x1 = gensym I (prime x) 
               val (I1,vb2,L1) = 
                 rename_type (x1::I,plus_subst [(x,Var x1)] vb1,L) 
           in (I1,vb2,(Dep (x1,inst_type I vb u))::L1)
           end
         else
           let val (I1,vb2,L1) = rename_type (x::I,vb1,L) 
           in (I1,vb2,(Dep (x,inst_type I vb u))::L1)
           end
      end
;


fun unfold_type (T as TExpl(c,l)) env = 
     if isqsym c then T
     else (case get_type_def_of c env of
            TUnknown => T
          | DT (t as TExpl _) => check_prod_type (unfold_type t env) env
          | DT t => check_prod_type t env)
|   unfold_type (T as TLet(vb,c,l)) env = 
     if isqsym c then T
     else (case get_type_def_of c env of
            TUnknown => TLet(vb,c,l)
          | DT (t as TExpl _) => inst_type l vb (check_prod_type (unfold_type t env) env)
          | DT t => inst_type l vb (check_prod_type t env))
|   unfold_type t env = check_prod_type t env
and check_prod_type (T as Prod(argl,t)) env =
      (case unfold_type t env of
         (Prod(argl1,t1)) => check_prod_type (Prod(argl@argl1,t1)) env
       | t => T)
|   check_prod_type t env = t
;


(* we use the fact that we create only Let(S,c) c constant and variables of S
   used by c, and we never create Let(S,Var x) *)


fun fun_Prod (L1,Prod(L,e)) = Prod(L1@L,e)
 |  fun_Prod ([],e)        = e
 |  fun_Prod (L1,e)        = Prod(L1,e) ;(************************************************************************)
(***********        TYPE CHECKING FUNCTIONS                   ***********)
(************************************************************************)


fun on_proper_form (Var _) = true
|   on_proper_form (Can _) = true    
|   on_proper_form (Impl _) = true
|   on_proper_form (Expl _) = true
|   on_proper_form (Let(_,Expl _)) = true
|   on_proper_form (Let(_,Impl _)) = true
|   on_proper_form (Let(_,Can _)) = true
|   on_proper_form  _ = false
    ;

fun get_type_of_def name env =
      case (look_up_def name env) of
        (UAbbr (UEDef(_,_,typ,_))) => typ
      | (Abbr (EDef(_,_,typ,_,_))) => typ
      | _ => raise look_up_abbr_error name
; 
exception look_up_prim_error of string;



(*************** ENVIRONMENT DESTRUCTION FUNCTIONS *****************)

fun get_prims     (Env(prims,_,_,_,_))                     = prims;

fun look_up_theory_prim name env =
      let fun look_up_constr ((prim as ConTyp(name',_,_,_))::prims) =
                 if name = name' then (true,prim) else look_up_constr prims
          |   look_up_constr [] = (false,ConTyp("",Sort "Set",DCon ([],[]),0))
          fun look_up name ((prim as CTyp(name',_,_,_,constrl))::prims) = 
                 if name = name' then (Prim prim) else 
                   let val (found,prim) = look_up_constr constrl
                   in if found then (Constr(name,prim)) else look_up name prims
                   end
          |   look_up name ((prim as ITyp(name',_,_,_,_))::prims) = 
                 if name = name' then (Prim prim) else look_up name prims
          |   look_up name [] = raise look_up_prim_error name
      in look_up name (get_prims env)
      end
;
fun get_u_prims   (Env(_,_,_,Scratch(u_prims,_,_,_),_))    = u_prims;          

fun look_up_u_prim name env =
      let fun look_up_constr ((prim as UConTyp(name',_,_))::prims) =
                 if name = name' then (true,prim) else look_up_constr prims
          |   look_up_constr [] = (false,UConTyp("",TUnknown,DCon ([],[])))
          fun look_up name ((prim as UCTyp(name',_,_,constrl))::prims) = 
                 if name = name' then (UPrim prim) else 
                   let val (found,prim) = look_up_constr constrl
                   in if found then (UConstr (name,prim)) else look_up name prims
                   end
          |   look_up name ((prim as UITyp(name',_,_,_))::prims) = 
                 if name = name' then (UPrim prim) else look_up name prims
          |   look_up name [] = raise look_up_prim_error name
      in look_up name (get_u_prims env)
      end
;
fun get_back_prims (Env(_,_,_,_,Back(prims,_,_)))           = prims;

fun look_up_back_prim name env =
      let fun look_up_constr ((prim as UConTyp(name',_,_))::prims) =
                 if name = name' then (true,prim) else look_up_constr prims
          |   look_up_constr [] = (false,UConTyp("",TUnknown,DCon ([],[])))
          fun look_up name ((prim as UCTyp(name',_,_,constrl))::prims) = 
                 if name = name' then (UPrim prim) else 
                   let val (found,prim) = look_up_constr constrl
                   in if found then (UConstr (name,prim)) else look_up name prims
                   end
          |   look_up name ((prim as UITyp(name',_,_,_))::prims) = 
                 if name = name' then (UPrim prim) else look_up name prims
          |   look_up name [] = raise look_up_prim_error name
      in look_up name (get_back_prims env)
      end
;

fun look_up_prim name env =
      look_up_theory_prim name env
      handle (look_up_prim_error name) => 
        (look_up_u_prim name env
         handle (look_up_prim_error name) => 
            look_up_back_prim name env)   (* for reading a scratch file *)
;
exception Type_Not_Yet_Defined of string;


fun get_type_of_prim name env =
       case (look_up_prim name env) of
         (Prim (CTyp(_,typ,_,_,_))) => typ
       | (Constr (_,ConTyp(_,typ,_,_))) => typ
       | (Prim (ITyp(_,typ,_,_,_))) => typ
       | (UPrim (UCTyp(_,DT typ,_,_))) => typ
       | (UConstr (_,UConTyp(_,DT typ,_))) => typ
       | (UPrim (UITyp(_,DT typ,_,_))) => typ
       | (UPrim (UCTyp(_,TUnknown,_,_))) => raise Type_Not_Yet_Defined name
       | (UConstr (_,UConTyp(_,TUnknown,_))) => raise Type_Not_Yet_Defined name
       | (UPrim (UITyp(_,TUnknown,_,_))) => raise Type_Not_Yet_Defined name 
       | _ => raise look_up_prim_error name
;

(*********** typecheck.ml ************)
exception gettype_error of EXP;(*************************************************************************)
(* functions to compute conversion of terms and types                    *)
(*************************************************************************)


fun gettype (Var x) C I env = type_from_context x C env
|   gettype (Impl (c,_)) C I env = get_type_of_prim c env
|   gettype (Expl (c,l)) C I env = get_type_of_def c env
|   gettype (Can (c,l)) C I env = get_type_of_prim c env
|   gettype (Let(vb,Impl(c,l))) C I env = 
       inst_type I vb (get_type_of_prim c env)
|   gettype (Let(vb,Expl(c,l))) C I env = 
       inst_type I vb (get_type_of_def c env)
|   gettype (Let(vb,Can(c,l))) C I env = 
       inst_type I vb (get_type_of_prim c env)
|   gettype e _ _ _ = raise gettype_error e
;


fun get_real_type e DefC I env = unfold_type (gettype e DefC I env) env;

(* This function might seem unnecessary complex, but its just for saving work
   with renaming variables, when not needed. *)
fun increase_context (Lam([],e)) (Prod([],t)) I C = (e,t,rev C,I)
|   increase_context (Lam([],e)) t I C = (e,t,rev C,I)
|   increase_context (Lam(v::vl,e)) (Prod(Arr A::argl,t)) I C =
      if occurs I v then 
        let val newvar = gensym (vl@I) v
            val I' = newvar::I
        in increase_context (inst I' [(v,Var newvar)] (Lam(vl,e))) (Prod(argl,t))
                          I' ((newvar,A)::C)
        end
      else increase_context (Lam(vl,e)) (Prod(argl,t)) (v::I) ((v,A)::C)
|   increase_context (Lam(v::vl,e)) (Prod(Dep (x,A)::argl,t)) I C =
      if v = x then
        if occurs I v then 
          let val newvar = gensym I v
              val I' = newvar::I
          in increase_context (inst I' [(v,Var newvar)] (Lam(vl,e))) 
	                      (inst_type I' [(x,Var newvar)] (Prod(argl,t)))
                            I' ((newvar,A)::C)
          end
        else increase_context (Lam(vl,e)) (Prod(argl,t)) (v::I) ((v,A)::C)
      else if not (occurs I v) then  (* v =/= x *)
             let val I' = v::I
             in increase_context (Lam(vl,e)) 
                               (inst_type I' [(x,Var v)] (Prod(argl,t))) I' ((v,A)::C)
             end
           else if not (occurs I x) then
                   let val I' = x::I
                   in increase_context (inst I' [(v,Var x)] (Lam(vl,e))) (Prod(argl,t))
                            I' ((x,A)::C)
                   end
                else let val newvar = gensym I v  (* both x and v is in I *)
                         val I' = newvar::I
                     in increase_context (inst I' [(v,Var newvar)] (Lam(vl,e))) 
                                          (inst_type I' [(x,Var newvar)] (Prod(argl,t)))     
                                           I' ((newvar,A)::C)
                     end
|   increase_context e (Prod([],t)) I C = (e,t,rev C,I)
|   increase_context e t I C = (e,t,rev C,I)
;

fun add_contexts (DCon (l,I)) [] = DCon (l,I)
|   add_contexts (DCon ([GCon []],[])) C = DCon ([GCon C],map fst C)
|   add_contexts (DCon (l,I)) C = DCon (l@ [GCon C],(map fst C)@ I);
exception Can't_compute_sort_of of EXP;

fun is_quest_mark (Var s) = isqsym s 
|   is_quest_mark _ = false
;


(* used in make_ground to compute an extension to the context with names distinct *)
(* from the original context names *)
fun get_arg_types (Prod([],t)) I C _ = (t,rev C)
|   get_arg_types (Prod(Arr A::argl,t)) I C n =
      let val newvar = gensym I ("h"^makestring n)  
             (* This is a hack to get "decent" name.. *)
      in get_arg_types (Prod(argl,t)) (newvar::I) ((newvar,A)::C) (n+1)
      end
|   get_arg_types (Prod(Dep (x,A)::argl,t)) I C n =
      if occurs I x then 
        let val newvar = gensym I ("h"^makestring n)
            val I' = newvar::I
        in get_arg_types (inst_type I' [(x,Var newvar)] (Prod(argl,t)))
                          I' ((newvar,A)::C) (n+1)
        end
      else get_arg_types (Prod(argl,t)) (x::I) ((x,A)::C) n
|   get_arg_types t I C _ = (t,rev C)
  ;
  
    
(* e1 and e2 are applied to a proper number of fresh variables  *)
(* -> saturated expressions. Since variables are fresh, *)
fun make_ground e1 e2 (t as Prod (_,_)) env DefC I = 
     let val (t',C') = get_arg_types t I [] 0
         val I' = map fst C'
         val vl = map Var I'
     in (fun_App(e1,vl),fun_App(e2,vl),t',add_contexts DefC C',I')
     end
|   make_ground e1 e2 t env C I = (e1,e2,t,C,[])
;

fun get_definiens_of name env = 
      case (look_up_def name env) of
        (UAbbr (UEDef(_,def,_,_))) => def
      | (Abbr (EDef(_,def,_,_,_))) => D def
      | _ => raise look_up_abbr_error name
;

fun isunknown c env = 
      case get_definiens_of c env of
        Unknown => true
      | _ => false
;

fun any_unknown e1 e2 env =
     let fun unknown (Expl(name,_)) = isunknown name env
         |   unknown _ = false
     in unknown e1 orelse unknown e2
     end
;

(* PATTERN_REDUCABLE is the resulting type of trying one pattern to the argument
   list. The expression list is the possibly reduced arguments, to save work. *)
datatype PATTERN_REDUCABLE = MATCH of (string * EXP) list * EXP list
                           | NOTYET of EXP list 
                           | IRRED of EXP list 
		     ;

fun add_arg e (MATCH(subst,agl)) = MATCH(subst,e::agl)
|   add_arg e (IRRED(agl))        = IRRED(e::agl)
|   add_arg e (NOTYET(agl))       = NOTYET(e::agl) ;(*************************************************************************)
(* functions to compute head-normal and normal form of terms and types   *)
(*************************************************************************)

fun add_subst (x,e) (MATCH(subst,agl)) = MATCH((x,e)::subst,e::agl)
|   add_subst (x,e) (IRRED(agl))        = IRRED(e::agl)
|   add_subst (x,e) (NOTYET(agl))       = NOTYET(e::agl) ;

fun union_subst S1 S2 = S1@S2 ;


(*********************************************   Not USED  

fun disjoint_names [] l = true
|   disjoint_names (a::s) l = not (mem l a) andalso disjoint_names s l
;

fun new_patt_names [] I = []
|   new_patt_names (x::l) I = 
      let val x' = gensym I x
      in (x,x')::new_patt_names l (x'::I)
      end
;

fun rename_vars newnames ((x,e)::S) = 
      let fun newname x ((y,y')::l) = if x = y then y' else newname x l
          |   newname x [] = raise newnames_error
      in (newname x newnames,e)::rename_vars newnames S
      end
|   rename_vars newnames [] = []
;


fun inst_patt free_vars S patt_S pattern def = 
     let val patt_vars = map fst patt_S
         fun mapsnd f ((x,y)::l) = (x,f y)::mapsnd f l
         |   mapsnd f [] = []
     in if disjoint_names patt_vars free_vars 
          then inst free_vars patt_S (inst free_vars S def)
        else let val newnames = new_patt_names patt_vars free_vars
                 val newpatt_S = rename_vars newnames patt_S
                 val newdef = inst free_vars (mapsnd Var newnames) def
             in inst free_vars newpatt_S (inst free_vars S newdef)
             end
     end
;

*********************** end Not USED **************************************)

fun on_constructor_form (Can _) = true
|   on_constructor_form (Let(S,Can _)) = true
|   on_constructor_form (Var _) = true
|   on_constructor_form _ = false
;

exception Not_On_Constructor_Form;
fun get_constr_name (Can(c,_)) = c
|   get_constr_name (Let(_,Can(c,_))) = c
|   get_constr_name _ = raise Not_On_Constructor_Form

fun same_constructor c c' =
      get_constr_name c = get_constr_name c' 
      handle Not_On_Constructor_Form => false
;

(*********** reduce.ml ************)
exception checkpattern_error;
exception matchpattern_error of EXP;
exception simplereduce_result_error of EXP;

(********* functions to fill in incomplete expressions *******************)
 
fun type_arity t env =     
     let fun t_arity (Prod (dl,_)) = len dl
         |   t_arity _ = 0
     in t_arity (unfold_type t env)
     end
;



(*********** check_definitions.ml ************)
exception Not_allowed_pattern of EXP;
     

(*********** DON"T ALLOW REDUCTION RULES FROM SCRATCH AREA ***********)     


fun get_patterns_of name env =
      let fun get_defs (IDef(App(_,pattern),def,_,_,_)::defs) =
                (pattern,def)::get_defs defs
          |   get_defs (IDef(Impl _,def,_,_,_)::defs) = [([],def)]     (* can only be one pattern... *)
                    |   get_defs [] = []
          |   get_defs (IDef(e,_,_,_,_)::_) = raise Not_allowed_pattern e  
      in case (look_up_prim name env) of
           (Prim (ITyp(_,_,_,_,patterns))) => get_defs patterns
         | (UPrim (UITyp(_,_,_,wpatterns))) => []      (* What else to do with not complete patterns ???? *)
         | _ => raise look_up_prim_error name
      end
;

(* MATCH_REDUCABLE is the resulting type of trying to match an expression to
   the impliciteliy defined patterns in the environment. 
     Irred_match  : The arguments can not be reduced to match a pattern,
                    because of a variable occurence in some main arguments.
     NotYet_Match : There is a not yet defined constant in some main arguments.
     Reduced      : The expression matched the pattern, and the resulting term is
                    the substitution applied to the right-hand side of that pattern.
*)
datatype MATCH_REDUCABLE = Irred_Match of EXP
                   | NotYet_Match of EXP
                   | Reduced of EXP
		     ;

(************************************************************)
(*************** TYPE CHECKING DATATYPES ********************)
(************************************************************)

(*********** reduction and conversion datatypes **************)

(* REDUCABLE is the resulting type of computation to head normal form *)
datatype REDUCABLE = Irred of EXP
                   | NotYet of EXP
                   | HNform of EXP
		     ;

fun get_subset [] _ = []
|   get_subset (x::A) B = if mem B x then get_subset A B else x::get_subset A B;(*************************************************************************)
(* Functions to compute free identifiers and functions to instansiate    *)
(* substitutions and to do simple reductions on terms and types.         *)
(*************************************************************************)


(***** COMPUTATION OF FREE VARIABLES NOT IN THE CONTEXT *******)
(* get_subset_fidents computes FV(exp) - S, and is used to check that all
   free variables in a typed expression is *)

fun get_subset_fidents S (Var s)        = if mem S s then [] else [s]
 |  get_subset_fidents S (Expl(s,l))   = get_subset l S
 |  get_subset_fidents S (Impl(s,l))   = get_subset l S
 |  get_subset_fidents S (Can(s,l))   = get_subset l S
 |  get_subset_fidents S (App(e1,A))    = 
      union(get_subset_fidents S e1,map_union (get_subset_fidents S) A)
 |  get_subset_fidents S (Lam(L,e))     = get_subset_fidents (S@L) e
 |  get_subset_fidents S (Let(X,e))     = 
    union(get_subset_fidents (S@(map fst X)) e,
          map_union (get_subset_fidents S) (map snd X))
    ;
     
fun checkpattern (e::argl) I (Var x::pattern) env =
      if x = "_" then
        add_arg e (checkpattern argl I pattern env)
      else
        add_subst (x,e) (checkpattern argl I pattern env)
|   checkpattern (App(f,l)::argl) I (App(f',pl)::pattern) env =
      if on_constructor_form f then 
        if same_constructor f f' then
          (case (checkpattern argl I pattern env) of
             IRRED(argl') => IRRED(App(f,l)::argl')
          |  NOTYET(argl') =>               
             (case (checkpattern l I pl env) of
                 IRRED(l') => IRRED(App(f,l')::argl')
             |   NOTYET(l') => NOTYET(App(f,l')::argl')
             |   MATCH(_,l') => NOTYET(App(f,l')::argl'))
          |  MATCH(s,argl') =>
              (case (checkpattern l I pl env) of
                 IRRED(l') => IRRED(App(f,l')::argl')
              |  NOTYET(l') => NOTYET(App(f,l')::argl')
              |  MATCH(s',l') => MATCH(union_subst s' s,App(f,l')::argl')))
        else IRRED(App(f,l)::argl)
      else try_reduce_and_match (App(f,l)::argl) I (App(f',pl)::pattern) env
|   checkpattern (App(f,l)::argl) I (f'::pattern) env =
      if on_constructor_form f then IRRED(App(f,l)::argl)
      else try_reduce_and_match (App(f,l)::argl) I (f'::pattern) env 
|   checkpattern (f::argl) I (App(f',pl)::pattern) env =
      if on_constructor_form f then IRRED(f::argl)
      else try_reduce_and_match (f::argl) I (App(f',pl)::pattern) env 
|   checkpattern (f::argl) I (f'::pattern) env =
      if on_constructor_form f then 
        if on_constructor_form f' then
          if same_constructor f f' then
            (case (checkpattern argl I pattern env) of
               IRRED(argl') => IRRED(f::argl')
            |  NOTYET(argl') => NOTYET(f::argl')
            |  MATCH(s,argl') => MATCH(s,f::argl'))
          else IRRED(f::argl)
        else IRRED(f::argl)
      else try_reduce_and_match (f::argl) I (f'::pattern) env 
|   checkpattern [] _ [] _ = MATCH([],[])
|   checkpattern _ _ _ _ = raise checkpattern_error
and try_reduce_and_match (a::argl) I (App(f,l)::pattern) env =
      (case (hnf I env a ) of
              (Irred a') => IRRED(a'::argl)
           |  (HNform (App(f',l'))) => 
                  checkpattern ((App(f',l'))::argl) I (App(f,l)::pattern) env
           |  (HNform a') => IRRED(a'::argl)
           |  (NotYet a') => (case (checkpattern argl I pattern env) of
                                IRRED(argl') => IRRED(a'::argl')
                              | NOTYET(l') => NOTYET(a'::l')
                              | MATCH(_,l') => NOTYET(a'::l')))
|   try_reduce_and_match (a::argl) I (f::pattern) env = 
      (case (hnf I env a ) of
              (Irred a') => IRRED(a'::argl)
           |  (HNform f') => 
                 checkpattern (f'::argl) I (f::pattern) env
           |  (NotYet a') => (case (checkpattern argl I pattern env) of
                                IRRED(argl') => IRRED(a'::argl')
                              | NOTYET(l') => NOTYET(a'::l')
                              | MATCH(_,l') => NOTYET(a'::l')))
|   try_reduce_and_match _ _ _ _ = raise checkpattern_error
and matchpattern f argl _ [] _ = Irred_Match(App(f,argl))
|   matchpattern (f as Let(S,Impl(c,vl))) argl I ((pattern,def)::l) env = 
      ((case (checkpattern argl I pattern env) of    (** Is (I@vl) needed ??? **)
         IRRED(argl') => matchpattern f argl' I l env  (* Yes, for inst_patt *)
      |  NOTYET(argl') => NotYet_Match(App(f,argl'))
      |  MATCH(s,_) => inst_def (I@vl) (plus_subst S s) def f env)
      handle checkpattern_error => raise matchpattern_error f)
|   matchpattern f argl I ((pattern,def)::l) env =
      (case (checkpattern argl I pattern env) of   
         IRRED(argl') => matchpattern f argl' I l env
      |  NOTYET(argl') => NotYet_Match(App(f,argl'))
      |  MATCH(s,_) => inst_def I s def (App(f,argl)) env
      handle checkpattern_error => raise matchpattern_error f)  
and hnf I env e = 
      let val sr = simplereduce I e
      in case sr of
           Can _ => HNform sr
         | Let(S,Can _) => HNform sr
(*         | Impl _ => HNform sr *)
         | Let(S,Impl _) => HNform sr
         | Var _ => HNform sr
         | App(Can _,_) => HNform sr
         | App(Let(S,Can _),_) => HNform sr
         | App(Var _,_) => HNform sr
(* new *)| Impl(c,l) => try_match_pattern (Impl(c,l)) [] I env
         | App(Impl(c,vl),al) => try_match_pattern (Impl(c,vl)) al I env
         | App(Let(S,Impl(c,vl)),al) =>  try_match_pattern (Let(S,Impl(c,vl))) al I env
         | Expl(s,l) => 
             (case (get_definiens_of s env) of
                Unknown => NotYet sr
             |  D def => hnf I env def)
         | Let(vb,Expl(s,l)) => 
             (case (get_definiens_of s env) of
                Unknown => NotYet sr
              | D def => hnf I env (inst I vb def))
         | App(Expl(s,l),al) => 
             (case (get_definiens_of s env) of
                Unknown => NotYet sr
              | D def => hnf I env (fun_App(def,al)))
         | App(Let(vb,Expl(s,l)),al) => 
             (case (get_definiens_of s env) of
                Unknown => NotYet sr
              | D def => hnf I env (fun_App(inst I vb def,al)))
         | Lam(vb,e) => HNform (Lam(vb,e))             (** SHOULD THID BE ??? **)
         | e => raise simplereduce_result_error e
      end
and try_match_pattern (f as Impl(c,l)) argl I env = (* Could do eta-expand here! *)
        let val ctype = get_type_of_prim c env
            val arity_diff = type_arity ctype env - len argl
        in if arity_diff > 0 then Irred (App(f,argl))
           else case matchpattern f argl I (get_patterns_of c env) env of
                  Reduced e => hnf I env e
                | NotYet_Match e => NotYet e
                | Irred_Match e  => Irred e
         end
|   try_match_pattern (f as Let(_,Impl(c,_))) argl I env =
        let val ctype = get_type_of_prim c env
            val arity_diff = type_arity ctype env - len argl
        in if arity_diff > 0 then Irred (App(f,argl))
           else case matchpattern f argl I (get_patterns_of c env) env of
                  Reduced e => hnf I env e
                | NotYet_Match e => NotYet e
                | Irred_Match e  => Irred e
         end
|   try_match_pattern e _ _ _ = raise Not_allowed_pattern e
and inst_def I S (Expr e) _ env = Reduced(inst I S e)
|   inst_def I S (Case (v,t,exprl)) oldpattern env =
      case hnf I env (inst I S v) of
        (HNform u) => inst_deflist S I exprl u oldpattern env 
      |  _ => Irred_Match (oldpattern)
and inst_deflist _ I [] _ oldpattern _ = Irred_Match (oldpattern)
|   inst_deflist S I ((p,def)::l) u oldpattern env = 
      case checkpattern [u] I [p] env of
        MATCH(s,_) => inst_def (I@get_subset_fidents I p) (plus_subst S s) def oldpattern env
      | _ => inst_deflist S I l u oldpattern env
;
exception get_head_and_args_error of EXP;

fun get_head_and_args (App(f,argl)) = (f,argl)
|   get_head_and_args (e as Lam _)  = raise get_head_and_args_error e
|   get_head_and_args e             = (e,[])
;


(*********** conversion.ml ************)
exception should_be_function_type;


fun argl_types (Prod(dl,_)) = dl
|   argl_types _ = raise should_be_function_type;
exception argl_conv_error; 
    
datatype CONSTRAINTS = Ok of ENV_CONSTRAINT list
                     | E_Noteq of EXP * EXP
		     | T_Noteq of TYP * TYP
                     | ET_Noteq of EXP * TYP
                     | NotType of TYP
		     ;
    
fun add_constraints cl (Ok cl') = Ok(cl@cl')
|   add_constraints _ notequal = notequal
;
exception head_error of EXP;
    

fun name_of (Can (c,_)) = c
|   name_of (Impl(c,_)) = c
|   name_of (Expl(c,_)) = c
|   name_of (Var x) = x
|   name_of e          = raise head_error e
; 
  
fun name_of_head (Let(_,e)) = name_of e
|   name_of_head (App(f,argl)) = name_of_head f
|   name_of_head e          = name_of e
;


fun get_context_of_prim name env =
       case (look_up_prim name env) of
         (Prim (CTyp(_,_,DefC,_,_))) => DefC
       | (Constr (_,ConTyp(_,_,DefC,_))) => DefC
       | (Prim (ITyp(_,_,DefC,_,_))) => DefC
       | (UPrim (UCTyp(_,_,DefC,_))) => DefC
       | (UConstr (_,UConTyp(_,_,DefC))) => DefC
       | (UPrim (UITyp(_,_,DefC,_))) => DefC
       | _ => raise look_up_prim_error name
;
exception Cannot_have_local_context of EXP;


fun get_real_context (Expl(c,l)) env = unfold_defcontext (get_context_of_def c env) env
|   get_real_context (Impl(c,l)) env = unfold_defcontext (get_context_of_prim c env) env
|   get_real_context (Can (c,l)) env = unfold_defcontext (get_context_of_prim c env) env
|   get_real_context (Let(_,e)) env = get_real_context e env
|   get_real_context e _ = raise Cannot_have_local_context e
;


fun subst_of_head (Let(S,_))        = S
|   subst_of_head (Can(c,_))        = []
|   subst_of_head (Impl(c,_))       = []
|   subst_of_head (Expl(c,_))       = []
|   subst_of_head e                 = raise head_error e
;

(*********** SOME HIERUSTICS IN CONVERSION ******************)

fun check_conv e1 e2 (t as Prod(_,_)) env C I =  (* Not a ground type t *)
      if e1 = e2 then Ok []
      else if any_unknown e1 e2 env then Ok [EE(e1,e2,t,C)]
      else let val (e1',e2',t',C',I') = make_ground e1 e2 t env C I
           in check_conv e1' e2' t' env C' (I'@I)
           end
|    check_conv (e1 as Let(S1,Expl(c1,l1))) (e2 as Let(S2,Expl(c2,l2))) t env C I =
      if c1 = c2 then subst_conv S1 S2 (get_real_context (Expl(c1,l1)) env) env C I 
      else reduce_and_check_conv e1 e2 t env C I
|   check_conv (e1 as App(f as Expl(c1,l1),argl1)) (e2 as App(Expl(c2,l2),argl2)) t env C I =
      if c1 = c2 then 
        case argl_conv argl1 argl2 (argl_types (get_real_type f C I env)) env C I [] of
          (Ok []) => Ok []
        | notequals => reduce_and_check_conv e1 e2 t env C I
      else reduce_and_check_conv e1 e2 t env C I
|   check_conv (e1 as App(f as Let(S1,Expl(c1,l1)),argl1)) (e2 as App(Let(S2,Expl(c2,l2)),argl2)) t env C I =
      if c1 = c2 then 
        (case subst_conv S1 S2 (get_real_context f env) env C I of
          (Ok []) => (case argl_conv argl1 argl2 (argl_types (get_real_type f C I env)) env C I [] of
                         (Ok []) => Ok []
                      | notequals => reduce_and_check_conv e1 e2 t env C I)
        | notequals => notequals)
      else reduce_and_check_conv e1 e2 t env C I
|   check_conv e1 e2 t env C I =
      if e1 = e2 then Ok []
      else if any_unknown e1 e2 env then Ok [EE(e1,e2,t,C)]
      else reduce_and_check_conv e1 e2 t env C I
and reduce_and_check_conv e1 e2 t env C I =
           let val hnf_e2 = hnf I env e2
           in case (hnf I env e1) of
               (Irred e1') => 
                  (case hnf_e2 of
                    (Irred e2') => 
                       if e1' = e2' then Ok [] 
                       else 
                         let val (head1,argl1) = get_head_and_args e1'                        
                             val (head2,argl2) = get_head_and_args e2'    
                             val head1_t = get_real_type head1 C I env
                         in case is_head_conv head1 head2 env C I of
                             (Ok cl) => add_constraints cl 
                                        (argl_conv argl1 argl2 (argl_types head1_t) env C I [])
                            | notequals => notequals
                         end
                  |   (NotYet e2') => 
                         let val (head1,argl1) = get_head_and_args e1'                        
                             val (head2,argl2) = get_head_and_args e2'    
                             val head1_t = get_real_type head1 C I env
                         in case is_head_conv head1 head2 env C I of
                             (Ok cl) => add_constraints cl
                               (argl_conv argl1 argl2 (argl_types head1_t) 
                                env C I [])
                            | notequals => Ok [EE(e1',e2',t,C)]
                         end
		  |   (HNform e2') => E_Noteq (e1',e2'))
             | (NotYet e1') => 
                  (case hnf_e2 of
                      (Irred e2') => 
                         let val (head1,argl1) = get_head_and_args e1'                        
                             val (head2,argl2) = get_head_and_args e2'    
                             val head1_t = get_real_type head1 C I env
                         in case is_head_conv head1 head2 env C I of
                             (Ok cl) => add_constraints cl
                               (argl_conv argl1 argl2 (argl_types head1_t) 
                                env C I [])
                            | notequals => Ok [EE(e1',e2',t,C)]
                         end
                  |   (NotYet e2') => 
                          if e1' = e2' then Ok ([]) else Ok [EE(e1',e2',t,C)] 
		  |   (HNform e2') => Ok [EE(e1',e2',t,C)] )
             | (HNform e1') => 
                  (case hnf_e2 of
                      (Irred e2') => E_Noteq (e1',e2')
                  |   (NotYet e2') => Ok [EE(e1',e2',t,C)] 
		  |   (HNform e2') => check_hnf_conv e1' e2' t env C I)
           end
and check_hnf_conv (App(f,argl)) (App(f',argl')) t env C I =
      (case is_head_conv f f' env C I of
         (Ok cl) => add_constraints cl
                    (argl_conv argl argl' (argl_types (get_real_type f C I env)) env C I [])
       | notequals => notequals)
|   check_hnf_conv (e1 as App _) e2 _ _ _ _ = E_Noteq (e1,e2)
|   check_hnf_conv e1 (e2 as App _) _ _ _ _ = E_Noteq (e1,e2)
|   check_hnf_conv e1 e2 t env C I = 
       is_head_conv e1 e2 env C I
and argl_conv (e1::argl1) (e2::argl2) (Dep(x,t)::typl) env C I S =
      (case check_conv e1 e2 (inst_type I S t) env C I of
         (Ok constraintl) => 
            add_constraints constraintl (argl_conv argl1 argl2 typl env C I ((x,e1)::S))
      |  notequal => notequal)
|   argl_conv (e1::argl1) (e2::argl2) ((Arr t)::typl) env C I S =
      (case check_conv e1 e2 (inst_type I S t) env C I of
         (Ok constraintl) => 
            add_constraints constraintl (argl_conv argl1 argl2 typl env C I S)
      |  notequal => notequal)
|   argl_conv [] [] _ _ _ _ _ = Ok []
|   argl_conv _ _ _ _ _ _ _ = raise argl_conv_error
and subst_conv S1 S2 (Con C) env gamma I =
     let fun subst S1 S2 ((x,A)::C) env gamma I =
             (case check_conv (component S1 x) (component S2 x) 
                    (inst_type I S1 A) env gamma I of
                (Ok constraintl) => 
                  add_constraints constraintl (subst S1 S2 C env gamma I)
             |  notequal => notequal)
        |   subst _ _ [] _ _ _ = Ok []
     in subst S1 S2 C env gamma I
     end
and is_head_conv (Var x) (Var x') _ _ _ = 
      if x = x' then Ok [] else E_Noteq (Var x,Var x')
|   is_head_conv (Var x) e _ _ _ = E_Noteq (Var x,e)
|   is_head_conv e (Var x) _ _ _ = E_Noteq (Var x,e)
|   is_head_conv h h' env C I =
      if name_of_head h = name_of_head h' then 
        let val h_context = get_real_context h env
        in subst_conv (subst_of_head h) (subst_of_head h') h_context env C I
        end
      else E_Noteq (h,h')
;
    
fun add_to_defcontext (x,t) (DCon (l,I)) =
      let fun add (x,t) ((GCon C)::l) = rev (GCon (C@[(x,t)])::l)
          |   add (x,t) (a::l) = rev ((GCon [(x,t)])::a::l)
          |   add (x,t) [] = [GCon [(x,t)]]
      in DCon (add (x,t) (rev l),x::I)
      end
;

fun add_tc_constraints cl (a1,a2,constr,S1,S2,C,I) = (a1,a2,add_constraints cl constr,S1,S2,C,I);

fun type_conv (Sort s) (Sort s') env C I = 
      if s = s' then Ok [] else T_Noteq (Sort s,Sort s') 
|   type_conv (T as TExpl(s,l)) T' env C I =
     if T = T' then Ok [] else
      (case get_type_def_of s env of
         (DT t) => (case T' of
                     TExpl(s',l') => 
                       if s = s' then Ok []
                       else (case get_type_def_of s env of
                               TUnknown => Ok [TT(T',T,C)]
                             | (DT t') => type_conv t t' env C I)
                   | _ => type_conv t T' env C I)
       | TUnknown => Ok [TT(T,T',C)])
|   type_conv T (T' as TExpl(s,l)) env C I =
     if T = T' then Ok [] else
      (case get_type_def_of s env of
         (DT t) => type_conv T t env C I
       | TUnknown => Ok [TT(T',T,C)])
|   type_conv (T as TLet(vb,c,l)) (T' as TLet(vb',c',l')) env C I =
      if c = c' then
        subst_conv vb vb' (unfold_defcontext (get_context_of_def c env) env) env C I
      else (case get_type_def_of c env of
              TUnknown => Ok [TT(T,T',C)]
            | (DT t) => (case get_type_def_of c' env of
                          TUnknown => Ok [TT(T',inst_type I vb' t,C)]
                        | (DT t') => type_conv (inst_type I vb t) (inst_type I vb' t') env C I))
|   type_conv (T as TLet(vb,c,l)) T' env C I =
     if T = T' then Ok [] else
      (case get_type_def_of c env of
         TUnknown => Ok [TT(T,T',C)]
       | (DT t) => type_conv (inst_type I vb t) T' env C I)
|   type_conv T (T' as TLet(vb,c,l)) env C I =
     if T = T' then Ok [] else
      (case get_type_def_of c env of
         TUnknown => Ok [TT(T',T,C)]
       | (DT t) => type_conv T (inst_type I vb t) env C I)
|   type_conv (Elem (s,e)) (Elem (s',e')) env C I = 
      if s = s' then check_conv e e' (Sort s) env C I 
      else T_Noteq (Sort s,Sort s') 
|   type_conv (Prod(argt1,t1)) (Prod(argt2,t2)) env C I =
      let val (a1,a2,constr,S1,S2,C',I') = type_conv_decl argt1 argt2 env C I [] []
      in case constr of
           (Ok cl) => add_constraints cl (type_conv (inst_type I' S1 (fun_Prod(a1,t1))) 
                                                    (inst_type I' S2 (fun_Prod(a2,t2))) env C' I')
         | notequals => notequals
      end
|   type_conv t1 t2 _ _ _ = T_Noteq(t1,t2)
and type_conv_decl ((Arr A)::argl) ((Arr A')::argl') env C I S S' =
      (case type_conv (inst_type I S A) (inst_type I S' A') env C I of
        (Ok cl) => add_tc_constraints cl (type_conv_decl argl argl' env C I S S')
      | notequal => (argl,argl',notequal,S,S',C,I))
|   type_conv_decl (Dep(x,A)::argl) (Dep(x',A')::argl') env C I S S' =
      let val A0 = inst_type I S A
          val A0' = inst_type I S' A'
      in if x = x' andalso (not (occurs I x)) then
	   case type_conv A0 A0' env C I of
             (Ok cl) => 
                add_tc_constraints cl (type_conv_decl argl argl' env (add_to_defcontext (x,A0) C) (x::I) S S')
           | notequal => (argl,argl',notequal,S,S',C,I)
         else case type_conv A0 A0' env C I of
                 (Ok cl) => let val newvar = if occurs I x then
                                               if occurs I x' then gensym I x
                                               else x'
                                             else x
                                val C' = add_to_defcontext (newvar,A0) C
                                val S0 = (x,Var newvar)::S
                                val S0' = (x',Var newvar)::S'
                             in add_tc_constraints cl (type_conv_decl argl argl' env C' (newvar::I) S0 S0')
                             end
              | notequal => (argl,argl',notequal,S,S',C,I)
      end
|   type_conv_decl (Dep(x,A)::argl) ((Arr A')::argl') env C I S S' =
      let val A0 = inst_type I S A
          val A0' = inst_type I S' A'
          val newvar = if occurs I x then gensym I x else x
          val S0 = (x,Var newvar)::S
          val C' = add_to_defcontext (newvar,A0) C
      in case type_conv A0 A0' env C I of
           (Ok cl) => add_tc_constraints cl (type_conv_decl argl argl' env C' (newvar::I) S0 S')
         | notequal => (argl,argl',notequal,S,S',C,I)
      end
|   type_conv_decl ((Arr A)::argl) (Dep(x',A')::argl') env C I S S' =
      let val A0 = inst_type I S A
          val A0' = inst_type I S' A'
          val newvar = if occurs I x' then gensym I x' else x'
          val S0' = (x',Var newvar)::S'
          val C' = add_to_defcontext (newvar,A0) C
      in case type_conv A0 A0' env C I of
           (Ok cl) => add_tc_constraints cl (type_conv_decl argl argl' env C' (newvar::I) S S0')
         | notequal => (argl,argl',notequal,S,S',C,I)
      end
|   type_conv_decl argl1 argl2 env C I S S' = (argl1,argl2,Ok [],S,S',C,I)
;


fun add_S_constraints cl (Ok l,S,l') = (Ok (cl@l),S,l')
|   add_S_constraints _ (notequal,S,l) = (notequal,S,l)
;

(********** try_fill_in.ml ***********************)
exception Not_possible_to_fill_in;

fun try_compute_type (App(f,argl)) DefC env = 
      if on_proper_form f then    (* f must be a variable or a constant *)
        if is_quest_mark f then raise Can't_compute_sort_of (App(f,argl))
        else let val I = defcontext_names DefC
                 val ftype = get_real_type f DefC I env
             in case ftype of
                  (Prod(argt,t')) => 
                    if (len argl) > (len argt) then 
                        raise Can't_compute_sort_of (App(f,argl))
                    else let val (cl,S,argl') = try_compute_type_list argl argt DefC I env []
                         in inst_type I S (fun_Prod (argl',t'))
                          end
                 | _ => raise Can't_compute_sort_of (App(f,argl))
             end
      else raise Can't_compute_sort_of (App(f,argl))
|   try_compute_type e DefC env =
      if on_proper_form e then 
        get_real_type e DefC (defcontext_names DefC) env
      else raise Can't_compute_sort_of e
and  try_compute_type_list ((e as Lam(vl,_))::argl) (Arr t::l) DefC I env S =
       (case t of
          (Prod(argt,T)) =>
              if (len vl) > (len argt) then raise Can't_compute_sort_of e
              else let val (e',t',C',I') = increase_context e t I []
                       val DefC' = add_contexts DefC C'
                       val e'type = try_compute_type e' DefC' env
                   in case type_conv e'type (inst_type I' S T) env DefC' I' of
                       (Ok cl) => add_S_constraints cl 
                                  (try_compute_type_list argl l DefC' I' env S)
                      | notequal => (notequal,S,[])
                   end
          | _ => raise Can't_compute_sort_of e)
|   try_compute_type_list (e::argl) (Arr t::l) DefC I env S =
      if is_quest_mark e then try_compute_type_list argl l DefC I env S
      else let val etype = try_compute_type e DefC env 
           in case type_conv etype (inst_type I S t) env DefC I of
                (Ok cl) => add_S_constraints cl (try_compute_type_list argl l DefC I env S)
               | notequal => (notequal,S,[])
           end
|    try_compute_type_list ((e as Lam(vl,_))::argl) (Dep(x,t)::l) DefC I env S =
       (case t of
          (Prod(argt,T)) =>
              if (len vl) > (len argt) then raise Can't_compute_sort_of e
              else let val (e',t',C',I') = increase_context e t I []
                       val DefC' = add_contexts DefC C'
                       val e'type = try_compute_type e' DefC' env
                   in case type_conv e'type (inst_type I' S T) env DefC' I' of
                       (Ok cl) => add_S_constraints cl 
                                  (try_compute_type_list argl l DefC' I' env ((x,e)::S))
                      | notequal => (notequal,S,[])
                   end
          | _ => raise Can't_compute_sort_of e)
|   try_compute_type_list (e::argl) (Dep(x,t)::l) DefC I env S =
      if is_quest_mark e then try_compute_type_list argl l DefC I env ((x,e)::S)
      else let val etype = try_compute_type e DefC env
           in case type_conv etype (inst_type I S t) env DefC I of
               (Ok cl) => add_S_constraints cl 
                           (try_compute_type_list argl l DefC I env ((x,e)::S))
              | notequal => (notequal,S,[])
           end
|   try_compute_type_list [] argt _ _ _ S = (Ok [],S,argt)
|   try_compute_type_list _ _ _ _ _ _ = raise Not_possible_to_fill_in
;

fun special_occurs sym (x::l) s =
      let fun remove s (a::l) = if a = s then l else a::l
          |   remove _ [] = []
          fun special_eq l s = (remove sym l) = (remove sym s)
      in x = s orelse special_eq (explode x) (explode s) orelse special_occurs sym l s
      end
|   special_occurs _ [] s = false
;
fun infront sym s = 
      let val l = explode s
      in case l of
           (a::l) => if a = sym then s else sym^s
          | [] => sym
      end
;


fun create sym l s =
     let fun compute (n::sif) = ord(n) - ord("0") + 10 * (compute sif)
         |   compute [] = 0
         fun isdigit x = ord("0") <= ord(x) andalso ord(x) <= ord("9")
         fun get_num (a::l) = 
               if isdigit a then 
                 let val (sif,l') = get_num l
                 in (a::sif,l')
                 end
               else ([],a::l)
         |   get_num [] = ([],[])
         fun add_one l =
          let val (n,s') = get_num l
          in (implode (rev s'))^makestring ((compute n)+1)
          end
     in if special_occurs sym l s then create sym l (add_one (rev (explode s))) else infront sym s
     end
;

fun assoc_TID ((a,b)::l) a' = if a = a' then b else assoc_TID l a'
|   assoc_TID [] a = a
;
fun rename_ID S (ID id) = ID (assoc_TID S id)
|   rename_ID S (APP(f,l)) = APP(rename_ID S f,map (rename_ID S) l)
|   rename_ID S (LAM(vl,e)) = LAM(vl,rename_ID (filter (fn (a,b)=> not(mem vl a)) S) e)
|   rename_ID S (LET(vb,e)) = LET(vb,rename_ID S e) (* ???????????????????????????????????????? *)
fun rename_TID S (TID id) = TID (assoc_TID S id)
|   rename_TID S (PROD (decl,T)) =
      let val (decl',S') = rename_decl decl S
      in PROD(decl',rename_TID S' T)
      end
|   rename_TID S (ELEM e) = ELEM (rename_ID S e)
|   rename_TID S t = t
and rename_decl ((ARR t)::l) S = 
     let val (l',S') = rename_decl l S
     in (ARR (rename_TID S t)::l',S')
     end
|   rename_decl ((DEP(x,t))::l) S = 
     let val (l',S') = rename_decl l (filter (fn (a,b) => a <> x) S)
     in (DEP(x,rename_TID S t)::l',S')
     end
|   rename_decl [] S = ([],S)
;

fun convert_type DefC env symbols (TID s) = 
      let val I = defcontext_names DefC
      in if mem I s then Elem (get_sort (Var s) (unfold_type (type_from_context s DefC env) env))
         else case get_id_kind s env of
                (true,Type_Abbr) => TExpl(s,defcontext_names (get_context_of_def s env))
              | (true,s_kind) => if is_exp_kind s_kind then
                                   convert_type DefC env symbols (ELEM (ID s))
                                 else raise Name_already_defined s
              | _ => if isqsym s then TExpl(s,I)    (* This is a new goal ... *)
                     else raise look_up_name_error s
      end
|   convert_type DefC env symbols (SORT s) = Sort s
|   convert_type DefC env symbols (TLET(S,id)) =
      let val I = defcontext_names DefC
      in case get_id_kind id env of
                (true,Type_Abbr) => 
                    TLet(unfold_defsubst (convert_DefS I S symbols env) env I,id,I)
              | (true,s_kind) => if is_exp_kind s_kind then
                                   convert_type DefC env symbols (ELEM (LET(S,ID id)))
                                 else raise Name_already_defined id
              | _ => TLet(unfold_defsubst (convert_DefS I S symbols env) env I,id,I) 
      end
|   convert_type DefC env symbols (ELEM con_e) = 
      let val e = convert_exp (defcontext_names DefC) env symbols con_e
      in case e of
           (Var x) => if isqsym x then Elem ("Set",e)   (*********** DEFAULT *****************)
                      else Elem (get_sort e (try_compute_type e DefC env))
         | (Lam _) => raise Only_ground_terms_can_be_types e
         | _ => Elem (get_sort e (unfold_type (try_compute_type e DefC env) env))
      end
|   convert_type DefC env symbols (PROD (decl,t)) =
      let fun conv (sym,(ARR t)::l,DefC,S) = 
                let val (sym',l',DefC',S') = conv (sym,l,DefC,S)
                in (sym',Arr (convert_type DefC env sym (rename_TID S t))::l',DefC',S')
                end
          |   conv (sym,DEP(x,t)::l,DefC,S) =
                let val I = defcontext_names DefC
                    val x' = if mem I x then create "" I x else x
                    val t' = convert_type DefC env sym (rename_TID S t)
                    val (sym',l',DefC',S') = conv ((Var x')::sym,l,add_contexts DefC [(x',t')],if x = x' then S else (x,x')::S)
                in (sym',Dep (x',t')::l',DefC',S')
                end
          |   conv (sym,[],DefC,S) = (sym,[],DefC,S)
          val (allsymbols,conv_decl,newDefC,S) = conv (symbols,decl,DefC,[])
      in Prod(conv_decl,convert_type newDefC env allsymbols (rename_TID S t))
      end
;

fun mkDefC (C,I) = DCon ([GCon C],I);


(************* functions to get names or symbols in env *************)

fun symbol_table (Env(_,_,Info(symbols,_,_,_),_,_)) = symbols;

fun convert_DefC (DCON l) env =
      let fun context_names name = 
                let val (Con C) = unfold_defcontext (look_up_defcontext name env) env
                    val I = map fst C
                in (map Var I,(C,I))
                end
          fun c_conv (sym,(x,t)::l,(C,I)) =
                let val t' = convert_type (mkDefC (C,I)) env sym t
                    val (sym',l',(C',I')) = c_conv ((Var x)::sym,l,((x,t')::C,x::I))
                in (sym',(x,t')::l',(C',I'))
                end
          |   c_conv (sym,[],I) = (sym,[],I)
          fun conv (sym,(CNAME name)::l,(C,I)) = 
                let val (newsym,(C',I')) = context_names name 
                    val (sym',l',(C'',I'')) = conv (newsym @ sym,l,(C'@C,I'@I))
                in (sym',(CName (name,I'))::l',(C'',I''))
                end
          |   conv (sym,(GCON c)::l,(C,I)) =
                let val (sym',c',(C',I')) = c_conv (sym,c,(C,I))
                    val (sym'',l',(C'',I'')) = conv (sym',l,(C',I'))
                in (sym'',(GCon c')::l',(C'',I''))
                end
          |   conv (sym,[],I) = (sym,[],I)
          val (allsymbols,newl,(C,I)) = conv(symbol_table env,l,([],[]))
      in (DCon (newl,I),allsymbols)
      end
;

fun convert_exp_typ_DefC ce ct cDefC env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
          val I = defcontext_names DefC
      in (convert_exp I env allsymbols ce,convert_type DefC env allsymbols ct,DefC)
      end
;


(**** FOR PRINTING A FILE WHICH CAN BE RELOADED *****************)
    
fun myprint s = (output(std_out,s);
		 flush_out std_out);
     
val new_info =
     "\n\n"^
     "  Turbo WINDOW_VERSION September 6 \n\n"^
     "            *** NEW *** \n"^
     "  Implicit constants without arguments \n"
;
(*****************************************************************)
(*********************  TOP-LOOP FUNCTIONS ***********************)
(*****************************************************************)

  
fun print_start_info() =
     myprint (
       "Welcome to the proof editor :\n"^
       "********** ALF**********\n\n"^new_info)
;


fun undo flags = not (mem flags "-u");
		   


datatype UNDO_INFO = UNDO of ENV | NOTHING;




(* in let(x1=e1,...,xn=en;e) the identifiers x1,...,xn are distincts *)

(* invariants: no identifiers appear twice in the list 
   App(e,l), l is not empty, and e is not an App
   Lam(l,e), l is not empty, and e is not an Lam,

 but this is not true for let, in general

 Let(S1,Let(S2,u))

 is not the same as Let(S1@S2,u), becaise Let(S,u) represents the simultaneous
 substitution of S to the term u *)

(********* parsing datatypes, concrete syntax ************)



datatype token =
 Ident of string
|Symbol of string ;(**************************************************************************)
(**************** PARSING FUNCTION FOR COMMANDS ***************************)
(**************************************************************************)



fun lower_case s = 
      let fun upper x = ord("A") <= ord(x) andalso ord(x) <= ord("Z")
          fun make_lower x = if upper x then chr(ord("a")-ord("A")+ord(x)) else x
      in implode (map make_lower (explode s))
      end
;
exception Not_An_Ident of string;


(*********** do_command.ml ************)
exception Not_A_Command of string;

fun next_command ((Ident s)::R) = (lower_case s,R)
|   next_command ((Symbol s)::R) = raise Not_An_Ident s
|   next_command [] = raise Not_A_Command ""
;

datatype PATH_ID = Pexp | Ptype | Pcontext | Psubst | Ppatt | Pname of string | Ppath of int list;
datatype WINDOW_PATH = WP of string * PATH_ID list;
			

datatype COMMAND = 
(* file commands to extend and save the theory *)
                   New_env                                 (*#Ok*)
                 | New_scratch                             (*#Ok*)
                 | Include_file of string                  (*#New definitions :*)
                 | Reinclude_file of string                (*#New definitions :*)
                 | Load_file of string                     (*#New definitions :*)
                 | Reload_file of string                   (*#New definitions :*)
                 | Load_scratch of string                  (*#New definitions :*)
                 | Save_defs of string                     (*#Ok*)
                 | Save_scratch of string                  (*#Ok*)
                 | Move_to_env of string list              (*#Ok/Error*)
(* extending the scratch area *)
                 | New_exp of string                       (*#New definitions :*)
                 | New_type of string                      (*#New definitions :*)
                 | New_context of string                   (*#New definitions :*)
                 | New_subst of string * CONDEF_SUBST      (*#New definitions :*)
                 | New_set of string                       (*#New definitions :*)
                 | New_constr of string * string           (*#New definitions :*)
                 | New_impl of string                      (*#New definitions :*)
                 | Move_to_scratch of string list          (*#Ok*)
                 | Extend_context of string * string
                 | Change_context of string * CONDEF_CONTEXT
(* refining a goal *)
                 | Abstr of WINDOW_PATH                       (*#New definitions :*)
                 | Abstr_all of WINDOW_PATH
                 | Refine of WINDOW_PATH * CONEXP
                 | Change of WINDOW_PATH * CONEXP
                 | Abstract_type of WINDOW_PATH * string
                 | Refine_type of WINDOW_PATH * CONTYP
                 | Change_type of WINDOW_PATH * CONTYP
                 | Solve_constr of int
(* refining a pattern *)
                 | Create_pattern of WINDOW_PATH                (*#New definitions :*)
                 | Refine_pattern of WINDOW_PATH
                 | Case_pattern of WINDOW_PATH
(* info to the window system *)
                 | Show_info of string   (* WINDOW_PATH    FFFFOOOORRRRRR NNNNNOOOOOWWWW *)
(* backtracking *)
                 | Remove_def of string
                 | Remove_const of string list
                 | Remove_case of string
                 | Remove_patterns of string
(* Massaging a term/type*)
                 | Unfold of WINDOW_PATH  
                 | Hnf of WINDOW_PATH 
                 | Nf of WINDOW_PATH 
(* show things *)
                 | Show_unfold of WINDOW_PATH  
                 | Show_hnf of WINDOW_PATH 
                 | Show_nf of WINDOW_PATH 
                 | Typecheck of CONEXP * CONTYP * CONDEF_CONTEXT
                 | Fits of CONDEF_SUBST * CONEXP * CONDEF_CONTEXT
                 | Print_env
                 | Print_name of string list
                 | Print_scratch
                 | Print_actual_env
                 | Com_file of string
                 | Print_constr
                 | Print_unknown
                 | Print_visible_unknown
                 | Help
                 | History of string
		 | Print_bug of string
                 | NoCommand of string
                 | Undo
                 | Quit
		 ;

datatype 'a OUTPUT = Fail of string * token list
                   | Res of 'a * token list ;

(*********** parse_definitions.ml ************)
exception Syntax_error of string * token list;

fun get_result (Res(r,[])) = r
|   get_result (Res(_,s)) = 
       raise Syntax_error ("Expected nothing here!",s)
|   get_result (Fail(message,rest)) =
       raise Syntax_error (message,rest)
;

fun opt_APP (e,[]) = e
|   opt_APP (APP(e,l),l1) = APP(e,l@l1)
|   opt_APP (e,l)           = APP(e,l) ;
     
fun start_with x (Symbol y::l) = y = x
|   start_with x _             = false 
;
infix modify ;

fun (parser modify f) s = 
       case parser s of 
         Res(x,l)  => Res(f x,l)
       | Fail(s,l) => Fail(s,l) 
;

fun pair x y = (x,y) ;
		     
fun follow_with x parser1 parser2 s =
      case parser1 s of  
        Res(zut,l) => if start_with x l then (parser2 modify (pair zut)) l
                      else Res((zut,[]),l)
      | Fail(s,l) => Fail(s,l) 
;
		     

fun opt_LAM ([],e)          = e
|   opt_LAM (l,LAM(l1,e))   = LAM(l@l1,e)
|   opt_LAM (l,e)           = LAM(l,e) ;


fun opt_LET (x,S) = LET(S,ID x);

fun opt_FORGET (_,(x,_)) = x ;

fun opt_ID x = ID x ;
fun opt_SName ((_,S),_) = SNAME S;

(* composition of parsers *)

infix <|> ;

fun (parser1 <|> parser2) s =
       case parser1 s of  
         Res(zut,l) => Res(zut,l)
       | Fail(_,_) => parser2 s
;


fun opt_Comp ((((_,s1),_),s2),_) = COMP (s1,s2);

fun code a (Ident x::l) = if a = x then Res(x,l) 
			         else Fail(a^" expected",(Ident x)::l)
|   code a other         = Fail(a^" expected",other) ;


fun   close "(" ")" = true
|     close "[" "]" = true
|     close "{" "}" = true
|     close ">" ">" = true
|     close _ _     = false 
;
fun Cons x l = x::l ;
      
fun   closing "(" = ")"
|     closing "[" = "]"
|     closing "{" = "}"
|     closing ">" = ">"
|     closing _   = "" 
;
      

fun sequence openid comma parser (Symbol y::l) = 
      let fun parser1 s = 
            case parser s of
              Res(zut,Symbol y::l) => 
                if close openid y then Res([zut],l) 
                else if y = comma then (parser1 modify (Cons zut)) l
                     else Fail((closing openid)^" or "^comma^" expected",Symbol y::l)
            | Res(_,l)  => Fail((closing openid)^" or "^comma^" expected",l)
            | Fail(s,l) => Fail(s,l)
      in if y = openid then parser1 l else Fail(openid^" expected",Symbol y::l) 
      end
|   sequence openid _ _ l = Fail(openid^" expected",l) 
;

fun opt_DECL (x,(_,y)) = (x,y) ;

fun PARSER_ID (Ident S::l) = Res(S,l)
|   PARSER_ID other        = Fail("identifier expected",other) 
;
infix <&> ;
    
fun (parser1 <&> parser2) s = 
       case parser1 s of  
         Res(zut,l) => (parser2 modify (pair zut)) l
       | Fail(s,l) => Fail(s,l) 
;
						  
fun literal a (Symbol x::l) = if a = x then Res(x,l) 
			      else Fail(a^" expected",(Symbol x)::l)
|   literal a other         = Fail(a^" expected",other) 
;
    
fun PARSER_EXP s  =
      ((follow_with "("
         (( (sequence "[" "," PARSER_ID <&> PARSER_EXP) modify opt_LAM)
      <|>((PARSER_ID <&> PARSER_DEFSUBST) modify opt_LET)
      <|>((literal "(" <&> (PARSER_EXP <&> literal ")")) modify opt_FORGET)
      <|> (PARSER_ID modify opt_ID))
         ((sequence "(" "," PARSER_EXP))) modify opt_APP) s 
and PARSER_DEFSUBST s = ((PARSER_SUBST modify GSUBST) 
                       <|> ((literal "{" <&> PARSER_COMPSUBST <&> code "o" <&> 
                             PARSER_COMPSUBST <&> literal "}")
                               modify opt_Comp)
                       <|> ((literal "{" <&> PARSER_ID  <&> literal "}") modify opt_SName)) s
and PARSER_COMPSUBST s = (((literal "{" <&> PARSER_COMPSUBST <&> code "o" <&> 
                             PARSER_COMPSUBST <&> literal "}")
                               modify opt_Comp)
                        <|> (PARSER_ID modify SNAME)) s
and PARSER_SUBST s = (sequence "{" ";" PARSER_SUB) s
and PARSER_SUB s = 
      ((PARSER_ID <&> (literal ":=" <&> PARSER_EXP)) modify opt_DECL) s
;
					       

(* basic parsers *)			      

fun PARSER_NAME (Ident s::l) = Res(s,l)
|   PARSER_NAME other        = Fail("identifier expected",other)
;

fun parse_name_and_subst s =
      get_result ((PARSER_NAME <&> PARSER_DEFSUBST) s)
;

fun parse_name_and_var s =
      get_result ((PARSER_NAME <&> PARSER_NAME) s)
;
fun opt_SORT x = SORT x;
fun opt_TLET (id,S) = TLET(S,id);


fun opt_TID_or_ELEM (ID x) = TID x
|   opt_TID_or_ELEM x = ELEM x;

fun PARSER_GROUNDTYPE s =
((literal "Prop" modify opt_SORT)     
<|>(literal "Set" modify  opt_SORT)
<|>((PARSER_ID <&> PARSER_DEFSUBST) modify opt_TLET)
<|>(PARSER_EXP modify opt_TID_or_ELEM)) s
;

fun opt_PROD ([],e) = e
|   opt_PROD (l,PROD(l1,e)) = PROD(l@l1,e)
|   opt_PROD (l,e) = PROD(l,e) ;

fun append x y  = x@y ;

    

fun append_sequence openid comma parser (Symbol y::l) = 
      let fun parser1 s = 
                case parser s of
                  Res(zut,Symbol y::l) => 
                    if close openid y then Res(zut,l) 
                    else if y = comma then (parser1 modify (append zut)) l
                         else Fail((closing openid)^" or "^comma^" expected",Symbol y::l)
                | Res(_,l)  => Fail((closing openid)^" or "^comma^" expected",l)
                | Fail(s,l) => Fail(s,l)
      in if y = openid then parser1 l else Fail(openid^" expected",Symbol y::l) 
      end
|   append_sequence openid _ _ l = Fail(openid^" expected",l) 
;
  
fun opt_LIST ([],x) = []
  | opt_LIST (a::l,x) = (a,x)::(opt_LIST (l,x))  ;

fun sequence_with_end endid comma parser =
     let fun parser1 s = 
              case parser s of
                Res(zut,Symbol x::l) => 
                  if x = endid then Res([zut],l) 
                  else if x = comma then (parser1 modify (Cons zut)) l
                       else Fail(endid^" or "^comma^" expected",Symbol x::l)
              | Res(_,l)  => Fail(endid^" or "^comma^" expected",l)
              | Fail(s,l) => Fail(s,l)

     in parser1
     end 
;
    
fun opt_DEP (x,y) = DEP (x,y) ;      

fun opt_ARR x = ARR x ;
fun Inj x = [x] ;

fun PARSER_TYPE s =
(  ((append_sequence "(" ";" PARSER_DECL <&> PARSER_TYPE) modify opt_PROD)
<|> PARSER_GROUNDTYPE) s
and PARSER_SIMPLDECL s = 
(  ((PARSER_ID <&> (literal ":=" <&> PARSER_TYPE)) modify (Inj o opt_DECL))
<|>(((sequence_with_end ":" "," PARSER_ID) <&> PARSER_TYPE) modify opt_LIST)) s
and PARSER_DECL s =
(  (PARSER_SIMPLDECL modify (map opt_DEP))
<|>(PARSER_TYPE modify (Inj o opt_ARR))) s ;

(*< PARSER_CONTEXT : token list -> (string * CONTYP) list OUTPUT >*)
fun PARSER_CONTEXT s = 
         (append_sequence "[" ";" PARSER_SIMPLDECL
     <|> ((literal "[" <&> literal "]") modify (fn (_,_) => []))) s
;

fun PARSER_GROUND_DEFC s = (PARSER_ID modify CNAME
                        <|> (PARSER_CONTEXT modify GCON)) s
;(****************************************************)
(****   PARSING FUNCTIONS FOR  DEFINITIONS   ********)
(****************************************************)

fun parse_list comma parser s = 
      let fun parser1 s1 = 
                case parser s1 of
                  Res(c,(Symbol y)::s') =>
                    if y = comma then (parser1 modify (Cons c)) s'
                    else Res([c],(Symbol y)::s')
                | Res(c,s') => Res([c],s')
                | Fail(s,l) => Fail(s,l)
      in parser1 s
      end
;

fun PARSER_DEFCONTEXT s =  (parse_list "+" PARSER_GROUND_DEFC modify DCON) s
;

fun parse_name_and_context s =
      get_result ((PARSER_NAME <&> PARSER_DEFCONTEXT) s)
;
          

fun split_wpath [] [] = []
|   split_wpath [] l = [rev l]
|   split_wpath ("."::l) l' = (rev l')::split_wpath l []
|   split_wpath (a::l) l' = split_wpath l (a::l')
;

fun conv_number s =
     let fun isdigit n = (n <= "9") andalso (n >= "0")
         fun conv ([],n) = (true,n)
         |   conv (a::l,n) = 
           if isdigit a then conv(l,n*10+ord a - ord "0")
           else (false,0)
     in conv(explode s,0)
     end
;

fun convert_path (nl::l) =
      let val (oknum,n) = conv_number (implode nl)
      in if oknum then let val (numl,rest) = convert_path l
                       in (n::numl,rest)
                       end
         else ([],nl::l)
      end
|   convert_path [] = ([],[])
;

fun split_pattern_path pl =
      let val (numl,rest) = convert_path pl
      in if null numl then (false,[],[])     (* Pattern path may not be empty ****)
         else (true,[Ppath numl],rest)
      end
;
fun mkpath [] = ""
|   mkpath ((x:int)::l) = "."^makestring x^mkpath l;
exception Path_error of string;

fun fix_if_LHS_unknown (c::cl) rest =
      if isqsym c then
        let val (ok,path,rest1) = split_pattern_path rest 
        in if ok then case (path,rest1) of
                        ([Ppath l],["E"]::rest2) => (implode (c::cl) ^ mkpath l ^".E",rest2)
                      | _ => (implode (c::cl),rest)
           else (implode (c::cl),rest)
        end
      else (implode (c::cl),rest)
|  fix_if_LHS_unknown [] rest = raise Path_error "Empty name"
;

fun get_path [] = []
|   get_path pl =
      let val (path,rest) = convert_path pl
      in if null rest then [Ppath path]
         else raise Path_error 
                 ("Only digits allowed in path for types and expressions, not : "^(implode (hd rest)))
      end
;

fun get_type_or_context_path (p::pl) =
      (case implode p of
        "T" => (true,Ptype::get_path pl)
      | "C" => (true,Pcontext::get_path pl)
      | _ => (false,[]))
|   get_type_or_context_path [] = (true,[])
;

fun get_constr_path c (cl::l) env =
      let val c1 = implode cl
      in case get_id_kind c1 env of
           (true,Constr_Kind setname) => 
             if c = setname then 
               let val (ok,wpath) = get_type_or_context_path l
               in if ok then WP(c,(Pname c1)::wpath)
                  else raise Path_error ("Type, context or empty path expected after : "^c^"."^c1)
               end
             else raise Path_error (c1^" is not a constructor of "^c)
          |(true,_) => raise Path_error 
                         ("The name after the setname "^c^" must be a constructor name, not : "^c1)
          |(false,_) => raise Path_error ("The name after the setname "^c^" is not known : "^c1)
      end
|   get_constr_path c [] _ = WP(c,[])
;
                

fun parse_set_kind_path c [] env = WP(c,[])
|   parse_set_kind_path c pl env =
      let val (ok,wpath) = get_type_or_context_path pl
      in if ok then WP(c,wpath)
         else get_constr_path c pl env
      end
;

(* can be empty, E,E.T or P + paths after each *)
fun get_patt_path [] = (true,[])
|   get_patt_path (cl1::l) =
      case implode cl1 of
        "E" => (case l of
                  (cl2::l') => (case implode cl2 of
                                  "T" => (true,Pexp::Ptype::get_path l')
                                | _ => (true,Pexp::get_path (cl2::l')))
                | [] => (true,[Pexp]))
      | "P" => (true,Ppatt::get_path l)
      | _ => (false,[])
;




(*********** window path functions *************)
val pexp = ".E";
val ptype = ".T";
val pcontext = ".C";
val psubst = ".S";
val ppatt = ".P";
fun makepath [] = ""
|   makepath (Pexp::l) = pexp^makepath l
|   makepath (Ptype::l) = ptype^makepath l
|   makepath (Pcontext::l) = pcontext^makepath l
|   makepath (Psubst::l) = psubst^makepath l
|   makepath (Ppatt::l) = ppatt^makepath l
|   makepath (Pname s::l) = "."^s^makepath l
|   makepath (Ppath p::l) = (mkpath p)^makepath l;fun print_wpath (WP(c,wpl)) = c ^ makepath wpl;

fun get_pattern_path c [] = WP(c,[])
|   get_pattern_path c pl =
      let val (ok,pl_path,rest) = split_pattern_path pl
      in if ok then 
           let val (ok,wpath) = get_patt_path rest
           in if ok then WP(c,pl_path@wpath)
              else raise Path_error ("Expected E,E.T or P + paths after : "^print_wpath (WP(c,pl_path)))
           end
         else raise Path_error ("Pattern path expected after "^c)
      end
;       (*   OOOOOOBBBBBSSSSSSS *)

fun parse_impl_kind_path c [] = WP(c,[])
|   parse_impl_kind_path c pl =
      let val (ok,wpath) = get_type_or_context_path pl
      in if ok then WP(c,wpath)
         else get_pattern_path c pl
      end
;

fun parse_exp_abbr_path c [] = WP(c,[])
|   parse_exp_abbr_path c pl = 
      let val (ok,pathl) = get_type_or_context_path pl
      in if ok then WP(c,pathl)
         else WP(c,get_path pl)
      end
;

fun parse_type_abbr_path c [] = WP(c,[])
|   parse_type_abbr_path c (cl::l) =
      case implode cl of
        "C" => WP(c,Pcontext::get_path l)
      | _ => WP(c,get_path (cl::l))
;

fun parse_context_abbr_path c rest = WP(c,get_path rest);
fun parse_subst_abbr_path c rest = WP(c,[]);

fun parse_window_path l env =
     case split_wpath l [] of 
        [] => raise Path_error "Empty path"
      | (cl::rest) => 
           let val (c,rest) = fix_if_LHS_unknown cl rest
           in case get_id_kind c env of
                (true,Set_Kind) => parse_set_kind_path c rest env
              | (true,Impl_Kind) => parse_impl_kind_path c rest
              | (true,Exp_Abbr) => parse_exp_abbr_path c rest
              | (true,Type_Abbr) => parse_type_abbr_path c rest
              | (true,Context_Abbr) => parse_context_abbr_path c rest
              | (true,Subst_Abbr) => parse_subst_abbr_path c rest
              | (true,Constr_Kind _) => 
                   raise Path_error ("A path cannot start with a constructor name : "^c)
              | (false,_) => raise Path_error ("There is no definition with name : "^c)
           end
;

fun window_path s env = parse_window_path (explode s) env;

fun parse_refine s env =
      let fun opt_refine ((c,_),e) = Refine (window_path c env,e)
      in  get_result (
            (  (PARSER_ID <&> literal "=" <&> PARSER_EXP) modify opt_refine
           <|> ((PARSER_ID <&> literal "with" <&> PARSER_EXP) modify opt_refine)) s)
      end
;
  
fun parse_change s env =
      let fun opt_change ((c,_),e) = Change (window_path c env,e)
      in  get_result (
            (  (PARSER_ID <&> literal "=" <&> PARSER_EXP) modify opt_change
           <|> ((PARSER_ID <&> literal "with" <&> PARSER_EXP) modify opt_change)) s)
      end
;
  

fun get_name ((Ident s)::_) = s
|   get_name ((Symbol s)::_) = raise Not_An_Ident s
|   get_name [] = ""
;
exception Missing_arguments;

fun window_path_and_opt_name ((Ident s)::l) env = 
      let val s' = get_name l
      in (window_path s env,s')
      end
|   window_path_and_opt_name ((Symbol s)::_) _ = raise Not_An_Ident s
|   window_path_and_opt_name _ _ = raise Missing_arguments
;

fun parse_refine_type s env =
      let fun opt_refine ((c,_),t) = Refine_type (window_path c env,t)
      in  get_result (
            (  (PARSER_ID <&> literal "=" <&> PARSER_TYPE) modify opt_refine
           <|> ((PARSER_ID <&> literal "with" <&> PARSER_TYPE) modify opt_refine)) s)
      end
;
  
fun parse_change_type s env =
      let fun opt_change ((c,_),t) = Change_type (window_path c env,t)
      in  get_result (
            (  (PARSER_ID <&> literal "=" <&> PARSER_TYPE) modify opt_change
           <|> ((PARSER_ID <&> literal "with" <&> PARSER_TYPE) modify opt_change)) s)
      end
;

fun PARSER_NUM (R as (Ident s)::R') =
      let val (isnumber,n) = conv_number s
      in if isnumber then (Res(n,R')) else Fail("Not a number",R)
      end
|   PARSER_NUM R = Fail("Not a number",R)
;

fun parse_number s = get_result (PARSER_NUM s)
;

fun get_window_path R env = window_path (get_name R) env;

fun emptyseq s = Res([],s) ;
		     
fun optional pr = (pr modify Inj) <|> emptyseq ;

  
fun parse_typecheck s =
      let fun opt_typecheck (((e,_),t),[C]) = Typecheck (e,t,C)
          |   opt_typecheck (((e,_),t),_) = Typecheck (e,t,DCON [])
      in get_result (
           ((PARSER_EXP <&> literal ":" <&> PARSER_TYPE <&> optional PARSER_DEFCONTEXT)
            modify opt_typecheck) s)
      end
;

fun parse_fits s =
      let fun opt_fits_context ((S,e),[C]) = Fits (S,e,C)
          |   opt_fits_context ((S,e),_) = Fits (S,e,DCON [])
      in get_result (((PARSER_DEFSUBST <&> 
                       PARSER_EXP <&> optional PARSER_DEFCONTEXT)
                      modify opt_fits_context) s)
      end
;

fun get_several_names ((Ident s)::l) = s::get_several_names l
|   get_several_names ((Symbol s)::_) = raise Not_An_Ident s
|   get_several_names [] = []
;

fun parse_command R env = 
     let val (command,R') = next_command R
     in case command of
(* file commands to extend and save the theory *)
          "new" => New_env
        | "new_scratch" => New_scratch
        | "include" => Include_file (get_name R')
        | "reinclude" => Reinclude_file (get_name R')
        | "load" => Load_file (get_name R')
        | "reload" => Reload_file (get_name R')
        | "load_scratch" => Load_scratch (get_name R')
        |           "ls" => Load_scratch (get_name R')
        | "save" => Save_defs (get_name R')
        | "save_scratch" => Save_scratch (get_name R')
        | "move_to_env" => Move_to_env (get_several_names R')
        |             "mte" => Move_to_env (get_several_names R')
(* extending the scratch area *)
        | "new_exp" => New_exp (get_name R')
        |      "ne" => New_exp (get_name R')
        | "new_type" => New_type (get_name R')
        |       "nt" => New_type (get_name R')
        | "new_context" => New_context (get_name R')
        | "new_subst" => New_subst (parse_name_and_subst R')
        | "new_set" => New_set (get_name R')
        |      "ns" => New_set (get_name R')
        | "new_constr" => New_constr (parse_name_and_var R')
        |         "nc" => New_constr (parse_name_and_var R')
        | "new_impl" => New_impl (get_name R')
        |       "ni" => New_impl (get_name R')
        | "move_to_scratch" => Move_to_scratch (get_several_names R')
        |             "mts" => Move_to_scratch (get_several_names R')
        | "extend_context" => Extend_context (parse_name_and_var R')
        | "change_context" => Change_context (parse_name_and_context R')
(* refining a goal *)
        | "abstract" => Abstr (get_window_path R' env)
        |        "a" => Abstr (get_window_path R' env)
        | "abstract_all" => Abstr_all (get_window_path R' env)
        |           "aa" => Abstr_all (get_window_path R' env)
        | "refine" => parse_refine R' env 
        |      "r" => parse_refine R' env
        | "change" => parse_change R' env
        |      "c" => parse_change R' env
        | "abstract_type" => Abstract_type (window_path_and_opt_name R' env)
        |            "at" => Abstract_type (window_path_and_opt_name R' env)
        | "refine_type" => parse_refine_type R' env
        |          "rt" => parse_refine_type R' env
        | "change_type" => parse_change_type R' env
        |          "ct" => parse_change_type R' env
        | "solve_constraint" => Solve_constr (parse_number R')
        |               "sc" => Solve_constr (parse_number R')
(* refining a pattern *)
        | "refine_pattern" => Refine_pattern (get_window_path R' env)
        |             "rp" => Refine_pattern (get_window_path R' env)
        | "create_pattern" => Create_pattern (get_window_path R' env)
        |             "cp" => Create_pattern (get_window_path R' env)
        | "do_case" => Case_pattern (get_window_path R' env)
        |      "dc" => Case_pattern (get_window_path R' env)
        | "show_info" => Show_info (get_name R')    
               (* (get_window_path R' env) FFFFOORRRRRR NNNNNNOOOOOOWWWWWWW*)
(* backtracking *)
        | "remove_def" => Remove_def (get_name R')
        | "remove" => Remove_const (get_several_names R')
        | "remove_case" => Remove_case (get_name R')
        | "remove_patterns" => Remove_patterns (get_name R')
(* massage term/type *)
        | "unfold" => Unfold (get_window_path R' env)
        | "hnf" => Hnf (get_window_path R' env)
        | "nf" => Nf (get_window_path R' env)
(* show things *)
        | "show_unfold" => Show_unfold (get_window_path R' env)
        | "show_hnf" => Show_hnf (get_window_path R' env)
        | "show_nf" => Show_nf (get_window_path R' env)
        | "typecheck" => parse_typecheck R'
        | "fits" => parse_fits R'
        | "print_env" => Print_env
        |        "pe" => Print_env
        | "print" =>  Print_name (get_several_names R')
        |     "p" =>  Print_name (get_several_names R')
        | "print_actual" => Print_actual_env
        |           "pa" => Print_actual_env
        | "print_scratch" => Print_scratch
        |            "ps" => Print_scratch
        | "constraints" => Print_constr
        |          "pc" => Print_constr
        | "unknown" => Print_unknown
        |       "u" => Print_unknown
        | "visibles" => Print_visible_unknown
        |        "v" => Print_visible_unknown
        | "history" => History (get_name R')
        | "bug" => Print_bug (get_name R')
        | "help" => Help
        | "load_commands" => Com_file (get_name R')
        |            "lc" => Com_file (get_name R')
        | "undo" => Undo
        | "quit" => Quit
        | "exit" => Quit
        | s => NoCommand s
     end
 ;
val symbolchar = mem (explode ";,{}[]|()>:+=") ;(*************************************************************************)
(*   PARSING functions for expressions, types and context                *)
(*************************************************************************)

(* concrete syntax *)

val layout = mem [" ","\n","\t"] ;
fun isletter s = ord s >= ord "a" andalso ord s <= ord "z" orelse
                 ord s >= ord "A" andalso ord s <= ord "Z";
fun isdigit s = ord s >= ord "0" andalso ord s <= ord "9";

fun letter x = isletter x orelse isdigit x orelse mem (explode "-<>#?'_./~") x;
val keyword = mem ["Set","Prop","is","with","case","end","of","#VN#","#YN#","#AL#"] ;
fun keycheck S = if keyword S then Symbol S else Ident S;

fun lexanal [] = []
|   lexanal (a::l) = 
      if layout a then lexanal l
      else if a = ":" then 
              (case l of 
                "="::l1 => Symbol ":="::(lexanal l1)
               | _      => Symbol ":"::(lexanal l))
           else if a = ";" then 
                  (case l of 
                    ";"::l1 => Symbol ";;"::(lexanal l1)
                   | _      => Symbol ";"::(lexanal l))
                else if a = "=" then 
                       (case l of 
                         ">"::l1 => Symbol "=>"::(lexanal l1)
                        | _      => Symbol "="::(lexanal l))
                     else if symbolchar a then Symbol a::(lexanal l)
	                  else getword a l
and getword S [] = [keycheck S]
|   getword S (x::l) = if layout x then (keycheck S)::(lexanal l)
                       else if letter x then getword (S^x) l
			    else (keycheck S)::(lexanal (x::l)) ;
exception subst_composition_error of DEF_SUBST;
exception Not_An_Abbreviation of string;
exception Constraint_after_backtrack of CONSTRAINTS;
exception Arity_Mismatch_in_refinement of (EXP * TYP);
exception Expected_id_and_num of token list;
exception Not_A_number of string;
exception Not_An_Impl of string;
exception Underscore_in_pattern_not_ok of EXP;
exception split_pattern_failed of WAITING_PATTERN * string * EXP;
exception look_up_wpatt_error of string;
exception pattern_without_function_def of string;
exception Not_A_Pattern_solution of U_ABBREVIATIONS;

    
(*********** printing of an expression *************)

fun print_exp (Var s)      = s
 |  print_exp (Expl(c,_))  = c
 |  print_exp (Impl(c,_))  = c
 |  print_exp (Can(c,_))   = c
 |  print_exp (App(Var s,A))     = s^"("^print_exp_app A^")"
 |  print_exp (App(Impl(c,_),A)) = c^"("^print_exp_app A^")"
 |  print_exp (App(Can(c,_),A))  = c^"("^print_exp_app A^")"
 |  print_exp (App(Expl(c,_),A)) = c^"("^print_exp_app A^")"
 |  print_exp (App(Let(L,e),A)) = 
       print_exp e^"{"^print_exp_let L^"}"^"("^print_exp_app A^")"
 |  print_exp (App(e,A)) = "("^print_exp e^")("^print_exp_app A^")"
 |  print_exp (Lam(L,e)) = "["^print_exp_lam L^"]"^print_exp e
 |  print_exp (Let(L,e)) = print_exp e^"{"^print_exp_let L^"}"
and print_exp_app [e]    = print_exp e
 |  print_exp_app (e::A) = print_exp e^","^print_exp_app A
 |  print_exp_app []     = raise exp_error
and print_exp_lam [s]    = s
 |  print_exp_lam (s::A) = s^","^print_exp_lam A
 |  print_exp_lam []     = raise exp_error
and print_exp_let [(x,e)]    = x^":="^print_exp e
 |  print_exp_let ((x,e)::A) = x^":="^print_exp e^";"^print_exp_let A
 |  print_exp_let []     = raise exp_error ;
exception type_error;


(*********** printing of a type *************)

fun print_typ (Sort s)   = s
 |  print_typ (Elem (s,e))   = print_exp e
 |  print_typ (TExpl(c,l)) = c
 |  print_typ (TLet(vb,c,l)) = c^"{"^print_exp_let vb^"}"
 |  print_typ (Prod([],t)) = print_typ t
 |  print_typ (Prod(A,t)) = "("^(print_typ_decl A)^(print_typ t)
and print_typ_decl [d]   = (print_decl d)^")"
 |  print_typ_decl (d::A) = (print_decl d)^";"^(print_typ_decl A)
 |  print_typ_decl []     = raise type_error
and print_decl (Arr t)    = print_typ t
 |  print_decl (Dep (x,t)) = x^":"^(print_typ t) ;


(*********** printing of a context *************)
		  
fun print_context (Con l) =
      let fun pr [] = ""
          |   pr ([(x,A)]) = x^":"^print_typ A
          |   pr ((x,A)::l) = x^":"^print_typ A^";"^pr l
      in "["^pr l^"]"
      end
  ;

fun print_ground_context [CName (s,_)] = s
|   print_ground_context [GCon C] = print_context (Con C)
|   print_ground_context ((CName (s,_))::l) = s^" + "^print_ground_context l
|   print_ground_context (GCon C::l) = print_context (Con C)^" + "^print_ground_context l
|   print_ground_context [] = ""
;

fun print_def_context (DCon ([],_)) = "[]"
|   print_def_context (DCon (l,_)) = print_ground_context l;

(*          
fun print_udefC (U_GCon l) = 
      let fun print_UG [(x,t)] = x^":"^print_utyp t
          |   print_UG ((x,t)::l) = x^":"^print_utyp t^","^print_UG l
          |   print_UG _ = ""
      in "["^print_UG l^"]"
      end
;
*)

(*********** printing of a substitution *************)
		  
fun print_subst l =
      let fun printl [] = ""
          |   printl ([(x,e)]) = x^":="^print_exp e
          |   printl ((x,e)::l) = x^":="^print_exp e^";"^printl l
      in "{"^printl l^"}"
      end
  ;


fun print_comp_subst (SName s) = s
|   print_comp_subst (GSubst S) = print_subst S
|   print_comp_subst (Comp (S1,S2)) = 
      print_comp_subst S1^" o "^print_comp_subst S2
;

fun print_def_subst (SName s) = "{"^s^"}"
|   print_def_subst (GSubst S) = print_subst S
|   print_def_subst (Comp (DefS1,DefS2)) =
       "{"^print_comp_subst DefS1^" o "^print_comp_subst DefS2^"}"
;

fun print_u_abbr (UEDef(name,D e2,t,c)) =
      name^" = "^print_exp e2^" : "^print_typ t^"     "^print_def_context c
|   print_u_abbr (UEDef(name,Unknown,t,c)) =
      name^" = ? : "^print_typ t^"     "^print_def_context c
|   print_u_abbr (UTDef(name,DT t,c)) =
      name^" = "^print_typ t^"     "^print_def_context c
|   print_u_abbr (UTDef(name,TUnknown,c)) =
      name^" = ?      "^print_def_context c
|   print_u_abbr (UCDef(name,udefC)) =
      name^" is "^print_def_context udefC
|   print_u_abbr (USDef(name,S,dc1,dc2)) =
      name^" is "^print_def_subst S^" : "^print_def_context dc1^"     "^print_def_context dc2
;
exception Incomplete_in_theory of ENV_KIND;



(********** unification.ml ************)
exception Impossible_unification of CONSTRAINTS;
exception Nontrivial_unification of ENV_CONSTRAINT list;
exception Type_not_S_type of string;
exception Var_not_in_context of string;
exception New_name_as_head_in_refinement of string;
exception Several_occurences_of_var;(*************************************************************************)
(*                        PRINTING functions                             *)
(*************************************************************************)


fun print_token_list ((Ident s)::(Ident s1)::l) = s^" "^s1^print_token_list l
|   print_token_list ((Ident s)::l) = s^print_token_list l
|   print_token_list ((Symbol s)::l) = s^print_token_list l
|   print_token_list [] = "\n"
;

fun chop 1 (a::l) = [a]
|   chop n (a::l) = a::chop (n-1) l
|   chop n [] = []
;
exception Not_on_proper_form of EXP;
exception Subst_on_non_subst_form of EXP;
exception Let_Not_Restricted of EXP;
exception Variable_twice_in_context of string;
exception free_variable_not_in_context of string list;
exception Impl_arity_mismatch of EXP;
exception Not_allowed_con_pattern;
exception Pattern_Var_not_unique_type of string * PATTERN;

fun print_def_exp level (Expr e) = print_exp e
|   print_def_exp level (Case(e,t,dl)) =
      "case "^print_exp e^" : "^print_typ t^" of\n"^print_case_list (level^"  ") dl^level^"end"
and print_case_list level [] = ""
|   print_case_list level ((e,d)::l) = 
     print_case_list level l^"\n"^level^print_exp e^" => "^print_def_exp (level^"  ") d
;
 
fun print_idef (IDef(Impl(c,_),e2,t,_,_)) =
      "\t"^c^"() = "^print_def_exp "\t" e2 
|   print_idef (IDef(e1,e2,t,c,_)) =
      "\t"^print_exp e1^" = "^print_def_exp "\t" e2 
      ;
exception Constraints_in_theory of CONSTRAINTS * ENV_KIND;
exception Constraints_in_context of DEF_CONTEXT * CONSTRAINTS;
exception Constraints_in_subst of DEF_SUBST * CONSTRAINTS;
exception Constraints_in_pattern of EXP * DEFINITION * CONSTRAINTS;
exception constraints_in_pattern of CONSTRAINTS;
exception Non_linear_pattern_error of EXP;
exception pattern_before_definition of string * ENV_KIND;
exception Refine_with_non_expl of EXP;
exception Refine_with_non_Texpl of TYP;
exception Command_on_non_expl of EXP;
exception Fits_with_non_subst_form of EXP;
exception Not_Correct_Refinement of CONSTRAINTS;


(*************** printing constraints *******************) 
  
fun print_constraint (Ok []) = "Ok\n"
|   print_constraint (Ok l) = 
     let fun pr [] = ""
         |   pr (EE(e1,e2,t,C)::l) = 
               print_exp e1^" = "^print_exp e2^" : "^print_typ t
                  ^"   "^print_def_context C^" \n"^ pr l
         |   pr (TT(t1,t2,C)::l) = 
               print_typ t1^" = "^print_typ t2
                  ^"   "^print_def_context C^" \n"^ pr l
     in pr l
     end
|   print_constraint (E_Noteq(e1,e2)) = 
       print_exp e1^" <> "^print_exp e2^" \n"
|   print_constraint (T_Noteq(t1,t2)) = 
       print_typ t1^" <> "^print_typ t2^" \n"
|   print_constraint (ET_Noteq(e,t)) = 
       print_exp e^" has not type "^print_typ t^" \n"
|   print_constraint (NotType t) = 
       print_typ t^" is not a type \n"
 ;
exception Circular_definition of ENV_KIND;
exception Insert_Incomplete of string list;
exception Must_be_explicit of EXP;


(*********** parse_command.ml ************)
exception Incomplete_command;
exception Not_in_scratch of string list;

(*********** backtrack.ml ************)
exception Not_backtrack_point of string;
exception Used_in_non_backtrack_point of string;



(*********** refinement.ml ************)
exception Must_Abstract_on_function of TYP;
exception Refine_on_not_unknown of string;
exception Impl_typ_not_a_function_type of PRIMITIVES;

fun print_constructor (ConTyp(name,t,c,_)) =
      "\t"^name^" : "^print_typ t^"     "^print_def_context c
;



(*********** list printing functions ***************)


fun print_list pf [] = "\n"
|   print_list pf (a::l) = print_list pf l^pf a ^"\n"
;


(*********** printing of a primitive *************)

fun print_prim (CTyp(name,t,c,_,constl)) = 
       name^" : "^print_typ t^"     "^print_def_context c
       ^print_list print_constructor constl
|   print_prim (ITyp(name,t,c,_,idefs)) = 
       name^" : "^print_typ t^"     "^print_def_context c
       ^print_list print_idef idefs
;
exception UImpl_typ_not_a_function_type of U_PRIMITIVES;

fun print_utyp TUnknown = "?"
|   print_utyp (DT t) = print_typ t
;

fun print_u_constructor (UConTyp(name,t,c)) =
      "\t"^name^" : "^print_utyp t^"     "^print_def_context c
;




(**************** add new unsure definitions to scratch *******************)

fun mk_invisible_name name = 
      if visible_name name then qsym^name else name;
fun mkname (P(s,l)) = s^mkpath l;

fun print_w_pattern level (WPatt(id,DefC,Con C,patt,WUnknown,t)) =
      let val pattname = mkname id
      in level^pattname^": "^print_exp patt^" = "^mk_invisible_name pattname^" : "^print_typ t^"    "
         ^ print_def_context (add_contexts DefC C)
      end
|   print_w_pattern level (WPatt(id,DefC,Con C,patt,WCase(e,et,wpl),t)) =
      level^(mkname id)^": "^print_exp patt^" = "^
        "case "^print_exp e^" : "^print_typ et^" of"^print_list (print_w_pattern (level^"  ")) wpl^
        " : "^print_typ t^"    "^print_def_context (add_contexts DefC C)
|   print_w_pattern level (WPatt(id,DefC,Con C,patt,WExpr e,t)) =
      level^(mkname id)^": "^print_exp patt^" = "^print_exp e^" : "^print_typ t^"    "
        ^ print_def_context (add_contexts DefC C)
;

fun print_wpatterns wpatts = print_list (print_w_pattern "\t") wpatts;

fun print_u_prim (UCTyp(name,t,c,constl)) = 
       name^" : "^print_utyp t^"     "^print_def_context c
       ^print_list print_u_constructor constl
|   print_u_prim (UITyp(name,t,c,wpatts)) = 
       name^" : "^print_utyp t^"     "^print_def_context c
       ^ print_wpatterns wpatts
;
exception Definition_not_complete of ENV_KIND;
exception Local_names_in_pattern of EXP;
exception Lam_with_ground_type of EXP * TYP;
exception Not_A_Sub_context of EXP * DEF_CONTEXT;
exception Name_already_in_context of string;
exception Not_elem_type of TYP;
exception case_pattern_failed of EXP;
exception Cannot_split_CPatt of string;

(************ waiting_patterns.ml ***********)
exception path_nonexistant;
exception Could_not_fill_in_all of CONTEXT * TYP;
exception Not_A_Set_Constructor of EXP;
exception Refine_exp_free_Vars of string * EXP * string list;
exception Refine_type_free_Vars of string * TYP * string list;
exception Can't_add_constructor of U_CONSTRUCTORS;
exception Can't_add_wpattern of WAITING_PATTERN;
exception Must_Complete_these_definitions of string list * string list;
exception Deleted_names_used_in of (string * string list) list;
    
fun plist l = 
     let fun pl [a] = a
         |   pl (a::l) = a^","^pl l
         |   pl [] = ""
     in "["^pl l^"]"
     end
;
 
fun print_used_in [] = ""
|   print_used_in ((c,cl)::l) = c^" is used in "^plist cl^"\n"^print_used_in l
;
exception Incomplete_context_used of string;

(************** modify_env.ml ****************)
exception Theory_def_used_in of string list * string list;
exception Nothing_to_save of string;
exception Must_be_of_settype of string * string * TYP;
exception Must_be_Set of string * TYP;
exception No_such_constraint_number;
exception Can't_solve_constraint of ENV_CONSTRAINT;


  
fun print_env_constraint [] = ""
|   print_env_constraint l = 
     let fun pr [] = ""
         |   pr (EE(e1,e2,t,C)::l) = 
               print_exp e1^" = "^print_exp e2^" : "^print_typ t
                  ^"   "^print_def_context C^" \n"^ pr l
         |   pr (TT(t1,t2,C)::l) = 
               print_typ t1^" = "^print_typ t2
                  ^"   "^print_def_context C^" \n"^ pr l
     in pr l
     end
;

(*********** file_handler.ml ****************)
exception No_end_of_comment of string;
exception Expand_pattern_with_scratch_set of string;
exception No_patterns of string;
exception Term_instanciated_by_unification;
exception Completed_def_not_typecorrect of ENV_KIND;


(*********** printing of abbreviations ***************)
      
fun print_abbr (EDef(name,e2,t,c,_)) =
      name^" = "^print_exp e2^" : "^print_typ t^"     "^print_def_context c
|   print_abbr (TDef(name,t,c,_)) =
      name^" = "^print_typ t^"     "^print_def_context c
|   print_abbr (CDef(name,defC,_)) =
      name^" is "^print_def_context defC
|   print_abbr (SDef(name,S,dc1,dc2,_)) =
      name^" is "^print_def_subst S^" : "^print_def_context dc1^"     "^print_def_context dc2
;

    
(*********** printing of environment ***************)

fun print_env_kind (Abbr def) = print_abbr def
|   print_env_kind (UAbbr def) = print_u_abbr def
|   print_env_kind (Prim def) = print_prim def
|   print_env_kind (UPrim def) = print_u_prim def
|   print_env_kind (Patt def) = print_idef def
|   print_env_kind (UPatt def) = print_w_pattern "" def
|   print_env_kind (Constr (_,def)) = print_constructor def
|   print_env_kind (UConstr (_,def)) = print_u_constructor def
;
exception Can't_remove_head of EXP;
exception Unknown_type_needed_in_appl of EXP;


(******** diverse *************)
exception Error_in_DEF of exn * string;
exception move_patt_to_wpatt_error;
exception Dependency_graph_mismatch;
exception fix_args_error;
exception create_pattern_error;
exception type_check_args_error;
exception patt_var_occur_error;
exception create_names_error;
exception print_in_order_error;
exception newnames_error;
exception Unsure_in_theory;
exception parsed_as_prim;
exception id_number_not_found of (string * (string * int));
exception path_error;
exception Not_U_definition of ENV_KIND;
exception Constructors_or_patterns_not_moved_with_set of ENV_KIND list;
exception parsed_as_PATT_not_WPATT;
exception Not_A_Simple_Constraint of ENV_CONSTRAINT;



(********* wprinter.ml *****************)
exception Not_Used_Anymore of string;
exception Not_A_goal of string;
exception make_unknown_error;
exception Can't_massage of string;


(******************* ERROR MESSAGES *************************)
fun bugreport error =
      let val bug =
         case error of
            zip_error => "zip_error"
          | move_patt_to_wpatt_error => "move_patt_to_wpatt_error"
          | Dependency_graph_mismatch => "Dependency_graph_mismatch"
          | fix_args_error => "fix_args_error"
          | create_pattern_error => "create_pattern_error"
          | FreeIdentsType  => "Prod type with zero arguments"
          | exp_error => "Let, Lam or App exp with zero lists"
          | type_error => "Prod type with no type arguments"
          | take_error => "take_error"
          | matchpattern_error c => 
               "Wrong implicit definition in environment for "^print_exp c
          | get_head_and_args_error e => 
              "Irred from hnf : "^(print_exp e)^" (expected irred pattern)"
          | argl_conv_error => "Argument lists of different length"
          | gettype_error e => 
              "Term not on proper form, can't get type for : "^(print_exp e)
          | type_check_args_error => "Arity mismatch"
          | simplereduce_result_error e => 
              "Not expected result from simplereduce : "^(print_exp e)
          | patt_var_occur_error => "patt_var_occur_error"
          | should_be_function_type => "should_be_function_type"
          | create_names_error => "create_names_error"
          | print_in_order_error => "print_in_order_error"
          | (Name_not_in_dep_list x) => "Name_not_in_dep_list : "^x
          | newnames_error => "newnames_error"
          | Unsure_in_theory => "Unsure_in_theory"
          | parsed_as_prim => "Parser does not decide if constructor or not."
          | id_number_not_found (func, (name,no)) => 
              "id_number_not_found ("^name^","^makestring no^") in "^func
          | path_error => "path_error"
          | Path_error s => "Path_error : "^s
          | (Not_U_definition def) => "Not_U_definition : "^print_env_kind def
          | (Constructors_or_patterns_not_moved_with_set cl) =>
               "Constructors or patterns are not moved with their set : "^print_list print_env_kind cl
          | parsed_as_PATT_not_WPATT =>
             "Pattern parsed as 'patt' instead of 'wpatt' from saved scratch"
          | Not_A_Simple_Constraint constr =>
             "Not a simple constraint : "^ print_env_constraint [constr]
          | Not_Used_Anymore s => "Not used anymore: "^s
          | Bind => "Bind"
          | Not_A_goal c => "This is not a goal : "^c
          | make_unknown_error => "Make_Unknown_Error"
          | Can't_massage s => "Can't unfold or reduce this : "^s
          | _ => "Failure, not taken care of"
      in "This can not happen, please report :\n  * "^bug
      end
;
  

  
fun errormessage_str error =
     case error of
           (subst_composition_error S) =>
              "Only named substituitions are allowed in compositions of substitutions, not :\n "
              ^print_def_subst S
       | Not_An_Abbreviation name => "This is not an abbreviation : "^name
       | Constraint_after_backtrack notequals =>
              "Unsolvable constraints after last clear (change) : "^
                 (print_constraint notequals)
       |   (Arity_Mismatch_in_refinement (e,t)) =>
              "Type has higher arity than expression  in :\n  "
               ^(print_exp e)^" : "^(print_typ t)
       |   (Expected_id_and_num tokenl) =>
              "Expected an index into waiting pattern list, and a name, not :\n "^print_token_list tokenl
       |   (Not_A_number s) =>
              "Expected a number, not : "^s
       |   (Not_An_Impl name) =>
               "Can only create patterns for implicitely definied constants, not :\n "^name
       |   (Underscore_in_pattern_not_ok p) =>
              "The underscores in this pattern are not computable from typechecking,\n"
              ^"and therefore not allowed : "^print_exp p
       |   (split_pattern_failed (wpatt,x,e)) =>
              "Not possible to split this pattern at "^x^" with "^print_exp e
       |   (look_up_wpatt_error name) =>
              "This waiting pattern is not found : "^name
       |   (pattern_without_function_def name) =>
              "Missing function definition for pattern : "^name
       |   (Not_A_Pattern_solution def) =>
              "This can't be a definition to a pattern : "^ print_u_abbr def
       |   (Incomplete_in_theory env_def) =>
              "The theory definition depends on constants in the scratch area, in :\n "^
               (print_env_kind env_def)
       |   (Impossible_unification notequals) =>
              "Unsolvable unification : "^(print_constraint notequals)
       |   (Nontrivial_unification env_cl) =>
              "Nontrivial unification problem :\n "^(print_env_constraint env_cl)
       |   (Type_not_S_type name)=> "The type of "^name^" is not a set."
       |   (Var_not_in_context name) =>
              name^" is not in the context of the pattern"
       |   (New_name_as_head_in_refinement x) =>
              "New name not allowed as head in an application : "^x
       |   Several_occurences_of_var => 
              "Several occurences of bound variable names\n in refined abstraction not allowed."
       |   (Syntax_error (err_mess,rest)) => 
              "Syntax error :\n   "^err_mess^"\nnear : "^ print_token_list (chop 15 rest)
       |   (Elem_type_not_Sort (e,t)) =>
             print_exp e^" is of type "^print_typ t^" and cannot itself be a type"
       |   (Can't_compute_sort_of e) =>
             "Can't compute the type of : "^print_exp e
       |   (look_up_name_error name) => "Unknown name : "^name
       |   (look_up_prim_error name) => "Unknown primitive constant : "^name
       |   (look_up_abbr_error name) => "Unknown explicit constant : "^name
       |   (Not_A_Subst_Definition name) =>
              name^" is not a named substitution"
       |   (Not_A_Context_Definition name) =>
              name^" is not a named context"
       |   (type_from_context_error x) => "Unknown variable : "^x
       |   (Not_on_proper_form f) => 
              "Head of application not constant/variable in : "^(print_exp f) 
       |   (Subst_on_non_subst_form e) => 
              "Attempt to substitute in expression other than a constant :\n "^(print_exp e) 
       |   (Let_Not_Restricted e) => 
              "Substitution is not restricted to constants context in :\n "^(print_exp e)
       |   (Variable_twice_in_context x) => 
              "Variable "^x^" occurs twice in context."
       |   (free_variable_not_in_context l) => 
              "These free variable is not declared in the context :\n "^plist l
       |   (Impl_arity_mismatch e) => "Arity mismatch in : "^(print_exp e)
       |   (Not_allowed_pattern e) => 
              "Not allowed pattern : "^(print_exp e)
       |   Not_allowed_con_pattern => 
              "Not allowed concrete pattern"
       |   (Pattern_Var_not_unique_type (x,def)) =>
              "Pattern variable with non unique type :\n "^x^" in pattern "^(print_idef def)
       |   (Constraints_in_theory (cl,env_kind)) =>
              "Constraints in the theory : "^(print_constraint cl)^
                 "in the definition : "^(print_env_kind env_kind)
       |   (Constraints_in_context (C,cl)) =>
               "Constraints in the context "^ print_def_context C^" :\n "^(print_constraint cl)
       |   (Constraints_in_subst (S,cl)) =>
             "Constraints in the substitution "^ print_def_subst S^" :\n "^(print_constraint cl)
       |   (Constraints_in_pattern (patt,d,cl)) =>
              "Constraints : "^print_constraint cl^
              "\nin the pattern : "^print_exp patt^" = "^(print_def_exp "" d)
       |   (constraints_in_pattern cl) =>
              "Constraints in pattern : "^print_constraint cl
       |   (Name_already_defined name) =>
              "Name is already defined : "^name
       |   (Non_linear_pattern_error p) =>
              "Convertibility of different pattern variables not assured in :\n "^(print_exp p)
       |   (pattern_before_definition (name,patt)) =>
              "No definition of "^name^" before pattern : \n   "^(print_env_kind patt)
       |   (Refine_with_non_expl e) =>
              "Only explicitely defined constants can be refined, not :\n "^(print_exp e)
       |   (Refine_with_non_Texpl t) =>
              "Only explicitely defined constants can be refined, not : "^(print_typ t)
       |   (Command_on_non_expl e) =>
              "This command can only be applied to explicitely defined constants, not : "
              ^(print_exp e)
       |   (Fits_with_non_subst_form e) =>
              "Only constants can fit a context, not : "^(print_exp e)
       |   (Not_A_Command s) =>
              "Unknown command : "^s  (*  (strconc (map makestring (map ord (explode s)))) *)
       |   (Not_Correct_Refinement constr) =>
              "Refinemnent creates unsolvable constraint :\n "^(print_constraint constr)
       |    Circular_definition (def) => 
             "This definition creates a circular reference :\n "^(print_env_kind def)
       |   circular_definition =>
             "This refinement is not allowed because of circular reference."
       |   (Insert_Incomplete namelist) => 
              "Definition of "^plist namelist^" is not complete, and can't be moved!"
       |   (Must_be_explicit e) =>
              "The command can only be applied to removable defined constants, not to :\n "^
                 (print_exp e)
       |   (Incomplete_command) =>
	       "Incomplete command in file. Expected ';;'."
       |   (Not_in_scratch l) =>
              plist l^" is not visible in the scratch area, and can not be changed."
       |   (Not_backtrack_point name) => 
              "This term/subterm is instantiated by unification and can't be changed or removed!"
       |   (Used_in_non_backtrack_point name) =>
              name^" is used in a nonbacktrackable point, and can not be deleted."
       |   (Must_Abstract_on_function t) =>
              "Only constants with a function type can be abstracted, not type :\n "
              ^(print_typ t)
       |   (Refine_on_not_unknown s) =>
              "Only not yet defined constants can be refined, not : "^s
       |   (Impl_typ_not_a_function_type def) =>
           "Types of implicitely defined constants are expected to be function types, not :\n"
              ^(print_prim def)
       |   (UImpl_typ_not_a_function_type def) =>
           "Types of implicitely defined constants are expected to be function types, not :\n"
              ^(print_u_prim def)
       |   (Definition_not_complete def) =>
              "Before the operation is allowed, this definition must be completed  :\n "
                 ^(print_env_kind def)
       |   (Local_names_in_pattern e) =>
              "Local variables of the implicit constant are not allowed in the pattern : "^
               print_exp e
       |   (Lam_with_ground_type (e,t)) =>
              "The term "^(print_exp e)^" must have a function type, not :\n "^(print_typ t)
       |   (Not_A_Sub_context (e,C)) =>
              "The context of "^print_exp e^" is not a subcontext of :\n "^print_def_context C
       |   (Cannot_have_local_context e) =>
              "Only constants can have local contexts, not :\n "^print_exp e
       |   (Name_already_in_context name) =>
              "You have chosen a name already in the context : "^name
       |   (head_error e) =>
            "Only canonical constants (with or without substitution) can be in a pattern, not :\n "
            ^(print_exp e)
       |   (Not_An_Ident s) => "Identifier expected, not : "^s
       |   Missing_arguments => "Missing arguments in the command"
       |   (Not_elem_type t) => "The case expression must be of a small type, not :\n "^print_typ t
       |   (case_pattern_failed e) =>
             "Not possible to do case on "^print_exp e
       |   (Cannot_split_CPatt path) =>
            "Not allowed to operate on this pattern, since it already has a (partial) definition :\n "^path
       |   path_nonexistant => "The pattern does not exist"
       |   Not_possible_to_fill_in => 
             "Context and substitution abbreviations are not\n possible to fill in automatically."
       |   (Could_not_fill_in_all (context,t)) =>
             "These identifiers could not be filled in : "^print_context context
             ^"\nin the type : "^print_typ t
       |   (Not_A_Set_Constructor A) =>
             "Case analyses can only be done on set constructors, not :\n "^print_exp A
       |   (Refine_exp_free_Vars (c,e,freevars)) =>
             "The derived refinement of "^c^" = "^(print_exp e)^" is not correct, since\n "
            ^(plist freevars)^" are not in "^c^"'s local context.\n"
            ^"(New names are system generated names for bound variables.)"
       |   (Refine_type_free_Vars (c,t,freevars)) =>
             "The derived refinement of "^c^" = "^(print_typ t)^" is not correct, since \n"
            ^(plist freevars)^" are not in "^c^"'s local context.\n"
            ^"(New names are system generated names for bound variables.)"
       |   (Can't_add_constructor def) =>
             "Must complete the set type before adding constructors in : \n"
             ^print_u_constructor def
       |   (Can't_add_wpattern def) =>
             "Must complete the function type before adding patterns in : \n"
             ^print_w_pattern "" def
       |   (Must_Complete_these_definitions (cl,l)) =>
             "Must complete the definitions : "^plist l^
             "\nbefore the definitions : "^plist cl
       |   (Deleted_names_used_in l) =>
             "This names are used in other definitions and can't be deleted : \n"^
	      print_used_in l
       |   (Type_Not_Yet_Defined name) =>
              "The type of "^name^" is not yet defined."
       |   (Incomplete_context_used name) =>
              "Context abbreviations must be completed before used in other definitions,\n"
              ^"which is not the case for : "^name
       |   (Theory_def_used_in (l,cl)) =>
              "Can't move "^plist l^" to the scratch, since it is used in :\n "^plist cl
       |   (May_complete_context_before_use name) =>
              "The context abbreviation may not be used while in the scratch area : "^name
       |   (Nothing_to_save filename) =>
              "Nothing to save in : "^filename
       |   (Must_be_of_settype (s,pathname,t)) =>
              "The type goal "^pathname^" must end in type "^s^" to be a constructor type, not :\n"
              ^ print_typ t
       |   (Must_be_Set (pathname,t)) =>
              "The type goal "^pathname^" must be Set or a family of sets to be a Set-constructor, not :\n"
              ^print_typ t
       |   (No_such_constraint_number) => "There is no such constraint number"
       |   (Can't_solve_constraint constr) =>
              "Can't solve this constraint, not on proper form : \n"^(print_env_constraint [constr])
       |   (No_end_of_comment filename) =>
              "Unclosed comment in file : "^filename
       |   (Expand_pattern_with_scratch_set c) =>
              "Must complete the set before it's constructors are used in case analysis : "^c
       |   (Only_ground_terms_can_be_types e) => "Only ground terms can be Elem-types, not : "^print_exp e
       |   (No_patterns name) =>
              "This implicit constant is not complete (has no patterns) : "^name
       |   Term_instanciated_by_unification => 
              "This term gets instantiated by unification (after removal) and can't be changed."
       |   (Completed_def_not_typecorrect def) =>
              "This definition is not typecorrect anymore... (reduction rules must have been changed!) : \n"
              ^ print_env_kind def
       |   Can't_remove_head e => "It is not allowed to only remove the head (or it's type) in : "^print_exp e
       |   Unknown_type_needed_in_appl f => print_exp f^" is used in an application, so it's type must be known"
       |   Error_in_DEF (error,name) => errormessage_str error ^ "\nError occured in the definition of: "^name
       |   (Io{name=s, ...}) => s 
       |   _ => bugreport error
;


fun break_points s =
      let fun break n (a::l) = if n < 200 then a::break (n+1) l
                               else a::"\n"::break 0 l
          |   break n [] = []
      in implode (break 0 (explode s))
      end
;

fun errormessage error =
      let val message = errormessage_str error
      in myprint ("#ERROR : \n   "^break_points message^"\n")
      end
;



fun get_command [] env =
     let fun end_mark (";"::";"::_) = (true,[])
         |   end_mark (a::l) = 
                 let val (isend,l') = end_mark l
                 in (isend,a::l')
                 end
         |   end_mark [] = (false,[])
         fun get_com_line () =
           let val R = explode (input_line std_in)
               val (found_end,R') = end_mark R
           in if found_end then R' 
              else if null R then ["Q","u","i","t"]
                   else R @ get_com_line()
           end
         val prompt = "\n-> "
     in (myprint prompt;
         let val R = get_com_line()
         in (parse_command (lexanal R) env,[],(implode R)^";;\n")
         end
         handle error =>  (errormessage error ; get_command [] env))
     end
|  get_command (com::coml) env = 
        (com env,coml,"") 
        handle error =>  (errormessage error ; get_command [] env)
;

      

fun add_history comm (Env(p,a,Info(sy,n,q,hist),s,b)) =
      Env(p,a,Info(sy,n,q,comm::hist),s,b)
;

fun show_ok () = myprint "\n#Ok!\n";val start_info = Info([],[],([],0),[]);(************************************************************)
(* ENVIRONMENT FUNCTIONS *)
(************************************************************)

val start_deps = Deps([],[],[],[],[]);
val start_scratch = Scratch([],[],[],start_deps);
val start_back = Back([],[],start_deps)

val start_env =  Env([],[],start_info,start_scratch,start_back);

(*********** file commands to extend and save the theory **************)

fun do_new_env (flag,coml,env,oldenv) = 
     (show_ok();(flag,coml,start_env,if undo flag then UNDO env else NOTHING));

fun save_info namelist (Info(symbols,names,idlist,hist)) =
      let fun save_syms names = filter (fn e => mem names (name_of e))
          fun save_names names = filter (fn (c,_) => mem names c)
      in Info(save_syms namelist symbols,save_names namelist names,idlist,hist)
      end
;

fun name_of_abbr (TDef(name,_,_,_)) = name
|   name_of_abbr (EDef(name,_,_,_,_)) = name
|   name_of_abbr (CDef(name,_,_)) = name
|   name_of_abbr (SDef(name,_,_,_,_)) = name
;

fun name_of_constr (ConTyp(name,_,_,_)) = name;


fun get_prim_names ((ITyp(name,_,_,_,_))::l) = name::get_prim_names l
|   get_prim_names ((CTyp(name,_,_,_,cl))::l) = name::(map name_of_constr cl) @ get_prim_names l
|   get_prim_names [] = []
;

fun get_all_names prims abbrs = 
     get_prim_names prims @ map name_of_abbr abbrs
;

fun do_new_scratch (flag,coml,env as Env(p,a,i,scratch,Back(_,_,deps)),oldenv) = 
     let val newenv = Env(p,a,save_info (get_all_names p a) i,
                          start_scratch,start_back)
     in (show_ok();if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
     end
     handle error => (errormessage error ; (flag,coml,env,oldenv))
;  

datatype CON_ABBREVIATIONS = 
            TDEF of string * CONTYP * CONDEF_CONTEXT
          | EDEF of string * CONEXP * CONTYP * CONDEF_CONTEXT
          | SDEF of string * CONDEF_SUBST * CONDEF_CONTEXT * CONDEF_CONTEXT
          | CDEF of (string * CONDEF_CONTEXT)
;

datatype CON_PRIMITIVES = CTYP of string * CONTYP * CONDEF_CONTEXT   
                        | ITYP of string * CONTYP * CONDEF_CONTEXT
                          (* Implicit definitions with pattern *)
		    ;
		     
(* the type and pattern_context are computed *)
datatype CON_DEFINITION = EXPR of CONEXP
                       | CASE of CONEXP * CONTYP * (CONEXP * CON_DEFINITION) list;

datatype CON_PATTERN = C_PATT of CONEXP * CON_DEFINITION;

datatype CONCONTEXT = CON of (string * CONTYP) list;

datatype CONWDEF = WEXPR of CONEXP
                 | WCASE of CONEXP * CONTYP * CON_WPATTERN list
and      CON_WPATTERN = WPATT of string * CONDEF_CONTEXT * CONCONTEXT * CONEXP * CONWDEF * CONTYP
;

datatype CON_UCONSTR = UCONTYP of string * CONTYP * CONDEF_CONTEXT;

datatype CON_ENV_KIND = ABBR of CON_ABBREVIATIONS
                  | PRIM of CON_PRIMITIVES
                  | PATT of CON_PATTERN
                  | UPATT of CON_WPATTERN
                  | UCONSTR of string * CON_UCONSTR
		  ;
fun opt_CTyp ((((id,_),t),c),_) = PRIM (CTYP(id,t,c));
fun opt_ITyp ((((id,_),t),c),_) = PRIM (ITYP(id,t,c));



fun PARSER_PRIMDEF s = 
       (  (PARSER_ID <&> literal ":" <&> PARSER_TYPE <&> PARSER_DEFCONTEXT <&> code "C")
             modify opt_CTyp
      <|> ((PARSER_ID <&> literal ":" <&> PARSER_TYPE <&> PARSER_DEFCONTEXT <&> code "I") 
             modify opt_ITyp)) s
;

fun opt_wpatt (((((((i,_),d),c),p),t),_),def) = WPATT(i,d,c,p,def,t);
fun opt_wcase ((((((_,e),_),t),_),wpl),_) = WCASE(e,t,wpl);

fun seq parser [] = Res([],[])
|   seq parser s =
      case parser s of 
        Fail _ => Res([],s)
      | Res(x,s1) =>
          case seq parser s1 of
            Fail(l1,r1) => Fail(l1,r1)
          | Res(xs,s2) => Res(x::xs,s2)
;

fun PARSER_WPATT s = 
      ((PARSER_ID <&> literal ":" <&> PARSER_DEFCONTEXT <&> 
           (PARSER_CONTEXT modify CON) <&> PARSER_EXP <&> PARSER_TYPE 
            <&> literal "=" <&> PARSER_WDEF modify opt_wpatt)) s
and PARSER_WDEF s =
     ((literal "case" <&> PARSER_EXP <&> literal ":" <&> PARSER_TYPE <&> literal "of" 
        <&> seq PARSER_WPATT <&> literal "end" modify opt_wcase)
     <|> (PARSER_EXP modify WEXPR)) s
;
fun opt_Cdef ((id,_),c) = CDEF (id,c);

fun PARSER_ABBR_CONTEXT s = ((PARSER_ID <&> literal "is" <&> PARSER_DEFCONTEXT) modify opt_Cdef) s;
fun opt_Sdef (((((id,_),s),_),d1),d2) = SDEF (id,s,d1,d2);
fun PARSER_ABBR_SUBST   s = ((PARSER_ID <&> literal "is" <&> PARSER_DEFSUBST <&> literal ":" <&> 
			      PARSER_DEFCONTEXT <&> PARSER_DEFCONTEXT) modify opt_Sdef) s;
fun opt_Edef (((((id,_),e),_),t),c) = EDEF (id,e,t,c);
fun opt_Tdef (((id,_),t),c) = TDEF (id,t,c);

fun PARSER_ABBR s = (
	  PARSER_ABBR_SUBST
      <|> ((PARSER_ID <&> literal "=" <&> PARSER_EXP <&> literal ":" <&> 
            PARSER_TYPE <&> PARSER_DEFCONTEXT) modify opt_Edef)
      <|> ((PARSER_ID <&> literal "=" <&> PARSER_TYPE <&> PARSER_DEFCONTEXT) modify opt_Tdef)
      <|> PARSER_ABBR_CONTEXT) s
;

fun opt_Patt ((p,_),e) = PATT (C_PATT (p,e));

fun opt_case (((((_,e),[]),_),dl),_) = CASE(e,TID "?",dl)
|   opt_case (((((_,e),((_,t)::_)),_),dl),_) = CASE(e,t,dl);
fun opt_onecase ((p,_),d) = (p,d);
fun PARSER_CASE_DEF s = 
           ((literal "case" <&> PARSER_EXP <&> optional (literal ":" <&> PARSER_TYPE)
              <&> literal "of" 
              <&> seq PARSER_DEF_EXP_LIST <&> literal "end" modify opt_case)
        <|> (PARSER_EXP modify EXPR)) s
and PARSER_DEF_EXP_LIST s =
           ((PARSER_EXP  <&> literal "=>" <&> PARSER_CASE_DEF) modify opt_onecase) s
;
fun opt_PattID ((id,_),_) = ID id;

fun PARSER_DEF s = 
          (PARSER_PRIMDEF
      <|> ((PARSER_ID modify opt_ID <&> (sequence "(" "," PARSER_EXP) modify opt_APP <&>
           literal "=" <&> PARSER_CASE_DEF) modify opt_Patt)
      <|> (PARSER_WPATT modify UPATT)
      <|> (PARSER_ABBR modify ABBR)
      <|> ((PARSER_ID <&> literal "(" <&> literal ")" modify opt_PattID) 
           <&> literal "=" <&> PARSER_CASE_DEF modify opt_Patt)) s
;


fun PARSER_DEF_LIST s = seq PARSER_DEF s;

fun convert_abbr (EDEF (name,ce,ct,cDefC)) env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in EDef(name,convert_exp (defcontext_names DefC) env allsymbols ce,
              convert_type DefC env allsymbols ct,DefC,0)
      end
|   convert_abbr (TDEF (name,ct,cDefC)) env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in TDef(name,convert_type DefC env allsymbols ct,DefC,0)
      end
|   convert_abbr (CDEF (name,cDefC)) env =
      CDef(name,fst (convert_DefC cDefC env),0)
|   convert_abbr (SDEF (name,cS,cD1,cD2)) env =
      let val (DefC2,allsymbols) = convert_DefC cD2 env
          val (DefC1,_) = convert_DefC cD1 env
      in SDef(name,convert_DefS (defcontext_names DefC2) cS allsymbols env,DefC1,DefC2,0)
      end
;

fun convert_prim (CTYP (name,ct,cDefC)) env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in CTyp(name,convert_type DefC env allsymbols ct,DefC,0,[])
      end
|   convert_prim (ITYP (name,ct,cDefC)) env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in ITyp(name,convert_type DefC env allsymbols ct,DefC,0,[])
      end
;


fun function_name (APP(ID s,_)) = s
|   function_name (ID s) = s
|   function_name _ = raise Not_allowed_con_pattern
;       (*  'a list -> bool   *)


fun reduce f u nil       = u       (* ('a -> 'b -> 'b) -> 'b -> 'a list -> 'b *)
  | reduce f u (x :: xs) =
       f x (reduce f u xs);
fun flat() = reduce append nil;

fun fixpatternvars (App(f,argl)) =
      let fun fix (Expl(x,_)) = Var x
          |   fix (Impl(x,_)) = Var x
          |   fix (App(f,l)) = App(f,map fix l)
          |   fix e = e
          fun pattvars (Var x) = [x]
          |   pattvars (App(_,argl)) = flat() (map pattvars argl)
          |   pattvars _ = []
          val newpattern = App(f,map fix argl)
      in (pattvars newpattern,newpattern)
      end
|   fixpatternvars (Can(c,l)) = ([],Can(c,l))
|   fixpatternvars (Let(S,Can(c,l))) = ([],Let(S,Can(c,l)))
|   fixpatternvars (Impl(c,l)) = ([],Impl(c,l))
|   fixpatternvars p = raise Not_allowed_pattern p
;

fun names l = map fst l;
fun make_DefC [] = DCon ([],[])
|   make_DefC C = DCon ([GCon C],map fst C);

fun fix_args sym argl namelist =
      let fun fix sym [] name_list newnames = 
                   (newnames @ name_list,map (fn name => Var name) name_list)
          |   fix sym ((a as Var n)::l) (name::nl) newnames = 
                  if sym = n then 
                    let val (newnames',l') = fix sym l nl (name::newnames) 
                    in (newnames',Var (name)::l')
                    end
                  else 
                    let val (newnames',l') = fix sym l nl newnames
                    in (newnames',a::l')
                    end
          |   fix sym (a::l) (name::nl) newnames = 
                    let val (newnames',l') = fix sym l nl newnames
                    in (newnames',a::l')
                    end
          |   fix sym (a::l) [] _ = raise fix_args_error
          val (newnames,newargl) = fix sym (rev argl) (rev namelist) []
       in (newnames,rev newargl)
       end
;
val usym = "_";

				     
    
fun not_used used_names sym (Dep(name,t)) = create sym used_names name
|   not_used used_names sym (Arr t) = create sym used_names "h"
;
    


fun create_names sym 0 _ _ = []
|   create_names sym n (Prod (argt::l,t)) used_names =
      let val new_name = not_used used_names sym argt
      in new_name::create_names sym (n-1) (Prod(l,t)) (new_name::used_names)
      end
|   create_names _ _ _ _  = raise create_names_error
;
fun global_names (Env(_,_,Info(_,names,_,_),_,Back(_,_,deps))) = (map fst names)@(get_YN_names deps);


(* This functions computes the types of free variables in the term, but does 
   NOT garantee type correctness, so this must be checked afterwards! *)
fun patt_context (p as App(c,argl)) C I LI env =
      let val DefC = make_DefC C
          val typc = get_real_type c DefC I env
      in case typc of
           (Prod(typl,t)) => 
            let val argl_len = len argl
            in if len typl = argl_len then   (* arity ok *)
                let val (_,argl') = 
                      fix_args usym argl (create_names usym argl_len typc (I @ (global_names env)))
                    val (ext_C,S,newargl) = get_context argl' typl [] C I env [] LI
                in (ext_C,inst_type (names ext_C) S t,App(c,newargl))
                end
              else raise Impl_arity_mismatch p
            end
           | _ => raise Impl_arity_mismatch p     
      end
|   patt_context (Can(c,l)) C I LI env = (C,get_type_of_prim c env,Can(c,l))
|   patt_context (e as Let(S,Can(c,l))) C I LI env = 
       (C,inst_type I S (get_type_of_prim c env),Let(S,Can(c,l)))
|   patt_context e _ _ _ _ = raise Not_allowed_pattern e
and get_context [] _ S C _ _ argl _ = (C,S,rev argl)
|   get_context (Var x::argl) (Arr t::typl) S C I env newargl LI =
      if mem LI x then raise Local_names_in_pattern (Var x)
      else if mem I x then raise Non_linear_pattern_error (Var x)
      else get_context argl typl S ((x,inst_type I S t)::C) (x::I) env (Var x::newargl) LI
|   get_context (Var x::argl) (Dep(y,t)::typl) S C I env newargl LI =
      if mem LI x then raise Local_names_in_pattern (Var x)
      else if mem I x then raise Non_linear_pattern_error (Var x)
      else let val t' = inst_type I S t
               val S' = (y,Var x)::S
           in get_context argl typl S' ((x,t')::C) (x::I) env (Var x::newargl) LI
           end
|   get_context (Can(c,vl)::argl) (Arr t::typl) S C I env newargl LI =
      get_context argl typl S C I env (Can(c,vl)::newargl) LI
|   get_context ((e as Let(Sc,Can(c,vl)))::argl) (Arr t::typl) S C I env newargl LI =
      get_context argl typl S C I env (e::newargl) LI
|   get_context (Can(c,vl)::argl) (Dep(y,t)::typl) S C I env newargl LI =
      get_context argl typl ((y,Can(c,vl))::S) C I env (Can(c,vl)::newargl) LI
|   get_context ((e as Let(Sc,Can(c,vl)))::argl) (Dep(y,t)::typl) S C I env newargl LI =
       get_context argl typl ((y,e)::S) C I env (e::newargl) LI
|   get_context (App(Can(c,vl),carg)::argl) (Arr t::typl) S C I env newargl LI =
      let val (C',T',arg) = patt_context (App(Can(c,vl),carg)) C I  LI env
          val C'I = names C'
      in get_context argl typl S C' C'I env (arg::newargl) LI
      end  
|   get_context ((e as App(Let(Sc,Can(c,vl)),carg))::argl) (Arr t::typl) S C I env newargl  LI=
      let val (C',T',e') = patt_context e C I LI env
          val C'I = names C'
      in get_context argl typl S C' C'I env (e'::newargl) LI 
      end  
|   get_context ((b as App(Can(c,vl),carg))::argl) (Dep(y,t)::typl) S C I env newargl LI =
      let val (C',T',b') = patt_context (App(Can(c,vl),carg)) C I LI env
          val S' = (y,b')::S
          val C'I = names C'
      in get_context argl typl S' C' C'I env (b'::newargl) LI
      end
|   get_context ((b as App(Let(Sc,Can(c,vl)),carg))::argl) (Dep(y,t)::typl) S C I env newargl LI =
      let val (C',T',b') = patt_context b C I LI env
          val S' = (y,b')::S
          val C'I = names C'
      in get_context argl typl S' C' C'I env (b'::newargl) LI
      end
|   get_context (e::_) _ _ _ _ _ _ _ = raise Not_allowed_pattern e
;
(****************************************************)
(******* FUNCTIONS TO CHECK  DEFINITIONS ************)
(****************************************************)



(*************  functions to check patterns *****************)

fun pattern_context e (Con C) env =
      let val I = names C
          val (C',t,e') = patt_context e [] I I env
      in (Con (rev C'),t,e')
      end
;

fun is_in_the_DefC UN (DCon (C,_)) =
      let fun in_C UN ((CName (name,_))::l) = 
                 if mem UN name then union([name],in_C UN l) else in_C UN l
          |   in_C UN ((GCon ((x,t)::C))::l) = 
                 union(is_in_the_type UN t,in_C (substract x UN) ((GCon C)::l))
          |   in_C UN ((GCon [])::l) = in_C UN l
          |   in_C UN [] = []
      in in_C UN C
      end
;

fun is_in_type_or_DefC UN t DefC =
      union(is_in_the_type UN t,is_in_the_DefC UN DefC)
;  

fun is_in_the_DefS UN (SName name) = if mem UN name then [name] else []
|   is_in_the_DefS UN (GSubst S) = map_union (is_in_the_term UN) (map snd S)
|   is_in_the_DefS UN (Comp(DefS1,DefS2)) =
       union(is_in_the_DefS UN DefS1,is_in_the_DefS UN DefS2)
;

fun is_in_the_USDef UN DefS DefC1 DefC2 =
      union(is_in_the_DefS UN DefS,
            union (is_in_the_DefC UN DefC1,is_in_the_DefC UN DefC2))
;

fun update_define (UEDef(x,Unknown,t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_type_or_DefC UN t DefC
          val newYN = x::YN
          val newDO = (x,[])::DO
          val newDDO = (x,(T,[]))::DDO
      in Deps(DN,CN,newYN,newDO,newDDO)
      end
|   update_define (UEDef(x,D def,t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_type_or_DefC UN t DefC
          val L = is_in_the_term UN def
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = x::CN
              val newDO = (x,union(DL,TL))::DO
              val newDDO = (x,(T,L))::DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
|   update_define (UTDef(x,TUnknown,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val newYN = x::YN
          val newDO = (x,[])::DO
          val newDDO = (x,(T,[]))::DDO
      in Deps(DN,CN,newYN,newDO,newDDO)
      end
|   update_define (UTDef(x,DT t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val L = is_in_the_type UN t
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = x::CN
              val newDO = (x,union(DL,TL))::DO
              val newDDO = (x,(T,L))::DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
|   update_define (UCDef(x,C)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN C
          val UT = retreive_undefined DO T YN
          val newCN = x::CN
          val newDO = (x,UT)::DO
          val newDDO = (x,(T,[]))::DDO
      in Deps(DN,newCN,YN,newDO,newDDO)
      end
|   update_define (USDef(x,DefS,DefC1,DefC2)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_USDef UN DefS DefC1 DefC2
          val UT = retreive_undefined DO T YN
          val newCN = x::CN
          val newDO = (x,UT)::DO
          val newDDO = (x,(T,[]))::DDO
      in Deps(DN,newCN,YN,newDO,newDDO)
      end
  ;

fun add_u_abbr_to_scratch def (Scratch(prims,defs,constr,deps)) =
      Scratch(prims,def::defs,constr,update_define def deps)
;

fun add_u_abbr_to_backtrack def (Back(uprims,defs,deps)) env = 
      Back(uprims,def::defs,update_define def deps)
;

fun add_new_uabbr_info (UEDef(name,e,t,C)) (Info(symbols,names,idlist,hist)) = 
      let val newnames = (name,Exp_Abbr)::names
          val newsymbols = Expl(name,defcontext_names C)::symbols
      in Info(newsymbols,newnames,idlist,hist)
      end
|   add_new_uabbr_info (UTDef(name,t,C)) (Info(symbols,names,idlist,hist)) = 
      Info(symbols,(name,Type_Abbr)::names,idlist,hist)
|   add_new_uabbr_info (USDef(name,S,dc1,dc2)) (Info(symbols,names,idlist,hist)) =
      Info(symbols,(name,Subst_Abbr)::names,idlist,hist)
|   add_new_uabbr_info (UCDef(name,C)) (Info(symbols,names,idlist,hist)) =
      Info(symbols,(name,Context_Abbr)::names,idlist,hist)
;

fun add_u_abbr_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newscratch = add_u_abbr_to_scratch def scratch
          val newbacktrack = add_u_abbr_to_backtrack def backtrack env
          val newinfo = add_new_uabbr_info def info
      in Env(prims,abbrs,newinfo,newscratch,newbacktrack)
      end handle circular_definition => raise Circular_definition (UAbbr def);
fun add_context_as_unknowns DefC ((x,t)::l) env S I = 
      add_context_as_unknowns DefC l (add_u_abbr_to_env 
          (UEDef(x,Unknown,inst_type I S t,DefC)) env)
          ((x,Expl(x,I))::S) I
|   add_context_as_unknowns DefC [] env S _ = (env,S)
;

(*
val S = (x,e1)::S;
val (e1::argl1)=argl1;
val (e2::argl2)=argl2;
val (Dep(x,t)::typl)=typl;
check_conv e1 e2 (inst_type I S t) env C I;

*)


(************ CLEARS SCRATCH DEFINITIONS WHEN DOES UNIFICATION  **********)

fun create_new_scratch DefC (Con C) (Env(prims,abbrs,info,_,_)) =
      let val new_env = Env(prims,abbrs,info,start_scratch,start_back)
      in add_context_as_unknowns DefC C new_env [] (defcontext_names DefC)
      end
;

fun type_computable (Lam _) = false
|   type_computable (App(f,argl)) = on_proper_form f
|   type_computable _ = true
;

fun get_name_and_local_vars (Expl(c,l)) = (c,l)
|   get_name_and_local_vars (Impl(c,l)) = (c,l)
|   get_name_and_local_vars (Can (c,l)) = (c,l)
|   get_name_and_local_vars f = raise Subst_on_non_subst_form f
;

fun isrestricted ((x,_)::vb) varlist = 
      if mem varlist x then isrestricted vb varlist
      else false
|   isrestricted [] _ = true
;

fun on_subst_form (Expl(c,l)) = true
|   on_subst_form (Impl(c,l)) = true
|   on_subst_form (Can (c,l)) = true
|   on_subst_form _ = false
;

(*

val S=(x,e)::S;
val (e::argl)=argl;
val  (Dep(x,t)::l)=l;
type_check e (inst_type I S t) DefC I env;

*)

fun sub_context (Con C) delta I env = 
     let fun sub_cont [] _ _ = Ok []
         |   sub_cont ((x,A)::C) delta env =
               (case (type_conv (type_from_context x delta env) A env delta I) of
                  (Ok cl) => add_constraints cl  (sub_cont C delta env)
                 | notequals => notequals)
     in sub_cont C delta env
     end
 ;

fun  type_check e (T as TExpl(s,l)) DefC I env =
      (case (get_type_def_of s env) of
        TUnknown => 
          if type_computable e then 
             case compute_type e DefC env of
               (Ok cl,et) => add_constraints cl (Ok [TT(T,et,DefC)])
             | (notequals,_) => notequals
          else ET_Noteq (e,T)
      | (DT t) => type_check e t DefC I env)
|   type_check e (T as TLet(vb,s,l)) DefC I env =
      (case (get_type_def_of s env) of
        TUnknown => 
           if type_computable e then 
             case compute_type e DefC env of
               (Ok cl,et) => add_constraints cl (Ok [TT(T,et,DefC)])
             | (notequals,_) => notequals
           else ET_Noteq (e,T)
      | (DT t) => type_check e (inst_type I vb t) DefC I env)
|   type_check (e as Lam(vl,_)) (t as Prod(argl,t')) DefC I env =
      if (len vl) > (len argl) then 
        case t' of
          TExpl(s,l) => 
             (case (get_type_def_of s env) of 
               TUnknown => ET_Noteq (e,t)
             | (DT T) => type_check e (fun_Prod(argl,T)) DefC I env)
        | TLet(vb,s,l) => 
             (case (get_type_def_of s env) of 
               TUnknown => ET_Noteq (e,t)
             | (DT T) => type_check e (inst_type I vb (fun_Prod(argl,T))) DefC I env)
        | _ => raise Lam_with_ground_type (e,t)
      else let val (e',t',C',I') = increase_context e t I []
           in type_check e' t' (add_contexts DefC C') I' env
           end
|   type_check (e as Lam(vl,_)) t _ _ _ = raise Lam_with_ground_type (e,t)
|   type_check (Let(vb,f)) t DefC I env =
      if on_subst_form f then
        let val (c,l) = get_name_and_local_vars f
        in if (isrestricted vb l) then
             (case fits_context vb (get_real_context f env) DefC I env of
               (Ok cl) => 
                add_constraints cl (type_conv (inst_type I vb (gettype f DefC I env)) t env DefC I)
             | notequal => notequal)
          else raise Let_Not_Restricted (Let(vb,f)) 
        end
      else raise Subst_on_non_subst_form f  (* empty context => vb is not restricted *)
|   type_check (e as App(Let(vb,f),argl)) t DefC I env =
      if on_subst_form f then
        let val (c,l) = get_name_and_local_vars f
        in if (isrestricted vb l) then
             (case fits_context vb (get_real_context f env) DefC I env of
                (Ok cl) => 
                   add_constraints cl (type_check_appl (Let(vb,f)) argl t DefC I env)
               | notequals => notequals)
          else raise Let_Not_Restricted (Let(vb,f))
        end
      else raise Subst_on_non_subst_form f  (* empty context => vb is not restricted  *)
|   type_check (App(Expl(c,l),argl)) t DefC I env =
       (case (sub_context (get_real_context (Expl(c,l)) env) DefC I env) of
         (Ok cl) => add_constraints cl (type_check_appl (Expl(c,l)) argl t DefC I env)
       | notequals => raise Not_A_Sub_context (Expl(c,l),DefC))
|   type_check (App(f,argl)) t DefC I env =
      if on_proper_form f then    (* f must be a variable or a constant *)
        if on_subst_form f then
          (case (sub_context (get_real_context f env) DefC I env) of
             (Ok cl) => add_constraints cl (type_check_appl f argl t DefC I env)
          | notequals => raise Not_A_Sub_context (f,DefC))
        else type_check_appl f argl t DefC I env
      else raise Not_on_proper_form f
|   type_check e t DefC I env =   (* Should be check subcontext later... *)
      if on_subst_form e then 
        (case (sub_context (get_real_context e env) DefC I env) of
           (Ok cl) => add_constraints cl (type_conv (gettype e DefC I env) t env DefC I)
         | notequals => raise Not_A_Sub_context (e,DefC))
      else type_conv (gettype e DefC I env) t env DefC I
and type_check_appl f argl t DefC I env =
        let val ftype = get_real_type f DefC I env
        in case ftype of
             (Prod(argt,t')) => 
                if (len argl) > (len argt) then ET_Noteq (App(f,argl),t)  (* arity mismatch *)
                else let val (constraints,S,argt') = type_check_args argl argt DefC I env []
                     in case constraints of
                          (Ok cl) => 
                             add_constraints cl 
                               (type_conv (inst_type I S (fun_Prod (argt',t'))) t env DefC I)
                        | notequal => notequal
                     end
           | TExpl(c,l) => raise Unknown_type_needed_in_appl f
           | _ => ET_Noteq (App(f,argl),t)     (* arity mismatch *)
        end
and type_check_args (e::argl) (Arr t::l) DefC I env S =
      (case (type_check e (inst_type I S t) DefC I env) of
        (Ok cl) => add_S_constraints cl (type_check_args argl l DefC I env S)
      | notequal => (notequal,S,[]))
|   type_check_args (e::argl) (Dep(x,t)::l) DefC I env S =
      (case (type_check e (inst_type I S t) DefC I env) of
         (Ok cl) => add_S_constraints cl (type_check_args argl l DefC I env ((x,e)::S))
      | notequal => (notequal,S,[]))
|   type_check_args [] argt _ _ _ S = (Ok [],S,argt)
|   type_check_args _ _ _ _ _ _ = raise type_check_args_error
and fits_context vb (Con C') DefC I env =
      let fun fits vb ((x,A)::l) I DefC env =
              (case (type_check (component vb x) 
                                (inst_type I vb A) 
                                DefC I env) of
               (Ok cl) => add_constraints cl (fits vb l I DefC env)
               |  notequal => notequal)
          | fits vb [] _ _ _ = Ok []
      in fits vb C' I DefC env
      end
and compute_type (App(f,argl)) DefC env = 
      if on_proper_form f then    (* f must be a variable or a constant *)
        let val I = defcontext_names DefC
            val ftype = get_real_type f DefC I env
        in case ftype of
             (Prod(argt,t')) => 
                if (len argl) > (len argt) then 
                  raise Can't_compute_sort_of (App(f,argl))
                else let val (cl,S,argl') = type_check_args argl argt DefC I env []
                     in (cl,inst_type I S (fun_Prod (argl',t')))
                     end
           | _ => raise Can't_compute_sort_of (App(f,argl))
        end
      else raise Can't_compute_sort_of (App(f,argl))
|   compute_type e DefC env =
      if on_proper_form e then (Ok [],get_real_type e DefC (defcontext_names DefC) env)
      else raise Can't_compute_sort_of e
;                                          (* 'a * 'b -> 'b *)

fun split nil             = (nil, nil)            (* ('a * 'b) list ->        *)
  | split ((x, y) :: xys) =                       (*        'a list * 'b list *)
       let val (xs, ys) = split xys
       in (x :: xs, y :: ys) end;

fun expl_to_var_in_exp _ c env (Expl(c',l)) = if c = c' then (Var c) else Expl(c',l)
|   expl_to_var_in_exp I c env (App(f,argl)) =
      simplereduce I (fun_App(expl_to_var_in_exp I c env f,
                         map (expl_to_var_in_exp I c env) argl))
|   expl_to_var_in_exp I c env (Lam(vb,e)) = 
       if mem vb c then rename_var I c vb e env
       else fun_Lam(vb,expl_to_var_in_exp I c env e)
|   expl_to_var_in_exp I c env (Let(vb,e)) = 
      simplereduce I (fun_Let(expl_to_var_in_sub I c env vb,expl_to_var_in_exp I c env e))
|   expl_to_var_in_exp _ _ _ e = e
and expl_to_var_in_sub I c env vb =
      let val (vars,exps) = split vb
      in zip(vars,map (expl_to_var_in_exp I c env) exps)
      end
and rename_var I c vb e env =
      let val newc = create "" ((c::I) @ global_names env) c  (** sym shouldn't matter ????? **)
          val newvb = map (fn x => if x = c then newc else x) vb
          val newI = newvb @ I
      in Lam(newvb,expl_to_var_in_exp newI c env (inst newI [(c,Var newc)] e))
      end
;

fun expl_to_var_in_D_exp I c env (D def) = D (expl_to_var_in_exp I c env def)
|   expl_to_var_in_D_exp I c env Unknown = Unknown
;

fun dep_names [] = []
|   dep_names ((Arr t)::l) = dep_names l
|   dep_names ((Dep(x,t))::l) = x::dep_names l
;


(* The substitution S is ONLY for renaming of bound variables!!! *)
fun expl_to_var_in_type I c env (Elem (s,e)) = Elem (s,expl_to_var_in_exp I c env e)
|   expl_to_var_in_type I c env (Prod(argt,t)) =
      let val (S,argt') = expl_to_var_in_type_list (dep_names argt@I) c env argt []
      in Prod(argt',expl_to_var_in_type I c env (inst_type I S t))
      end
|   expl_to_var_in_type _ _ _ t = t
and expl_to_var_in_type_list I c env [] S = (S,[])
|   expl_to_var_in_type_list I c env ((Arr t)::l) S =
      let val (S',l') = expl_to_var_in_type_list I c env l S
      in (S',Arr (expl_to_var_in_type I c env (inst_type I S t))::l')
      end
|   expl_to_var_in_type_list I c env ((Dep(x,t))::l) S =
      if c = x then 
        let val c' = create "" (I @ global_names env) c  (** sym sholdn't matter ????? **)
        in expl_to_var_in_type_list (c'::I) c env ((Dep(c',t))::l) ((c,Var c')::S)
        end
      else let val (S',l') = expl_to_var_in_type_list (x::I) c env l S
           in (S',(Dep(x,expl_to_var_in_type I c env (inst_type I S t))::l'))
           end
;

fun expl_to_var_in_DefC c env (DCon (l,I)) = 
      let fun expl_to_var_C I ((x,t)::l) = 
                (x,expl_to_var_in_type I c env t)::expl_to_var_C (x::I) l
          |   expl_to_var_C _ [] = []
          fun unfold I ((CName s)::l) = (CName s)::unfold I l
          |   unfold I ((GCon C)::l) = (GCon (expl_to_var_C I C))::unfold I l
          |   unfold _ [] = []
      in DCon (unfold (c::I) l,I)
      end
;


fun expl_to_var_in_u_abbr c env (UEDef(name,def,t,DefC)) =
      let val I = c::defcontext_names DefC
      in UEDef(name,expl_to_var_in_D_exp I c env def,
                    expl_to_var_in_type I c env t,
                    expl_to_var_in_DefC c env DefC)
      end
|   expl_to_var_in_u_abbr c env (UTDef(name,TUnknown,DefC)) =
      UTDef(name,TUnknown,expl_to_var_in_DefC c env DefC)
|   expl_to_var_in_u_abbr c env (UTDef(name,DT t,DefC)) =
      let val I = c::defcontext_names DefC
      in UTDef(name,DT (expl_to_var_in_type I c env t),
                        expl_to_var_in_DefC c env DefC)
      end
|   expl_to_var_in_u_abbr c env (USDef(name,DefS,DefC1,DefC2)) =
      USDef(name,DefS,
                 expl_to_var_in_DefC c env DefC1,
                 expl_to_var_in_DefC c env DefC2)
|   expl_to_var_in_u_abbr c env (UCDef(name,DefC)) =
      UCDef(name,expl_to_var_in_DefC c env DefC)
;

fun split_definitions ((UEDef(name,Unknown,t,_))::l) context subst env =
      split_definitions (map (expl_to_var_in_u_abbr name env) l) ((name,t)::context) subst env
|   split_definitions ((UEDef(name,D e,t,_))::l) context subst env =
      split_definitions l context ((name,e)::subst) env
|   split_definitions (_::l) context subst env = split_definitions l context subst env
|   split_definitions [] context subst env = (Con (rev context),subst)
;

fun name_of_u_prim (UCTyp(name,_,_,_)) = name
|   name_of_u_prim (UITyp(name,_,_,_)) = name
;

fun okey_recursive_def c env =
      case get_id_kind c env of
        (true,Impl_Kind) => (true,map name_of_u_prim (get_u_prims env))
       | _ => (false,[])
;

fun used_in_def c (Deps(DN,CN,YN,DO,DDO)) =
      let fun find c ((x,(T,E))::l) = if mem E c then x else find c l
          |   find c [] = c
      in find c DDO
      end
;

fun goal_in_def c (Env(_,_,_,_,Back(_,_,deps))) = used_in_def c deps;

    
fun not_circular name e (env as Env(_,_,_,_,Back(_,_,Deps(DN,CN,YN,DO,DDO)))) =
      let val (ok,names) = okey_recursive_def (goal_in_def name env) env
          val L = filter (not o (mem names)) (is_in_the_term (CN @ YN) e)
          val DL = retreive_undefined DO L YN
      in not (mem DL name)
      end
;
    
fun trivial_subst ((x,Var x')::l) = x = x' andalso trivial_subst l
|   trivial_subst [] = true
|   trivial_subst _ = false
;

fun not_type_circular name t (Env(_,_,_,_,Back(_,_,Deps(DN,CN,YN,DO,DDO)))) =
      let val L = is_in_the_type (CN @ YN) t
          val DL = retreive_undefined DO L YN
      in not (mem DL name)
      end
;




fun is_special_var s =
      case explode s of
        ("_"::_) => true
      | _ => false
;
exception Not_An_TExpl of TYP;

fun name_of_TExpl (TExpl(c,l)) = c
|   name_of_TExpl t = raise Not_An_TExpl t
;

fun get_simple_constr ((c as EE(e1,e2,t,C))::l) env =
      let fun remove_trivial_subst (Let(S,Expl(c,l))) = Expl(c,l)
          |   remove_trivial_subst e = e
          fun derived_in_scope (Expl(_,l)) e =   
                let val freevars = get_subset_fidents l e
                in null freevars
                end
          |   derived_in_scope _ _ = true
          fun is_unknown_and_not_circular (e1 as Expl(c,l)) e2 = 
                get_definiens_of c env = Unknown andalso
                not_circular c e2 env andalso derived_in_scope e1 e2
          |   is_unknown_and_not_circular (e1 as Let(S,Expl(c,l))) e2 =
                trivial_subst S andalso
                get_definiens_of c env = Unknown andalso
                not_circular c e2 env andalso derived_in_scope e1 e2
          |   is_unknown_and_not_circular _ _ = false
          fun larger_context (Expl(_,l)) (Expl(_,l')) = len l > len l'
          |   larger_context _ _ = false
      in if is_unknown_and_not_circular e1 e2 then 
           if is_unknown_and_not_circular e2 e1 then
             if is_special_var (name_of_head e2)
               then (true,EE(remove_trivial_subst e2,e1,t,C),l)
               else if larger_context e2 e1 then (true,EE(remove_trivial_subst e2,e1,t,C),l)
                    else (true,EE(remove_trivial_subst e1,e2,t,C),l)
           else (true,EE(remove_trivial_subst e1,e2,t,C),l)
         else if is_unknown_and_not_circular e2 e1 then 
                (true,EE(remove_trivial_subst e2,e1,t,C),l)
              else let val (found,simple,other) = get_simple_constr l env
                   in (found,simple,c::other)
                   end
      end
|   get_simple_constr ((c as TT(t1,t2,C))::l) env =
      let fun remove_trivial_subst_T (TLet(S,c,l)) = TExpl(c,l)
          |   remove_trivial_subst_T t = t
          fun is_unknown_and_not_circular (TExpl(c,l)) t2 = 
                get_type_def_of c env = TUnknown andalso
                not_type_circular c t2 env
          |   is_unknown_and_not_circular (TLet(S,c,l)) t2 =
                trivial_subst S andalso
                get_type_def_of c env = TUnknown andalso
                not_type_circular c t2 env
          |   is_unknown_and_not_circular _ _ = false
          fun larger_context (TExpl(_,l)) (TExpl(_,l')) = len l > len l'
          |   larger_context _ _ = false
      in if is_unknown_and_not_circular t1 t2 then 
           if is_unknown_and_not_circular t2 t1 then
             if is_special_var (name_of_TExpl t2)
               then (true,TT(remove_trivial_subst_T t2,t1,C),l)
             else if larger_context t2 t1 then (true,TT(remove_trivial_subst_T t2,t1,C),l)
                  else (true,TT(remove_trivial_subst_T t1,t2,C),l)
           else (true,TT(remove_trivial_subst_T t1,t2,C),l)
         else if is_unknown_and_not_circular t2 t1 then 
                (true,TT(remove_trivial_subst_T t2,t1,C),l)
              else let val (found,simple,other) = get_simple_constr l env
                   in (found,simple,c::other)
                   end
      end
|   get_simple_constr [] env = (false,TT(Sort "",Sort "",DCon([],[])),[])
;


fun try_find_simple (Scratch(prims,defs,l,deps)) env = 
      let val (isfound,simple,other) = get_simple_constr l env
      in (isfound,simple,Scratch(prims,defs,other,deps))
      end
;

(*
val env = change_scratch newscratch env;
val (scratch as Scratch(_,_,constr,_)) = refine_simple_constr simple newscratch env;
myprint (print_env_constraint constr);
val (exist_simple,simple,newscratch) = try_find_simple scratch env;
myprint(if exist_simple then print_env_constraint [simple] else "STOP");
*)

fun exp_valid_in_context c e env =
     let val I = defcontext_names (get_context_of_def c env)
         val freevars = get_subset_fidents I e
     in (null freevars,freevars)
     end
;

fun unfold_in_exp _ c def (Expl(c',l)) = if c = c' then def else Expl(c',l)
|   unfold_in_exp I c def (App(f,argl)) =
      simplereduce I (fun_App(unfold_in_exp I c def f,map (unfold_in_exp I c def) argl))
|   unfold_in_exp I c def (Lam(vb,e)) = 
       fun_Lam(vb,unfold_in_exp I c def e)
|   unfold_in_exp I c def (Let(vb,e)) = 
      simplereduce I (fun_Let(unfold_in_sub I c def vb,unfold_in_exp I c def e))
|   unfold_in_exp _ _ _ e = e
and unfold_in_sub I c def vb =
      let val (vars,exps) = split vb
      in zip(vars,map (unfold_in_exp I c def) exps)
      end
;
    
fun unfold_in_type I c def (Elem (s,e)) = Elem (s,unfold_in_exp I c def e)
|   unfold_in_type I c def (Prod(argt,t)) =
      let fun sub_arg c def (Dep (x,t')) = Dep(x,unfold_in_type I c def t')
          |   sub_arg c def (Arr t') = Arr (unfold_in_type I c def t')
      in Prod(map (sub_arg c def) argt,unfold_in_type I c def t)
      end
|   unfold_in_type _ _ _ t = t
;

fun unfold_in_DefC c e (DCon (l,I)) = 
      let fun unfold_C ((x,t)::l) = (x,unfold_in_type I c e t)::unfold_C l
          |   unfold_C [] = []
          fun unfold ((CName s)::l) = (CName s)::unfold l
          |   unfold ((GCon C)::l) = (GCon(unfold_C C))::unfold l
          |   unfold [] = []
      in DCon (unfold l,I)
      end
;

fun unfold_in_u_constr c e (UConTyp(name,DT t,DefC)) =
      UConTyp(name,DT (unfold_in_type (defcontext_names DefC) c e t),unfold_in_DefC c e DefC)
|   unfold_in_u_constr c e (UConTyp(name,TUnknown,DefC)) =
      UConTyp(name,TUnknown,unfold_in_DefC c e DefC)
;

fun context_names (Con C) = map fst C;


fun unfold_in_C I c e (Con C) =
      let fun unfold_C I ((x,t)::l) = (x,unfold_in_type I c e t)::unfold_C (x::I) l
          |   unfold_C _ [] = []
      in Con (unfold_C I C)
      end
;
          

fun unfold_in_wpatt c e (WPatt(p,DefC,C,patt,def,t)) =
      let val I = defcontext_names DefC @ context_names C
      in WPatt(p, 
               unfold_in_DefC c e DefC,unfold_in_C I c e C,
               patt, (* contains only variables, _ or constructors *)
               unfold_in_wdef I c e def,unfold_in_type I c e t)
      end
and unfold_in_wdef I c e WUnknown = WUnknown
|   unfold_in_wdef I c e (WExpr def) = WExpr (unfold_in_exp I c e def)
|   unfold_in_wdef I c e (WCase (def,t,wpatts)) =
      WCase(unfold_in_exp I c e def,unfold_in_type I c e t,map (unfold_in_wpatt c e) wpatts)
;

fun unfold_in_u_prim c e (UCTyp(name,DT t,DefC,constrl)) =
      let val I = defcontext_names DefC
      in UCTyp(name,DT (unfold_in_type I c e t),unfold_in_DefC c e DefC,
               map (unfold_in_u_constr c e) constrl)
      end
|   unfold_in_u_prim c e (UCTyp(name,TUnknown,DefC,constrl)) =
      let val I = defcontext_names DefC
      in UCTyp(name,TUnknown,unfold_in_DefC c e DefC,
               map (unfold_in_u_constr c e) constrl)
      end
|   unfold_in_u_prim c e (UITyp(name,DT t,DefC,patts)) =
      let val I = defcontext_names DefC
      in UITyp(name,DT (unfold_in_type I c e t),unfold_in_DefC c e DefC,
               map (unfold_in_wpatt c e) patts)
      end
|   unfold_in_u_prim c e (UITyp(name,TUnknown,DefC,patts)) =
      let val I = defcontext_names DefC
      in UITyp(name,TUnknown,unfold_in_DefC c e DefC,
               map (unfold_in_wpatt c e) patts)
      end
;


fun unfold_in_D_exp I c e (D def) = D (unfold_in_exp I c e def)
|   unfold_in_D_exp I c e Unknown = Unknown
;

fun unfold_in_DefS c e (SName s) _ = SName s
|   unfold_in_DefS c e (GSubst S) I = GSubst (unfold_in_sub I c e S)
|   unfold_in_DefS c e (Comp (DefS1,DefS2)) I =
      Comp (unfold_in_DefS c e DefS1 I,unfold_in_DefS c e DefS2 I)
;

fun unfold_in_u_abbr c e (UEDef(name,def,t,DefC)) =
      let val I = defcontext_names DefC
      in UEDef(name,unfold_in_D_exp I c e def,unfold_in_type I c e t,unfold_in_DefC c e DefC)
      end
|   unfold_in_u_abbr c e (UTDef(name,DT t,DefC)) =
      let val I = defcontext_names DefC
      in UTDef(name,DT (unfold_in_type I c e t),unfold_in_DefC c e DefC)
      end
|   unfold_in_u_abbr c e (UTDef(name,TUnknown,DefC)) =
      let val I = defcontext_names DefC
      in UTDef(name,TUnknown,unfold_in_DefC c e DefC)
      end
|   unfold_in_u_abbr c e (USDef(name,DefS,DefC1,DefC2)) =
      USDef(name,unfold_in_DefS c e DefS (defcontext_names DefC2),
            unfold_in_DefC c e DefC1,unfold_in_DefC c e DefC2)
|   unfold_in_u_abbr c e (UCDef(name,DefC)) =
      UCDef(name,unfold_in_DefC c e DefC)
;
      

fun change_unknown name e ((def as UEDef(name',Unknown,t,DefC))::l) =
      if name = name' then (UEDef(name,D e,t,DefC))::l
      else def::change_unknown name e l
|   change_unknown name e (def::l) = def::change_unknown name e l
|   change_unknown name _ [] = raise look_up_abbr_error name
;

fun remove_and_unfold_in_prims c e (def::l) =
      if c = name_of_u_prim def then remove_and_unfold_in_prims c e l
      else (unfold_in_u_prim c e def)::remove_and_unfold_in_prims c e l
|   remove_and_unfold_in_prims _ _ [] = []
;

fun name_of_u_abbr (UTDef(name,_,_)) = name
|   name_of_u_abbr (UEDef(name,_,_,_)) = name
|   name_of_u_abbr (UCDef(name,_)) = name
|   name_of_u_abbr (USDef(name,_,_,_)) = name
;

fun remove_and_unfold_in_abbrs c e (def::l) =
      if c = name_of_u_abbr def then remove_and_unfold_in_abbrs c e l
      else (unfold_in_u_abbr c e def)::remove_and_unfold_in_abbrs c e l
|   remove_and_unfold_in_abbrs _ _ [] = []
;   

fun unfold_in_constr c e l =
     let fun unfold c e (EE(e1,e2,t,DefC)::l) = 
            let val I = defcontext_names DefC
            in (EE(unfold_in_exp I c e e1,unfold_in_exp I c e e2,
                unfold_in_type I c e t,unfold_in_DefC c e DefC))::unfold c e l
            end
         |   unfold c e (TT(t1,t2,DefC)::l) = 
            let val I = defcontext_names DefC
            in (TT(unfold_in_type I c e t1,unfold_in_type I c e t2,
                unfold_in_DefC c e DefC))::unfold c e l
            end
         |   unfold _ _ [] = []
     in unfold c e l
     end
;

fun term_depends_on name ((x,(T,E))::l) =
      if name = x then E else term_depends_on name l
|   term_depends_on name [] = []
;

fun remove_and_change_DO_list x DL ((y,L)::l) =
      if x = y then remove_and_change_DO_list x DL l
      else (y,change_to DL x L)::remove_and_change_DO_list x DL l
|   remove_and_change_DO_list x DL [] = []
;

fun remove_and_change_DDO_list x L ((y,(T,E))::l) = 
      if x = y then remove_and_change_DDO_list x L l
      else (y,(change_to L x T,change_to L x E))::remove_and_change_DDO_list x L l
|   remove_and_change_DDO_list x L [] = []
;

(* This is only done in the scratch, since unfold in scratch *)
(* means update_refine in backtrack *)

fun update_unfold x (Deps(VN,CN,YN,DO,DDO)) =
      let val L = term_depends_on x DDO
          val DL = retreive_undefined DO L YN
          val newYN = substract x YN
          val newCN = substract x CN   (* if defining first, unfolding after *)
          val newDO = remove_and_change_DO_list x DL DO
          val newDDO = remove_and_change_DDO_list x L DDO
      in Deps(VN,newCN,newYN,newDO,newDDO)
      end
;


fun update_unknown_in_scratch c e recursion_allowed (Scratch(prims,defs,constr,deps)) = 
    if is_special_var c then 
           Scratch(map (unfold_in_u_prim c e) prims,
                   map (unfold_in_u_abbr c e) (change_unknown c e defs),unfold_in_constr c e constr,
                   update_refine c e recursion_allowed deps)
    else if visible_name c then 
           Scratch(prims,change_unknown c e defs,unfold_in_constr c e constr,
                   update_refine c e recursion_allowed deps)
         else Scratch(remove_and_unfold_in_prims c e prims,
                      remove_and_unfold_in_abbrs c e defs,unfold_in_constr c e constr,
                      update_unfold c (update_refine c e recursion_allowed deps))
;


fun get_subset_fidents_type S (Sort s) = []
 |  get_subset_fidents_type S (Elem (s,e)) = get_subset_fidents S e
 |  get_subset_fidents_type S (TExpl(c,l)) = get_subset l S
 |  get_subset_fidents_type S (TLet(vb,c,l)) =
      union(get_subset l (S@(map fst vb)),
            map_union (get_subset_fidents S) (map snd vb))
 |  get_subset_fidents_type S (Prod(Dep(x,t)::l,t'))  = 
      union(get_subset_fidents_type S t,
            get_subset_fidents_type (x::S) (Prod(l,t')))
 |  get_subset_fidents_type S (Prod(Arr t::l,t'))  = 
      union(get_subset_fidents_type S t,
            get_subset_fidents_type S (Prod(l,t')))
 |  get_subset_fidents_type S (Prod([],t'))  = 
      get_subset_fidents_type S t'
;

fun type_valid_in_context c t env =
     let val I = defcontext_names (get_context_of_def c env)
         val freevars = get_subset_fidents_type I t
     in (null freevars,freevars)
     end
;

(* This ONLY refines the constraint by constraint, as far as possible *)
fun refine_constraints (EE(e1,e2,t,DefC)::l) env = 
      (case check_conv e1 e2 t env DefC (defcontext_names DefC) of
         (Ok cl) =>  cl @ (refine_constraints l env) 
      | notequals => raise Not_Correct_Refinement notequals)
|   refine_constraints (TT(t1,t2,DefC)::l) env = 
      (case type_conv t1 t2 env DefC (defcontext_names DefC) of
         (Ok cl) =>  cl @ (refine_constraints l env) 
      | notequals => raise Not_Correct_Refinement notequals)
|   refine_constraints [] _ = []
;


fun refine_constr_in_scratch (Scratch(prims,defs,constr,deps)) env =
      Scratch(prims,defs,refine_constraints constr env,deps)
;

fun change_Tunknown name t ((def as UTDef(name',TUnknown,DefC))::l) =
      if name = name' then (UTDef(name,DT t,DefC))::l
      else def::change_Tunknown name t l
|   change_Tunknown name t (def::l) = def::change_Tunknown name t l
|   change_Tunknown name _ [] = raise look_up_abbr_error name
;

fun Tunfold_in_type I c def (TExpl(c',l)) = if c = c' then def else TExpl(c',l)
|   Tunfold_in_type I c def (TLet(vb,c',l)) = 
      if c = c' then (inst_type I vb def) else TExpl(c',l)
|   Tunfold_in_type I c def (Prod(argt,t)) =
      let fun sub_arg c def (Dep (x,t')) = Dep(x,Tunfold_in_type I c def t')
          |   sub_arg c def (Arr t') = Arr (Tunfold_in_type I c def t')
      in fun_Prod(map (sub_arg c def) argt,Tunfold_in_type I c def t)
      end
|   Tunfold_in_type _ _ _ t = t
;

fun Tunfold_in_DefC c T (DCon (l,I)) = 
      let fun unfold_C ((x,t)::l) = (x,Tunfold_in_type I c T t)::unfold_C l
          |   unfold_C [] = []
          fun unfold ((CName s)::l) = (CName s)::unfold l
          |   unfold ((GCon C)::l) = (GCon(unfold_C C))::unfold l
          |   unfold [] = []
      in DCon (unfold l,I)
      end
;

fun Tunfold_in_u_constr c T (UConTyp(name,DT t,DefC)) =
      UConTyp(name,DT (Tunfold_in_type (defcontext_names DefC) c T t),Tunfold_in_DefC c T DefC)
|   Tunfold_in_u_constr c T (UConTyp(name,TUnknown,DefC)) =
      UConTyp(name,TUnknown,Tunfold_in_DefC c T DefC)
;

fun Tunfold_in_C I c T (Con C) =
      let fun unfold_C I ((x,t)::l) = (x,Tunfold_in_type I c T t)::unfold_C (x::I) l
          |   unfold_C _ [] = []
      in Con (unfold_C I C)
      end
;
          

fun Tunfold_in_wpatt c T (WPatt(p,DefC,C,e,wdef,t)) =
      let val I = defcontext_names DefC @ context_names C
      in WPatt(p,Tunfold_in_DefC c T DefC,Tunfold_in_C I c T C,e,
               Tunfold_in_wdef I c T wdef,Tunfold_in_type I c T t)
      end
and Tunfold_in_wdef I c T WUnknown = WUnknown
|   Tunfold_in_wdef I c T (WExpr e) = WExpr e   (* expr dosn't contain types *)
|   Tunfold_in_wdef I c T (WCase (e,t,wpatts)) =
      WCase(e,Tunfold_in_type I c T t,map (Tunfold_in_wpatt c T) wpatts)
;

fun Tunfold_in_u_prim c T (UCTyp(name,DT t,DefC,constrl)) =
      let val I = defcontext_names DefC
      in UCTyp(name,DT (Tunfold_in_type I c T t),Tunfold_in_DefC c T DefC,
               map (Tunfold_in_u_constr c T) constrl)
      end
|   Tunfold_in_u_prim c T (UCTyp(name,TUnknown,DefC,constrl)) =
      let val I = defcontext_names DefC
      in UCTyp(name,TUnknown,Tunfold_in_DefC c T DefC,
               map (Tunfold_in_u_constr c T) constrl)
      end
|   Tunfold_in_u_prim c T (UITyp(name,DT t,DefC,patts)) =
      let val I = defcontext_names DefC
      in UITyp(name,DT (Tunfold_in_type I c T t),Tunfold_in_DefC c T DefC,
               map (Tunfold_in_wpatt c T) patts)
      end
|   Tunfold_in_u_prim c T (UITyp(name,TUnknown,DefC,patts)) =
      let val I = defcontext_names DefC
      in UITyp(name,TUnknown,Tunfold_in_DefC c T DefC,
               map (Tunfold_in_wpatt c T) patts)
      end
;


fun remove_and_Tunfold_in_prims c T (def::l) =
      if c = name_of_u_prim def then remove_and_Tunfold_in_prims c T l
      else (Tunfold_in_u_prim c T def)::remove_and_Tunfold_in_prims c T l
|   remove_and_Tunfold_in_prims _ _ [] = []
;

fun Tunfold_in_u_abbr c T (UEDef(name,def,t,DefC)) =
      let val I = defcontext_names DefC
      in UEDef(name,def,Tunfold_in_type I c T t,Tunfold_in_DefC c T DefC)
      end
|   Tunfold_in_u_abbr c T (UTDef(name,DT t,DefC)) =
      let val I = defcontext_names DefC
      in UTDef(name,DT (Tunfold_in_type I c T t),Tunfold_in_DefC c T DefC)
      end
|   Tunfold_in_u_abbr c T (UTDef(name,TUnknown,DefC)) =
      let val I = defcontext_names DefC
      in UTDef(name,TUnknown,Tunfold_in_DefC c T DefC)
      end
|   Tunfold_in_u_abbr c T (USDef(name,DefS,DefC1,DefC2)) =
      USDef(name,DefS,
            Tunfold_in_DefC c T DefC1,Tunfold_in_DefC c T DefC2)
|   Tunfold_in_u_abbr c T (UCDef(name,DefC)) =
      UCDef(name,Tunfold_in_DefC c T DefC)
;

fun remove_and_Tunfold_in_abbrs c T (def::l) =
      if c = name_of_u_abbr def then remove_and_Tunfold_in_abbrs c T l
      else (Tunfold_in_u_abbr c T def)::remove_and_Tunfold_in_abbrs c T l
|   remove_and_Tunfold_in_abbrs _ _ [] = []
;

fun Tunfold_in_constr c t (EE(e1,e2,T,DefC)::l) = 
      let val I = defcontext_names DefC
      in (EE(e1,e2,Tunfold_in_type I c t T,
             Tunfold_in_DefC c t DefC))::Tunfold_in_constr c t l
      end
|   Tunfold_in_constr c t (TT(t1,t2,DefC)::l) = 
      let val I = defcontext_names DefC
      in (TT(Tunfold_in_type I c t t1,Tunfold_in_type I c t t2,
             Tunfold_in_DefC c t DefC))::Tunfold_in_constr c t l
      end
|   Tunfold_in_constr _ _ [] = []
;

fun Tupdate_unfold x t (Deps(VN,CN,YN,DO,DDO)) =
      let val L = is_in_the_type (CN @ YN) t
          val DL = retreive_undefined DO L YN
          val newYN = substract x YN
          val newCN = substract x CN   (* if defining first, unfolding after *)
          val newDO = remove_and_change_DO_list x DL DO
          val newDDO = remove_and_change_DDO_list x L DDO
      in Deps(VN,newCN,newYN,newDO,newDDO)
      end
;

fun update_Tunknown_in_scratch c t (Scratch(prims,defs,constr,deps)) = 
      if visible_name c then 
        Scratch(prims,
                change_Tunknown c t defs,Tunfold_in_constr c t constr,
                Tupdate_refine c t deps)
      else Scratch(remove_and_Tunfold_in_prims c t prims,
                   remove_and_Tunfold_in_abbrs c t defs,Tunfold_in_constr c t constr,
                   Tupdate_unfold c t deps)
;


fun unify_simple_constr (EE(Expl(c,l),e,_,_)) scratch env =
      let val (valid,freevars) = exp_valid_in_context c e env
      in if valid then                                              (* not allowed to be recursive *)
            refine_constr_in_scratch (update_unknown_in_scratch c e (false,[]) scratch) env
         else raise Refine_exp_free_Vars (c,e,freevars)
      end
|   unify_simple_constr (TT(TExpl(c,l),t,_)) scratch env =
      let val (valid,freevars) = type_valid_in_context c t env
      in if valid then 
           refine_constr_in_scratch (update_Tunknown_in_scratch c t scratch) env
         else raise Refine_type_free_Vars (c,t,freevars)
      end
|   unify_simple_constr constr _ _ = raise Not_A_Simple_Constraint constr
;


fun unify_constraints scratch env allsimple =
      let val (exist_simple,simple,newscratch) = try_find_simple scratch env
      in if exist_simple then 
              unify_constraints (unify_simple_constr simple newscratch env) 
                env (simple::allsimple)
         else (refine_constr_in_scratch scratch env,allsimple)
      end
;

fun add_constr l (Scratch(prims,defs,l',deps)) = 
      Scratch(prims,defs,l@l',deps);
    
fun remove_UAbbr [] = []
|   remove_UAbbr ((UAbbr def)::l) = def::remove_UAbbr l
|   remove_UAbbr (_::l) = remove_UAbbr l
;

datatype 'a SEARCH = Found of 'a | NotFound;

fun find_one_u_abbr name (def::rest) =
      if name = name_of_u_abbr def then Found(UAbbr def,rest)
      else (case find_one_u_abbr name rest of
             Found(def',rest') => Found(def',def::rest')
           | NotFound => NotFound)
|   find_one_u_abbr name [] = NotFound
;

fun find_one_u_prim name ((d as UCTyp(name',t,C,cl))::rest) =
      if name = name' then Found(UPrim (UCTyp(name,t,C,[])),rest,map (fn d => UConstr (name,d)) cl)
      else (case find_one_u_prim name rest of
            Found(def',rest',others) => Found(def',d::rest',others)
           | NotFound => NotFound)
|   find_one_u_prim name ((d as UITyp(name',t,C,pl))::rest) =
      if name = name' then Found(UPrim (UITyp(name',t,C,[])),rest,map (fn d => UPatt d) pl)
      else (case find_one_u_prim name rest of
            Found(def',rest',others) => Found(def',d::rest',others)
           | NotFound => NotFound)
|   find_one_u_prim name [] = NotFound
;

fun find_one_u_constr name ((d as UConstr(setname,UConTyp(name',_,_)))::l) =
      if name = name' then Found(d,l)
      else (case find_one_u_constr name l of
             Found(def,rest) => Found(def,d::rest)
           | NotFound => NotFound)
|   find_one_u_constr name (d::l) = (* The patterns are here as well *)
      (case find_one_u_constr name l of
         Found(def,rest) => Found(def,d::rest)
       | NotFound => NotFound)
|   find_one_u_constr name [] = NotFound
;

fun find_one_u_def name abbrs prims others =
      case find_one_u_abbr name abbrs of
        Found(def,rest) => (def,rest,prims,others)
      | NotFound => (case find_one_u_prim name prims of
                      Found(def,rest,others') => (def,abbrs,rest,others'@others)
                    | NotFound => (case find_one_u_constr name others of
                                    Found(def,rest) => (def,abbrs,prims,rest)
                                  | NotFound => raise print_in_order_error))
;

fun push_down name aftername (a::l) = 
      if a = aftername then a::name::l
      else a::push_down name aftername l
|   push_down name aftername [] = []
;

fun get_sorted_order (name::l) u_abbr u_prims others =
      let val (def,arest,prest,orest) = find_one_u_def name u_abbr u_prims others
      in case def of 
           (UConstr(setname,_)) => 
              if mem l setname then get_sorted_order (push_down name setname l) u_abbr u_prims others
              else def::get_sorted_order l arest prest orest
         | _ => def::get_sorted_order l arest prest orest
      end
|   get_sorted_order [] [] [] wpatts = rev wpatts
|   get_sorted_order _ _ _ _ = raise print_in_order_error
;

fun topo_sort [] _ = []
|   topo_sort l set_and_impl_names =
      let fun divide [] (ok,rest) = (ok,rest)
          |   divide ((x,([],[]))::l) (ok,rest) = divide l (x::ok,rest)
          |   divide ((x,(T,E))::l) (ok,rest) = divide l (ok,(x,(T,E))::rest)
          fun rec_divide [] (ok,rest) = (ok,rest)
          |   rec_divide ((x,([],E))::l) (ok,rest) = 
                if mem set_and_impl_names x then rec_divide l (x::ok,rest)
                else rec_divide l (ok,(x,([],E))::rest)
          |   rec_divide ((x,(T,E))::l) (ok,rest) = rec_divide l (ok,(x,(T,E))::rest)
          fun remove l l' = filter (not o (mem l)) l'
          fun remove_all ok ((x,(T,E))::l) = (x,(remove (x::ok) T,remove (x::ok) E))::remove_all ok l
          |   remove_all _ [] = []
          val (first,rest) = divide l ([],[])
      in if first = [] then
           let val (first,rest) = rec_divide l ([],[])
           in if first = [] then raise Dependency_graph_mismatch
              else first @ topo_sort (remove_all first rest) set_and_impl_names
           end
         else first @ topo_sort (remove_all first rest) set_and_impl_names
      end
  ;

(*
val l = remove_all first rest;
val (first,rest) = divide l ([],[]);
*)
  
fun topologic_sort (Deps(DN,CN,YN,DO,DDO)) set_and_impl_names =
      topo_sort (rev DDO) set_and_impl_names;

fun sort_abbrs_in_order u_abbr deps impl_and_set_names = 
        remove_UAbbr (get_sorted_order (topologic_sort deps impl_and_set_names) u_abbr [] []);

fun any_mem ll (a::l) = if mem ll a then true else any_mem ll l
|   any_mem ll [] = false
    ;
    
fun find_list name ((name',(T,L))::l) =
     if name = name' then (union(T,L)) else find_list name l
|   find_list name [] = []
;(**********************************************************)
(***** SUBSTITUTION OF DEFINITIONS IN THE ENVIRONMENT *****)
(*******          IN THE SCRATCH AREA               *******)
(**********************************************************)

fun divide_defs ((prim as (UCTyp(name,_,_,_)))::l) abbrs DDO CN =
       let val (unknowns,completes,prest,arest) = divide_defs l abbrs DDO CN
           val deplist = find_list name DDO
       in case deplist of
            [] => (unknowns,UPrim prim::completes,prest,arest)
          | dl => if any_mem CN dl then (unknowns,completes,prim::prest,arest)
                  else (unknowns,UPrim prim::completes,prest,arest)
       end
|   divide_defs ((prim as (UITyp(name,_,_,_)))::l) abbrs DDO CN =
       let val (unknowns,completes,prest,arest) = divide_defs l abbrs DDO CN
           val deplist = find_list name DDO
       in case deplist of
            [] => (unknowns,UPrim prim::completes,prest,arest)
          | dl => if any_mem CN dl then (unknowns,completes,prim::prest,arest)
                  else (unknowns,UPrim prim::completes,prest,arest)
       end
|   divide_defs [] ((edef as (UEDef(name,D def,_,_)))::l) DDO CN =
       let val (unknowns,completes,prest,arest) = divide_defs [] l DDO CN
           val deplist = find_list name DDO
       in case deplist of
            [] => (unknowns,UAbbr edef::completes,prest,arest)
          | dl => if any_mem CN dl then (unknowns,completes,prest,edef::arest)
                  else (unknowns,UAbbr edef::completes,prest,arest)
       end
|   divide_defs [] ((edef as (UEDef(name,Unknown,_,_)))::l) DDO CN =
      let val (unknowns,completes,prest,arest) = divide_defs [] l DDO CN
          val deplist = find_list name DDO
      in case deplist of
           [] => (edef::unknowns,completes,prest,arest)
         | dl => if any_mem CN dl then (unknowns,completes,prest,edef::arest)
                  else (edef::unknowns,completes,prest,arest)
      end
|   divide_defs [] ((tdef as (UTDef(name,DT def,_)))::l) DDO CN =
       let val (unknowns,completes,prest,arest) = divide_defs [] l DDO CN
           val deplist = find_list name DDO
       in case deplist of
            [] => (unknowns,UAbbr tdef::completes,prest,arest)
          | dl => if any_mem CN dl then (unknowns,completes,prest,tdef::arest)
                  else (unknowns,UAbbr tdef::completes,prest,arest)
       end
|   divide_defs [] ((tdef as (UTDef(name,TUnknown,_)))::l) DDO CN =
      let val (unknowns,completes,prest,arest) = divide_defs [] l DDO CN
          val deplist = find_list name DDO
      in case deplist of
           [] => (tdef::unknowns,completes,prest,arest)
         | dl => if any_mem CN dl then (unknowns,completes,prest,tdef::arest)
                  else (tdef::unknowns,completes,prest,arest)
      end
|   divide_defs [] (udef::l) DDO CN  =
       let val (unknowns,completes,prest,arest) = divide_defs [] l DDO CN
           val deplist = find_list (name_of_u_abbr udef) DDO
       in case deplist of
            [] => (unknowns,UAbbr udef::completes,prest,arest)
          | dl => (unknowns,completes,prest,udef::arest)
       end
|   divide_defs [] [] _ _ = ([],[],[],[])
;

fun unfold_and_keep_prims_list (UAbbr (UEDef(c,D e,_,_))::l) deflist =
      unfold_and_keep_prims_list l (map (unfold_in_u_prim c e) deflist)
|   unfold_and_keep_prims_list (UAbbr (UTDef(c,DT t,_))::l) deflist =
      unfold_and_keep_prims_list l (map (Tunfold_in_u_prim c t) deflist)
|   unfold_and_keep_prims_list  (_::l) deflist =
      unfold_and_keep_prims_list l deflist
|   unfold_and_keep_prims_list [] deflist = deflist
;

(*	
fun unfold_and_keep ((def as UEDef(c,D e,_,_))::l) deflist =
      unfold_and_keep l (map (unfold_in_u_abbr c e) deflist)
|   unfold_and_keep (_::l) deflist = unfold_and_keep l deflist
|   unfold_and_keep [] deflist = deflist
;
*)

fun unfold_and_keep_abbrs_list (UAbbr (UEDef(c,D e,_,_))::l) deflist =
      unfold_and_keep_abbrs_list l (map (unfold_in_u_abbr c e) deflist)
|   unfold_and_keep_abbrs_list (UAbbr (UTDef(c,DT t,_))::l) deflist =
      unfold_and_keep_abbrs_list l (map (Tunfold_in_u_abbr c t) deflist)
|   unfold_and_keep_abbrs_list  (_::l) deflist =
      unfold_and_keep_abbrs_list l deflist
|   unfold_and_keep_abbrs_list [] deflist = deflist
;
	
fun remove_defs (x::l) deps = 
      remove_defs l (update_delete x deps)
|   remove_defs [] deps = deps
;

fun defnames (UTDef(name,_,_)::l) = name::defnames l
|   defnames (UEDef(name,_,_,_)::l) = name::defnames l
|   defnames (UCDef(name,_)::l) = name::defnames l
|   defnames (USDef(name,_,_,_)::l) = name::defnames l
|   defnames [] = []
;

fun name_of_prim (CTyp(name,_,_,_,_)) = name
|   name_of_prim (ITyp(name,_,_,_,_)) = name
;

fun name_of_u_constr (UConTyp(name,_,_)) = name;



(******* looking up functions ********)
fun name_of_env_kind (Prim d) = name_of_prim d
|   name_of_env_kind (UPrim d) = name_of_u_prim d
|   name_of_env_kind (Abbr d) = name_of_abbr d
|   name_of_env_kind (UAbbr d) = name_of_u_abbr d
|   name_of_env_kind (Constr(_,d)) = name_of_constr d
|   name_of_env_kind (UConstr(_,d)) = name_of_u_constr d
|   name_of_env_kind _ = raise path_error
;

fun unfold_and_keep_definitions newdefs [] [] _ = newdefs
|   unfold_and_keep_definitions newdefs prims abbrs (deps as Deps(DN,CN,YN,DO,DDO)) =
      let val (unknowns,completes,prest,arest) = divide_defs prims abbrs DDO CN
      in unfold_and_keep_definitions (newdefs @ (map UAbbr unknowns) @ completes) 
           (unfold_and_keep_prims_list completes prest)
           (unfold_and_keep_abbrs_list completes arest) 
           (remove_defs (defnames unknowns @ (map name_of_env_kind completes)) deps)
      end
;

fun add_constraint_and_refine cl env =
     let val ((S as Scratch(prims,defs,constr,deps)),_) = 
          unify_constraints (add_constr (refine_constraints cl env) (get_scratch env)) env []
          handle Not_Correct_Refinement notequals => raise Impossible_unification notequals
     in case constr of
         [] => sort_abbrs_in_order (remove_UAbbr (unfold_and_keep_definitions [] [] defs deps)) 
                                    deps (map name_of_u_prim prims)
       | cl => raise Nontrivial_unification cl
     end
;

fun no_special_vars_in_context [] = true
|   no_special_vars_in_context ((x,_)::C) =
      not (is_special_var x) andalso no_special_vars_in_context C
;

fun only_special_vars [] = true
|   only_special_vars (a::l) = is_special_var a andalso only_special_vars l
;

fun is_in_the_def l (Expr e) = is_in_the_term l e
|   is_in_the_def l (Case(e,t,dl)) = 
       union(is_in_the_term l e,union(is_in_the_type l t,map_union (fn (e,d) => is_in_the_def l d) dl))
;

(* don't need to check t and C, since if the pattern is from the theory only, the type *)
(* of the implicit constant must be as well, and therefore the type and therefore the *)
(* context *)
fun is_patt (IDef(patt,def,_,_,_)) (Deps(DN,CN,YN,DO,DDO)) =   
      let val UN = YN @ CN
      in null (is_in_the_term UN patt) andalso null (is_in_the_def UN def)
      end
;
fun iscomplete_patt d env = is_patt d (get_deps env);

fun get_subset_free_idents S e t =
      union(get_subset_fidents S e,get_subset_fidents_type S t)
      ;


fun Type_Check e t DefC env =
      let val I = defcontext_names DefC
          val not_in_context = get_subset_free_idents I e t
      in case not_in_context of
           [] => type_check e t DefC I env
         | l => raise free_variable_not_in_context l
      end
;


fun unification DefC C u v A env = 
      let val (new_env,S) = create_new_scratch DefC C env
          val I = defcontext_names DefC @ context_names C
          val constr = [EE(inst I S u,inst I S v,inst_type I S A,DefC)]
      in split_definitions (add_constraint_and_refine constr new_env) [] [] env
      end
;

fun inst_and_rem_context  (x,e) (Con C) I =
      let fun instC [] = []
          |   instC ((y,t)::l) = (y,inst_type I [(x,e)] t)::instC l
          fun remove [] = []
          |   remove ((y,t)::l) = if x = y then instC l
                                  else (y,t)::remove l
      in Con(remove C)
      end
;

fun type_check_def DefC (Con C) T (Expr e) env = 
      let val DefC' = add_contexts DefC C
      in type_check e T DefC' (defcontext_names DefC') env
      end
|   type_check_def DefC (Con C) T (Case (v,vtype,expl)) env =
       case (unfold_type vtype env)  of 
           (Elem(s,A)) => type_check_case_list DefC (Con C) v A T env expl
         | t => raise Not_elem_type t
and type_check_case_list DefC C v A T env [] = Ok []
|   type_check_case_list DefC (Con C) v A T env ((p,def)::l) =
      let val DefC' = add_contexts DefC C
          val (Con C1',t,newp) = pattern_context p (unfold_defcontext DefC' env) env
           val (new_env,S) = create_new_scratch DefC (Con C1') env
           val I = defcontext_names DefC
           val newpattern = inst I S newp
           val newt = inst_type I S t
           val constr = type_check newpattern newt DefC' I new_env
       in case constr of
            (Ok cl) => 
              let val (Con C',subst) = 
                     split_definitions (add_constraint_and_refine cl new_env) [] [] new_env
                  val I' = defcontext_names DefC @ (map fst C')
              in  case (inst_type I' subst t) of
                          (Elem(s,B)) =>
                              let val (newC,S) = unification DefC (Con (C@C')) B A (Sort "Set") env
                                  val I = defcontext_names DefC @ context_names newC
                                  val newT = inst_type I S T 
                                  val instP = inst I S newp   
                              in case v of
                                    (Var z) => (case type_check_def DefC (inst_and_rem_context (z,instP) newC I)
                                                       (inst_type I [(z,instP)] newT) def env of
                                                 (*??????      (inst_case_def I [(z,instP)] def) env of ****)
                                                 (Ok []) => type_check_case_list DefC (Con C) v A T env l
                                               | constr => constr) (* will be raised when returned *)
                                   | _ => (case type_check_def DefC newC newT def env of
                                                  (*?????      (inst_case_def I S def) env of *****)
                                            (Ok []) => type_check_case_list DefC (Con C) v A T env l
                                          | constr => constr)   (* will be raised when returned *)
                             end
                        | t => raise Not_elem_type t
              end
          | notequals => notequals
       end
;



fun ok_patt_def (d as IDef(App(f,argl),def,t,C,id)) DefC env = 
     if iscomplete_patt d env then
       let val (new_env,S) = create_new_scratch DefC C env
           val I = defcontext_names DefC
           val newpattern = inst I S (App(f,argl))
           val newt = inst_type I S t
           val constr = type_check newpattern newt DefC I new_env
       in case constr of
            (Ok cl) => 
              let val (Con C',subst) = 
                     split_definitions (add_constraint_and_refine cl new_env) [] [] new_env
                  val I' = defcontext_names DefC @ (map fst C')
              in if no_special_vars_in_context C' andalso
                    only_special_vars (map fst subst)
                 then case type_check_def DefC (Con C') (inst_type I' subst t) def env of
                                       (*???????????  (inst_case_def I' subst def) env of ********)
                    (Ok []) => (C',inst_type I' subst t)
                   | cl => raise Constraints_in_theory (cl,Patt d)
                 else raise Underscore_in_pattern_not_ok (App(f,argl))
             end
           | constr => raise Constraints_in_theory (constr,Patt d)
       end
     else raise Incomplete_in_theory (Patt d)
|   ok_patt_def (d as IDef(Impl(c,l),def,t,C,id)) DefC env = 
     if iscomplete_patt d env then
       case Type_Check (Impl(c,l)) t DefC env of
         (Ok []) => (case type_check_def DefC (Con []) t def env of
                       (Ok []) => ([],t)
                     | cl  => raise Constraints_in_theory (cl,Patt d))
        | cl => raise Constraints_in_theory (cl,Patt d)
     else raise Incomplete_in_theory (Patt d)
|   ok_patt_def (IDef(e,_,_,_,_)) _ _ = raise Not_allowed_pattern e
;

fun append_context (Con l) l' = Con (l@l');


fun compute_context (p as App(Can(c,l),argl)) env =
      let fun get_context ((Var x)::l) ((Arr t)::lt) S I =
                (x,inst_type I S t)::get_context l lt S (x::I)
          |   get_context ((Var x)::l) ((Dep(y,t))::lt) S I =
                (x,inst_type I S t)::get_context l lt ((y,Var x)::S) (x::y::I)
          |   get_context ((p as App(Can(c,cl),argl))::l) ((Arr t)::lt) S I =
                let val ctype = unfold_type (get_type_of_prim c env) env
                in case ctype of
                     Prod(argt,t) => (get_context argl argt [] cl)@get_context l lt S I
                   | _ => raise Impl_arity_mismatch p
                end
          |   get_context ((p as App(Can(c,cl),argl))::l) ((Dep(y,t))::lt) S I =
                let val ctype = unfold_type (get_type_of_prim c env) env
                in case ctype of
                     Prod(argt,t) => (get_context argl argt [] cl)@get_context l lt ((y,p)::S) I
                   | _ => raise Impl_arity_mismatch p
                end
          |   get_context [] [] _ _ = []
          |   get_context _ _ _ _ = raise Impl_arity_mismatch p 
          val ctype = unfold_type (get_type_of_prim c env) env
      in case ctype of
          Prod(argt,t) => Con (rev (get_context argl argt [] l))
         | _ => raise Impl_arity_mismatch p
      end
|   compute_context (Can(c,l)) env = Con []
|   compute_context p _ = raise Not_allowed_pattern p
;

fun convert_def_exp I DefC env symbols (EXPR ce) = Expr (convert_exp I env symbols ce)
(*  for now until all files changed... *)
|   convert_def_exp I DefC env symbols (CASE(ce,TID "?",cdl)) = 
       let val e = convert_exp I env symbols ce
           val (_,et) = compute_type e DefC env
       in Case(e,et,convert_def_list e I DefC env symbols cdl)
       end
|   convert_def_exp I DefC env symbols (CASE(ce,ct,cdl)) = 
       let val e = convert_exp I env symbols ce
       in Case(e,convert_type DefC env symbols ct,convert_def_list e I DefC env symbols cdl)
       end
and convert_def_list _ I DefC env symbols [] = []
|   convert_def_list (Var x) I DefC env symbols ((cpattern,cdef)::l) =
      let val pattern = convert_exp I env symbols cpattern
          val (pattvars,fixedpattern) = fixpatternvars pattern
          val I' = pattvars@I
          val (C1 as Con c1) = unfold_defcontext DefC env
          val (C2 as Con c2) = inst_and_rem_context (x,fixedpattern) C1 I'
(*          val (Con C,t,newpattern) = pattern_context fixedpattern C2 env *)
          val (Con C) = compute_context fixedpattern env
          val def = convert_def_exp I' (add_contexts DefC C) env 
                    (map Var pattvars @ symbols) cdef
     in (fixedpattern,def)::convert_def_list (Var x) I DefC env symbols l
     end
|   convert_def_list e I DefC env symbols ((cpattern,cdef)::l) =
      let val pattern = convert_exp I env symbols cpattern
          val (pattvars,fixedpattern) = fixpatternvars pattern
          val (Con C,t,newpattern) = pattern_context fixedpattern (unfold_defcontext DefC env) env
          val def = convert_def_exp (pattvars@I) (add_contexts DefC C) env (map Var pattvars @ symbols) cdef
     in (fixedpattern,def)::convert_def_list e I DefC env symbols l
     end
;

fun convert_and_check_patt (C_PATT (cpattern,cdef)) env =
      let val symbols = symbol_table env
          val localI = defcontext_names (get_context_of_prim (function_name cpattern) env)
          val pattern = convert_exp localI env symbols cpattern
          val (pattvars,fixedpattern) = fixpatternvars pattern
      in case fixedpattern of
           (App(f,argl)) => 
              let val DefC = get_context_of_prim (name_of f) env
                  val f_context = unfold_defcontext DefC env
                  val (Con C,t,newpattern) = pattern_context (App(f,argl)) f_context env
                  val def = convert_def_exp (pattvars@localI) (add_contexts DefC C) 
                              env (map Var (pattvars @ localI) @ symbols) cdef
                  val (C',patt_type) = ok_patt_def (IDef(newpattern,def,t,Con C,0)) DefC env
                                       handle constraints_in_pattern constr => 
                                           raise Constraints_in_pattern (pattern,def,constr)
              in IDef(fixedpattern,def,patt_type,append_context f_context C',0)  
                               (* should keep the _ in the pattern!!! *)
              end
         | (Impl(c,l)) => 
              let val DefC = get_context_of_prim c env
                  val C = unfold_defcontext DefC env
                  val typc = get_real_type (Impl(c,l)) DefC (defcontext_names DefC) env
                  val def = convert_def_exp localI DefC env (map Var localI @ symbols) cdef
              in IDef(Impl(c,l),def,typc,C,0)
              end
         | e => raise Not_allowed_pattern e
      end
;(************** functions to compute CONCRETE -> ABSRACT definitions ************)

fun convert_def (ABBR def) env = Abbr (convert_abbr def env)
|   convert_def (PRIM def) env = Prim (convert_prim def env)
|   convert_def (PATT def) env = Patt (convert_and_check_patt def env)
|   convert_def _ _ = raise Match
;

fun name_of_ABBR (EDEF(ename,_,_,_)) = ename
|   name_of_ABBR (TDEF(tname,_,_)) = tname
|   name_of_ABBR (SDEF(sname,_,_,_)) = sname
|   name_of_ABBR (CDEF(cname,_)) = cname
;

fun name_of_PRIM (CTYP(name,_,_)) = name
|   name_of_PRIM (ITYP(name,_,_)) = name
;

fun name_of_CONSTR (UCONTYP(name,_,_)) = name;

fun name_of_PATT (C_PATT(APP(ID f,_),_)) = f
|   name_of_PATT (C_PATT(ID f,_)) = f
|   name_of_PATT _ = raise Not_allowed_con_pattern
;

fun name_of_UPATT (WPATT(_,_,_,APP(ID f,_),_,_)) = f
|   name_of_UPATT _ = raise Not_allowed_con_pattern
;(**************************************************************)
(********* FUNCTIONS TO GET DEFINITIONS ***********************)
(**************************************************************)

fun name_of_DEF (ABBR def) = name_of_ABBR def
|   name_of_DEF (PRIM def) = name_of_PRIM def
|   name_of_DEF (UCONSTR (_,def)) = name_of_CONSTR def
|   name_of_DEF (PATT def) = name_of_PATT def
|   name_of_DEF (UPATT def) = name_of_UPATT def
;


fun mark_new_abbr (EDef(name,e,t,C,_)) (Info(symbols,names,(l,n),h)) isnew newsymbol =
      let val id = n+1
          val newnames = if newsymbol then (name,Exp_Abbr)::names else names
          val newsymbols = if newsymbol then Expl(name,defcontext_names C)::symbols
                           else symbols
          val newdeflist = if isnew then (E_id(name,id)::l,id) else (l,id)
      in (Info(newsymbols,newnames,newdeflist,h),EDef(name,e,t,C,id))
      end
|   mark_new_abbr (TDef(name,t,C,_)) (Info(symbols,names,(l,n),h)) isnew newsymbol =
      let val id = n+1
          val newnames = if newsymbol then (name,Type_Abbr)::names else names
          val newdeflist = if isnew then (T_id(name,id)::l,id) else (l,id)
      in (Info(symbols,newnames,newdeflist,h),TDef(name,t,C,id))
      end
|   mark_new_abbr (SDef(name,S,dc1,dc2,_)) (Info(symbols,names,(l,n),h)) isnew _ =
      let val id = n+1
          val newnames = (name,Subst_Abbr)::names
          val newdeflist = if isnew then (DS_id(name,id)::l,id) else (l,id)
      in (Info(symbols,newnames,newdeflist,h),SDef(name,S,dc1,dc2,id))
      end
|   mark_new_abbr (CDef(name,C,_)) (Info(symbols,names,(l,n),h)) isnew _ =
      let val id = n+1
          val newnames = (name,Context_Abbr)::names
          val newdeflist = if isnew then (DC_id(name,id)::l,id) else (l,id)
      in (Info(symbols,newnames,newdeflist,h),CDef(name,C,id))
      end
;

fun add_abbr_to_env def isnew (env as Env(prims,abbrs,info,scr1,scr2)) =
      let val (newinfo,newdef) = mark_new_abbr def info isnew true (*true = new symbol*)
      in Env(prims,newdef::abbrs,newinfo,scr1,scr2)
      end
;

fun head_of (App(f,_)) = f
|   head_of e = e;

fun is_constructor_of (CTyp(name,t,DefC,_,_)) env =
      let fun con_of (Elem (s,e)) = 
                let val constr = head_of e
                in if on_constructor_form constr then (true,get_constr_name constr)
                   else (false,"")
                end
          |   con_of (TExpl(c,l)) =
                (case get_type_def_of c env of
                   TUnknown => (false,"")
                 | (DT t) => con_of t)
          |   con_of (TLet(vb,c,l)) =
                (case get_type_def_of c env of
                   TUnknown => (false,"")
                 | (DT t) => con_of (inst_type (defcontext_names DefC) vb t))
          |   con_of (Prod(_,t)) = con_of t
          |   con_of (Sort _) = (false,"")
      in con_of t
      end
|   is_constructor_of _ _ = (false,"")
;


fun mark_new_constr (d as ConTyp(name,t,C,_)) (Info(symbols,names,(l,n),h)) isnew setname newsymbol =
      let val id = n+1
          val newnames = if newsymbol then (name,Constr_Kind setname)::names else names
          val newsymbols = if newsymbol then Can(name,defcontext_names C)::symbols else symbols
          val newdeflist = if isnew then (Con_id(setname,id)::l,id) else (l,id)
      in (Info(newsymbols,newnames,newdeflist,h),ConTyp(name,t,C,id))
      end
;

fun add_constr_to_prims name def ((d as CTyp(name',t,DefC,id,cl))::l) =
       if name = name' then 
         let val d' = CTyp(name',t,DefC,id,def::cl)
         in (def,d'::l)
         end
       else let val (d',l') = add_constr_to_prims name def l
            in (def,d::l')
            end
|   add_constr_to_prims name def (d::l) = 
       let val (d',l') = add_constr_to_prims name def l
       in (d',d::l')
       end
|   add_constr_to_prims _ (ConTyp(name,t,_,_)) [] = raise look_up_prim_error name
;
        
fun add_constr_to_env name def isnew (env as Env(prims,abbrs,info,scr1,scr2)) =
      let val (newinfo,newdef) = mark_new_constr def info isnew name true (*true = new symbol*)
          val (d,newprims) = add_constr_to_prims name newdef prims
      in Env(newprims,abbrs,newinfo,scr1,scr2)
      end
;

fun mark_new_constr_list [] info isnew setname newsymbol = (info,[])
|   mark_new_constr_list (c::cl) info isnew setname newsymbol = 
      let val (newinfo,c') = mark_new_constr c info isnew setname newsymbol 
          val (info',cl') = mark_new_constr_list cl newinfo isnew setname newsymbol 
      in (info',c'::cl')
      end
;

fun pattern_name (App(f,_)) = name_of f
|   pattern_name (Impl(c,l)) = c
|   pattern_name e = raise Not_allowed_pattern e
;

fun mark_new_patt (IDef(pattern,def,t,C,_)) (Info(symbols,names,(l,n),h)) isnew =
      let val id = n+1
          val newdeflist = if isnew then (P_id(pattern_name pattern,id)::l,id) else (l,id)
      in (Info(symbols,names,newdeflist,h),IDef(pattern,def,t,C,id))
      end
;

fun mark_new_patt_list [] info isnew = (info,[])
|   mark_new_patt_list (p::pl) info isnew = 
      let val (newinfo,p') = mark_new_patt p info isnew
          val (info',pl') = mark_new_patt_list pl newinfo isnew
      in (info',p'::pl')
      end
;

fun mark_new_prim (CTyp(name,t,C,_,cl)) (Info(symbols,names,(l,n),h)) isnew newsymbol =
      let val id = n+1
          val newnames = if newsymbol then (name,Set_Kind)::names else names
          val newsymbols = if newsymbol then Can(name,defcontext_names C)::symbols else symbols
          val newdeflist = if isnew then (C_id(name,id)::l,id) else (l,id)
          val newinfo = Info(newsymbols,newnames,newdeflist,h)
          val (info',newcl) = mark_new_constr_list cl newinfo isnew name newsymbol 
      in (info',CTyp(name,t,C,id,newcl))
      end
|   mark_new_prim (ITyp(name,t,C,_,pl)) (Info(symbols,names,(l,n),h)) isnew newsymbol =
       let val id = n+1
          val newnames = if newsymbol then (name,Impl_Kind)::names else names
          val newsymbols = if newsymbol then Impl(name,defcontext_names C)::symbols else symbols
          val newdeflist = if isnew then (I_id(name,id)::l,id) else (l,id)
          val newinfo = Info(newsymbols,newnames,newdeflist,h)
          val (info',newpl) = mark_new_patt_list pl newinfo isnew
      in (info',ITyp(name,t,C,id,newpl))
      end
;

fun add_prim_to_env (d as CTyp(name,typ,DefC,id,cl)) isnew 
                          (env as Env(prims,abbrs,info,scr1,scr2)) =
      let val (isconstructor,constr_of) = is_constructor_of d env
      in if isconstructor then add_constr_to_env constr_of (ConTyp(name,typ,DefC,id)) isnew env
         else let val (newinfo,newdef) = mark_new_prim d info isnew true (*true = new symbol*)
              in Env(newdef::prims,abbrs,newinfo,scr1,scr2)
              end
      end
|   add_prim_to_env def isnew (env as Env(prims,abbrs,info,scr1,scr2)) =
      let val (newinfo,newdef) = mark_new_prim def info isnew true (*true = new symbol*)
      in Env(newdef::prims,abbrs,newinfo,scr1,scr2)
      end
;


fun add_patt_to_prims (patt as IDef(pattern,_,_,_,_)) prims =
      let fun add_patt patt name ((d as ITyp(c,t,C,n,pl))::l) =
                if c = name then (ITyp(c,t,C,n,patt::pl)::l)
                else d::add_patt patt name l
          |   add_patt patt name (d::l) = d::add_patt patt name l
          |   add_patt patt name [] = raise pattern_before_definition (name,Patt patt)
      in add_patt patt (pattern_name pattern) prims
      end
;

fun add_patt_to_env def isnew (env as Env(prims,abbrs,info,scr1,scr2)) =
      let val (newinfo,newdef) = mark_new_patt def info isnew
      in Env(add_patt_to_prims newdef prims,abbrs,newinfo,scr1,scr2)
      end
;

fun is_in_the_wdef l (WExpr e) = is_in_the_term l e
|   is_in_the_wdef l (WCase(e,t,wpl)) = 
       union(is_in_the_term l e,union(is_in_the_type l t,is_in_the_wpatts l wpl))
|   is_in_the_wdef l WUnknown = []
and is_in_the_wpatts l wpl = map_union (fn (WPatt(_,_,_,_,wdef,_)) => is_in_the_wdef l wdef) wpl
;



fun update_change x T ((y,L)::l) = if x = y then (x,T)::l else (y,L)::update_change x T l
|   update_change x T [] = [(x,T)]
;

fun update_prim (UCTyp(x,TUnknown,DefC,_)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val TD = retreive_undefined DO T YN
          val newYN = union([x],YN)
          val newDO = update_change x TD DO
          val newDDO = update_change x (T,[]) DDO
      in Deps(DN,CN,newYN,newDO,newDDO)
      end
|   update_prim (UCTyp(x,DT t,DefC,_)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val L = is_in_the_type UN t
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = union([x],CN)
              val newDO = update_change x (union(DL,TL)) DO
              val newDDO = update_change x (T,L) DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
|   update_prim (UITyp(x,TUnknown,DefC,_)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val TL = retreive_undefined DO T YN
          val newYN = union([x],YN)
          val newDO = update_change x TL DO
          val newDDO = update_change x (T,TL) DDO
      in Deps(DN,CN,newYN,newDO,newDDO)
      end
|   update_prim (UITyp(x,DT t,DefC,wpl)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_type_or_DefC UN t DefC
          val L = is_in_the_wpatts UN wpl
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x orelse mem TL x then raise circular_definition
         else 
          let val newCN = union([x],CN)
              val newDO = update_change x (union(DL,TL)) DO
              val newDDO = update_change x (T,L) DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
;


fun add_u_prim_to_scratch def (Scratch(prims,defs,constr,deps)) =
      Scratch(def::prims,defs,constr,update_prim def deps)
;

fun add_u_prim_to_backtrack def (Back(uprims,defs,deps)) =
      Back(def::uprims,defs,update_prim def deps)
;

fun add_new_uconstr_info (UConTyp(name,t,C)) setname (Info(symbols,names,idlist,hist)) = 
      let val newnames = (name,Constr_Kind setname)::names
          val newsymbols = Can(name,defcontext_names C)::symbols
      in Info(newsymbols,newnames,idlist,hist)
      end
;

fun add_new_uconstr_list_info (c::cl) setname info =
       add_new_uconstr_list_info cl setname (add_new_uconstr_info c setname info)
|   add_new_uconstr_list_info [] _ info = info
;

fun add_new_uprim_info (UCTyp(name,t,C,cl)) (Info(symbols,names,idlist,hist)) = 
      let val newnames = (name,Set_Kind)::names
          val newsymbols = Can(name,defcontext_names C)::symbols
      in add_new_uconstr_list_info cl name (Info(newsymbols,newnames,idlist,hist))
      end
|   add_new_uprim_info (UITyp(name,t,C,_)) (Info(symbols,names,idlist,hist)) = 
      let val newnames = (name,Impl_Kind)::names
          val newsymbols = Impl(name,defcontext_names C)::symbols
      in Info(newsymbols,newnames,idlist,hist)
      end
;

fun add_u_prim_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newscratch = add_u_prim_to_scratch def scratch
          val newbacktrack = add_u_prim_to_backtrack def backtrack
          val newinfo = add_new_uprim_info def info
      in Env(prims,abbrs,newinfo,newscratch,newbacktrack)
      end handle circular_definition => raise Circular_definition (UPrim def);


fun look_up_name name env =
      look_up_prim name env
      handle (look_up_prim_error name) => look_up_def name env
;

fun is_type t (Deps(DN,CN,YN,DO,DDO)) =
      null(retreive_undefined DO (is_in_the_type (YN @ CN) t) YN)
;
fun iscomplete_type t env = is_type t (get_deps env);

fun type_iscomplete c env =
      case look_up_name c env of
       (UPrim (UITyp(_,DT t,_,_))) => iscomplete_type t env
      |(UPrim (UCTyp(_,DT t,_,_))) => iscomplete_type t env
      | _ => false
;fun add_constructor def setname ((d as UCTyp(name,t,DefC,constrl))::l) =
      if name = setname then 
         UCTyp(name,t,DefC,def::constrl)::l
      else d::add_constructor def setname l
|   add_constructor def setname (d::l) = d::add_constructor def setname l
|   add_constructor def setname [] = raise look_up_prim_error setname
;

fun update_construct (UConTyp(x,TUnknown,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val newYN = union([x],YN)
          val newDO = (x,[])::DO
          val newDDO = (x,(T,[]))::DDO
      in Deps(DN,CN,newYN,newDO,newDDO)
      end
|   update_construct (UConTyp(x,DT t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val L = is_in_the_type UN t
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = x::CN
              val newDO = (x,union(DL,TL))::DO
              val newDDO = (x,(T,L))::DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
;

fun add_u_constr_to_scratch def setname (Scratch(prims,defs,constr,deps)) =
      Scratch(add_constructor def setname prims,defs,constr,update_construct def deps)
;

fun add_u_constr_to_backtrack def setname (Back(uprims,defs,deps)) =
      Back(add_constructor def setname uprims,defs,update_construct def deps)
;

fun add_u_constr_to_env def setname (env as Env(prims,abbrs,info,scratch,backtrack)) =
      if type_iscomplete setname env then 
        let val newscratch = add_u_constr_to_scratch def setname scratch
            val newbacktrack = add_u_constr_to_backtrack def setname backtrack
            val newinfo = add_new_uconstr_info def setname info
        in Env(prims,abbrs,newinfo,newscratch,newbacktrack)
        end handle circular_definition => raise Circular_definition (UConstr (setname,def))
      else raise Can't_add_constructor def
;
fun id_of_wpatt (WPatt(P(id,_),_,_,_,_,_)) = id;

fun add_wpatt_to_prims (patt as WPatt(P(name,_),_,_,_,_,_)) prims =
      let fun add_wpatt patt name ((d as UITyp(c,t,C,pl))::l) =
                if c = name then (UITyp(c,t,C,patt::pl)::l)
                else d::add_wpatt patt name l
          |   add_wpatt patt name (d::l) = d::add_wpatt patt name l
          |   add_wpatt patt name [] = raise pattern_before_definition (name,UPatt patt)
      in add_wpatt patt name prims
      end
;

 
(* change for x the term_dependent list to L , used for refine *)
fun add_to_DDO_list x newl ((y,(T,E))::l) = 
      if x = y then (x,(T,union(newl,E)))::l
      else (y,(T,E))::add_to_DDO_list x newl l
|   add_to_DDO_list x _ [] = raise Name_not_in_dep_list x
;

fun add_to_DO_list depl newL ((y,L)::l) = 
      if mem depl y then (y,union(newL,L))::add_to_DO_list depl newL l
      else (y,L)::add_to_DO_list depl newL l
|   add_to_DO_list _ _ [] = []
;

fun update_wpatt (WPatt(P(c,_),DefC,C,patt,wdef,t)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val E = is_in_the_wdef UN wdef
          val EL = retreive_undefined DO E YN
          val newDDO = add_to_DDO_list c E DDO
          val newDO = add_to_DO_list [c] EL DO
      in Deps(DN,CN,YN,newDO,newDDO)
      end
;

fun add_wpatt_to_scratch def (Scratch(prims,defs,constr,deps)) =
      Scratch(add_wpatt_to_prims def prims,defs,constr,update_wpatt def deps)



fun add_wpatt_to_backtrack def (Back(uprims,defs,deps)) =
      Back(add_wpatt_to_prims def uprims,defs,update_wpatt def deps)
;

fun add_wpatt_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      if type_iscomplete (id_of_wpatt def) env then 
        let val newscratch = add_wpatt_to_scratch def scratch
            val newbacktrack = add_wpatt_to_backtrack def backtrack
        in Env(prims,abbrs,info,newscratch,newbacktrack)
        end 
      else raise Can't_add_wpattern def
;


fun add_u_def_to_env (UAbbr def) env =
      add_u_abbr_to_env def env 
|   add_u_def_to_env (UPrim def) env = 
      add_u_prim_to_env def env 
|   add_u_def_to_env (UConstr (setname,def)) env =
      add_u_constr_to_env def setname env
|   add_u_def_to_env (UPatt def) env =
      add_wpatt_to_env def env
|   add_u_def_to_env def env = raise Not_U_definition def
;

(*************** functions to add definitions to env *****************)

fun add_def_to_env (Abbr def) isnew env = add_abbr_to_env def isnew env
|   add_def_to_env (Prim def) isnew env = add_prim_to_env def isnew env
|   add_def_to_env (Patt def) isnew env = add_patt_to_env def isnew env
|   add_def_to_env (Constr (setname,def)) isnew env = add_constr_to_env setname def isnew env
|   add_def_to_env Udef _ env = add_u_def_to_env Udef env
;

fun add_new_name_to_list (ABBR def) names = (name_of_ABBR def)::names
|   add_new_name_to_list (PRIM def) names = (name_of_PRIM def)::names
|   add_new_name_to_list (PATT def) names =
      if mem names (name_of_PATT def) then names 
      else raise pattern_without_function_def (name_of_PATT def)
|   add_new_name_to_list (UPATT def) names =
         if mem names (name_of_UPATT def) then names 
      else raise pattern_without_function_def (name_of_UPATT def)   
|   add_new_name_to_list _ _ = raise Match
;


fun look_up_new_defs (name::namelist) env =
      (case look_up_name name env of
        (Abbr d) => (Abbr d)::look_up_new_defs namelist env
      | (Prim d) => (Prim d)::look_up_new_defs namelist env
      | (Constr (setname,d)) => 
          if mem namelist setname then look_up_new_defs namelist env
          else (Constr (setname,d))::look_up_new_defs namelist env
      | _ => look_up_new_defs namelist env)
|   look_up_new_defs [] env = []
;

(*
fun split5 l =
     let fun split 5 l (a::l') = (rev l)::split 1 [a] l'
         |   split n l (a::l') = split (n+1) (a::l) l'
         |   split n l [] = [rev l]
     in split 0 [] l
     end
;
*)


fun add_definitions (def::deflist) env isnew newnames =
      let val d = convert_def def env handle error => raise Error_in_DEF (error,name_of_DEF def)
          val env' = add_def_to_env d isnew env 
      in add_definitions deflist env' isnew (add_new_name_to_list def newnames)
      end
|   add_definitions [] env _ newnames = (look_up_new_defs newnames env,env)
;


fun add_definition_list R isnew env =
      case PARSER_DEF_LIST R of
        (Res(deflist,[])) => add_definitions deflist env isnew []
      | (Res(def,R)) => raise Syntax_error("Unexpected end.",R)
      | Fail(s,R) => raise Syntax_error(s,R)
;
fun get_file instr =
       if end_of_stream instr then []
       else (explode (input_line instr)) @ get_file instr
;

fun remove_comments f ("("::"*"::l) = remove f l 0
|   remove_comments f (a::l) = a::remove_comments f l
|   remove_comments f [] = []
and remove f ("*"::")"::l) 0 = remove_comments f l
|   remove f ("*"::")"::l) n = remove f l (n-1)
|   remove f ("("::"*"::l) n = remove f l (n+1)
|   remove f (_::l) n = remove f l n
|   remove f [] _ = raise No_end_of_comment f
;

fun read_file filename  =
       let val instr = open_in filename
           val defs = get_file instr
           val finish = close_in instr
       in (remove_comments filename defs)
       end
;
fun reload_file isnew filename env = add_definition_list (lexanal (read_file filename)) isnew env;


fun wprint_exp (Var s)      = "#"^s
 |  wprint_exp (Expl(c,_))  = c
 |  wprint_exp (Impl(c,_))  = c
 |  wprint_exp (Can(c,_))   = c
 |  wprint_exp (App(Var s,A))     = "#"^s^"("^wprint_exp_app A^")"
 |  wprint_exp (App(Impl(c,_),A)) = c^"("^wprint_exp_app A^")"
 |  wprint_exp (App(Can(c,_),A))  = c^"("^wprint_exp_app A^")"
 |  wprint_exp (App(Expl(c,_),A)) = c^"("^wprint_exp_app A^")"
 |  wprint_exp (App(Let(L,e),A)) = 
       wprint_exp e^"{"^wprint_exp_let L^"}"^"("^wprint_exp_app A^")"
 |  wprint_exp (App(e,A)) = "("^wprint_exp e^")("^wprint_exp_app A^")"
 |  wprint_exp (Lam(L,e)) = "["^wprint_exp_lam L^"]"^wprint_exp e
 |  wprint_exp (Let(L,e)) = wprint_exp e^"{"^wprint_exp_let L^"}"
and wprint_exp_app [e]    = wprint_exp e
 |  wprint_exp_app (e::A) = wprint_exp e^","^wprint_exp_app A
 |  wprint_exp_app []     = raise exp_error
and wprint_exp_lam [s]    = "#"^s
 |  wprint_exp_lam (s::A) = "#"^s^","^wprint_exp_lam A
 |  wprint_exp_lam []     = raise exp_error
and wprint_exp_let [(x,e)]    = "#"^x^":="^wprint_exp e
 |  wprint_exp_let ((x,e)::A) = "#"^x^":="^wprint_exp e^";"^wprint_exp_let A
 |  wprint_exp_let []     = raise exp_error ;


(*********** printing of a type *************)

fun wprint_typ (Sort s)   = s
 |  wprint_typ (Elem (s,e))   = wprint_exp e
 |  wprint_typ (TExpl(c,l)) = c
 |  wprint_typ (TLet(vb,c,l)) = c^"{"^wprint_exp_let vb^"}"
 |  wprint_typ (Prod([],t)) = wprint_typ t
 |  wprint_typ (Prod(A,t)) = "("^(wprint_typ_decl A)^(wprint_typ t)
and wprint_typ_decl [d]   = (wprint_decl d)^")"
 |  wprint_typ_decl ((d as Dep(x,t))::(d1 as Dep(y,t'))::A) = 
      if t = t' then "#"^x^","^(wprint_typ_decl (d1::A))
      else (wprint_decl d)^";"^(wprint_typ_decl (d1::A))
 |  wprint_typ_decl (d::A) = (wprint_decl d)^";"^(wprint_typ_decl A)
 |  wprint_typ_decl []     = raise type_error
and wprint_decl (Arr t)    = wprint_typ t
 |  wprint_decl (Dep (x,t)) = "#"^x^":"^(wprint_typ t) ;


(*********** printing of a context *************)
		  
fun wprint_context (Con l) =
      let fun pr [] = ""
          |   pr ([(x,A)]) = "#"^x^":"^wprint_typ A
          |   pr ((x,A)::(y,B)::l) = 
                 if A = B then "#"^x^","^pr ((y,B)::l)
                 else "#"^x^":"^wprint_typ A^";"^pr ((y,B)::l)
      in "["^pr l^"]"
      end
  ;

fun wprint_ground_context [CName (s,_)] = s
|   wprint_ground_context [GCon C] = wprint_context (Con C)
|   wprint_ground_context ((CName (s,_))::l) = s^" + "^wprint_ground_context l
|   wprint_ground_context (GCon C::l) = wprint_context (Con C)^" + "^wprint_ground_context l
|   wprint_ground_context [] = ""
;

fun wprint_def_context (DCon ([],_)) = "[]"
|   wprint_def_context (DCon (l,_)) = wprint_ground_context l;



fun wprint_constructor (ConTyp(name,t,c,_)) =
      "\t"^name^" : "^wprint_typ t^"     "^wprint_def_context c
;


fun casepath s (n:int) = s^"."^(makestring n);
fun wprint_def_exp level _ (Expr e) = wprint_exp e
|   wprint_def_exp level n (Case(e,t,dl)) =
      "case "^wprint_exp e^" : "^wprint_typ t^" of\n"^wprint_case_list ("  "^level) n 1 dl
and wprint_case_list level _ _ [] = "\t"^level^"end"
|   wprint_case_list level n m ((e,d)::l) = 
      "\t"^level^(casepath n m)^": "^ wprint_exp e^" = "
          ^wprint_def_exp ("  "^level) (casepath n m) d^
      "\n"^wprint_case_list level n (m+1) l
;
 
fun wprint_idef n (IDef(e1,e2,t,c,_)) =
      wprint_exp e1^" = "^wprint_def_exp "" n e2 
;

fun print_num_list n pf [] = "\n"
|   print_num_list n pf (a::l) = 
      let val s = makestring n
      in "\n\t"^s^": "^pf s a ^"\n"^print_num_list (n+1) pf l
      end
;


fun wprint_prim (CTyp(name,t,c,_,constl)) = 
       name^" : "^wprint_typ t^"     "^wprint_def_context c
       ^print_list wprint_constructor constl
|   wprint_prim (ITyp(name,t,c,_,idefs)) = 
       name^" : "^wprint_typ t^"     "^wprint_def_context c
       ^print_num_list 1 wprint_idef (rev idefs)
;

fun wprint_utyp TUnknown = "?"
|   wprint_utyp (DT t) = wprint_typ t
;

fun wprint_u_constructor (UConTyp(name,t,c)) =
      "\t"^name^" : "^wprint_utyp t^"     "^wprint_def_context c
;
fun exppath s = s^pexp;
fun mkexp_name name = mk_invisible_name (exppath name);
fun mk_invisible_RHS_name path = mkexp_name (mkname path);
fun wprint_w_pattern level (WPatt(id,DefC,Con C,patt,WUnknown,t)) =
      let val pattname = mkname id
      in level^pattname^": "^wprint_exp patt^" = "^mk_invisible_RHS_name id
      end
|   wprint_w_pattern level (WPatt(id,DefC,Con C,patt,WCase(e,et,wpl),t)) =
      level^(mkname id)^": "^wprint_exp patt^" = "^
        "case "^wprint_exp e^" : "^wprint_typ et^" of"^print_list (wprint_w_pattern (level^"  ")) wpl
        ^level^"end"
|   wprint_w_pattern level (WPatt(id,DefC,Con C,patt,WExpr e,t)) =
      level^(mkname id)^": "^wprint_exp patt^" = "^wprint_exp e
;


fun wprint_wpatterns wpatts = print_list (wprint_w_pattern "\t") wpatts;

fun wprint_u_prim (UCTyp(name,t,c,constl)) = 
       name^" : "^wprint_utyp t^"     "^wprint_def_context c
       ^print_list wprint_u_constructor constl
|   wprint_u_prim (UITyp(name,t,c,wpatts)) = 
       name^" : "^wprint_utyp t^"     "^wprint_def_context c
       ^ wprint_wpatterns wpatts
;
		  
fun wprint_subst l =
      let fun wprintl [] = ""
          |   wprintl ([(x,e)]) = "#"^x^":="^wprint_exp e
          |   wprintl ((x,e)::l) = "#"^x^":="^wprint_exp e^";"^wprintl l
      in "{"^wprintl l^"}"
      end
  ;


fun wprint_comp_subst (SName s) = s
|   wprint_comp_subst (GSubst S) = wprint_subst S
|   wprint_comp_subst (Comp (S1,S2)) = 
      wprint_comp_subst S1^" o "^wprint_comp_subst S2
;

fun wprint_def_subst (SName s) = "{"^s^"}"
|   wprint_def_subst (GSubst S) = wprint_subst S
|   wprint_def_subst (Comp (DefS1,DefS2)) =
       "{"^wprint_comp_subst DefS1^" o "^wprint_comp_subst DefS2^"}"
;

      
fun wprint_abbr (EDef(name,e2,t,c,_)) =
      name^" = "^wprint_exp e2^" : "^wprint_typ t^"     "^wprint_def_context c
|   wprint_abbr (TDef(name,t,c,_)) =
      name^" = "^wprint_typ t^"     "^wprint_def_context c
|   wprint_abbr (CDef(name,defC,_)) =
      name^" = "^wprint_def_context defC
|   wprint_abbr (SDef(name,S,dc1,dc2,_)) =
      name^" = "^wprint_def_subst S^" : "^wprint_def_context dc1^"     "^wprint_def_context dc2
;

fun wprint_u_abbr (UEDef(name,D e2,t,c)) =
      name^" = "^wprint_exp e2^" : "^wprint_typ t^"     "^wprint_def_context c
|   wprint_u_abbr (UEDef(name,Unknown,t,c)) =
      name^" = ?"^name^" : "^wprint_typ t^"     "^wprint_def_context c
|   wprint_u_abbr (UTDef(name,DT t,c)) =
      name^" = "^wprint_typ t^"     "^wprint_def_context c
|   wprint_u_abbr (UTDef(name,TUnknown,c)) =
      name^" = ?"^name^"       "^wprint_def_context c
|   wprint_u_abbr (UCDef(name,udefC)) =
      name^" = "^wprint_def_context udefC
|   wprint_u_abbr (USDef(name,S,dc1,dc2)) =
      name^" = "^wprint_def_subst S^" : "^wprint_def_context dc1^"     "^wprint_def_context dc2
;

fun show_new_def (Prim (CTyp d)) = "#Set: "^wprint_prim (CTyp d)
|   show_new_def (Prim (ITyp d)) = "#Impl: "^wprint_prim (ITyp d)
|   show_new_def (UPrim (UCTyp d)) = "#Set: "^wprint_u_prim (UCTyp d)
|   show_new_def (UPrim (UITyp d)) = "#Impl: "^wprint_u_prim (UITyp d)
|   show_new_def (Abbr (EDef d)) = "#Expl: "^ wprint_abbr (EDef d)
|   show_new_def (Abbr (TDef d)) = "#TExpl: "^ wprint_abbr (TDef d)
|   show_new_def (Abbr (CDef d)) = "#Context: "^ wprint_abbr (CDef d)
|   show_new_def (Abbr (SDef d)) = "#Subst: "^ wprint_abbr (SDef d)
|   show_new_def (UAbbr (d as UEDef(name,Unknown,t,DefC))) =
      if visible_name name then
         "#Expl: "^ wprint_u_abbr d
        ^"\n#Goal: ?"^name^" : "^wprint_typ t^"   "^wprint_def_context DefC
      else "#Goal: "^name^" : "^wprint_typ t^"   "^wprint_def_context DefC
|   show_new_def (UAbbr (UEDef d)) = "#Expl: "^ wprint_u_abbr (UEDef d)
|   show_new_def (UAbbr (d as UTDef(name,TUnknown,DefC))) =
      if visible_name name then
         "#TExpl: "^ wprint_u_abbr d
        ^"\n#Goal: ?"^name^" Type   "^wprint_def_context DefC
      else "#Goal: "^name^" Type   "^wprint_def_context DefC
|   show_new_def (UAbbr (UTDef d)) = "#TExpl: "^ wprint_u_abbr (UTDef d)
|   show_new_def (UAbbr (UCDef d)) = "#Context: "^ wprint_u_abbr (UCDef d)
|   show_new_def (UAbbr (USDef d)) = "#Subst: "^ wprint_u_abbr (USDef d)
|   show_new_def _ = ""
;

fun show_defs [] = ()
|   show_defs l =
      myprint (print_list show_new_def l)
;

fun is_a_sort x = mem ["Prop","Set"] x;

fun get_context_of name env =
     get_context_of_def name env
     handle (look_up_abbr_error _) => get_context_of_prim name env
;
exception TLet_Not_Restricted of TYP;

fun istype_check (Sort s) _ _ _ = if is_a_sort s then Ok [] else NotType (Sort s)
|   istype_check (Elem (s,e)) DefC I env = type_check e (Sort s) DefC I env
|   istype_check (TExpl(c,l)) DefC I env = Ok []
|   istype_check (TLet(vb,c,l)) DefC I env =
      if (isrestricted vb l) then
        fits_context vb (unfold_defcontext (get_context_of c env) env) DefC I env
      else raise TLet_Not_Restricted (TLet(vb,c,l)) 
|   istype_check (Prod(Arr t1::l,t2)) DefC I env =
      (case (istype_check t1 DefC I env) of
         (Ok cl) => add_constraints cl (istype_check (Prod(l,t2)) DefC I env)
      |  notequals => notequals)
|   istype_check (Prod(Dep(x,t1)::l,t2)) DefC I env =
      (case (istype_check t1 DefC I env) of
         (Ok cl) => add_constraints cl (istype_check (Prod(l,t2)) 
                    (add_to_defcontext (x,t1) DefC) (x::I) env)
      |  notequals => notequals)
|   istype_check (Prod([],t)) DefC I env = istype_check t DefC I env
    ;

fun check_context [] _ _ _ = Ok []
|   check_context ((x,A)::C) C' I env =
      if occurs I x then raise Variable_twice_in_context x
      else case (istype_check A (DCon ([GCon C'],I)) I env) of
             (Ok cl) => add_constraints cl (check_context C ((x,A)::C') (x::I) env)
           | notequals => notequals
;

fun iscontext_check (DCon ([CName (name,_)],_)) env = 
      if not (visible_name name) orelse in_scratch_area name env 
        then raise May_complete_context_before_use name
      else Ok []  (* Know this is checked already!!! *)
|   iscontext_check DefC env = 
      let val (Con C) = unfold_defcontext DefC env
      in check_context C [] [] env
      end
;

fun Type_and_Context_Check e t DefC env =
      case iscontext_check DefC env of
        (Ok cl) => add_constraints cl (Type_Check e t DefC env)
      | notequals => notequals
;

fun IsType_Check t DefC env =
      let val I = defcontext_names DefC
          val not_in_context = get_subset_fidents_type I t
      in case not_in_context of
           [] => (case iscontext_check DefC env of
                    (Ok cl)  => add_constraints cl (istype_check t DefC I env)
                   | notequals => notequals)
         | l => raise free_variable_not_in_context l
      end
;

fun IsType_and_Context_Check t DefC env =
      case iscontext_check DefC env of
        (Ok cl) => add_constraints cl (IsType_Check t DefC env)
      | notequals => notequals
;

fun is_sub_context (DefC1 as DCon ([(CName (name,_))],_)) (DefC2 as DCon ([(CName (name',_))],I)) env =
      if name = name' then Ok []
      else let val C = unfold_defcontext DefC1 env
           in sub_context C DefC2 I env
           end
|   is_sub_context DefC1 DefC2 env =
      let val C = unfold_defcontext DefC1 env
      in sub_context C DefC2 (defcontext_names DefC2) env
      end
;
	   
fun Fits_Context_Check (SName name) DefC1 DefC2 env =
      let val (_,SDefC1,SDefC2) = look_up_defsubst name env
      in case is_sub_context SDefC1 DefC1 env of
          (Ok cl) => add_constraints cl (is_sub_context SDefC2 DefC2 env)
         | notequals => notequals
      end
|   Fits_Context_Check (GSubst S) DefC1 DefC2 env =
      let val C = unfold_defcontext DefC1 env
          val I = defcontext_names DefC2
      in fits_context S C DefC2 I env
      end
|   Fits_Context_Check (S as Comp (S1,S2)) DefC1 DefC2 env =
      let val (constr1,S1DefC1,S1DefC2) = check_defsubst_contexts S1 env
          val (constr2,S2DefC1,S2DefC2) = check_defsubst_contexts S2 env
      in case is_sub_context DefC1 S1DefC1 env of
          (Ok cl1) => 
            (case is_sub_context S1DefC2 S2DefC1 env of
                (Ok cl2) => add_constraints (constr1@constr2@cl1@cl2) 
                            (is_sub_context S2DefC2 DefC2 env)
             | notequals => raise Constraints_in_subst (S,notequals))
         | notequals => notequals
      end
and check_defsubst_contexts (SName name) env = 
     (fn (x,y,z) => ([],y,z)) (look_up_defsubst name env)
|   check_defsubst_contexts (S as Comp (S1,S2)) env =
      let val (cl1,S1DefC1,S1DefC2) = check_defsubst_contexts S1 env
          val (cl2,S2DefC1,S2DefC2) = check_defsubst_contexts S2 env
      in case is_sub_context S1DefC2 S2DefC1 env of
          (Ok cl) => (cl1@cl2@cl,S1DefC1,S2DefC2)
         | notequals => raise Constraints_in_subst (S,notequals)
      end
|   check_defsubst_contexts S env = raise subst_composition_error S
;

fun check_abbr_def (d as EDef(_,e,t,DefC,_)) env =
      (case Type_and_Context_Check e t DefC env of
        (Ok []) => d
      | cl => raise Constraints_in_theory (cl,Abbr d))
|   check_abbr_def (d as TDef(_,t,DefC,_)) env =
      (case IsType_and_Context_Check t DefC env of
        (Ok []) => d
      | cl => raise Constraints_in_theory (cl,Abbr d))
|   check_abbr_def (d as CDef(_,DefC,_)) env =
      (case iscontext_check DefC env of
        (Ok []) => d
      | cl => raise Constraints_in_theory (cl,Abbr d))
|   check_abbr_def (d as SDef(_,S,DefC1,DefC2,_)) env = 
      (case iscontext_check DefC1 env of
        (Ok []) => 
          (case iscontext_check DefC2 env of
            (Ok []) => 
              (case Fits_Context_Check S DefC1 DefC2 env of
                (Ok []) => d
              | cl => raise Constraints_in_theory (cl,Abbr d))
          | cl => raise Constraints_in_theory (cl,Abbr d))
       | cl => raise Constraints_in_theory (cl,Abbr d))
       ;

fun check_and_add_abbr def isnew env = 
      add_abbr_to_env (check_abbr_def def env) isnew env
;


(********** functions to check abbreviations ****************)


fun check_and_add_ABBR def env isnew  =
      let val name = name_of_ABBR def
      in if occurs (global_names env) name then raise Name_already_defined name
         else check_and_add_abbr (convert_abbr def env) isnew env
      end
;


fun is_prim (CTyp(_,t,DefC,_,_)) (Deps(DN,CN,YN,DO,DDO)) =
      null (is_in_type_or_DefC (YN @ CN) t DefC)
|   is_prim (ITyp(_,t,DefC,_,_)) (Deps(DN,CN,YN,DO,DDO)) =
      null (is_in_type_or_DefC (YN @ CN) t DefC)
;

(******************* check if a theory definition is complete or not *******************)

fun iscomplete_prim d env = is_prim d (get_deps env);


fun check_prim_def (d as CTyp(_,typ,DefC,_,_)) env =    
     if iscomplete_prim d env then
      (case IsType_and_Context_Check typ DefC env of
         (Ok []) => d
       | cl => raise Constraints_in_theory (cl,Prim d))
     else raise Incomplete_in_theory (Prim d)
|   check_prim_def (d as ITyp(_,typ,DefC,_,_)) env =
     if iscomplete_prim d env then
       let val t = unfold_type typ env
       in (*if is_function_type t then*)
            (case IsType_and_Context_Check t DefC env of
              (Ok []) => d
            | cl => raise Constraints_in_theory (cl,Prim d))
         (*else raise Impl_typ_not_a_function_type d*)
       end
     else raise Incomplete_in_theory (Prim d)
;
    

(************ functions to check primitives ***************)

fun check_and_add_prim def isnew env = 
      add_prim_to_env (check_prim_def def env) isnew env
;


fun check_and_add_PRIM def env isnew  =
      let val name = name_of_PRIM def
      in if occurs (global_names env) name then raise Name_already_defined name
         else check_and_add_prim (convert_prim def env) isnew env
      end
;

fun add_patt def isnew env = 
      add_patt_to_env def isnew env
;

fun convert_C (CON l) DefC symbols env =
     let fun conv ((x,t)::l,sym,DefC) = 
              let val t' = convert_type DefC env sym t
                  val (l',sym') = conv (l,Var x::sym,add_to_defcontext (x,t') DefC)
              in ((x,t')::l',sym')
              end
         |   conv ([],sym,_) = ([],sym)
         val (C,allsymbols) = conv (l,symbols,DefC)
     in (Con C,allsymbols)
     end
;

fun get_number (a::l,n) =
      if isdigit a then get_number(l,n*10+ord a - ord "0")
      else (a::l,n)
|   get_number ([],n) = ([],n);
fun path_of ("."::l) = 
      let val (l',n) = get_number (l,0)
      in n::path_of l'
      end
|   path_of [] = []
|   path_of (a::l) = raise path_error;
fun mkpid s = 
      let fun pid ("."::n::l') l = 
                if isdigit n then P(implode (rev l),path_of ("."::l'))
                else pid l' (n::"."::l)
          |   pid (a::p) l = pid p (a::l)
          |   pid [] l = P(implode (rev l),[])
      in pid (explode s) []
      end;

fun convert_wpatt env startsymbols (WPATT(id,cDefC,cC,ce,cdef,ct)) =
      let val (DefC,somesymbols) = convert_DefC cDefC env
          val (C as Con C',allsymbols) = convert_C cC DefC somesymbols env
          val DefC' = add_contexts DefC C'
          val I = defcontext_names DefC'
      in WPatt(mkpid id,DefC,C,convert_exp I env allsymbols ce,
               convert_wdef env cdef I DefC' allsymbols,
               convert_type DefC' env allsymbols ct)
      end
and convert_wdef env (WEXPR (ID s)) I DefC allsymbols = 
      if isqsym s then WUnknown else WExpr (convert_exp I env allsymbols (ID s))
|   convert_wdef env (WEXPR ce) I DefC allsymbols = WExpr (convert_exp I env allsymbols ce)
|   convert_wdef env (WCASE(ce,ct,cwpl)) I DefC allsymbols =
      WCase(convert_exp I env allsymbols ce,
            convert_type DefC env allsymbols ct,
            map (convert_wpatt env allsymbols) cwpl)
;

(************** functions to check env kind definitions ****************)

fun check_and_add_definition (ABBR def) env isnew  =
      check_and_add_ABBR def env isnew 
|   check_and_add_definition (PRIM def) env isnew  =
      check_and_add_PRIM def env isnew 
|   check_and_add_definition (PATT def) env isnew =
      add_patt (convert_and_check_patt def env) isnew env
|   check_and_add_definition (UPATT def) env isnew =
      add_wpatt_to_env (convert_wpatt env (symbol_table env) def) env
| check_and_add_definition _ _ _ = raise Match
;

fun check_and_add_definitions (def::deflist) isnew env newnames =
      let val newenv = check_and_add_definition def env isnew
                       handle error => raise Error_in_DEF (error,name_of_DEF def)
      in check_and_add_definitions deflist isnew newenv (add_new_name_to_list def newnames)
      end
|   check_and_add_definitions [] _ env newnames = (look_up_new_defs newnames env,env)
;

fun check_and_add_definition_list marked R env =
      case PARSER_DEF_LIST R of
        (Res(deflist,[])) => check_and_add_definitions deflist marked env []
      | (Res(def,R)) => raise Syntax_error("Unexpected end.",R)
      | Fail(s,R) => raise Syntax_error(s,R)
;

 
fun load_file isnew filename env = 
       check_and_add_definition_list isnew (lexanal (read_file filename)) env;
  
fun do_load_file filename (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = load_file true filename env     (* marked to be new *)
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun do_reload_file filename (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = reload_file true filename env     (* marked to be new *)
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun do_include_file filename (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = load_file false filename env     (* marked to be included *)
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun do_reinclude_file filename (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = reload_file false filename env     (* marked to be included *)
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
 
fun opt_UConTyp ((((id,_),t),c),setname) = UCONSTR (setname,(UCONTYP(id,t,c)));

fun constrcode (Ident x::l) = 
     (case explode x of
        ("C"::"."::sl) => Res(implode sl,l)
      | _ => Fail("Constructor code expected",(Ident x)::l))
|   constrcode other = Fail("Constructor code expected",other)
;

fun PARSER_CONSTRDEF s = 
      ((PARSER_ID <&> literal ":" <&> PARSER_TYPE <&> PARSER_DEFCONTEXT <&> constrcode)
             modify opt_UConTyp) s
;

fun PARSER_BACK_DEF s = 
          (PARSER_CONSTRDEF 
      <|> PARSER_PRIMDEF
      <|> (PARSER_WPATT modify UPATT)
      <|> (PARSER_ABBR modify ABBR)) s
;

fun opt_info ((_,VN),((_,YN),(_,AL))) = (VN,YN,AL);
fun opt_pair ((((_,x),_),y),_) = (x,y);

fun PARSER_ID_PAIR s = 
      ((literal "(" <&> PARSER_ID <&> literal "," <&> PARSER_ID <&> literal ")")
          modify opt_pair) s
;


fun list_with_start openid comma parser (Symbol y::l) = 
       let fun is_empty_list (Symbol y::l) openid = close openid y
           |   is_empty_list _ _ = false
           fun parser1 s =
               if is_empty_list s openid then Res([],tl l) 
               else
                 case parser s of
                    Res(zut,Symbol y::l) => 
                       if close openid y then Res([zut],l) 
                       else if y = comma then (parser1 modify (Cons zut)) l
                            else Fail((closing openid)^" or "^comma^" expected",Symbol y::l)
                  | Res(_,l)  => Fail((closing openid)^" or "^comma^" expected",l)
                  | Fail(s,l) => Fail(s,l)
       in if y = openid then parser1 l else Fail(openid^" expected",Symbol y::l) 
       end
|   list_with_start openid _ _ l = Fail(openid^" expected",l) 
;

fun PARSER_INFO s =
        ((literal "#VN#" <&> (list_with_start "[" "," PARSER_ID)
     <&>((literal "#YN#" <&> (list_with_start "[" "," PARSER_ID))
     <&> (literal "#AL#" <&> (list_with_start "[" "," PARSER_ID_PAIR)))) modify opt_info) s
;
fun PARSER_BACKTRACK s =
      (PARSER_INFO <&> seq PARSER_BACK_DEF) s
;

fun convert_u_abbr (EDEF (name,ce,ct,cDefC)) env =
    if ce = ID "?" then
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in UEDef(name,Unknown,convert_type DefC env allsymbols ct,DefC)
      end
    else
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in UEDef(name,D (convert_exp (defcontext_names DefC) env allsymbols ce),
               convert_type DefC env allsymbols ct,DefC)
      end
|   convert_u_abbr (TDEF (name,ct,cDefC)) env =
    if ct = TID "?" then
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in UTDef(name,TUnknown,DefC)
      end
    else
      let val (DefC,allsymbols) = convert_DefC cDefC env
      in UTDef(name,DT (convert_type DefC env allsymbols ct),DefC)
      end
|   convert_u_abbr (CDEF (name,cDefC)) env =
      UCDef(name,fst (convert_DefC cDefC env))
|   convert_u_abbr (SDEF (name,cS,cD1,cD2)) env =
      let val (DefC2,allsymbols) = convert_DefC cD2 env
          val (DefC1,_) = convert_DefC cD1 env
      in USDef(name,convert_DefS (defcontext_names DefC2) cS allsymbols env,DefC1,DefC2)
      end
;


fun convert_u_prim (CTYP(name,ct,cDefC)) env =
     if ct = TID "?" then
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UCTyp(name,TUnknown,DefC,[])
       end
     else
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UCTyp(name,DT (convert_type DefC env allsymbols ct),DefC,[])
       end
|   convert_u_prim (ITYP(name,ct,cDefC)) env =
     if ct = TID "?" then
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UITyp(name,TUnknown,DefC,[])
       end
     else
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UITyp(name,DT (convert_type DefC env allsymbols ct),DefC,[])
       end
;

fun convert_u_constr (UCONTYP(name,ct,cDefC)) env =
     if ct = TID "?" then
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UConTyp(name,TUnknown,DefC)
       end
     else
       let val (DefC,allsymbols) = convert_DefC cDefC env
       in UConTyp(name,DT (convert_type DefC env allsymbols ct),DefC)
       end
;

fun add_uabbr_symbol (UEDef(name,_,_,DefC)) (Info(symbols,names,id,n)) =
      Info(Expl(name,defcontext_names DefC)::symbols,(name,Exp_Abbr)::names,id,n)
|   add_uabbr_symbol (UTDef(name,_,DefC)) (Info(symbols,names,id,n)) =
      Info(symbols,(name,Type_Abbr)::names,id,n)
|   add_uabbr_symbol (UCDef(name,DefC)) (Info(symbols,names,id,n)) =
      Info(symbols,(name,Context_Abbr)::names,id,n)
|   add_uabbr_symbol (USDef(name,_,_,DefC)) (Info(symbols,names,id,n)) =
      Info(symbols,(name,Subst_Abbr)::names,id,n)
;

fun add_uprim_symbol (UCTyp(name,_,DefC,_)) (Info(symbols,names,id,n)) =
      Info(Can(name,defcontext_names DefC)::symbols,(name,Set_Kind)::names,id,n)
|   add_uprim_symbol (UITyp(name,_,DefC,_)) (Info(symbols,names,id,n)) =
      Info(Impl(name,defcontext_names DefC)::symbols,(name,Impl_Kind)::names,id,n)
;

fun add_uconstr_symbol (UConTyp(name,_,DefC)) setname (Info(symbols,names,id,n)) =
      Info(Can(name,defcontext_names DefC)::symbols,(name,Constr_Kind setname)::names,id,n)
;

fun add_to_backtrack (UAbbr def) (env as Env(p,a,i,s,backtrack)) =
      Env(p,a,add_uabbr_symbol def i,s,add_u_abbr_to_backtrack def backtrack env)
|   add_to_backtrack (UPrim def) (Env(p,a,i,s,backtrack)) =
      Env(p,a,add_uprim_symbol def i,s,add_u_prim_to_backtrack def backtrack)
|   add_to_backtrack (UConstr (setname,def)) (Env(p,a,i,s,backtrack)) =
      Env(p,a,add_uconstr_symbol def setname i,s,add_u_constr_to_backtrack def setname backtrack)
|   add_to_backtrack (UPatt def) (Env(p,a,i,s,backtrack)) =
      Env(p,a,i,s,add_wpatt_to_backtrack def backtrack)
|   add_to_backtrack def env = raise Not_U_definition def
;

fun add_def_to_backtrack (ABBR def) env =
      let val name = name_of_ABBR def
      in if occurs (global_names env) name then raise Name_already_defined name
         else let val newdef = UAbbr (convert_u_abbr def env)
              in (newdef,add_to_backtrack newdef env)
              end
      end
|   add_def_to_backtrack (PRIM def) env =
      let val name = name_of_PRIM def
      in if occurs (global_names env) name then raise Name_already_defined name
         else let val newdef = UPrim (convert_u_prim def env)
              in (newdef,add_to_backtrack newdef env)
              end
      end
|   add_def_to_backtrack (UCONSTR (setname,def)) env =
      let val name = name_of_CONSTR def
      in if occurs (global_names env) name then raise Name_already_defined name
         else let val newdef = UConstr (setname,convert_u_constr def env)
              in (newdef,add_to_backtrack newdef env)
              end
      end
|   add_def_to_backtrack (UPATT def) env =
      let val newdef = UPatt (convert_wpatt env (symbol_table env) def)
      in (newdef,add_to_backtrack newdef env)
      end
|   add_def_to_backtrack (PATT def) env = raise parsed_as_PATT_not_WPATT
;

fun get_id_name (C_id (name,_)) = name
|   get_id_name (Con_id(name,_)) = name
|   get_id_name (I_id(name,_)) = name
|   get_id_name (P_id(name,_)) = name
|   get_id_name (E_id(name,_)) = name
|   get_id_name (T_id(name,_)) = name
|   get_id_name (DC_id(name,_)) = name
|   get_id_name (DS_id(name,_)) = name
;

fun remove_info namelist (Info(symbols,names,(idlist,maxid),hist)) =
      let fun remove_sym namelist = filter (fn e => not (mem namelist (name_of e)))
          fun remove_name namelist = filter (fn (c,_) => not (mem namelist c))
          fun remove_id namelist = filter (fn id => not (mem namelist (get_id_name id)))
      in Info(remove_sym namelist symbols,remove_name namelist names,(remove_id namelist idlist,maxid),hist)
      end
;

fun name_of_env_kind_list ((Prim d)::l) = name_of_prim d :: name_of_env_kind_list l
|   name_of_env_kind_list ((UPrim d)::l) = name_of_u_prim d :: name_of_env_kind_list l
|   name_of_env_kind_list ((Abbr d)::l) = name_of_abbr d :: name_of_env_kind_list l
|   name_of_env_kind_list ((UAbbr d)::l) = name_of_u_abbr d :: name_of_env_kind_list l
|   name_of_env_kind_list ((Constr(_,d))::l) = name_of_constr d :: name_of_env_kind_list l
|   name_of_env_kind_list ((UConstr(_,d))::l) = name_of_u_constr d :: name_of_env_kind_list l
|   name_of_env_kind_list (_::l) =  name_of_env_kind_list l
|   name_of_env_kind_list [] = []
;

(*
fun DN_of_deps (Deps(DN,_,_,_,_)) = DN;
fun isvisible c (Deps(VN,CN,YN,DO,DDO)) = mem VN c;
*)
fun get_visible_names (Scratch(_,_,_,Deps(VN,CN,YN,DO,DDO))) = 
       (CN,YN,[]);

fun get_scratch_names scratch =
      let val (CN,YN,_) = get_visible_names scratch
      in YN @ CN
      end
;

(*
val (envdef as UPatt def)=a

val scratch' = add_env_kind_to_scratch envdef scratch;
val newenv = change_scratch scratch' env;
val (Ok cl) = compute_constr_of_wpatt def newenv;
val newscratch = add_constraints_to_scratch cl scratch';
val env = change_scratch newscratch newenv;
val scratch = newscratch;

*)


fun compute_constr_of_def (UEDef(_,Unknown,t,DefC)) env =
      IsType_Check t DefC env
|   compute_constr_of_def (UEDef(_,D e,t,DefC)) env =
      Type_Check e t DefC env
|   compute_constr_of_def (UTDef(_,TUnknown,DefC)) env =
      iscontext_check DefC env
|   compute_constr_of_def (UTDef(_,DT t,DefC)) env =
      IsType_Check t DefC env
|   compute_constr_of_def (UCDef(_,DefC)) env =
      iscontext_check DefC env
|   compute_constr_of_def (USDef(_,S,DefC1,DefC2)) env =
      Fits_Context_Check S DefC1 DefC2 env
;

fun compute_constr_of_constr (UConTyp(name,TUnknown,DefC)) env =
      iscontext_check DefC env
|   compute_constr_of_constr (UConTyp(name,DT t,DefC)) env =
      IsType_Check t DefC env
;

fun compute_constr_of_list f (a::l) env =
      (case f a env of
        (Ok cl) => add_constraints cl (compute_constr_of_list f l env)
       | notequals => raise Constraint_after_backtrack notequals)
|   compute_constr_of_list f [] _ = Ok []
;

fun compute_constr_of_wpatt (WPatt(_,DefC,Con C,patt,WUnknown,t)) env =
      istype_check t (add_contexts DefC C) (defcontext_names DefC @ map fst C) env
|   compute_constr_of_wpatt (WPatt(_,DefC,Con C,patt,WExpr e,t)) env = 
      type_check e t (add_contexts DefC C) (defcontext_names DefC @ map fst C) env
|   compute_constr_of_wpatt (WPatt(_,DefC,Con C,patt,WCase(e,et,wpl),t)) env = 
      case type_check e et (add_contexts DefC C) (defcontext_names DefC @ map fst C) env of
        (Ok cl) => add_constraints cl (compute_constr_of_wpatt_list wpl env)
      | notequals => raise Constraint_after_backtrack notequals
and compute_constr_of_wpatt_list (wpatt::l) env =
     (case compute_constr_of_wpatt wpatt env of
       (Ok cl) => add_constraints cl (compute_constr_of_wpatt_list l env)
     | notequals => raise Constraint_after_backtrack notequals)
|   compute_constr_of_wpatt_list [] env = Ok []
;

fun compute_constr_of_prim (UCTyp(name,TUnknown,DefC,_)) env =
      iscontext_check DefC env
|   compute_constr_of_prim (UITyp(name,TUnknown,DefC,_)) env =
      iscontext_check DefC env
|   compute_constr_of_prim (UCTyp(name,DT t,DefC,conl)) env =
      (case IsType_Check t DefC env of
        (Ok cl) => add_constraints cl (compute_constr_of_list compute_constr_of_constr conl env)
       | notequals => raise Constraint_after_backtrack notequals)
|   compute_constr_of_prim (UITyp(name,DT t,DefC,pl)) env =
      (case IsType_Check t DefC env of
        (Ok cl) => add_constraints cl (compute_constr_of_wpatt_list pl env)
       | notequals => raise Constraint_after_backtrack notequals)
;
      



(*************** functions to add definitions to scratch areas **************)

(* used by add_visible_defs (used in make_new_scratch) *)
fun add_env_kind_to_scratch (UPrim def) (Scratch(prims,defs,constr,deps)) =
      Scratch(def::prims,defs,constr,update_prim def deps)
|   add_env_kind_to_scratch (UAbbr def) (Scratch(prims,defs,constr,deps)) =
      Scratch(prims,def::defs,constr,update_define def deps)
|   add_env_kind_to_scratch (UConstr (setname,def)) (Scratch(prims,defs,constr,deps)) =
      Scratch(add_constructor def setname prims,defs,constr,update_construct def deps)
|   add_env_kind_to_scratch (UPatt def) (Scratch(prims,defs,constr,deps)) =
      Scratch(add_wpatt_to_prims def prims,defs,constr,update_wpatt def deps)
|   add_env_kind_to_scratch def _ = raise Not_U_definition def
;


fun add_constraints_to_scratch cl (Scratch(p,a,l,d)) = Scratch(p,a,l@cl,d);

fun change_scratch scratch (Env(p,a,i,_,back)) = Env(p,a,i,scratch,back);

fun add_visible_defs ((envdef as UAbbr def)::defs) scratch env =
      let val scratch' = add_env_kind_to_scratch envdef scratch
          val newenv = change_scratch scratch' env
      in case compute_constr_of_def def newenv
           of (Ok cl) => let val newscratch = add_constraints_to_scratch cl scratch'
                         in add_visible_defs defs newscratch (change_scratch newscratch newenv)
                         end
            | notequals => raise Constraint_after_backtrack notequals
      end
|   add_visible_defs ((envdef as UPrim def)::defs) scratch env =
      let val scratch' = add_env_kind_to_scratch envdef scratch
          val newenv = change_scratch scratch' env
      in case compute_constr_of_prim def newenv
           of (Ok cl) => let val newscratch = add_constraints_to_scratch cl scratch'
                         in add_visible_defs defs newscratch (change_scratch newscratch newenv)
                         end
            | notequals => raise Constraint_after_backtrack notequals
      end
|   add_visible_defs ((envdef as UConstr (setname,def))::defs) scratch env =
      let val scratch' = add_env_kind_to_scratch envdef scratch
          val newenv = change_scratch scratch' env
      in case compute_constr_of_constr def newenv
           of (Ok cl) => let val newscratch = add_constraints_to_scratch cl scratch'
                         in add_visible_defs defs newscratch (change_scratch newscratch newenv)
                         end
            | notequals => raise Constraint_after_backtrack notequals
      end
|   add_visible_defs ((envdef as UPatt def)::defs) scratch env =
      let val scratch' = add_env_kind_to_scratch envdef scratch
          val newenv = change_scratch scratch' env
      in case compute_constr_of_wpatt def newenv
           of (Ok cl) => let val newscratch = add_constraints_to_scratch cl scratch'
                         in add_visible_defs defs newscratch (change_scratch newscratch newenv)
                         end
            | notequals => raise Constraint_after_backtrack notequals
      end
|   add_visible_defs [] scratch env = (scratch,env)
|   add_visible_defs _ _ _ = raise Match
;

fun refine_simple_constr (EE(Expl(c,l),e,_,_)) scratch env =
      let val (valid,freevars) = exp_valid_in_context c e env
      in if valid then  
refine_constr_in_scratch 
   (update_unknown_in_scratch c e (okey_recursive_def (goal_in_def c env) env) scratch) env
(*           case look_up_u_abbr_in_scratch c scratch of
             (UEDef(c,Unknown,t,DefC)) =>
               let val constraints = Type_Check e t DefC env
               in case constraints of
                    (Ok cl) => refine_constr_in_scratch 
                               (add_constr cl (update_unknown_in_scratch c e 
                                  (okey_recursive_def (goal_in_def c env) env) scratch)) env
                  | notequals => raise Constraint_after_backtrack notequals
               end
           | _ => raise Refine_on_not_unknown c
*)
         else raise Refine_exp_free_Vars (c,e,freevars)
      end
|   refine_simple_constr (TT(TExpl(c,l),t,_)) scratch env =
      let val (valid,freevars) = type_valid_in_context c t env
      in if valid then 
           case look_up_u_abbr_in_scratch c scratch of
             (UTDef(c,TUnknown,DefC)) =>
               let val constraints = IsType_Check t DefC env
               in case constraints of
                    (Ok cl) => refine_constr_in_scratch (add_constr cl (update_Tunknown_in_scratch c t scratch)) env
                  | notequals => raise Constraint_after_backtrack notequals
               end
           | _ => raise Refine_on_not_unknown c
         else raise Refine_type_free_Vars (c,t,freevars)
      end
|   refine_simple_constr constr _ _ = raise Not_A_Simple_Constraint constr
;

fun update_refine_constr scratch env allsimple =
      let val (exist_simple,simple,newscratch) = try_find_simple scratch env
      in if exist_simple then 
           let val env' = change_scratch newscratch env
           in update_refine_constr (refine_simple_constr simple newscratch env') env' (simple::allsimple)
           end
         else (scratch,allsimple)
      end
;

fun add_udefs_symbols ((UPrim def)::l) info =
      add_udefs_symbols l (add_new_uprim_info def info)
|   add_udefs_symbols ((UAbbr def)::l) info =
      add_udefs_symbols l (add_new_uabbr_info def info)
|   add_udefs_symbols (def::l) info = raise Not_U_definition def
|   add_udefs_symbols [] info = info
;
fun get_all_defs  (Scratch(prims,defs,_,_))                = 
                      map UPrim prims @ map UAbbr defs;


(************** functions to add constraints to scratch **************)


fun refine_constraints_and_update (Scratch(prims,defs,l,deps)) (env as Env(p,a,i,_,back)) = 
      let val l' = refine_constraints l env
          val (refined_scratch,constraints) = update_refine_constr (Scratch(prims,defs,l',deps)) env []
      in Env(p,a,add_udefs_symbols (get_all_defs refined_scratch) i,refined_scratch,back)
      end
;
(**************************************************************************)
(************* BACKTRACKING OF THE SCRATCH AREA DEFINITIONS ***************)
(**************************************************************************)


(*
fun make_new_scratch envdefs (env as Env(p,a,i,_,newbacktrack)) =
      let val newscratch = add_visible_defs envdefs start_scratch
          val env' = Env(p,a,i,newscratch,newbacktrack)
      in refine_constraints_and_update (recompute_constraints newscratch env') env'
      end
;
*)      

fun make_new_scratch envdefs (env as Env(p,a,i,_,newbacktrack)) =
      let val (newscratch,newenv) = add_visible_defs envdefs start_scratch (Env(p,a,i,start_scratch,newbacktrack))
      in refine_constraints_and_update newscratch newenv
      end
;

(* 
val (def::deflist)=deflist;
val env = check_and_add_definition def env true;
*)

fun check_and_add_unsures (def::defs) info env newdefs =
      let val (newdef,newenv) = add_def_to_backtrack def env
                                handle error => raise Error_in_DEF (error,name_of_DEF def)
      in check_and_add_unsures defs info newenv (newdef::newdefs)
      end
|    check_and_add_unsures [] (info as (_,_,AL)) (env as Env(p,a,i,scratch,backtrack)) newdefs = 
       let val newinfo = remove_info (get_scratch_names scratch @ name_of_env_kind_list newdefs) i
           val env' = Env(p,a,newinfo,start_scratch,backtrack)
           val newenv = make_new_scratch (rev newdefs) env'
       in (get_all_defs (get_scratch newenv),newenv)
       end
;

fun check_and_add_unsure_list R env =
      case PARSER_BACKTRACK R of
        (Res((info,deflist),[])) => 
            check_and_add_unsures deflist info env []
      | (Res(_,R)) => raise Syntax_error("Unexpected end.",R)
      | Fail(s,R) => raise Syntax_error(s,R)
;
fun load_scratch filename env = 
      check_and_add_unsure_list (lexanal (read_file filename)) env;

fun do_load_scratch filename (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = load_scratch filename env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;


(*********** functions to look up definition by its idnumber **********)

fun look_up_C_id (id as (_,n)) ((def as CTyp(_,_,_,id',_))::l) = 
      if n = id' then def else look_up_C_id id l
|   look_up_C_id id (_::l) = look_up_C_id id l
|   look_up_C_id id [] = raise id_number_not_found ("look_up_C_id", id)
;

fun look_up_Con_id (id as (name,idnr)) ((def as CTyp(name',_,_,_,cl))::l) = 
      let fun look_up idnr ((def as ConTyp(_,_,_,id))::l) = 
                if idnr = id then (name,def) else look_up idnr l
          |   look_up _ [] = raise id_number_not_found ("look_up_Con_id.look_up", id)
      in if name = name' then look_up idnr cl else look_up_Con_id id l
      end
|   look_up_Con_id id (_::l) = look_up_Con_id id l
|   look_up_Con_id id [] = raise id_number_not_found ("look_up_Con_id", id)
;

fun look_up_I_id (id as (_,n)) ((def as ITyp(_,_,_,id',_))::l) = 
      if n = id' then def else look_up_I_id id l
|   look_up_I_id id (_::l) = look_up_I_id id l
|   look_up_I_id id [] = raise id_number_not_found ("look_up_I_id", id)
;

fun look_up_P_id (name,id) (ITyp(name',_,_,_,pattl)::l) = 
      if name = name' then look_up_Plist id pattl
      else look_up_P_id (name,id) l
|   look_up_P_id id (_::l) = look_up_P_id id l
|   look_up_P_id id [] = raise id_number_not_found ("look_up_P_id", id)
and look_up_Plist id ((def as IDef(_,_,_,_,id'))::l) =
      if id = id' then def else look_up_Plist id l
|   look_up_Plist id [] = raise id_number_not_found ("look_up_Plist", ("",id))
;

fun look_up_E_id (id as (_,n)) ((def as EDef(_,_,_,_,id'))::l) = 
      if n = id' then def else look_up_E_id id l
|   look_up_E_id id (_::l) = look_up_E_id id l
|   look_up_E_id id [] = raise id_number_not_found ("look_up_E_id", id)
;

fun look_up_T_id (id as (_,n)) ((def as TDef(_,_,_,id'))::l) = 
      if n = id' then def else look_up_T_id id l
|   look_up_T_id id (_::l) = look_up_T_id id l
|   look_up_T_id id [] = raise id_number_not_found ("look_up_T_id", id)
;

fun look_up_DC_id (id as (_,n)) ((def as CDef(_,_,id'))::l) = 
      if n = id' then def else look_up_DC_id id l
|   look_up_DC_id id (_::l) = look_up_DC_id id l
|   look_up_DC_id id [] = raise id_number_not_found ("look_up_DC_id", id)
;

fun look_up_DS_id (id as (_,n)) ((def as SDef(_,_,_,_,id'))::l) = 
      if n = id' then def else look_up_DS_id id l
|   look_up_DS_id id (_::l) = look_up_DS_id id l
|   look_up_DS_id id [] = raise id_number_not_found ("look_up_DS_id", id)
;

fun only_new_defs (Env(prims,abbrs,Info(_,_,(new_defs,last_id),_),_,_)) =
      let fun get_new ((C_id n)::l) l' = get_new l ((Prim (look_up_C_id n prims))::l')
          |   get_new ((Con_id n)::l) l' = get_new l ((Constr (look_up_Con_id n prims))::l')
          |   get_new ((I_id n)::l) l' = get_new l ((Prim (look_up_I_id n prims))::l')
          |   get_new ((P_id n)::l) l' = get_new l ((Patt (look_up_P_id n prims))::l')
          |   get_new ((E_id n)::l) l' = get_new l ((Abbr (look_up_E_id n abbrs))::l')
          |   get_new ((T_id n)::l) l' = get_new l ((Abbr (look_up_T_id n abbrs))::l')
          |   get_new ((DC_id n)::l) l' = get_new l ((Abbr (look_up_DC_id n abbrs))::l')
          |   get_new ((DS_id n)::l) l' = get_new l ((Abbr (look_up_DS_id n abbrs))::l')
          |   get_new [] l = l
      in get_new new_defs []
      end
;

fun print_file_prim (CTyp(name,t,c,_,_)) = 
      name^" : "^print_typ t^"     "^print_def_context c^"    C"
|   print_file_prim (ITyp(name,t,c,_,_)) = 
      name^" : "^print_typ t^"     "^print_def_context c^"    I"
;

fun print_file_constr (ConTyp(name,t,c,_)) = 
      name^" : "^print_typ t^"     "^print_def_context c^"    C"
;




fun print_new_def (Abbr def) = "\n"^print_abbr def
|   print_new_def (Prim def) = "\n"^print_file_prim def
|   print_new_def (Constr (s,def)) = "   "^print_file_constr def
|   print_new_def (Patt def) = print_idef def
|   print_new_def _ = raise Unsure_in_theory
;

fun print_rev_list pf [] = "\n"
|   print_rev_list pf (b::l) = "\n" ^pf b ^print_rev_list pf l
;

fun print_new_definitions l = print_rev_list print_new_def l;


fun print_to_file filename env =
     let val env_kind_list = only_new_defs env
     in if null env_kind_list 
          then raise Nothing_to_save filename
          else let val outstr = open_out filename
               in (output (outstr,print_new_definitions env_kind_list);
		   close_out outstr)
               end
     end 
 ;
  
fun do_save filename (flag,coml,env,oldenv) =
      ((print_to_file filename env;myprint "#Ok!") handle error => errormessage error ;
      (flag,coml,env,oldenv))
;
 
fun ppairlist l = 
     let fun ppl [(a,b)] = "("^a^","^b^")"
         |   ppl ((a,b)::l') = "("^a^","^b^")"^","^ppl l'
         |   ppl [] = ""
     in "["^ppl l^"]"
     end
;


fun print_info (Deps(_,CN,YN,_,_)) (Deps(AL,_,_,_,_)) =
     "\n#VN# "^plist (filter visible_name YN @ CN)^
     "\n#YN# "^plist YN^
     "\n#AL# "^ppairlist AL^"\n"
;
fun get_back_deps (Env(_,_,_,_,Back(_,_,deps)))            = deps;

fun print_file_u_prim (UCTyp(name,t,c,_)) = 
      name^" : "^print_utyp t^"     "^print_def_context c^"    C"
|   print_file_u_prim (UITyp(name,t,c,_)) = 
      name^" : "^print_utyp t^"     "^print_def_context c^"    I"
;

fun print_file_wpatt (WPatt(id,DefC,C,patt,def,t)) =
      let val pattname = mkname id
      in pattname^" : "^print_def_context DefC^"   "^print_context C^"   "
         ^print_exp patt^"   "^print_typ t^"=\n       "^print_wdefinition pattname def
      end
and print_wdefinition pattname (WUnknown) =  "?"   (*mk_invisible_name pattname*)
|   print_wdefinition _ (WExpr e) = print_exp e
|   print_wdefinition _ (WCase(e,t,wpl)) = 
      "case "^print_exp e^" : "^print_typ t^" of"^print_list print_file_wpatt wpl^"\nend"
;

fun print_file_u_constr setname (UConTyp(name,t,c)) = 
      name^" : "^print_utyp t^"     "^print_def_context c^"    C."^setname
;

fun print_file_env_kind (Abbr def) = "\n"^print_abbr def
|   print_file_env_kind (UAbbr def) = "\n"^print_u_abbr def
|   print_file_env_kind (Prim def) = "\n"^print_file_prim def
|   print_file_env_kind (UPrim def) = "\n"^print_file_u_prim def
|   print_file_env_kind (Patt def) = print_idef def
|   print_file_env_kind (UPatt def) = "   "^print_file_wpatt def
|   print_file_env_kind (Constr (_,def)) = "   "^print_file_constr def
|   print_file_env_kind (UConstr (setname,def)) = "   "^print_file_u_constr setname def
;

fun get_constructors_and_patterns (UCTyp(c,t,DefC,cl)::l) others =
       let val (prims',others') = get_constructors_and_patterns l others
       in (UCTyp(c,t,DefC,[])::prims',map (fn d => UConstr(c,d)) cl @ others')
       end
|   get_constructors_and_patterns (UITyp(c,t,DefC,wpl)::l) others =
       let val (prims',others') = get_constructors_and_patterns l others
       in (UITyp(c,t,DefC,[])::prims',map UPatt wpl @ others')
       end
|   get_constructors_and_patterns [] others = ([],others)
;


fun sort_in_order u_abbr u_prims deps = 
      let val (new_u_prims,others) = get_constructors_and_patterns u_prims []
      in get_sorted_order (topologic_sort deps (map name_of_u_prim u_prims)) u_abbr new_u_prims others
      end
;

fun print_backtrack_in_order (Back(u_prims,u_abbr,deps)) =
       print_rev_list print_file_env_kind (sort_in_order u_abbr u_prims deps)^"\n"
;
      

(*********** printing of scratch area ***************)


fun print_scratch (Scratch(uprims,u_abbr,[],deps)) =
       print_list print_u_prim uprims^"\n"^
       print_list print_u_abbr u_abbr^"\n"
|   print_scratch (Scratch(uprims,u_abbr,env_constr,deps)) =
       print_list print_u_prim uprims^"\n"^
       print_list print_u_abbr u_abbr^"\n"^
       "(**** constraints ****\n"^
       print_env_constraint env_constr^
       "\n**** end constraints ****)\n"
;

fun print_scratch_to_file filename (Env(_,_,_,Scratch([],[],_,_),_)) =
       raise Nothing_to_save filename
|   print_scratch_to_file filename (env as Env(_,_,_,scratch,backtrack)) =
      let val outstr = open_out filename
      in (output (outstr,
            "\n(********* SCRATCH AREA FOR BACKTRACKING ***********)\n"^
            print_info (get_deps env) (get_back_deps env)^
            (print_backtrack_in_order backtrack )^
            "\n(********* VISIBLE SCRATCH AREA FOR READING ********\n"^
            (print_scratch scratch)^
            "\n ********* END VISIBLE SCRATCH AREA  ********)\n");
	    close_out outstr)
      end
;

fun do_save_scratch filename (flag,coml,env,oldenv) =
      ((print_scratch_to_file filename env;myprint "#Ok!") handle error => errormessage error ;
      (flag,coml,env,oldenv))
;

fun look_up_u_name name env =
      look_up_u_prim name env
      handle (look_up_prim_error name) => UAbbr(look_up_u_abbr name env)
;

fun forall p nil = true                        		(* ('a -> bool) ->    *)
  | forall p (x :: xs) = p x andalso forall p xs;


fun unknown_depends_on name ((x,(T,E))::l) =
      if name = x then (filter (not o visible_name) (union(T,E))) else unknown_depends_on name l
|   unknown_depends_on name [] = []
;

fun type_depends_on name ((x,(T,E))::l) =
      if name = x then T else type_depends_on name l
|   type_depends_on name [] = []
;

fun iscomplete (deps as Deps(VN,CN,YN,DO,DDO)) name = 
      not (mem YN name) andalso
      null (unknown_depends_on name DDO) andalso 
      forall (iscomplete deps) (type_depends_on name DDO)
;
       

fun iscomplete_def name env = 
      case look_up_u_name name env of
        (UPrim(UITyp(c,_,_,[]))) => raise No_patterns c
      | (UPrim(UCTyp(_,_,_,cl))) => 
           let val deps = get_deps env
           in forall (iscomplete deps) (map name_of_u_constr cl) andalso iscomplete deps name
           end 
     | _ => iscomplete (get_deps env) name
;

(********** functions to change, insert or remove a definition ************)

fun all_complete_defs [] _ = true
|   all_complete_defs (d::defs) env = 
      iscomplete_def d env andalso all_complete_defs defs env
;


(******************* Insert_definition functions *************************)
(* dela upp c + c's lemmor fr}n resten av scratch, ta bort fr}n deps *)
(* obs! se till att kommer i r{tt ordning, s} c {r sist i listan! *)

fun get_constructor_names c (UCTyp(c',_,_,cl)::l) = 
      if c = c' then map name_of_u_constr cl
      else get_constructor_names c l
|   get_constructor_names c (d::l) = get_constructor_names c l
|   get_constructor_names c [] = []
;

fun get_all_constructor_names [] _ = []
|   get_all_constructor_names (c::l) uprims = 
      get_constructor_names c uprims @ get_all_constructor_names l uprims
;

fun get_all_dependent deps clist = 
      let fun get_dep (deps as Deps(VN,CN,YN,DO,DDO)) c deplist =
                if mem deplist c then []
                else let val depends_on = union(term_depends_on c DDO,type_depends_on c DDO)
                     in all_dep deps depends_on (union(deplist,depends_on))
                     end
          and all_dep deps (c::l) deplist =
                if mem deplist c then all_dep deps l deplist
                else let val c_l = get_dep deps c deplist
                         val deplist' = all_dep deps c_l (union(c_l,deplist))
                     in all_dep deps l (union(deplist',deplist))
                     end
          |   all_dep deps [] deplist = deplist
      in union(clist,all_dep deps clist [])
      end
;


fun all_mem visibles (a::l) = mem visibles a andalso all_mem visibles l
|   all_mem visibles [] = true
;


fun get_completes_in_order (name::l) u_abbr prims others =
      let val (def,arest,prest,orest) = find_one_u_def name u_abbr prims others
          val (cdefs,abbrs',prims') = get_completes_in_order l arest prest orest
      in (def::cdefs,abbrs',prims')
      end
|   get_completes_in_order [] abbrs prims others = (rev others,abbrs,prims)
;

fun update_delete_list (name::l) deps =
      update_delete_list l (update_delete name deps)
|   update_delete_list [] deps = deps
;

fun delete_complete_defs clist (scratch as Scratch(uprims,uabbrs,constr,deps)) = 
      let val newclist = clist @ get_all_constructor_names clist uprims
          val all = get_all_dependent deps newclist
      in if all_mem newclist all then
          let val l = union(newclist,all)
              val sort_l = filter (mem l) (topologic_sort deps (map name_of_u_prim uprims))
              val (complete_defs,defs',prims') = get_completes_in_order sort_l uabbrs uprims []
          in (complete_defs,
              Scratch(prims',defs',constr,update_delete_list (rev sort_l) deps),
              sort_l)
          end
         else raise Must_Complete_these_definitions (newclist,minus all newclist)
      end
;

fun get_unknowns_depends_on name (Deps(_,CN,YN,DO,DDO)) =
      unknown_depends_on name DDO
;

fun get_all_unknown_depends_on (c::l) deps =
      union(get_unknowns_depends_on c deps,get_all_unknown_depends_on l deps)
|   get_all_unknown_depends_on [] deps = []
;

fun delete_inserted_uprims l (def::defs) =
      if mem l (name_of_u_prim def) then delete_inserted_uprims l defs
      else def::delete_inserted_uprims l defs
|   delete_inserted_uprims _ [] = []
;

fun delete_inserted_uabbrs l (def::defs) =
      if mem l (name_of_u_abbr def) then delete_inserted_uabbrs l defs
      else def::delete_inserted_uabbrs l defs
|   delete_inserted_uabbrs _ [] = []
;

fun delete_inserted_defs l visibles_left (Back(uprims,defs,deps)) =
      let val total_l = l @ get_all_unknown_depends_on l deps
      in if any_mem visibles_left total_l then raise
           Must_Complete_these_definitions (filter visible_name l,filter (mem visibles_left) total_l)
         else Back(delete_inserted_uprims total_l uprims,
                   delete_inserted_uabbrs total_l defs,update_delete_list total_l deps)
      end
;
fun get_visibles (Scratch(_,_,_,Deps(_,CN,YN,_,_))) = 
      (filter visible_name CN) @ (filter visible_name YN);



fun U_Abbr_to_Abbr (UEDef(name,D e,t,DefC)) = EDef(name,e,t,DefC,0)
|   U_Abbr_to_Abbr (UTDef(name,DT t,DefC)) = TDef(name,t,DefC,0)
|   U_Abbr_to_Abbr (UCDef(name,DefC)) = CDef(name,DefC,0)
|   U_Abbr_to_Abbr (USDef(name,DefS,DefC1,DefC2)) = SDef(name,DefS,DefC1,DefC2,0)
|   U_Abbr_to_Abbr def = raise Insert_Incomplete [name_of_u_abbr def]
;(********** COMPLETE DEFS NEED NOT BE TYPECHECKED *************)

fun add_complete_abbr_to_env def (env as Env(prims,abbrs,info,scr1,scr2)) =
        let val (newinfo,newdef) = mark_new_abbr def info true false
        in Env(prims,newdef::abbrs,newinfo,scr1,scr2)
        end
;

fun U_Constr_to_Constr (UConTyp(name,DT t,DefC)) = ConTyp(name,t,DefC,0)
|   U_Constr_to_Constr (UConTyp(name,_,_)) = raise Insert_Incomplete [name]
;

fun wpatt_to_patt env (WPatt(id,DefC,Con C,u,WExpr e,t)) = 
      IDef(u,Expr e,t,append_context (unfold_defcontext DefC env) C,0)
|   wpatt_to_patt env (WPatt(id,DefC,Con C,u,WCase(e,et,wpl),t)) = 
      IDef(u,Case(e,et,wcase_to_case env wpl),t,append_context (unfold_defcontext DefC env) C,0)
|   wpatt_to_patt _ p = raise Insert_Incomplete [id_of_wpatt p]
and wcase_to_case _ [] = []
|   wcase_to_case env (WPatt(id,DefC,C,u,WExpr e,t)::l) = 
       (u,Expr e)::wcase_to_case env l
|   wcase_to_case env (WPatt(id,DefC,C,u,WCase(e,et,wpl),t)::l) =
       (u,Case(e,et,wcase_to_case env wpl))::wcase_to_case env l
|   wcase_to_case _ (p::_) = raise Insert_Incomplete [id_of_wpatt p]
;

fun U_Prim_to_Prim (UCTyp(name,DT t,DefC,cl)) env =
      CTyp(name,t,DefC,0,map U_Constr_to_Constr cl)
|   U_Prim_to_Prim (UITyp(name,DT t,DefC,wpatts)) env =
      ITyp(name,t,DefC,0,map (wpatt_to_patt env) wpatts)
|   U_Prim_to_Prim def _ = raise Insert_Incomplete [name_of_u_prim def]
;

fun add_complete_prim_to_env def (env as Env(prims,abbrs,info,scr1,scr2)) =
        let val (newinfo,newdef) = mark_new_prim def info true false
        in Env(newdef::prims,abbrs,newinfo,scr1,scr2)
        end
;

fun add_complete_constr_to_env def setname (env as Env(prims,abbrs,info,scr1,scr2)) =
        let val (newinfo,newdef) = mark_new_constr def info true setname false
            val (_,newprims) = add_constr_to_prims setname newdef prims
        in Env(newprims,abbrs,newinfo,scr1,scr2)
        end
;

fun add_complete_patt_to_env def (env as Env(prims,abbrs,info,scr1,scr2)) =
        let val (newinfo,newdef) = mark_new_patt def info true
            val newprims = add_patt_to_prims newdef prims
        in Env(newprims,abbrs,newinfo,scr1,scr2)
        end
;

fun add_completes_to_env ((UAbbr def)::l) env =
      let val newdef = U_Abbr_to_Abbr def
          val newenv = add_complete_abbr_to_env newdef env
          val (defl,env') = add_completes_to_env l newenv
      in ((name_of_abbr newdef)::defl,env')
      end
|   add_completes_to_env ((UPrim def)::l) env = 
      let val newdef =  U_Prim_to_Prim def env
          val newenv = add_complete_prim_to_env newdef env
          val (defl,env') = add_completes_to_env l newenv
      in ((name_of_prim newdef)::defl,env')
      end
|   add_completes_to_env ((UConstr(setname,def))::l) env =
      let val newdef =  U_Constr_to_Constr def
          val newenv = add_complete_constr_to_env newdef setname env
          val (defl,env') = add_completes_to_env l newenv
      in (defl,env')
      end
|   add_completes_to_env ((UPatt def)::l) env =
      let val newdef =  wpatt_to_patt env def
          val newenv = add_complete_patt_to_env newdef env
          val (defl,env') = add_completes_to_env l newenv
      in (defl,env')
      end
|   add_completes_to_env (def::_) _ = raise Not_U_definition def
|   add_completes_to_env [] env = ([],env)
;

fun insert_def_to_env clist (env as Env(prims,abbrs,info,scratch,backtrack)) = 
     let val (complete_defs,newscratch,l) = delete_complete_defs clist scratch
         val newbacktrack = delete_inserted_defs l (get_visibles newscratch) backtrack
      in add_completes_to_env complete_defs
         (Env(prims,abbrs,info,newscratch,newbacktrack))
      end
;

fun move_defs_to_env namelist env =
      if all_complete_defs namelist env then 
         insert_def_to_env namelist env
      else raise Insert_Incomplete (filter (fn c => not (iscomplete_def c env)) namelist)
;

fun empty_scratch (Env(_,_,_,Scratch([],[],_,_),_)) = true
|   empty_scratch _ = false
;

fun look_up_names (name::l) env = look_up_name name env::look_up_names l env
|   look_up_names [] env = []
;

fun do_move_to_env namelist (flag,coml,env,oldenv) =
      let val (moved_defs,env') = move_defs_to_env namelist env
          val dummyfilename = "##BACKUP_ALF##.alf"
          val autosave = (print_to_file dummyfilename env';
                          if empty_scratch env' then ()
                          else print_scratch_to_file (dummyfilename^".scratch") env')
      in (show_defs (look_up_names moved_defs env');if undo flag then (flag,coml,env',UNDO env) else (flag,coml,env',oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun typepath s = s^ptype;
fun mktype_name name = mk_invisible_name (typepath name);
fun mknew_UTDef name context = UAbbr (UTDef(name,TUnknown,context));
val empty_context = DCon([],[]);
fun mknew_UEDef name tname context = UAbbr (UEDef(name,Unknown,TExpl(tname,[]),context));
;

fun add_scratch_abbr_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newscratch = add_u_abbr_to_scratch def scratch
          val newinfo = add_new_uabbr_info def info
      in Env(prims,abbrs,newinfo,newscratch,backtrack)
      end handle circular_definition => raise Circular_definition (UAbbr def);
;

fun add_scratch_prim_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newscratch = add_u_prim_to_scratch def scratch
          val newinfo = add_new_uprim_info def info
      in Env(prims,abbrs,newinfo,newscratch,backtrack)
      end handle circular_definition => raise Circular_definition (UPrim def);

fun add_scratch_constr_to_env def setname (env as Env(prims,abbrs,info,scratch,backtrack)) =
      if type_iscomplete setname env then 
        let val newscratch = add_u_constr_to_scratch def setname scratch
            val newinfo = add_new_uconstr_info def setname info
        in Env(prims,abbrs,newinfo,newscratch,backtrack)
        end handle circular_definition => raise Circular_definition (UConstr (setname,def))
      else raise Can't_add_constructor def
;

fun add_scratch_wpatt_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      if type_iscomplete (id_of_wpatt def) env then 
        let val newscratch = add_wpatt_to_scratch def scratch
        in Env(prims,abbrs,info,newscratch,backtrack)
        end 
      else raise Can't_add_wpattern def
;

fun add_scratch_def_to_env (UAbbr def) env = add_scratch_abbr_to_env def env
|   add_scratch_def_to_env (UPrim def) env = add_scratch_prim_to_env def env
|   add_scratch_def_to_env (UConstr(setname,def)) env = 
      add_scratch_constr_to_env def setname env
|   add_scratch_def_to_env (UPatt def) env = add_scratch_wpatt_to_env def env
|   add_scratch_def_to_env def env = raise Not_U_definition def
;

fun add_scratch_defs_to_env (def::scratch_defs) env =
      add_scratch_defs_to_env scratch_defs (add_scratch_def_to_env def env)
|   add_scratch_defs_to_env [] env = env
;
;

fun add_backtrack_abbr_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newbacktrack = add_u_abbr_to_backtrack def backtrack env
      in Env(prims,abbrs,info,scratch,newbacktrack)
      end
;
;

fun add_backtrack_prim_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newbacktrack = add_u_prim_to_backtrack def backtrack
      in Env(prims,abbrs,info,scratch,newbacktrack)
      end
;

fun add_backtrack_constr_to_env def setname (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newbacktrack = add_u_constr_to_backtrack def setname backtrack
      in Env(prims,abbrs,info,scratch,newbacktrack)
      end
;

fun add_backtrack_wpatt_to_env def (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newbacktrack = add_wpatt_to_backtrack def backtrack
      in Env(prims,abbrs,info,scratch,newbacktrack)
      end
;

fun add_backtrack_def_to_env (UAbbr def) env = add_backtrack_abbr_to_env def env
|   add_backtrack_def_to_env (UPrim def) env = add_backtrack_prim_to_env def env
|   add_backtrack_def_to_env (UConstr(setname,def)) env = 
      add_backtrack_constr_to_env def setname env
|   add_backtrack_def_to_env (UPatt def) env = add_backtrack_wpatt_to_env def env
|   add_backtrack_def_to_env def env = raise Not_U_definition def
;

fun add_back_defs_to_env (def::real_defs) env =
      add_back_defs_to_env real_defs (add_backtrack_def_to_env def env)
|   add_back_defs_to_env [] env = env
;

fun add_scratch_and_back_defs defs env = 
      add_scratch_defs_to_env defs (add_back_defs_to_env defs env)
;

fun add_new_exp name env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val Tname = mktype_name name
               val defs = [mknew_UTDef Tname empty_context,mknew_UEDef name Tname empty_context]
           in (defs,add_scratch_and_back_defs defs env)
           end
;

(*********** functions to extending the scratch area **************)

fun do_new_exp name (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_exp name env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun add_new_type name env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val defs = [mknew_UTDef name empty_context]
           in (defs,add_scratch_and_back_defs defs env)
           end
;

fun do_new_type name (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_type name env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun add_new_context name env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val defs = [UAbbr (UCDef(name,empty_context))]
           in (defs,add_scratch_and_back_defs defs env)
           end
;

fun do_new_context name (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_context name env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun do_new_subst def (flag,coml,env,oldenv) =
     (myprint "#ERROR: Not yet implemented.\n";(flag,coml,env,oldenv))
(*
      let val (newdefs,newenv) = add_new_subst def env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
*)
;

fun add_new_set name env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val Tname = mktype_name name
               val defs = [mknew_UTDef Tname empty_context,
                           UPrim (UCTyp(name,DT (TExpl(Tname,[])),empty_context,[]))]
           in (defs,add_scratch_and_back_defs defs env)
           end
;

fun do_new_set name (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_set name env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun add_new_constr name setname env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val Tname = mktype_name (setname^"."^name)
               val DefC = get_context_of_prim setname env
               val I = defcontext_names DefC
               val defs = [mknew_UTDef Tname DefC,
                           UConstr (setname,UConTyp(name,DT (TExpl(Tname,I)),DefC))]
               val env' = add_scratch_and_back_defs defs env
           in ((look_up_u_prim setname env')::defs,env')
           end
;

fun do_new_constr name setname (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_constr name setname env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun add_new_impl name env =
      if occurs (global_names env) name then raise Name_already_defined name
      else let val Tname = mktype_name name
               val defs = [mknew_UTDef Tname empty_context,
                                   UPrim (UITyp(name,DT (TExpl(Tname,[])),empty_context,[]))]
           in (defs,add_scratch_and_back_defs defs env)
           end
;

fun do_new_impl name (flag,coml,env,oldenv) =
      let val (newdefs,newenv) = add_new_impl name env
      in (show_defs newdefs;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun get_opened_theory_names (Env(prims,abbrs,Info(_,_,(new_defs,last_id),_),_,_)) =
      let fun names (c::l) l' = let val name = get_id_name c 
                                in if mem l' name then names l l'
                                   else names l (name::l')
                                end
          |   names [] l = l
      in names new_defs []
      end
;

fun used_in_exp cl (App(f,argl)) = used_in_exp cl f orelse exists (used_in_exp cl) argl
|   used_in_exp cl (Lam(_,e)) = used_in_exp cl e
|   used_in_exp cl (Let(vb,e)) = used_in_subst cl vb orelse used_in_exp cl e
|   used_in_exp cl (Can(c',_)) = mem cl c'
|   used_in_exp cl (Impl(c',_)) = mem cl c'
|   used_in_exp cl (Expl(c',_)) = mem cl c'
|   used_in_exp cl (Var _) = false
and used_in_subst cl ((_,e)::l) = used_in_exp cl e orelse used_in_subst cl l
|   used_in_subst cl [] = false
;

fun used_in_type cl (Prod(decl,t)) = 
      let fun used_in ((Arr t)::l) = used_in_type cl t orelse used_in l
          |   used_in ((Dep(_,t))::l) = used_in_type cl t orelse used_in l
          |   used_in [] = false
      in used_in decl orelse used_in_type cl t 
      end
|   used_in_type cl (Elem (_,e)) = used_in_exp cl e
|   used_in_type cl (TExpl(c',_)) = mem cl c'
|   used_in_type cl (TLet(vb,c',_)) = mem cl c' orelse used_in_subst cl vb
|   used_in_type cl (Sort _) = false
;

fun used_in_DefC cl (DCon(gcl,_)) =
      let fun used_in_C ((_,t)::l) = used_in_type cl t orelse used_in_C l
          |   used_in_C [] = false
          fun used_in ((CName (c',_))::l) =
               mem cl c' orelse used_in l
          |   used_in ((GCon C)::l) =
               used_in_C C orelse used_in l
          |   used_in [] = false
      in used_in gcl
      end
;

fun used_in_constr_list cl (ConTyp(_,t,DefC,_)::l) =
      used_in_type cl t orelse used_in_DefC cl DefC orelse used_in_constr_list cl l
|   used_in_constr_list cl [] = false
;

fun used_in_RHS cl (Expr e) = used_in_exp cl e
|   used_in_RHS cl (Case(e,t,dl)) = 
      used_in_exp cl e orelse used_in_type cl t orelse used_in_caselist cl dl
and used_in_caselist cl ((p,d)::l) = used_in_exp cl p orelse used_in_RHS cl d orelse used_in_caselist cl l
|   used_in_caselist cl [] = false
;

fun used_in_pattern_list cl ((IDef(e,def,t,C,_)::l)) =
      used_in_exp cl e orelse used_in_RHS cl def orelse used_in_pattern_list cl l
|   used_in_pattern_list cl [] = false
;

fun used_in_prim cl (CTyp(_,t,DefC,_,l)) =
      used_in_type cl t orelse used_in_DefC cl DefC orelse used_in_constr_list cl l
|   used_in_prim cl (ITyp(_,t,DefC,_,pl)) =
      used_in_type cl t orelse used_in_DefC cl DefC orelse used_in_pattern_list cl pl
;

fun used_in_prim_defs cl theorynames used_in (def::l) =
      let val name = name_of_prim def
      in if mem theorynames name then
           if used_in_prim cl def then used_in_prim_defs cl theorynames (name::used_in) l
           else used_in_prim_defs cl theorynames used_in l
         else used_in
      end
|   used_in_prim_defs cl theorynames used_in [] = used_in
;


fun used_in_DefS cl (SName s) = mem cl s
|   used_in_DefS cl (Comp (S1,S2)) = used_in_DefS cl S1 orelse used_in_DefS cl S2
|   used_in_DefS cl (GSubst l) = used_in_subst cl l
;

fun used_in_abbr cl (EDef(_,e,t,DefC,_)) =
      used_in_exp cl e orelse used_in_type cl t orelse used_in_DefC cl DefC
|   used_in_abbr cl (TDef(_,t,DefC,_)) =
      used_in_type cl t orelse used_in_DefC cl DefC
|   used_in_abbr cl (CDef(_,DefC,_)) = used_in_DefC cl DefC
|   used_in_abbr cl (SDef(_,S,DefC1,DefC2,_)) =
      used_in_DefS cl S orelse used_in_DefC cl DefC1 orelse used_in_DefC cl DefC2
;

fun used_in_abbr_defs cl theorynames used_in (def::l) =
      let val name = name_of_abbr def
      in if mem theorynames name then
           if used_in_abbr cl def then used_in_abbr_defs cl theorynames (name::used_in) l
           else used_in_abbr_defs cl theorynames used_in l
         else used_in
      end
|   used_in_abbr_defs cl theorynames used_in [] = used_in
;


fun used_in_defs cl (env as Env(prims,abbrs,_,_,_)) theorynames =
       (used_in_prim_defs cl theorynames [] prims) @ (used_in_abbr_defs cl theorynames [] abbrs)
;

fun constr_to_u_constr (ConTyp(name,t,DefC,_)) = UConTyp(name,DT t,DefC)
;

fun name_of_patt (IDef(p,_,_,_,_)) = name_of_head p;
fun next (x::l) = (x+1::l)
|   next _ = raise path_error;
fun nextpath (P(id,path)) = P(id,rev (next (rev path)));

fun fix_new_path c ((c',p)::l) = 
     if c = c' then 
       let val p' = nextpath p
       in (p',(c,p')::l)
       end
     else let val (p',l') = fix_new_path c l
          in (p',(c',p)::l')
          end
|  fix_new_path c [] = 
    let val p = P(c,[0])
    in (p,[(c,p)])
    end
;

fun remove_initial (Con l) (Con l') =
     let fun rem_init [] l = l
         |   rem_init (a::l) (b::l') =
               if a = b then rem_init l l'
               else raise move_patt_to_wpatt_error
         |   rem_init _ _ = raise move_patt_to_wpatt_error
     in Con (rem_init l l')
     end
;
fun nextdepth (P(id,path)) = P(id,path@[0]);

fun patts_to_wpatts ((IDef(patt,rhs,t,context,_))::l) DefC unfolded_DefC p env =
      let val C = remove_initial unfolded_DefC context
      in WPatt(p,DefC,C,patt,RHS_to_wpatt rhs t DefC C p env,t)::
          patts_to_wpatts l DefC unfolded_DefC (nextpath p) env
      end
|   patts_to_wpatts [] _ _ _ _ = []
and RHS_to_wpatt (Expr e) t DefC context p env = WExpr e
|   RHS_to_wpatt (Case (v,vtype,expl)) T DefC (Con C) p env =
     (case (unfold_type vtype env)  of 
           (Elem(s,A)) => WCase(v,vtype,pattl_to_wpattl expl DefC (Con C) v A T (nextdepth p) env)
         | t => raise Not_elem_type t)
and pattl_to_wpattl ((p,def)::l) DefC (Con C) v A T path env =
      let val DefC' = add_contexts DefC C
          val (Con C1',t,newp) = pattern_context p (unfold_defcontext DefC' env) env
           val (new_env,S) = create_new_scratch DefC' (Con C1') env
           val I = defcontext_names DefC'
           val newpattern = inst I S newp
           val newt = inst_type I S t
           val constr = type_check newpattern newt DefC I new_env
       in case constr of
            (Ok cl) => 
              let val (Con C',subst) = 
                     split_definitions (add_constraint_and_refine cl new_env) [] [] new_env
                  val I' = defcontext_names DefC @ (map fst C')
              in  case (inst_type I' subst t) of
                          (Elem(s,B)) =>
                              let val (newC,S) = unification DefC (Con (C@C')) B A (Sort "Set") env
                                  val I = defcontext_names DefC @ context_names newC
                                  val newT = inst_type I S T    
                                  val instP = inst I S newp
                              in case v of
                                    (Var z) => 
                                       let val newC' = inst_and_rem_context (z,instP) newC I
                                           val newT' = inst_type I [(z,instP)] newT
                                       in (WPatt(path,DefC,newC',p,RHS_to_wpatt def newT' DefC newC' path env,newT'))::
                                             pattl_to_wpattl l DefC (Con C) v A T (nextpath path) env
                                       end
                                   | _ => WPatt(path,DefC,newC,p,RHS_to_wpatt def newT DefC newC path env,newT)::
                                             pattl_to_wpattl l DefC (Con C) v A T (nextpath path) env
                              end
                        | t => raise Not_elem_type t
              end
          | notequals => raise Constraint_after_backtrack notequals
       end
|   pattl_to_wpattl [] DefC C _ _ _ p env = []
;

fun abbr_to_u_abbr (EDef(name,e,t,DefC,_)) = UEDef(name,D e,t,DefC)
|   abbr_to_u_abbr (TDef(name,t,DefC,_)) = UTDef(name,DT t,DefC)
|   abbr_to_u_abbr (CDef(name,DefC,_)) = UCDef(name,DefC)
|   abbr_to_u_abbr (SDef(name,DefS,DefC1,DefC2,_)) = USDef(name,DefS,DefC1,DefC2)
;

fun prim_to_u_prim (CTyp(name,t,DefC,_,_)) env = UCTyp(name,DT t,DefC,[])
|   prim_to_u_prim (ITyp(name,t,DefC,_,_)) env = UITyp(name,DT t,DefC,[])
;

fun get_defs_to_move clist ((Constr(setname,def))::l) env pattpaths =
      if mem clist setname then 
        (UConstr(setname,constr_to_u_constr def))::get_defs_to_move clist l env pattpaths 
      else get_defs_to_move clist l env pattpaths
|   get_defs_to_move clist ((Patt def)::l) env pattpaths =
      let val c = name_of_patt def
      in if mem clist c then 
           let val DefC = get_context_of_prim c env
               val unfoldedDefC = unfold_defcontext DefC env
               val (path,pattpaths') = fix_new_path c pattpaths
               val wpatt = case patts_to_wpatts [def] DefC unfoldedDefC path env of
		 wpatt :: _ => wpatt
	       | _ => raise Bind
           in (UPatt wpatt)::get_defs_to_move clist l env pattpaths'
           end
         else get_defs_to_move clist l env pattpaths
     end
|   get_defs_to_move clist ((Abbr def)::l) env  pattpaths = 
      if mem clist (name_of_abbr def) then 
        (UAbbr (abbr_to_u_abbr def))::get_defs_to_move clist l env pattpaths
      else get_defs_to_move clist l env pattpaths
|   get_defs_to_move clist ((Prim def)::l) env pattpaths =
      if mem clist (name_of_prim def) then 
        (UPrim (prim_to_u_prim def env))::get_defs_to_move clist l env pattpaths
      else get_defs_to_move clist l env pattpaths
|   get_defs_to_move clist (_::l) env pattpaths = get_defs_to_move clist l env pattpaths
|   get_defs_to_move clist [] env pattpaths = []
;

fun add_u_defs_to_env (def::defs) env = 
       add_u_defs_to_env defs (add_u_def_to_env def env)
|   add_u_defs_to_env [] env = env
;

fun move_to_scratch clist (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val all_defs_in_order = only_new_defs env
          val move_defs = get_defs_to_move clist all_defs_in_order env []
          val prims' = filter (fn d => not (mem clist (name_of_prim d))) prims
          val abbrs' = filter (fn d => not (mem clist (name_of_abbr d))) abbrs
          val newinfo = remove_info (name_of_env_kind_list move_defs) info
          val env' = Env(prims',abbrs',newinfo,scratch,backtrack)
      in add_u_defs_to_env move_defs env' 
      end
;


(*************** functions to check if a definition is movable to the scratch *****************)

fun move_defs_to_scratch clist (env as Env(prims,abbrs,i,scratch,backtrack)) =
      let val theory_names = get_opened_theory_names env
          val used_in = used_in_defs clist env theory_names
      in if all_mem clist used_in then move_to_scratch clist env
         else raise Theory_def_used_in (clist,minus used_in clist)
      end
;

fun look_up_scratch_defs env clist = map (fn c => look_up_u_name c env) clist;

fun do_move_to_scratch clist (flag,coml,env,oldenv) =
      let val newenv = move_defs_to_scratch clist env
      in (show_defs (look_up_scratch_defs newenv clist);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))



fun is_context_path (WP(c,[])) env = 
      (case get_id_kind c env of
         (true,Context_Abbr) => true
       | other => false)
|   is_context_path (WP(c,p)) env = hd (rev p) = Pcontext
;

fun change_context_in_uconstr DefC (UConTyp(c,DT t,DefC')) = UConTyp(c,DT t,DefC)
|   change_context_in_uconstr _ (UConTyp(c,TUnknown,DefC)) = 
       raise Not_Used_Anymore ("TUnknown in constr: "^c)
;

fun change_context_in_uconstrl cname DefC (cdef::cl) =
      if cname = name_of_u_constr cdef then change_context_in_uconstr DefC cdef::cl
      else cdef::change_context_in_uconstrl cname DefC cl
|   change_context_in_uconstrl cname DefC [] = raise path_error
;

fun change_context_in_uprim DefC (UCTyp(c,DT t,DefC',cl)) [Pcontext] =
      UCTyp(c,DT t,DefC,cl)
|   change_context_in_uprim DefC (UCTyp(c,DT t,DefC',cl)) [Pname cname,Pcontext] =
      UCTyp(c,DT t,DefC',change_context_in_uconstrl cname DefC cl)
|   change_context_in_uprim DefC (UITyp(c,DT t,DefC',wpl)) [Pcontext] =
      UITyp(c,DT t,DefC,wpl)
|   change_context_in_uprim DefC def p = def
;

fun change_context_in_uprims c p DefC (def::prims) =
      if c = name_of_u_prim def then (change_context_in_uprim DefC def p)::prims
      else def::change_context_in_uprims c p DefC prims
|   change_context_in_uprims c _ _ [] = []
;

fun remove_subgoals_in_uabbrs remlist (def::l) = 
      if mem remlist (name_of_u_abbr def) then remove_subgoals_in_uabbrs remlist l
      else def::remove_subgoals_in_uabbrs remlist l
|   remove_subgoals_in_uabbrs remlist [] = []
;

fun any_constructor c (UCTyp(_,_,_,cl)) = mem (map name_of_u_constr cl) c
|   any_constructor c _ = false
;


fun extendcontext (x::l) (Prod(Dep(y,t)::argt,T)) DefC = 
      extendcontext l (inst_type (defcontext_names DefC) [(y,Var x)] (fun_Prod(argt,T)))
                      (add_to_defcontext (x,t) DefC) 
|   extendcontext (x::l) (Prod(Arr t::argt,T)) DefC =
      extendcontext l (fun_Prod(argt,T)) (add_to_defcontext (x,t) DefC)
|   extendcontext [] T DefC = (DefC,T)
|   extendcontext (x::l) _ DefC = raise should_be_function_type
;

infix U;;
fun A U B = union(A,B);

(*
val defs0 = defs U defs0;
val DefC = add_to_defcontext (x,t') DefC;
val usednames=usednames';
val (Dep(x,t)::l) = l;
val (defs,t',usednames') = make_Tsubgoals t DefC usednames env;
*)

fun make_subgoals (Expl(c,l)) t DefC usednames env =
      if visible_name c then ([],Expl(c,l),usednames)
      else if c = qsym then 
             let val name = create qsym usednames "u"
             in ([UEDef(name,Unknown,t,DefC)],Expl(name,defcontext_names DefC),name::usednames)
             end
           else ([UEDef(c,Unknown,t,DefC)],Expl(c,l),usednames)
|   make_subgoals (App(Let(vb,f),argl)) t DefC usednames env =
      if name_of f = qsym then raise Can't_remove_head (App(Let(vb,f),argl))
      else 
        let val (defs,vb',usednames') = 
              make_subgoals_of_subst vb (get_context_of (name_of f) env) DefC usednames env
            val I = defcontext_names DefC
            val ftype = get_real_type (Let(vb',f)) DefC I env
        in case ftype of
            (Prod(argt,t')) =>
               let val (defs',argl',usednames'') = make_subgoals_list argl argt [] DefC usednames' env
               in (defs U defs',App(Let(vb',f),argl'),usednames'')
               end
           | _ => raise type_check_args_error
        end
|   make_subgoals (App(f,argl)) t DefC usednames env = 
      if name_of f = qsym then raise Can't_remove_head (App(f,argl))
      else 
        let val I = defcontext_names DefC
            val ftype = get_real_type f DefC I env 
                        handle (look_up_abbr_error _) => raise Can't_remove_head (App(f,argl))
        in case ftype of
            (Prod(argt,t')) =>
               let val (defs,argl',usednames') = make_subgoals_list argl argt [] DefC usednames env
               in (defs,App(f,argl'),usednames')
               end
           | _ => raise type_check_args_error
        end
|   make_subgoals (Lam(vl,e)) (Prod(argt,t)) DefC usednames env =
      let val (DefC',t') = extendcontext vl (Prod(argt,t)) DefC
          val (defs,e',usednames') = make_subgoals e t' DefC' usednames env
      in (defs,Lam(vl,e'),usednames')
      end
|   make_subgoals (Let(vb,e)) t DefC usednames env =
      if name_of e = qsym then raise Can't_remove_head (Let(vb,e))
      else 
        let val (defs,vb',usednames') = 
              make_subgoals_of_subst vb (get_context_of (name_of e) env) DefC usednames env
        in (defs,Let(vb',e),usednames')
        end
|   make_subgoals e t DefC usednames env = ([],e,usednames)
and make_subgoals_of_subst ((x,e)::l) C DefC usednames env =
      let val (defs,e',usednames') = make_subgoals e (type_from_context x C env) DefC usednames env
          val (defs',l',usednames'') = make_subgoals_of_subst l C DefC usednames' env
      in (defs U defs',(x,e')::l',usednames'')
      end
|   make_subgoals_of_subst [] C DefC usednames env = ([],[],usednames)
and make_subgoals_list (a::argl) (Dep(x,t)::l) S DefC usednames env =
      let val (defs,a',usednames') = 
            make_subgoals a (inst_type (defcontext_names DefC) S t) DefC usednames env
          val (defs',argl',usednames'') = 
            make_subgoals_list argl l ((x,a')::S) DefC usednames' env
      in (defs U defs',a'::argl',usednames'')
      end
|   make_subgoals_list (a::argl) ((Arr t)::l) S DefC usednames env =
      let val (defs,a',usednames') = 
            make_subgoals a (inst_type (defcontext_names DefC) S t) DefC usednames env
          val (defs',argl',usednames'') = make_subgoals_list argl l S DefC usednames' env
      in (defs U defs',a'::argl',usednames'')
      end
|   make_subgoals_list [] argt S DefC usednames env = ([],[],usednames)
|   make_subgoals_list _ _ _ _ _ _ = raise type_check_args_error
;

fun make_Tsubgoals (TExpl(c,l)) DefC usednames env =
      if visible_name c then ([],TExpl(c,l),usednames)
      else if c = qsym then 
             let val name = create qsym usednames "T"
             in ([UTDef(name,TUnknown,DefC)],TExpl(name,defcontext_names DefC),name::usednames)
             end
           else ([UTDef(c,TUnknown,DefC)],TExpl(c,l),usednames)
|   make_Tsubgoals (Elem(s,e)) DefC usednames env =
      let val (newdefs,e',usednames') = make_subgoals e (Sort s) DefC usednames env
      in (newdefs,Elem(s,e'),usednames')
      end
|   make_Tsubgoals (Prod(argt,t)) DefC usednames env =
      let val (defs,argt',DefC',usednames') = make_Tsubgoals_argt argt DefC usednames env
          val (defs',t',usednames'') = make_Tsubgoals t DefC' usednames' env
      in (defs U defs',Prod(argt',t'),usednames'')
      end
|   make_Tsubgoals t  DefC usednames env = ([],t,usednames)
and make_Tsubgoals_argt ((Arr t)::l) DefC usednames env =
      let val (defs,t',usednames') = make_Tsubgoals t DefC usednames env
          val (defs',l',DefC',usednames'') = make_Tsubgoals_argt l DefC usednames' env
      in (defs U defs',(Arr t')::l',DefC',usednames'')
      end
|   make_Tsubgoals_argt (Dep(x,t)::l) DefC usednames env =
      let val (defs,t',usednames') = make_Tsubgoals t DefC usednames env
          val (defs',l',DefC',usednames'') = make_Tsubgoals_argt l (add_to_defcontext (x,t') DefC) usednames' env
      in (defs U defs',Dep(x,t')::l',DefC',usednames'')
      end
|   make_Tsubgoals_argt [] DefC usednames env = ([],[],DefC,usednames)
;
 
fun make_Csubgoals (DCon (l,I)) usednames env = 
      let fun GCsubgoals ((x,t)::cl) names (l,I) defs =
                let val DefC = DCon(l,I)
                    val (defs',t',names') = make_Tsubgoals t DefC names env
                    val (DCon(l',I')) = add_to_defcontext (x,t') DefC
                in GCsubgoals cl names' (l',I') (defs U defs')
                end
          |   GCsubgoals [] names (l,I) defs = (defs,(l,I),names)
          fun Csubgoals ((CName C)::cl) names (l,I) defs = 
                Csubgoals cl names (l@[CName C],I@snd C) defs
          |   Csubgoals ((GCon C)::cl) names (l,I) defs = 
                let val (defs',(l',I'),names') = GCsubgoals C names (l,I) defs
                in Csubgoals cl names' (l',I') (defs U defs')
                end
          |   Csubgoals [] names (l',I) defs = (defs,(l',I),names)
          val (newdefs,(l',I'),usednames') = Csubgoals l (I@usednames) ([],[]) []
      in (newdefs,DCon(l',I'),usednames')
      end
;

fun mk_subgoals_and_deps_of_uconstr (UConTyp(c,DT t,DefC)) usednames env =
      let val (defs,DefC',usednames') = make_Csubgoals DefC usednames env
          val (defs',t',usednames'') = make_Tsubgoals t DefC' usednames' env
      in (defs U defs',UConTyp(c,DT t',DefC'),usednames'')
      end
|   mk_subgoals_and_deps_of_uconstr def usednames env = ([],def,usednames)
;

fun mk_subgoals_and_deps_of_uconstrl name (d::cl) usednames env =
      if name = name_of_u_constr d then
        let val (defs,d',usednames') = mk_subgoals_and_deps_of_uconstr d usednames env
        in (defs,d'::cl,usednames')
        end
      else let val (defs,cl',usednames') = mk_subgoals_and_deps_of_uconstrl name cl usednames env
           in (defs,d::cl',usednames')
           end
|   mk_subgoals_and_deps_of_uconstrl _ [] usednames env = ([],[],usednames)
;

fun mk_subgoals_and_deps_of_wpattl (d::wpl) usednames env =
      let val (defs,d',usednames') = mk_subgoals_and_deps_of_wpatt d usednames env
          val (defs',wpl',usednames'') = mk_subgoals_and_deps_of_wpattl wpl usednames' env
      in (defs U defs',d'::wpl',usednames'')
      end
|   mk_subgoals_and_deps_of_wpattl [] usednames env = ([],[],usednames)
and mk_subgoals_and_deps_of_wpatt (WPatt(p,DefC,Con C,patt,WExpr e,t)) usednames env =
      let val (newdefs,e',usednames') = make_subgoals e t (add_contexts DefC C) usednames env
      in (newdefs,WPatt(p,DefC,Con C,patt,WExpr e',t),usednames')
      end
|   mk_subgoals_and_deps_of_wpatt (WPatt(p,DefC',Con C,patt,WCase(e,et,wpl),t)) usednames env =
      let val DefC = add_contexts DefC' C
          val (defs,et',usednames') = make_Tsubgoals et DefC usednames env
          val (defs',e',usednames'') = make_subgoals e et' DefC usednames' env
          val (defs'',wpl',usednames''') = mk_subgoals_and_deps_of_wpattl wpl usednames'' env
      in (defs U defs' U defs'',WPatt(p,DefC',Con C,patt,WCase(e',et',wpl'),t),usednames''')
      end
|   mk_subgoals_and_deps_of_wpatt def usednames env = ([],def,usednames)
;


fun mk_subgoals_and_deps_of_uprim name (UCTyp(c,DT t,DefC,cl)) env = 
      if name = c then 
        let val usednames = global_names env
            val (defs,DefC',usednames') = make_Csubgoals DefC usednames env
            val (defs',t',usednames'') = make_Tsubgoals t DefC' usednames' env
        in (UCTyp(c,DT t',DefC',cl),defs U defs')
        end
      else let val usednames = global_names env
               val (defs,cl',usednames') = mk_subgoals_and_deps_of_uconstrl name cl usednames env
           in (UCTyp(c,DT t,DefC,cl'),defs)
           end
|   mk_subgoals_and_deps_of_uprim _ (UITyp(c,DT t,DefC,wpl)) env =
      let val usednames = global_names env
          val (defs,DefC',usednames') = make_Csubgoals DefC usednames env
          val (defs',t',usednames'') = make_Tsubgoals t DefC' usednames' env
          val (defs'',wpl',usednames''') = mk_subgoals_and_deps_of_wpattl wpl usednames'' env
      in (UITyp(c,DT t',DefC',wpl'),defs U defs' U defs'')
      end
|   mk_subgoals_and_deps_of_uprim _ def env = (def,[])
;

fun update_define_list (def::l) deps = update_define_list l (update_define def deps)
|   update_define_list [] deps = deps
;

fun make_subgoals_and_deps_of_uprim c (uprim::l) deps env =
      if c = name_of_u_prim uprim orelse any_constructor c uprim then
	let val (uprim',defs) = mk_subgoals_and_deps_of_uprim c uprim env
        in (uprim'::l,defs,update_prim uprim' (update_define_list defs deps))
        end
      else let val (l',defs,deps') = make_subgoals_and_deps_of_uprim c l deps env
           in (uprim::l',defs,deps')
           end
|   make_subgoals_and_deps_of_uprim c [] deps env = ([],[],deps)
;



fun subgoals_and_deps_of_uprim c (backtrack as Back(uprims,defs,deps)) env =
      let val (uprims',newdefs,deps') = make_subgoals_and_deps_of_uprim c uprims deps env
      in Back(uprims',newdefs U defs,deps')
      end
;

fun change_context_in_uabbr (UEDef(c,D e,t,_)) DefC = UEDef(c,D e,t,DefC)
|   change_context_in_uabbr (UEDef(c,Unknown,t,_)) DefC = UEDef(c,Unknown,t,DefC)
|   change_context_in_uabbr (UTDef(c,DT t,_)) DefC = UTDef(c,DT t,DefC)
|   change_context_in_uabbr (UTDef(c,TUnknown,_)) DefC = UTDef(c,TUnknown,DefC)
|   change_context_in_uabbr (UCDef(c,_)) DefC = UCDef(c,DefC)
|   change_context_in_uabbr def _ = def
;

fun change_context_and_remove_subgoals_in_uabbr c DefC remlist (def::defs) =
      let val defname = name_of_u_abbr def
      in if not (visible_name defname) then 
           if mem remlist defname then change_context_and_remove_subgoals_in_uabbr c DefC remlist defs
           else def::change_context_and_remove_subgoals_in_uabbr c DefC remlist defs
         else if c = defname then (change_context_in_uabbr def DefC)::
                change_context_and_remove_subgoals_in_uabbr c DefC remlist defs
              else def::change_context_and_remove_subgoals_in_uabbr c DefC remlist defs
      end
|   change_context_and_remove_subgoals_in_uabbr c _ _ [] = []
;

 

fun mk_subgoals_and_deps_of_uabbr (UEDef(c,D e,t,DefC)) env = 
      let val (defs,DefC',usednames) = make_Csubgoals DefC (global_names env) env
          val (defs',t',usednames') = make_Tsubgoals t DefC' usednames env
          val (defs'',e',_) = make_subgoals e t' DefC' usednames' env
      in (UEDef(c,D e',t',DefC'),defs U defs' U defs'')
      end
|   mk_subgoals_and_deps_of_uabbr (UEDef(c,Unknown,t,DefC)) env = 
      let val (defs,DefC',usednames) = make_Csubgoals DefC (global_names env) env
          val (defs',t',_) = make_Tsubgoals t DefC' usednames env
      in (UEDef(c,Unknown,t',DefC'),defs U defs')
      end
|   mk_subgoals_and_deps_of_uabbr (UTDef(c,DT t,DefC)) env =
      let val (defs,DefC',usednames) = make_Csubgoals DefC (global_names env) env
          val (defs',t',_) = make_Tsubgoals t DefC' usednames env
      in (UTDef(c,DT t',DefC'),defs U defs')
      end
|   mk_subgoals_and_deps_of_uabbr (UTDef(c,TUnknown,DefC)) env =
      let val (defs,DefC',_) = make_Csubgoals DefC (global_names env) env
      in (UTDef(c,TUnknown,DefC'),defs)
      end
|   mk_subgoals_and_deps_of_uabbr (UCDef(c,DefC)) env =
      let val (defs,DefC',_) = make_Csubgoals DefC (global_names env) env
      in (UCDef(c,DefC'),defs)
      end      
|   mk_subgoals_and_deps_of_uabbr def env = (def,[])
;
fun not_in_deps (Deps(DN,CN,YN,DO,DDO)) c = not (mem (CN@YN) c);


(********** need special change update after backtracking (does not use it always for efficiency) ****************)

fun update_change_define (UEDef(x,Unknown,t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_type_or_DefC UN t DefC
          val TL = retreive_undefined DO T YN
          val newYN = union([x],YN)
          val newCN = substract x CN
          val newDO = update_change x TL DO
          val newDDO = update_change x (T,[]) DDO
      in Deps(DN,newCN,newYN,newDO,newDDO)
      end
|   update_change_define (UEDef(x,D def,t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_type_or_DefC UN t DefC
          val L = is_in_the_term UN def
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = union([x],CN)
              val newDO = update_change x (union(DL,TL)) DO
              val newDDO = update_change x (T,L) DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
|   update_change_define (UTDef(x,TUnknown,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val TL = retreive_undefined DO T YN
          val newYN = union([x],YN)
          val newCN = substract x CN
          val newDO = update_change x TL DO
          val newDDO = update_change x (T,[]) DDO
      in Deps(DN,newCN,newYN,newDO,newDDO)
      end
|   update_change_define (UTDef(x,DT t,DefC)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN DefC
          val L = is_in_the_type UN t
          val DL = retreive_undefined DO L YN
          val TL = retreive_undefined DO T YN
      in if mem DL x then raise circular_definition
         else 
          let val newCN = union([x],CN)
              val newDO = update_change x (union(DL,TL)) DO
              val newDDO = update_change x (T,L) DDO
          in Deps(DN,newCN,YN,newDO,newDDO)
          end
      end
|   update_change_define (UCDef(x,C)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_DefC UN C
          val UT = retreive_undefined DO T YN
          val newCN = union([x],CN)
          val newDO = update_change x UT DO
          val newDDO = update_change x (T,[]) DDO
      in Deps(DN,newCN,YN,newDO,newDDO)
      end
|   update_change_define (USDef(x,DefS,DefC1,DefC2)) (Deps(DN,CN,YN,DO,DDO)) = 
      let val UN = CN @ YN
          val T = is_in_the_USDef UN DefS DefC1 DefC2
          val UT = retreive_undefined DO T YN
          val newCN = union([x],CN)
          val newDO = update_change x UT DO
          val newDDO = update_change x (T,[]) DDO
      in Deps(DN,newCN,YN,newDO,newDDO)
      end
  ;

fun make_subgoals_and_deps_of_uabbr c (uabbr::l) deps env =
      if c = name_of_u_abbr uabbr then
	let val (uabbr',newdefs) = mk_subgoals_and_deps_of_uabbr uabbr env
            val newdefs' = filter (fn d => not_in_deps deps (name_of_u_abbr d)) newdefs
        in (uabbr'::(newdefs' U l),update_change_define uabbr' (update_define_list newdefs' deps))
        end
      else let val (l',deps') = make_subgoals_and_deps_of_uabbr c l deps env
           in (uabbr::l',deps')
           end
|   make_subgoals_and_deps_of_uabbr c [] deps env = ([],deps)
;

fun subgoals_and_deps_of_uabbr c (backtrack as Back(uprims,defs,deps)) env =
      let val (defs',deps') = make_subgoals_and_deps_of_uabbr c defs deps env
      in Back(uprims,defs',deps')
      end
;

fun change_to_new_context (wp as WP(c,p)) DefC (backtrack as Back(uprims,defs,deps)) env =
      case look_up_u_name c env of
        (UPrim def) => 
           let val rlist = get_unknowns_depends_on c deps
               val back' = Back(change_context_in_uprims c p DefC uprims,
                                remove_subgoals_in_uabbrs rlist defs,
                                update_delete_list rlist deps)
           in subgoals_and_deps_of_uprim c back' env
           end
      | (UAbbr def) => 
          let val rlist = get_unknowns_depends_on c deps
              val back' = Back(uprims,
                               change_context_and_remove_subgoals_in_uabbr c DefC rlist defs,
                               update_delete_list rlist deps)
           in subgoals_and_deps_of_uabbr c back' env
           end
      | _ => raise Path_error ("look_up_name "^c^" failed")
;


(********** functions to remove and delete definitions ************)

fun split_prims_and_abbrs ((UPrim d)::l) (prims,abbrs) =
      split_prims_and_abbrs l (d::prims,abbrs)
|   split_prims_and_abbrs ((UAbbr d)::l) (prims,abbrs) =
      split_prims_and_abbrs l (prims,d::abbrs)
|   split_prims_and_abbrs ((UConstr (setname,d))::l) (prims,abbrs) =
      split_prims_and_abbrs l (add_constructor d setname prims,abbrs)
|   split_prims_and_abbrs ((UPatt d)::l) (prims,abbrs) =
      split_prims_and_abbrs l (add_wpatt_to_prims d prims,abbrs)
|   split_prims_and_abbrs (d::l) _ = raise Not_U_definition d
|   split_prims_and_abbrs [] (prims,abbrs) = (prims,abbrs)
;

fun sort_defs_in_order (Back(u_prims,u_abbr,deps)) =
      let val newlist = sort_in_order u_abbr u_prims deps
          val (new_u_prims,new_u_abbrs) = split_prims_and_abbrs newlist ([],[])
      in (newlist,Back(new_u_prims,new_u_abbrs,deps))
      end
;


fun make_change_context wpath DefC (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val backtrack' = change_to_new_context wpath DefC backtrack env
          val (orderedlist,newbacktrack) = sort_defs_in_order backtrack'
          val env' = Env(prims,abbrs,remove_info (get_scratch_names scratch) info,start_scratch,newbacktrack)
      in make_new_scratch orderedlist env'
      end
;
 
fun extend_context (wp as WP(c,p)) name env = 
      if is_context_path wp env then
        let val DefC = get_context_of c env
            val I = defcontext_names DefC
        in if mem I name then raise Name_already_in_context name
           else make_change_context wp (add_to_defcontext (name,TExpl(qsym,[])) DefC) env
        end
      else raise path_error
;

fun show_new_defs l = print_list show_new_def l;

fun show_constraint (EE(e1,e2,t,DefC)) =
      "#EConstraint: "^wprint_exp e1^" = "^wprint_exp e2^" : "^wprint_typ t^"   "^wprint_def_context DefC
|   show_constraint (TT(t1,t2,DefC)) =
      "#TConstraint: "^wprint_typ t1^" = "^wprint_typ t2^"   "^wprint_def_context DefC
;

fun wprint_scratch (Scratch(uprims,uabbrs,constr,_)) =
      (myprint (show_new_defs (map UPrim uprims));
       myprint (show_new_defs (map UAbbr uabbrs));
       myprint (print_rev_list show_constraint constr))
;fun do_extend_context wpath name (flag,coml,env,oldenv) =
      let val newenv = extend_context wpath name env
      in (wprint_scratch (get_scratch newenv);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))      
;

fun inst_context I S ((x,t)::l) = (x,inst_type I S t)::inst_context (x::I) S l
|   inst_context I S [] = []
;

fun change_qsymVar_to_qsymExpl (DCon(l,I)) =
      let fun change ((CName C)::l) = (CName C)::change l
          |   change ((GCon C)::l) = 
                (GCon (inst_context [] [(qsym,Expl(qsym,[]))] C))::change l
          |   change [] = []
      in DCon(change l,I)
      end
;
      

fun change_context wpath DefC env = 
     if is_context_path wpath env then
       make_change_context wpath (change_qsymVar_to_qsymExpl DefC) env
     else raise path_error
;

fun do_change_context wpath cDefC (flag,coml,env,oldenv) =
      let val newenv = change_context wpath (fst (convert_DefC cDefC env))  env
      in (wprint_scratch (get_scratch newenv);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))      
;

(************************************************************)
(****************** COMMAND DATATYPE ************************)
(************************************************************)
	
datatype INFOSORT = CInfo of DEF_CONTEXT
                  | TCInfo of TYP * DEF_CONTEXT
                  | ETCInfo of EXP * TYP * DEF_CONTEXT
                  | TGoal of string * DEF_CONTEXT
                  | EGoal of string * TYP * DEF_CONTEXT
;
fun find_index_in_list 1 (a::l) = a
|   find_index_in_list n (a::l) = find_index_in_list (n-1) l
|   find_index_in_list _ [] = raise path_error
;
      
fun type_of_argt (Arr t) = t
|   type_of_argt (Dep(x,t)) = t
;

fun get_info_from_exp (Var x) t DefC [] env = ETCInfo(Var x,type_from_context x DefC env,DefC) 
|   get_info_from_exp e t DefC [] env = ETCInfo(e,t,DefC) 
|   get_info_from_exp (App(f,argl)) t DefC (0::p) env =
      ETCInfo(f,gettype f DefC (defcontext_names DefC) env,DefC)
|   get_info_from_exp (App(f,argl)) t DefC  (n::p) env = 
       let val ftype = get_real_type f DefC (defcontext_names DefC) env
       in case ftype of
           (Prod(argt,_)) => get_info_from_exp_list n argl argt [] DefC p env
          | _ => raise path_error
       end
|   get_info_from_exp (Lam(v::vl,e)) (Prod(dt::argt,t)) DefC (0::p) env =  
       get_info_from_exp (fun_Lam(vl,e)) (fun_Prod(argt,t)) (add_to_defcontext (v,type_of_argt dt) DefC) p env 
|   get_info_from_exp (Lam([],e)) t DefC p env = get_info_from_exp e t DefC p env 
|   get_info_from_exp (Lam _) t DefC  _ env = raise path_error
|   get_info_from_exp (Let(vb,e)) t DefC  (0::p) env = get_info_from_exp e t DefC p env 
|   get_info_from_exp (Let(vb,e)) t DefC  (n::p) env = 
       let val (x,xe) = find_index_in_list n vb
           val xDefC = get_context_of (name_of e) env
           val xt = type_from_context x DefC env
       in get_info_from_exp xe xt xDefC p env 
       end
|   get_info_from_exp _ _ _ _ _ = raise path_error
and get_info_from_exp_list 1 (a::argl) (dt::argt) S DefC p env =
      let val t = unfold_type (inst_type (defcontext_names DefC) S (type_of_argt dt)) env
      in get_info_from_exp a t DefC p env
      end
|   get_info_from_exp_list n (a::argl) ((Arr t)::argt) S DefC p env =
      get_info_from_exp_list (n-1) argl argt S DefC p env
|   get_info_from_exp_list n (a::argl) ((Dep(x,t))::argt) S DefC p env =
      get_info_from_exp_list (n-1) argl argt ((x,a)::S) DefC p env
|   get_info_from_exp_list n _ _ _ _ _ _ = raise path_error
;

fun get_info_from_type t DefC [] env = TCInfo(t,DefC)
|   get_info_from_type (Elem(s,e)) DefC (0::p) env =
      get_info_from_exp e (Sort s) DefC p env
|   get_info_from_type (Prod([Arr _],t)) DefC (0::p) env = get_info_from_type t DefC p env 
|   get_info_from_type (Prod([Dep(x,xt)],t)) DefC (0::p) env = 
      get_info_from_type t (add_to_defcontext (x,xt) DefC) p env 
|   get_info_from_type (Prod((Arr _)::argt,t)) DefC (0::p) env = 
       get_info_from_type (Prod(argt,t)) DefC p env 
|   get_info_from_type (Prod((Dep(x,xt))::argt,t)) DefC (0::p) env = 
      get_info_from_type (Prod(argt,t)) (add_to_defcontext (x,xt) DefC) p env 
|   get_info_from_type (Prod(a::argt,t)) DefC (1::p) env =
       get_info_from_type (type_of_argt a) DefC p env
|   get_info_from_type _ _ _ _ = raise path_error
;

fun append_named_context (DCon (l,I)) (name,I') = DCon (l@[CName (name,I')],I@I');
            
fun get_info_from_context DefC [] env = CInfo(DefC)
|   get_info_from_context (DCon(l,_)) p env =
      let fun show_g_context ((x,t)::l) DefC (1::p) env =
                get_info_from_type (unfold_type t env) DefC p env
          |   show_g_context ((x,t)::l) DefC (n::p) env =
                show_g_context l (add_to_defcontext (x,t) DefC) ((n-1)::p) env
          |   show_g_context _ _ _ _ = raise path_error
          fun show_context ((CName C)::l) DefC p env =
                show_context l (append_named_context DefC C) p env
          |   show_context ((GCon C)::l) DefC (n::p1) env =
                let val Clen = length C
                in if n > Clen then show_context l (add_contexts DefC C) ((n-Clen)::p1) env
                   else show_g_context C DefC (n::p1) env
                end
          |   show_context _ _ _ _ = raise path_error
      in show_context l empty_context p env
      end
;

fun get_constr_info (ConTyp(c,t,DefC,_)) p env =
      case p of
        [] => ETCInfo(Can(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p)))
;

fun look_up_constr name ((prim as ConTyp(name',_,_,_))::prims) =
        if name = name' then prim else look_up_constr name prims
|   look_up_constr name [] = raise look_up_prim_error name
;


fun get_pattern_info (IDef(patt,Expr e,t,Con C,_)) p env =
      let val DefC = mkDefC(C,map fst C)
      in case p of 
          [] => TCInfo(t,DefC)
        | [Pexp] => ETCInfo(e,t,DefC)
        | [Pexp,Ppath p1] => get_info_from_exp e (unfold_type t env) DefC p1 env
        | [Ppatt] => ETCInfo(patt,t,DefC)
        | [Ppatt,Ppath p1] => get_info_from_exp patt t DefC p1 env
        | _ => raise Path_error (print_wpath (WP(name_of_head patt,p)))
      end
|   get_pattern_info (IDef(patt,Case(e,et,pl),t,Con C,_)) p env =
      let val DefC = mkDefC(C,map fst C)
      in case p of 
          [] => ETCInfo(patt,t,DefC)
        | [Pexp] => ETCInfo(e,et,DefC)
        | [Pexp,Ppath p1] => get_info_from_exp e (unfold_type et env) DefC p1 env
        | [Pexp,Ptype] => TCInfo(et,DefC)
        | [Pexp,Ptype,Ppath p1] => get_info_from_type et DefC p1 env
        | [Ppatt,Ppath p1] => get_info_from_exp patt t DefC p1 env
        | _ => raise Path_error (print_wpath (WP(name_of_head patt,p)))
      end
;

fun get_prim_info (CTyp(c,t,DefC,_,cl)) p env =
      (case p of
        [] => ETCInfo(Can(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | ((Pname name)::p1) => get_constr_info (look_up_constr name cl) p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_prim_info (ITyp(c,t,DefC,_,pl)) p env =
      (case p of
        [] => ETCInfo(Impl(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | ((Ppath [n])::p1) => get_pattern_info (find_index_in_list n pl) p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
;

fun get_abbr_info (EDef(c,e,t,DefC,_)) p env =
      (case p of
        [] => ETCInfo(e,t,DefC)
      | [Ppath p1] => get_info_from_exp e (unfold_type t env) DefC p1 env
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_abbr_info (TDef(c,t,DefC,_)) p env =
      (case p of
        [] => TCInfo(t,DefC)
      | [Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_abbr_info (CDef(c,DefC,_)) p env =
      (case p of
        [Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_abbr_info (SDef _) p env = CInfo(empty_context)     (***** OOOOBBBSSS!!!!!!! FOR NOW!!!!!!! ********)
;

fun get_u_constr_info (UConTyp(c,DT t,DefC)) p env =
      (case p of
        [] => ETCInfo(Can(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_constr_info (UConTyp(c,TUnknown,DefC)) p env = raise Not_Used_Anymore ("TUnknown in constr: "^c)
;

fun look_up_u_constr name ((prim as UConTyp(name',_,_))::prims) =
      if name = name' then prim else look_up_u_constr name prims
|   look_up_u_constr name [] = raise look_up_prim_error name
;

fun get_wpattern_info (WPatt(P(c,q),DefC0,Con C,patt,WExpr e,t)) p env =
      let val DefC = add_contexts DefC0 C
      in case p of 
          [] => ETCInfo(patt,t,DefC)
        | [Pexp] => ETCInfo(e,t,DefC)
        | [Pexp,Ppath p1] => get_info_from_exp e (unfold_type t env) DefC p1 env
        | [Ppatt] => ETCInfo(patt,t,DefC)
        | [Ppatt,Ppath p1] => get_info_from_exp patt t DefC p1 env
        | _ => raise Path_error (print_wpath (WP(c,(Ppath q)::p)))
      end
|   get_wpattern_info (WPatt(P(c,q),DefC0,Con C,patt,WCase(e,et,wpl),t)) p env =
      let val DefC = add_contexts DefC0 C
      in case p of 
          [] => ETCInfo(patt,t,DefC)
        | [Pexp] => ETCInfo(e,et,DefC)
        | [Pexp,Ppath p1] => get_info_from_exp e (unfold_type et env) DefC p1 env
        | [Pexp,Ptype] => TCInfo(et,DefC)
        | [Pexp,Ptype,Ppath p1] => get_info_from_type et DefC p1 env
        | [Ppatt] => ETCInfo(patt,t,DefC)
        | [Ppatt,Ppath p1] => get_info_from_exp patt t DefC p1 env
        | _ => raise Path_error (print_wpath (WP(c,(Ppath q)::p)))
      end
|   get_wpattern_info (WPatt(P(c,q),DefC0,Con C,patt,WUnknown,t)) p env =
      let val DefC = add_contexts DefC0 C
      in case p of 
          [] => ETCInfo(patt,t,DefC)
        | [Pexp] => EGoal(mk_invisible_RHS_name (P(c,q)),t,DefC)
        | [Ppatt] => ETCInfo(patt,t,DefC)
        | [Ppatt,Ppath p1] => get_info_from_exp patt t DefC p1 env
        | _ => raise Path_error (print_wpath (WP(c,(Ppath q)::p)))
      end
;
fun path_equal (P(s,p)) (P(s',p')) = 
      let fun equal [] _ = true
          |   equal _ [] = true
          |   equal (a::l) (a'::l') = a = a' andalso equal l l'
      in s = s' andalso equal p p'
      end
;

fun get_wpattern path ((p as WPatt(path',_,_,_,WCase(_,_,wl),_))::l) = 
      if path = path' then p
      else if path_equal path path' then get_wpattern path wl
           else get_wpattern path l
|   get_wpattern path ((p as WPatt(path',_,_,_,_,_))::l) = 
      if path = path' then p 
      else if path_equal path path' then raise look_up_wpatt_error (mkname path)
           else get_wpattern path l
|   get_wpattern path [] = raise look_up_wpatt_error (mkname path)
;


fun get_u_prim_info (UCTyp(c,DT t,DefC,cl)) p env =
      (case p of
        [] => ETCInfo(Can(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | ((Pname name)::p1) => get_u_constr_info (look_up_u_constr name cl) p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_prim_info (UCTyp(c,TUnknown,DefC,cl)) p env = raise Not_Used_Anymore ("TUnknown in prim: "^c)
|   get_u_prim_info (UITyp(c,DT t,DefC,wpl)) p env =
      (case p of
        [] => ETCInfo(Impl(c,defcontext_names DefC),t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | ((Ppath q)::p1) => get_wpattern_info (get_wpattern (P(c,q)) wpl) p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_prim_info (UITyp(c,TUnknown,DefC,cl)) p env = raise Not_Used_Anymore ("TUnknown in prim: "^c)
;

fun get_u_abbr_info (UEDef(c,D e,t,DefC)) p env =
      (case p of
        [] => ETCInfo(e,t,DefC)
      | [Ppath p1] => get_info_from_exp e (unfold_type t env) DefC p1 env
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_abbr_info (UEDef(c,Unknown,t,DefC)) p env =
      (case p of
        [] => EGoal(c,t,DefC)
      | [Ptype] => TCInfo(t,DefC)
      | [Ptype,Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_abbr_info (UTDef(c,DT t,DefC)) p env =
      (case p of
        [] => TCInfo(t,DefC)
      | [Ppath p1] => get_info_from_type t DefC p1 env
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_abbr_info (UTDef(c,TUnknown,DefC)) p env =
      (case p of
        [] => TGoal(c,DefC)
      | [Pcontext,Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_abbr_info (UCDef(c,DefC)) p env =
      (case p of
        [Ppath p1] => get_info_from_context DefC p1 env
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   get_u_abbr_info (USDef _) p env = CInfo(empty_context)  (*********OOOOOOOOOBBBBBBBBBSSSSSSSSSSSS************)
;

fun get_wpath_info (wp as WP(c,p)) env =
      case look_up_name c env of
                (Prim def) => get_prim_info def p env
              | (Abbr def) => get_abbr_info def p env
              | (UPrim def) => get_u_prim_info def p env
              | (UAbbr def) => get_u_abbr_info def p env
              | _ => raise Path_error ("look_up_name "^c^" failed")
;
      
fun istype_goal c env = 
      case get_id_kind c env of
        (true,Type_Abbr) => (case get_type_def_of c env of
                               TUnknown => true
                             | _ => false)
      | _ => false
;fun nyfind_goal wpath env =
     case get_wpath_info wpath env of
       TGoal(c,DefC) => (c,wpath)
     | EGoal(c,t,DefC) => (c,wpath)
     | TCInfo(TExpl(c,l),DefC) => if istype_goal c env then (c,wpath) else raise Not_A_goal c
     | ETCInfo(Expl(c,l),t,DefC) => if isunknown c env then (c,wpath) else raise Not_A_goal c
     | _ => raise Not_A_goal ""
;

(************ functions to refine a type unknown *****************)  

fun result_type_path [Ptype] = true
|   result_type_path [Ptype,Ppath p] = 
      let fun all_zeros [] = true
          |   all_zeros (a::l) = a = 0 andalso all_zeros l
      in all_zeros p
      end
|   result_type_path (Pname c::p) = result_type_path p
|   result_type_path _ = false
;

fun ground_type (Prod (_,t)) env = ground_type t env
|   ground_type (TExpl(c,l)) env = 
      if isqsym c then false 
      else 
      (case get_type_def_of c env of
         TUnknown => false
       | DT t => ground_type t env)
|   ground_type (TLet(vb,c,l)) env = 
      if isqsym c then false 
      else 
      (case get_type_def_of c env of
         TUnknown => true
       | DT t => ground_type t env)
|   ground_type (Sort _) _ = true
|   ground_type (Elem _) _ = true
;
fun mk_invisible_wpath_name wpath = mk_invisible_name (print_wpath wpath);

fun check_ok_type (wp as WP(c,Pname c1::p)) env t =
     if result_type_path p andalso ground_type t env then
       (case t of
         Elem("Set",e) => 
           if name_of_head e = c then true
           else raise Must_be_of_settype (c,mk_invisible_wpath_name wp,t)
       | (Prod(_,Elem("Set",e))) => 
           if name_of_head e = c then true
           else raise Must_be_of_settype (c,mk_invisible_wpath_name wp,t)
       | t => raise Must_be_of_settype (c,mk_invisible_wpath_name wp,t))
     else true
|   check_ok_type (wp as WP(c,p)) env t =
     if result_type_path p andalso ground_type t env then
       case get_id_kind c env of 
         (true,Set_Kind) => 
            (case t of 
               (Sort "Set") => true
             | (Prod (_,Sort "Set")) => true
             | _ => raise Must_be_Set (mk_invisible_wpath_name wp,t))
         | _ => true
     else true
;

fun Check_ok_type wpath env t = 
      if check_ok_type wpath env (unfold_type t env) then t
      else raise Must_be_of_settype ("",mk_invisible_wpath_name wpath,t)
;

fun apply_on_snd f l = map (fn (a,b) => (a,f b)) l;
fun remove_named_goals (ID s) = if visible_name s then (ID s) else (ID qsym)
|   remove_named_goals (APP(f,argl)) = APP(remove_named_goals f,map remove_named_goals argl)
|   remove_named_goals (LAM(vl,e)) = LAM(vl,remove_named_goals e)
|   remove_named_goals (LET(S,e)) = LET(remove_named_goals_DefS S,remove_named_goals e)
and remove_named_goals_DefS (SNAME name) = SNAME name
|   remove_named_goals_DefS (GSUBST s) = GSUBST (apply_on_snd remove_named_goals s)
|   remove_named_goals_DefS (COMP (DefS1,DefS2)) =
      COMP(remove_named_goals_DefS DefS1,remove_named_goals_DefS DefS2)
;

fun remove_named_Tgoals (TID s) = if visible_name s then (TID s) else (TID qsym)
|   remove_named_Tgoals (TLET(S,id)) = TLET(remove_named_goals_DefS S,id)
|   remove_named_Tgoals (ELEM(e)) = ELEM(remove_named_goals e)
|   remove_named_Tgoals (PROD(decl,t)) = 
      PROD(map (fn (ARR t) => ARR (remove_named_Tgoals t) 
                |  (DEP(x,t)) => DEP(x,remove_named_Tgoals t)) decl,remove_named_Tgoals t)
|   remove_named_Tgoals (SORT s) = SORT s
;

fun create_type_name I newnames env =
      create qsym (newnames @ I @ (global_names env)) "T"   (* must be something ... *)
;

fun term_arity (App(f,argl)) DefC I env = type_arity (get_real_type f DefC I env) env - (len argl)
|   term_arity e DefC I env = type_arity (get_real_type e DefC I env) env
;


fun fill_up n (e as App(f,argl)) DefC I env =
      let val ftype = get_real_type f DefC I env
          val name_list = create_names qsym (n+len argl) ftype    (**** always used with '?' YES! ***)
                ((get_subset_fidents [] e) @ I @ (global_names env)) (* names used somewhere *)
          val (newnames,newargl) = fix_args qsym argl name_list
      in (newnames,App(f,newargl))
      end
|   fill_up n f DefC I env =
      let val ftype = get_real_type f DefC I env
          val name_list = create_names qsym n ftype (I @ (global_names env))
      in (name_list,fun_App(f,map (fn name => Var name) name_list))
      end
;

fun fill_up_with_arguments (e as Lam _) _ _ _ _ _ = ([],e)
|   fill_up_with_arguments (e as Var x) t DefC I newnames env =
      if mem I x then
        let val arity_diff = type_arity (type_from_context x DefC env) env - type_arity t env
        in if arity_diff < 0 then raise Arity_Mismatch_in_refinement (e,t)
           else fill_up arity_diff e DefC (newnames@I) env
        end
      else if isqsym x then
             let val newname = create qsym (newnames@I@global_names env) "e"
             in ([newname],Var newname)
             end
           else ([],e)
|   fill_up_with_arguments e t DefC I newnames env =     
     let val arity_diff =  term_arity e DefC I env - type_arity t env
     in if arity_diff < 0 then raise Arity_Mismatch_in_refinement (e,t)
        else fill_up arity_diff e DefC (newnames@I) env
     end
;

fun fill_in_type_args (TExpl(c,l)) DefC I newnames env =
      if isqsym c then 
        let val name = create_type_name I newnames env
        in (name::newnames,TExpl(name,l))
        end
      else (newnames,TExpl(c,l))
|   fill_in_type_args (Prod(argl,t)) DefC I newnames env =
      let val (newnames',argl',DefC') = fill_in_type_args_list argl DefC I newnames env
          val (newnames'',t') = fill_in_type_args t DefC' (defcontext_names DefC') newnames' env
      in (newnames'',Prod(argl',t'))
      end
|   fill_in_type_args (TLet(vb,c,l)) DefC I newnames env =
      if isqsym c then 
	  let val name = create_type_name I newnames env
        in (name::newnames,TLet(vb,name,l))
        end
      else (newnames,TLet(vb,c,l))
|   fill_in_type_args (Elem (s,e)) DefC I newnames env =
      let val (generatednames,e') = fill_up_with_arguments e (Sort s) DefC I newnames env
      in (generatednames@newnames,Elem(s,e'))
      end
|   fill_in_type_args t _ _ newnames _ = (newnames,t)
and fill_in_type_args_list ((Arr t)::l) DefC I newnames env =
      let val (newnames',t') = fill_in_type_args t DefC I newnames env
          val (newnames'',l',DefC') = fill_in_type_args_list l DefC I newnames' env
      in (newnames'',Arr t'::l',DefC')
      end
|   fill_in_type_args_list (Dep(x,t)::l) DefC I newnames env =
      let val (newnames',t') = fill_in_type_args t DefC I newnames env
          val DefC' = add_to_defcontext (x,t) DefC
          val (newnames'',l',DefC'') = 
            fill_in_type_args_list l DefC' (x::I) newnames' env
      in (newnames'',Dep(x,t')::l',DefC'')
      end
|   fill_in_type_args_list [] DefC _ newnames _ = (newnames,[],DefC)
;

fun increase_refine_context (Lam([],e)) (Prod([],t)) _ C _ _ = (e,t,rev C)
|   increase_refine_context (Lam([],e)) t _ C _ _ = (e,t,rev C)
|   increase_refine_context (Lam(v::vl,e)) (Prod(Arr A::argl,t)) I C DefC env =
      if occurs I v then 
        case type_conv A (type_from_context v DefC env) env DefC I of
          (Ok _) => increase_refine_context (Lam(vl,e)) (Prod(argl,t)) I C DefC env 
        | _ => raise Name_already_in_context v
      else increase_refine_context (Lam(vl,e)) (Prod(argl,t)) 
                                       (v::I) ((v,A)::C) DefC env
|   increase_refine_context (Lam(v::vl,e)) (Prod(Dep (x,A)::argl,t)) I C DefC env =
      if occurs I v then 
        case type_conv A (type_from_context v DefC env) env DefC I of
          (Ok _) => increase_refine_context (Lam(vl,e)) 
                       (inst_type I [(x,Var v)] (Prod(argl,t))) I C DefC env 
        | _ => raise Name_already_in_context v
      else if v = x then 
             increase_refine_context (Lam(vl,e)) (Prod(argl,t)) 
                                         (v::I) ((v,A)::C) DefC env
           else let val I' = v::I
                in increase_refine_context 
                     (Lam(vl,e)) (inst_type I' [(x,Var v)] (Prod(argl,t))) 
                     I' ((v,A)::C) DefC env
                 end
|   increase_refine_context e (Prod([],t)) _ C _ _ = (e,t,rev C)
|   increase_refine_context e t _ C _ _ = (e,t,rev C)
;

fun increase_refinement_context (e as Lam(vl,_)) t I C DefC env =
      let fun several_occurences (v::vl) = 
                mem vl v orelse several_occurences vl
          |   several_occurences [] = false
      in if several_occurences vl then raise Several_occurences_of_var
         else increase_refine_context e t I C DefC env
      end
|   increase_refinement_context e t I C DefC env =
      increase_refine_context e t I C DefC env
;

(****** Don't need to send back the name anymore............. ********)
fun add_unsure_def_to_env def env =
       add_u_abbr_to_env def env 
;
fun get_symbol name env = look_up_symbol (symbol_table env) name;

fun add_new_subst_goals (x::l) S DefC I fDefC used_names env =
      let val newname = create qsym (l@I@used_names@(global_names env)) x
          val t = type_from_context x fDefC env
          val env' = add_unsure_def_to_env (UEDef(newname,Unknown,t,DefC)) env
      in add_new_subst_goals l ((x,Expl(newname,I))::S) DefC I fDefC (newname::used_names) env'
      end
|   add_new_subst_goals [] S _ _ _ used_names env = (S,used_names,env)
;

fun applied n (Prod(typl,t)) = 
      let fun chop 0 l = l
          |   chop n (a::l) = chop (n-1) l
          |   chop _ _ = raise type_check_args_error
          val length = len typl
      in if n > length then raise type_check_args_error
         else if n = length then t
              else Prod(chop n typl,t)
      end
|   applied _ _ = raise type_check_args_error
;

fun add_s_refine_constraints cl (env,ES,defs,Ok cl',S) = (env,ES,defs,Ok (cl@cl'),S)
|   add_s_refine_constraints cl (env,ES,defs,notequals,S) = (env,ES,defs,notequals,S)
;


fun add_refine_constraints cl (env,ES,defs,Ok cl') = (env,ES,defs,Ok (cl@cl'))
|   add_refine_constraints cl (env,ES,defs,notequals) = (env,ES,defs,notequals)
;

(* The type t can NOT involve new variables, IF we always substitute *)
(* instanciated terms into the type in type_check_refine_args *)
(* new expl constants are added to the env as goes along, to be able to use normal *)
(* typechecking functions *)
fun type_check_refinement (e as Lam(vl,_)) (t as Prod(argl,_)) DefC I env newnames =
      if (len vl) > (len argl) then (env,e,newnames,ET_Noteq (e,t))
      else let val (e',t',C') = increase_refinement_context e t I [] DefC env
               val I' = I@(map fst C')
               val (generated_names,e'') = fill_up_with_arguments e' t' DefC I' newnames env
               val (env',new_e,newnames',constraints) =
                 type_check_refinement e'' t' (add_contexts DefC C') I' env (generated_names@newnames)
           in (env',Lam(vl,new_e),newnames',constraints)
           end
|   type_check_refinement (e as Lam _)  t _ _ _ _ = raise Lam_with_ground_type (e,t)
|   type_check_refinement (Var x) t DefC I env newnames =
      if mem I x then    (* in the context , not a new explicit constant *)
        (env,Var x,newnames,type_conv (type_from_context x DefC env) t env DefC I)
      else (case (get_symbol x env) of
            (Var x) => 
              if mem newnames x then 
                let val env' = add_unsure_def_to_env (UEDef(x,Unknown,t,DefC)) env
                    val new_e = Expl(x,I)
                in (env',new_e,x::newnames,Ok [])
                end
              else raise look_up_name_error x
           | e => (env,e,newnames,type_conv (gettype e DefC I env) t env DefC I))
|   type_check_refinement (App(Var x,argl)) t DefC I env newnames =
      if mem I x then type_check_refine_appl (Var x) argl t DefC I env newnames
      else (case (get_symbol x env) of
             (Var x) => raise New_name_as_head_in_refinement x
           | e => type_check_refine_appl e argl t DefC I env newnames)
|   type_check_refinement (e as App(f,argl)) t DefC I env newnames = 
      let val (env',f',newnames',constraints) = type_check_head f DefC I env newnames
      in case constraints of     
           (Ok cl) => 
             add_refine_constraints cl (type_check_refine_appl f' argl t DefC I env' newnames')
         | notequals => (env,e,newnames,notequals)
      end
|   type_check_refinement e t DefC I env newnames =
      (case type_check_head e DefC I env newnames of
         (env',e',newnames',Ok cl) => 
             add_refine_constraints cl 
               (env',e',newnames',type_conv (gettype e' DefC I env) t env' DefC I)
       | notequals => notequals)
and type_check_head (Let(vb,f)) DefC I env newnames =
        let val (c,l) = get_name_and_local_vars f
        in if (isrestricted vb l) then
             let val free_vars = minus l (map fst vb)
             in if all_mem I free_vars then 
                  let val (env',vb',newnames',constr) =
                    fits_refinement_context vb (get_real_context f env) DefC I env newnames
                  in (env',Let(vb',f),newnames',constr)
                  end
                else extend_subst vb f c (minus free_vars I) DefC I env newnames
             end
           else raise Let_Not_Restricted f
        end
|   type_check_head f DefC I env newnames = 
        let val (c,l) = get_name_and_local_vars f
        in if all_mem I l then (env,f,newnames,Ok [])
           else extend_subst [] f c (minus l I) DefC I env newnames
        end
and extend_subst vb f c freevars DefC I env newnames =
      let val (S,used_names,env') = 
         add_new_subst_goals freevars [] DefC I (get_context_of c env) newnames env
      in type_check_head (Let(vb@S,f)) DefC I env' used_names
      end
and type_check_refine_appl f argl t DefC I env newnames =
      let val ftype = get_real_type f DefC I env
      in case ftype of
           (Prod(typl,t')) => 
              let val (env',argl',newnames',constraints,S) = 
                    type_check_refinement_args argl typl [] DefC I env newnames
                  val newt' = inst_type I S (applied (len argl) ftype)
              in case constraints of
                   (Ok cl) => 
                       (env',App(f,argl'),newnames',
                        add_constraints cl (type_conv newt' t env' DefC I))
                 | notequal => (env',App(f,argl'),newnames',notequal)
              end
           | _ => (env,App(f,argl),newnames,ET_Noteq (App(f,argl),t))     (* arity mismatch *)
      end
and type_check_refinement_args (e::argl) (Arr t::l) S DefC I env newnames =
      let val t' = inst_type I S t
          val (generated_names,e') = fill_up_with_arguments e t' DefC I newnames env
      in case type_check_refinement e' t' DefC I env (generated_names@newnames) of
           (env',e1,newnames',Ok cl) => 
             let val (env1,argl1,newnames1,constr,S1) =
                type_check_refinement_args argl l S DefC I env' newnames'
             in add_s_refine_constraints cl (env1,e1::argl1,newnames1,constr,S1)
             end
         | (env',e,newnames',notequal) => (env',e::argl,newnames',notequal,S)
      end
|   type_check_refinement_args (e::argl) (Dep(x,t)::l) S DefC I env newnames =
      let val t' = inst_type I S t
          val (generated_names,e') = fill_up_with_arguments e t' DefC I newnames env
      in case type_check_refinement e' t' DefC I env (generated_names@newnames) of
           (env',e1,newnames',Ok cl) => 
             let val (env1,argl1,newnames1,constr,S1) =
                type_check_refinement_args argl l ((x,e1)::S) DefC I env' newnames'
             in add_s_refine_constraints cl (env1,e1::argl1,newnames1,constr,S1)
             end
         | (env',e,newnames',notequal) => (env',e::argl,newnames',notequal,S)
      end
|   type_check_refinement_args [] _ S _ _ env newnames = (env,[],newnames,Ok [],S)
|   type_check_refinement_args _ _ _ _ _ _ _ = raise type_check_args_error
and fits_refinement_context vb (Con C') DefC I env newnames =
      let fun change_vb x e ((x',e')::l) = 
                if x = x' then (x,e)::l else (x',e')::change_vb x e l
          |   change_vb _ _ [] = []
          fun fits vb ((x,A)::l) I C env newnames =
               let val (env',e,newnames',constr) =
                 type_check_refinement (component vb x) (inst_type I vb A) DefC I env newnames
               in case constr of
                    Ok cl => add_refine_constraints cl 
                                (fits (change_vb x e vb) l I C env' newnames')
                  | notequals => (env',vb,newnames,notequals)
               end
          | fits vb [] _ _ env newnames = (env,vb,newnames,Ok [])
      in fits vb C' I DefC env newnames
      end
;

          
fun check_refine_type (Elem (s,e)) DefC I env newnames =
      let val (generated_names,newe) = fill_up_with_arguments e (Sort s) DefC I newnames env
          val (env',e',newnames',constr) = 
           type_check_refinement newe (Sort s) DefC I env (generated_names@newnames)
      in (env',Elem(s,e'),newnames',constr)
      end
|   check_refine_type (TExpl(c,l)) DefC I env newnames =
      (case get_id_kind c env of
         (true,Type_Abbr) => (env,TExpl(c,l),newnames,Ok [])
       | (true,_) => raise Name_already_defined c
       | _ => let val env' = add_unsure_def_to_env (UTDef(c,TUnknown,DefC)) env
                  val new_t = TExpl(c,defcontext_names DefC)
              in (env',new_t,newnames,Ok [])
              end)
|   check_refine_type (Prod(typl,t)) DefC I env newnames =
     let val (env',typl',newnames',constr,DefC',I') = 
           check_refine_type_list typl DefC I env newnames
     in case constr of 
         (Ok cl) => let val (env'',t',newnames'',constr') = 
                       check_refine_type t DefC' I' env' newnames'
                    in (env'',Prod(typl',t'),newnames'',add_constraints cl constr')   
                    end 
        | _ => (env',Prod(typl',t),newnames',constr)
     end
|   check_refine_type t _ _ env newnames = (env,t,newnames,Ok [])
and check_refine_type_list [] DefC I env newnames = (env,[],newnames,Ok [],DefC,I)
|   check_refine_type_list (Arr t::l) DefC I env newnames =
      let val (env',t',newnames',constr) = check_refine_type t DefC I env newnames
      in case constr of
           (Ok cl) => 
              let val (env'',l',newnames'',constr',DefC',I') = 
                         check_refine_type_list l DefC I env' newnames'
              in (env'',Arr t'::l',newnames'',add_constraints cl constr',DefC',I')
              end
          | _ => (env',Arr t'::l,newnames',constr,DefC,I)
      end
|   check_refine_type_list (Dep(x,t)::l) DefC I env newnames =
      let val (env',t',newnames',constr) = check_refine_type t DefC I env newnames
      in case constr of
           (Ok cl) => 
              let val (env'',l',newnames'',constr',DefC',I') = 
                   check_refine_type_list l (add_to_defcontext (x,t') DefC) (x::I) env' newnames'
              in (env'',Dep(x,t')::l',newnames'',add_constraints cl constr',DefC',I')
              end
          | _ => (env',Dep(x,t')::l,newnames',constr,DefC,I)
      end
;

fun check_type_refine t DefC env =
      let val I = defcontext_names DefC
          val (generated_names,t') = fill_in_type_args t DefC I [] env
      in check_refine_type t' DefC I env generated_names
      end
;

fun update_constr constr scratch env = 
      update_refine_constr (add_constr constr scratch) env []
;

fun names_of_simple_constr (EE(Expl(c,l),_,_,_)) = c
|   names_of_simple_constr (EE(Let(_,Expl(c,_)),_,_,_)) = c
|   names_of_simple_constr (TT(TExpl(c,l),_,_)) = c
|   names_of_simple_constr (TT(TLet(_,c,_),_,_)) = c
|   names_of_simple_constr constr = raise Not_A_Simple_Constraint constr
;

fun update_constraints constr (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val (newscratch,derived) = update_constr constr scratch env
          val unfolded_names = filter (not o visible_name) 
                               (map names_of_simple_constr derived)
      in (Env(prims,abbrs,remove_info unfolded_names info,newscratch,backtrack),derived)
      end
;

fun update_Tunknown_in_backtrack c t (back as Back(prims,defs,deps)) env = 
      if visible_name c then 
        Back(prims,change_Tunknown c t defs,Tupdate_refine c t deps)
      else Back(remove_and_Tunfold_in_prims c t prims,
                remove_and_Tunfold_in_abbrs c t defs,Tupdate_unfold c t deps)
;

fun update_Tunknown c t (env as Env(prims,abbrs,info,scratch,backtrack_scratch)) =
      let val newscratch = 
            refine_constr_in_scratch (update_Tunknown_in_scratch c t scratch) env
          val newbacktrack = update_Tunknown_in_backtrack c t backtrack_scratch env
      in if visible_name c then Env(prims,abbrs,info,newscratch,newbacktrack)
         else Env(prims,abbrs,remove_info [c] info,newscratch,newbacktrack)
      end
;
fun get_u_abbrs   (Env(_,_,_,Scratch(_,u_abbrs,_,_),_))    = u_abbrs;

(********** functions to add unsure definitions to the scratch area *********)

fun filter_newdefs newnames env =
      let fun get_new l = filter (fn d => mem newnames (name_of_u_abbr d)) l
      in get_new (get_u_abbrs env)
      end
;

fun t_refine_and_add_constraints_to_env c t newnames constraints env = 
      let val (env',derived_eq) = 
         update_constraints constraints (update_Tunknown c t env)
      in (filter_newdefs newnames env',env',derived_eq)
      end
;
fun get_constraints (Env(_,_,_,Scratch(_,_,constraints,_),_))    = constraints;

fun checktyperefinement c t DefC env =
      let val (env',t',newnames,constraints) = check_type_refine t DefC env
      in case constraints of
          (Ok l) => 
             let val (newdefs,env'',derived_equalities) = 
                   t_refine_and_add_constraints_to_env c t' newnames l env'
             in (([c],newdefs,derived_equalities,get_constraints env''),env'')
             end
         | notequals => raise Not_Correct_Refinement notequals
      end
;
 
fun check_type_refinement c con_t wpath env =
      if istype_goal c env then
        let val DefC = get_context_of_def c env
            val I = defcontext_names DefC
            val t = Check_ok_type wpath env 
                       (convert_type DefC env ((map Var I) @ symbol_table env) 
                        (remove_named_Tgoals con_t))
        in checktyperefinement c t DefC env
        end
      else raise Refine_on_not_unknown c
;

(*********** functions to abstract a type unknown ******************)

fun abstract_type c "" wpath env = 
      check_type_refinement c (PROD([ARR (TID qsym)],TID qsym)) wpath env
|   abstract_type c varname wpath env =
      check_type_refinement c (PROD([DEP(varname,TID qsym)],TID qsym)) wpath env
;

fun alpha_convert I (Lam(vl,e)) = 
     let fun alpha I (x::l,e) = 
           if occurs I x then 
             let val x1 = gensym (x::l@I) (prime x)
                 val I' = x1::I
                 val (l',e') = alpha I' (l,inst I' [(x,Var x1)] e)
             in (x1::l',e')
             end
           else let val (l',e') = alpha I (l,e)
                in (x::l',e')
                end
        | alpha I ([],e) = ([],e)
     in Lam(alpha I (vl,e))
     end
|   alpha_convert I e = e
;

fun remove_type_args 0 t = t
|   remove_type_args n (Prod(a::argl,t)) =
      remove_type_args (n-1) (fun_Prod(argl,t)) 
|   remove_type_args _ t = raise Must_Abstract_on_function t
;

fun check_refine (Lam(vl1,e1)) t DefC env =
      let val I = defcontext_names DefC
          val (vl,e) =
	    case(if any_mem I vl1 then alpha_convert I (Lam(vl1,e1)) else (Lam(vl1,e1))) of
	      Lam x => x
	    | _ => raise Bind
          val (generated_names,e') = 
            fill_up_with_arguments e (remove_type_args (len vl) t) DefC (vl@I) [] env
      in type_check_refinement (Lam(vl,e')) t DefC (defcontext_names DefC) env generated_names
      end
|   check_refine e t DefC env =
      let val I = defcontext_names DefC
          val (generated_names,e') = fill_up_with_arguments e t DefC I [] env
      in type_check_refinement e' t DefC I env generated_names
      end
;

fun get_real_type_of_def name env =
      case get_type_of_def name env of
        (TExpl(c,l)) => 
           (case get_type_def_of c env of
              TUnknown => TExpl(c,l)
           | DT t => t)
      | (TLet(vb,c,l)) =>
           (case get_type_def_of c env of
              TUnknown => TLet(vb,c,l)
           | DT t => inst_type l vb t)
      | t => t
;

fun update_unknown_in_backtrack c e recursion_allowed (back as Back(prims,defs,deps)) env = 
      if visible_name c then 
           Back(prims,change_unknown c e defs,update_refine c e recursion_allowed deps)
      else Back(remove_and_unfold_in_prims c e prims,
                remove_and_unfold_in_abbrs c e defs,
                update_unfold c (update_refine c e recursion_allowed deps))
;


(******** function to update an unknown *************)

fun update_unknown c e recursion_allowed (env as Env(prims,abbrs,info,scratch,backtrack_scratch)) =
      let val newscratch = 
            refine_constr_in_scratch (update_unknown_in_scratch c e recursion_allowed scratch) env
          val newbacktrack = update_unknown_in_backtrack c e recursion_allowed backtrack_scratch env
      in if visible_name c then Env(prims,abbrs,info,newscratch,newbacktrack)
         else Env(prims,abbrs,remove_info [c] info,newscratch,newbacktrack)
      end
;

fun refine_and_add_constraints_to_env c e recursion_allowed newnames constraints env = 
      let val (env',derived_eq) = 
         update_constraints constraints (update_unknown c e recursion_allowed env)
      in (filter_newdefs newnames env',env',derived_eq)
      end
;

fun checkrefinement c DefC recursion_allowed e env =
        let val I = defcontext_names DefC
            val (env',e',newnames,constraints) = 
                 check_refine e (get_real_type_of_def c env) DefC env
        in case constraints of
             (Ok l) => 
                let val (newdefs,env'',derived_equalities) = 
                   refine_and_add_constraints_to_env c e' recursion_allowed newnames l env'
                in (([c],newdefs,derived_equalities,get_constraints env''),env'')
                end
           | notequals => raise Not_Correct_Refinement notequals
        end
;


(************ functions to refine an unknown *****************)  

fun check_refinement (Expl(c,l)) recursion_allowed con_e env =
      if isunknown c env then
        let val DefC = get_context_of_def c env
            val I = defcontext_names DefC
            val e = convert_exp I env ((map Var I) @ symbol_table env) (remove_named_goals con_e)
        in checkrefinement c DefC recursion_allowed e env
        end
      else raise Refine_on_not_unknown c
|   check_refinement e _ _ _ = raise Refine_with_non_expl e
;

fun abstract n (Expl(c,l)) (typ as Prod(typl,t)) env = 
      let val defcontext = get_context_of_def c env
          val I = defcontext_names defcontext
          val env_names = global_names env
          val name_list = create_names "" n typ (I@env_names)
          val var_list = map Var name_list
          val I' = name_list @ I
          val (C,S,_) = get_context var_list typl [] [] I env [] I
          val c_def = LAM(name_list,ID qsym)
      in check_refinement (Expl(c,l)) (false,[]) c_def env
      end
|   abstract _ e (Prod(_,_)) _ = raise Must_be_explicit e
|   abstract _ _ t _ = raise Must_Abstract_on_function t
;

fun abstract_one (e as (Expl(c,l))) (WP(cp,p)) env = 
      if isunknown c env then
        let val ctype = get_real_type_of_def c env
        in case ctype of
             (Prod(argl,t)) => abstract 1 e ctype env
           | (TExpl(ct,lt)) => 
                (case get_type_def_of ct env of
                   TUnknown => 
                     let val ((_,u1,c1,d1),env1) = 
                          abstract_type ct (create "" (l@global_names env) "x") (WP(cp,p@[Ptype])) env
                         val ((_,u2,c2,d2),env2) = abstract 1 e (get_real_type_of_def c env1) env1
                     in (([c,ct],u1@u2,c1@c2,d1@d2),env2)
                     end
                 | _ => raise Must_Abstract_on_function ctype)
           | _ => raise Must_Abstract_on_function ctype
        end 
      else raise Refine_on_not_unknown c 
|   abstract_one e _ env = raise Must_be_explicit e
;
fun Abstract_one wpath env = 
      let val (c,cwpath) = nyfind_goal wpath env
      in abstract_one (get_symbol c env) cwpath env
      end;

fun name_of_simple_constraint (EE(Expl(c,_),_,_,_)) = c
|   name_of_simple_constraint (TT(TExpl(c,_),_,_)) = c
|   name_of_simple_constraint constr = raise Not_A_Simple_Constraint constr
;


fun derived_names l = map name_of_simple_constraint l;

fun show_derived c = "#Void : "^(mk_invisible_name c);

fun show_newdef_info def = show_new_def (UAbbr def);

fun show_newdefs_info defs = print_list show_newdef_info defs;

fun remove_derived l derived_names =
      filter (fn d => not (mem derived_names (name_of_u_abbr d))) l
;
fun show_refine_info (cl,newdefs,derived_eq,constraints) (WP(s,_)) env =
      let val void_names = derived_names derived_eq
      in (myprint (print_list show_derived (union(cl,void_names))); 
         myprint (show_new_def (look_up_name s env));
         myprint (show_newdefs_info (remove_derived newdefs void_names)); 
         myprint (print_rev_list show_constraint constraints))
      end
;

(*********** functions to refining a goal **************)

fun do_abstr c (flag,coml,env,oldenv) =
      let val (info,newenv) = Abstract_one c env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun abstract_all (e as Expl(c,l)) env = 
      if isunknown c env then
        let val ctype = unfold_type (get_real_type_of_def c env) env
        in case ctype of
             (Prod(argl,t)) => abstract (len argl) e ctype env
           | t => raise Must_Abstract_on_function t
        end 
      else raise Refine_on_not_unknown c 
|   abstract_all e env =  raise Must_be_explicit e
;
(******************************************************************************)
(************                REFINEMENT FUNCTIONS                   ***********)
(******************************************************************************)

fun Abstract_all wpath env = 
      let val (c,cwpath) = nyfind_goal wpath env
      in abstract_all (get_symbol c env) env
      end;

fun do_abstr_all c (flag,coml,env,oldenv) =
      let val (info,newenv) = Abstract_all c env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun is_pattern_path (WP(c,(Ppath p)::l)) = true
|   is_pattern_path _ = false
;


fun pattern_wpath_to_path_and_rest (WP(c,(Ppath p)::rest)) = (P(c,p),rest)
|   pattern_wpath_to_path_and_rest wpath = raise Path_error ("Not a pattern path : "^print_wpath wpath)
;

fun RHS_of_pattern wpath = 
     if is_pattern_path wpath then 
       let val (pattern_path,rest) = pattern_wpath_to_path_and_rest wpath
       in case rest of
            [Pexp] => true
           | _ => false
       end
     else false
;

fun pattern_wpath_to_path wpath = fst (pattern_wpath_to_path_and_rest wpath);
          

fun look_up_wpattern (P(name,pl)) (Env(p,a,i,Scratch(up,d,c,g),scr)) =
      let fun get_impl fname (UITyp(name',_,_,wpl)::l) = 
                if fname = name' then wpl
                else get_impl fname l
          |   get_impl fname (_::l) = get_impl fname l
          |   get_impl fname [] = raise look_up_wpatt_error name
       in get_wpattern (P(name,pl)) (get_impl name up) 
       end
;






(*************** make a goal out of the right-hand side of a pattern *************)


fun make_goal_of_wpatt name (WPatt(path,DefC,Con C,patt,WUnknown,t)) =
      let val DefC' = add_contexts DefC C
          val I = defcontext_names DefC'
          val e = Expl(name,I)
      in (WPatt(path,DefC,Con C,patt,WExpr e,t),UEDef(name,Unknown,t,DefC'))
      end
|   make_goal_of_wpatt name (WPatt(path,DefC,Con C,patt,_,t)) =
      raise Cannot_split_CPatt (mkname path)
;
fun id_of_path (P(id,_)) = id;

fun update_wpatts (wpatt::l) deps  = update_wpatts l (update_wpatt wpatt deps)
|   update_wpatts [] deps = deps
;

fun change_wpatt_in_scratch newwpl path (Scratch(prims,defs,constr,deps)) =
      let fun change_to wpl ((p as WPatt(path',DefC,C,patt,WCase(e,et,pl),t))::l) = 
                if path = path' then wpl@l 
                else if path_equal path path' then 
                       let val pl' = change_to wpl pl
                       in WPatt(path',DefC,C,patt,WCase(e,et,pl'),t)::l
                       end
                     else p::change_to wpl l
          |   change_to wpl ((p as WPatt(path',_,_,_,_,_))::l) = 
                if path = path' then wpl@l else p::change_to wpl l
          |   change_to wpl [] = raise look_up_wpatt_error (id_of_path path)
          fun change fname ((d as UITyp(name,t,DefC,wpl))::l) =
                if name = fname then UITyp(name,t,DefC,change_to newwpl wpl)::l
                else d::change fname l
          |   change fname (d::l) = d::change fname l
          |   change fname [] = raise look_up_prim_error fname
      in Scratch(change (id_of_path path) prims,defs,constr,update_wpatts newwpl deps)
      end
;

fun change_wpatt_in_back newwpl path (Back(prims,defs,deps)) =
      let fun change_to wpl ((p as WPatt(path',DefC,C,patt,WCase(e,et,pl),t))::l) = 
                if path = path' then wpl@l 
                else if path_equal path path' then 
                       let val pl' = change_to wpl pl
                       in WPatt(path',DefC,C,patt,WCase(e,et,pl'),t)::l
                       end
                     else p::change_to wpl l
          |   change_to wpl ((p as WPatt(path',_,_,_,_,_))::l) = 
                if path = path' then wpl@l else p::change_to wpl l
          |   change_to wpl [] = raise look_up_wpatt_error (id_of_path path)
          fun change fname ((d as UITyp(name,t,DefC,wpl))::l) =
                if name = fname then UITyp(name,t,DefC,change_to newwpl wpl)::l
                else d::change fname l
          |   change fname (d::l) = d::change fname l
          |   change fname [] = raise look_up_prim_error fname
      in Back(change (id_of_path path) prims,defs,update_wpatts newwpl deps)
      end
;

fun change_wpattern_to_new path wpatts (Env(prims,abbrs,info,scr1,scr2)) =
      Env(prims,abbrs,remove_info [mk_invisible_RHS_name path] info,change_wpatt_in_scratch wpatts path scr1,
                           change_wpatt_in_back wpatts path scr2)
;

fun make_and_add_goal path env =
      let val wpatt = look_up_wpattern path env
          val goalname = mk_invisible_RHS_name path
          val (new_wpatt,def) = make_goal_of_wpatt goalname wpatt
      in change_wpattern_to_new path [new_wpatt] (add_u_abbr_to_env def env)
      end
;

fun okey_recursive (wpath as WP(c,p)) env = 
     if is_pattern_path wpath then 
       let val (pattern_path,rest) = pattern_wpath_to_path_and_rest wpath
           val ok_names = map name_of_u_prim (get_u_prims env)
       in case rest of
             [Pexp] => (true,ok_names)
           | [Pexp,Ppath l] => (true,ok_names)
           | _ => (false,[])
       end
     else (false,[])
;
fun Check_refinement wpath e env = 
      if RHS_of_pattern wpath andalso not (in_scratch_area (mk_invisible_wpath_name wpath) env) then 
        let val path = pattern_wpath_to_path wpath
            val env' = make_and_add_goal path env
        in check_refinement (get_symbol (mk_invisible_RHS_name path) env') 
             (okey_recursive wpath env) e env'
        end
      else 
        let val (c,cwpath) = nyfind_goal wpath env
        in check_refinement (get_symbol c env) (okey_recursive cwpath env) e env
        end;

fun do_refine c e (flag,coml,env,oldenv) =
      let val (info,newenv) = Check_refinement c e env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
datatype REM_OR_CHANGE = REM | CHANGE of EXP | CHANGE_T of TYP;
fun pconstr name = "."^name;
fun constrpath s c = s^(pconstr c);fun mkconstr_name sname name = mk_invisible_name (constrpath sname name);

fun freevars e = get_subset_fidents [] e;


fun rem_or_change_sub_exp REM (Expl(c,l)) [] = 
      if visible_name c then Expl(qsym,[])
      else raise Not_backtrack_point c
|   rem_or_change_sub_exp REM e [] = Expl(qsym,[])
|   rem_or_change_sub_exp (CHANGE e) _ [] = e
|   rem_or_change_sub_exp REM (App(f,argl)) [0] = Expl(qsym,[])
|   rem_or_change_sub_exp (CHANGE f') (App(f,argl)) (0::p) = 
      let val e = App(rem_or_change_sub_exp (CHANGE f') f p,argl)
      in simplereduce (freevars e) e
      end
|   rem_or_change_sub_exp what (App(f,argl)) (0::p) = App(rem_or_change_sub_exp what f p,argl)
|   rem_or_change_sub_exp what (App(f,argl)) (n::p) = App(f,rem_or_change_sub_exp_list what n argl p)
|   rem_or_change_sub_exp what (Lam(v::vl,e)) (0::p) = fun_Lam([v],rem_or_change_sub_exp what (fun_Lam(vl,e)) p)
|   rem_or_change_sub_exp what (Lam([],e)) p = rem_or_change_sub_exp what e p 
|   rem_or_change_sub_exp what (Lam _) _ = raise path_error
|   rem_or_change_sub_exp what (Let(vb,e)) (0::p) = rem_or_change_sub_exp what e p 
|   rem_or_change_sub_exp what (Let(v::vb,e)) (n::p) = fun_Let([v],rem_or_change_sub_exp what (fun_Let(vb,e)) p)
|   rem_or_change_sub_exp what (Expl(c,l)) p = if visible_name c then raise path_error
                                   else raise Not_backtrack_point c
|   rem_or_change_sub_exp what _ _ = raise path_error
and rem_or_change_sub_exp_list what 1 (a::argl) p = rem_or_change_sub_exp what a p::argl
|   rem_or_change_sub_exp_list what n (a::argl) p = a::rem_or_change_sub_exp_list what (n-1) argl p
|   rem_or_change_sub_exp_list what n _ _ = raise path_error
;

fun rem_or_change_sub_type REM (TExpl(c,l)) [] = 
      if visible_name c then TExpl(qsym,[])
      else raise Not_backtrack_point c
|   rem_or_change_sub_type REM t [] = TExpl(qsym,[])
|   rem_or_change_sub_type (CHANGE_T t) _ [] = t
|   rem_or_change_sub_type what (Elem(s,e)) (0::p) = 
      (case rem_or_change_sub_exp what e p of
         Expl(qsym,[]) => TExpl(qsym,[])
       | e' => Elem(s,e'))
|   rem_or_change_sub_type what (Prod([d],t)) (0::p) = Prod([d],rem_or_change_sub_type what t p)
|   rem_or_change_sub_type what (Prod(d::argt,t)) (0::p) = 
      fun_Prod([d],rem_or_change_sub_type what (Prod(argt,t)) p)
|   rem_or_change_sub_type what (Prod(Arr A::argt,t)) (1::p) = Prod(Arr (rem_or_change_sub_type what A p)::argt,t)
|   rem_or_change_sub_type what (Prod(Dep(x,A)::argt,t)) (1::p) = 
      Prod(Dep(x,rem_or_change_sub_type what A p)::argt,t)
|   rem_or_change_sub_type what (TExpl(c,l)) p = if visible_name c then raise path_error
                                          else raise Not_backtrack_point c
|   rem_or_change_sub_type what _ _ = raise path_error
;

fun rem_or_change_in_context what (DCon (l,I)) p =
     let fun rem_con ((x,t)::l) (1::p) = (x,rem_or_change_sub_type what t p)::l
         |   rem_con ((x,t)::l) (n::p) = (x,t)::rem_con l ((n-1)::p)
         |   rem_con _ _ = raise path_error
         fun remove ((CName c)::l) p = CName c::remove l p
         |   remove ((GCon C)::l) (n::p) = 
               let val len_C = len C
               in if len_C >= n then (GCon (rem_con C (n::p)))::l
                  else (GCon C)::remove l ((n-len_C)::p)
               end
         |   remove _ _ = raise path_error
     in DCon(remove l p,I)
     end
;

fun rem_or_change_in_uconstr what setname (UConTyp(c,DT t,DefC)) p =
      (case p of
        [Ptype] => (case what of
                      REM => UConTyp(c,DT (TExpl(mktype_name (mkconstr_name setname c),defcontext_names DefC)),DefC)
                    | (CHANGE_T t') => UConTyp(c,DT t',DefC)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ptype,Ppath p1] => UConTyp(c,DT (rem_or_change_sub_type what t p1),DefC)
      | [Pcontext,Ppath p1] =>  UConTyp(c,DT t,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uconstr _ _ (UConTyp(c,TUnknown,DefC)) p = raise Not_Used_Anymore ("TUnknown in constr: "^c)
;

fun rem_or_change_in_uconstr_list what setname name p (cdef::cl) =
      if name = name_of_u_constr cdef then rem_or_change_in_uconstr what setname cdef p::cl
      else cdef::rem_or_change_in_uconstr_list what setname name p cl
|   rem_or_change_in_uconstr_list what setname name p [] = raise path_error
;
fun pid_of_wpatt (WPatt(pid,_,_,_,_,_)) = pid;
fun mk_invisible_path_name path = mk_invisible_name (mkname path);
fun mkcase_type_name p = typepath (exppath (mk_invisible_path_name p))


fun rem_or_change_in_wpatt what p (WPatt(P(c,q),DefC0,Con C,patt,WExpr e,t)) =
      let val I = defcontext_names DefC0 @ map fst C
      in case p of
          [Pexp] => (case what of
                      REM => WPatt(P(c,q),DefC0,Con C,patt,WExpr (Expl(mk_invisible_RHS_name (P(c,q)),I)),t)
                    | CHANGE(e') => WPatt(P(c,q),DefC0,Con C,patt,WExpr e',t)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
        | [Pexp,Ppath p1] => WPatt(P(c,q),DefC0,Con C,patt,WExpr (rem_or_change_sub_exp what e p1),t)
        | _ => raise Path_error (mkname (P(c,q)))
      end
|   rem_or_change_in_wpatt what p (WPatt(P(c,q),DefC0,Con C,patt,WCase(e,et,wpl),t)) =
      let val I = defcontext_names DefC0 @ map fst C
      in case p of 
          [Pexp] => (case what of
                      REM => WPatt(P(c,q),DefC0,Con C,patt,WCase(Expl(mk_invisible_RHS_name (P(c,q)),I),et,wpl),t)
                    | CHANGE(e') => WPatt(P(c,q),DefC0,Con C,patt,WCase(e',et,wpl),t)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
        | [Pexp,Ppath p1] => WPatt(P(c,q),DefC0,Con C,patt,WCase(rem_or_change_sub_exp what e p1,et,wpl),t)
        | [Pexp,Ptype] => (case what of
                              REM => WPatt(P(c,q),DefC0,Con C,patt,WCase(e,TExpl(mkcase_type_name (P(c,q)),I),[]),t)
                            | CHANGE_T(et') => WPatt(P(c,q),DefC0,Con C,patt,WCase(e,et',wpl),t)
                            | _ => raise Path_error (print_wpath (WP(c,p))))
        | [Pexp,Ptype,Ppath p1] => WPatt(P(c,q),DefC0,Con C,patt,WCase(e,rem_or_change_sub_type what et p1,[]),t)
        | [Ppatt] => WPatt(P(c,q),DefC0,Con C,patt,WExpr (Expl(mk_invisible_RHS_name (P(c,q)),I)),t)
        | _ => raise Path_error (mkname (P(c,q)))
      end
|   rem_or_change_in_wpatt what p (WPatt(P(c,q),DefC0,Con C,patt,WUnknown,t)) =
       raise Path_error (mkname (P(c,q)))
;

fun rem_or_change_in_wpatt_list what path p ((wpatt as WPatt(path',DefC,C,patt,WCase(e,et,wpl),t))::l) =
      if path = pid_of_wpatt wpatt then rem_or_change_in_wpatt what p wpatt::l
      else if path_equal path path' then 
             WPatt(path',DefC,C,patt,WCase(e,et,rem_or_change_in_wpatt_list what path p wpl),t)::l
           else wpatt::rem_or_change_in_wpatt_list what path p l
|   rem_or_change_in_wpatt_list what path p (wpatt::l) =
      if path = pid_of_wpatt wpatt then rem_or_change_in_wpatt what p wpatt::l
      else wpatt::rem_or_change_in_wpatt_list what path p l
|   rem_or_change_in_wpatt_list what path p [] = []
;

    
fun rem_or_change_in_uprim what (UCTyp(c,DT t,DefC,cl)) p =
      (case p of
        [Ptype] => (case what of
                      REM => UCTyp(c,DT (TExpl(mktype_name c,defcontext_names DefC)),DefC,cl)
                    | (CHANGE_T t') => UCTyp(c,DT t',DefC,cl)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ptype,Ppath p1] => UCTyp(c,DT (rem_or_change_sub_type what t p1),DefC,cl)
      | [Pcontext,Ppath p1] =>  UCTyp(c,DT t,rem_or_change_in_context what DefC p1,cl)
      | ((Pname name)::p1) => UCTyp(c,DT t,DefC,rem_or_change_in_uconstr_list what c name p1 cl)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uprim what (UCTyp(c,TUnknown,DefC,cl)) p = raise Not_Used_Anymore ("TUnknown in prim: "^c)
|   rem_or_change_in_uprim what (UITyp(c,DT t,DefC,wpl)) p =
      (case p of
        [Ptype] => (case what of
                      REM => UITyp(c,DT (TExpl(mktype_name c,defcontext_names DefC)),DefC,[])
                    | (CHANGE_T t') => UITyp(c,DT t',DefC,wpl)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ptype,Ppath p1] => UITyp(c,DT (rem_or_change_sub_type what t p1),DefC,[])
      | [Ppatt] => UITyp(c,DT t,DefC,[])
      | [Pcontext,Ppath p1] => UITyp(c,DT t,rem_or_change_in_context what DefC p1,wpl)
      | ((Ppath q)::p1) => UITyp(c,DT t,DefC,rem_or_change_in_wpatt_list what (P(c,q)) p1 wpl)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uprim what (UITyp(c,TUnknown,DefC,cl)) p = raise Not_Used_Anymore ("TUnknown in prim: "^c)
;
      

fun change_in_uprims what c p (def::prims) =
      if c = name_of_u_prim def then (rem_or_change_in_uprim what def p)::prims
      else def::change_in_uprims what c p prims
|   change_in_uprims what c p [] = []
;
fun get_unknowns_in_type t (Deps(DN,CN,YN,DO,DDO)) = is_in_the_type YN t;

fun get_unknowns_in_term e (Deps(DN,CN,YN,DO,DDO)) = is_in_the_term YN e;

fun get_unknowns_in REM _ = []
|   get_unknowns_in (CHANGE_T t) deps = get_unknowns_in_type t deps
|   get_unknowns_in (CHANGE e) deps = get_unknowns_in_term e deps
;


fun rem_or_change_in_uabbr what (UEDef(c,D e,t,DefC)) p =
      (case p of
        [] => (case what of
                 REM => UEDef(c,Unknown,t,DefC)
               | CHANGE(e') => UEDef(c,D e',t,DefC)
               | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ppath p1] => UEDef(c,D (rem_or_change_sub_exp what e p1),t,DefC)
      | [Ptype] => UEDef(c,D e,TExpl(mktype_name c,defcontext_names DefC),DefC)
      | [Ptype,Ppath p1] => UEDef(c,D e,rem_or_change_sub_type what t p1,DefC)
      | [Pcontext,Ppath p1] =>  UEDef(c,D e,t,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uabbr what (UEDef(c,Unknown,t,DefC)) p =
      (case p of
        [] => UEDef(c,Unknown,t,DefC)
      | [Ptype] => (case what of
                      REM => UEDef(c,Unknown,TExpl(mktype_name c,defcontext_names DefC),DefC)
                    | (CHANGE_T t') => UEDef(c,Unknown,t',DefC)
                    | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ptype,Ppath p1] => UEDef(c,Unknown,rem_or_change_sub_type what t p1,DefC)
      | [Pcontext,Ppath p1] => UEDef(c,Unknown,t,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uabbr what (UTDef(c,DT t,DefC)) p =
      (case p of
        [] => (case what of
                 REM => UTDef(c,TUnknown,DefC)
               | (CHANGE_T t') => UTDef(c,DT t',DefC)
               | _ => raise Path_error (print_wpath (WP(c,p))))
      | [Ppath p1] => UTDef(c,DT (rem_or_change_sub_type what t p1),DefC)
      | [Pcontext,Ppath p1] => UTDef(c,DT t,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uabbr what (UTDef(c,TUnknown,DefC)) p =
      (case p of
        [] => raise Not_backtrack_point c
      | [Pcontext,Ppath p1] => UTDef(c,TUnknown,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uabbr what (UCDef(c,DefC)) p =
      (case p of
        [Ppath p1] => UCDef(c,rem_or_change_in_context what DefC p1)
      | _ => raise Path_error (print_wpath (WP(c,p))))
|   rem_or_change_in_uabbr _ (USDef d) p = USDef d
;

fun change_and_remove_subgoals_in_uabbr what c p remlist (def::defs) =
      let val defname = name_of_u_abbr def
      in if not (visible_name defname) then 
           if mem remlist defname then change_and_remove_subgoals_in_uabbr what c p remlist defs
           else if c = defname then 
                 (rem_or_change_in_uabbr what def p)::change_and_remove_subgoals_in_uabbr what c p remlist defs
                else def::change_and_remove_subgoals_in_uabbr what c p remlist defs
         else if c = defname then 
                 (rem_or_change_in_uabbr what def p)::change_and_remove_subgoals_in_uabbr what c p remlist defs
              else def::change_and_remove_subgoals_in_uabbr what c p remlist defs
      end
|   change_and_remove_subgoals_in_uabbr what c p _ [] = []
;

fun make_unknown_or_change what (wp as WP(c,p)) (backtrack as Back(uprims,defs,deps)) env =
      case look_up_u_name c env of
        (UPrim def) => 
           let val rlist = case p of
                            (Pname c')::_ => get_unknowns_depends_on c' deps U get_unknowns_in what deps
                            | _ => get_unknowns_depends_on c deps U get_unknowns_in what deps
               val back' = Back(change_in_uprims what c p uprims,
                                remove_subgoals_in_uabbrs rlist defs,
                                update_delete_list rlist deps)
           in subgoals_and_deps_of_uprim (case p of (Pname c')::_ => c' | _ => c) back' env
           end
      | (UAbbr def) => 
          let val rlist = if visible_name c then get_unknowns_depends_on c deps U get_unknowns_in what deps
                          else []
              val back' = Back(uprims,
                               change_and_remove_subgoals_in_uabbr what c p rlist defs,
                               update_delete_list rlist deps)
           in subgoals_and_deps_of_uabbr c back' env
           end
      | _ => raise Path_error ("look_up_name "^c^" failed")
;

fun update_rem_or_change_def what wpath (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val backtrack' = make_unknown_or_change what wpath backtrack env
          val (orderedlist,newbacktrack) = sort_defs_in_order backtrack'
          val env' = Env(prims,abbrs,remove_info (get_scratch_names scratch) info,start_scratch,newbacktrack)
      in make_new_scratch orderedlist env'
      end
;

fun not_instantiated wpath env =
       case get_wpath_info wpath env of
       TCInfo(TExpl(c,l),DefC) => istype_goal c env
     | ETCInfo(Expl(c,l),t,DefC) => isunknown c env
     | TGoal(c,DefC) => true
     | EGoal(c,t,DefC) => true
     | _ => false
;


(*********** functions to change the definition of an unknown **************************)

fun check_change wpath path e env =
      let val env' = update_rem_or_change_def REM wpath env
          val name = if in_scratch_area path env then path else mk_invisible_name path
      in if not_instantiated wpath env' then Check_refinement wpath e env'
         else raise Term_instanciated_by_unification
      end
;
fun find_sub_term_path wpath env = print_wpath wpath;
fun Check_change wpath e env = check_change wpath (find_sub_term_path wpath env) e env;

fun do_change path e (flag,coml,env,oldenv) =
      let val (info,newenv) = Check_change path e env
      in (show_refine_info info path newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun Abstr_type wpath givenname env = 
      let val (c,cwpath) = nyfind_goal wpath env
      in abstract_type c givenname cwpath env
      end;

fun do_abstract_type c varname (flag,coml,env,oldenv) =
      let val (info,newenv) = Abstr_type c varname env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun Check_refine_type wpath t env = 
      let val (c,cwpath) = nyfind_goal wpath env
      in check_type_refinement c t cwpath env
      end;

fun do_refine_type c t (flag,coml,env,oldenv) =
      let val (info,newenv) = Check_refine_type c t env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;


(*********** functions to change the definition of a type unknown **************************)

fun check_change_type wpath path t env =
      let val env' = update_rem_or_change_def REM wpath env
      in if not_instantiated wpath env' then Check_refine_type wpath t env'
         else raise Term_instanciated_by_unification
      end
;
fun Check_change_type wpath t env = check_change_type wpath (find_sub_term_path wpath env) t env;

fun do_change_type path t (flag,coml,env,oldenv) =
      let val (info,newenv) = Check_change_type path t env
      in (show_refine_info info path newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;   

fun get_matching_vars t vb DefC I env =
       filter (fn (v,a) => type_conv t (type_from_context v DefC env) env DefC I = Ok []) vb
;

fun find_match vb e t DefC I env =
       filter (fn (v,a) => check_conv a e t env DefC I = Ok []) vb
;


(********** functions to abstract an unknown with function type ************)

(* A little hack to fix that I don't have the wpath for the goal:
   goal_in_def c env finds the definition in which c is defined, and
   okey_recursive_def cdef env sais it's okey if cdef is implicit...
   It's okey to return WP(cdef,[]) as the faked path, since cdef it's
   the only thing I look at...
*)
fun solve_constraint (EE(App(Expl(c,l),[Var x]),ce,_,DefC)) env =
      let val cDefC = get_context_of_def c env
          val I = defcontext_names DefC
          val x' = create "" I x
          val e = fun_Lam([x'],inst I [(x,Var x')] ce)
          val cdef = goal_in_def c env
      in (WP(cdef,[]),checkrefinement c cDefC (okey_recursive_def cdef env) e env)
      end
|   solve_constraint (EE(ce,App(Expl(c,l),[Var x]),_,DefC)) env =
      let val cDefC = get_context_of_def c env
          val I = defcontext_names DefC
          val x' = create "" I x
          val e = fun_Lam([x'],inst I [(x,Var x')] ce)
          val cdef = goal_in_def c env
      in (WP(cdef,[]),checkrefinement c cDefC (okey_recursive_def cdef env) e env)
      end
|   solve_constraint (EE(Let(vb,Expl(c,l)),e,t,DefC)) env =
      let val cDefC = get_context_of_def c env
          val I = defcontext_names cDefC
          val varlist = get_matching_vars t vb cDefC I env
          val cdef = goal_in_def c env
      in case find_match varlist e t DefC (defcontext_names DefC) env of
           [] => (WP(cdef,[]),checkrefinement c DefC (okey_recursive_def cdef env) e env)
         | ((v,_)::_) => (WP(cdef,[]),checkrefinement c cDefC (okey_recursive_def cdef env) (Var v) env)
      end
|   solve_constraint (EE(e,Let(vb,Expl(c,l)),t,DefC)) env =
      let val cDefC = get_context_of_def c env
          val I = defcontext_names cDefC
          val varlist = get_matching_vars t vb cDefC I env
          val cdef = goal_in_def c env
      in case find_match varlist e t DefC (defcontext_names DefC) env of
           [] => (WP(cdef,[]),checkrefinement c DefC (okey_recursive_def cdef env) e env)
         | ((v,_)::_) => (WP(cdef,[]),checkrefinement c cDefC (okey_recursive_def cdef env) (Var v) env)
      end
|   solve_constraint constr env = raise Can't_solve_constraint constr
;

fun Solve_Constraint 1 (constr::cl) env = solve_constraint constr env
|   Solve_Constraint n (constr::cl) env = Solve_Constraint (n-1) cl env 
|   Solve_Constraint _ [] env = raise No_such_constraint_number
;

fun do_solve_constraint n (flag,coml,env,oldenv) =
      let val (c,(info,newenv)) = Solve_Constraint n (get_constraints env) env
      in (show_refine_info info c newenv;if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun contextpath s = s^pcontext;


fun name_of_wpatt wpatt = mkname (pid_of_wpatt wpatt);

fun look_up_path d (Ptype::pl) env = 
      look_up_path (UAbbr (look_up_u_abbr (typepath (name_of_env_kind d)) env)) pl env
|   look_up_path d (Pcontext::pl) env = 
      look_up_path (UAbbr (look_up_u_abbr (contextpath (name_of_env_kind d)) env)) pl env
|   look_up_path (Prim d) path env = look_up_prim_path d path env
|   look_up_path (UPrim d) path env = look_up_uprim_path d path env
|   look_up_path (UPatt d) (Pexp::pl) env =
      look_up_path (UAbbr (look_up_u_abbr (name_of_wpatt d) env)) pl env
|   look_up_path d path _ = (path,d)
and look_up_prim_path (CTyp(name,_,_,_,cl)) ((Pname c)::pl) env =
      let fun get_constr c [] = raise path_error
          |   get_constr c ((d as ConTyp(c',_,_,_))::l) =
                if c = c' then Constr(name,d) else get_constr c l
      in look_up_path (get_constr c cl) pl env
      end
|   look_up_prim_path (d as ITyp(name,_,_,_,pattl)) ((Ppath nl)::pl) env =
      let fun get_pattern 1 (p::_) = Patt p
          |   get_pattern n (_::l) = get_pattern (n-1) l
          |   get_pattern _ [] = raise path_error
      in case nl of
           [] => look_up_prim_path d pl env
         | (n::pathl) => (Ppath pathl::pl,get_pattern n pattl)
      end
|   look_up_prim_path d pl env = (pl,Prim d)
and look_up_uprim_path (UCTyp(name,_,_,cl)) ((Pname c)::pl) env =
      let fun get_constr c [] = raise Path_error (print_wpath (WP(name,(Pname c)::pl)))
          |   get_constr c ((d as UConTyp(c',_,_))::l) =
                if c = c' then UConstr(name,d) else get_constr c l
      in look_up_path (get_constr c cl) pl env
      end
|   look_up_uprim_path (UITyp(name,_,_,wpl)) ((Ppath p)::pl) env =
      look_up_path (UPatt (get_wpattern (P(name,p)) wpl)) pl env
|   look_up_uprim_path d pl _ = (pl,UPrim d)
;


fun look_up_path_def (WP(name,[])) env = ([],look_up_name name env)
|   look_up_path_def (WP(name,pl)) env =
      look_up_path (look_up_name name env) pl env
;

fun hnf_term c env e =
     let val e' = hnf (defcontext_names c) env e
     in case e' of
         (NotYet e') => e'
        |(Irred e') => e'
        |(HNform e') => e'
     end;

fun is_set_constructor (Can _) = true
|   is_set_constructor (Let(_,Can _)) = true
|   is_set_constructor _ = false
;

fun get_constructors_of name env =
      case look_up_prim name env of
        (Prim (CTyp(_,_,_,_,cl))) =>
           map (fn (ConTyp(name,_,DefC,_)) => Can(name,defcontext_names DefC)) (rev cl)
     |  (UPrim (UCTyp(_,_,_,cl))) =>
           map (fn (UConTyp(name,_,DefC)) => Can(name,defcontext_names DefC)) (rev cl)
     | _ =>  raise look_up_prim_error name 
;

fun make_context (x::xl) (Arr t::argl) I S C =
      make_context xl argl I S ((x,inst_type I S t)::C)
|   make_context (x::xl) (Dep(y,t)::argl) I S C =
      make_context xl argl I ((y,Var x)::S) ((x,inst_type I S t)::C)
|   make_context _ _ _ S C = (C,S)
;

fun create_pattern_vars C e (T as Prod(argl,t)) I env =
      let val name_list = create_names "" (len argl) T (I @ (global_names env))
          val (context,S) = make_context name_list argl (name_list @ I) [] []
      in (Con (C@(rev context)),fun_App(e,map Var name_list),inst_type I S t)
      end
|   create_pattern_vars C e t _ _ = (Con C,e,t)
;

fun subst_pattern l (App(f,argl)) = App(f,map (subst_pattern l) argl)
|   subst_pattern l (Var x) = if mem l x then Var "_" else Var x
|   subst_pattern l e = e
;

fun cases_from_pattern DefC (C as Con c) case_e t t' e env usednames =
      let val (_,e_type) = compute_type e (add_contexts DefC c) env
          val I = defcontext_names DefC @ context_names C
          val (newC,newe,newe_t) = create_pattern_vars c e e_type (I @ usednames) env
      in case (newe_t,t') of
           (Elem(s,e),Elem(s',e')) => 
             if s = s' then
               let val (context,subst) = unification DefC newC e e' (Sort s) env
                   val I' = (context_names newC) @ I
                   val newt = inst_type I' subst t
                   val newe' = inst I' subst newe
               in case case_e of
                   (Var z) => (DefC,inst_and_rem_context (z,newe') context I',
                               subst_pattern (map fst subst) newe,inst_type I' [(z,newe')] newt)
                  | _ => (DefC,context,subst_pattern (map fst subst) newe,newt)
               end
             else raise case_pattern_failed (e)
         | _ => raise case_pattern_failed (e)
      end
;


fun all_pattern_names (path as P(c,l)) env =
      let fun find_pattern path (wpatt::wpl) =
                 if path_equal path (pid_of_wpatt wpatt) then wpatt
                 else find_pattern path wpl
          |   find_pattern path [] = raise path_error
          fun get_names (WPatt(_,_,C,_,WCase(_,_,wpl),_)) =
                 context_names C @ flat() (map get_names wpl)
          |   get_names (WPatt(_,_,C,_,_,_)) = context_names C 
          val def = look_up_u_prim c env 
      in case def of
          (UPrim (UITyp(_,_,DefC,wpl))) =>
             get_names (find_pattern path wpl) @ (defcontext_names DefC)
         | _ => raise look_up_prim_error c
      end
;



fun all_cases_from_pattern path [] DefC C e t t' env = []
|   all_cases_from_pattern path (c::l) DefC C e t t' env =
      let val test = [cases_from_pattern DefC C e t t' c env (all_pattern_names path env)]
                     handle Impossible_unification _ => []
      in case test of
          ((DefC',context,pattern,typ)::_) => 
             let val wdef = WExpr(Expl(mk_invisible_RHS_name path,
                                       defcontext_names DefC'@context_names context))
             in all_cases_from_pattern (nextpath path) l DefC C e t t' env @
                   [WPatt(path,DefC',context,pattern,wdef,typ)]
             end
        | [] => all_cases_from_pattern path l DefC C e t t' env
      end
;


fun compute_cases path e etype DefC (C as Con C') t env =
      let val DefC' = add_contexts DefC C'
      in case etype of
           Elem(s,A) => 
             let val hnf_A = hnf_term DefC' env A
                 val head_A = head_of hnf_A
             in if is_set_constructor head_A then
                  let val c = name_of_head head_A
                  in (*********if in_scratch_area c env then raise Expand_pattern_with_scratch_set c
                     else OOOOOOOOOBBBBBBBBBBBBSSSSSSSSSSSS!!!!!!!!!!!!!!************************)
                          let val S = subst_of_head head_A
                              val constr_list = map (fn z => fun_Let(S,z)) (get_constructors_of c env)
                          in all_cases_from_pattern path constr_list DefC C e t (Elem(s,hnf_A)) env
                          end
                  end
                else raise Not_A_Set_Constructor A
              end
         | t => raise Not_elem_type t
      end
;

fun make_patt_goals ((WPatt(path,DefC,Con C,_,WUnknown,t))::l) =
      UAbbr (UEDef(mk_invisible_RHS_name path,Unknown,t,add_contexts DefC C))::make_patt_goals l
|   make_patt_goals ((WPatt(path,DefC,Con C,_,WExpr(Expl(name,I)),t))::l) =
      UAbbr (UEDef(name,Unknown,t,add_contexts DefC C))::make_patt_goals l
|   make_patt_goals (d::l) = make_patt_goals l
|   make_patt_goals [] = []
;

fun update_case_pattern_wpatts p wpatts ((d as WPatt(p',DefC,C,patt,WCase(e,et,wpl),t))::l) =
      if p = p' then WPatt(p',DefC,C,patt,WCase(e,et,wpatts),t)::l
      else if path_equal p p' then 
             WPatt(p',DefC,C,patt,WCase(e,et,update_case_pattern_wpatts p wpatts wpl),t)::l
           else d::update_case_pattern_wpatts p wpatts l
|   update_case_pattern_wpatts p wpatts (d::l) = d::update_case_pattern_wpatts p wpatts l
|   update_case_pattern_wpatts p wpatts [] = raise Cannot_split_CPatt (id_of_path p)
;

fun update_case_pattern_in_uprims (path as P(c,p)) wpatts ((d as UITyp(c',t,DefC,wpl))::l) =
      if c = c' then
        UITyp(c',t,DefC,update_case_pattern_wpatts path wpatts wpl)::l
      else d::update_case_pattern_in_uprims path wpatts l
|   update_case_pattern_in_uprims path wpatts (d::l) = d::update_case_pattern_in_uprims path wpatts l
|   update_case_pattern_in_uprims path wpatts [] = raise Cannot_split_CPatt (id_of_path path)
;

fun update_case_pattern_in_scratch p wpatts (Scratch(uprims,a,c,d)) =
      Scratch(update_case_pattern_in_uprims p wpatts uprims,a,c,update_wpatts wpatts d)
;

fun update_case_pattern_in_back p wpatts (Back(uprims,a,d)) =
      Back(update_case_pattern_in_uprims p wpatts uprims,a,update_wpatts wpatts d)
;

fun update_case_pattern path wpatts (Env(p,a,i,scratch,back)) =
      Env(p,a,i,update_case_pattern_in_scratch path wpatts scratch,
                update_case_pattern_in_back path wpatts back)
;
(************ functions to create patterns **************)

fun create_pattern path env = 
      case look_up_path_def path env of
        (_,def as UPrim (UITyp(c,DT T,DefC,[]))) =>
          if iscomplete_type T env then
            (case (unfold_type T env) of
              (T' as Prod(typl,t)) => 
                 let val env_names = global_names env
                     val I = defcontext_names DefC
                     val name_list = create_names "" (len typl) T' (I@env_names)
                     val var_list = map Var name_list
                     val (C,S,_) = get_context var_list typl [] [] I env [] I
                     val newC = rev C
                     val newtype = inst_type (name_list@I) S t
                     val newpath = nextdepth (mkpid c)
                     val RHS_name = mk_invisible_RHS_name newpath
                     val RHS_DefC = add_contexts DefC newC
                     val goal = UEDef(RHS_name,Unknown,newtype,RHS_DefC)
                     val wpatt = WPatt(newpath,DefC,Con newC,App(Impl(c,I),var_list),
                                       WExpr(Expl(RHS_name,defcontext_names RHS_DefC)),newtype)
                 in ([UAbbr goal],add_wpatt_to_env wpatt (add_u_abbr_to_env goal env))
                 end
(*             | _ => raise UImpl_typ_not_a_function_type (UITyp(c,DT T,DefC,[]))) *)
(**************** new *****************)
               | T => 
                 let val newpath = nextdepth (mkpid c)
                     val I = defcontext_names DefC
                     val RHS_name = mk_invisible_RHS_name newpath
                     val goal = UEDef(RHS_name,Unknown,T,DefC)
                     val wpatt = WPatt(newpath,DefC,Con [],Impl(c,I),WExpr(Expl(RHS_name,I)),T)
                 in ([UAbbr goal],add_wpatt_to_env wpatt (add_u_abbr_to_env goal env))
                 end)
(**************** end *****************)
          else raise Definition_not_complete def
       | (_,def as UPrim (UITyp(c,TUnknown,DefC,[]))) => raise Definition_not_complete def
       | (_,def as UPatt (wpatt as WPatt(p,DefC,C,patt,WCase (e,etype,[]),t))) => 
            if iscomplete_type etype env then 
              let val newwpatts = compute_cases (nextdepth p) e etype DefC C t env
                  val newgoals = make_patt_goals newwpatts
              in (newgoals,update_case_pattern p newwpatts (add_u_defs_to_env newgoals env))
              end
            else raise Definition_not_complete def
       | (_,UPatt (WPatt(p,DefC,C,patt,WCase (e,et,_),t))) => raise Cannot_split_CPatt (id_of_path p)
       | (_,def) => raise Not_An_Impl (name_of_env_kind def)
;

(*********** functions to refining a pattern **************)

fun do_create_pattern (p as WP(c,_)) (flag,coml,env,oldenv) =
      let val (newgoals,newenv) = create_pattern p env
      in (show_defs (look_up_u_prim c newenv::newgoals);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
; 

fun get_term_of_path e [] = e
|   get_term_of_path (App(f,argl)) (0::p) = get_term_of_path f p
|   get_term_of_path (App(f,argl)) (n::p) = get_term_of_path (find_index_in_list n argl) p
|   get_term_of_path (Lam(v::vl,e)) (0::p) = get_term_of_path (Lam(vl,e)) p
|   get_term_of_path (Lam([],e)) p = get_term_of_path e p
|   get_term_of_path (Lam _) _ = raise path_error
|   get_term_of_path (Let(vb,e)) (0::p) = get_term_of_path e p
|   get_term_of_path (Let(vb,e)) (n::p) = 
      get_term_of_path (snd (find_index_in_list n vb)) p
|   get_term_of_path _ _ = raise path_error
;

fun name_of_pattern_var path p env =
      let val (WPatt (_,_,_,pattern,_,_)) = look_up_wpattern path env
      in case get_term_of_path pattern p of
           (Var x) => x
         | e => raise Path_error ("Pattern variable expected, not : "^print_exp e)
      end
;


fun get_pattern_var_name path (Ppatt::[Ppath p]) env = name_of_pattern_var path p env
|   get_pattern_var_name path wp _ = 
      raise Path_error ("Can't be a path to a pattern variable : "^makepath wp)
;

fun get_impl_and_var wpath env = 
      let val (pattern_path,var_path) = pattern_wpath_to_path_and_rest wpath
      in (pattern_path,get_pattern_var_name pattern_path var_path env)
      end
;

fun get_type_in_context name (Con C) =
     let fun get ((x,t)::l) = if name = x then t else get l
         |   get [] = raise Var_not_in_context name
     in get C
     end
;
     
(******************* Operations on Waiting patterns **************************)

fun split_context name (Con C) =
     let fun split ((x,t)::l) l' = if x = name then (rev l',l,t)
                                  else split l ((x,t)::l')
         |   split [] l' = raise Var_not_in_context name
     in split C []
     end
;


fun split_pattern (p as WPatt(_,DefC,C,patt,WUnknown,t)) path name e env =
      let val (first,last,name_t) = split_context name C
          val DefC' = add_contexts DefC first
          val (_,e_type) = compute_type e DefC' env
          val I = defcontext_names DefC @ context_names C
          val (newC,newe,newe_t) = create_pattern_vars first e e_type I env
      in case (newe_t,name_t) of
           (Elem(s,e),Elem(s',e')) => 
             if s = s' then
               let val (context,subst) = unification DefC newC e (hnf_term DefC' env e') (Sort s) env
                   val I' = (context_names newC) @ I
                   val newpatt = inst I' [(name,newe)] patt
                   val subst' = (name,inst I' subst newe)::subst
                   val newt = inst_type I' subst' t
                   val newcontext = append_context context (inst_context I' subst' last)
                   val newI = defcontext_names DefC @ context_names newcontext
                   val newwdef = WExpr (Expl(mk_invisible_RHS_name path,newI))
               in WPatt(path,DefC,newcontext,subst_pattern (map fst subst) newpatt,newwdef,newt)
               end
             else raise split_pattern_failed (p,name,e)
         | _ => raise split_pattern_failed (p,name,e)
      end
|   split_pattern (WPatt(path,DefC,C,patt,_,t)) _ name e env = 
       raise Cannot_split_CPatt (id_of_path path)
;

fun split_all_patterns path name [] wpatt env = []
|   split_all_patterns path name (e::l) wpatt env =
      let val newWpatt = 
            [split_pattern wpatt path name e env]
            handle Impossible_unification _ => []
      in split_all_patterns (nextpath path) name l wpatt env @ newWpatt
      end
;

fun delete_unknown_in_scratch c (Scratch(p,defs,constr,deps)) =
      Scratch(p,filter (fn d => name_of_u_abbr d <> c) defs,constr,update_delete c deps)
;

(*    fixa med assoc path name kanske ????? *)
fun delete_unknown_in_back c (Back(p,defs,deps)) =
      Back(p,filter (fn d => name_of_u_abbr d <> c) defs,update_delete c deps)
;

fun delete_unknown c (env as Env(prims,abbrs,info,scratch,backtrack)) =
      Env(prims,abbrs,info,delete_unknown_in_scratch c scratch,delete_unknown_in_back c backtrack)
;


fun cover_pattern name (p as WPatt(path,DefC,C as Con c,patt,WUnknown,t)) env =
      (case (get_type_in_context name C) of
        (Elem(s,e)) => 
           let val hnf_e = head_of (hnf_term (add_contexts DefC c) env e)
           in if is_set_constructor hnf_e then
                let val c = name_of_head hnf_e
                in (********** OOOBBBBBSSSSSS
                   if in_scratch_area c env then raise Expand_pattern_with_scratch_set c
                   else ***********************)
                        let val S = subst_of_head hnf_e
                            val constr_list = map (fn y => fun_Let(S,y)) (get_constructors_of c env)
                        in (split_all_patterns (nextdepth path) name constr_list p env,env)
                        end
                end
              else raise Not_A_Set_Constructor e
           end
       | _ => raise Type_not_S_type name)
|   cover_pattern name (WPatt(path,DefC,C as Con c,patt,WExpr (Expl(d,l)),t)) env =
      if isunknown d env then 
        cover_pattern name (WPatt(path,DefC,C,patt,WUnknown,t)) (delete_unknown d env)
      else raise Cannot_split_CPatt (id_of_path path)
|   cover_pattern name (WPatt(path,DefC,C,patt,_,t)) env = 
         raise Cannot_split_CPatt (id_of_path path)
;

fun expand_pattern (n,c) env =
      let val (newpatterns,env') = cover_pattern c (look_up_wpattern n env) env
          val newgoals = make_patt_goals newpatterns
      in (newgoals,change_wpattern_to_new n newpatterns (add_u_defs_to_env newgoals env'))
      end
;

fun show_defs_with_void path defs =
      myprint ("#Void : "^(mk_invisible_RHS_name path) ^ print_list show_new_def defs);


fun do_refine_pattern (wpath as WP(c,_)) (flag,coml,env,oldenv) =
      let val (pattern_path,varname) = get_impl_and_var wpath env
          val (newgoals,newenv) = expand_pattern (pattern_path,varname) env
      in (show_defs_with_void pattern_path ((look_up_u_prim c newenv)::newgoals);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;


fun change_wpatt_in_env wpatt path (Env(prims,abbrs,info,scr1,scr2)) =
      Env(prims,abbrs,info,change_wpatt_in_scratch [wpatt] path scr1,
                           change_wpatt_in_back [wpatt] path scr2)
;

fun make_case_pattern (WPatt(p as P(c,_),DefC,Con C,u,_,t)) path env =
      let val DefC' = add_contexts DefC C
          val I = defcontext_names DefC'
          val name = mk_invisible_path_name p
          val e_name = exppath name
          val t_name = typepath e_name
          val new_e = Expl(e_name,I)
          val new_t = TExpl(t_name,I)
          val newgoals = 
               [mknew_UTDef t_name DefC',UAbbr (UEDef(e_name,Unknown,new_t,DefC'))]
          val env' = add_u_defs_to_env newgoals env
          val wpatt = WPatt(p,DefC,Con C,u,WCase(new_e,new_t,[]),t)
       in (newgoals,change_wpatt_in_env wpatt path env') 
       end
;


fun create_case path env =
      let val (wpatt as WPatt(p,DefC,C,u,def,t)) = look_up_wpattern path env
      in case def of
          WExpr (Expl(c,l)) => 
             if isunknown c env then
               make_case_pattern wpatt path (delete_unknown c env)
             else raise Cannot_split_CPatt (id_of_path path)
        | WUnknown => make_case_pattern wpatt path env
        | _ => raise Cannot_split_CPatt (id_of_path path)
       end
;

fun do_case_pattern (wpath as WP(c,_)) (flag,coml,env,oldenv) =
      let val pattern_path = pattern_wpath_to_path wpath
          val (newgoals,newenv) = create_case pattern_path env
      in (show_defs_with_void pattern_path (look_up_u_prim c newenv::newgoals);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;    

fun get_massaged_type_and_context c (ct,cDefC) env =
      case look_up_u_abbr c env of
         (UEDef(_,_,t,DefC)) => (t,DefC)
        | _ => (ct,cDefC)
;

fun LHS_of_pattern (WP(c,(Ppath p)::Ppatt::(Ppath _)::l)) = true
|   LHS_of_pattern _ = false
;


fun wprint_applic (vl,cl) =
      let fun vprint (x,t) = "#Applic: #"^x^" : "^wprint_typ t
          fun cprint (c,t) = "#Applic: "^c^" : "^wprint_typ t
      in (print_rev_list vprint vl) ^ (print_rev_list cprint cl)
      end
;

fun IsSetConstructor (Sort "Set") = true
|   IsSetConstructor (Prod(_,Sort "Set")) = true
|   IsSetConstructor _ = false
;

fun get_applicable_sets (env as Env(prims,abbrs,_,Scratch(uprims,uabbrs,_,_),_)) =
      let fun set_prims (CTyp(c,t,_,_,_)::l) = (c,t)::set_prims l
          |   set_prims (ITyp(c,t,_,_,_)::l) = 
               if IsSetConstructor (unfold_type t env) then (c,t)::set_prims l
               else set_prims l
          |   set_prims [] = []
          fun set_uprims (UCTyp(c,DT t,_,_)::l) = (c,t)::set_uprims l
          |   set_uprims (UITyp(c,DT t,_,_)::l) = 
               if IsSetConstructor (unfold_type t env) then (c,t)::set_uprims l
               else set_uprims l
          |   set_uprims (_::l) = set_uprims l
          |   set_uprims [] = []
          fun set_abbrs (EDef(c,_,t,_,_)::l) =
               if IsSetConstructor (unfold_type t env) then (c,t)::set_abbrs l
               else set_abbrs l
          |   set_abbrs (TDef(c,t,_,_)::l) = 
               if IsSetConstructor (unfold_type t env) then (c,t)::set_abbrs l
               else set_abbrs l
          |   set_abbrs (_::l) = set_abbrs l
          |   set_abbrs [] = []
          fun set_uabbrs (UEDef(c,_,t,_)::l) =
               if visible_name c then 
                 if IsSetConstructor (unfold_type t env) then (c,t)::set_uabbrs l
                 else set_uabbrs l
               else set_uabbrs l
          |   set_uabbrs (UTDef(c,DT t,_)::l) =
               if visible_name c then 
                 if IsSetConstructor (unfold_type t env) then (c,t)::set_uabbrs l
                 else set_uabbrs l
               else set_uabbrs l
          |   set_uabbrs (_::l) = set_uabbrs l
          |   set_uabbrs [] = []
      in set_prims prims @ set_uprims uprims @ set_abbrs abbrs @ set_uabbrs uabbrs
      end
;

fun wprint_Tapplic_list (Con C) env = 
      wprint_applic (filter (fn (x,t) => IsSetConstructor (unfold_type t env)) C,get_applicable_sets env)
;

fun term_of_head (Let(_,e)) = e
|   term_of_head (App(f,argl)) = term_of_head f
|   term_of_head e          = e
;

fun IsVarConstructor x (Elem(_,e)) = Var x = head_of e
|   IsVarConstructor x (Prod(_,Elem(_,e))) = Var x = head_of e
|   IsVarConstructor _ _ = false
;

fun IsElemConstructor e (Elem(s,e')) = e = head_of e'
|   IsElemConstructor e (Prod(_,Elem(_,e'))) = e = head_of e'
|   IsElemConstructor _ _ = false
;

fun name_type_of_constr (ConTyp(c,t,_,_)) = (c,t);
fun get_name_type_of_u_constr (UConTyp(c,DT t,_)::l) = (c,t)::get_name_type_of_u_constr l
|   get_name_type_of_u_constr (_::l) = get_name_type_of_u_constr l
|   get_name_type_of_u_constr [] = []
;

fun get_applicable_constants e (env as Env(prims,abbrs,_,Scratch(uprims,uabbrs,_,_),_)) =
      let fun const_prims (CTyp(c,t,_,_,cl)::l) = 
                if c = name_of e then map name_type_of_constr cl @ const_prims l
                else const_prims l
          |   const_prims (ITyp(c,t,_,_,_)::l) = 
               if IsElemConstructor e (unfold_type t env) then (c,t)::const_prims l
               else const_prims l
          |   const_prims [] = []
          fun const_uprims (UCTyp(c,_,_,cl)::l) = 
                if c = name_of e then get_name_type_of_u_constr cl @ const_uprims l
                else const_uprims l
          |   const_uprims (UITyp(c,TUnknown,_,_)::l) = const_uprims l
          |   const_uprims (UITyp(c,DT t,_,_)::l) = 
               if IsElemConstructor e (unfold_type t env) then (c,t)::const_uprims l
               else const_uprims l
          |   const_uprims [] = []
          fun const_abbrs (EDef(c,_,t,_,_)::l) =
               if IsElemConstructor e (unfold_type t env) then (c,t)::const_abbrs l
               else const_abbrs l
          |   const_abbrs (_::l) = const_abbrs l
          |   const_abbrs [] = []
          fun const_uabbrs (UEDef(c,_,t,_)::l) =
               if visible_name c then 
                 if IsElemConstructor e (unfold_type t env) then (c,t)::const_uabbrs l
                 else const_uabbrs l
               else const_uabbrs l
          |   const_uabbrs (_::l) = const_uabbrs l
          |   const_uabbrs [] = []
      in const_prims prims @ const_uprims uprims @ const_abbrs abbrs @ const_uabbrs uabbrs
      end
;


fun find_applicable_names (Sort "Set") (Con C) env = 
      (filter (fn (x,t) => IsSetConstructor (unfold_type t env)) C,get_applicable_sets env)
|   find_applicable_names (Elem(s,e)) (Con C) env =
      let val head = term_of_head e
      in case head of
           (Var y) => (filter (fn (x,t) => IsVarConstructor y (unfold_type t env)) C,[])
         | e => (filter (fn (x,t) => IsElemConstructor e (unfold_type t env)) C,
                 get_applicable_constants e env)
      end
|   find_applicable_names _ _ _ = ([],[])
;
   
fun wprint_applic_list t context env = 
      wprint_applic (find_applicable_names (unfold_type t env) context env)
;


fun wprint_vardecl (x,t) = "#Vardecl: #"^x^" : "^wprint_typ t
;


fun wprint_t_info (s,Con C) =
      print_list wprint_vardecl C
      ^"\n#Type: "^s^"\n"
;

fun nyshow_info wpath env =
     case get_wpath_info wpath env of
       CInfo(DefC) => wprint_t_info ("context",unfold_defcontext DefC env)
     | TCInfo(TExpl(c,l),DefC) => 
         if istype_goal c env then 
           let val context = unfold_defcontext DefC env
           in (wprint_Tapplic_list context env) ^ (wprint_t_info ("type",context))
           end
         else wprint_t_info ("type",unfold_defcontext DefC env)
     | ETCInfo(Expl(c,l),t,DefC) => 
         if isunknown c env then
           let val (t,DefC) = get_massaged_type_and_context c (t,DefC) env  (**** FOR NOW UNTIL JOHAN CHANGED ****)
               val context = unfold_defcontext DefC env
           in (wprint_applic_list (unfold_type t env) context env) ^ (wprint_t_info (wprint_typ t,context))
           end
         else wprint_t_info (wprint_typ t,unfold_defcontext DefC env)
     | TCInfo(t,DefC) => wprint_t_info ("type",unfold_defcontext DefC env)
     | ETCInfo(e,t,DefC) => 
           let val context = unfold_defcontext DefC env
           in if LHS_of_pattern wpath then wprint_t_info (wprint_typ t,Con [])
              else wprint_t_info (wprint_typ t,context)
           end
     | TGoal(c,DefC) => 
           let val context = unfold_defcontext DefC env
           in (wprint_Tapplic_list context env) ^ (wprint_t_info ("type",context))
           end
     | EGoal(c,t,DefC) => 
           let val context = unfold_defcontext DefC env
           in (wprint_applic_list (unfold_type t env) context env) ^ (wprint_t_info (wprint_typ t,context))
           end
;


(******** Info to windowsystem *************)

fun do_showinfo s (flag,coml,env,oldenv) =
     let val wpath = window_path s env 
     in (myprint (nyshow_info wpath env);(flag,coml,env,oldenv))
     end
     handle error => (flag,coml,env,oldenv)  (* at least for now......... *)
;
fun Remove_sub_expression wpath env = update_rem_or_change_def REM wpath env;

(******** backtracking ************)


fun do_removedef c (flag,coml,env,oldenv) =
      let val newenv = Remove_sub_expression c env
      in (wprint_scratch (get_scratch newenv);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun all_dependent_names (deps as Deps(DN,CN,YN,DO,DDO)) name =
      let val depends_on = union(term_depends_on name DDO,type_depends_on name DDO)
          val derived_in = filter (fn x => not (visible_name x)) depends_on 
      in name::union(derived_in,(map_union (all_dependent_names deps) derived_in))
      end
;        

fun all_dependent_names_list deps (c::l) =
      union(all_dependent_names deps c,all_dependent_names_list deps l)
|   all_dependent_names_list deps [] = []
;


(*************** functions to delete or remove a constant *******************)

fun get_names_to_delete namelist (Back(uprims,defs,deps)) =   
           all_dependent_names_list deps namelist
;
fun get_backtrack (Env(_,_,_,_,back))                      = back;

fun delete_constructors c env =
       case look_up_name c env of
         UPrim (UCTyp(_,_,_,cl)) => get_names_to_delete (map name_of_u_constr cl) (get_backtrack env)
       | _ => []
;

fun delete_all_constructors (c::l) env =
      delete_constructors c env @ delete_all_constructors l env
|   delete_all_constructors [] env = []
;

fun in_type_list y ((x,(T,E))::l) =
      if mem T y then x::in_type_list y l else in_type_list y l
|   in_type_list y [] = []
;

fun used_by_list y ((x,(T,E))::l) =
      if mem E y then x::used_by_list y l else used_by_list y l
|   used_by_list y [] = []
;


fun used_elsewhere DDO l (name::del_list) =
      let val used_by = union(in_type_list name DDO,used_by_list name DDO)
      in if all_mem l used_by then used_elsewhere DDO l del_list
         else (name,used_by)::used_elsewhere DDO l del_list
      end
|   used_elsewhere _ _ [] = []
;

fun get_used_in (Deps(DN,CN,YN,DO,DDO)) del_list clist = 
     let fun remove_dep_list clist ((x,(T,E))::l) = 
               if mem clist x then (x,(T,[]))::l
               else (x,(T,E)):: remove_dep_list clist l
         |    remove_dep_list _ [] = []
     in used_elsewhere (remove_dep_list clist DDO) del_list del_list
     end
;
      


fun delete_list del_l (Back(uprims,defs,deps)) =
      let fun delete_def l (udef::defs) =
                if mem l (name_of_u_abbr udef) then delete_def l defs
                else udef::delete_def l defs
          |   delete_def l [] = []
          fun delete_prim l (UCTyp(name,t,DefC,cl)::defs) =
                if mem l name then delete_prim l defs
                else UCTyp(name,t,DefC,filter (fn d => not (mem l (name_of_u_constr d))) cl)::delete_prim l defs
          |   delete_prim l (udef::defs) =
                if mem l (name_of_u_prim udef) then delete_prim l defs
                else udef::delete_prim l defs
          |   delete_prim l [] = []
      in Back(delete_prim del_l uprims,delete_def del_l defs,update_delete_list del_l deps)
      end
;

fun delete_in_backtrack clist (backtrack as Back(uprims,defs,deps)) env =
      let val del_list = get_names_to_delete clist backtrack @ delete_all_constructors clist env
          val used_in = get_used_in deps (filter visible_name del_list) clist 
      in case used_in of
           [] => delete_list del_list backtrack
         | _ => raise Deleted_names_used_in used_in
      end
;

fun update_delete_def clist (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val backtrack' = delete_in_backtrack clist backtrack env
          val (orderedlist,newbacktrack) = sort_defs_in_order backtrack'
          val env' = Env(prims,abbrs,remove_info (get_scratch_names scratch) info,start_scratch,newbacktrack)
      in make_new_scratch orderedlist env'
      end
;

fun delete_definition clist (env as Env(prims,abbrs,i,scratch,backtrack)) = 
      let val scratch_names = get_scratch_names (get_scratch env)
      in if minus scratch_names clist = [] then Env(prims,abbrs,remove_info clist i,start_scratch,start_back)
         else case minus clist scratch_names of
               [] => update_delete_def clist env
              | l => raise Not_in_scratch l
      end
;(**************  commands that modify the environment, but is not refine-commands *********)

fun Remove_totally clist env = delete_definition clist env;

fun do_removeconst clist (flag,coml,env,oldenv) =
      let val env' = Remove_totally clist env
      in (wprint_scratch (get_scratch env');if undo flag then (flag,coml,env',UNDO env) else (flag,coml,env',oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun Remove_Case (WP(c,[Ppath p])) env = update_rem_or_change_def REM (WP(c,[Ppath p,Ppatt])) env
|   Remove_Case wpath env = raise Path_error ("Not a path to a case expression : "^print_wpath wpath)
;

fun do_removecase c (flag,coml,env,oldenv) =
      let val env' = Remove_Case (window_path c env) env
      in (wprint_scratch (get_scratch env');if undo flag then (flag,coml,env',UNDO env) else (flag,coml,env',oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun remove_patterns wpath (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val backtrack' = make_unknown_or_change REM wpath backtrack env
          val (orderedlist,newbacktrack) = sort_defs_in_order backtrack'
          val env' = Env(prims,abbrs,remove_info (get_scratch_names scratch) info,start_scratch,newbacktrack)
      in make_new_scratch orderedlist env'
      end
;

fun Remove_Patterns (wp as WP(c,[])) env = 
      (case get_id_kind c env of
        (true,Impl_kind) => remove_patterns (WP(c,[Ppatt])) env
      | _ => raise Path_error ("Not a path to an implicit constant : "^print_wpath wp))
|   Remove_Patterns wp env = raise Path_error ("Not a path to an implicit constant : "^print_wpath wp)
;

fun do_removepatterns c (flag,coml,env,oldenv) =
      let val env' = Remove_Patterns (window_path c env) env
      in (wprint_scratch (get_scratch env');if undo flag then (flag,coml,env',UNDO env) else (flag,coml,env',oldenv))
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
fun change_to_unfolded_type (TExpl(c,l)) DefC wpath env =
      (case get_type_def_of c env of
        TUnknown => raise Can't_massage c
      | DT t => update_rem_or_change_def (CHANGE_T t) wpath env)
|   change_to_unfolded_type t DefC wpath env = raise Not_An_Abbreviation (print_typ t)
;

fun nfterm I env e = 
 case hnf I env e of 
 HNform (App(x,al)) => App(x,map (nfterm I env) al)
|HNform (Lam(vb,e)) => Lam(vb,nfterm (vb@I) env e)
|HNform u => u 
|NotYet (App(x,al)) => App(x,map (nfterm I env) al)
|NotYet u => u
|Irred (App(x,al)) => App(x,map (nfterm I env) al)
|Irred u => u ;



fun nf_term c env e =
     nfterm (defcontext_names c) env e
;

fun nf_type DefC env (Elem (s,e)) = Elem(s,nf_term DefC env e)
|   nf_type DefC env (Prod(argl,t)) = Prod(nf_type_map DefC env argl,nf_type DefC env t)
|   nf_type DefC env (TExpl(c,l)) =
      (case get_type_def_of c env of
         TUnknown => TExpl(c,l)
      | (DT t) => nf_type DefC env t)
|   nf_type DefC env (TLet(vb,c,l)) =
      (case get_type_def_of c env of
         TUnknown => TLet(vb,c,l)
      | (DT t) => nf_type DefC env (inst_type (defcontext_names DefC) vb t))
|   nf_type DefC env t = t
and nf_type_map DefC env ((Arr t)::l) = Arr (nf_type DefC env t)::nf_type_map DefC env l
|   nf_type_map DefC env ((Dep(x,t))::l) = Dep(x,(nf_type DefC env t))::nf_type_map DefC env l
|   nf_type_map _ _ [] = []
;
fun change_to_nf_type t DefC wpath env = update_rem_or_change_def (CHANGE_T (nf_type DefC env t)) wpath env;

fun hnf_type DefC env (Elem (s,e)) = Elem(s,hnf_term DefC env e)
|   hnf_type DefC env (Prod(argl,t)) = Prod(hnf_type_map DefC env argl,hnf_type DefC env t)
|   hnf_type DefC env (TExpl(c,l)) =
      (case get_type_def_of c env of
         TUnknown => TExpl(c,l)
      | (DT t) => hnf_type DefC env t)
|   hnf_type DefC env (TLet(vb,c,l)) =
      (case get_type_def_of c env of
         TUnknown => TLet(vb,c,l)
      | (DT t) => hnf_type DefC env (inst_type (defcontext_names DefC) vb t))
|   hnf_type DefC env t = t
and hnf_type_map  DefC env ((Arr t)::l) = Arr (hnf_type DefC env t)::hnf_type_map DefC env l
|   hnf_type_map  DefC env ((Dep(x,t))::l) = Dep(x,(hnf_type DefC env t))::hnf_type_map DefC env l
|   hnf_type_map _ _ [] = []
;
fun change_to_hnf_type t DefC wpath env = update_rem_or_change_def (CHANGE_T (hnf_type DefC env t)) wpath env;
datatype CHANGE_INFO = HNF | NF | UNFOLD;

fun change_to_unfolded_term (Expl(c,l)) DefC wpath env = 
      (case get_definiens_of c env of
        Unknown => raise Can't_massage c
      | D e => update_rem_or_change_def (CHANGE e) wpath env)
|   change_to_unfolded_term e DefC wpath env = raise Not_An_Abbreviation (print_exp e)
;
fun change_to_nf_term e DefC wpath env = update_rem_or_change_def (CHANGE (nf_term DefC env e)) wpath env;
fun change_to_hnf_term e DefC wpath env = update_rem_or_change_def (CHANGE (hnf_term DefC env e)) wpath env;

fun do_change_massaged kind (wp as WP(c,_)) (flag,coml,env,oldenv) =
     let val newenv = 
           case get_wpath_info wp env of
             TCInfo(t,DefC) => 
               (case kind of
                  UNFOLD => change_to_unfolded_type t DefC wp env
                | NF => change_to_nf_type t DefC wp env
                | HNF => change_to_hnf_type t DefC wp env
               )
           | ETCInfo(e,t,DefC) => 
               (case kind of
                  UNFOLD => change_to_unfolded_term e DefC wp env
                | NF => change_to_nf_term e DefC wp env
                | HNF => change_to_hnf_term e DefC wp env
               )
          | TGoal(c,DefC) => raise Can't_massage c
          | EGoal(c,t,DefC) => raise Can't_massage c
          | CInfo(DefC) => raise Can't_massage (print_def_context DefC)
     in (wprint_scratch (get_scratch newenv);if undo flag then (flag,coml,newenv,UNDO env) else (flag,coml,newenv,oldenv))
     end
     handle error => (errormessage error ; (flag,coml,env,oldenv));

fun do_print_name names (flag,coml,env,oldenv) =
      (show_defs (look_up_names names env) handle error => errormessage error ; 
      (flag,coml,env,oldenv))
;
(************** printing info to window system *********************)

fun wprint_env (Env(prims,abbrs,_,scratch,_)) =
      (myprint (show_new_defs (map Prim prims));
       myprint (show_new_defs (map Abbr abbrs)))
;

fun do_print_env (flag,coml,env,oldenv) =
      (wprint_env env handle error => errormessage error ;
      (flag,coml,env,oldenv))
;

fun do_print_scratch (flag,coml,env,oldenv) =
      (wprint_scratch (get_scratch env)
       handle error => errormessage error ;
      (flag,coml,env,oldenv))
;
 
fun ppplist s [(a,(t,l))] = s^a^" => "^plist t^","^plist l
|   ppplist s ((a,(t,l))::l') = s^a^" => "^plist t^","^plist l^"\n"^ppplist s l'
|   ppplist s [] = ""
;

fun pplist s [(a,l)] = s^a^" => "^plist l
|   pplist s ((a,l)::l') = s^a^" => "^plist l^"\n"^pplist s l'
|   pplist s [] = ""
;
    
fun print_deps (Deps(AL,CN,YN,DO,DDO)) =
     "\nAL = ["^print_list (fn (x,y) => x^" => "^y) AL ^"]"
    ^"\nCN = "^plist CN
    ^"\nYN = "^plist YN
    ^"\nDO =\n"^pplist "     " DO
    ^"\nDDO =\n"^ppplist "      " DDO
;

fun  print_my_backtrack_in_order (Back(u_prims,u_abbr,deps)) =
       "\n\n(********** backtrack ************)\n"^
       print_rev_list print_env_kind (sort_in_order u_abbr u_prims deps)^"\n"^
       print_deps deps
;

fun print_my_scratch (Scratch(uprims,u_abbr,[],deps)) =
       print_list print_u_prim uprims^"\n"^
       print_list print_u_abbr u_abbr^"\n"^
       print_deps deps
|   print_my_scratch (Scratch(uprims,u_abbr,env_constr,deps)) =
       print_list print_u_prim uprims^"\n"^
       print_list print_u_abbr u_abbr^"\n"^
       print_env_constraint env_constr^
       "\n**** end constraints ****)\n"^
       print_deps deps
;   


fun print_env_info (Info(symbols,_,_,_)) =
     "Symbols = "^plist (map print_exp symbols)^"\n"
;

fun print_my_env (Env(_,_,info,scratch,backtrack)) =
      print_env_info info^
      print_my_scratch scratch^
      print_my_backtrack_in_order backtrack
;

fun do_print_actual (flag,coml,env,oldenv) =
      (myprint (print_my_env env)
       handle error => errormessage error ;
      (flag,coml,env,oldenv))
;(***************************************************************************)    
(******************* FUNCTIONS TAKING CARE OF COMMANDS *********************)
(***************************************************************************)    


(**************  functions to print answers etc. ************)
    
fun Show_constraints (Scratch(_,_,[],_)) = "\n There are no constraints.\n"
|   Show_constraints (Scratch(_,_,constraints,_)) =
    "\n Constraints : \n"^print_env_constraint constraints;

fun do_print_constr (flag,coml,env,oldenv) =
      (myprint (Show_constraints (get_scratch env))
       handle error => errormessage error ;
      (flag,coml,env,oldenv))
;

fun print_unknown (UEDef(name,Unknown,t,c)::l) =
      name^" = ? : "^print_typ t^"     "^print_def_context c^"\n\n"^print_unknown l
|   print_unknown (_::l) = print_unknown l
|   print_unknown [] = "\n"
    ;

fun print_subgoals (Env(_,_,_,Scratch(_,u_abbrs,_,_),_)) =
      print_unknown u_abbrs
;

fun do_print_unknown (flag,coml,env,oldenv) =
      (myprint (print_subgoals env)
       handle error => errormessage error ;
      (flag,coml,env,oldenv))
;

fun print_visible_subgoals (Env(_,_,_,Scratch(_,u_abbrs,_,deps),_)) =
      let val visible_u_abbr = 
            filter (fn def => visible_name (name_of_u_abbr def)) u_abbrs
      in print_unknown visible_u_abbr
      end
;

fun do_print_visible_unknown (flag,coml,env,oldenv) =
      (myprint (print_visible_subgoals env)
       handle error => errormessage error ;
      (flag,coml,env,oldenv))
;


fun do_typecheck ce ct cDefC (flag,coml,env,oldenv) =
      let val (e,t,DefC) = convert_exp_typ_DefC ce ct cDefC env
      in (myprint (print_constraint (Type_and_Context_Check e t DefC env));
         (flag,coml,env,oldenv))
      end handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun get_unfold_Tdef c l env =
     case get_type_def_of c env of
       TUnknown => TExpl(c,l)
     | DT t => t
;

fun show_type t = "\n#Type: "^wprint_typ t^"\n";
    

(********** functions to unfold and insert a definition in env ************)

fun get_unfold_def c l env =
     case get_definiens_of c env of
       Unknown => Expl(c,l)
     | D e => e
;
fun show_term e = "\n#Term: "^wprint_exp e^"\n";

fun do_show_massaged kind (wp as WP(c,p)) (flag,coml,env,oldenv) =
     case get_wpath_info wp env of
       TCInfo(t,DefC) => 
         let val t' = case kind of
                        UNFOLD => (case t of
                                   TExpl(c,l) => get_unfold_Tdef c l env
                                  | _ => raise Not_An_Abbreviation c)
                      | NF => nf_type DefC env t
                      | HNF => hnf_type DefC env t
         in (myprint (show_type t');(flag,coml,env,oldenv))
         end
     | ETCInfo(e,t,DefC) => 
         let val e' = case kind of
                        UNFOLD => (case e of
                                    Expl(c,l) => get_unfold_def c l env
                                  | _ => raise Not_An_Abbreviation c)
                      | NF => nf_term DefC env e
                      | HNF => hnf_term DefC env e
         in (myprint (show_term e');(flag,coml,env,oldenv))
         end
     | TGoal(c,DefC) => raise Can't_massage c
     | EGoal(c,t,DefC) => raise Can't_massage c
     | CInfo(DefC) => raise Can't_massage (print_def_context DefC)
;

fun convert_subst_exp_DefC cs ce cDefC env =
      let val (DefC,allsymbols) = convert_DefC cDefC env
          val I = defcontext_names DefC
      in (convert_DefS I cs allsymbols env,convert_exp I env allsymbols ce,DefC)
      end
;

(*
fun undefined_var_used x ((y,TUnknown)::l) = undefined_var_used x l
|   undefined_var_used x ((y,DT t)::l) =
      mem (get_subset_fidents_type [] t) x orelse undefined_var_used x l
|   undefined_var_used x [] = false
;

fun UDefC_check (Con l) env = 
      let fun check ((x,DT A)::C) C' I env =
               if occurs I x then raise Variable_twice_in_context x
               else (case (istype_check A (DCon ([GCon C'],I)) I env) of
                       (Ok cl) => add_constraints cl (check C ((x,A)::C') (x::I) env)
                     | notequals => notequals)
          |   check ((x,TUnknown)::C) C' I env =
               if occurs I x then raise Variable_twice_in_context x
               else if undefined_var_used x C 
                      then raise Variable_used_before_defined (x,U_GCon l)
                    else check C C' (x::I) env
          |   check [] _ _ _ = Ok []
      in check l [] [] env
      end
;
*)

fun is_proper_context DefC env =
      (case iscontext_check DefC env of
         (Ok []) => true
       | cl => raise Constraints_in_context (DefC,cl))
;

fun do_check_fits cvb cf cDefC (flag,coml,env,oldenv) = 
      let val (S,f,DefC) = convert_subst_exp_DefC cvb cf cDefC env
          val C = get_real_context f env
          val I = defcontext_names DefC
      in if on_subst_form f then
           (if is_proper_context DefC env then 
              myprint (print_constraint 
                (fits_context (unfold_defsubst S env (context_names C)) C DefC I env))
            else myprint "\nNot a proper context.\n" ;
           (flag,coml,env,oldenv))
         else raise Fits_with_non_subst_form f
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;


fun do_help (flag,coml,env,oldenv) =
      ((system "cat WINDOW_ALF_HELP_FILE");(flag,coml,env,oldenv))
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun print_hist [] = ""
|   print_hist (s::sl) = print_hist sl^s
;

fun print_history filename (env as Env(_,_,Info(_,_,_,[]),_,_)) = (myprint "No history.";env)
|   print_history filename (env as Env(_,_,Info(_,_,_,[_]),_,_)) = (myprint "No history.";env)
|   print_history filename (Env(p,a,Info(x,y,z,_::historylist),s,b)) =  (* first is command 'history' *)
      let val outstr = open_out filename
      in (output (outstr,print_hist historylist);
          close_out outstr;
          myprint ("History saved in "^filename);
          Env(p,a,Info(x,y,z,historylist),s,b))
      end
;

fun do_history filename (flag,coml,env,oldenv) =
      let val newenv = print_history filename env
      in (flag,coml,newenv,oldenv)
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun id_of_def (Prim(CTyp(_,_,_,id,_))) = id
|   id_of_def (Prim(ITyp(_,_,_,id,_))) = id
|   id_of_def (Patt(IDef(_,_,_,_,id))) = id
|   id_of_def (Constr(_,ConTyp(_,_,_,id))) = id
|   id_of_def (Abbr(EDef(_,_,_,_,id))) = id
|   id_of_def (Abbr(TDef(_,_,_,id))) = id
|   id_of_def (Abbr(CDef(_,_,id))) = id
|   id_of_def (Abbr(SDef(_,_,_,_,id))) = id
|   id_of_def _ = raise Unsure_in_theory
;

fun sort_defs_by_id [] = []
|   sort_defs_by_id [d] = [d]
|   sort_defs_by_id (d::defs) =
     let fun split (d::l) (sm,la) id = if id_of_def d < id then split l (d::sm,la) id
                                       else split l (sm,d::la) id
         |   split [] (sm,la) _ = (sm,la)
         val (smaller,larger) = split defs ([],[d]) (id_of_def d)
     in sort_defs_by_id larger @ sort_defs_by_id smaller
     end
;

fun get_all_theory_defs prims abbrs =
      let fun make_env_kind ((d as CTyp(name,_,_,_,cl))::prims) =
                (Prim d)::(map (fn d => Constr(name,d)) cl)@make_env_kind prims
          |   make_env_kind ((d as ITyp(_,_,_,_,pl))::prims) =
                (Prim d)::(map Patt pl)@make_env_kind prims
          |    make_env_kind [] = []
          val all_defs = make_env_kind prims @ (map Abbr abbrs)
      in sort_defs_by_id all_defs
      end
;


fun print_bug filename (env as Env(prims,abbrs,info,scratch,backtrack)) =
      let val newenv = print_history (filename^".hist") env
          val dummy = if empty_scratch env then ()
                      else print_scratch_to_file (filename^".alf.scratch") env
          val all_defs = get_all_theory_defs prims abbrs
      in if all_defs = [] then newenv 
         else let val outstr = open_out (filename^".alf")
              in (output (outstr,print_list print_new_def all_defs);
	          close_out outstr;
                  newenv)
              end
      end
;

fun do_print_bug filename (flag,coml,env,oldenv) =
      let val newenv = print_bug filename env
      in (flag,coml,newenv,oldenv)
      end
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;

fun read_command_file filename =
      let fun divide_com [Symbol ";;"] R = [parse_command (rev R)]
          |   divide_com ((Symbol ";;")::R') R = (parse_command (rev R))::(divide_com R' [])
	  |   divide_com (a::R') R = divide_com R' (a::R)	
          |   divide_com [] R = raise Incomplete_command
      in divide_com (lexanal (read_file filename)) []
      end
;

fun do_com_file filename (flag,coml,env,oldenv) =
      (flag,(read_command_file filename) @ coml,env,oldenv)
      handle error => (errormessage error ; (flag,coml,env,oldenv))
;
  
fun do_nocommand s (flag,coml,env,oldenv) =
      (myprint ("#ERROR: Unknown command : "^s) ; (flag,coml,env,oldenv))
;

fun wprint_all (Env(prims,abbrs,_,scratch,_)) =
      (myprint (show_new_defs (map Prim prims));
       myprint (show_new_defs (map Abbr abbrs));
       wprint_scratch scratch)
;
fun do_undo (flag,coml,env,UNDO oldenv) =
      if undo flag then (wprint_all oldenv ; (flag,coml,add_history "undo;;\n" oldenv,UNDO env))
      else (myprint "#ERROR: Undo_flag not properly set...";(flag,coml,env,UNDO oldenv))
|   do_undo (flag,coml,env,NOTHING) =
      if undo flag then (myprint "#ERROR: Undo_flag not properly set...";(flag,coml,env,NOTHING))
      else (myprint "#ERROR: You started ALF with undo switched off...";(flag,coml,env,NOTHING))
;

fun docommand (flag,commandlist,currentenv,oldenv) =
      let val (command,rest,hist) = get_command commandlist currentenv
          val newenv = case command of
                         Show_info _ => currentenv
                       | _ => add_history hist currentenv
      in case command of
(* file commands to extend and save the theory *)
	  New_env => 
            docommand (do_new_env (flag,rest,newenv,oldenv))
        | New_scratch => 
            docommand (do_new_scratch (flag,rest,newenv,oldenv))
        | Include_file filename =>
            docommand (do_include_file filename (flag,rest,newenv,oldenv))
        | Reinclude_file filename =>
            docommand (do_reinclude_file filename (flag,rest,newenv,oldenv))
        | Load_file filename => 
            docommand (do_load_file filename (flag,rest,newenv,oldenv))
        | Reload_file filename => 
            docommand (do_reload_file filename (flag,rest,newenv,oldenv))
        | Load_scratch filename => 
            docommand (do_load_scratch filename (flag,rest,newenv,oldenv))
        | Save_defs filename => 
            docommand (do_save filename (flag,rest,newenv,oldenv)) 
        | Save_scratch filename => 
            docommand (do_save_scratch filename (flag,rest,newenv,oldenv)) 
        | Move_to_env name =>
            docommand (do_move_to_env name (flag,rest,newenv,oldenv)) 
(* extending the scratch area *)
        | New_exp name => 
            docommand (do_new_exp name (flag,rest,newenv,oldenv))
        | New_type name => 
            docommand (do_new_type name (flag,rest,newenv,oldenv))
        | New_context name => 
            docommand (do_new_context name (flag,rest,newenv,oldenv))
        | New_subst definition => 
            docommand (do_new_subst definition (flag,rest,newenv,oldenv))
        | New_set name => 
            docommand (do_new_set name (flag,rest,newenv,oldenv))
        | New_constr (setname,name) => 
            docommand (do_new_constr name setname (flag,rest,newenv,oldenv))
        | New_impl name => 
            docommand (do_new_impl name (flag,rest,newenv,oldenv))
        | Move_to_scratch namelist =>
            docommand (do_move_to_scratch namelist (flag,rest,newenv,oldenv)) 
        | Extend_context (c,name) =>
            docommand (do_extend_context (window_path c newenv) name (flag,rest,newenv,oldenv)) 
        | Change_context (c,cDefC) =>
            docommand (do_change_context (window_path c newenv) cDefC (flag,rest,newenv,oldenv)) 
(* refining a goal *)
        | Abstr p => 
            docommand (do_abstr p (flag,rest,newenv,oldenv))
        | Abstr_all p => 
            docommand (do_abstr_all p (flag,rest,newenv,oldenv))
        | Refine (p,e) => 
            docommand (do_refine p e (flag,rest,newenv,oldenv))
        | Change (p,e) =>
            docommand (do_change p e (flag,rest,newenv,oldenv))
        | Abstract_type (p,x) => 
            docommand (do_abstract_type p x (flag,rest,newenv,oldenv))
        | Refine_type (p,t) => 
            docommand (do_refine_type p t (flag,rest,newenv,oldenv))
        | Change_type (p,t) =>
            docommand (do_change_type p t (flag,rest,newenv,oldenv))
        | Solve_constr n =>
            docommand (do_solve_constraint n (flag,rest,newenv,oldenv))
(* refining a pattern *)
        | Create_pattern p => 
            docommand (do_create_pattern p (flag,rest,newenv,oldenv))
        | Refine_pattern p => 
            docommand (do_refine_pattern p (flag,rest,newenv,oldenv))
        | Case_pattern p => 
            docommand (do_case_pattern p (flag,rest,newenv,oldenv))
(* info to windowsystem *)
        | Show_info p =>
            docommand (do_showinfo p (flag,rest,newenv,oldenv))
(* backtracking *)
        | Remove_def c => 
            docommand (do_removedef (window_path c newenv) (flag,rest,newenv,oldenv))
        | Remove_const c => 
            docommand (do_removeconst c (flag,rest,newenv,oldenv))
        | Remove_case c => 
            docommand (do_removecase c (flag,rest,newenv,oldenv))
        | Remove_patterns c => 
            docommand (do_removepatterns c (flag,rest,newenv,oldenv))
(* Massaging a subterm/type *)
        | Unfold wpath => 
            docommand (do_change_massaged UNFOLD wpath (flag,rest,newenv,oldenv))
        | Hnf wpath =>
            docommand (do_change_massaged HNF wpath (flag,rest,newenv,oldenv))
        | Nf wpath =>
            docommand (do_change_massaged NF wpath (flag,rest,newenv,oldenv))
(* Printing commands *)
        | Print_name names => 
            docommand (do_print_name names (flag,rest,newenv,oldenv))
        | Print_env => 
            docommand (do_print_env (flag,rest,newenv,oldenv))
        | Print_scratch => 
            docommand (do_print_scratch (flag,rest,newenv,oldenv))
        | Print_actual_env => 
            docommand (do_print_actual (flag,rest,newenv,oldenv))
        | Print_constr => 
            docommand (do_print_constr (flag,rest,newenv,oldenv))
        | Print_unknown => 
            docommand (do_print_unknown (flag,rest,newenv,oldenv))
        | Print_visible_unknown => 
            docommand (do_print_visible_unknown (flag,rest,newenv,oldenv))
(* Question commands *)
        | Typecheck (e,t,c) => 
            docommand (do_typecheck e t c (flag,rest,newenv,oldenv))
        | Show_hnf wpath => 
            docommand (do_show_massaged HNF wpath (flag,rest,newenv,oldenv))
        | Show_nf wpath => 
            docommand (do_show_massaged NF wpath (flag,rest,newenv,oldenv))
        | Show_unfold wpath => 
            docommand (do_show_massaged UNFOLD wpath (flag,rest,newenv,oldenv))
	| Fits (dl,e,c) => 
            docommand (do_check_fits dl e c (flag,rest,newenv,oldenv))
(* Other useful commands *)
        | Help => 
            docommand (do_help (flag,rest,newenv,oldenv)) 
        | History filename =>
            docommand (do_history filename (flag,rest,newenv,oldenv)) 
        | Print_bug filename =>
            docommand (do_print_bug filename (flag,rest,newenv,oldenv)) 
        | Com_file filename => 
            docommand (do_com_file filename (flag,rest,newenv,oldenv)) 
        | NoCommand s => 
            docommand (do_nocommand s (flag,rest,newenv,oldenv)) 
        | Undo => docommand (do_undo (flag,rest,newenv,oldenv))
        | Quit => myprint "\n Goodbye.\n\n"  (* newenv *)
     end
;

     
fun go flags =  (print_start_info();
	     if undo flags then docommand (flags,[],start_env,UNDO start_env)
             else docommand (flags,[],start_env,NOTHING)
	    )
;
 
fun alfII (args, env) = go args;

