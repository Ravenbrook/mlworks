/*  ==== ASSEMBLY-LANGUAGE FUNCTIONS ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  Declarations for assembly-language functions.
 *
 *  Revision Log
 *  ------------
 *  $Log: mach_fixup.h,v $
 *  Revision 1.2  1994/06/09 14:52:20  nickh
 *  new file
 *
 * Revision 1.1  1994/06/09  11:27:28  nickh
 * new file
 *
 *  Revision 1.1  1992/10/23  16:14:55  richard
 *  Initial revision
 *
 */

#ifndef mach_fixup_h
#define mach_fixup_h

#ifdef MACH_FIXUP

#include "mltypes.h"

/* Fixup function; the core of the GC. Defined in mach_fixup.S, q.v. */

extern mlval *mach_fixup(mlval *to, mlval *what, mlval value);

#endif /* MACH_FIXUP */

#endif /* mach_fixup_h */
