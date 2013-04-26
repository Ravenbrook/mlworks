(*
 *
 * $Log: elf.fun,v $
 * Revision 1.2  1998/06/03 12:30:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991,1992,1993 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>                     *)
(* Modified: Spiro Michaylov <spiro@cs.cmu.edu>               *)
(* Modified: Ekkehard Rohwedder <er@cs.cmu.edu>               *)


(* Requires much cleaning up !!! *)

functor Elf
   (structure Basic : BASIC
    structure Term : TERM
    structure Sb : SB  sharing Sb.Term = Term
    structure Reduce : REDUCE sharing Reduce.Term = Term
    structure Sign : SIGN  sharing Sign.Term = Term
    structure Constraints : CONSTRAINTS  sharing Constraints.Term = Term
    structure Unify : UNIFY  sharing Unify.Term = Term
                             sharing Unify.Constraints = Constraints
    structure Print : PRINT  sharing Print.Term = Term
    structure Specials : SPECIALS  sharing Specials.Term = Term
    structure Progtab : PROGTAB  sharing Progtab.Term = Term
       sharing Progtab.Sign = Sign
    structure Simplify : UNIFY
       sharing Simplify.Term = Term
       sharing Simplify.Constraints = Unify.Constraints
    structure TypeRecon : TYPE_RECON  sharing TypeRecon.Term = Term
    structure ElfFrontEnd : ELF_FRONT_END
       sharing type ElfFrontEnd.Constraints.constraint = Constraints.constraint
       sharing ElfFrontEnd.Sign = Sign
    structure Solver : SOLVER
       sharing Solver.Term = Term
       sharing Solver.Constraints = Constraints
    structure Store : STORE
       sharing Store.Term = Term
       sharing Store.Sign = Sign
       sharing Store.Progtab = Progtab
    structure Sys : SYS
    structure Time : TIME)
    : ELF =
