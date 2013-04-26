/*  ==== C LANGUAGE EXTENSIONS ====
 *
 *  Copyright (C) 1992 Harleqiun Ltd.
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


#ifdef __GNUC__
#  define inline	__inline__
#  define nonreturning(return_type,function_name,args) \
	return_type function_name args __attribute__ ((noreturn))
#  define data_aligned(x,alignment) x __attribute__ ((aligned (alignment)))
#else
#  define inline
#  define nonreturning(return_type, function_name,args) \
	return_type function_name args
#  define data_aligned(x,alignment) x
#endif


#endif
