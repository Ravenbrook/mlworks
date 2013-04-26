/* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * The C header file that would need to be included by any C (generated)
 * file -- typically this would be #included in a generated stub, but 
 * it could also be explicitly #included by a user if necessary.
 *
 *.free-standing: To enable this file to be #included by client code it
 * cannot reference any MLWorks runtime header files.  Consequently there
 * is currently some duplication between values defined here and those
 * found in some MLWorks runtime headers.  Where possible the values in
 * the MLWorks runtime headers should be redefined in terms of the values
 * given here.
 *
 *
 * Revision Log
 * ------------
 * $Log: mlw_ci.h,v $
 * Revision 1.4  1999/03/17 17:25:46  johnh
 * [Bug #190529]
 * Add support (expose declaring/retracting of gc roots) for stub generator.
 *
 * Revision 1.3  1998/10/15  12:53:17  jont
 * [Bug #20139]
 * Fix mlw_val_int_to_int to work with negative ints
 *
 * Revision 1.2  1997/07/01  14:12:42  stephenb
 * [Bug #30029]
 * Lots of renaming
 *
 * Revision 1.1  1997/05/07  08:24:16  stephenb
 * new unit
 * [Bug #30030]
 *
 */


/*
** Normally I'd do the following by putting the OS specific parts in 
** different files and #including them and using the include path to
** pick up the right one.  However this file is going out to customers
** and so it is preferable to just have one file.
*/

#ifdef _WIN32
#define mlw_ci_export  __declspec( dllexport )
#define mlw_ci_import  __declspec( dllimport )
#else
#define mlw_ci_export
#define mlw_ci_import
#endif


/* From values.h */

typedef unsigned int mlw_val;

#define mlw_val_primary_tag_even_int 0
#define mlw_val_primary_tag_pair     1
#define mlw_val_primary_tag_header   2
#define mlw_val_primary_tag_ref      3
#define mlw_val_primary_tag_odd_int  4
#define mlw_val_primary_tag_pointer  5


/* values.h#PRIMARY */
#define mlw_val_primary_tag(v) ((mlw_val(v)) & 7)


/* Integer */

#define mlw_val_int_bits 30
#define mlw_val_int_max ((1<<(mlw_val_int_bits-1)) - 1)
#define mlw_val_int_min (-(1<<(mlw_val_int_bits-1)))

#define mlw_val_int_from_int(x) ((x)<<2)
#define mlw_val_int_to_int(x) (((int)(x))>>2)


/* Char */

#define mlw_val_char_from_char(x) ((x)<<2)
#define mlw_val_char_to_char(x) ((x)>>2)


/* Word */

#define mlw_val_word_bits 30
#define mlw_val_word_max ((1<<(mlw_val_word_bits)) - 1)
#define mlw_val_word_min 0

#define mlw_val_word_from_uint(x) ((x)<<2)
#define mlw_val_word_to_uint(x) ((x)>>2)


/* Unit */

#define mlw_val_unit mlw_val_int_from_int(0)


#define mlw_val_hdr_length(r) ((r)>>6)

/* Record */

#define mlw_val_rec_length(r) \
  mlw_val_hdr_length(*(mlval *)((r)-mlw_val_primary_tag_pointer))

