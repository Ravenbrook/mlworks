(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: load.sml,v $
 * Revision 1.3  1998/06/18 09:49:05  jont
 * [Bug #70127]
 * Correct for change in spec in Shell.Project.newProject
 *
 * Revision 1.2  1998/06/09  15:10:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
Shell.Project.newProject(OS.Path.fromUnixPath "/tmp");
let 
  val path = OS.FileSys.getDir()
  val files = map
    (fn s => OS.Path.concat [path, s])
    ["__arithmetic.sml",
     "__cli.sml",
     "__code.sml",
     "__dynamics.sml",
     "__interpreter.sml",
     "__lexer.sml",
     "__lowlevel.sml",
     "__parser.sml",
     "__scheduler.sml",
     "__store.sml",
     "__stream.sml",
     "__tracer.sml",
     "_arithmetic.sml",
     "_cli.sml",
     "_code.sml",
     "_dynamics.sml",
     "_interpreter.sml",
     "_lexer.sml",
     "_parser.sml",
     "_scheduler.sml",
     "_tracer.sml",
     "arithmetic.sml",
     "cli.sml",
     "code.sml",
     "dynamics.sml",
     "interpreter.sml",
     "lexer.sml",
     "lowlevel.sml",
     "parser.sml",
     "scheduler.sml",
     "store.sml",
     "stream.sml",
     "tracer.sml"]
in
  Shell.Project.setFiles files
end;
Shell.Project.setTargetDetails "__cli.sml";
Shell.Project.setTargets ["__cli.sml"];
Shell.Project.forceCompileAll();
Shell.Project.loadAll()
