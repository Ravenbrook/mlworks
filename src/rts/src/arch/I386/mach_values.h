/*
 * ==== Architecture dependent ML VALUE TOOLS ====
 *		I386
 *
 * Copyright (C) 1994 Harlequin Ltd.
 *
 * Description
 * -----------
 * These macros are used by other I386 assembly language routines in
 * the ML to C interface and the C language routines for loading.
 * They deal with code vectors.
 *
 * $Log: mach_values.h,v $
 * Revision 1.8  1997/06/03 09:24:41  jont
 * [Bug #30076]
 * [Bug #30076]
 * Modifications to allow 3 bites of information for nmber of stack arguments
 *
 * Revision 1.7  1997/05/30  12:11:48  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.6  1995/09/01  13:58:12  nickb
 * Add CCODE_UNIT_SIZE
 *
 * Revision 1.5  1995/08/31  13:44:33  nickb
 * Add INTERCEPT_LENGTH.
 *
 * Revision 1.4  1994/12/08  13:47:20  matthew
 * Added REVERSE_REAL_BYTES flag to control real to bytestring conversion
 *
 * Revision 1.3  1994/10/19  17:52:51  jont
 * Fix problems with too many code vectors
 *
 * Revision 1.2  1994/10/10  15:57:30  jont
 * Sort out interception bits etc
 *
 * Revision 1.1  1994/10/04  16:52:52  jont
 * new file
 *
 */

#ifndef mach_values_h
#define mach_values_h

/* If defined, reverse real bytes when converting from real to byte string */
#define REVERSE_REAL_BYTES

#define CCODE_NONGC_BITS	8
#define CCODE_SAVES_BITS	2
#define CCODE_NUMBER_BITS	10
#define CCODE_ARGS_BITS         3

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

#define change_code_endian	0

#define INTERCEPT_LENGTH	I386_INTERCEPT_LENGTH

#define CCODE_UNIT_SIZE		1

#endif