#define mlw_val_rec_nfields(r)                              \
  ((mlw_val_primary_tag(r) == mlw_val_primary_tag_pointer)  \
    ? 2                                                     \
    : mlw_val_rec_length(r)

#define mlw_val_rec_field(r, i) (((mlw_val *)((r) - 1))[i])


/* String */

#define mlw_ci_str_to_charp(s) (((char *)(s)) -1)
#define mlw_ci_str_length(s) \
  mlw_val_hdr_length(*((mlw_val *)((s)-mlw_val_primary_tag_pointer)))


/* CharVector */

#define mlw_ci_char_vector_to_charp(s) mlw_ci_str_to_charp(s)
#define mlw_ci_char_vector_length(s) mlw_ci_str_length(s)


/* CharArray */

#define mlw_ci_char_array_to_charp(s) \
  ((((char *)(s)) - mlw_val_primary_tag_ref) + 4)

#define mlw_ci_char_array_length(s) \
  mlw_val_hdr_length(*((mlw_val *)((s)-mlw_val_primary_tag_ref)))



/* RealArray */

#define mlw_ci_real_array_to_doublep(s) \
  ((double *)((((char *)(s)) - mlw_val_primary_tag_ref) + 8))

#define mlw_ci_real_array_length(s) \
  mlw_val_hdr_length(*((mlw_val *)((s)-mlw_val_primary_tag_ref)))



/* RealVector */

#define mlw_ci_real_vector_to_doublep(s) \
  ((double *)((((char *)(s)) - mlw_val_primary_tag_ref) + 8))

#define mlw_ci_real_vector_length(s) \
  mlw_val_hdr_length(*((mlw_val *)((s)-mlw_val_primary_tag_ref)))




extern mlw_ci_export mlw_val mlw_ci_boxi_make(unsigned int);
extern mlw_ci_export mlw_val mlw_ci_real_make(double);
extern mlw_ci_export mlw_val mlw_ci_raise_syserr(int);
extern mlw_ci_export mlw_val mlw_ci_tuple_make(int);
extern mlw_ci_export void declare_gc_root(mlw_val);
extern mlw_ci_export void retract_gc_root(mlw_val);

#define mlw_ci_word32_to_uint(w) (*((unsigned int *)mlw_ci_str_to_charp(w)))
#define mlw_ci_word32_from_uint(ui) mlw_ci_boxi_make(ui)


/* MLWorksCInterface.Char.char */

#define mlw_ci_char_to_char(x)    ((x)>>2)
#define mlw_ci_char_from_char(x)  ((x)<<2)


/* MLWorksCInterface.Uchar.word */

#define mlw_ci_uchar_to_uchar(x)    ((x)>>2)
#define mlw_ci_uchar_from_uchar(x)  ((x)<<2)


/* MLWorksCInterface.Ushort.word */

#define mlw_ci_ushort_to_ushort(x)   ((x)>>2)
#define mlw_ci_ushort_from_ushort(x) ((x)<<2)


/* MLWorksCInterface.short.int */

#define mlw_ci_short_to_short(x)   ((x)>>2)
#define mlw_ci_short_from_short(x) ((x)<<2)

/* MLWorksCInterface.Uint.word */

#define mlw_ci_uint_to_uint(w)    mlw_ci_word32_to_uint(w)
#define mlw_ci_uint_from_uint(ui) mlw_ci_word32_from_uint(ui)


/* MLWorksCInterface.Int.int */

#define mlw_ci_int_to_int(i)   ((int)mlw_ci_word32_to_uint(i))
#define mlw_ci_int_from_int(i) mlw_ci_word32_from_uint((unsigned int)i)


/* MLWorksCInterface.Long.int */

#define mlw_ci_long_to_long(w)   ((long)mlw_ci_word32_to_uint(w))
#define mlw_ci_long_from_long(i) mlw_ci_word32_from_uint((unsigned long)i)


/* MLWorksCInterface.Ulong.word */

#define mlw_ci_ulong_to_ulong(w)    mlw_ci_word32_to_uint(w)
#define mlw_ci_ulong_from_ulong(ul) mlw_ci_word32_from_uint(ul)


/* real */

#define mlw_ci_real_to_double(r) (*((double *)(mlw_ci_str_to_charp(r)+4)))
#define mlw_ci_real_from_double(r) mlw_ci_real_make(r)


/* Option */

#define mlw_val_option_make_none() (mlw_val_int_from_int(0))
#define mlw_val_option_is_none(opt) ((opt) == mlw_val_int_from_int(0))
#define mlw_val_option_some(opt) mlw_val_rec_field(opt, 1)


#include <stdlib.h>		/* malloc, realloc, free */



/* Function Argument */
#define mlw_arg(arg, n) mlw_val_rec_field(arg, n)


/* MLWorksCInterface.VoidPtr */

#define mlw_ci_void_ptr_to_voidp(vp) \
  ((void *)(*((unsigned int *)mlw_ci_str_to_charp(vp))))
#define mlw_ci_void_ptr_from_voidp(vp) \
  mlw_ci_boxi_make((unsigned int)vp)


/* MLWorksCInterface.CharPtr */

#define mlw_ci_char_ptr_to_charp(cp) \
  ((char *)mlw_ci_void_ptr_to_voidp(cp))

#define mlw_ci_char_ptr_from_charp(cp) \
  mlw_ci_void_ptr_from_voidp((void *)cp)


/* From "environment.h" */

extern mlw_ci_export mlw_val
mlw_bind_function(const char *, mlw_val (*)(mlw_val));

#define mlw_ci_register_function(name, fn) \
  mlw_bind_function(name, fn)
