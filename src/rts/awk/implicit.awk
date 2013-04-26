BEGIN {
	print "(*  ==== IMPLICIT VECTOR OFFSETS ====";
        print " *";
        print " *  Machine generated from implicit.c by implicit.awk";
        print " *  DO NOT ALTER";
	print " *)";
	print ("\nsignature IMPLICIT_VECTOR =");
	print ("  sig");
      }

/^.* *struct  *implicit_vector *$/ {
	  START = 1;
	}

/}.*; *$/ {
	  START = 0;
	}

	{
	  if (START > 2) print("    val", $2, ": int");
	  if (START > 0) ++START;
	}

END {
	print ("  end");
    }
