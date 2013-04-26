/* Copyright (C) 1997 Harlequin Ltd
 *
 * Dummy power function
 *
 * $Log: localreals.c,v $
 * Revision 1.2  1998/02/05 13:46:33  jont
 * [Bug #70039]
 * Add dummy check_neg_zero function
 *
 * Revision 1.1  1997/10/09  10:22:47  jont
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

extern int check_neg_zero(double *x)
{
  return 0;
}
