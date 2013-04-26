/* Copyright (C) 1997 Harlequin Ltd
 *
 * Linux specific power function
 * This is to make up for certain deficiencies in the linux implementation
 * of pow which don't exist under Solaris, SunOS, Irix, Win95 or WinNT.
 * See the basis/maths.sml test suite entry, tests 12b - 12s for the exact
 * tests failed. Hopefully one day it can be removed.
 *
 * $Log: localreals.c,v $
 * Revision 1.2  1998/02/05 13:46:47  jont
 * [Bug #70039]
 * Add dummy check_neg_zero function
 *
 * Revision 1.1  1997/10/09  14:51:35  jont
 * new unit
 * Extra code to make up for the fact that pow does not work properly
 *
 *
 */

#include <stdio.h>
#include "localreals.h"
#include <math.h>

static double posinf = 1.0/0.0;

/* It appears that abs doesn't work properly under Linux either */
static double abs(double a)
{
  return ((a >= 0.0) ? a : -a);
}

extern int localpower(double a, double b, double *result)
{
  if (isnan(a) || isnan(b) || abs(a) == 1.0 || abs(b) == 1.0 || abs(a) == 0.0 || abs(b) == 0.0) {
    return 0; /* Don't touch nans  or +/- 1.0 or 0.0 */
  } else {
    double neginf = -posinf;
    int a_is_inf = (a == posinf || a == neginf);
    int b_is_inf = (b == posinf || b == neginf);
    if (a_is_inf || b_is_inf) {
      if (a_is_inf && b_is_inf) {
	return 0;
      } else {
	if (a_is_inf) {
	  /* inf ** x */
	  if (a == posinf) {
	    if (b > 0.0) {
	      *result = a;
	    } else {
	      *result = 0.0;
	    }
	  } else {
	    /* a = neginf */
	    double floor_b = floor(b);
	    double b_by_2 = b/2.0;
	    double floor_b_by_2 = floor(b_by_2);
	    if (b > 0.0) {
	      if (floor_b == b && b_by_2 != floor_b_by_2) {
		*result = a;
	      } else {
		*result = posinf;
	      }
	    } else {
	      if (floor_b == b && b_by_2 != floor_b_by_2) {
		*result = -0.0;
	      } else {
		*result = 0.0;
	      }
	    }
	  }
	} else {
	  /* x ** inf */
	  int b_pos = (b == posinf);
	  int a_large = abs(a) > 1.0;
	  *result = (b_pos == a_large) ? posinf : 0.0;
	}
	return 1;
      } 
    } else {
      return 0;
    }
  }
}

extern int check_neg_zero(double *x)
{
  return 0;
}
