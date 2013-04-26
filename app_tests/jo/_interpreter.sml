(*
 *
 * $Log: _interpreter.sml,v $
 * Revision 1.2  1998/06/08 13:07:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	    Jo: A Concurrent Constraint Programming Language
		    (Programming for the 1990s)

			   Andrew Wilson
			19th November 1990

		   Serial Interpreter for Jo Toddler
			    the functor

Version of July 1996, modified to use Harlequin MLWorks separate 
compilation system.
*)

require "interpreter";
require "code";
require "scheduler";
require "dynamics";
require "arithmetic";
require "__lowlevel";


functor Interpreter(structure Code: CODE
                    structure Scheduler: SCHEDULER
                    structure Dynamics: DYNAMICS
                    structure Arithmetic: ARITHMETIC
                    sharing type Code.object = Scheduler.object
                        and type Code.constraint = Scheduler.constraint
                        and type Code.agent = Scheduler.agent
                        and type Code.clause = Scheduler.clause
                        and type Code.object = Dynamics.object
                        and type Code.constraint = Dynamics.constraint
                        and type Code.agent = Dynamics.agent
                        and type Dynamics.context = Scheduler.context
                        and type Dynamics.condition = Scheduler.condition
                        and type Dynamics.answer = Arithmetic.answer
                        and type Arithmetic.context = Dynamics.context
                        and type Arithmetic.constraint = Code.constraint
                        and type Arithmetic.condition = Scheduler.condition
                    ):INTERPRETER =
struct
  open Code
  open Scheduler
  open Dynamics

  exception ProgramFailed of int
  exception RunError of string

  val schedule = Scheduler.give


	(* COUNT: a simple function to count the length of a list *)

  fun count nil = 0
    | count(a::b) = 1+count(b)

  fun isNil nil = true
    | isNil _ = false

(****************************************************************************)
(***	PART ONE:	INTERPRETING JO 90 CONSTRAINTS 			  ***)
(****************************************************************************)

		(* ISFIXED:  a test for the "fixed(x)" constraint *)

    fun allFixed(nil) = true
      | allFixed(a::b) = isFixed(a) andalso allFixed(b)

    and isFixed(VOID) = true
      | isFixed(WILDCARD) = true
      | isFixed(UNKNOWN _) = false 
      | isFixed(POINTER(_,_,_,_,p)) = isFixed(!p)
      | isFixed(VARIABLE(_,_)) = false
      | isFixed(ATOMIC x) = true

      | isFixed(INFINITY) = true
      | isFixed(MINFINITY) = true
      | isFixed(NUMBER _) = true
      | isFixed(RANGE (a,b,c,d)) = (sameObjects(a,d) andalso b andalso c)
      | isFixed(PLUS(a,b)) = isFixed(a) andalso isFixed(b)
      | isFixed(MINUS(a,b)) = isFixed(a) andalso isFixed(b)
      | isFixed(TIMES(a,b)) = isFixed(a) andalso isFixed(b)
      | isFixed(DIVIDES(a,b)) = isFixed(a) andalso isFixed(b)

      | isFixed(HERBRAND(label,kids,rest)) = isFixed(label) andalso
					     isFixed(rest) andalso
					     allFixed(kids)		
      | isFixed _ = raise Fail "Impossible Case 7"

		(* ISKNOWN: a test for the "known(x)" constraint *)

    val isKnown = fn X =>
	  case X of 
	      UNKNOWN _ => false
	    | VARIABLE _ => false
	    | PARAMETER _ => false
	    | _ => true


    fun succ(ref(false)) = ()
      | succ(ref(true)) = print "---Success\n"

    fun fail(ref(false)) = ()
      | fail(ref(true)) = print "---Failure\n"


