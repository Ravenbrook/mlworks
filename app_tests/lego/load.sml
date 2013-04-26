(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
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
