/*  ==== ASSEMBLY-LANGUAGE FUNCTIONS ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  Declarations for assembly-language functions.
 *
 *  Revision Log
 *  ------------
 *  $Log: mach.h,v $
 *  Revision 1.4  1994/11/22 16:02:03  matthew
 *  Added possible assembler division function
 *
 * Revision 1.3  1994/09/13  14:57:17  nickb
 * Change mach_ovfl_mul (now an asm routine called direct from ML).
 *
 * Revision 1.2  1994/06/09  14:37:45  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:04:41  nickh
 * new file
 *
 *  Revision 1.1  1992/10/23  16:14:55  richard
 *  Initial revision
 *
 */

#ifndef mach_h
#define mach_h

#ifdef MACH_INT_MUL

/* Integer multiplication, defined in intmul.S, used in integers.c */

extern mlval mach_int_mul(mlval arg_pair);

#endif /* MACH_INT_MUL */

#ifdef MACH_INT_DIV

/* Integer division, defined in intmul.S, used in integers.c */

extern mlval mach_int_div(mlval arg_pair);
extern mlval mach_int_mod(mlval arg_pair);

#endif /* MACH_INT_DIV */

#if defined(MACH_POLY_EQ) || defined (MACH_STRINGS)

/* Polymorphic equality, defined in poly_equal.S, used in value.c, strings.c */

extern mlval poly_equal (mlval arg_pair);
extern mlval poly_not_equal (mlval arg_pair);

#endif /* MACH_POLY_EQ */

#ifdef MACH_STRINGS

/* String comparisons, defined in poly_equal.S, used in strings.c */

extern mlval ml_string_less (mlval arg_pair);
extern mlval ml_string_greater (mlval arg_pair);

#endif /* MACH_STRINGS */

/* For other assembly-language stuff see interface.[hS], mach_fixup.[hS] */

#endif /* mach_h */
