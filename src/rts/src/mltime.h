/*  ==== TIME ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: mltime.h,v $
 *  Revision 1.1  1997/11/17 17:49:46  jont
 *  new unit
 *  This has ceased to be platform specific
 *
 * Revision 1.3  1995/07/17  12:35:47  nickb
 * Add ml_time_microseconds.
 *
 * Revision 1.2  1995/05/18  16:11:32  jont
 * Add ml_time_t
 *
 * Revision 1.1  1994/12/09  16:12:52  jont
 * new file
 *
 * Revision 1.1  1994/10/04  16:33:39  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:25:53  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:50:34  nickh
 * new file
 *
 *  Revision 1.3  1993/11/22  17:47:35  jont
 *  Changed to expose time_decode and time_encode for use by runtime system
 *  consistency checking
 *
 *  Revision 1.2  1993/11/12  16:55:48  nickh
 *  remove ml_virtual_time (we don't have virtual times any more).
 *
 *  Revision 1.1  1992/11/03  11:22:06  richard
 *  Initial revision
 *
 */

#ifndef time_h
#define time_h

extern void time_init(void);

/* user_clock() returns the number of microseconds of user virtual
 * time elapsed since MLWorks was started. It uses a double because
 * longs have insufficient precision (32 bits gives only just over an
 * hour, doubles give years */

extern double user_clock(void);

#endif
