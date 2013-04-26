/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Interface to timer structure that is common to all timer implementations.
 * This is only meant to be used by the various mlw_timer.c files.
 *
 * Note that this is called mlw_timer rather than timer to avoid header 
 * file clashes on systems that have a timer.h file.
 * 
 * Revision Log
 * ------------
 *
 * $Log: mlw_timer.h,v $
 * Revision 1.1  1996/05/30 10:10:04  stephenb
 * new unit
 *
 */

#define mlw_timer_cpu_make() allocate_record(3)
#define mlw_timer_cpu_usr(timer) FIELD(timer, 2)
#define mlw_timer_cpu_sys(timer) FIELD(timer, 1)
#define mlw_timer_cpu_gc(timer)  FIELD(timer, 0)
