/*
 * ==== CREATE A DUMMY COFF SECTION FOR ML HEAP ====
 *		I386 version
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
