/*  ==== Linker naming macros ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 * This header defines a macro which produces a label for a C object,
 * as produced by the C compiler (and expected by the linker) on this
 * OS. It is used in the asm interface, as shown in these two examples:
 * 
 * 	.global C_NAME(ml_gc)
 * 
 * 	call C_NAME(gc)
 * 
 *  $Id: naming.h,v 1.1 1994/07/08 11:17:21 nickh Exp $
 */

#ifndef naming_h
#define naming_h

/* C_NAME(x) produces a name for an item referred to simply as 'x' in
C code, by which it can be referred to in asm code. */

#define C_NAME(nm)	_ ## nm

#endif /* naming_h */
