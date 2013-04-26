BEGIN	{
	  print "(*  ==== RUNTIME SYSTEM TAGS ====";
	  print " *";
	  print " *  Machine generated from tags.h by tags.awk";
	  print " *  DO NOT ALTER";
	  print " *)";
          print "\nrequire \"tags\";";
	  print "\nstructure Tags_ : TAGS =";
	  print "  struct";
	}

/^#define[ \t]+[A-Z0-9_]+[ \t]+[0-9]+/ {
	  print "    val " $2 " = " $3;
	}

END	{
	  print "  end";
	}
