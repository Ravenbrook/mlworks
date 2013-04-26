/* Copyright (C) 1997 Harlequin Ltd
 *
 * Power function in case various OSes can't do the job properly
 * eg Linux.
 * Also stuff to sort out signed 0.0
 *
 * $Log: localreals.h,v $
 * Revision 1.2  1998/02/05 13:12:36  jont
 * [Bug #70039]
 * Add function to check for negative zero for those platforms
 * that don't support it properly (NT and Irix)
 *
 * Revision 1.1  1997/10/09  14:07:00  jont
 * new unit
 * Prototype for extra power function needed by linux to
 * compensate for fp system bugs
 *
 *
 */

#ifndef localreals_h
#define localreals_h

extern int localpower(double, double, double *);

extern int check_neg_zero(double *);

#endif
