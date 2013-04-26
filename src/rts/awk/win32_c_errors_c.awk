# Copyright (C) 1996 Harlequin Ltd
#
# Generate C functions which partially implement OS.errorName and OS.syserror 
# based on the contents of (a local copy of) C:/msdev/include/sys/errno.h
#
# $Log: win32_c_errors_c.awk,v $
# Revision 1.1  1996/06/04 13:14:43  stephenb
# new unit
#
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
  printf("#include <errno.h> /* E[A-Z]* */\n");
  printf("#include <string.h> /* strcmp */\n");
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
  printf("** XXX\n");
  printf("*/\n");
  printf("static char * mlw_c_error_name(unsigned int error_code)\n");
  printf("{\n");
  printf("  switch (error_code) {\n");
  printf("  case   0: return \"\";  break;\n");
  for (i in errors) {
    printf("  case %12s: return \"%s\";\n", errors[i], errors[i]);
  }
  printf("  default: return \"MLWORKS_INTERNAL_ERROR\";\n");
  printf("  }\n");
  printf("}\n");
  printf("\n\n\n");
  printf("/*\n");
  printf("** XXX\n");
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
  printf("static int mlw_c_syserror(char const * error_message)\n");
  printf("{\n");
  for (i in errors) {
    printf("  if (strcmp(error_message, \"%s\") == 0)\n", errors[i])
    printf("    return %s;\n", errors[i])
  }
  printf("  return 0;\n");
  printf("}\n");
}
