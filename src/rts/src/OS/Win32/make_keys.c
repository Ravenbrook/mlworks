/*
 *
 * Produce the security key values for MLWorks
 *
 * Copyright (C) 1998 Harlequin Group plc
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
