(*
 * $Log: _simpleutils.sml,v $
 * Revision 1.28  1997/05/09 11:12:42  matthew
 * Adding substitution functions
 *
 * Revision 1.27  1997/02/11  16:17:04  matthew
 * Fixing problem with linearize1 and switches
 *
 * Revision 1.26  1997/01/13  10:24:15  andreww
 * [Bug #1818]
 * Adding Floatarray builtins.
 *
 * Revision 1.25  1997/01/06  16:38:06  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.24  1996/12/18  14:39:02  matthew
 * Removing BUILTINAPP
 *
 * Revision 1.23  1996/10/31  16:02:16  io
 * moving String from toplevel
 *
 * Revision 1.22  1996/04/30  16:32:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.21  1996/04/19  10:52:03  matthew
 * Removed some exceptions
 *
 * Revision 1.20  1996/03/28  10:24:38  matthew
 * Adding where type clause
 *
 * Revision 1.19  1996/03/26  12:32:41  jont
 * Modify safety category of VECTOR_SUB and INTABS
 *
 * Revision 1.18  1996/03/20  12:19:00  matthew
 * Make CALL_C safe to allow applications to be lifted to top level
 *
 * Revision 1.17  1995/10/12  14:10:14  jont
 * Prevent lifting of handler functions
 *
 * Revision 1.16  1995/09/12  12:23:02  daveb
 * Replaced use of LambdaTypes.Option.opt with MLWorks.Option.option.
 *
 * Revision 1.15  1995/09/04  10:00:45  jont
 * Add word comparisons to list of simple comparisons
 *
 * Revision 1.14  1995/07/31  11:04:17  jont
 * Add overloaded div and mod
 *
 * Revision 1.13  1995/07/25  11:50:50  jont
 * Add word operations
 *
 * Revision 1.12  1995/07/14  10:08:33  jont
 * Add builtin char operations
 *
 * Revision 1.11  1995/04/28  11:44:15  matthew
 * Adding UMAP and CAST pervasives
 *
 * Revision 1.10  1995/04/27  15:34:33  jont
 * Fix require statements and comments
 *
 * Revision 1.9  1995/02/16  15:24:16  matthew
 * Adding debugger pervasives
 *
 * Revision 1.8  1995/01/19  17:06:50  matthew
 * Improving interaction with debugger
 *
 * Revision 1.7  1995/01/10  11:18:33  matthew
 * Adding MLVALUE
 *
 * Revision 1.6  1994/11/29  11:02:04  matthew
 * Extra clause for safety of APP (BUILTIN _,_,_)
 *
 * Revision 1.5  1994/11/21  15:17:30  matthew
 * cin _lambdaio.sml
 * Added new pervasives
 *
 * Revision 1.4  1994/11/14  11:44:05  matthew
 * Little hack for lifting raises
 *
 * Revision 1.3  1994/10/12  09:32:16  matthew
 * Changed simpletypes unit name
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *)

require "../utils/lists";
require "^.basis.__list";
require "../main/pervasives";
require "../basics/scons";
require "../utils/crash";
require "lambdatypes";
require "simpleutils";

functor SimpleUtils ( structure Lists : LISTS
                      structure LambdaTypes : LAMBDATYPES where type LVar = int
                      structure Pervasives  : PERVASIVES
                      structure Scons : SCONS
                      structure Crash : CRASH 

                      sharing type Scons.SCon = LambdaTypes.Ident.SCon
                      sharing type LambdaTypes.Primitive = Pervasives.pervasive
                        ) : SIMPLEUTILS =
struct
  
  structure LambdaTypes = LambdaTypes

  open LambdaTypes

  exception Error of string

  val null_debug = NONE

  fun is_absent NONE = true
    | is_absent _ = false

  fun optfun f (SOME x) = SOME (f x)
    | optfun f NONE = NONE

  fun iterate f ([],acc) = acc
    | iterate f (e::l,acc) = iterate f (l,f(e,acc))

  fun intmember (i:int,[]) = false
    | intmember (i:int,i'::rest) = i = i' orelse intmember (i,rest)

  fun list_add_var (var,l) =
    if intmember (var,l) then l else var::l

  (* Find free variables *)
  fun freevars (exp,dyn_vars) =
    let
      fun aux (INT _,acc) = acc
        | aux (SCON _,acc) = acc
        | aux (BUILTIN _,acc) = acc
        | aux (VAR var,acc) = if intmember (var,dyn_vars) then list_add_var (var,acc) else acc
        | aux (APP (e,(el,fpel),_),acc) = iterate (fn (e,acc) => aux (e,acc)) (fpel @ el,aux (e,acc))
        | aux (FN (args,e,_,_,_,_),acc) = aux (e,acc)
        | aux (STRUCT (el,_),acc) = iterate (fn (e,acc) => aux (e,acc)) (el,acc)
        | aux (SWITCH (e,info,tel,opte), acc) =
          let
            val acc1 = aux (e,acc)
            val acc2 = iterate (fn ((t,e),acc) => aux (e,(taux (t,acc)))) (tel,acc1)
          in
            case opte of
              SOME e => aux (e,acc2)
            | _ => acc2
          end
        | aux (HANDLE (e1,e2,_),acc) = aux (e1,aux (e2,acc))
        | aux (RAISE e,acc) = aux (e,acc)
        | aux (SELECT (_,e),acc) = aux (e,acc)
        | aux (LET ((v,_,e1),e2),acc) = aux (e2,aux(e1,acc))
        | aux (LETREC (fl,el,e),acc) =
          let
            val newacc = iterate aux (el,acc)
          in
            aux (e,newacc)
          end
        | aux (MLVALUE _,acc) = acc
      and taux (EXP_TAG e ,acc) = aux(e,acc)
        | taux (_,acc) = acc
    in
      rev (aux (exp,[]))
    end
  
  fun occurs (lvar, expression) =
    let
      fun occurs(VAR lv) = lv = lvar
	| occurs(FN(_,le,_,_,_,_)) = occurs le
	| occurs(LET((lv,_,lb),le)) = occurs lb orelse occurs le
	| occurs(LETREC(lv_list, le_list, le)) =
	  (occurs le orelse Lists.exists occurs le_list)
	| occurs(APP(le, (lel,fpel),_)) = (occurs le orelse Lists.exists occurs lel orelse Lists.exists occurs fpel)
	| occurs(SCON _) = false
	| occurs(MLVALUE _) = false
	| occurs(INT _) = false
	| occurs(SWITCH(le, info, tag_le_list, leo)) =
	  (occurs le orelse
	   occurs_opt leo orelse
	   Lists.exists occurs_tag tag_le_list)
	| occurs(STRUCT (le_list,_)) = Lists.exists occurs (le_list)
	| occurs(SELECT(_, le)) = occurs le
	| occurs(RAISE (le)) = occurs le
	| occurs(HANDLE(le, le',_)) = (occurs le orelse occurs le')
	| occurs(BUILTIN _) = false

      and occurs_opt(NONE) = false
	| occurs_opt(SOME le) = occurs le

      and occurs_tag (tag, le) =
	(case tag of
	   EXP_TAG le' => occurs le' orelse occurs le
	 | _ => occurs le)
    in
      occurs expression
    end

   (* Use only for simple expressions *)
   (* Doesn't accumulate function names *)
   fun vars_of exp =
     let
       fun aux (INT _,acc) = acc
         | aux (SCON _,acc) = acc
         | aux (MLVALUE _,acc) = acc
         | aux (BUILTIN _,acc) = acc
         | aux (VAR var,acc) = list_add_var (var,acc)
         | aux (APP (e,(el,fpel),_),acc) = laux (fpel, laux (el,aux(e,acc)))
         | aux (STRUCT (el,_),acc) = laux (el,acc)
         | aux (RAISE e,acc) = aux (e,acc)
         | aux (SELECT (_,e),acc) = aux (e,acc)
         | aux _ = Crash.impossible "Complex expression in vars_of"
       and laux ([],acc) = acc
         | laux (e::el,acc) = laux (el,aux(e,acc))
     in
       rev (aux (exp,[]))
     end

  (* OK things to always inline *)
  (* Really only want int scons, but problems with LOAD_STRING *)
  fun is_atomic (VAR _) = true
    | is_atomic (STRUCT ([],_)) = true
    | is_atomic (INT _) = true
    | is_atomic (SCON _) = true
    | is_atomic (BUILTIN _) = true
    | is_atomic _ = false
      
  fun is_simple exp =
    case exp of
      LET _=> false 
    | LETREC _ => false
    | FN _ => false
    | SWITCH _ => false
    | HANDLE _ => false
    | _ => true
                  
fun wrap_lets (e,[]) = e
  | wrap_lets (e',(v,i,e)::vel) =
    wrap_lets (LET ((v,i,e),e'),vel)

fun unwrap_lets e =
  let
    fun aux (LET ((v,i,e1),e2),acc) =
      aux (e2,(v,i,e1)::acc)
      | aux (e,acc) = (acc,e)
  in
    aux (e,[])
  end

fun is_simple_comparison b =
  case b of
    Pervasives.INTLESS => true
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
  | Pervasives.WORDEQ => true
  | Pervasives.WORDNE => true
  | Pervasives.WORDLT => true
  | Pervasives.WORDLE => true
  | Pervasives.WORDGT => true
  | Pervasives.WORDGE => true
  | Pervasives.CHAREQ => true
  | Pervasives.CHARNE => true
  | Pervasives.CHARLT => true
  | Pervasives.CHARLE => true
  | Pervasives.CHARGT => true
  | Pervasives.CHARGE => true
  | _ => false
      

fun switchable_exp e =
  is_atomic e orelse
  (case e of
     APP (BUILTIN b,_,_) =>
       is_simple_comparison b
   | _ => false)
    
fun switch_unwrap_lets e =
  let
    val (lets,e) = unwrap_lets e
  in
    if switchable_exp e
      then (lets,e)
    else
      let
        val id = new_LVar ()
      in
        ((id,null_debug,e) :: lets,VAR id)
      end
  end

(* Linearize an expression *)
(* This could be done better *)
fun linear1 (exp as INT _) = exp
  | linear1 (exp as SCON _) = exp
  | linear1 (exp as MLVALUE _) = exp
  | linear1 (exp as BUILTIN _) = exp
  | linear1 (exp as VAR _) = exp
  | linear1 (APP (FN (([x],[]),body,_,_,_,_),([arg],[]),_)) =
    linear1 (LET ((x,null_debug,arg),body))
  | linear1 (exp as APP (e1,(el,fpel),ty)) =
    if is_atomic e1
      then
        linear1_list (el,fn el => linear1_list (fpel, fn fpel => APP (e1,(el,fpel),ty)))
    else
      let
        val e1' = linear1 e1
        val var1 = new_LVar()
      in
        LET ((var1,null_debug,e1'),
             linear1_list (el,fn el => linear1_list (fpel, fn fpel => APP(VAR var1,(el,fpel),ty))))
      end
  | linear1 (FN (xl,e1,a,b,c,d)) =
    FN (xl,linear1 e1,a,b,c,d)
  | linear1 (LETREC (fl,el,e)) =
    LETREC (fl,map linear1 el,linear1 e)
  | linear1 (STRUCT (el,ty)) =
    linear1_list (el,fn el => STRUCT (el,ty))
  | linear1 (SWITCH (e1,info,[(t,e2)],NONE)) = 
    let
      val var = new_LVar ()
    in
      LET ((var,null_debug,linear1 e1),linear1 e2)
    end
  | linear1 (SWITCH (e,info,tel,opte)) = 
    let
      val (lets,e') = switch_unwrap_lets (linear1 e)
    in
      wrap_lets (SWITCH (e',
                         info,
                         map (telfun linear1) tel,
                         optfun linear1 opte),
                 lets)
    end
  | linear1 (HANDLE (e1,e2,s)) = HANDLE(linear1 e1, linear1 e2, s)
(*
    let
      val var = new_LVar ()
      val e2' = linear1 e2
    in
      LET ((var,null_debug,e2'),
           HANDLE (linear1 e1,VAR var,s))
    end
*)
  | linear1 (exp as RAISE e) =
    if is_atomic e 
      then exp
    else
      let
        val e' = linear1 e
        val var = new_LVar()
      in
        LET ((var,null_debug,e'),RAISE (VAR var))
      end
  | linear1 (exp as SELECT (info,e)) =
    if is_atomic e
      then exp
    else
      let
        val e' = linear1 e
        val var = new_LVar()
      in
        LET ((var,null_debug,e'),SELECT (info,VAR var))
      end
  (* Nasty little hack for bounds checks *)
  | linear1 (LET ((v,i,
                   SWITCH (e1,info,
                           [(t1,se1 as RAISE _),
                            (t2,se2)],
                           NONE)),
                  e2)) =
    linear1 (SWITCH (e1,info,
                     [(t1,se1),
                      (t2,LET ((v,i,se2),e2))],
                     NONE))
  | linear1 (LET ((v,i,e1),e2)) =
    let
      val e1' = linear1 e1
      val e2' = linear1 e2
    in
      LET ((v,i,e1'),e2')
    end
and linear1_list (el,cons) =
  let
    fun aux (e::el,lets,acc) =
      if is_atomic e
        then aux (el,lets,e::acc)
      else
        let
          val var = new_LVar ()
          val e' = linear1 e
        in
          aux (el,(var,null_debug, e')::lets,VAR var :: acc)
        end
      | aux ([],lets,acc) =
        (lets, rev acc)
    val (lets,acc) = aux (el,[],[])
  in
    wrap_lets (cons acc, lets)
  end

(* Diddle with LETs *)
(* gets rid of the crap produced by linear1 *)
fun linear2 (LET ((xl1,info1,LET((xl2,info2,e1),e2)),e3)) =
    linear2 (LET ((xl2,info2,e1),(LET ((xl1,info1,e2),e3))))
  | linear2 (LET ((x,info,LETREC (fl,el,e1)),e2)) =
    linear2 (LETREC (fl,el,LET ((x,info,e1),e2)))
  | linear2 (LET ((x,info,e1),e2)) =
    let
      val e1' = linear2 e1
    in
      case e1' of
        LET _ => linear2 (LET ((x,info,e1'),e2))
      | _ =>
          let
            val e2' = linear2 e2
          in
            case e2' of
              VAR x' =>
                (* Don't remove bindings with debug info *)
                if x = x' andalso is_absent info
                  then e1' 
                else LET ((x,info,e1'),e2')
            | _ => LET ((x,info,e1'),e2')
          end
    end
  | linear2 (FN (vl,e,a,b,c,d)) = FN (vl,linear2 e,a,b,c,d)
  | linear2 (SWITCH (LET ((v,i,e1),e2),info,tel,opte)) =
    linear2 (LET ((v,i,e1),SWITCH (e2,info,tel,opte)))
  | linear2 (SWITCH (e,info,tel,opte)) =
    SWITCH (e,
            info,
            map (telfun linear2) tel,
            optfun linear2 opte)
  | linear2 (HANDLE (e1,e2,s)) = HANDLE (linear2 e1,linear2 e2,s)
  | linear2 (LETREC (fl,el,e)) =
    LETREC (fl,map linear2 el,linear2 e)
  | linear2 e = e

val linearize = linear2 o linear1

  fun get_arity Pervasives.EQ = 2
    | get_arity Pervasives.UMAP = 2
    | get_arity Pervasives.MOD = 2
    | get_arity Pervasives.PLUS = 2
    | get_arity Pervasives.STAR = 2
    | get_arity Pervasives.MINUS = 2
    | get_arity Pervasives.DIV = 2
    | get_arity Pervasives.NE = 2
    | get_arity Pervasives.LESS = 2
    | get_arity Pervasives.GREATER = 2
    | get_arity Pervasives.LESSEQ = 2
    | get_arity Pervasives.GREATEREQ = 2
    | get_arity Pervasives.FDIV = 2

    | get_arity Pervasives.INT32PLUS = 2
    | get_arity Pervasives.INT32MOD = 2
    | get_arity Pervasives.INT32DIV = 2
    | get_arity Pervasives.INT32STAR = 2
    | get_arity Pervasives.INT32MINUS = 2
    | get_arity Pervasives.INT32LESS = 2
    | get_arity Pervasives.INT32GREATER = 2
    | get_arity Pervasives.INT32LESSEQ = 2
    | get_arity Pervasives.INT32GREATEREQ = 2
    | get_arity Pervasives.INT32EQ = 2
    | get_arity Pervasives.INT32NE = 2

    | get_arity Pervasives.INTPLUS = 2
    | get_arity Pervasives.UNSAFEINTPLUS = 2
    | get_arity Pervasives.UNSAFEINTMINUS = 2
    | get_arity Pervasives.INTMOD = 2
    | get_arity Pervasives.INTDIV = 2
    | get_arity Pervasives.INTSTAR = 2
    | get_arity Pervasives.INTMINUS = 2
    | get_arity Pervasives.INTLESS = 2
    | get_arity Pervasives.INTGREATER = 2
    | get_arity Pervasives.INTLESSEQ = 2
    | get_arity Pervasives.INTGREATEREQ = 2
    | get_arity Pervasives.INTEQ = 2
    | get_arity Pervasives.INTNE = 2

    | get_arity Pervasives.REALPLUS = 2
    | get_arity Pervasives.REALSTAR = 2
    | get_arity Pervasives.REALMINUS = 2
    | get_arity Pervasives.REALLESS = 2
    | get_arity Pervasives.REALGREATER = 2
    | get_arity Pervasives.REALLESSEQ = 2
    | get_arity Pervasives.REALGREATEREQ = 2
    | get_arity Pervasives.REALEQ = 2
    | get_arity Pervasives.REALNE = 2

    | get_arity Pervasives.WORDEQ = 2
    | get_arity Pervasives.WORDNE = 2
    | get_arity Pervasives.WORDLT = 2
    | get_arity Pervasives.WORDLE = 2
    | get_arity Pervasives.WORDGT = 2
    | get_arity Pervasives.WORDGE = 2
    | get_arity Pervasives.WORDPLUS = 2
    | get_arity Pervasives.WORDMINUS = 2
    | get_arity Pervasives.WORDSTAR = 2
    | get_arity Pervasives.WORDDIV = 2
    | get_arity Pervasives.WORDMOD = 2
    | get_arity Pervasives.WORDORB = 2
    | get_arity Pervasives.WORDXORB = 2
    | get_arity Pervasives.WORDANDB = 2
    | get_arity Pervasives.WORDNOTB = 1
    | get_arity Pervasives.WORDLSHIFT = 2
    | get_arity Pervasives.WORDRSHIFT = 2
    | get_arity Pervasives.WORDARSHIFT = 2

    | get_arity Pervasives.WORD32EQ = 2
    | get_arity Pervasives.WORD32NE = 2
    | get_arity Pervasives.WORD32LT = 2
    | get_arity Pervasives.WORD32LE = 2
    | get_arity Pervasives.WORD32GT = 2
    | get_arity Pervasives.WORD32GE = 2
    | get_arity Pervasives.WORD32PLUS = 2
    | get_arity Pervasives.WORD32MINUS = 2
    | get_arity Pervasives.WORD32STAR = 2
    | get_arity Pervasives.WORD32DIV = 2
    | get_arity Pervasives.WORD32MOD = 2
    | get_arity Pervasives.WORD32ORB = 2
    | get_arity Pervasives.WORD32XORB = 2
    | get_arity Pervasives.WORD32ANDB = 2
    | get_arity Pervasives.WORD32NOTB = 1
    | get_arity Pervasives.WORD32LSHIFT = 2
    | get_arity Pervasives.WORD32RSHIFT = 2
    | get_arity Pervasives.WORD32ARSHIFT = 2

    (* Need some string operations here -- maybe *)

    (* Need some bytearray operations here -- maybe *)

    | get_arity Pervasives.BECOMES = 2
    | get_arity Pervasives.ORDOF = 2
    | get_arity Pervasives.HAT = 2
    | get_arity Pervasives.O = 2
    | get_arity Pervasives.SUB = 2
    | get_arity Pervasives.UNSAFE_SUB = 2
    | get_arity Pervasives.UPDATE = 3
    | get_arity Pervasives.UNSAFE_UPDATE = 3
    | get_arity Pervasives.ARRAY_FN = 2
    | get_arity Pervasives.BYTEARRAY = 2
    | get_arity Pervasives.BYTEARRAY_SUB = 2
    | get_arity Pervasives.BYTEARRAY_UPDATE = 3
    | get_arity Pervasives.BYTEARRAY_UNSAFE_SUB = 2
    | get_arity Pervasives.BYTEARRAY_UNSAFE_UPDATE = 3
    | get_arity Pervasives.FLOATARRAY = 2
    | get_arity Pervasives.FLOATARRAY_SUB = 2
    | get_arity Pervasives.FLOATARRAY_UPDATE = 3
    | get_arity Pervasives.FLOATARRAY_UNSAFE_SUB = 2
    | get_arity Pervasives.FLOATARRAY_UNSAFE_UPDATE = 3
    | get_arity Pervasives.VECTOR_SUB = 2

    | get_arity Pervasives.AT = 2
    | get_arity Pervasives.EQFUN = 2

    | get_arity Pervasives.ANDB = 2
    | get_arity Pervasives.LSHIFT = 2
    | get_arity Pervasives.ORB = 2
    | get_arity Pervasives.RSHIFT = 2
    | get_arity Pervasives.ARSHIFT = 2
    | get_arity Pervasives.XORB = 2

    | get_arity Pervasives.ALLOC_PAIR = 1
    | get_arity Pervasives.RECORD_UNSAFE_SUB = 2
    | get_arity Pervasives.RECORD_UNSAFE_UPDATE = 3
    | get_arity Pervasives.STRING_UNSAFE_SUB = 2
    | get_arity Pervasives.STRING_UNSAFE_UPDATE = 3

    | get_arity _ = 1
      
  local 
    open Pervasives
    (* UNSAFE - can't optimize at all *)
    (* ELIM - can be eliminated if unused (ref etc.) *)
    (* CSE - OK for CSE - may raise exn, but always behaves the same *)
    (* SAFE - can be eliminated, moved etc. freely *)

    datatype Safety = UNSAFE | ELIM | CSE | SAFE
    fun builtin_safety b =
      case b of
          REF => ELIM
        (* These perhaps should be errors *)
        | EXORD => UNSAFE
        | EXCHR => UNSAFE
        | EXDIV => UNSAFE
        | EXSQRT => UNSAFE
        | EXEXP => UNSAFE
        | EXLN => UNSAFE
        | EXIO => UNSAFE
        | EXMATCH => UNSAFE
        | EXBIND => UNSAFE
        | EXINTERRUPT => UNSAFE
        | EXOVERFLOW => UNSAFE
        | EXRANGE => UNSAFE
        | MAP => SAFE
        | UMAP => UNSAFE
        | REV => SAFE
        | NOT => SAFE
        | ABS => SAFE
        | FLOOR => CSE
        | REAL => SAFE
        | SQRT => CSE
        | SIN => CSE
        | COS => CSE
        | ARCTAN => CSE
        | EXP => CSE
        | LN => CSE
        | SIZE => SAFE
        | CHR => CSE
        | ORD => CSE
        | CHARCHR => CSE
        | CHARORD => SAFE
        | ORDOF => CSE
        | EXPLODE => SAFE
        | IMPLODE => SAFE
        | DEREF => ELIM
        | FDIV => CSE
        | DIV => CSE
        | MOD => CSE
        | PLUS => CSE
        | STAR => CSE
        | MINUS => CSE
        | HAT => SAFE
        | AT => SAFE
        | NE => SAFE
        | LESS => SAFE
        | GREATER => SAFE
        | LESSEQ => SAFE
        | GREATEREQ => SAFE
        | BECOMES => UNSAFE
        | O => SAFE
        | UMINUS => CSE
        | EQ => SAFE
        | EQFUN => SAFE
        | LOAD_STRING => SAFE
        | REALPLUS => CSE
        | INTPLUS => CSE
        | UNSAFEINTPLUS => SAFE
        | UNSAFEINTMINUS => SAFE
        | REALSTAR => CSE
        | INTSTAR => CSE
        | REALMINUS => CSE
        | INTMINUS => CSE
        | REALUMINUS => CSE
        | INTUMINUS => CSE
        | INTDIV => CSE
        | INTMOD => CSE
        | INTLESS => SAFE
        | REALLESS => SAFE
        | INTGREATER => SAFE
        | REALGREATER => SAFE
        | INTLESSEQ => SAFE
        | REALLESSEQ => SAFE
        | INTGREATEREQ => SAFE
        | REALGREATEREQ => SAFE
        | INTEQ => SAFE
        | INTNE => SAFE
        | REALEQ => SAFE
        | REALNE => SAFE
        | STRINGEQ => SAFE
        | STRINGNE => SAFE
        | STRINGLT => SAFE
        | STRINGLE => SAFE
        | STRINGGT => SAFE
        | STRINGGE => SAFE
        | CHAREQ => SAFE
        | CHARNE => SAFE
        | CHARLT => SAFE
        | CHARLE => SAFE
        | CHARGT => SAFE
        | CHARGE => SAFE
        | INTABS => CSE
        | REALABS => SAFE
        (* This can raise an exception, but value polymorphism buggers us if we can't lift it *)
        | CALL_C => SAFE
        | ARRAY_FN => ELIM
        | LENGTH => SAFE
        | SUB => UNSAFE
        | UPDATE => UNSAFE
        | UNSAFE_SUB => ELIM
        | UNSAFE_UPDATE => UNSAFE
        | BYTEARRAY => ELIM
        | BYTEARRAY_LENGTH => SAFE
        | BYTEARRAY_SUB => UNSAFE
        | BYTEARRAY_UPDATE => UNSAFE
        | BYTEARRAY_UNSAFE_SUB => ELIM
        | BYTEARRAY_UNSAFE_UPDATE => UNSAFE
        | FLOATARRAY => ELIM
        | FLOATARRAY_LENGTH => SAFE
        | FLOATARRAY_SUB => UNSAFE
        | FLOATARRAY_UPDATE => UNSAFE
        | FLOATARRAY_UNSAFE_SUB => ELIM
        | FLOATARRAY_UNSAFE_UPDATE => UNSAFE
        | VECTOR => SAFE
        | VECTOR_LENGTH => SAFE
        | VECTOR_SUB => CSE
        | EXSIZE => UNSAFE
        | EXSUBSCRIPT => UNSAFE
        | ANDB => SAFE
        | LSHIFT => SAFE
        | NOTB => SAFE
        | ORB => SAFE
        | RSHIFT => SAFE
        | ARSHIFT => SAFE
        | XORB => SAFE
        | CAST => SAFE
        | ALLOC_STRING => UNSAFE
        | ALLOC_VECTOR => UNSAFE
        | ALLOC_PAIR => UNSAFE
        | RECORD_UNSAFE_SUB => UNSAFE
        | RECORD_UNSAFE_UPDATE => UNSAFE
        | STRING_UNSAFE_SUB => UNSAFE
        | STRING_UNSAFE_UPDATE => UNSAFE
	| WORDANDB => SAFE
	| WORDARSHIFT => SAFE
	| WORDDIV => CSE
	| WORDEQ => SAFE
	| WORDGE => SAFE
	| WORDGT => SAFE
	| WORDLE => SAFE
	| WORDLSHIFT => SAFE
	| WORDLT => SAFE
	| WORDMINUS => SAFE
	| WORDMOD => CSE
	| WORDNE => SAFE
	| WORDNOTB => SAFE
	| WORDORB => SAFE
	| WORDPLUS => SAFE
	| WORDRSHIFT => SAFE
	| WORDSTAR => SAFE
	| WORDXORB => SAFE
        | INT32ABS => CSE
        | INT32PLUS => CSE
        | INT32STAR => CSE
        | INT32MINUS => CSE
        | INT32UMINUS => CSE
        | INT32DIV => CSE
        | INT32MOD => CSE
        | INT32LESS => SAFE
        | INT32GREATER => SAFE
        | INT32LESSEQ => SAFE
        | INT32GREATEREQ => SAFE
        | INT32EQ => SAFE
        | INT32NE => SAFE
	| WORD32ANDB => SAFE
	| WORD32ARSHIFT => SAFE
	| WORD32DIV => CSE
	| WORD32EQ => SAFE
	| WORD32GE => SAFE
	| WORD32GT => SAFE
	| WORD32LE => SAFE
	| WORD32LSHIFT => SAFE
	| WORD32LT => SAFE
	| WORD32MINUS => SAFE
	| WORD32MOD => CSE
	| WORD32NE => SAFE
	| WORD32NOTB => SAFE
	| WORD32ORB => SAFE
	| WORD32PLUS => SAFE
	| WORD32RSHIFT => SAFE
	| WORD32STAR => SAFE
	| WORD32XORB => SAFE
        (* Associated with the interpreter only *)
        (* Not sure about the next ones *)
        (* They are probably all safe *)
        | IDENT_FN => UNSAFE
        | ML_OFFSET => UNSAFE
        | ENTUPLE => UNSAFE
        | ML_CALL => UNSAFE
        | ML_REQUIRE => UNSAFE

        | LOAD_VAR => SAFE
        | LOAD_EXN => SAFE
        | LOAD_STRUCT => SAFE
        | LOAD_FUNCT => SAFE

        | GET_IMPLICIT => SAFE

  in
    fun safe_builtin b =
        case (builtin_safety b) of
          SAFE => true
        | _ => false
        
    fun safe_elim_builtin b = 
        case builtin_safety b of
          SAFE => true
        | ELIM => true
        | _ => false

    fun safe_cse_builtin b =
        case builtin_safety b of
          SAFE => true
        | CSE => true
        | _ => false
  end

  (* This may give erroneous results if the expression isn't linearized *)
  fun internal_safe builtinfun e =
    let
      fun aux (SCON _) = true
        | aux (INT _) = true
        | aux (VAR _) = true
        | aux (MLVALUE _) = true
        | aux (BUILTIN _) = true
        | aux (APP (BUILTIN b,_,_)) = builtinfun b
        | aux (APP _) = false
        | aux (FN _) = true
        | aux (STRUCT _) = true
        | aux (SWITCH (e,info,tel,SOME elsee)) =
          aux e andalso 
          List.all (fn (t,e) => aux_tag t andalso aux e) tel andalso 
          aux elsee
        | aux (SWITCH (e,info,tel,NONE)) =
          aux e andalso List.all (fn (t,e) => aux e) tel
        | aux (HANDLE _) = false
        | aux (RAISE e) = false
        | aux (SELECT _) = true
        | aux (LET ((_,_,e1),e2)) = aux e1 andalso aux e2
        | aux (LETREC (_,_,e)) = aux e
      and aux_tag (EXP_TAG e) = aux e
        | aux_tag t = true
    in
      aux e
    end

  val safe_elim = internal_safe safe_elim_builtin
  val safe_cse = internal_safe safe_cse_builtin
  val safe = internal_safe safe_builtin      

  (* This inserts the definitions in vel into exp, as if we had done a subst and then a CSE *)

  fun insert_as_needed ([],exp) = exp
    | insert_as_needed (vel,exp) = 
      let
        fun get_needed (vel,exp) =
          let
            val needed_vars = freevars (exp,map #1 vel)
            val needed = List.filter (fn (x,i,y) => intmember (x,needed_vars)) vel
            val not_needed = Lists.filter_outp (fn (x,i,y) => intmember (x,needed_vars)) vel
          in
            (needed,not_needed)
          end

        fun is_function (FN _) = true
          | is_function _ = false

        fun do_complex (LET ((v,i,e1 as SWITCH (test,info,tel,opts)),e2)) =
            let
              val (needed,not_needed) = get_needed (vel,test)
            in
              wrap_lets (LET ((v,i,insert_as_needed (not_needed,e1)),
                              insert_as_needed (not_needed,e2)),
                         needed)
            end
          | do_complex (LET ((v,i,e1),e2)) =
            if is_simple e1 orelse is_function e1
              then
                let
                  val (needed,not_needed) = get_needed (vel,e1)
                in
                  wrap_lets (LET ((v,i,e1),insert_as_needed (not_needed,e2)),needed)
                end
            else
              LET ((v,i,do_complex e1),do_complex e2)
          | do_complex (SWITCH (e,info,tel,opte)) =
            SWITCH (do_complex e, 
                    info,
                    map (telfun do_complex) tel,
                    optfun do_complex opte)

          | do_complex (HANDLE (e1,e2,s)) = HANDLE(do_complex e1,do_complex e2,s)

          | do_complex (LETREC (fl,el,e)) =
            let
              val bodies = STRUCT (el,TUPLE)
              val (needed,not_needed) = get_needed (vel,bodies)
            in
              wrap_lets (LETREC (fl,el,insert_as_needed (not_needed,e)),needed)
            end
          | do_complex e =
            let
              val (needed,_) = get_needed (vel,e)
            in
              wrap_lets (e,needed)
            end
      in
        do_complex exp
      end

  (* vel is in reverse order *)
  fun get_needed (vel,exp) =
    let
     (* this function reverses the param *)
      fun filterp (f,[],acc1,acc2) = (acc1,acc2)
        | filterp (f,(a::b),acc1,acc2) = 
          if f a 
            then filterp (f,b,a::acc1,acc2) 
          else filterp (f,b,acc1,a::acc2)
      val needed_vars = freevars (exp,map #1 vel)
    in
      filterp (fn (x,i,y) => intmember (x,needed_vars),vel,[],[])
    end

  fun schedule2 (needed,not_needed,exp) =
    let
      fun aux ([],needed,not_needed) =
        wrap_lets (schedule_aux (rev not_needed,exp), needed)
        | aux ((v,i,e)::rest,needed,not_needed) =
          let
            val (n,nn) = get_needed (rev not_needed,e)
          in
            case n of
              [] => aux (rest,(v,i,e)::needed,not_needed)
            | _ => aux (n @ ((v,i,e)::rest),needed,nn)
          end
    in
      aux (needed,[],not_needed)
    end

  and schedule_aux (vel,exp) = 
      let
        fun is_function (FN _) = true
          | is_function _ = false

        fun do_schedule (SELECT _) = true
          | do_schedule _ = false

        fun do_complex (e as LET ((v,i,e1 as SWITCH (test,info,tel,opts)),e2)) =
            let
              val (needed,not_needed) = get_needed (vel,test)
            in
              case needed of
                [] => LET ((v,i,do_complex e1),do_complex e2)
              | _ => 
                  schedule2 (needed,not_needed,e)
            end
          | do_complex (e as LET ((v,i,e1),e2)) =
            if do_schedule e1
              then schedule_aux ((v,i,e1)::vel,e2)
            else
              if is_simple e1 orelse is_function e1
                then
                  let
                    val (needed,not_needed) = get_needed (vel,e1)
                  in
                    case needed of
                      [] => LET ((v,i,do_complex e1),do_complex e2)
                    | _ => schedule2 (needed,not_needed,e)
                  end
              else
                LET ((v,i,do_complex e1),do_complex e2)
          | do_complex (e as SWITCH (test,info,tel,opte)) =
            let
              val (needed,not_needed) = get_needed (vel,test)
            in
              case needed of
                [] =>
                  SWITCH (test, 
                          info,
                          map (telfun do_complex) tel,
                          optfun do_complex opte)
              | _ => schedule2 (needed,not_needed,e)
            end

          | do_complex (HANDLE (e1,e2,s)) = HANDLE(do_complex e1,do_complex e2,s)
          | do_complex e =
            let
              val (needed,not_needed) = get_needed (vel,e)
            in
              case needed of
                [] => e
              | _ => schedule2 (needed,not_needed,e)
            end
      in
        do_complex exp
      end

  fun schedule exp = schedule_aux ([],exp)

  (* A simple size measure *)

  fun size_less (exp,n,allow_fns) =
    let
      fun aux (e,n) =
        if n <= 0 then n
        else
          case e of
            INT _ => n-1
          | SCON _ => n-1
          | MLVALUE _ => n-1
          | BUILTIN _ => n-1
          | VAR _ => n-1
          (* Should be a function of the builtin *)
          | APP (BUILTIN _,_,_) => n-1
          | APP (e,(el,fpel),_) => n - (3 + Lists.length el + Lists.length fpel)
          (* Don't want to inline these right now *)
          (* Unless its inline_single_callees in which case, what the hell *)
          | FN {2 = body,...} => 
              if allow_fns then aux (body,n) else 0
          | LETREC _ => 0
          (* 3 for the overhead of allocation *)
          | STRUCT (el,_) => n - 3 - length el
          (* 2 overhead for each switch *)
          | SWITCH (e,_,tel,opte) =>
                let
                  fun red ([],SOME e,n) = aux (e,n-2)
                    | red ([],NONE,n) = n
                    | red ((t,e)::l,opte,n) = red (l,opte,aux (e,n-2))
                in
                  red (tel,opte,n-1)
                end
          (* 10 for the overhead of handling *)
          | HANDLE (e1,e2,_) =>
                aux (e2,aux (e1,n-10))
          | RAISE e => (aux (e,n-3))
          | SELECT _ => n-1
          | LET ((v,_,e1),e2) => aux (e2,aux (e1,n))
      val r = aux (exp,n) > 0
    in
      r
    end

    (* This is incomplete -- used for simple expressions *)
    fun exp_eq (VAR v,VAR v') = v = v'
      | exp_eq (APP (e1,(el,fpel),_),APP (e1',(el',fpel'),_)) = 
      exp_eq (e1,e1') andalso explist_eq (el,el') andalso explist_eq (fpel, fpel')
      | exp_eq (SCON (s, _), SCON (s', _)) = Scons.scon_eqval(s,s')
      | exp_eq (INT n, INT n') = n = n'
      | exp_eq (STRUCT (el,ty),STRUCT (el',ty')) = ty = ty' andalso explist_eq (el,el')
      | exp_eq (SELECT ({index=i,size=j,selecttype=ty},e), SELECT ({index=i',size=j',selecttype=ty'},e')) = 
        ty = ty' andalso i = i' andalso j = j' andalso exp_eq (e,e')
      | exp_eq (BUILTIN b,BUILTIN b') = b = b'
      | exp_eq _ = false
    and explist_eq ([],[]) = true
      | explist_eq (e::el,e'::el') = exp_eq (e,e') andalso explist_eq (el,el')
      | explist_eq _ = false


  fun get_fn_lvars(acc, le as LambdaTypes.LET _) =
    let
      val (bindings, le) = unwrap_lets le
      val acc =
	Lists.reducel
	(fn (acc, (lv, _, le)) => 
         (case le of
            LambdaTypes.FN _ => lv :: acc
          | _ => acc))
	(get_fn_lvars (acc, le), bindings)
    in
      Lists.reducel get_fn_lvars (acc, map #3 bindings)
    end
    | get_fn_lvars(acc, LambdaTypes.VAR _) = acc
    | get_fn_lvars(acc, LambdaTypes.FN (_, le,_,_,_,_)) = get_fn_lvars(acc, le)
    | get_fn_lvars(acc, LambdaTypes.LETREC(lv_list, le_list, le)) =
    let
      val lv_list = map #1 lv_list
      val acc = Lists.reducel
	(fn (acc, le) => get_fn_lvars(acc, le))
	(get_fn_lvars(acc, le), le_list)
      val bindings = Lists.zip(lv_list, le_list)
    in
      Lists.reducel
      (fn (acc, (lv, le)) => lv :: acc)
      (acc, bindings)
    end
    | get_fn_lvars(acc, LambdaTypes.APP(le, (lel,fpel),_)) =
    Lists.reducel
    (fn (acc, le) => get_fn_lvars(acc, le))
    (get_fn_lvars(acc, le), lel @ fpel)
    | get_fn_lvars(acc, LambdaTypes.SCON _) = acc
    | get_fn_lvars(acc, LambdaTypes.MLVALUE _) = acc
    | get_fn_lvars(acc, LambdaTypes.INT _) = acc
    | get_fn_lvars(acc, LambdaTypes.SWITCH(le, info, tag_le_list, def)) =
    let
      val acc = get_fn_lvars(case def of SOME e => get_fn_lvars (acc, e) | _ => acc, le)
    in
      Lists.reducel
      (fn (acc, (tag, le)) =>
       get_fn_lvars(acc, le))
      (acc, tag_le_list)
    end
    | get_fn_lvars(acc, LambdaTypes.STRUCT (le_list,_)) =
    Lists.reducel
    (fn (acc, le) => get_fn_lvars(acc, le))
    (acc, le_list)
    | get_fn_lvars(acc, LambdaTypes.SELECT(_, le)) =
    get_fn_lvars(acc, le)
    | get_fn_lvars(acc, LambdaTypes.RAISE (le)) =
    get_fn_lvars(acc, le)
    | get_fn_lvars(acc, LambdaTypes.HANDLE(le, le',_)) =
    get_fn_lvars(get_fn_lvars(acc, le), le')
    | get_fn_lvars(acc, LambdaTypes.BUILTIN _) = acc


  fun function_lvars exp = get_fn_lvars ([],exp)

    fun subst (f,e) =
      let
        fun aux (e as INT _) = e
          | aux (e as SCON _) = e
          | aux (e as MLVALUE _) = e
          | aux (e as BUILTIN _) = e
          | aux (e as VAR v) = f v
          | aux (APP (e,(el,fpel),ty)) = APP (aux e,(map aux el,map aux fpel), ty)
          | aux (FN (args,e,status,name,ty,info)) = FN (args,aux e,status,name,ty,info)
          | aux (LETREC (fl,el,e)) =
          LETREC (fl,map aux el,aux e)
          | aux (STRUCT (el,ty)) = STRUCT (map aux el,ty)
          | aux (SWITCH (e,info,tel,opte)) =
          SWITCH (aux e, 
                  info,
                  map (telfun aux) tel,
                  optfun aux opte)
          | aux (HANDLE (e1,e2,s)) = HANDLE(aux e1,aux e2,s)
          | aux (RAISE e) = RAISE (aux e)
          | aux (SELECT (info,e)) = SELECT (info,aux e)
          | aux (LET ((v,i,e1),e2)) =
          LET((v,i,aux e1),aux e2)
      in
        aux e
      end

  (* This should only include the inlined fp pervasives that don't mind unboxed args *)
  val fp_pervasives = 
    [Pervasives.FLOOR,
     Pervasives.FDIV,
     Pervasives.REALPLUS,
     Pervasives.REALSTAR,
     Pervasives.REALMINUS,
     Pervasives.REALLESS,
     Pervasives.REALGREATER,
     Pervasives.REALLESSEQ,
     Pervasives.REALGREATEREQ,
     Pervasives.REALEQ,
     Pervasives.REALNE]
  fun is_fp_builtin b = Lists.member (b,fp_pervasives)
end
