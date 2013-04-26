BEGIN {
	  print "/*  ==== IMPLICIT VECTOR OFFSETS ===";
	  print " *";
	  print " *  Machine generated from implicit.h by offsets.awk";
	  print " *  DO NOT ALTER";
	  print " */\n";
	  print "#ifndef offsets_h\n#define offsets_h\n";
	}

/^.* *struct  *implicit_vector *$/ {
	  START = 1;
	}

/}.*; *$/ {
	  START = 0;
	}

	{
	  if(START > 2) print "#define IMPLICIT_" $2 " " 4*(START-3);
	  if(START > 0) ++START;
	}

END	{
	  print "\n#endif";
	}
