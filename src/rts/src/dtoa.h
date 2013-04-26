/*  EXACT real conversion */
/* Copyright (C) 1997 The Harlequin Group Limited */
/*
 *  $Log: dtoa.h,v $
 *  Revision 1.1  1997/03/06 15:06:34  matthew
 *  new unit
 *
 */

#include "mach_values.h"
/* Other platforms may require more #defines here */
/* see dtoa.h */

#ifdef REVERSE_REAL_BYTES
#define IEEE_8087
#else
#define IEEE_MC68k
#endif

char * dtoa (double d, int mode, int ndigits, int *decpt, int *sign, char **rve);
void freedtoa(char *s);
double strtod (const char *s00, char **se);

