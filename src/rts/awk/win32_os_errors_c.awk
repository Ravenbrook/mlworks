# Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Generate C functions to implement OS.errorName and OS.syserror 
# based on the contents of C:/msdev/include/winerror.h
#
# $Log: win32_os_errors_c.awk,v $
# Revision 1.3  1997/05/21 13:40:50  johnh
# [Bug #01702]
# mlw_win32_strerror no longer automatically generated - see
# src/OS/Win32/win32_error.c
#
# Revision 1.2  1996/06/04  12:03:12  stephenb
# Extend to deal with C (errno) errors as well as Win32 errors.
#
# Revision 1.1  1996/05/28  12:06:06  stephenb
# new unit
#

BEGIN {
  printf("/* Copyright 2013 Ravenbrook Limited\n");
  printf("**\n");
  printf("** This file was generated from winerror.h using win32_os_errors_c.awk.\n");
  printf("**\n");
  printf("** It would be better go generate the first two functions as SML\n");
  printf("** rather than C.  The only reason this is not being done\n");
  printf("** that at the time this is added there is no consensus\n");
  printf("** on how to structure the generated SML files such that they\n");
  printf("** can be distributed as part of the basis implementation.\n");
  printf("** Generating C and pulling the code through the runtime\n");
  printf("** avoids this problem.  Hopefully a consensus will be reached\n");
  printf("** in the near future and this file can go away.\n");
  printf("**\n");
  printf("*/\n\n\n");
  printf("#include \"allocator.h\" /* ml_string */\n");
  printf("#include \"values.h\" /* mlw_option_make_some */\n");
  printf("#include <stdio.h> /* DWORD */\n");
  printf("#include <windows.h> /* DWORD */\n");
  printf("#if !defined(_WIN32) && !defined(WIN32)\n");
  printf("#include <ver.h>\n");
  printf("#endif\n");
  printf("#include \"os_errors.h\"\n");
  printf("\n\n");
}

/^\/\/ MessageId:/ {
  errorName= $3;
  next;
}

/^\/\/ MessageText:/ {
  inErrorMessage= 1;
  next;
}

/^\/\/[\t ]*$/ {
  next;
}

/^#define/ {
  errorNumber=substr($3, 0, length($3)-1)
  if (errorName) {
    errors[errorNumber]= errorName;
  }
  errorName=0;
  if (inErrorMessage) {
    errorMessages[errorNumber]= errorMessage;
    inErrorMessage= 0;
    errorMessage="";
  }
  next;
}



#
# The file winerrors.h contains error codes for OLE.  Since a) we don't
# support it and b) the errors are in a different format, just quit
# processing at this point.
#

/OLE Error Codes/ {
  exit;
}


{
  if (inErrorMessage) {
    if (errorMessage)
      errorMessage=errorMessage" "substr($0, 5);
    else
      errorMessage=substr($0, 5)
  }
}


END {
  printf("static char const * mlw_win32_error_name(unsigned int error_code)\n");
  printf("{\n");
  printf("  switch (error_code) {\n");
  for (i in errors) {
     printf("  case %4d: return \"%s\";\n", i, errors[i])  
  }
  printf("  default: return \"MLWORKS_INTERNAL_ERROR\";\n");
  printf("  }\n");
  printf("}\n");
  printf("\n\n\n");


  printf("/*\n");
  printf("** OS.errorName : syserror -> string\n");
  printf("*/\n");
  printf("mlval mlw_os_error_name(mlval arg)\n");
  printf("{\n");
  printf("  unsigned int error_code= CWORD(arg);\n");
  printf("  char const *error_name= ((error_code&0x1) == 0)\n");
  printf("    ? mlw_win32_error_name(error_code>>1)\n")
  printf("    : mlw_c_error_name(error_code>>1);\n")
  printf("  return ml_string(error_name);\n");
  printf("}\n");
  printf("\n\n\n");


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
  printf("static int mlw_win32_syserror(char const *error_message)\n");
  printf("{\n");
  for (i in errors) {
    printf("  if (strcmp(error_message, \"%s\") == 0)\n", errors[i])
    printf("    return %d;\n", i)
  }
  printf("  return 0;\n");
  printf("}\n\n\n\n");


  printf("/*\n");
  printf("** OS.syserror : string -> syserror option\n");
  printf("*/\n");
  printf("mlval mlw_os_syserror(mlval arg)\n");
  printf("{\n");
  printf("  char const * error_message= CSTRING(arg);\n");
  printf("  int error_code= mlw_win32_syserror(error_message);\n");
  printf("  if (error_code != 0) {\n");
  printf("    return mlw_option_make_some(MLINT(error_code<<1));\n");
  printf("  } else if ((error_code= mlw_c_syserror(error_message)) != 0) {\n");
  printf("    return mlw_option_make_some(MLINT((error_code<<1)|1));\n");
  printf("  } else {\n");
  printf("    return mlw_option_make_none();\n");
  printf("  }\n");
  printf("}\n\n\n\n");

}
