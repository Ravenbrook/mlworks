(*

Result: OK
 
$Log: debug.sml,v $
Revision 1.3  1996/05/08 12:39:10  jont
Arrays have moved

 * Revision 1.2  1996/02/23  16:27:51  daveb
 * Converted Shell structure to new capitalisation convention.
 *
 *  Revision 1.1  1995/09/25  10:19:54  jont
 *  new unit
 *

Copyright (c) 1995 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Compiler.generateDebugInfo, true);
Shell.Options.set(Shell.Options.Compiler.generateTraceProfileCode, true);
Shell.Options.set(Shell.Options.Compiler.generateVariableDebugInfo, true);
Shell.Options.set(Shell.Options.Compiler.optimizeLeafFns, false);
Shell.Options.set(Shell.Options.Compiler.optimizeSelfTailCalls, false);
Shell.Options.set(Shell.Options.Compiler.optimizeTailCalls, false);

fun do_test i = 
  let
    val results = MLWorks.Internal.Array.array (10, 0);

    fun print_results i =
      let
        val score = real (MLWorks.Internal.Array.sub (results, i)) ;
      in
        ()
      end
  in
    print_results 0
  end
