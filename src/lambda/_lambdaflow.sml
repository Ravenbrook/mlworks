(*
 * $Log: _lambdaflow.sml,v $
 * Revision 1.8  1998/02/19 16:56:05  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.7  1998/01/19  14:48:02  jkbrook
 *  [Bug #30309]
 *  Turn off basic-block creation to improve compilation speed
 *
 *  Revision 1.6  1997/06/12  10:22:11  matthew
 *  Improving FP argument analysis.
 *
 *  Revision 1.5  1997/05/28  10:57:41  matthew
 *  Speeding up local functions stuff -- use a table of seen nodes, not a list.
 *
 *  Revision 1.4  1997/05/22  14:24:59  matthew
 *  [Bug #20058]
 *  Remove redundant functions
 *
 *  Revision 1.3  1997/05/21  11:21:25  matthew
 *  Improving interaction between local functions and FP args
 *
 *  Revision 1.2  1997/02/12  12:58:13  matthew
 *  andalso removal done in wrong order
 *
 *  Revision 1.1  1997/01/06  10:32:26  matthew
 *  new unit
 *  New optimization stages
 *
 * Copyright (C) 1996 The Harlequin Group Limited.
*)

require "../basis/__int";
require "../basis/__list";

require "../utils/inthashtable";
require "../utils/crash";
require "../debugger/runtime_env";
require "../main/machspec";
require "simpleutils";
require "lambdaprint";
require "lambdaflow";

functor LambdaFlow (structure SimpleUtils : SIMPLEUTILS 
                      where type LambdaTypes.LVar = int
                    structure LambdaPrint : LAMBDAPRINT
                      where type LambdaTypes.LVar = int
                    structure IntHashTable : INTHASHTABLE
                    structure Crash : CRASH
                    structure RuntimeEnv : RUNTIMEENV
                    structure MachSpec : MACHSPEC

                    sharing LambdaPrint.LambdaTypes = SimpleUtils.LambdaTypes
                    sharing type SimpleUtils.LambdaTypes.FunInfo = 
                      RuntimeEnv.FunInfo
                      ) : LAMBDAFLOW =
  struct
    structure LambdaTypes = SimpleUtils.LambdaTypes
    structure Table = IntHashTable
    open LambdaTypes

    val max_local_size = 100
    val doprint = false
    val blockify = false
    val do_cps = true

    (* Round up the usual utilities *)
    fun P s = print s
    fun I s = Int.toString s
    fun B true = "true"
      | B false = "false"
    fun iterate f [] = ()
      | iterate f (a::b) = (ignore(f a); iterate f b)
    fun optfun f NONE = NONE
      | optfun f (SOME e) = SOME (f e)    
    fun telmap f = map (telfun f)
    fun zip' ([],[],acc) = rev acc
      | zip' (a::b,c::d,acc) = zip'(b,d,(a,c)::acc)
      | zip' _ = Crash.impossible "zip"
    fun zip (l1,l2) = zip' (l1,l2,[])
    fun member (x,[]) = false
      | member (x,a::b) = x = a orelse member (x,b)
    fun assoc (x,[]) = NONE
      | assoc (x,(x',a)::b) = if x = x' then SOME a else assoc (x,b)
    (* If this gets used for long lists, it should be reimplemented *)
    fun subtract ([],l2) = []
      | subtract (a::b,l2) = 
      if member (a,l2) 
        then subtract (b,l2) 
      else a :: subtract (b,l2)
    fun conc' ([],acc) = rev acc
      | conc' ([]::rest,acc) = conc' (rest,acc)
      | conc' ((a::b)::rest,acc) = conc' (b::rest,a::acc)
    fun conc l = conc' (l,[])
    fun pushnew (v,l) = if member (v,!l) then () else l := v :: !l
    fun pushnewp (x,l) =
      if member (x,!l) then false
      else (l := x :: !l; true)
    fun length l =
      let fun aux ([],n) = n
            | aux (a::b,n) = aux (b,n+1)
      in
        aux (l,0)
      end
    fun forall f [] = true
      | forall f (a::rest) = f a andalso forall f rest

    fun sort f [] = []
      | sort f (a::rest) : int list =
      let
        fun part (a,[],l1,l2) = (l1,l2)
          | part (a,b::rest,l1,l2) =
          if f (b,a) then part (a,rest,b::l1,l2)
          else part (a,rest,l1,b::l2)
        val (l1,l2) = part (a,rest,[],[])
      in
        sort f l1 @ [a] @ sort f l2
      end

    fun crash s = Crash.impossible ("LambdaFlow: " ^ s)
    val newvar = LambdaTypes.new_LVar
    datatype Cont = UNKNOWN | CONT of LVar

    (* Printing utilities *)
    fun print_fns [] = ""
      | print_fns [v] = I v
      | print_fns (v::rest) = (I v ^ " " ^ print_fns rest)
    fun C UNKNOWN = "external"
      | C (CONT v) = I v
    fun print_conts [] = ""
      | print_conts [v] = C v
      | print_conts (v::rest) = ( C v ^ " " ^ print_conts rest)
    fun print_table (table) =
      Table.iterate
      (fn (v,{external,tails}) =>
       P (I v ^ " external: " ^ B (!external) ^ " tails: " ^ print_fns (!tails) ^ "\n"))
      table

    fun new_table () = Table.new 16

    fun print_call_table table =
      Table.iterate
      (fn (v,callees) => 
       if !callees = []
         then ()
       else P (I v ^ ": " ^ print_fns (!callees) ^ "\n"))
      table

    fun print_info table =
      Table.iterate
      (fn (v,{conts,tail_calls,calls,external}) =>
       P (I v ^ (if !external then " (external)" else "") ^ ": tail calls: " ^ 
          print_fns (!tail_calls) ^ ", calls: " ^ print_fns (!calls) ^ 
          ", conts: " ^ print_conts (!conts) ^ "\n"))
      table

    fun do_switch ((exp1,info1,tel1,def1),info2,tel2,def2) =
      (* Aha, a nested switch, perhaps an andalso or whatever *)
      (* Let us eliminate it *)
      let
        fun mkbodyfun e = 
          FN (([new_LVar()],[]),e,
              BODY,
              "switch body<Match>",
              LambdaTypes.null_type_annotation,
              LambdaTypes.user_funinfo)
        fun mkapp fvar = APP (VAR fvar,
                              ([INT 0],[]),
                              NONE)
        val bodydata =
          map (fn (t,e) =>
               let
                 val fvar = new_LVar()
               in
                 ((fvar,mkbodyfun e),(t,mkapp fvar))
               end)
          tel2
        val bodyfuns = map #1 bodydata
        val newtel = map #2 bodydata
        val (newdef,defun) =
          case def2 of
            SOME e => 
              let
                val fvar = new_LVar ()
              in
                (SOME (mkapp fvar),[(fvar,mkbodyfun e)])
              end
          | _ => (NONE,[])
        val newswitch =
          SWITCH (exp1,info1,
                  (* Note that the switched on expression here may not be *)
                  (* a var or a comparison, so we need to restructure if necessary *)
                  map
                  (fn (t,e) =>
                   (t,SimpleUtils.linearize (SWITCH (e,info2,newtel,newdef))))
                  tel1,
                  case def1 of
                    SOME e => SOME (SimpleUtils.linearize (SWITCH (e,info2,newtel,newdef)))
                  | _ => NONE)
        fun wrap (e,(fvar,f)::rest) =
          wrap (LET ((fvar,NONE,f),e),rest)
          | wrap (e,[]) = e
        val newexp =
          wrap (newswitch,defun @ rev bodyfuns)
      in
        newexp
      end (* of do_switch *)

    val max_switch_level = 8

    (* Usually assumption of linearizedness *)
    fun preanalyse e =
      let
        fun p level e =
          if level > max_switch_level then e
          else
            case e of
            FN (args,e,status,name,ty,info) => FN (args,p level e,status,name,ty,info)
          | LETREC (vl,el,e) => LETREC (vl,map (p level) el,p level e)
          | SWITCH (e,info,tel,def) =>
              SWITCH (e,info,telmap (p level) tel, optfun (p level) def)
          (* Things don't work inside handlers just yet *)
          | HANDLE (e1,e2,s) => HANDLE (e1, e2, s)
          | LET ((var,info,e1 as SWITCH data1),e2 as SWITCH (VAR var',info2,tel2,def2)) =>
              if var = var' andalso 
                not (SimpleUtils.occurs (var,SWITCH (INT 0,info2,tel2,def2)))
                then p (level + 1) (do_switch (data1,info2,tel2,def2))
              else LET ((var,info,p level e1),p level e2)
          | LET ((var,info,e1 as SWITCH data1),
                 e2 as LET ((var3,info3,SWITCH (VAR var',info2,tel2,def2)),body)) =>
            if var = var' andalso 
              not (SimpleUtils.occurs (var,SWITCH (INT 0,info2,tel2,def2)))
              andalso not (SimpleUtils.occurs (var',body))
              then 
                p (level+1) (LET ((var3,info3,do_switch (data1,info2,tel2,def2)),body))
            else LET ((var,info,p level e1),p level e2)
          | LET ((var1,info1,LET ((var2,info2,e2),e1)),body) =>
              p level (LET ((var2,info2,e2),LET ((var1,info1,e1),body)))
          | LET ((var,info,e1),e2) =>
              LET ((var,info,p level e1),p level e2)
          | _ => e
      in
        p 0 e
      end (* of preanalyse *)

    fun too_big e = not (SimpleUtils.size_less (e,max_local_size,true))

    fun is_switch (SWITCH _) = true
      | is_switch _ = false

    (* This takes a list of declarations and converts all switches to tail *)
    (* recursive form *)
    fun tail_convert (PROGRAM (decs,e)) = 
      let
        (* Call the appropriate continuation function *)
        fun apply_cont (NONE,e) = e
          (* If its a RAISE, then the continuation never happens *)
          | apply_cont (SOME (fvar,args),e as RAISE _) = e
          | apply_cont (SOME (fvar,args),e) =
            if SimpleUtils.is_atomic e
              then APP (VAR fvar, (e :: map VAR args,[]),NONE)
            else
              let
                val var = newvar()
              in
                LET ((var,NONE,e),
                     APP (VAR fvar,(map VAR (var :: args),[]),NONE))
              end

        (* Record the set of continuation functions and their arguments *)
        val contvars_table = ref []
        fun lookup_contvars c =
          let
            fun find [] = crash "lookup_contvars"
              | find ((c',args)::rest) = 
                if c = c' then args else find rest
          in
            find (!contvars_table)
          end
        fun add_contvars (c,args) =
          contvars_table := (c,args) :: !contvars_table

        (* scan an expression and lift out continuation functions *)
        (* accumulate new definitions in acc *)
        fun convert (e,freevars,cont,acc) =
          ((* P ("converting " ^ LambdaPrint.print_exp e ^ "\n"); *)
           case e of
             FN ((args,fpargs), body, status, name, ty,info) =>
               let
                 val (body,acc) = convert (body,fpargs @ args @ freevars,NONE,acc)
               in
                 (apply_cont (cont, (FN ((args,fpargs),body,status,name,ty,info))),acc)
               end
           | LET ((var,info,e),body) =>
               (* Don't need a continuation if e isn't a switch expression *)
               if not do_cps orelse not (is_switch e) orelse too_big body orelse too_big e
                 then
                   let
                     val (body,acc) = convert (body,var::freevars,cont,acc)
                   in
                     (LET ((var,info,e),body),acc)
                   end
               else
                 let
                   (* make a continuation *)
                   val contvar = newvar();
                   val (body,acc) = convert (body,var::freevars,cont,acc)
                   val args = SimpleUtils.freevars (body,freevars)
                   (* The relevant continuation function *)
                   val newcont = SOME (contvar,args)
                   val (e,acc) = convert (e,freevars,newcont,acc)
                   val newfun = FN ((var::args,[]),body,BODY,"letbody fun",
                                    LambdaTypes.null_type_annotation,
                                    LambdaTypes.internal_funinfo)
                   val newdec = (contvar,NONE,VAL newfun)
                 in
                   (* Record the continuation variables *)
                   add_contvars (contvar,args);
                   (e,newdec::acc)
                 end
           | SWITCH (e,info,tel,default) =>
               let
                 (* When doing loop analysis, it is desirable for switch bodies to be atomic *)
                 (* or function calls. This code ensures that (when blockify is true) *)
                 fun is_app (APP _) = true
                   | is_app _ = false
                 fun s_convert (e,freevars,cont,acc)  =
                   let
                     val (e,acc) = convert (e,freevars,cont,acc)
                     fun has_cont (SOME _) = true
                       | has_cont NONE = false
                   in
                     if has_cont cont orelse not blockify orelse 
                        SimpleUtils.is_atomic e orelse is_app e
                       then (e,acc)
                     else
                       (* Here we make a separate function for the switch body *)
                       (* This is to aid in loop analysis *)
                       let
                         val fvar =  newvar()
                         val args = SimpleUtils.freevars (e,freevars)
                         val newfun = FN ((args,[]),e,BODY,"switch arm fn",
                                          LambdaTypes.null_type_annotation,
                                          LambdaTypes.internal_funinfo)
                         val newdec = (fvar,NONE,VAL newfun)
                       in
                         (APP (VAR fvar, (map VAR args,[]),NONE),newdec :: acc)
                       end
                   end
                 fun scan ([],tel,acc) = (rev tel,acc)
                   | scan ((t,e)::rest,tel,acc) =
                     let
                       val (e,acc) = s_convert (e,freevars,cont,acc)
                     in
                       scan (rest,(t,e)::tel,acc)
                     end
                 val (tel,acc) = scan (tel,[],acc)
                 val (default,acc) =
                   case default of
                     NONE => (NONE,acc)
                   | SOME e =>
                       let
                         val (e,acc) = s_convert (e,freevars,cont,acc)
                       in
                         (SOME e,acc)
                       end
               in
                 (SWITCH (e,info,tel,default),acc)
               end
           | HANDLE (e1,e2,s) =>
               (* It seems pointless doing much with handlers as we can't optimize calls to the *)
               (* relevant local functions *)
               let
(*
                 val (e1,acc) = convert (e1,freevars,NONE,acc)
                 val (e2,acc) = convert (e2,freevars,NONE,acc)
*)
               in
                 (apply_cont (cont, (HANDLE (e1,e2,s))),acc)
               end
           (* Crash for LETREC case *)
           | LETREC _ => crash "letrec found in tail_convert"
           (* If it ain't a letrec then it must be a simple expression *)
           | _ => (apply_cont (cont, e),acc))

        fun do_dec (VAL (exp as FN _),acc) =
          let
            val (exp,acc) = convert (exp,[],NONE, acc)
          in
            (VAL exp, acc)
          end
          (* No point in converting top level expressions *)
          (* As there is nothing they can be a local function of *)
          | do_dec (VAL exp,acc) =
            (VAL exp,acc)
          | do_dec (FUNCTOR (var,name,(decs,e)),acc) =
            let
              val decs = scan_decs (decs,[])
            in
              (FUNCTOR (var,name,(decs,e)),acc)
            end

        and scan_decs ([], acc) = rev acc
          | scan_decs ((var,info,dec)::rest,acc) =
            let
              val (dec,acc) = do_dec (dec,acc)
            in
              scan_decs (rest,(var,info,dec) :: acc)
            end

        (* Rewrite the list of declarations *)
        val decs = scan_decs (decs,[])

        (* Now the decs have explicit continuation functions *)
        (*  Now we need to record:
         1. explicit continuations of functions. 
         2. tail calls between functions
         3. non-tail calls between functions
         4. whether the function is called externally
         *)

        val fn_table = 
          let
            (* This accumulates call & continuation info about functions *)
            fun  make_fn_table (decs,init) = 
              let
                val table = new_table ()
                fun scan ((var,info,FUNCTOR (v,names,(decs,e)))::rest) =
                  (scan decs;
                   scan rest)
                  | scan ((var,info,VAL (FN {4=name,...})) :: rest) =
                  (Table.update (table,var,init());
                   scan rest)
                  | scan (_ :: rest) = scan rest
                  | scan [] = ()
              in
                scan decs; (* Find the lvars for the default functions *)
                table
              end
          in
            make_fn_table (decs, fn _ => {conts = ref [],
                                          tail_calls = ref [],
                                          calls = ref [],
                                          external = ref false}) (* continuations,tail calls,calls *)
          end

        fun conts_of f = (#conts (Table.lookup (fn_table, f)))
        fun tail_calls_of f = (#tail_calls (Table.lookup (fn_table, f)))
        fun calls_of f = (#calls (Table.lookup (fn_table, f)))

        fun addcont (c,f) =
          (pushnew (c,conts_of f)) handle Table.Lookup => ()
        fun addtailcall (c,f) =
          (pushnew (c,tail_calls_of f)) handle Table.Lookup => ()
        fun addcall (c,f) =
          (pushnew (c,calls_of f)) handle Table.Lookup => ()
        fun set_external f =
          (#external (Table.lookup (fn_table, f)) := true)
          handle Table.Lookup => ()
        datatype Context = TOPCONTEXT | FUNCONTEXT of LVar | ANON
        fun do_call (f,context,tail) =
          case Table.tryLookup (fn_table, f) of
            NONE => ()
          | _ =>
              if not tail
                then 
                  (addcont (UNKNOWN,f);
                   case context of 
                     FUNCONTEXT current => addcall (f,current)
                   | _ => ())
              else
                case context of
                  TOPCONTEXT => crash "found tail call in top level"
                | FUNCONTEXT current => addtailcall (f,current)
                | ANON => addcont (UNKNOWN, f)

        val contfuns = map #1 (!contvars_table)
        fun scan_exp (exp,context,tail) =
          case exp of
            VAR var => (addcont (UNKNOWN,var); set_external var)
          | FN (args,exp,status,name,ty,info) => 
              scan_exp (exp,ANON,true)
          | LET ((var, info, exp1 as APP (VAR f,_,_)),
                 exp2 as APP (VAR c,_,_)) =>
            (* We've found a call to a continuation *)
           if tail andalso member (c,contfuns)
              then 
                (addcont (CONT c, f);
                 do_call (c,context,tail))
            else
              (scan_exp (exp1,context,false);
               scan_exp (exp2,context,tail))
          | LET ((var, info,exp1),exp2) =>
              (scan_exp (exp1,context,false);
               scan_exp (exp2,context,tail))
          | LETREC (vl,el,e) =>
              crash "letrec found in do_call"
          | APP (exp,(el,fpel),info) =>
              (case exp of
                 VAR v => do_call (v,context,tail)
               | _ => scan_exp (exp,context,false);
               iterate (fn e => scan_exp (e, context,false)) (el @ fpel))
          | SCON _ => ()
          | INT _ => ()
          | SWITCH (e,info,tel,default) =>
            (scan_exp (e,context,false);
             iterate (fn (t,e) => scan_exp (e,context,tail)) tel;
             case default of
               SOME e => scan_exp (e,context,tail)
             | _ => ())
          | STRUCT (el,_) =>
              iterate (fn e => scan_exp (e,context,false)) el
          | SELECT (_,e) =>
              scan_exp (e,context,false)
          | RAISE e =>
              scan_exp (e,context,false)
          | HANDLE (e1,e2,s) =>
              (scan_exp (e1,context,false);
               scan_exp (e2,context,false))
          | BUILTIN p => ()
          | MLVALUE _ => ()

        fun scan_one (var, FUNCTOR (_,s,(decs,e))) =
          (scan_decs decs;
           scan_exp (e,TOPCONTEXT,false))
          | scan_one (var,VAL (FN (vl,body,status,name,ty,info))) =
            scan_exp (body,FUNCONTEXT var,true)
          | scan_one (var,VAL e) =
            scan_exp (e,TOPCONTEXT,false)
        and scan_decs [] = ()
          | scan_decs ((var,info,dec) :: rest) =
            (scan_one (var,dec);
             scan_decs rest)

        fun get_continuation f =
          (case conts_of f of
             ref [CONT c] => SOME c
           | _ => NONE)
             handle Table.Lookup => NONE

        (* Need to take into account continuations of continuations *)
        (* This is for nested cases.  In this case, we just append all the arguments together *)
        fun find_all_contvars c =
          let
            val cargs = lookup_contvars c
            val extra = 
              case get_continuation c of
                SOME c' => find_all_contvars c'
              | _ => []
          in
            cargs @ extra
          end

        fun convert_decs decs =
          let
            fun convert_exp (exp,cont) =
              case exp of
                FN (args,exp,status,name,ty,info) => 
                  apply_cont (cont,FN (args,convert_exp (exp,NONE),status,name,ty,info))
              | LET ((var, info1, exp1 as APP (VAR f,(args,fpargs),info2)),
                     exp2 as APP (VAR c,_,_)) =>
                (* We've found a call to a continuation *)
                (case get_continuation f of
                   SOME c'' =>
                     if c = c'' then 
                       let
                         val cargs = find_all_contvars c
                         val check = case fpargs of
                           [] => ()
                         | _ => crash "convert_decs: fpargs found"
                       in
                         APP (VAR f, (args @ map VAR cargs,[]),info2)
                       end
                     else crash "Wrong continuation found"
                 | _ => LET ((var,info1,convert_exp (exp1,NONE)),convert_exp (exp2,cont)))

              | LET ((var, info,exp1),exp2) =>
                  LET ((var,info,convert_exp (exp1,NONE)),
                       convert_exp (exp2,cont))
              | LETREC (vl,el,e) =>
                  crash "letrec found in convert_exp"
              | APP (VAR f,(args,fp_args),info) =>
                  (case get_continuation f of
                     SOME c =>
                       let
                         val cargs = find_all_contvars c
                         val check = case fp_args of
                           [] => ()
                         | _ => crash "convert_decs: fpargs in APP"
                       in
                         APP (VAR f, (args @ map VAR cargs,[]),info)
                       end
                   | NONE => apply_cont (cont,exp))
              | SWITCH (e,info,tel,default) =>
                  SWITCH (convert_exp (e,NONE),info,
                          map (telfun (fn e => convert_exp (e,cont))) tel,
                               optfun (fn e => convert_exp (e,cont)) default)
              | HANDLE (e1,e2,s) =>
                  apply_cont (cont,HANDLE (convert_exp (e1,NONE),convert_exp (e2,NONE),s))
              | _ => apply_cont (cont,exp)

            fun scan_one (var, info, FUNCTOR (n,s,(decs,e))) =
              (var,info,FUNCTOR (n,s,(map scan_one decs,convert_exp (e,NONE))))
              | scan_one (f,vinfo, VAL (FN ((vl,fpargs),body,status,name,ty,info))) =
                (case get_continuation f of
                   SOME c =>
                     let
                       val cargs = find_all_contvars c
                     in
                       (f,vinfo,VAL (FN ((vl@cargs,fpargs),convert_exp (body,SOME (c,cargs)),status,name,ty,info)))
                     end
                 | NONE => (f,vinfo,VAL (FN ((vl,[]),convert_exp (body,NONE),status,name,ty,info))))
              | scan_one (var,vinfo,VAL e) =
                (var,vinfo,VAL (convert_exp (e,NONE)))
          in
            (map scan_one decs,convert_exp (e,NONE))
          end
        val changed = ref true

      in
        scan_decs decs;
        scan_exp (e,TOPCONTEXT,false);
        (* Now we need to iterate information *)
        while (!changed) do
          (changed := false;
           Table.iterate (fn (_,{conts,tail_calls,...}) =>
                          (iterate
                           (fn f =>
                            iterate
                            (fn c =>
                             changed := (pushnewp (c,conts_of f) orelse !changed)
                             handle Table.Lookup => ())
                            (!conts))
                           (!tail_calls)))
           fn_table);
        (* Now we should have all of the relevant continuation information *)
        if doprint 
          then 
            print_info fn_table
        else ();
        PROGRAM (convert_decs decs)
      end (* of tail_convert *)



    (* make a table of all the functions declared in dec *)
    (* Initial value for each function is init () *)
    fun find_functions (decs,init) =
      let
        val table = new_table ()
        fun scan [] = ()
          | scan ((var,info,dec)::rest) =
            (case dec of
               FUNCTOR (var,name,(decs,e)) => scan decs
             | VAL (FN (vl,e,s,n,t,i)) =>
                 Table.update (table,var,init ())
             | VAL _ => ();
             scan rest)
      in
        scan decs;
        table
      end

    (* Some flow analysis *)

    (* Find what the call graph is *)
    (* Return a table of the known functions *)

    (* we need to know, for each function, whether it has an external or *)
    (* escaping occurence, the  functions that tail call it *)
    (* Fill in the table with the uses of the known functions *)
    fun find_uses (decs,e) =
      let
        val table = find_functions (decs,fn _ => {external = ref false,
                                                  tails = ref []})
        fun do_call (var,current,tail) =
          case Table.tryLookup (table,var) of
            NONE => ()
          | SOME {external,tails}=>
              if current = ~1 then
                external := true
              else
                if tail then
                  (* we aren't interested in self tail calls *)
                  if var = current then ()
                  else tails := current :: !tails
                else external := true
        fun do_external var =
          case Table.tryLookup (table,var) of
            NONE => ()
          | SOME {external,tails} => external := true
        fun scan_exp (exp,current,tail) =
          case exp of
            VAR var => do_external var
          | FN (args,exp,status,name,ty,info) => 
              scan_exp (exp,~1,true)
          | LET ((var, info,exp1),exp2) =>
              (scan_exp (exp1,current,false);
               scan_exp (exp2,current,tail))
          | LETREC (vl,el,e) =>
              crash "letrec found"
          | APP (exp,(el,fpel),info) =>
              (case exp of
                 VAR v => do_call (v,current,tail)
               | _ => scan_exp (exp,current,false);
               iterate (fn e => scan_exp (e, current,false)) (fpel @ el))
          | SCON _ => ()
          | INT _ => ()
          | SWITCH (e,info,tel,default) =>
            (scan_exp (e,current,false);
             iterate (fn (t,e) => scan_exp (e,current,tail)) tel;
             case default of
               SOME e => scan_exp (e,current,tail)
             | _ => ())
          | STRUCT (el,_) =>
              iterate (fn e => scan_exp (e,current,false)) el
          | SELECT (_,e) =>
              scan_exp (e,current,false)
          | RAISE e =>
              scan_exp (e,current,false)
          | HANDLE (e1,e2,s) =>
              (scan_exp (e1,current,false);
               scan_exp (e2,current,false))
          | BUILTIN p => ()
          | MLVALUE _ => ()
        fun scan_one (var, FUNCTOR (_,s,(decs,e))) =
          (scan_decs decs;
           scan_exp (e,~1,false))
          | scan_one (var,VAL (FN (vl,body,status,name,ty,info))) =
            scan_exp (body,var,true)
          | scan_one (var,VAL e) =
            scan_exp (e,~1,false)
        and scan_decs [] = ()
          | scan_decs ((var,info,dec) :: rest) =
            (scan_one (var,dec);
             scan_decs rest)
      in
        scan_decs decs;
        scan_exp (e,~1,false);
        table
      end

    datatype LabelType = NOLABEL | ONELABEL of LVar | MANYLABELS

    fun localize (labeltable,uses_table,declist) =
      let
        (* A local function is one labelled with exactly one external function *)
        fun is_local f =
          case Table.tryLookup (labeltable,f) of
            SOME (ref (ONELABEL _)) => true
          | _ => false

        fun not_referenced f =
          case Table.tryLookup (uses_table,f) of
            SOME ({tails = ref [], external = ref false}) => 
              (print (I f ^ " not referenced\n");
               true)
          | _ => false

        (* Any functions that have a unique label are inserted into the *)
        (* labelling function in a local letrec *)
        (* localtable maps functions to their local functions *)
        val localtable = 
          let
            val table = new_table ()
            fun add_entry (f,locf) =
              let
                val place =
                  case Table.tryLookup (table,f) of
                    SOME r => r
                  | _ =>
                      let
                        val p = ref []
                      in
                        Table.update (table,f,p);
                        p
                      end
              in
                place := locf :: !place
              end
            val _ =
              Table.iterate
              (fn (locf,ref (ONELABEL f)) => add_entry (f,locf)
            | _ => ())
              labeltable
          in
            table
          end

        (* Table of definitions *)
        val deftable = 
          let
            val table = new_table ()
            (* This could just do the local functions *)
            fun scan [] = ()
              | scan ((var,info,dec) :: rest) =
                (case dec of
                   VAL (FN data) => Table.update (table,var,(var,info,data))
                 | VAL _ => ()
                 | FUNCTOR (var,s,(declist,e)) => scan declist;
                     scan rest)
            val _ = scan declist
          in
            table
          end

        (* take a function and put its local functions in *)
        fun insert_locals ([],body) = body
          | insert_locals (locals,body) =
            let
              val fndata = map (fn l => Table.lookup (deftable,l)) locals
              val vl = map (fn (var,info,_) => (var,info)) fndata
              val el = 
                map 
                (fn (_,_,((vl,fpargs),body,s,n,t,_)) => 
                 FN ((vl,fpargs),body,s,n,t,RuntimeEnv.LOCAL_FUNCTION))
                fndata
            in
              (* P ("Localizing " ^ print_fns locals ^ "\n"); *)
              LETREC (vl,el,body)
            end

        fun transform ([],acc) = rev acc
          | transform ((var,info,dec)::rest,acc) =
            case dec of
              FUNCTOR (fvar,s,(declist,e)) =>
                transform (rest,(var,info,FUNCTOR (fvar,s,(transform (declist,[]),e)))::acc)
            | VAL (FN ((args,fpargs),body,status,name,ty,finfo)) =>
                if is_local var orelse not_referenced var 
                  then transform (rest,acc)
                else
                  let
                    val newbody =
                      case Table.tryLookup (localtable,var) of
                        SOME (ref locals) =>
                          insert_locals (locals,body)
                      | _ => body
                  in
                    transform (rest,(var,info,VAL (FN ((args,fpargs),newbody,status,name,ty,finfo)))::acc)
                  end
            | VAL exp => transform (rest,(var,info,VAL exp) :: acc)
      in
        transform (declist,[])
      end (* of localize *)

    fun lift_locals (PROGRAM (decs,e))=
      let
        val uses_table = find_uses (decs,e)
        (* Now construct the a call graph for tail calls *)
        val call_table = 
          let
            val table = Table.map (fn _ => ref []) uses_table
            (* initialize the entries *)
            val _ : unit = 
              Table.iterate
              (fn (callee,{tails,...}) =>
               iterate 
               (fn caller => pushnew (callee, Table.lookup (table, caller)))
               (!tails))
              uses_table
          in
            table
          end
        fun is_external f =
          let
            val {external,tails} = 
              Table.lookup (uses_table,f)
          in
            !external
          end

        fun set_external f =
          let
            val {external,tails} = 
              Table.lookup (uses_table,f)
          in
            external := true
          end

        val labeltable = Table.map (fn _ => ref NOLABEL) uses_table

	fun trace1 (table,f) =
          let
            val callees = !(Table.lookup (call_table,f))
          in
            foldl
            (fn (g,acc) =>
             if is_external g then acc
             else 
               let
                 val entry = Table.lookup (table,g)
               in
                 case !entry of
                   NOLABEL => (entry := ONELABEL f; acc)
                 | ONELABEL f' => (if f = f' then acc 
                                  else
                                    (entry := MANYLABELS;
                                     set_external g;
                                     g :: acc))
                 | MANYLABELS => crash "MANYLABELS in trace1"
               end)
            [] callees
          end

        fun is_member (f,hashset) =
          case Table.tryLookup (hashset,f) of
            SOME _ => true
          | _ => false
        fun add_member (f,hashset) =
          Table.update (hashset,f,())

        fun trace (table,label,f,seen) =
          if is_member (f,seen) orelse is_external f then ()
          else
            let
              val entry = Table.lookup (table, f)
              val _ = case !entry of
                NOLABEL => entry := ONELABEL label
              | ONELABEL label' => 
                  if label = label' then ()
                  else entry := MANYLABELS
              | MANYLABELS => ()
              val callees = !(Table.lookup (call_table,f))
            in
              add_member (f,seen);
              iterate (fn g => trace (table,label,g,seen)) callees
            end

        fun dotrace1 () =
          let
            val externs = 
              Table.fold
              (fn (acc,var,_) => 
               if is_external var 
                 then var :: acc
               else acc)
              ([],uses_table)
            fun aux [] = ()
              | aux (a::b) =
                aux (trace1 (labeltable,a) @ b)
          in
            aux externs
          end

        (* starting from the external functions label children *)
        fun dotrace () =
          Table.iterate
          (fn (var,_) =>
           if is_external var then
             iterate (fn g => trace (labeltable,var,g,new_table())) (!(Table.lookup (call_table,var)))
           else ())
          uses_table

        val _ = dotrace1 ()
        val _ = dotrace ()
        val decs = localize (labeltable,uses_table,decs)
      in
(*
        print_table uses_table;
        P "calls:\n";
        print_call_table call_table;
        P "labels:\n";
        print_call_table labeltable;
*)
        PROGRAM (decs,e)
      end (* of lift_locals *)


    (* FP args tranformation *)

    val num_fp_args = List.length (MachSpec.fp_arg_regs)

    fun findfpargs (PROGRAM (decs,e)) =
      if num_fp_args = 0 then (PROGRAM (decs,e))
      else
      let
        fun find_fps (e, args, fp_funs) =
          let
            val fps = ref []
            (* assume linearized for simplicity *)
            fun scan e = 
              case e of
                LET ((var,info,e),body) =>
                  (scan e; scan body)
              | SWITCH (e,info,tel,opte) =>
                  (scan e;
                   iterate (fn (t,e) => scan e) tel;
                   case opte of
                     SOME e => scan e
                   | _ => ())
              | HANDLE (e1,e2,s) => (scan e1;scan e2)
              | APP (BUILTIN b, (arglist,fpargs), ty) =>
                  (if SimpleUtils.is_fp_builtin b
                    then 
                      (iterate
                       (fn VAR x => 
                        if member (x,args) then pushnew (x,fps)
                        else ()
                     | _ => ())
                       arglist)
                  else ())
              | APP (VAR f, (arglist,[]), ty) =>
                  (case Table.tryLookup (fp_funs,f) of
                     NONE => ()
                   | SOME (f_args,f_fpargs,_) =>
                       let
                         val pairs = zip (arglist,f_args)
                         fun do_one (VAR x, a) =
                           if member (a,f_fpargs) andalso member (x,args)
                             then ((* print ("Found derived FP arg " ^ I x ^ "\n"); *)
                                   pushnew (x,fps))
                           else ()
                           | do_one _ = ()
                       in
                         iterate do_one pairs
                       end)
              | _ => ()
          in
            scan e;
            !fps
          end

        fun check_size l =
          let
            fun aux (0,_,acc) = rev acc
              | aux (n,a::b,acc) = aux (n-1,b,a::acc)
              | aux (n,[],acc) = rev acc
          in
            aux (num_fp_args,l,[])
          end

        val fp_funs = 
          let 
            val changed = ref true
            val count = ref 0
            val fp_funs = new_table ()
            fun scan (x,info,FUNCTOR (var,name,(decs,exp))) =
              iterate scan decs
              | scan (x,info,VAL (FN ((args,_),body,status,name,ty,funinfo))) =
              let
                val fpargs = check_size (find_fps (body,args,fp_funs))
              in
                case fpargs of
                  [] => ()
                | _ => 
                    let
                      val change = 
                        case Table.tryLookup (fp_funs,x) of
                          NONE => true
                        | SOME (_,fpargs',_) =>
                            fpargs <> fpargs'
                    in
                      if not change then ()
                      else
                        (changed := true;
                         Table.update (fp_funs,x,(args,fpargs,ref NONE)))
                    end
              end
              | scan x = ()
          in
            while !changed
              do
              (changed := false;
               count := !count + 1;
               iterate scan decs);
(*
            if !count > 2 then print (I (!count) ^ " iterations\n") else ();
*)
            fp_funs
          end
        fun is_fp_fun f = 
          case Table.tryLookup (fp_funs,f) of
            SOME _ => true
          | NONE => false

        (* Now we have to change applications of functions with fpargs and *)
        (* to do the right thing with escaping occurrences *)
        (* also change the function argument lists appropriately *)

        fun lookup (v,[]) = NONE
         | lookup (v,(v',a) :: rest) = if v = v' then SOME a else lookup (v,rest)

        fun lookup' (v,[]) = Crash.impossible "lookup'"
          | lookup' (v,(v',a) :: rest) = if v = v' then a else lookup' (v,rest)

        fun rearrange_args (argsexps,args,fp_args) =
          let
            val argvars = zip (args,argsexps)
            val gc_args = subtract (args,fp_args)
          in
            (map (fn v => lookup' (v,argvars)) gc_args,
             map (fn v => lookup' (v,argvars)) fp_args)
          end

        fun changeexp e =
          case e of
            VAR v =>
              (case Table.tryLookup (fp_funs, v) of
                 SOME (args,fp_args,newvar) =>
                   (case !newvar of
                      SOME v' => VAR v'
                    | NONE => 
                        let
                          val v' = new_LVar()
                        in
                          newvar := SOME v';
                          VAR v'
                        end)
               | _ => e)
          | FN ((ll,fpl),body,status,name,ty,info) =>
            FN ((ll,fpl),changeexp body, status, name,ty,info)
          | LET ((lvar,info,lexp),body) =>
            LET ((lvar,info,changeexp lexp), changeexp body)
          | LETREC (lvl, lel, body) =>
            LETREC (lvl,map changeexp lel, changeexp body)
          | APP (VAR v,(lel,[]), ty) =>
            (case Table.tryLookup (fp_funs,v) of
               NONE => APP (VAR v,(map changeexp lel,[]), ty)
             | SOME (args,fp_args,_) =>
                 APP (VAR v, rearrange_args (map changeexp lel, args,fp_args),ty))
          | APP (e,(lel,[]), ty) =>
            APP (changeexp e, (map changeexp lel,[]), ty)
          | APP _ => Crash.impossible ("fp_args in changeexp")
          | SCON _ => e
          | MLVALUE _ => e
          | INT _ => e
          | SWITCH (e,info,tel, opte) =>
            SWITCH (changeexp e, info, telmap changeexp tel, optfun changeexp opte)
          | SELECT (info,e1) =>
            SELECT (info, changeexp e1)
          | RAISE e => RAISE (changeexp e)
          | STRUCT (el,ty) => STRUCT (map changeexp el,ty)
          | HANDLE (e1,e2,s) => HANDLE (changeexp e1, changeexp e2, s)
          | BUILTIN _ => e

        fun progmap f (declist,exp) =
          let
            fun decfun (VAL (FN (vl,e,status,name,ty,debug))) = 
              VAL (FN (vl,f e,status,name,ty,debug))
              | decfun (VAL e) = VAL (f e)
              | decfun (FUNCTOR (var,name,prog)) =
              FUNCTOR (var,name,progmap f prog)
          in
            (map (fn (var,info,dec) => (var,info,decfun dec)) declist,
             f exp)
          end

        val (decs,e) = progmap changeexp (decs,e)

        fun dodecs ([],acc) = rev acc
          | dodecs ((x,info,FUNCTOR (var,name,(decs,exp))) :: rest, acc) =
          dodecs (rest,(x,info,FUNCTOR (var,name,(dodecs (decs,nil),exp))) :: acc)
          | dodecs ((entry as (x,info, VAL (FN ((args,_),body,status,name,ty,funinfo)))) :: rest, acc) =
          (case Table.tryLookup (fp_funs,x) of
             NONE => dodecs (rest, entry :: acc)
           | SOME (args,fp_args,external) =>
               let
                 val gc_args = subtract (args,fp_args)
                 val acc =
                   (x,info, VAL (FN ((gc_args,fp_args),body,status,name,ty,funinfo))) :: acc
                 val acc = 
                   case !external of
                     NONE => acc
                   | SOME v => (v,NONE,(VAL (FN ((args,[]),APP (VAR x,(map VAR gc_args,map VAR fp_args),NONE), ENTRY, name ^  "<FP entry point>",ty,funinfo)))) :: acc
               in
                 dodecs (rest,acc)
               end)
           | dodecs (entry::rest,acc) =
               dodecs (rest, entry::acc)
      in
        PROGRAM (dodecs (decs,[]),e)
      end

    (* Some stuff for loop analysis *)
  
    fun loop_analysis (PROGRAM (decs,e)) =
      let
        (* ~1 is the root node *)
        (* a node has ~1 as a parent if it is external *)
        (* Of course, it dominates all other nodes, so we can omit it from our calculations of dom *)

        (* Calculate the call graph and its inverse *)
        (* Then the dominator sets for each node *)
        (* In the process, we find the back arcs and determine if these are loops *)
        (* Given the set of loop headers, we determine the components of the loops *)
        (* And thus we can do loop invariant removal etc. *)

        val callertable = find_functions (decs,
                                          fn _ => [])
        val paramtable = new_table()
        val bodytable = new_table()
        (* scan over an expression accumulating information about function calls *)
        val external = ~1
        fun scan_exp (exp,context) =
          let
            fun add (f,args,c) =
              case Table.tryLookup (callertable,f) of
                SOME rl => Table.update (callertable,f,(c,args) :: rl)
              | _ => ()
          in
            case exp of
              VAR var => add (var,NONE,external)
            | FN (args,exp,status,name,ty,info) => 
                scan_exp (exp,external)
            | LET ((var, info,exp1),exp2) =>
                (scan_exp (exp1,context);
                 scan_exp (exp2,context))
            | LETREC (vl,el,e) =>
                crash "letrec found in do_call"
            | APP (exp,(el,fpel),info) =>
                (case exp of
                   VAR v => add (v,SOME (el,fpel),context)
                 | _ => scan_exp (exp,context);
                     iterate (fn e => scan_exp (e, context)) (el @ fpel))
            | SCON _ => ()
            | INT _ => ()
            | SWITCH (e,info,tel,default) =>
                   (scan_exp (e,context);
                    iterate (fn (t,e) => scan_exp (e,context)) tel;
                    case default of
                      SOME e => scan_exp (e,context)
                    | _ => ())
            | STRUCT (el,_) =>
                   iterate (fn e => scan_exp (e,context)) el
            | SELECT (_,e) =>
                scan_exp (e,context)
            | RAISE e =>
                scan_exp (e,context)
            | HANDLE (e1,e2,s) =>
                (scan_exp (e1,context);
                 scan_exp (e2,context))
            | BUILTIN p => ()
            | MLVALUE _ => ()
          end
        fun scan_one (var, FUNCTOR (_,s,(decs,e))) =
          (scan_decs decs;
           scan_exp (e,external))
          | scan_one (var,VAL (FN (vl,body,status,name,ty,info))) =
          (Table.update (paramtable,var,vl);
           Table.update (bodytable,var,body);
           scan_exp (body,var))
          | scan_one (var,VAL e) =
            scan_exp (e,external)
        and scan_decs [] = ()
          | scan_decs ((var,info,dec) :: rest) =
            (scan_one (var,dec);
             scan_decs rest)

        val _ = scan_decs decs
        val _ = scan_exp (e,external)
        (* Now callertable, paramtable and bodytable are correct *)
        fun print_calls [] = ""
          | print_calls (~1 :: rest) = "external " ^ print_calls rest
          | print_calls (f :: rest) = I f ^ " " ^ print_calls rest
        fun invert t =
          let
            val table = Table.map (fn _ => []) t
          in
            Table.update (table,~1,[]);
            Table.iterate
            (fn (f,vl) =>
             app
             (fn (c,el) => Table.update (table,
                                         c,
                                         (f,el) :: Table.lookup (table,c)))
             vl)
            t;
            table
          end
        val calleetable = invert (callertable) (* Define calleetable *)
          
        (* Do a dfs search search of the graph *)
        (* So a function get listed after all of its children *)
        fun dfs table =
          let
            val result = ref []
            val backarcs = ref []
            fun aux (node,seen,route) =
              if member (node,seen) then seen
              else
                let
                  val children = Table.lookup (table,node)
                  val newroute = node :: route
                  val newseen = 
                    List.foldl
                    (fn ((child,_),seen) => 
                     (if member (child,newroute)
                        then backarcs := (child,node) :: !backarcs
                      else ();
                        aux (child,node::seen,node::route)))
                    seen
                    children
                in
                  result := node :: !result;
                  newseen
                end
          in
            ignore(aux (~1,[],[]));
            (!result,!backarcs)
          end
        (* and now we compute the dominator relationship. This is some *)
        (* code that uses  ordered lists to represent sets *)
        (* table is a hash table of the predecessor relation *)
        (* and items is the list of nodes in dfs order *)
        (* See the Dragon book for details of the algorithm *)

        fun compute_dom (table,root,items) =
          let
            val init = sort (op <) items
            val result = Table.map (fn _  => init) table
            val _ = Table.update (result,root,[root])
            fun insert (n,[]) = [n]
              | insert (n,a::b) = 
              if n = a then a :: b
              else if n < a then n :: a :: b
              else a :: insert (n,b)
            fun intersect [] = []
              | intersect [a] = a
              | intersect (a::b::rest) = 
              let
                fun i2 ([],l2,acc) = rev acc
                  | i2 (l1,[],acc) = rev acc
                  | i2 (a::b,c::d,acc) =
                  if a < c then i2 (b,c::d,acc)
                  else if a > c then i2 (a::b,d,acc)
                  else (* a = c *) i2 (b,d,a::acc)
              in
                intersect (i2 (a,b,[])::rest)
              end

            fun iter () =
              let
                val change = ref false
              in
                app
                (fn f =>
                 let
                   val old = Table.lookup (result,f)
                   val new = 
                     insert 
                     (f,
                      intersect 
                      (map 
                       (fn (x,_) => Table.lookup (result,x)) 
                       (Table.lookup (table,f))))
                 in
                   if new <> old then
                     (change := true;
                      Table.update (result,f,new)(* ;
                      P ("Doing " ^ I f ^ ": ");
                      app (fn x => P (I x ^ " ")) new;
                      P ("\n") *))
                   else ()
                 end)
                items;
                if !change then iter ()
                else ()
              end
          in
            iter ();
            result
          end
        val (items,backarcs) = dfs calleetable

        (* Don't pass the ~1 node to compute_dom *)
        val dom_table = compute_dom (callertable,~1,List.tl items)
        val loop_arcs = 
          List.filter 
          (fn (tail,head) => member (tail,Table.lookup (dom_table,head)))
          backarcs

        (* Each loop is a header block/function/node plus all the blocks "in" the loop *)
        (* The blocks "in" the loop are any with a backarc to the header, plus any that *)
        (* can reach a block in the loop without passing through the header *)
        (* ie. we take the closure *)
        val loop_list = 
          let
            val t = new_table ()
              (* the tail is the loop header (must sort out the terminology) *)
            fun it (tail,head) =
              Table.update (t,tail,
                            case Table.tryLookup (t,tail) of 
                              SOME l => head :: l
                            | NONE => [head])
            fun allblocks (f,l) =
              let
                val result = ref []
                fun loop [] = ()
                  | loop (block::rest) =
                  if block = f orelse member (block,!result)
                    then loop rest
                  else
                    let
                      val _ = result := block :: !result
                      val preds = map #1 (Table.lookup (callertable,block))
                    in
                      loop (preds@rest)
                    end
              in
                loop l;
                (f,!result)
              end
            fun find ([],acc) = rev acc
              | find (f::rest,acc) =
              case Table.tryLookup (t,f) of
                SOME l => find (rest,allblocks(f,l)::acc)
              | _ => find (rest,acc)
          in
            app it loop_arcs;
            find (items,[])
          end

        (* Now we want to calculate how header parameters get propagated around the loop *)
        (* Here is the algorithm *)
        fun propagate (f,blocks) =
          (* build a table of how parameters to f get propagated around the loop *)
          let
            fun sort_out ((p,fp),SOME (a,fa)) =
              let              
                val plist = p @ fp
                val alist = a @ fa
                fun pos (a,n,[]) = ~1
                  | pos (a,n,a'::rest) = if a = a' then n else pos (a,n+1,rest)
              in
                map (fn VAR a => pos (a,0,plist) | _ => ~1) alist
              end
              | sort_out _ = Crash.impossible "sort_out"
            fun combine ([],[]) = []
              | combine (a::r,a'::r') = (if a = a' then a else ~1) :: combine (r,r')
              | combine _ = Crash.impossible "combine"
            fun apply (m,a) = map (fn n => if n = ~1 then ~1 else List.nth (m,n)) a
            val fromf = new_table ()
            fun addinfo (g,args) =
              case Table.tryLookup (fromf,g) of
                NONE => (Table.update (fromf,g,args); true)
              | SOME args' => 
                  let
                    val new = combine (args,args')
                  in
                    if new <> args' then
                      (Table.update (fromf,g,new);
                       true)
                    else false
                  end
            (* initialize the fromf table with propagations from f *)
            val fparams = Table.lookup (paramtable,f)
            val _ =
              app
              (fn (g,args) => (ignore(addinfo (g, sort_out (fparams,args))); ()))
              (Table.lookup (calleetable,f))
            val proplist =
              conc
              (map
               (fn f =>
                let
                  val fparams = Table.lookup (paramtable,f)
                in
                  map
                  (fn (g,args) => (f,g,sort_out (fparams,args)))
                  (Table.lookup (calleetable,f))
                end)
               blocks)
            fun loop () =
              let
                val changed = ref false
              in
                app
                (fn (f,g,info) =>
                 case Table.tryLookup (fromf,f) of
                   SOME args' =>
                     let
                       val i = addinfo (g,apply (args',info))
                     in
                       changed := (!changed orelse i)
                     end
                 | _ => ())
                proplist;
                if !changed then loop () else ()
              end
          in
            loop ();
            fromf
          end
        (* Record which invariants we have done -- this is because a loop invariant is an *)
        (* invariant of any subloop, but we only want to define it once at the top level *)
        (* Fortunately, we iterate through the loops top down, so do each variable when we first *)
        (* see it and then ignore it henceforth *)
        val done_vars = ref []
        (* header is the loop header function.  blocks is the list of functions in the loop *)
        fun make_invariants (header,blocks,fromh) =
          let
            (* Accumulate the loop invariants here *)
            val all_invariants = ref []
            val hparams = op@ (Table.lookup (paramtable,header))
            val hinfo = Table.lookup (fromh,header)
            (* List of loop invariant arguments to f *)
            val args =
              rev (#2 (foldl (fn (n, (m,acc)) => (m+1,
                                                 (if m = n then SOME (List.nth (hparams,n))
                                                  else NONE) :: acc)) (0,[]) hinfo))
            (* augment calls to loop functions with invariant parameters *)
            fun do_one f =
              let
                val body = Table.lookup (bodytable,f)
                val params = op@ (Table.lookup (paramtable,f))
                val finfo = Table.lookup (fromh,f)
                (* work out the invariant parameters to this function *)
                (* and the header parameters that they correspond to *)
                val invariants =
                  #2 (foldl (fn (var,(i,acc)) =>
                            let
                              val findex = List.nth (finfo,i)
                            in
                              (i+1,
                               if findex >= 0
                                 then case List.nth (args,findex) of
                                   SOME m => (var,m)::acc
                                 | _ => acc
                               else acc)
                            end) (0,[]) params)

                fun transform e =
                  SimpleUtils.subst (fn v => VAR (case assoc (v,invariants) of SOME v' => v' | _ => v), e)
                (* Now we want to detect expressions involving only top level *)
                (* and loop invariant variables *) 
                val liftable_expressions = ref []
                fun check_vars (VAR v) = member (v, map #1 invariants) orelse member (v,map #1 (!liftable_expressions))
                  | check_vars (INT _) = true
                  | check_vars (SCON _) = true
                  | check_vars (BUILTIN _) = true
                  | check_vars (APP (e,(el,fpel),_)) = check_vars e andalso forall check_vars el andalso forall check_vars fpel
                  | check_vars (STRUCT (el,_)) = forall check_vars el
                  | check_vars _ = false
                fun scan e =
                  case e of
                    LET ((var,info,e),body) =>
                      (if SimpleUtils.is_simple e andalso SimpleUtils.safe e andalso check_vars e
                         (* Some vars are in more than one loop *)
                         (* Since we do outermost first, this ensures we are OK *)
                         then if member (var,!done_vars) then () 
                           else (done_vars := var :: !done_vars;
                                 liftable_expressions := (var,transform e) :: !liftable_expressions)
                       else scan e;
                       scan body)
                  | _ => ()
              in
                scan body;
                all_invariants := (!liftable_expressions) @ !all_invariants
(*
                app
                (fn (v,e) => 
                 P ("Invariant for " ^ I f ^ ": " ^ I v ^ " = " ^ LambdaPrint.print_exp e ^ "\n"))
                (!liftable_expressions)
*)
              end
          in
            app do_one (header :: blocks);
            (header,blocks,!all_invariants)
          end

        val loops =
             (* loop_list is in depth first order -- ie. outer loops precede *)
             (* inner loops *)
             map
             (fn (header,loops) => 
              let
                val fromh = propagate (header,loops)
                val self = Table.lookup (fromh,header)
              in 
                (* P ("Loop: " ^ I header ^ ": " ^ print_fns loops ^ " [" ^ print_fns self ^ "]\n"); *)
                make_invariants (header,loops,fromh)
              end)
             loop_list
        val newdata = ref []
        (* Now we _side_effect_ the param table and the body table. *)

        fun do_one (header,blocks,[]) = ()
          | do_one (header,blocks,invariants) =
          let
            (* Now we do two things -- add an internal header *)
            (* function that defines the loop invariant, and modify *)
            (* calls to loop function within the loop appropriately *)
            val invids = map #1 invariants
            val fid = newvar ()
            val (p,fp) = Table.lookup (paramtable,header)
            fun wrap (e,(fvar,f)::rest) =
              wrap (LET ((fvar,NONE,f),e),rest)
              | wrap (e,[]) = e
            fun scan_exp exp =
              case exp of
                VAR _ => exp
              | FN (args,exp,status,name,ty,info) =>
                  FN (args,scan_exp exp,status,name,ty,info)
              | LET ((var,info,exp1),exp2) =>
                  if member (var,invids) then scan_exp (exp2)
                  else LET ((var,info,scan_exp exp1),scan_exp exp2)
              | LETREC _ => crash "letrec found in lift_invariants"
              | APP (fexp,(el,fpel),info) =>
                    (case fexp of
                       VAR f => 
                         if f = header 
                           then APP (VAR fid,(el @ map VAR invids,fpel),info)
                         else if member (f,blocks) 
                                then APP (VAR f,(el @ map VAR invids,fpel),info)
                              else exp
                     | _ => exp)
              | SWITCH (e,info,tel,default) =>
                       SWITCH (scan_exp e,
                               info,
                               telmap scan_exp tel,
                               optfun scan_exp default)
              | HANDLE (e1,e2,s) => HANDLE (scan_exp e1,scan_exp e2,s)
              | _ => exp
            (* This is the body of the new header function *)
            val newbody =
              wrap (APP (VAR fid,(map VAR (p @ invids), map VAR fp),
                         NONE),
                    invariants)
          in
            newdata := (header,(fid,invids,newbody)):: !newdata;
            app
            (fn id => (Table.update (bodytable,id,
                                     scan_exp (Table.lookup (bodytable,id)));
                       if id = header then ()
                       else Table.update (paramtable,id,
                                          (fn ((a,b),c) => (a @ c,b))
                                          (Table.lookup (paramtable,id), invids))))
            (header::blocks)
          end
        val _ = app do_one loops
        fun invariants_rewrite (decs,exp, []) = (decs,exp)
          | invariants_rewrite (decs,exp, newdata) = 
          let
            fun scan ([],acc) = rev acc
              | scan ((var,info,FUNCTOR (f,s,(decs,e))) :: rest,acc) =
              scan (rest, (var,info,FUNCTOR (f,s,(scan (decs,[]),e))) :: acc)
              | scan ((var,info,VAL (FN (vl,body,status,name,ty,info'))) :: rest, acc) =
              (case assoc (var,newdata) of
                 SOME (fid,invids,newbody) =>
                   ((* print "Doing header\n"; *)
                    let
                      val vl = Table.lookup (paramtable,var)
                    in
                      scan (rest,
                            (var,info,VAL (FN (vl,newbody,status,name,ty,info'))) ::
                            (fid,info,VAL (FN ((#1 vl @ invids, #2 vl),
                                               Table.lookup (bodytable,var),
                                               status,name,ty,info'))) ::
                            acc)
                    end)
               | NONE =>
                   ((* print "Doing body function\n"; *)
                    scan (rest, 
                          (var,info,VAL (FN (Table.lookup (paramtable,var),
                                             Table.lookup (bodytable,var),
                                             status,name,ty,info'))) ::
                          acc)))
              | scan (entry :: rest, acc) =
                 scan (rest,entry :: acc)
          in
            (scan (decs,[]),exp)
          end
        (* This sort of adds in the internal header function definitions *)
        (* And inserts the new parameter lists and bodies of loop functions *)
        val (decs,e) =
          invariants_rewrite (decs,e,!newdata)
      in
        PROGRAM (decs,e)
      end
  end

