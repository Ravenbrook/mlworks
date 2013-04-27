/*  ==== PERVASIVE INTEGERS ====
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
 *  Revision Log
 *  ------------
 *  $Log: integers.c,v $
 *  Revision 1.12  1996/04/30 12:49:07  matthew
 *  Adding some useful functions
 *
 * Revision 1.11  1996/04/19  13:58:52  matthew
 * Exception overflow
 *
 * Revision 1.10  1996/02/09  14:22:04  jont
 * Modify int32 divide to raise Overflow on max neg div ~1
 *
 * Revision 1.9  1996/02/06  15:13:35  jont
 * Alter int32_mod to raise Mod on mod by 0
 *
 * Revision 1.8  1996/01/31  13:16:04  jont
 * Add overflow detection to 32 bit integer operations
 *
 * Revision 1.7  1995/09/15  16:20:37  daveb
 * Corrected printing of negative 32-bit integers.
 *
 * Revision 1.6  1995/09/15  10:51:02  daveb
 * Added int32_to_string.
 *
 * Revision 1.5  1995/09/11  14:15:19  daveb
 * Updated for built-in int32 type.
 *
 * Revision 1.4  1994/11/22  16:02:28  matthew
 * Added possible assembler division function
 *
 * Revision 1.3  1994/09/09  16:21:40  nickb
 * Change integer multiply to a pure asm routine, with no C indirection.
 *
 * Revision 1.2  1994/06/09  14:50:23  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:24:46  nickh
 * new file
 *
 *  Revision 1.4  1994/01/28  17:39:20  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.3  1993/11/18  13:26:00  daveb
 *  Added handler for SIGEMT traps, which are raised when tagged integer
 *  operations overflow.
 *
 *  Revision 1.2  1993/02/01  16:04:45  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.1  1992/10/23  16:14:36  richard
 *  Initial revision
 *
 */

#include "integers.h"
#include "mltypes.h"
#include "values.h"
#include "exceptions.h"
#include "environment.h"
#include "syscalls.h"
#include "diagnostic.h"
#include "exceptions.h"
#include "interface.h"
#include "utils.h"
#include "mach.h"

#include "words.h"
#include "allocator.h"
#include "alloc.h"
#include "sys_types.h"

#ifndef MACH_INT_MUL

static mlval multiply (mlval argument)
{
  int arg1 = CINT(FIELD(argument, 0));
  int arg2 = CINT(FIELD(argument, 1));

  double prod = ((double) arg1) * ((double) arg2);
  if ((prod > (double) ML_MAX_INT))
    exn_raise(perv_exn_ref_overflow);
  else if (prod < (double) ML_MIN_INT)
    exn_raise(perv_exn_ref_overflow);
  else
    return MLINT((int)prod);
}

#endif

#ifndef MACH_INT_DIV

static mlval divide (mlval argument)
{
  int divisor = CINT(FIELD(argument, 0));
  int dividend = CINT(FIELD(argument, 1));
  int answer, remainder;

  if(dividend == 0)
    exn_raise(perv_exn_ref_div);

  if((dividend+1)==0 && divisor==0xE0000000)
    exn_raise(perv_exn_ref_overflow);

  answer = divisor/dividend;
  remainder = divisor - answer*dividend;
  if((remainder > 0 && dividend < 0) || (remainder < 0 && dividend > 0))
    answer -= 1; /* Shift into correct range */

  return(MLINT(answer));
}

static mlval modulo (mlval argument)
{
  int divisor = CINT(FIELD(argument, 0));
  int dividend = CINT(FIELD(argument, 1));
  int answer;

  if(dividend == 0)
    exn_raise(perv_exn_ref_div);

  answer = divisor%dividend;
  if ((answer > 0 && dividend < 0) || (answer < 0 && dividend > 0))
    answer += dividend; /* Shift into correct range */

  return(MLINT(answer));
}

#endif

static mlval int32_mul(mlval argument)
{
  int *val1 = CWORD32(FIELD(argument,0)),
      *val2 = CWORD32(FIELD(argument,1));
  mlval result;
  double prod = ((double) *val1) * ((double) *val2);
  if ((prod > (double) ML_MAX_INT32))
    exn_raise(perv_exn_ref_overflow);
  else if (prod < (double) ML_MIN_INT32)
    exn_raise(perv_exn_ref_overflow);

  result = allocate_word32();
  num_to_word32((word)prod,result);

  return(result);
}

static mlval int32_to_int (mlval arg)
{
  int n = *CWORD32(arg);
  if ((n > ML_MAX_INT) || (n < ML_MIN_INT))
    exn_raise (perv_exn_ref_overflow);
  return (MLINT (n));
}

static mlval int_to_int32 (mlval arg)
{
  int n = CINT (arg);
  mlval result = allocate_word32();
  num_to_word32 ((word)n,result);
  return (result);
}

static mlval int32_div(mlval argument)
{
  int answer,
      remainder,
      *divisor = CWORD32(FIELD(argument,0)),
      *dividend = CWORD32(FIELD(argument,1));
  mlval result;

  if (*dividend == 0u) exn_raise(perv_exn_ref_div);
  if((*dividend+1)==0 && *divisor==ML_MIN_INT32)
    exn_raise(perv_exn_ref_overflow);

  answer = (*divisor / *dividend);
  remainder = *divisor - answer * *dividend;
  if((remainder > 0 && *dividend < 0) || (remainder < 0 && *dividend > 0))
    answer -= 1; /* Shift into correct range */


  result = allocate_word32();
  num_to_word32((uint32)answer,result);

  return(result);
}

static mlval int32_mod(mlval argument)
{
  int answer,
     *divisor = CWORD32(FIELD(argument,0)),
     *dividend = CWORD32(FIELD(argument,1));
  mlval result;

  if (*dividend == 0u) exn_raise(perv_exn_ref_div);

  answer = (*divisor % *dividend);
  if ((answer > 0 && *dividend < 0) || (answer < 0 && *dividend > 0))
    answer += *dividend; /* Shift into correct range */

  result = allocate_word32();
  num_to_word32((uint32)answer,result);

  return(result);
}

void integers_init(void)
{
#ifdef MACH_INT_MUL
  env_asm_function("integer multiply", mach_int_mul);
#else
  env_function("integer multiply", multiply);
#endif

#ifdef MACH_INT_DIV
  env_asm_function ("integer divide",mach_int_div);
  env_asm_function ("integer modulo",mach_int_mod);
#else
  env_function("integer divide", divide);
  env_function("integer modulo", modulo);
#endif

  env_function("int32 multiply", int32_mul);
  env_function("int32 divide", int32_div);
  env_function("int32 modulo", int32_mod);

  env_function("int int_to_int32",int_to_int32);
  env_function("int int32_to_int",int32_to_int);
}

