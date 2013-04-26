BEGIN {
  print "(*  ==== CONTROL IDENTIFIERS FOR MS WINDOWS DIALOGS ====";
  print " *";
  print " *  Machine generated from rts/resource.h by rts/awk/__control_names.awk";
  print " *  DO NOT ALTER";
  print " *)";
  print "require \"$.winsys.control_names\";";
  print "\nstructure ControlName : CONTROL_NAME = ";
  print "  struct";
  print "    exception NotFound of string";
  print "    fun getResID str = ";
  print "      case str of";
  first =1;
}

($1 == "#define" && $2 ~ /^[a-zA-Z_]/ && $3 ~ /^[0-9]/) {
  if (first == 1)
    print "        \"" $2 "\" => " $3;
  else
    print "      | \"" $2 "\" => " $3;
  first = 0;
}

END   {
  print "      | _ => raise NotFound str";
  print "  end";
}

