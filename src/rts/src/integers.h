/*  ==== PERVASIVE INTEGERS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: integers.h,v $
 *  Revision 1.2  1994/06/09 14:50:42  nickh
 *  new file
 *
 * Revision 1.1  1994/06/09  11:25:11  nickh
 * new file
 *
 *  Revision 1.1  1992/10/23  16:14:55  richard
 *  Initial revision
 *
 */

#ifndef integers_h
#define integers_h

#include "mltypes.h"

extern void integers_init(void);

/* The function to call when the asm implementation of integer
 * multiply detects an overflow condition. It raises Prod.
 *
 * arg1 and arg2 are the arguments to multiply, hi and lo are partial
 * products. */

extern mlval multiply_overflow_fn(int arg1, int arg2, int lo, int hi);


#endif
