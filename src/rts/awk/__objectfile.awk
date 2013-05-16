BEGIN {
	print "(* __objectfile.sml the structure *)";
	print "(*";
	print " * Object file opcodes";
	print " * Machine generated file : DO NOT ALTER";
	print " * Generated from : objectfile.h";
        print " *";
	print " * The generated copy of this file in src/rts/gen is information";
        print " * about the object files that the *current runtime* can load";
        print " * and *not* necessarily what the compiler generates.  This file";
        print " * should be hand-copied to src/main/__objectfile.sml for use";
        print " * by the compiler, with version numbers for the object files";
        print " * that the source code of the compiler actually outputs.";
        print " *";
	print " * Copyright 2013 Ravenbrook Limited";
	print " *)";
	print ("\nstructure ObjectFile_ =");
	print ("struct");
      }

/#define GOOD_MAGIC/ {
	 print("  val", $2, "=", $3);
       }

/#define OBJECT_FILE_VERSION/ {
	 print("  val", $2, "=", $3);
       }

/#define HEADER_SIZE/ {
	 print("  val", $2, "=", $3);
       }

/#define OPCODE_.*/ {
	 print("  val", $2, "=", $3);
       }

END {
	print ("end;");
    }
