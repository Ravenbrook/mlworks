/*  ==== C WORD OPERATORS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Word manipulation operators are required by the Initial Basis. Words
 *  represent unsigned natural numbers of a certain size.  As a first-cut
 *  implementation, this is provided via operations in C.  This will be
 *  slow - however, these could eventually be inlined and treated like our
 *  pervasive operators.
 *  
 *  Revision Log
 *  ------------
 *  $Log: words.h,v $
 *  Revision 1.3  1995/09/04 10:32:23  daveb
 *  Changed unsigned to word.
 *
 * Revision 1.2  1995/04/03  12:07:13  brianm
 * Adding num_to_word32() word32_to_num().
 * Updating to use allocate_word32() and CWORD32().
 * Made code more GC-safe by moving allocation to end of functions.
 *
 * Revision 1.1  1995/03/16  18:34:05  brianm
 * new unit
 * New file.
 *
 *
 */

#ifndef words_h
#define words_h

#include "mltypes.h"

extern void     words_init(void);
extern void     num_to_word32(word, mlval);
extern word  	word32_to_num(mlval);

#endif
