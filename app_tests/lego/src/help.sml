(*
 *
 * $Log: help.sml,v $
 * Revision 1.2  1998/08/05 17:39:56  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
(* help.sml *)

fun help() = message"\
\New Commands:\n\
\  Inductive DECLS1        defines datatype(s) DECLS1 with constructors\n\
\    [Parameters  DECS]         DECLS2 and (optional) parameters DECS.\n\
\    Constructors DECLS2        **Experimental: report bugs to ccmj**\n\
\  Module ID               start a module named ID which requires modules\n\
\    [Import ID1 ID2 ..]        named ID1 ID2 ..\n\
\  Load ID                 Include module ID if not yet included\n\
\  ForgetMark ID           forget back to the start of module ID,\n\
\                               but not any modules it imports\n\
\Basic Commands - see User Manual for more info:\n\
\  Init TT[']              where TT is LF, PCC, CC, or XCC\n\
\      The optional ' requests maximal universe polymorphism.\n\
\  Include \"STRING\"        process file named STRING\n\
\  Goal TERM               start refinement proof with goal TERM\n\
\  Refine [NUM] TERM       refine goal NUM by TERM\n\
\  Intros [NUM] ID1 ID2 .. Pi-introductions on HNF of goal NUM\n\
\  intros [NUM] ID1 ID2 .. Pi-introductions on goal NUM\n\
\  Claim TERM              create a new goal (lemma) in a proof\n\
\  Equiv TERM              replace first goal with equivalent goal TERM\n\
\  Qrepl TERM              use the type of TERM as a conditional equation\n\
\                               to rewrite the current goal\n\
\  Prf                     show current proof state\n\
\  Save ID                 save proof term as global with name ID\n\
\  $Save ID                save proof term as local with name ID\n\
\  KillRef                 kill the current refinement proof\n\
\  Discharge ID            discharge assumptions back to ID\n\
\  Help                 print this message\n\
\  Logic                load logic prelude into current state\n\
\  Pwd                  print working directory\n\
\  Cd \"STRING\"          change directory\n\
\  Ctxt [n]             prints all (last n) context entries\n\
\  Decls [n]            prints all (last n) declarations (not definitions)\n\
\  Freeze ID1 ID2 ..    definitions IDn will not be expanded\n\
\  Unfreeze ID1 ID2 ..  forget freeze on definitions IDn\n\
\Basic Syntax: (some theories don't have 'Type' or Sigma)\n\
\  TERM ::= Prop | Type                     kinds\n\
\         | ID                              variable or constant\n\
\         | {x:TERM}TERM | TERM -> TERM     Pi\n\
\         | [x:TERM]TERM                    Lambda\n\
\         | TERM TERM                       application\n\
\         | <x:TERM>TERM | TERM # TERM      Sigma\n\
\         | (TERM,TERM)                     pair\n\
\         | TERM.1 | TERM.2                 projections\n\
\         | (TERM : TERM)                   typecast\n\
\         | [x=TERM]TERM                    'let'\n\
\  CXT  ::= [] | CXT BIND                   context\n\
\  BIND ::= [x:TERM]                        local variable or assumption\n\
\         | [x=TERM]                        global definition\n\
\         | $[x:TERM]                       global variable or assumption\n\
\         | $[x=TERM]                       local definition\n\
\   *** There is much more info in the User Manual! ***";




