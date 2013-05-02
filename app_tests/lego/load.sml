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
 * Revision 1.3  1998/08/07 16:25:49  jont
 * Modify to run test data
 *
 *  Revision 1.2  1998/08/05  17:11:42  jont
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)
(* This defines a function lego () *)

Shell.Options.set(Shell.Options.Language.abstractions,true);

let
  val _ = Shell.Path.setSourcePath[".","~sml/MLW/src/"];
  val basis_name = OS.Path.concat["/u", "sml", "MLW", "src", "basis.mlp"]
  val _ = Shell.Project.openProject basis_name
  val configs = Shell.Project.showAllConfigurations();
  val _ = Shell.Project.newProject(OS.Path.fromUnixPath "/tmp");
  val _ = Shell.Project.setSubprojects[(basis_name)];
  val _ =
    app
    (fn config =>
     Shell.Project.setConfigurationDetails(config, {files=[], library = []}))
    configs;
  val path = OS.FileSys.getDir()
  val files =
    (OS.Path.concat[path, "polyml-compat.sml"]) ::
    map
    (fn s => OS.Path.concat [path, "src", s])
    ["lego_lex.sml",
     "tactics.sml",
     "base.sml",
     "logic.sml",
     "term.sml",
     "machine.sml",
     "modules.sml",
     "toc.sml",
     "discharge.sml",
     "namespace.sml",
     "toplevel.sml",
     "newtop.sml",
     "type.sml",
     "help.sml",
     "unif.sml",
     "ind_relations.sml",
     "universe.sml",
     "init.sml",
     "ut1.sml",
     "interface.sml",
     "parser.sml",
     "ut2.sml",
     "pattern.sml",
     "ut3.sml",
     "lego__grm.sml",
     "pretty.sml",
     "utils.sml",
     "lego_grm.sml",
     "synt.sml"]

in
  Shell.Project.setFiles files
end;
Shell.Project.setTargetDetails "interface.sml";
Shell.Project.setTargets ["interface.sml"];
Shell.Project.forceCompileAll();
Shell.Project.loadAll();
OS.FileSys.chDir("lambda/full");
lego();
Include"load.l";
