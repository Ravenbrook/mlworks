BEGIN {
	print "(* objectfile.sml the signature *)";
	print "(*";
	print " * Object file opcodes";
	print " * Machine generated file : DO NOT ALTER";
	print " * Generated from : objectfile.h";
	print " * Copyright (c) 1991 Harlequin Ltd.";
	print " *)";
	print ("\nsignature OBJECTFILE =");
	print ("sig");
      }

/#define GOOD_MAGIC/ {
	 print("  val", $2, ": int");
       }

/#define HEADER_SIZE/ {
	 print("  val", $2, ": int");
       }

/#define OBJECT_FILE_VERSION/ {
	 print("  val", $2, ": int");
       }

/#define OPCODE_.*/ {
	 print("  val", $2, ": int");
       }

END {
	print ("end;");
    }
