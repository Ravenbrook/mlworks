BEGIN {
	print "(* __objectfile.sml the structure *)";
	print "(*";
	print " * Object file opcodes";
	print " * Machine generated file : DO NOT ALTER";
	print " * Generated from : objectfile.h";
	print " * Copyright (c) 1991 Harlequin Ltd.";
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
