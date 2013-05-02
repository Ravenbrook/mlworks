/*
 * ==== Architecture dependent ML VALUE TOOLS ====
 *		SPARC
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * Description
 * -----------
 * These macros are used by other SPARC assembly language routines in
 * the ML to C interface and the C language routines for loading.
 * They deal with code vectors.
 *
 * $Log: mach_values.h,v $
 * Revision 1.6  1997/05/30 09:29:57  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.5  1995/09/01  13:57:38  nickb
 * Add CCODE_UNIT_SIZE
 *
 * Revision 1.4  1995/08/31  13:43:46  nickb
 * Add INTERCEPT_LENGTH.
 *
 * Revision 1.3  1994/10/05  10:40:12  jont
 * Add change_code_endian for use by loader.c
 *
 * Revision 1.2  1994/08/25  10:08:29  matthew
 * Increase CCODE_NUMBER_BITS to 10
 *
 * Revision 1.1  1994/07/25  15:58:03  jont
 * new file
 *
 */

#ifndef mach_values_h
#define mach_values_h

#define CCODE_NONGC_BITS	16
#define CCODE_SAVES_BITS	0
#define CCODE_NUMBER_BITS	10
#define CCODE_ARGS_BITS         0 /* Only non-zero on I386 */

/* The next few macros calculate the sizes and offsets of the other
fields; they're used in other macros in this file but shouldn't be
used directly.
 */

#define CCODE_INTERCEPT_BITS	(31 - CCODE_NONGC_BITS - CCODE_ARGS_BITS - CCODE_SAVES_BITS - CCODE_NUMBER_BITS)
#define CCODE_LEAF_BIT		(31 - CCODE_NONGC_BITS - CCODE_ARGS_BITS - CCODE_SAVES_BITS)
#define CCODE_NONGC_SHIFT	(32 - CCODE_NONGC_BITS)
#define CCODE_SAVES_SHIFT	(32 - CCODE_NONGC_BITS - CCODE_ARGS_BITS - CCODE_SAVES_BITS)
#define CCODE_INTERCEPT_SHIFT	CCODE_NUMBER_BITS
#define CCODE_INTERCEPT_MASK	((1 << CCODE_INTERCEPT_BITS)-1)
#define CCODE_ARGS_SHIFT	(32-CCODE_NONGC_BITS-CCODE_ARGS_BITS)

/* Now we get on to macros used out there in the runtime system:

CCODE_MAX_<field> is the maximum valid number in a field.
CCODE_NO_INTERCEPT is the value placed in the 'intercept' field of a
code item not compiled for tracing or call-counting.
*/

#define CCODE_MAX_NUMBER	((1 << CCODE_NUMBER_BITS)-1)
#define CCODE_MAX_SAVES		((1 << CCODE_SAVES_BITS)-1)
#define CCODE_MAX_NONGC		((1 << CCODE_NONGC_BITS)-1)
#define CCODE_MAX_ARGS		((1 << CCODE_ARGS_BITS)-1)
#define CCODE_MAX_INTERCEPT	(CCODE_INTERCEPT_MASK -1)
#define CCODE_NO_INTERCEPT	CCODE_INTERCEPT_MASK

#define change_code_endian	1

#define INTERCEPT_LENGTH	SPARC_INTERCEPT_LENGTH

#define CCODE_UNIT_SIZE		4

#endif
