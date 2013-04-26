BEGIN {
	print "(*  ==== IMPLICIT VECTOR OFFSETS ====";
        print " *";
        print " *  Machine generated from implicit.c by __implicit.awk";
        print " *  DO NOT ALTER";
	print " *)";
	print ("\nstructure ImplicitVector_ =");
	print ("  struct");
      }

/^.* *struct  *implicit_vector *$/ {
        START = 1;
      }

/}.*; *$/  {
	START = 0;
      }

      {
	if (START > 2) print("    val", $2, "=", START-3);
	if (START > 0) ++START;
      }

END   {
	print ("  end");
      }
