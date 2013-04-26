(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Copyright (C) 1998. Harlequin Group plc
 *  All rights reserved.
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
