(*
 *
 * $Log: make_sccs.ml,v $
 * Revision 1.2  1998/06/02 15:14:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 	$Id: make_sccs.ml,v 1.2 1998/06/02 15:14:22 jont Exp $	 *)
(* * *   S C C S   W O R K B E N C H   * * *)

val _ = uses ["sccs/Part.sig","sccs/Part.str"];

structure P = Part();

val _ = uses ["sccs/Act.sig","sccs/Act.str"];

structure A = Act (structure P = P);

val _ = uses ["sccs/Agent.sig","sccs/Agent.str"];

structure Ag = Agent(structure A=A; structure V=V);

val _ = uses ["sccs/AgentIO.sig","sccs/AgentIO.str"];

structure AgIO = AgentIO(structure Ag = Ag);

structure PK =
  struct
    type hash_key = Ag.agent
    val hashVal = Ag.hashval
    val sameKey = op =
  end;
structure PH = HashTable(PK);

val _ = uses ["sccs/AgentFuns.sig","sccs/AgentFuns.str"];

structure Agf =  AgentFuns( structure AgIO = AgIO;
                            structure E  = E;
                            structure SL = SL );

val _ = uses ["PolyGraph.sig","PolyGraph.str"];

structure PG = PolyGraph(structure Agf = Agf;
                         structure SL   = SL;
                         structure AgIO = AgIO);

val _ = uses ["AccSet.sig","AccSet.str"];

structure AS = AccSet( structure A = A;
                       structure Trie = Trie );

val _ = uses ["TGraph.sig","TGraph.str"];

structure TG = TGraph(structure PG = PG;
                      structure SL = SL;
                      structure Trie = Trie;
                      structure AS = AS );

val _ = uses ["Elem.sig","Elem.str","DivComp.sig","DivComp.str"];

structure Elem = Elem(structure PG = PG;
                      structure SL = SL;
                      structure AS = AS);

val _ = uses ["GenPre.sig","GenPre.str","DivPre.sig","DivPre.str"];

structure DivC = DivComp(structure Elem = Elem);
structure GenP = GenPre(structure DivC = DivC);
structure DivP = DivPre(structure GenP = GenP);

val _ = uses ["Equiv.sig","Equiv.str"];

structure Eq = Equiv(structure PG = PG;
                     structure SL = SL);

val _ = uses ["TestOps.sig","TestOps.str"];

structure TO = TestOps(structure Eq = Eq;
                       structure SL = SL;
                       structure TG = TG;
                       structure GenP = GenP);

val _ = uses ["HMLogic.sig","HMLogic.str","Logic.sig","Logic.str"];

structure HML = HMLogic(structure A = A;
                        structure V = V);

structure L =  Logic(structure A = A;
                     structure V = V); (* V not E now *)

val _ = uses ["LogIO.sig","LogIO.str"];

structure LogIO = LogIO(structure L = L);


val _ = uses ["HMLTran.sig","HMLTran.str"];

structure Tr = HMLTran(structure E = E; (* additional E *)
(* 		       structure L = L;				       *)
		       structure LogIO = LogIO;
                       structure HML = HML);

val _ = uses ["HMLSat.sig","HMLSat.str"];

structure Sat = HMLSat(structure SL = SL;
                       structure E = E; (* E not Agf *)
                       structure AgIO = AgIO;
                       structure HML = HML); (* HML not TR *)

val _ = uses ["HMLCheck.sig","HMLCheck.str"];

structure Check =  HMLCheck(structure SL = SL;
			    structure E = E; (*additional E *)
                            structure PG = PG;
                            structure HML = HML); (* HML not TR *)

val _ = uses ["Df.sig","Df.str"];

structure Df = Df(structure PG = PG;
                  structure SL = SL;
                  structure L = L);

val _ = uses ["Contract.sig","Contract.str"];

structure Cont = Contract(structure PG = PG);

val _ = uses ["sccs/Interface.sig","sccs/Interface.str"];

structure Inter = Interface(structure AgIO = AgIO;
                            structure LogIO = LogIO;
                            structure E = E;
                            structure SL = SL);

val _ = uses ["Commands.sig","Commands.str"];

structure Commands = Commands(structure Ag = Ag;
                              structure L = L);

val _ = uses ["Parse.sig","Parse.str"];

structure Parse = Parse(structure Commands = Commands);

val _ = uses ["Sim.sig","Sim.str"];

structure Sim = Simulate(structure SL = SL;
                         structure Inter = Inter;
                         structure Parse = Parse;
                         structure Agf = Agf;
                         structure AgIO = AgIO);

val _ = uses ["Help.sig","sccs/Help.str"];

structure Help = Help();

val _ = uses ["Top.sig","sccs/Top.str"];

structure Top = Top( structure AgIO = AgIO;
                     structure Agf = Agf;
                     structure DivP = DivP;
                     structure Cont = Cont;
                     structure Eq = Eq;
                     structure TO = TO;
                     structure TG = TG;
                     structure Tr = Tr;
                     structure Sat = Sat;
                     structure Check = Check;
                     structure LogIO = LogIO;
                     structure Inter = Inter;
                     structure Parse = Parse;
                     structure Sim = Sim;
                     structure Help = Help;
                     structure Df = Df);

val sccs_cwb = Top.toploop;
