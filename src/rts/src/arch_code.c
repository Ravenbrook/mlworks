/* rts/src/arch_code.c
 *
 * Dummy version of rts/src/arch/$ARCH/arch_code.c, for those architectures
 * which don't yet have the real thing.
 * 
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: arch_code.c,v $
 * Revision 1.1  1995/07/19 13:33:35  nickb
 * new unit
 * dinking about with bits of machine code.
 *
 */

#include "arch_code.h"

extern int arch_space_unprofile_code(mlval codepointer)
{
  return 0;
}
    
extern int arch_space_profile_code(mlval codepointer)
{
  return 0;
}