struct

  val version = "Elf, Version 0.5, August 30, 1995"

  structure F = Print.F
  structure S = Print.S

  structure Store = Store

  structure E =
  struct 
    exception UnknownSwitch = Basic.UnknownSwitch

    (* Control *)
    val all_solutions = ref false

    fun control "all_solutions" = all_solutions
      | control s = raise UnknownSwitch("Elf.control",s)

    (* Warning *)
    val warn_redeclaration = ElfFrontEnd.warn_redeclaration
    val warn_redeclaration_initload = ref true
    val warn_implicit = ElfFrontEnd.warn_implicit

    fun warn "redeclaration" = warn_redeclaration
      | warn "redeclaration_initload" = warn_redeclaration_initload
      | warn "implicit" = warn_implicit
      | warn s = raise UnknownSwitch("Elf.warn",s)

    (* Tracing *)
    val echo_declarations = ElfFrontEnd.echo_declarations
    val show_proof = ref false
    val show_obligations = ref false
    val show_dynamic = ref true
    val time_queries = ref false
    val batch_show_subst = ref true
    val batch_echo_query = ref true

    fun trace "echo_declarations" = echo_declarations
      | trace "show_proof" = show_proof
      | trace "show_obligations" =  show_obligations
      | trace "show_dynamic" = show_dynamic
      | trace "time_queries" = time_queries
      | trace "batch_show_subst" =  batch_show_subst
      | trace "batch_echo_query" =  batch_echo_query
      | trace s = raise UnknownSwitch("Elf.trace",s)

  end (* structure Switch *)

  open E

  fun with_value var value func =
      let val oldvalue = !var
	  val _ = var := value
	  val result = func () handle exn => ( var := oldvalue ; raise exn )
       in ( var := oldvalue ; result ) end

  exception NotYetLoaded

  fun is_dynamic filename =
        (case (Store.find_top filename)
           of NONE => raise NotYetLoaded
            | SOME(_,_,Store.Dynamic _) => true
            | SOME(_,_,Store.Static _) => false)

  (*
     Now the external functions
  *)

  fun maybe_start_timer () =
      if (!time_queries)
         then SOME(Time.timer_start ())
         else NONE

  fun maybe_print_timer (SOME(timer)) =
      if (!time_queries)
         then let val (rt,gct,tt) = Time.timer_read timer
               in print ("\nTimes: run = " ^ make_real rt
                         ^ "s gc = " ^ make_real gct
                         ^ "s total = " ^ make_real tt ^ "s\n")
              end
         else ()
    | maybe_print_timer (NONE) = ()

  fun more_solutions () = 
    if !all_solutions orelse (ord (input_line std_in)) = ord ";"
       then true
       else false

  (* Clean up below !!! *)

  fun create_goal (Term.HasType(M,A)) =
        let val e = Sb.new_evar (Term.Varbind("Query",A)) nil
            fun inst (Term.Evar(_,_,_,r as ref _)) M = ( r := SOME(M) )
	      | inst _ _ = raise Basic.Illegal ("inst: arg not Evar")
            val _ = inst e M
         in (e, A) end
    | create_goal (A) =
        let val e = Sb.new_evar (Term.Varbind("Query",A)) nil
         in (e, A) end

  fun hastype_query (Term.HasType _) = true
    | hastype_query _ = false

  fun query prog =
   let exception QueryComplete
       exception EOF_stream
       val at_least_one = ref false
       val _ = Progtab.store_prog prog
       fun query_loop_fun () =
    (let (* Prompting now in interactive_read *)
         (* val _ = (print "?- " ; flush_out std_out) *)
         val _ = at_least_one := false
         fun get_query(SOME input) = input
           | get_query(NONE) = raise EOF_stream
	 val (evars, M, con) = get_query(ElfFrontEnd.interactive_read ())
         val (e, A) = create_goal M
         val _ = print "Solving...\n"
         (* val _ = maybe_profile_on () *)
         val timer = maybe_start_timer ()
      in Solver.solve e (!show_proof orelse (hastype_query M)) con
            (fn newcon =>
               let val _ = maybe_print_timer timer
                   (* val _ = maybe_profile_off () *)
                   val newcon' = Simplify.simplify_constraint1 newcon
                in
                (case evars
                   of nil => print "solved\n" 
                    | _ => print (Print.makestring_substitution evars) ;
                 if Constraints.is_empty_constraint newcon'
                    then ()
                    else print (Constraints.makestring_constraint newcon') ;
                 if !show_proof
                    then print (Print.makestring_substitution [e])
                    else () ;
                 if !show_obligations
                    then let val (env,e') = TypeRecon.abst_over_evars nil
                                               TypeRecon.empty_env
                                               e
                             val (env',A') = TypeRecon.abst_over_evars nil
                                               env A
                             val (A'',_) = TypeRecon.env_to_pis env'
                                               A' Term.Type
                          in ( print "QQuery : " ;
                               print (Print.makestring_term A'') ;
                               print "\n" )
                         end
                     else () ;
                 if more_solutions ()
                    then ( at_least_one := true ; () )
                    else raise QueryComplete )
                end ) ;
          print (if !at_least_one then "no more solutions\n" else "no\n");
          query_loop ()
      end)
      and query_loop () =
             query_loop_fun ()
             handle QueryComplete => ( print "yes\n" ; query_loop () )

      fun top_loop () =
             ElfFrontEnd.handle_std_exceptions "\nstd_in" (query_loop)
             handle EOF_stream => raise EOF_stream
                  | e => ( print ("caught exception "
                                  ^ Sys.exception_name e ^ "\n") ;
                           top_loop () )
    in Sys.handle_interrupt (top_loop)
       handle EOF_stream => ()
   end  

  fun maybe_echo (str:string) =
    if (!batch_echo_query)
       then ( print("?- " ^ str) ; str )
       else str

  fun batch_query query_file token_stream prog =
   let exception QueryComplete of ElfFrontEnd.token_stream
       exception EOF_stream
       val _ = Progtab.store_prog prog
       fun query_loop_fun (token_stream) =
    (let fun get_query(SOME input) = input
           | get_query(NONE) = raise EOF_stream
	 val ((evars, M, con),rest_stream) =
	        get_query(ElfFrontEnd.stream_read token_stream)
         val (e, A) = create_goal M
         (* val _ = maybe_profile_on () *)
         val timer = maybe_start_timer ()
      in Solver.solve e (!show_proof orelse (hastype_query M)) con
            (fn newcon =>
               let val _ = maybe_print_timer timer
                   (* val _ = maybe_profile_off () *)
                in
                (if (!batch_show_subst) then () else raise QueryComplete(rest_stream) ;
                 case evars
                   of nil => print "solved\n" 
                    | _ => print (Print.makestring_substitution evars) ;
                 let val newcon' = Simplify.simplify_constraint1 newcon
                  in if Constraints.is_empty_constraint newcon'
                     then ()
                     else print (Constraints.makestring_constraint newcon')
                 end ;
                 if !show_proof
                    then print (Print.makestring_substitution [e])
                    else () ;
                 raise QueryComplete(rest_stream))
                end ) ;
          print "no\n";
          query_loop (rest_stream)
      end)
      and query_loop (token_stream) =
             query_loop_fun (token_stream)
             handle QueryComplete (rest_stream)
	               => ( print "yes\n" ; query_loop (rest_stream) )

      fun top_loop () =
             ElfFrontEnd.handle_std_exceptions query_file
	        (fn () => query_loop token_stream)
             handle EOF_stream => raise EOF_stream
                  | e => ( print ("caught exception "
                                  ^ Sys.exception_name e ^ "\n") ;
                           raise EOF_stream )
    in Sys.handle_interrupt (top_loop)
       handle EOF_stream => ()
   end  

   (* Accumulate filenames, programs, dynamic families *)
   fun acc_pc ((_,_,Store.Static _),sofar) = sofar
     | acc_pc ((filename,_,Store.Dynamic(_,prog,closed)),(fs,progs,closeds)) =
          (filename::fs, prog::progs, closed @ closeds)

   fun get_top_state ()
       : string list * Progtab.progentry list list * Term.sign_entry list =
       fold acc_pc (!Store.topenv) (nil, nil, nil)

   fun enum (fmtlist) = F.HVbox0 1 0 1 fmtlist

   fun fsep (s,nil) = F.String (S.string s) :: nil
     | fsep (s,f) = F.String (S.string s) :: F.Break :: f

   fun csep (s,nil) = F.String (S.const s) :: nil
     | csep (s,f) = F.String (S.const s) :: F.Break :: f

   fun se_name (Term.E(ref {Bind = Term.Varbind(s,_),...})) = s
     | se_name _ = raise Basic.Illegal ("se_name: improper arg")

   fun const_name (Term.Const(se)) = se_name se
     | const_name _ = raise Basic.Illegal ("const_name: improper arg")

   fun se_names nil = nil
     | se_names (se::ses) =  se_name se :: se_names ses

   fun show_using (fs) =
          F.print_fmt (F.Hbox [F.String (S.string "Using:"), F.Space,
                               enum (fold fsep fs nil), F.Newline ()])

   fun show_solving (closeds) = 
          F.print_fmt (F.Hbox [F.String (S.string "Solving for:"), F.Space,
                               enum (fold csep (se_names closeds) nil),
                               F.Newline ()])

   fun clauses_names nil = nil
     | clauses_names (Progtab.Progentry {Name = c, ...} :: pes) =
          const_name c :: clauses_names pes

   fun clause_info se = 
          F.HVbox (F.String (S.const (se_name se)) ::
                   F.String (S.string ":") :: F.Space ::
                   (fold csep (clauses_names (Progtab.get_rules (Term.Const se)))
                    nil))

   fun clauses_info nil = nil
     | clauses_info (se::nil) = [clause_info se]
     | clauses_info (se::closeds) =
          clause_info se :: F.Break :: clauses_info closeds

   fun show_clauses (closeds) =
          F.print_fmt
             (F.Vbox [F.String (S.string "Dynamic families and defining clauses:"),
                      F.Break, F.Vbox0 0 1 (clauses_info closeds)])

   fun show_prog () = 
       let val (fs,progs,closeds) = get_top_state ()
           val _ = Progtab.store_prog progs
        in ( show_using (fs) ;
             show_clauses (closeds) )
       end

  fun internal_top query_func =
     let val (fs,progs,closeds) = get_top_state ()
      in ( if (!show_dynamic)
	      then ( show_using (fs) ; show_solving (closeds) )
	      else () ;
           query_func progs )
     end

  fun top () = internal_top query

  fun batch_top query_file =
    let val instream = open_in query_file
	val token_stream = ElfFrontEnd.stream_init instream maybe_echo
        val _ = print ("[reading queries from file " ^ query_file ^ "]\n")
     in ( internal_top (batch_query query_file token_stream) ;
          close_in instream ;
          print("[closed query file " ^ query_file ^ "]\n") )
    end

  local
   fun h () =
   print (version ^ "\n" ^ "Top-level utilities:\n\
  \ initload [sfile1,...,sfilen] [dfile1,...,dfilem]\n\
  \                         --- reset & load, first static, then dynamic\n\
  \ top ()                  --- invoke Elf top-level\n\
  \ sload [file1,...,filen] --- static load\n\
  \ dload [file1,...,filen] --- dynamic load\n\
  \ reload file             --- reload with previous annotation\n\
  \ toc ()                  --- print summary of top-level environment\n\ 
  \ show_prog ()            --- print rules in top-level environment\n\
  \ print_sig file          --- print signature, elliding arguments\n\
  \ print_sig_full file     --- print signature, with implicit arguments\n\
  \ reset ()                --- empty all signatures and top-level environment\n\
  \ batch_top file          --- take top-level queries from file\n\
  \ cd \"directory\"          --- change working directory\n\
  \ pwd ()                  --- print current working directory\n\
  \ ls \"pattern\"            --- list current working directory contents\n\
  \ trace (n)               --- trace execution with verbosity level n\n\
  \ untrace ()              --- stop tracing (same as trace(0))\n\
  \ chatter (n)             --- set verbosity of chatter (default: 2)\n\
  \ help ()                 --- print this short help message\n\
  \Consult the README and NOTES files for further information.\n")
    val _ = Store.addhelp h
  in fun help _ = Store.help () end

  fun reset () = ( ElfFrontEnd.sig_clean () ;
                   Store.topenv := nil ;
                   Progtab.reset () )

  fun cd (dir) = Sys.cd (dir)
  fun ls (str) = Sys.ls (str)
  fun pwd () = print (Sys.cwd () ^ "\n")

  fun sload files = app Store.sload_one files

  fun dload files = app Store.dload_one files

  fun reload filename =
         if is_dynamic filename
            then dload [filename]
            else sload [filename]

  fun toc () =
        print (fold (fn ((filename,timestamp,Store.Static _),sofar)
                           => filename ^ " --- " ^ (makestring timestamp)
                              ^ " --- " ^ "static\n" ^ sofar
                      | ((filename,timestamp,Store.Dynamic _),sofar)
                           => filename ^ " --- " ^ (makestring timestamp)
                              ^ " --- " ^ "dynamic\n" ^ sofar)
                    (!Store.topenv) "")

  fun initload statics dynamics = 
      with_value warn_redeclaration
	  (!warn_redeclaration_initload orelse !warn_redeclaration)
	  (fn () => ( reset () ; sload statics ; dload dynamics ; toc () ))

  fun print_sig filename = Sign.sig_print (Store.find_sig filename)
  fun print_sig_full filename = Sign.sig_print_full (Store.find_sig filename)

  fun trace (level) =
      ( Solver.trace (level) ;
        Unify.Switch.trace "failure" := (level > 1) )
  fun untrace () = trace (0)

  fun chatter (level) =
      ( echo_declarations := (level > 1) ;
        show_dynamic := (level > 0) )

  structure U = Unify.Switch
  structure T = TypeRecon.Switch
  structure S = Solver.Switch

  fun save_elf (filename) =
         Sys.save_file(filename, version ^ ", saved on " ^ Sys.date())

end  (* functor Elf *)
