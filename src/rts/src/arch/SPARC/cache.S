/*
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * Description
 * -----------
 *
 * cache_flush ensures that any writes to the specified portion of 
 * instruction memory are reflected in the instruction cache i.e.
 * it may result in one or more lines of the instruction cache being flushed.
 *
 * Revision Log
 * ------------
 * $Log: cache.S,v $
 * Revision 1.3  1996/01/11 12:12:57  stephenb
 * Replace "flush" with "iflush" since the latter works for Solaris
 * and SunOS whereas the former only seems to work under Solaris.
 *
 * Revision 1.2  1996/01/10  14:07:24  stephenb
 * Adding a comment noting that #bytes should be > 0.
 *
 * Revision 1.1  1996/01/10  12:13:53  stephenb
 * new unit
 * Performs instruction cache flushing.
 *
 *
 */

#include "naming.h"

/* cache_flush
**
** inputs
**   %o0 - address at which to start flushing
**   %o1 - number of -bytes- (not words) to flush.
**
** outputs
**   none
**
** trashes
**   %o0, %o1
**
** assumptions
**   %o1 > 0 i.e. at least one byte needs to be flushed.
**   if %o1 is 0 then the double-word pointed to by %o0 will still be flushed.
**   You have been warned!
**
** The following may profit from some loop unrolling.
*/
	.global C_NAME(cache_flush)
C_NAME(cache_flush):  
	srl	%o1, 2, %o1
loop:	subcc	%o1, 8, %o1
	ble	finish
	iflush	%o0
	ba	loop
	add	%o0, 8, %o0
finish:	retl
	nop