(******************** HERBRAND CONSTRAINT SYSTEM *************************)



	(* MATCH: very important function.  This takes two   *)
 	(* objects, and matches them, returning a triple:    *)
	(* a flag indicating success (or not), and a list of *)
	(* variables and values, which if instantiated would *)
	(* give strict equality.			     *)
	(* used when checking equality, consistency and even *)
	(* publishing constraints.			     *)


	fun match(o1,o2,cntxt) =
	 let



		(* FIRST: some preliminary definitions, to facilitate*)
		(* a global (within the scope of match) variable to  *)
		(* hold the substitutions made to date.		     *)

	   exception NoMatch	(* quit as soon as possible *)

	   val unifier = ref([]) : (object * object ref) list ref

	   fun getSubstitution(var) =
		let
		    fun s(nil) = ref (UNKNOWN 0)
		      | s((a,v)::b) = if sameObjects(a,var) then v else s(b)
		 in
		     s(!unifier)
		end

	   fun substitute(var,value) =
		let val substn = getSubstitution(var)
	      	 in if sameObjects(!substn,UNKNOWN 0)
		    then (substn:=value;
			  unifier:=((var,substn)::(!unifier)))
		    else substn:=value
	        end




	(*SECOND: the actual matcher itself.  This consists *)
	(* of recursive functions.			    *)


		(*EQUAL: matches variable values. This includes*)
		(* pointers to other variables.		       *)


	   fun equal(VOID,VOID,_) = ()
	     | equal(UNKNOWN x,UNKNOWN y,_) = if x=y then () else raise NoMatch
	     | equal(WILDCARD,_,_) = ()
	     | equal(_,WILDCARD,_) = ()
	     | equal(ATOMIC x,ATOMIC y,_) = if x=y then () else raise NoMatch
	     | equal(HERBRAND(l,k,r),HERBRAND(l',k',r'),cntxt) =
			matchTrees(l,k,r,l',k',r',cntxt)

	     | equal(p as POINTER(name,num,trace,sn,x),y,cntxt) = 
			if sameObjects(p,y) then () else
			if isUnknown(!x) then substitute(p,y)
				         else equal(!x,y,cntxt)

	     | equal(x,p as POINTER(name,num,trace,sn,y),cntxt) = 
			if sameObjects(x,p) then () else
			if isUnknown(!y) then substitute(p,x)
					 else equal(x,!y,cntxt)
			 

	     | equal(x,y,cntxt) = 
		 (if isNumber(x) orelse isNumber(y)
		 then case Arithmetic.evalPrimitive(eq(x,y),cntxt)
			of yes => ()
			 | no => raise NoMatch
			 | maybe(c) => raise NoMatch
		 else raise NoMatch)
		 handle Arithmetic.ArithError => raise NoMatch









	   and matchList(nil,nil,_) = ()
	     | matchList(a::b,c::d,cntxt) = (matcher(a,c,cntxt);
					     matchList(b,d,cntxt))
             | matchList _ = raise Fail "Impossible case 8"




		(* MATCHER: matches one object to another.  It is *)
		(* here that variables are dealt with.  Note that *)
		(* if a variable occurs twice in a pattern, then  *)
		(* by the second time, it will have a constraint  *)
		(* in the substitution.  This substitution will   *)
		(* contain `more information' in it than in the   *)
		(* context, since we will have used the context   *)
		(* the first time, and have not added to the      *)
		(* in the meantime.				  *)


	   and matcher(var1 as VARIABLE(x,xn),
		       var2 as VARIABLE(y,yn), cntxt) =

		let
		  fun varsEqual(ref(POINTER(_,_,_,_,x)),y) = varsEqual(x,y)
		    | varsEqual(x,ref(POINTER(_,_,_,_,y))) = varsEqual(x,y)
	   	    | varsEqual(ref x,ref y) = sameObjects(x,y)

		  val vr1 = makePtr(var1,cntxt)
		  val v1 = getSubstitution(vr1)
		  val c1 = valOf(cntxt,xn)
		  val v1' = if isUnknown(!v1) then c1 else v1

		  val vr2 = makePtr(var2,cntxt)
		  val v2 = getSubstitution(vr2)
 		  val c2 = valOf(cntxt,yn)
		  val v2' = if isUnknown(!v2) then c2 else v2

                 in
		    if varsEqual(v1',v2') then () else
		      case (stripPtr(!v1'),stripPtr(!v2')) of
		        (UNKNOWN _,UNKNOWN _)=>(substitute(vr1,vr2))
		      | (UNKNOWN _,Y) => substitute(vr1,vr2)
		      | (X,UNKNOWN _) => substitute(vr2,vr1)
		      | (X,Y) => equal(X,Y,cntxt)
		end



           | matcher(var1 as VARIABLE(x,xn),
		     var2 as PARAMETER(y,yn),cntxt) =
   	        let
                  val vr1 = makePtr(var1,cntxt)
		  val v1 = getSubstitution(vr1)
		  val c1 = valOf(cntxt,xn)
		  val v1' = if isUnknown(!v1) then c1 else v1

	          val v2' = getSubstitution(var2)
	         in
		  case stripPtr(!v2') of
		      UNKNOWN _=> substitute(var2,vr1)
		    | Y => equal(stripPtr(!v1'),Y,cntxt)
		end



	   | matcher(var1 as VARIABLE(x,xn),Y,cntxt) =
		let
		  val vr1 = makePtr(var1,cntxt)
		  val v1 = getSubstitution(vr1)
		  val c1 = valOf(cntxt,xn)
		  val v1' = if isUnknown(!v1) then c1 else v1
		 in
		   if isUnknown(stripPtr(!v1'))
			then substitute(vr1,Y)
                        else equal(!v1',Y,cntxt)
		end




	   | matcher(X,var2 as VARIABLE(y,yn),cntxt) =
		let
		  val vr2 = makePtr(var2,cntxt)
		  val v2 = getSubstitution(vr2)
		  val c2 = valOf(cntxt,yn)
		  val v2' = if isUnknown(!v2) then c2 else v2
		 in
		   if isUnknown(stripPtr(!v2'))
			then substitute(vr2,X)
			else equal(X,!v2',cntxt)
		end




           | matcher(var1 as PARAMETER(x,xn),Y,cntxt) =
		let
		  val v1' = getSubstitution(var1)
		  val Y' = instantiate(Y,cntxt)
		 in
		  if isUnknown(stripPtr(!v1')) then substitute(var1,Y')
					       else equal(!v1',Y',cntxt)
		end





           | matcher(X,var2 as PARAMETER(y,yn),cntxt) =
		let
		  val v2' = getSubstitution(var2)
		  val X' = instantiate(X,cntxt)
		 in
		  if isUnknown(stripPtr(!v2')) then substitute(var2,X')
					       else equal(X',!v2',cntxt)
		end


	   | matcher(x,y,cntxt) = equal(x,y,cntxt)








		(* NOW: a function to match two trees.    *)
		(* difficulty arises in matching the ends *)
		(* of trees.				  *)

	 and matchTrees(l,k,r,l',k',r',cntxt) =
	     (matcher(l,l',cntxt);
	      let
		 fun matchKids(l,a::b,r,a'::b',r',cntxt) =
		     		(matcher(a,a',cntxt);
		     		 matchKids(l,b,r,b',r',cntxt))
		   | matchKids(_,nil,r,nil,r',cntxt) = matcher(r,r',cntxt)
		   | matchKids(l,a,r,nil,r',cntxt) =
			       matcher(HERBRAND(l,a,r),r',cntxt)
		   | matchKids(l,nil,r,a',r',cntxt) =
			       matcher(r,HERBRAND(l,a',r'),cntxt)
	       in
		 matchKids(l,k,r,k',r',cntxt)
	      end)



		(*DEPAIRLIST: take a list of pairs (substitutions) *)
		(* and split them into two lists: vars and vals.  *)


	fun dePairList(nil)=(nil,nil)
	  | dePairList((x,y)::b) = let val (p,q) = dePairList(b)
				    in (x::p,y::q)
				   end



     in
	(unifier:=[];
         matcher(o1,o2,cntxt);
	 let val (p,q) = dePairList(!unifier)
	  in (true,p,q)
	 end)
        handle NoMatch => (false,nil,nil)
    end
	




      (******************* PARAMETER HANDLING *************************)
	(*Parameters need careful handling:  After matching a clause   *)
	(*head, they need to be kept in proper order: parameter number *)
	(*ascending from 0.  Handy for when they are put into a context*)
	(*of their own, should the procedure ever be called.	       *)

		(*SORT: for sorting the list of parameters after it *)
		(* is first made.				    *)
		(*  Insertion sort is used: which is good, because  *)
		(* we may need to insert values later.		    *)

	   fun insertP(pvar,pval,nil,nil) = ([pvar],[pval])
	     | insertP(p as PARAMETER(x,xn),pval,
		       (q as PARAMETER(y,yn))::qrest,
		       qv::vals) =
		  if xn<yn then (p::q::qrest,pval::qv::vals)  else
		  if xn>yn then 
			let
			   val (qrest',vals') = insertP(p,pval,qrest,vals)
			 in
			   (q::qrest',qv::vals')
			end
		  else (q::qrest,qv::vals)
              | insertP _ = raise Fail "Impossible case 9"


	  fun sortP(nil,nil) = (nil,nil)
	    | sortP(a::b,c::d) = 
		let
		   val (b',d') = sortP(b,d)
		 in
		   insertP(a,c,b',d')
		end
             | sortP _ = raise Fail "Impossible case 10"


	  fun insertPs(nil,nil,a,b) = (a,b)
	    | insertPs(a::b,c::d,e,f) =
		let
		   val (e',f') = insertP(a,c,e,f)
		 in
		   insertPs(b,d,e',f')
		end

            | insertPs _ = raise Fail "Impossible case 11"






		(* SPLIT: takes as argument the vars/vals *)
		(* result from matcher, and splits them   *)
		(* into two (i.e., avars,avals,pvars,pvals*)
		(* removing parameters from unifier lists.*)


    fun split(nil,nil) = ((nil,nil),(nil,nil))
      | split((v as POINTER _)::vars,v'::vals) = 
		let val ((a,b),(c,d)) = split(vars,vals)
		 in ((v::a,v'::b),(c,d))
		end
      | split(v::vars,v'::vals) = 
		let val ((a,b),(c,d)) = split(vars,vals)
		 in ((a,b),(v::c,v'::d))
		end

      | split _ = raise Fail "Impossible case 12"




    (********************** UNIFICATION **************************)


		(* UNIFY: take the output from MATCH, and *)
		(* unify the two lists, thereby publishing *)
		(* the information.			 *)
		(* Note that hidden, internal variables  *)
		(* are not instantiated. *)



    fun unify(nil,nil,_,_) = ()
      | unify(POINTER(nam,num,_,sn,value)::vars, vlue::vals,cntxt,trace) =
	  let
	     fun set(var,value,tr) =
		  case !var of
		      UNKNOWN _ => Dynamics.setVal(var,value,tr,cntxt)
		   | POINTER(_,_,_,_,p) => set(p,value,tr)
		   | _ => ()
	   in
	      (set(value,instantiate(!vlue,cntxt),trace);
	       awake(!sn);
	       sn:= ~1;
	       unify(vars,vals,cntxt,trace))
	  end

      | unify(_::vars,_::vals,cntxt,trace) = unify(vars,vals,cntxt,trace)

      | unify _ = raise Fail "Impossible case 13"



(************* CONSTRAINT EVALUATION 1: WAKENED PROCESSES ********************)


		(* CHECK_VARS: upon awakening a process, *)
		(* it is necessary to check to see if    *)
		(* all of the previously uninstantiated  *)
		(* variables have been instantiated, and *)
		(* if so, if they match what is required *)
		(* by the suspending process.  Note that *)
		(* only strict equality suspends ---     *)
		(* hence if they don't match: failure.   *)

    exception UnInstantiated of object list * object ref list
			      * object list * object ref list


    fun checkVars(negated,vars,vals,cntxt) =
       let
	   fun expandPtrs(nil) = nil
	     | expandPtrs(a::b) = (!a)::expandPtrs(b)


	   fun cv(negated,vars,vals,cntxt) =
	       let
		   val (ok,vars',vals') = 
			match(HERBRAND(WILDCARD,vars,VOID),
			      HERBRAND(WILDCARD,expandPtrs(vals),VOID),
			      cntxt)

		   val ((avars,avals),(pvars,pvals)) = split(vars',vals')
		in
		   if not ok then 
			if negated then (pvars,pvals)
			           else raise ProgramFailed(456)
		   else if negated then raise ProgramFailed(457)
		   else if isNil(avars) then (pvars,pvals)
		   else raise UnInstantiated(avars,avals,pvars,pvals)
	       end

       in
	  cv(negated,vars,vals,cntxt)
      end

 





(************** CONSTRAINT EVALUATION 2: INITIAL EVALUATION ******************)




  local

       fun evalPrimitive(eq(o1,o2),cntxt) =
	   if isNumber(instantiate(o1,cntxt)) orelse 
              isNumber(instantiate(o2,cntxt)) 
           then 
	         Arithmetic.evalPrimitive(eq(o1,o2),cntxt)
	         handle Arithmetic.ArithError => no
	   else
	   let
	      val (ok,vars,vals) = match(o1,o2,cntxt)
  	    in
 	      if not ok then no
	      else
	        case vars of
	            nil  => yes
	          | POINTER(_,_,_,sn,_)::_ => maybe(varsEq(false,vars,vals))
	          | _ => no
	   end



         | evalPrimitive(fixed(VARIABLE(x,num)),cntxt) =
	      if isFixed(!(valOf(cntxt,num)))  then yes
	      else maybe(waitFixed([VARIABLE(x,num)],none))


         | evalPrimitive(known(VARIABLE(_,num)),cntxt) =
	      if isKnown(!(valOf(cntxt,num))) then yes else no


	 | evalPrimitive(greater(e,o1,o2),cntxt) =
	      (Arithmetic.evalPrimitive(greater(e,o1,o2),cntxt)
	        handle Arithmetic.ArithError => no)
              
	 | evalPrimitive(less(e,o1,o2),cntxt) =
	      (Arithmetic.evalPrimitive(less(e,o1,o2),cntxt)
	        handle Arithmetic.ArithError => no)

         | evalPrimitive(tt,_) = yes
         | evalPrimitive(ff,_) = no
         | evalPrimitive(none,cntxt) = yes

	 | evalPrimitive _ = no		(* for completeness *)


   in

       fun evalConstraint(neg(neg(c)),cntxt) = evalConstraint(c,cntxt)
	 | evalConstraint(consistent(consistent(c)),cntxt) = 
			evalConstraint(consistent(c),cntxt)
	 | evalConstraint(neg(c),cntxt) = 
	     (case evalConstraint(c,cntxt)
		of yes => no
		 | no => yes
		 | maybe(c) => maybe(negate(c))
	     )

	 | evalConstraint(consistent(c),cntxt) = 
	     (case evalConstraint(c,cntxt)
		of yes => yes
		 | no => no
		 | maybe _ => yes
	     )

	 | evalConstraint(c,cntxt) = evalPrimitive(c,cntxt)

   end







(***************** TESTING SUSPENSION CONDITIONS ************************)


  fun sieveFixed(nil,_) = nil
    | sieveFixed(a::b,cntxt) =
	if isFixed(instantiate(a,cntxt))
	then sieveFixed(b,cntxt)
	else a::sieveFixed(b,cntxt)





   fun testCondition(varsEq(negated,vars,vals),cntxt)=
	((ignore(checkVars(negated,vars,vals,cntxt)); yes)
	   handle ProgramFailed _ => no
		| UnInstantiated(a,b,_,_) => maybe(varsEq(negated,a,b))
	)





     | testCondition(allButOneFixed(vars,constr),cntxt) = yes

		(* intermediate condition to signify arith_wait *)
		(* so never actually tested as a procedure guard*)



     | testCondition(waitFixed(vars,constr),cntxt) =
       let
	  val vars' = sieveFixed(vars,cntxt)
	in
	  if count(vars')>0 then maybe(waitFixed(vars',constr))
			    else evalConstraint(constr,cntxt)
       end




			(* The last two are really suspending 'til a *)
			(* variable has been updated.  		     *)

     | testCondition(oneOf(vars,redundant,constr),cntxt) =
	if !redundant then yes
	else (redundant:=true; evalConstraint(constr,cntxt))

     | testCondition(rangeNarrowed(var,constr),cntxt) =
	  evalConstraint(constr,cntxt)





(****************************************************************************)
(***	PART TWO:	PROCEDURAL ASPECTS OF JO 90			  ***)
(****************************************************************************)




		(* SUSPEND_ON_COND: take a condition, and *)
		(* then suspend on an appropriate variable*)


	fun suspendOnCond(varsEq(_,POINTER(_,_,_,n,_)::_,_),p,_) =
	    	n:=suspend(p,!n)

	  | suspendOnCond(waitFixed(VARIABLE(_,n)::_,_),p,cntxt) =
		let
		   val m = suspensionNumber(cntxt,n)
		 in
		   m:=suspend(p,!m)
		end

	  | suspendOnCond(waitFixed(POINTER(_,_,_,m,_)::_,_),p,cntxt) =
		   m:=suspend(p,!m)


	  | suspendOnCond(rangeNarrowed(POINTER(_,_,_,m,_),_),p,cntxt) =
		  m:=suspend(p,!m)

	  | suspendOnCond(rangeNarrowed(VARIABLE(_,n),_),p,cntxt) =
		let
	  	   val m = suspensionNumber(cntxt,n)
		 in
		   m:=suspend(p,!m)
		end


          | suspendOnCond(allButOneFixed(fv,_),p,cntxt) =
	        let
		    fun suspendAll(nil,_,_) = ()
		      | suspendAll(VARIABLE(x,xn)::vars,
				    arithWait(_,a,t,b,c),cntxt) =
			  let 
			      val n = suspensionNumber(cntxt,xn)
			   in (n:=suspend(arithWait(VARIABLE(x,xn),a,t,b,c),
				!n);
			        suspendAll(vars,p,cntxt))
			  end

		      | suspendAll(POINTER(a,b,t,n,d)::vars,
				    arithWait(_,w,x,y,z),cntxt) =
			 (n:=suspend(arithWait(POINTER(a,b,t,n,d),w,x,y,z),
				     !n);
			  suspendAll(vars,p,cntxt))

		      | suspendAll _ = ()
		  in
		    suspendAll(fv,p,cntxt)
		end



          | suspendOnCond _ = raise Fail "Impossible case 14"

		(* EVALUATE: evaluate a constraint, and then *)
		(* proceed if success.  Suspend if variable  *)
		(* values are not known.		     *)

       fun evalSelect(c,a,cntxt,trace) =
	   case evalConstraint(c,cntxt)
   	     of yes => (succ(trace);schedule(exec(a,cntxt,trace)))
	      | no => (fail(trace);())
	      | maybe(c) => suspendOnCond(c,selection(c,cntxt,a,trace),cntxt)

       fun evalGuard(c,a,cntxt,trace) =
	   case evalConstraint(c,cntxt)
   	     of yes => (succ(trace);schedule(exec(a,cntxt,trace)))
	      | no => (fail(trace);raise ProgramFailed(9999))
	      | maybe(c) => suspendOnCond(c,guarded(c,cntxt,a,trace),cntxt)





	(* EVAL_ALT: evaluate guarded alternative.  If the guard    *)
	(* succeeds, then set the aternation switch to true,        *)
	(* thereby disabling other alternatives.  Then one executes *)
        (* the guarded agent.					    *)
	(* It may happen that the guard is a strict equality.  This *)
	(* cannot be evaluated until all variables in the guard are *)
        (* evaluated.  Hence the entire guard must be suspended.    *)

       fun evalAlt(c,cntxt,a,switch,counter,trace) =
	   case evalConstraint(c,cntxt)
	     of yes =>  (switch:=true; succ(trace); 
			 schedule(exec(a,cntxt,trace)))
	      | no =>   (fail(trace);
			 if !counter=1 then ()
			   	       else counter:= !counter -1)
  	      | maybe(d) => 
		   suspendOnCond(d,altGuard(switch,counter,d,cntxt,a,trace),
				     cntxt)










		(* STARTUP: set up a new context, carrying through *)
		(* all the relevant information to the new proc.   *)

    fun startUp(args,numVars,body,cntxt,trace) =
	let
	   val newCntxt = buildCntxt(args,numVars,cntxt,trace)
	 in
	   schedule(exec(body,newCntxt,trace))
	end












	(* EVAL_CALL: evaluate the possibility of matching a proc   *)
	(* call with a particular clause definition.  		    *)
	(* The actual form of matching is similar to asktell:  first*)
	(* check that structures match, (suspending if necessary)   *)
	(* and then tell the values of the parameters to the proc.  *)


   fun evalCall(name,switch,count,args,params,numVars,body,cntxt,trace)=
       let

	   val (ok,vars,vals) = match(HERBRAND(WILDCARD,args,VOID),
				      HERBRAND(WILDCARD,params,VOID),cntxt)

	   val ((avars,avals),(pvars,pvals)) = split(vars,vals)
	   val (pvars',pvals') = sortP(pvars,pvals)
	in
	   if ok then
		case avars of
		    nil => (switch:=true;
			    startUp(pvals',numVars,body,cntxt,trace))

		| POINTER(_,_,_,sn,_)::_ =>
			sn:=suspend(procGuard(name,switch,count,avars,avals,
					       pvars',pvals',
					       numVars,cntxt,body,trace),
			            !sn)

		| _ => (fail(trace); raise ProgramFailed(18))
           else (fail(trace);
		 if (!count)=1 then raise ProgramFailed(19)
			      else count:= (!count) -1)
     end












		(* SPAWN:  take an and-parallel agent, and   *)
		(* split it up into its component processes. *)

    fun spawn(a::b,cntxt,trace) = 
		(schedule(exec(a,cntxt,ref(!trace)));
		 spawn(b,cntxt,trace))
      | spawn(nil,_,_)      = ()









		(* CHOOSE: take an ALT statement and split it *)
		(* up into its component alternatives, 	      *)
		(* remembering the all-important switch, to   *)
		(* ensure that only one process actually      *)
		(* proceeds.				      *)


    fun choose(alternatives,cntxt,trace) = 
	let
	   fun count(nil) = 0
	     | count(_::b) = 1+count(b)

	   val switch = ref false       (* set to true when one succeeds *)
	   val counter = ref (count alternatives)
    
	   fun altSpawn(nil,_) =()
	     | altSpawn(a::b,cntxt) = 
		   (schedule(alternative(switch,counter,a,cntxt,ref(!trace))); 
		    altSpawn(b,cntxt))
        in
          altSpawn(alternatives,cntxt)
	end












		(* PUBLISH:  basically, tell a constraint.   *)

    fun publish(none,_,_) = ()
      | publish(tt,_,_) = ()
      | publish(ff,_,_) = raise ProgramFailed 98
      | publish(eq(o1,o2),cntxt,trace) =
	if isNumber(instantiate(o1,cntxt)) orelse 
           isNumber(instantiate(o2,cntxt))

						(* ARITHMETIC *)
	then 
	  (case Arithmetic.publish(eq(o1,o2),cntxt,trace)
	     of yes => (succ(trace))
	      | no => (fail(trace); raise ProgramFailed(34))
	      | maybe(c as allButOneFixed(fv,cond)) 
		     => suspendOnCond(c,arithWait(VOID,ref(fv),
						     cond,cntxt,trace),
					cntxt)
	      | maybe _ => (fail(trace); raise ProgramFailed(35))
	  )
	  handle Arithmetic.ArithError => 
		  raise RunError("Type Mismatch or Polynomial in free var.\n")



	else				(*HERBRAND*)
             let
	         val (ok,vars,vals) = match(o1,o2,cntxt)
	      in
	          if ok then unify(vars,vals,cntxt,trace)
		        else (fail(trace); raise ProgramFailed(20))
	     end





      | publish(greater(b,o1,o2),cntxt,trace) = 
	((case Arithmetic.publish(greater(b,o1,o2),cntxt,trace)
	   of yes => (succ(trace))
	    | no => (fail(trace); raise ProgramFailed(34))
	    | maybe(c as allButOneFixed(fv,cond)) 
		 => suspendOnCond(c,
				    arithWait(VOID,ref(fv),cond,cntxt,trace),
				    cntxt)
	    | maybe _ => (fail(trace); raise ProgramFailed(35))
	 )
	 handle Arithmetic.ArithError => 
		raise RunError("Type Mismatch or Polynomial in free var.\n")
        )





      | publish(less(b,o1,o2),cntxt,trace) = 
	((case Arithmetic.publish(less(b,o1,o2),cntxt,trace)
	   of yes => (succ(trace))
	    | no => (fail(trace); raise ProgramFailed(34))
	    | maybe(c as allButOneFixed(fv,cond)) 
		 => suspendOnCond(c,
				    arithWait(VOID,ref(fv),cond,cntxt,trace),
				    cntxt)
	    | maybe _ => (fail(trace); raise ProgramFailed(35))
         )
	 handle Arithmetic.ArithError => 
		raise RunError("Type Mismatch or Polynomial in free var.\n")
	)




      | publish(consistent(_),_,_) =
	           raise RunError("You can't publish consistency.\n")
      | publish(fixed(_),_,_) =
		   raise RunError("You can't publish ask-if-fixed. \n")
      | publish(known(_),_,_) =
		   raise RunError("You can't publish ask-if-known. \n")
      | publish(neg(_),_,_) =
		   raise RunError("You can't publish a negative. \n")







       (****************  SIDE-EFFECTING PREDICATES ********************)
       
          (* WRITE/1: write argument to screen. *)
          (* Suspend 'til arg fixed.            *)  

       fun toScreen([arg],cntxt,trace)=
           let
              val a=instantiate(arg,cntxt)
            in
                case a of
                  ATOMIC x => 
                  let
                      fun printChars(nil)=()
                        | printChars(#"!":: #"n"::X)=
                             (print "\n";printChars(X))
                        | printChars(a::X) = (print (str a); 
                                             printChars(X))
                   in
                      printChars(explode x)  
                  end
                | POINTER(_,_,_,_,ref(UNKNOWN _))
                     => suspendOnCond(waitFixed([arg],none),
                                      exec(call("write/1",[arg]),cntxt,trace),
                                      cntxt)
                | X => raise RunError("Can only print atoms to screen.\n")
            end

         | toScreen(_,_,_)=()




                 (* READ/1: read in a character *)
                 (* from keyboard as an atom.   *)
              

       fun fromKeyboard([arg],cntxt,trace)=
           let
              val a=instantiate(arg,cntxt)
            in
                case a of
                  POINTER(_,_,_,_,p as ref(UNKNOWN _))
                     => let
                           val ch=inputN(stdIn,1)
                           val x=if ch="\n" then ATOMIC "!n"
                                            else ATOMIC ch
                         in
                           Dynamics.setVal(p,x,trace,cntxt)
                        end
                | X => raise RunError("Can only read into a variable.\n")
           end
         | fromKeyboard(_,_,_)=()

   

	
                  (* Atomize/2: convert an atom into a list of *)
                  (* characters.                               *)

       fun stringToChars([arg1,arg2],cntxt,trace)=
           let
              val a1=instantiate(arg1,cntxt)
              val a2=instantiate(arg2,cntxt)
            in
              case a2 of
                POINTER(_,_,_,_,p as ref(UNKNOWN _)) =>
                 (case a1 of
                    ATOMIC x => Dynamics.setVal(p,
                                   HERBRAND(ATOMIC "string",
                                     map (fn x => ATOMIC (str x)) 
                                            (explode x),VOID),
                                     trace,cntxt)

                  | POINTER(_,_,_,_,ref(UNKNOWN _))
                     => suspendOnCond(waitFixed([arg1],none),
			      exec(call("atomize/2",[arg1,arg2]),cntxt,trace),
                              cntxt)

                  | X => raise RunError("Can only atomize atoms.\n")
                 )

              | X => raise RunError("Can only write to a variable.\n")
           end

         | stringToChars(_,_,_)=()




              (* build/2: convert a list of characters to an atom *)

       fun charsToString([arg1,arg2],cntxt,trace)=
           let
              val a1=instantiate(arg1,cntxt)
              val a2=instantiate(arg2,cntxt)
            in
              case a2 of
                POINTER(_,_,_,_,p as ref(UNKNOWN _)) =>
                 (case a1 of
                    HERBRAND(ATOMIC "string", X, Y) =>
                      let
                         fun getKids(HERBRAND(_,X,Y))= 
                              (map (fn ATOMIC(x) => x
                                     | _ => raise Fail "Impossible case 15") X)
                              @(getKids(Y))
                           | getKids _ = []
                       in
                         Dynamics.setVal(p,
                                         ATOMIC(concat((getKids(a1)))),
                                         trace,cntxt)
                      end

                  | POINTER(_,_,_,_,ref(UNKNOWN _))
                     => suspendOnCond(waitFixed([arg1],none),
			      exec(call("build/2",[arg1,arg2]),cntxt,trace),
                              cntxt)

                  | X => raise RunError("Can only build atoms.\n")
                 )

              | X => raise RunError("Can only write to a variable.\n")
           end
         | charsToString(_,_,_)=()




		(*NEWPROC: get the defining clauses for *)
		(* a new procedure, and then spawn off  *)
		(* the list of alternative clauses.     *)
		(* These will be checked later.		*)

    fun newProc(name,args,cntxt,trace)=
        case name of
          "write/1" => toScreen(args,cntxt,trace)
        | "read/1" => fromKeyboard(args,cntxt,trace)
        | "atomize/2" => stringToChars(args,cntxt,trace)
        | "build/2" => charsToString(args,cntxt,trace)
        | X =>
        let
	   fun count nil = 0
	     | count (a::b) = 1 + count(b)

	   val definitions = retrieve(name)
	   val switch = ref false
	   val counter = ref (count definitions)

	   fun procSpawn nil = ()
	     | procSpawn (clause(_,params,numVars,_,body)::rest) =
		(schedule(procAlt(name,switch,counter,args,params,
				    numVars,body,cntxt,trace));
	         procSpawn(rest)
		)
        in
           procSpawn(definitions)
	end
	   






		(*EXECUTE: execute a given process. *)

    fun execute(alternative(ref(true),_,_,_,_)) = ()
      | execute(alternative(swtch,count,guard(c,a),cntxt,trace)) = 
			evalAlt(c,cntxt,a,swtch,count,trace)

      | execute(alternative(switch,count,a,cntxt,trace))  =
		 (switch:=true; schedule(exec(a,cntxt,trace)))





      | execute(procAlt(name,switch,count,args,params,
			 numVars,body,cntxt,trace)) =

	  if !switch then ()
	  else
		evalCall(name,switch,count,args,params,
			  numVars,body,cntxt,trace)


 

      | execute(guarded(cond,cntxt,a,trace)) = 
	  (case testCondition(cond,cntxt)
	     of yes => (succ(trace); schedule(exec(a,cntxt,trace)))
	      | no => (fail(trace); raise ProgramFailed 91)
	      | maybe(c) => suspendOnCond(c,guarded(c,cntxt,a,trace),cntxt)
          )


      | execute(selection(cond,cntxt,a,trace)) = 
	  (case testCondition(cond,cntxt)
	     of yes => (succ(trace); schedule(exec(a,cntxt,trace)))
	      | no => (fail(trace); ())
	      | maybe(c) => suspendOnCond(c,selection(c,cntxt,a,trace),cntxt)
          )



      | execute(altGuard(switch,count,cond,cntxt,a,trace)) = 
	 if !switch then () 
	 else 
	   (case testCondition(cond,cntxt)
	      of yes => (succ(trace); switch:=true; 
			 schedule(exec(a,cntxt,trace)))
	       | no => (fail(trace);if !count=1 then raise ProgramFailed 90
			                        else count:=(!count-1))
	       | maybe(c) =>
		   suspendOnCond(c,
			           altGuard(switch,count,c,cntxt,a,trace),
				   cntxt)
	   )



      | execute(procGuard(name,switch,count,avars,avals,pvars,pvals,numVars,
			   cntxt,body,trace)) =
	 if !switch then () else
	 (let
	     val (newPVars,newPVals) = checkVars(false,avars,avals,cntxt)
	     val (pvars',pvals') = insertPs(newPVars,newPVals,pvars,pvals)
	   in
	     (switch:=true;
	      succ(trace);
	      startUp(pvals',numVars,body,cntxt,trace))
	  end
          handle 
	    ProgramFailed x 
	    => (fail(trace);
		if !count=1 then raise ProgramFailed x else count:=(!count)-1)
     
          | UnInstantiated(vars' as POINTER(_,_,_,sn,_)::_,vals',npvrs,npvls)
	    => let val (pvars',pvals') = insertPs(npvrs,npvls,pvars,pvals)
	        in
		  sn:=suspend(procGuard(name,switch,count,vars',vals',
					 pvars',pvals',
			                 numVars,cntxt,body,trace), !sn)
	        end
         )



      | execute(arithWait(var,vars,constr,cntxt,trace)) =
	  let
	    fun remove(_,nil) = nil
	      | remove(a,b::c) = if sameObjects(a,b) then remove(a,c) else b::remove(a,c)
         
	   in
	      if isFixed(instantiate(var,cntxt))
	      then
		 (vars:=remove(var,!vars);
	          case !vars
	            of nil => ()
		     | VARIABLE(x,xn)::nil
		         => (publish(constr,cntxt,trace); 
			     awake(!(suspensionNumber(cntxt,xn))))

		     | POINTER(_,_,_,n,_)::nil
		         => (publish(constr,cntxt,trace); 
			     awake(!n))
		     | _ => ()		(* wait 'til other vars woken *)
		 )
	      else 			(* resuspend on the variable *)
		   case var
		     of VARIABLE(x,xn) 
			   => let val n = suspensionNumber(cntxt,xn)
			      in n:=suspend(arithWait(var,vars,constr,
						       cntxt,trace),
					    !n)
			      end
		      | POINTER(_,_,_,n,_)
			   => n:=suspend(arithWait(var,vars,constr,
						    cntxt,trace),
					 !n)
		      | _ => ()
	  end



      | execute(exec(success,_,_))             = ()
      | execute(exec(failure,_,_))             = raise ProgramFailed(100)
      | execute(exec(par PARlist,cntxt,trace)) = spawn(PARlist,cntxt,trace)
      | execute(exec(alt ALTlist,cntxt,trace)) = choose(ALTlist,cntxt,trace)
      | execute(exec(guard(c,a),cntxt,trace))  = evalGuard(c,a,cntxt,trace)
      | execute(exec(select(c,a),cntxt,trace)) = evalSelect(c,a,cntxt,trace)
      | execute(exec(tell(c),cntxt,trace))   = publish(c,cntxt,trace)
      | execute(exec(call(name,args),cntxt,trace)) 
			= newProc(name,args,cntxt,trace)



   fun interpret() =  (while true do execute(Scheduler.take());   ())

end

