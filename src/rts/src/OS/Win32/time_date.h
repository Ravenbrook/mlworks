/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date.h,v $
 * Revision 1.6  1997/11/17 10:05:28  jont
 * [Bug #30089]
 * Add mlw_time_make for converting doubles to basis times
 *
 * Revision 1.5  1996/09/09  17:55:07  jont
 * Move two_to_32 into time_date.h from time.c
 *
 * Revision 1.4  1996/06/13  15:54:52  stephenb
 * Add mlw_time_to_timeval as needed by select (which is used to
 * implement OS.IO.poll).
 *
 * Revision 1.2  1996/06/12  08:47:58  stephenb
 * Replace the previous interface with one that better hides the internal
 * details of the type.
 *
 * Revision 1.1  1996/05/01  10:16:05  stephenb
 * new unit
 *
 */

#ifndef time_date_h
#define time_date_h

#include "mltypes.h"
#include <windows.h> /* FILETIME */

#define mlw_time_ticks_per_sec 10000000
#define two_to_32 ((double)(1 << 16) * (double)(1 << 16))

extern mlval mlw_time_from_file_time(FILETIME *);
extern void  mlw_time_to_file_time(mlval, FILETIME *);
extern void  mlw_time_to_timeval(mlval, struct timeval *);
extern mlval mlw_time_from_double(double);
extern mlval mlw_time_make(long secs, long usecs); /* ALLOCATES */

#endif /* !time_date_h */
