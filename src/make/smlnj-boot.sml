(* this code is used to load the MLWorks compiler into SML/NJ
   1. loads the emulation layer
   2. loads the dummy_make system
   3. loads the batch compiler
   4. dumps an image (for debugging)
   5. compiles pervasives
   6. compiles the batch compiler with itself
 *)

(* SML/NJ's backtrace feature is sometimes useful, but it causes a
   noticable slowdown both at runtime and compile time.
CM.make "$smlnj-tdp/back-trace.cm";
SMLofNJ.Internals.TDP.mode := true;
*)

use "make/nj_env.sml"; (* Simulate the runtime environment *)
use "make/change_nj.sml";

use "make/dummy_make.sml";
make "../main/__batch.sml";

print ("dumping image to make/smlnj-batch.img ...\n");
SMLofNJ.exportML "make/smlnj-batch.img";

Batch_.obey ["-verbose", "-pervasive-dir", "pervasive/", "-compile-pervasive"];

Batch_.obey ["-verbose",
	     "-pervasive-dir", "pervasive/",
	     "-project", "batch.mlp",
	     "-configuration", "I386/Linux",
	     "-target", "__batch.sml",
	     "-build"];
