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
