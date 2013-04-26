/*  === PERVASIVE EXCEPTIONS ===
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This module declares the exceptions which are visible in the pervasive
 *  environment, as well as some utilities for manipulating them.
 *
 *  Revision Log
 *  ------------
 *  $Log: exceptions.h,v $
 *  Revision 1.12  1998/03/26 16:20:20  jont
 *  [Bug #30090]
 *  Remove perv_exn_ref_io
 *
 * Revision 1.11  1997/05/22  08:33:54  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr to include an ml string.
 *
 * Revision 1.10  1996/06/04  13:30:20  io
 * add exn Size
 *
 * Revision 1.9  1996/04/22  14:20:56  stephenb
 * exn_raise_syserr: change the second argument to an int and
 * make it raise (string * NONE) if the int is 0.
 *
 * Revision 1.8  1996/04/19  09:57:10  matthew
 * Removing some exceptions
 *
 * Revision 1.7  1996/03/29  10:22:23  stephenb
 * Add exn_raise_syserror and corresponding exception to support
 * latest verison of OS.* in the basis.
 *
 * Revision 1.6  1996/01/16  12:08:10  nickb
 * Remove StorageManager exception.
 *
 * Revision 1.5  1995/07/20  16:36:41  jont
 * Add exception Overflow
 *
 * Revision 1.4  1995/03/15  17:37:16  nickb
 * Add threads exception.
 *
 * Revision 1.3  1994/10/19  15:21:24  nickb
 * The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.2  1994/06/09  14:50:07  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:24:27  nickh
 * new file
 *
 *  Revision 1.6  1993/07/23  11:12:08  richard
 *  Added X exception.
 *
 *  Revision 1.5  1993/04/20  12:44:25  richard
 *  Removed obsolete CLMError exception.  Added Unix and Trace exceptions.
 *  Added exn_raise_strings() to deal with errors from streams.c.
 *
 *  Revision 1.4  1993/04/02  14:17:00  jont
 *  New exception for bad iage when reading table of contents
 *
 *  Revision 1.3  1993/03/31  16:59:52  jont
 *  Made the size of the exception string buffer a #define value
 *
 *  Revision 1.2  1993/01/05  16:44:07  richard
 *  Added more floating point exceptions.
 *
 *  Revision 1.1  1992/11/02  14:51:15  richard
 *  Initial revision
 *
 */

#ifndef exceptions_h
#define exceptions_h

#include "mltypes.h"
#include "extensions.h"


extern void exn_init(void);


/*  === SPECIAL EXCEPTIONS ===
 *
 *  The default exception is the exception packet to which all the pervasive
 *  exceptions are initialised.
 */

extern mlval exn_default;


/*  === PERVASIVE EXCEPTIONS ===
 *
 *  The pervasive exceptions are actually ref cells containing objects of
 *  type `exn', i.e. contianing fully applied exception packets.  This is so
 *  they can be altered by the ML code itself.
 */

extern mlval perv_exn_ref_size;
extern mlval perv_exn_ref_div;
extern mlval perv_exn_ref_overflow;
extern mlval perv_exn_ref_substring;
extern mlval perv_exn_ref_profile;
extern mlval perv_exn_ref_save;
extern mlval perv_exn_ref_value;
extern mlval perv_exn_ref_load;
extern mlval perv_exn_ref_table;
extern mlval perv_exn_ref_string_to_real;
extern mlval perv_exn_ref_ln;
extern mlval perv_exn_ref_abs;
extern mlval perv_exn_ref_exp;
extern mlval perv_exn_ref_sqrt;
extern mlval perv_exn_ref_unbound;
extern mlval perv_exn_ref_signal;
extern mlval perv_exn_ref_trace;
extern mlval perv_exn_ref_threads;
extern mlval perv_exn_ref_syserr;

/*  === EXCEPTION RAISERS ===
 *
 *  These are convenience functions for c_raise in the ML interface.
 *  The total length of the formatted string produced by exn_raise_format()
 *  cannot exceed 2Kb-1.
 *
 *  NOTE: exn_raise_format does not perform any allocation until it has
 *  finished reading all its parameters.  It is therefore safe to feed it
 *  unrooted parts of ML values.
 */

nonreturning(extern void, exn_raise, (mlval exn_ref));
nonreturning(extern void, exn_raise_ml_string, (mlval exn_ref, mlval ml_str));
nonreturning(extern void, exn_raise_string, (mlval exn_ref, const char *string));
nonreturning(extern void, exn_raise_strings, (mlval exn_ref, ...));
nonreturning(extern void, exn_raise_int, (mlval exn_ref, int i));
nonreturning(extern void, exn_raise_format, (mlval exn_ref, const char *format, ...));
nonreturning(extern void, exn_raise_syserr, (mlval, int));

#define EXN_RAISE_FORMAT_BUFFER_SIZE 2047

#endif
