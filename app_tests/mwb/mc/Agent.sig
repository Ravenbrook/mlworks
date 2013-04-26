(*
 *
 * $Log: Agent.sig,v $
 * Revision 1.2  1998/06/11 13:14:13  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature McAGENT =
sig

  structure ACT : ACTION

  structure B : TEST

  type agent
  type env

  val mkstr : agent -> string
  (* constructors *)

  val mk_nil: agent

  val mk_sum: agent -> agent -> agent

  val mk_prefix: ACT.action -> agent -> agent

  (* Remember to extend mk_par to abstractions/concretions on *)
  (* either side                                              *)
  val mk_par: agent -> agent -> agent

  val mk_conditional: B.test -> agent -> agent -> agent

  val mk_abstraction: ACT.N.name -> agent -> agent

  val mk_application: agent -> ACT.N.name -> agent

  val mk_restriction: ACT.N.name -> agent -> agent

  val mk_concretion: ACT.N.name -> agent -> agent

  val mk_bconcretion: ACT.N.name -> agent -> agent

  val mk_identifier: string -> agent

  (* equality *)  

  val eq: agent -> agent -> bool

  (* Testers *)

  val is_nil: agent -> env -> bool

  val is_sum: agent -> env -> bool

  val is_prefix: agent -> env -> bool

  val is_par: agent -> env -> bool

  val is_conditional: agent -> env -> bool

  val is_application: agent -> env -> bool

  val is_restriction: agent -> env -> bool

  val is_identifier: agent -> env -> bool

  val is_process: agent -> env -> bool

  val is_concretion: agent -> env -> bool

  val is_bconcretion: agent -> env -> bool

  val is_abstraction: agent -> env -> bool

  (* Selectors *)

  val free_names: agent -> ACT.N.name list

  val sum_left: agent -> env -> agent

  val sum_right: agent -> env -> agent

  val prefix_left: agent -> env -> ACT.action

  val prefix_right: agent -> env -> agent

  val par_left: agent -> env -> agent

  val par_right: agent -> env -> agent

  val get_boolean: agent -> env -> B.test

  val cond_positive: agent -> env -> agent

  val cond_negative: agent -> env -> agent

  val appl_fun: agent -> env -> agent

  val appl_arg: agent -> env -> ACT.N.name

  val restriction_right: ACT.N.name -> agent -> env -> agent

  val concretion_left: agent -> env -> ACT.N.name

  val concretion_right: agent -> env -> agent

  val bconcretion_right: ACT.N.name -> agent -> env -> agent

  val abstraction_right: ACT.N.name -> agent -> env -> agent

  (* manipulators *)

  val pseudo_appl: agent -> agent -> env -> agent

  val identifier_def: agent -> env -> agent
end
