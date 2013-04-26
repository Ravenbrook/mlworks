/*  ==== PERVASIVE VALUE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: value.h,v $
 *  Revision 1.3  1994/10/19 15:37:58  nickb
 *  The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.2  1994/06/09  14:54:46  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:31:08  nickh
 * new file
 *
 *  Revision 1.1  1992/10/26  12:54:52  richard
 *  Initial revision
 *
 */

#ifndef value_h
#define value_h

#include "extensions.h"
#include "mltypes.h"

/* Initialize */

extern void value_init(void);

/* An integer which gets set to one if polymorphic equality is used to
 * compare two distinct function objects */

extern int ml_eq_function;

/* A function callable by the assembly-language function poly_equal to
 * report an error */

nonreturning(extern void, poly_equal_error, (mlval left, mlval right));

#endif
