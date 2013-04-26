# Copyright (C) 1996 Harlequin Ltd
#
# Generate C functions to implement OS.errorName and OS.syserror 
# based on the contents of /usr/include/sys/errno.h
#
# $Log: unix_os_errors_c.awk,v $
# Revision 1.1  1996/05/28 12:04:18  stephenb
# new unit
#

BEGIN {
  printf("/* Copyright (c) 1996 Harlequin Ltd.\n");
  printf("**\n");
  printf("** This file was generated from sys/errno.h using unix_error_name_c.awk.\n");
  printf("** DO NOT ALTER by hand.\n");
  printf("**\n");
  printf("** Note it would be better go generate both the functions as SML\n");
  printf("** rather than C.  The only reason this is not being done\n");
  printf("** that at the time this is added there is no consensus\n");
  printf("** on how to structure the generated SML files such that they\n");
  printf("** can be distributed as part of the basis implementation.\n");
  printf("** Generating C and pulling the code through the runtime\n");
  printf("** avoids this problem.  Hopefully a consensus will be reached\n");
  printf("** in the near future and this file can go away.\n");

  printf("*/\n\n");
  printf("#include \"allocator.h\" /* ml_string */\n");
  printf("#include \"values.h\" /* mlw_option_make_some */\n");
  printf("#include \"os_errors.h\"\n");
  printf("\n\n");
}


# The [0-9][0-9]* stuff in the following pattern is there so that defines
# that are not defined in terms of literal numbers are ignored.
# This is to avoid duplicate branches in case statements that result from
# things like the following from the Irix errno.h header file :-
#
#   #define EWOULDBLOCK EAGAIN
#
# Of course this could break badly on systems where the error codes
# are all defined in terms of the previous error code + 1.  However, we'll
# cross that bridge when we come to it. 

/^#define[\t ]*E[A-Za-z0-9]*[\t ]*[0-9][0-9]*/ {
  errors[$3]= $2
  next;
}

END {
  printf("/*\n");
  printf("** OS.errorName : syserror -> string\n");
  printf("*/\n");
  printf("mlval mlw_os_error_name(mlval arg)\n");
  printf("{\n");
  printf("  int error_code= CINT(arg);\n");
  printf("  char const *error_name;\n");
  printf("  switch (error_code) {\n");
  printf("  case   0: error_name= \"\";  break;\n");
  for (i in errors) {
    printf("  case %3d: error_name= \"%s\";  break;\n", i, errors[i]);
  }
  printf("  default: error_name= \"MLWORKS_INTERNAL_ERROR\";\n");
  printf("  }\n");
  printf("  return ml_string(error_name);\n");
  printf("}\n");
  printf("\n\n\n");
  printf("/*\n");
  printf("** OS.syserror : string -> syserror option\n");
  printf("*/\n");
  print "/* The implementation is rather simple in that it effectively"
  print "** performs a linear search to find the matching code."
  print "** A more efficient approach would be to build a trie"
  print "** and generate a tree of if statements."
  print "** The only reason this hasn't been implemented is that"
  print "** it is rather tough to do in AWK and this code is"
  print "** not critical enough to warrant rewriting it in C"
  print "** which is the only other language that is available to our"
  print "** build process on NT and Unix."
  print "*/"
  printf("mlval mlw_os_syserror(mlval arg)\n");
  printf("{\n");
  printf("  char const * error_message= CSTRING(arg);\n");
  printf("  int error_code= 0;\n");
  for (i in errors) {
    printf("  if (strcmp(error_message, \"%s\") == 0)\n", errors[i])
    printf("    error_code= %d;\n", i)
  }
  printf("  return mlw_option_make_some(MLINT(error_code));\n");
  printf("}\n");
}
