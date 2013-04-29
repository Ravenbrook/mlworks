/*  ==== C LANGUAGE EXTENSIONS ====
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
 *  This header declares macros which allow optimising extensions of the C
 *  language to be used in conjunction with certain compilers, most notably,
 *  GCC.  On compilers which do not support the extensions the macros are
 *  defined to have no effect.  The macros defined are as follows:
 *
 *    `inline'
 *      Can be placed on functions to cause them to be inlined.  Not to be
 *      used  with `extern'.
 *
 *    `nonreturning(return_type,function_name,arguments)'
 *      Used to construct a function prototype which indicates that
 *      the function never returns, e.g.
 *      "nonreturning(extern void, exit, (int return_value))"
 *
 *    `data_aligned(variable,alignment)'
 *      Used in a declaration to indicate that 'variable' should be aligned:
 *	for instance the declaration 'struct foo data_aligned(x,16)'
 *      declares a struct foo called x aligned on a 16-byte boundary.
 *
 *  $Id: extensions.h,v 1.4 1994/10/19 15:25:19 nickb Exp $ */


#ifndef extensions_h
#define extensions_h


#if defined(__GNUC__)
#  define inline	__inline__
#  define nonreturning(return_type,function_name,args) \
	return_type function_name args __attribute__ ((noreturn))
#  define data_aligned(x,alignment) x __attribute__ ((aligned (alignment)))
#elif defined(_MSC_VER)
#  define inline __inline
#  define nonreturning(return_type,function_name,args) \
  __declspec(noreturn) return_type function_name args
#  define data_aligned(x,alignment) x
#else
#  define inline
#  define nonreturning(return_type, function_name,args) \
	return_type function_name args
#  define data_aligned(x,alignment) x
#endif


#endif
