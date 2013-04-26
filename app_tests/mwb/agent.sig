(*
 *
 * $Log: agent.sig,v $
 * Revision 1.2  1998/06/11 13:35:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature AGENT =
sig
   structure T : TEST
   structure E : ENV
   structure Act : ACTION


   type agent

   type env

   exception WrongArgs of string


   val mkstr : agent -> string
   val makstr : agent * (string list) -> string
   val eq : agent * agent -> bool
   val hashval : agent -> int

   val mk_nil : unit -> agent
   val mk_prefix : Act.action * agent -> agent
   val mk_match : T.test * agent -> agent
   val mk_conditional : T.test * agent * agent -> agent
   val mk_sum : agent list -> agent
   val mk_parallel : agent list -> agent
   val mk_abstraction : Act.N.name * agent -> agent
   val mk_concretion : Act.N.name * agent -> agent
   val mk_restriction : Act.N.name * agent -> agent
   val mk_identifier : string -> agent
   val mk_application : agent * Act.N.name -> agent

   val is_nil : agent * env -> bool
   val is_prefix : agent * env -> bool
   val is_match : agent * env -> bool
   val is_conditional : agent * env -> bool
   val is_sum : agent * env -> bool
   val is_parallel : agent * env -> bool
   val is_restriction : agent * env -> bool
   val is_identifier : agent * env -> bool
   val is_application : agent * env -> bool
   val is_abstraction : agent * env -> bool (* arity >= 0 *)
   val is_concretion : agent * env -> bool (* arity <= 0 *)
   val is_process : agent * env -> bool	(* arity = 0 *)

   val prefix_act : agent * env -> Act.action
   val prefix_agent : agent * env -> agent
   val match_test : agent * env -> T.test
   val match_positive : agent * env -> agent
   val conditional_test : agent * env -> T.test
   val conditional_positive : agent * env -> agent
   val conditional_negative : agent * env -> agent
   val sum_summands : agent * env -> agent list
   val parallel_pars : agent * env -> agent list
   val application_arg : agent * env -> Act.N.name
   val application_args : agent * env -> Act.N.name list
   val application_abstr : agent * env -> agent
   val application_abstrs : agent * env -> agent (* innermost *)
   val restriction_agent : agent * env -> agent
   val restriction_right : agent * Act.N.name * env -> agent
   val abstraction_agent : agent * env -> agent
   val abstraction_right : agent * Act.N.name * env -> agent
   val concretion_name : agent * env -> Act.N.name
   val concretion_agent : agent * env -> agent

   val arity : agent * env -> int

   val pseudo_apply: agent * agent * env -> agent

   (* returns a list of the free names in an agent *)
   val free_names : agent -> T.N.name list
   val names : agent * env -> T.N.name list

   val apply : agent * (T.N.name list) * env -> agent
   val beta_reduce : agent -> (T.N.name list * int) -> agent
   val std_form : agent * env -> agent

   val substitute : (T.N.name * T.N.name) list * agent -> agent

   (* for debug? *)
   val abs_body : agent * int * env -> agent
   val abs_all : agent * env -> (int * agent)
   val conc_all : agent * env -> (int * T.N.name list * agent)

   val identifier_def : agent * env -> agent
end
