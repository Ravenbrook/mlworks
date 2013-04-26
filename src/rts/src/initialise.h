/*
 * initialise.h
 * Initialise the run-time system.
 * $Log: initialise.h,v $
 * Revision 1.3  1996/08/27 14:23:18  nickb
 * storeman arguments no longer passed to initializer.
 *
 * Revision 1.2  1994/06/09  14:39:10  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:06:27  nickh
 * new file
 *
 * Revision 1.4  1993/06/02  13:04:06  richard
 * Improved the use of const in the argv argument type.
 *
 * Revision 1.3  1993/04/30  12:36:44  richard
 * Multiple arguments can now be passed to the storage manager in a general
 * way.
 *
 * Revision 1.2  1992/03/12  12:28:07  richard
 * Added top_generation parameter.
 *
 * Revision 1.1  1991/10/23  15:26:52  davidt
 * Initial revision
 *
 * 
 * Copyright (c) Harlequin 1991.
 */


#ifndef initialise_h
#define initialise_h

#include <stddef.h>

void initialise(void);

#endif
