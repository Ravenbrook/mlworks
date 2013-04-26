/*
 *
 * Produce the process status values for MLWorks
 *
 * Copyright (C) 1999 Harlequin Group plc.  All rights reserved.
 *
 * $Log: make_statuses.c,v $
 * Revision 1.1  1999/03/11 18:17:17  daveb
 * new unit
 * Creates ML versions of Windows process exit statuses.
 *
 *
 */

#include "windows.h"

#include <stdio.h>

void print_status_and_value(const char *key, unsigned int value)
{
  printf("    val %s = 0wx%x : SysWord.word\n", key, value);
}

int main(int argc, char *argv[])
{
  printf("require \"$.basis.__sys_word\";\n\n");
  printf("structure Status =\n  struct\n");
  printf("    type status = SysWord.word\n");
  print_status_and_value("accessViolation", STATUS_ACCESS_VIOLATION);
  print_status_and_value("arrayBoundsExceeded", STATUS_ARRAY_BOUNDS_EXCEEDED);
  print_status_and_value("breakpoint", STATUS_BREAKPOINT);
  print_status_and_value("controlCExit", STATUS_CONTROL_C_EXIT);
  print_status_and_value("datatypeMisalignment", STATUS_DATATYPE_MISALIGNMENT);
  print_status_and_value("floatDenormalOperand", STATUS_FLOAT_DENORMAL_OPERAND);
  print_status_and_value("floatDivideByZero", STATUS_FLOAT_DIVIDE_BY_ZERO);
  print_status_and_value("floatInexactResult", STATUS_FLOAT_INEXACT_RESULT);
  print_status_and_value("floatInvalidOperation", STATUS_FLOAT_INVALID_OPERATION);
  print_status_and_value("floatOverflow", STATUS_FLOAT_OVERFLOW);
  print_status_and_value("floatStackCheck", STATUS_FLOAT_STACK_CHECK);
  print_status_and_value("floatUnderflow", STATUS_FLOAT_UNDERFLOW);
  print_status_and_value("guardPageViolation", STATUS_GUARD_PAGE_VIOLATION);
  print_status_and_value("integerDivideByZero", STATUS_INTEGER_DIVIDE_BY_ZERO);
  print_status_and_value("integerOverflow", STATUS_INTEGER_OVERFLOW);
  print_status_and_value("illegalInstruction", STATUS_ILLEGAL_INSTRUCTION);
  print_status_and_value("invalidDisposition", STATUS_INVALID_DISPOSITION);
  print_status_and_value("invalidHandle", STATUS_INVALID_HANDLE);
  print_status_and_value("inPageError", STATUS_IN_PAGE_ERROR);
  print_status_and_value("noncontinuableException", STATUS_NONCONTINUABLE_EXCEPTION);
  print_status_and_value("pending", STATUS_PENDING);
  print_status_and_value("privilegedInstruction", STATUS_PRIVILEGED_INSTRUCTION);
  print_status_and_value("singleStep", STATUS_SINGLE_STEP);
  print_status_and_value("stackOverflow", STATUS_STACK_OVERFLOW);
  print_status_and_value("timeout", STATUS_TIMEOUT);
  print_status_and_value("userAPC", STATUS_USER_APC);
  printf(" end");
  return 0;
}

