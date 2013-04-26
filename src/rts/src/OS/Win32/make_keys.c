/*
 *
 * Produce the security key values for MLWorks
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: make_keys.c,v $
 * Revision 1.1  1998/04/07 14:14:30  jont
 * new unit
 * ** No reason given. **
 *
 *
 */

#include "windows.h"

#include <stdio.h>

void print_key_and_value(const char *key, unsigned int value)
{
  printf("    val %s = 0wx%x : SysWord.word\n", key, value);
}

int main(int argc, char *argv[])
{
  printf("require \"$.basis.__sys_word\";\n\n");
  printf("structure Keys =\n  struct\n");
  print_key_and_value("synchronize", SYNCHRONIZE);
  print_key_and_value("standardRightsRead", STANDARD_RIGHTS_READ);
  print_key_and_value("standardRightsWrite", STANDARD_RIGHTS_WRITE);
  print_key_and_value("standardRightsExecute", STANDARD_RIGHTS_EXECUTE);
  print_key_and_value("standardRightsAll", STANDARD_RIGHTS_ALL);
  print_key_and_value("createLink", KEY_CREATE_LINK);
  print_key_and_value("createSubKey", KEY_CREATE_SUB_KEY);
  print_key_and_value("enumerateSubKeys", KEY_ENUMERATE_SUB_KEYS);
  print_key_and_value("notify", KEY_NOTIFY);
  print_key_and_value("queryValue", KEY_QUERY_VALUE);
  print_key_and_value("setValue", KEY_SET_VALUE);
  print_key_and_value("read", KEY_READ);
  print_key_and_value("write", KEY_WRITE);
  print_key_and_value("execute", KEY_EXECUTE);
  print_key_and_value("allAccess", KEY_ALL_ACCESS);
  printf(" end");
  return 0;
}
