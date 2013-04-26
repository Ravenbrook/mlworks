/*
 * ==== CREATE A DUMMY COFF SECTION FOR ML HEAP ====
 *		I386 version
 *
 * Copyright (C) 1995 Harlequin Ltd
 *
 * Description
 * -----------
 * This is just to force the linker to create an extra COFF section.
 * There seems to be a gas/link interaction problem, such that
 * this file must contain at least one external reference. Hence
 * the dummy text section.
 *
 * $Log: heap.S,v $
 * Revision 1.2  1997/06/16 14:02:29  andreww
 * [Bug #30045]
 * Altering dummy global name to one that actually appears in the
 * rts stub.
 *
# Revision 1.1  1995/11/28  13:27:48  jont
# new unit
#
 *
 */

#include "mach_values.h"
#include "macros.h"

dummy:
	lea	(C_NAME(image_continuation)), %eax
	.section	ML_HEAP	/* All we need is the name, no data yet */
	.long	0		/* But we need a little data, otherwise */
				/* the linker throws it away */
				/* However, the linker does not retain this data */