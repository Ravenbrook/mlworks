BEGIN {
	print "(* __objectfile.sml the structure *)";
	print "(*";
	print " * Object file opcodes";
	print " * Machine generated file : DO NOT ALTER";
	print " * Generated from : objectfile.h";
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
