(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: load.sml,v $
 * Revision 1.2  1998/06/11 12:54:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
use "../nj-compat/nj-compat";

(*Shell.Options.Mode.harlequin();*)

Shell.Options.set(Shell.Options.Language.typeDynamic, false);
Shell.Options.set(Shell.Options.Language.abstractions, true);

use "var.sig";
use "var.str";
use "name.sig";
use "test.sig";
use "sortedlist.sig";
use "lib.sml";
use "test.str";
use "sname.sig";
use "stest.sig";
use "stest.str";
use "sortedlist.str";
use "sname.str";
use "saction.sig";
use "sagent.sig";
use "sagent.str";
use "saction.str";
use "sPropVar.sig";
use "sPropVar.sml";
use "sFormula.sig";
use "sFormula.sml";
use "base.sml";
use "pi_grm.sig";
use "pi_lex.sml";
use "commands.sig";
use "pi_grm.sml";
use "flags.sml";
use "name.str";
use "action.sig";
use "mc/Agent.sig";
use "mc/PropVar.sig";
use "mc/Constant.sig";
use "mc/Formula.sig";
use "mc/DefList.sig";
use "mc/NameSubstitution.sig";
use "mc/Condition.sig";
use "mc/Sequent.sig";
use "mc/Sequent.sml";
use "mc/List.sig";
use "mc/List.sml";
use "mc/PropVar.sml";
use "mc/NameSubstitution.sml";
use "mc/Visited.sig";
use "mc/Visited.sml";
use "mc/AgentSubSem.sig";
use "mc/ModelChecker.sig";
use "mc/ModelChecker.sml";
use "mc/Formula.sml";
use "mc/EquivalenceChecker.sig";
use "mc/AgentTable.sig";
use "mc/AgentTable.sml";
use "mc/EquivalenceChecker.sml";
use "mc/DefList.sml";
use "mc/Constant.sml";
use "mc/Condition.sml";
use "mc/AgentSubSem.sml";
use "env.sig";
use "agent.sig";
use "mc/Agent.sml";
use "hashtbl.sig";
use "hashtbl.str";
use "env.str";
use "distinction.sig";
use "distinction.str";
use "commands.str";
use "agent_opensem.sig";
use "agent_opensem.str";
use "agent.str";
use "action.str";
use "top.sml";
