/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Interface to the rts routines that support the basis Timer implementation.
 * None are needed external to the file, so only the routine to register
 * them is external.
 *
 * This is called mlw_timer rather than timer to avoid header file clashes 
 * on systems that have a timer.h file.
 * 
 * Revision Log
 * ------------
 *
 * $Log: mlw_timer_init.h,v $
 * Revision 1.1  1996/05/29 14:23:56  stephenb
 * new unit
 *
 */

extern void mlw_timer_init(void);
