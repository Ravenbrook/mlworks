/*  ==== TIME ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
