(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Log: fd.sml,v $
 *  Revision 1.4  1998/07/15 14:17:50  jont
 *  [Bug #20130]
 *  Use forceCompileAll instead of compileAll
 *
 * Revision 1.3  1998/07/14  16:30:31  jont
 * [Bug #20130]
 * Modify to avoid recompiling into the release area
 *
 * Revision 1.2  1998/04/24  15:43:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Revision 1.1  1998/04/21  12:54:00  jont
 * new unit
 * ** No reason given. **
 *
 *
 *)

local
  structure s = Shell.Project;
in
  val _ = s.openProject"../src/mlworks.mlp";
  val _ = s.setConfiguration"I386/NT";
  val {binariesLoc, libraryPath, objectsLoc} = s.showLocations();
  val _ = s.setLocations
    {binariesLoc=binariesLoc, libraryPath=libraryPath, objectsLoc="objects"};
  val _ = s.setMode"Debug";
  val _ = s.setTargets["__batch.sml"];
  val _ = s.forceCompileAll();
  val _ = s.loadAll();
end
