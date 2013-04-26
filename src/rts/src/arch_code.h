/* rts/src/arch_code.h
 *
 * Functions for recognising and manipulating architecture-specific code
 * sequences.
 * 
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: arch_code.h,v $
 * Revision 1.1  1995/07/19 13:34:39  nickb
 * new unit
 * dinking about with bits of machine code.
 *
 */

#include "mltypes.h"

extern int arch_space_profile_code(mlval codepointer);
extern int arch_space_unprofile_code(mlval codepointer);
