/* Copyright (C) 1997 Harlequin Ltd
 *
 * Dummy power function
 *
 * $Log: localreals.c,v $
 * Revision 1.2  1998/02/05 13:14:53  jont
 * [Bug #70039]
 * Add function to check for negative zero
 *
 * Revision 1.1  1997/10/09  10:22:13  jont
 * new unit
 * Dummy implementation as FP system does the correct thing
 *
 *
 */

#include "localreals.h"

extern int localpower(double a, double b, double *result)
{
  return 0;
}

extern int asm_check_neg_zero(double *x);
extern int check_neg_zero(double *x)
{
  return asm_check_neg_zero(x);
}
