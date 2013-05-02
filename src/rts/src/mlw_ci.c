/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * The C side of the C<->ML Interface.
 *
 *.builtin: various functions defined here should be builtin to
 * the compiler for improved performance.
 *
 *.os: The interface is split into two parts, the OS independent part which
 * resides in this file and the OS dependent part which resides in mlw_ci_os.c
 * The split has been done such that the only function that the OS part
 * exports is the initialisation function (mlw_ci_os_init).  An alternative
 * would be do all initialisation here and have the OS dependent part export
 * those functions that need to be registered.  There are pros and cons
 * either way.  If the current mechanism is too constraining, then by all
 * means change to the alternative one.
 *
 * Revision Log
 * ------------
 *
 * $Log: mlw_ci.c,v $
 * Revision 1.2  1997/07/01 14:13:39  stephenb
 * [Bug #30029]
 * Renaming
 *
 * Revision 1.1  1997/04/30  14:14:09  stephenb
 * new unit
 * [Bug #30030]
 *
 */

#include <string.h>		/* memcpy */
#include "alloc.h"		/* malloc, free, realloc */
#include "allocator.h"		/* allocate_word32, allocate_string */
#include "values.h"		/* CWORD32 */
#include "gc.h"			/* declare_root, retract_root */
#include "environment.h"	/* env_function */
#include "mlw_ci.h"
#include "mlw_ci_init.h"	/* mlw_ci_init */
#include "mlw_ci_os_init.h"	/* mlw_ci_os_init */
#include "mlw_ci_io.h"		/* mlw_ci_io_init */



/*
** A generic boxed integer constructor -- allocates in ML heap.
** With the assumption that sizeof(int) == sizeof(long) == ... etc.,
** and with enough casts, this can be used to construct all boxed 
** values.
*/
mlw_ci_export mlw_val mlw_ci_boxi_make(unsigned int i)
{
  mlw_val v= allocate_word32();
  unsigned int * vp= (unsigned int *)CWORD32(v);
  *vp= i;
  return v;
}




mlw_ci_export mlw_val mlw_ci_real_make(double d)
{
  mlw_val r= allocate_real();
  SETREAL(r, d);
  return r;
}




/*
** C.deRef8 : C.void C.ptr -> Word8.word
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_de_ref8(mlw_val arg)
{
  unsigned char * cp= (unsigned char *)mlw_ci_void_ptr_to_voidp(arg);
  return mlw_ci_uchar_from_uchar(*cp);
}



/*
** C.deRef16 : C.void C.ptr -> Word16.word
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_de_ref16(mlw_val arg)
{
  unsigned short * p= (unsigned short *)mlw_ci_void_ptr_to_voidp(arg);
  return mlw_ci_ushort_from_ushort(*p);
}



/*
** C.deRef32 : C.void C.ptr -> Word32.word
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_de_ref32(mlw_val arg)
{
  void * wp= mlw_ci_void_ptr_to_voidp(arg);
  unsigned int w= *(unsigned int *)wp;
  return mlw_ci_word32_from_uint(w);
}



/*
** C.deRef32 : C.void C.ptr -> Word32.word
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_de_ref_real(mlw_val arg)
{
  void * vp= mlw_ci_void_ptr_to_voidp(arg);
  double d= *(double *)vp;
  return mlw_ci_real_from_double(d);
}




/*
** C.update8 : C.void C.ptr * Word8.word -> unit
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_update8(mlw_val arg)
{
  unsigned char * cp= (unsigned char *)mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  unsigned char c= mlw_ci_uchar_to_uchar(mlw_arg(arg, 1));
  *cp= c;
  return mlw_val_unit;
}



/*
** C.update16 : C.void C.ptr * Word.word -> unit
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_update16(mlw_val arg)
{
  unsigned short * sp= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  unsigned short s= mlw_ci_ushort_to_ushort(mlw_arg(arg, 1));
  *sp= s;
  return mlw_val_unit;
}



/*
** C.update32 : C.void C.ptr * Word32.word -> unit
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_update32(mlw_val arg)
{
  unsigned int * wp= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  unsigned int w= mlw_ci_word32_to_uint(mlw_arg(arg, 1));
  *wp= w;
  return mlw_val_unit;
}



/*
** C.updateReal : C.void C.ptr * Real.real -> unit
**
** Could and should be made into a compiler builtin.
*/
static mlw_val mlw_ci_void_ptr_update_real(mlw_val arg)
{
  double * dp= (double *)mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  double   d= mlw_ci_real_to_double(mlw_arg(arg, 1));
  *dp= d;
  return mlw_val_unit;
}




/*
** C.malloc : Word.word -> C.void C.ptr
**
*/
static mlw_val mlw_ci_malloc(mlw_val arg)
{
  size_t sz= (size_t)mlw_val_word_to_uint(arg);
  void *p= malloc(sz);
  return mlw_ci_void_ptr_from_voidp(p);
}



/*
** C.realloc : C.void C.ptr * Word.word -> C.void C.ptr
**
*/
static mlw_val mlw_ci_realloc(mlw_val arg)
{
  void *p= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  size_t sz= (size_t)mlw_val_word_to_uint(mlw_arg(arg, 1));
  void *np= realloc(p, sz);
  return mlw_ci_void_ptr_from_voidp(np);
}



/*
** C.free : C.void C.ptr -> unit
**
*/
static mlw_val mlw_ci_free(mlw_val arg)
{
  void *p= mlw_ci_void_ptr_to_voidp(arg);
  free(p);
  return mlw_val_unit;
}




/*
** C.memcpy : {from: C.void C.ptr, to: C.void C.ptr, size: Word.word} -> unit
**
*/
static mlw_val mlw_ci_memcpy(mlw_val arg)
{
  void *fp= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  size_t sz= (size_t)mlw_val_word_to_uint(mlw_arg(arg, 1));
  void *tp= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 2));
  (void)memcpy(tp, fp, sz);
  return mlw_val_unit;
}



/*
** C.CharPtr.fromString : string -> C.Char.char C.ptr
**
*/
static mlw_val mlw_ci_char_ptr_from_string(mlw_val arg)
{
  char const *s= mlw_ci_str_to_charp(arg);
  size_t l= mlw_ci_str_length(arg);
  char *p= malloc(l);
  if (p != NULL)
    memcpy(p, s, l);
  return mlw_ci_char_ptr_from_charp(p);
}



/*
** C.CharPtr.toString : C.Char.char C.ptr -> string
**
*/
static mlw_val mlw_ci_char_ptr_to_string(mlw_val arg)
{
  char *p= mlw_ci_char_ptr_to_charp(arg);
  return ml_string(p);
}


/*
** C.CharPtr.toStringN : C.CharPtr.ptr * Word.word -> string
**
*/
static mlw_val mlw_ci_char_ptr_to_string_n(mlw_val arg)
{
  char *p= mlw_ci_char_ptr_to_charp(mlw_arg(arg, 0));
  unsigned int l= mlw_val_word_to_uint(mlw_arg(arg, 1));
  mlw_val s= allocate_string(l+1);
  memcpy(CSTRING(s), p, l);
  CSTRING(s)[l]= '\0';
  return s;
}



void mlw_ci_init(void)
{
  env_function("C.VoidPtr.deRef8",     mlw_ci_void_ptr_de_ref8);
  env_function("C.VoidPtr.deRef16",    mlw_ci_void_ptr_de_ref16);
  env_function("C.VoidPtr.deRef32",    mlw_ci_void_ptr_de_ref32);
  env_function("C.VoidPtr.deRefReal",  mlw_ci_void_ptr_de_ref_real);
  env_function("C.VoidPtr.update8",    mlw_ci_void_ptr_update8);
  env_function("C.VoidPtr.update16",   mlw_ci_void_ptr_update16);
  env_function("C.VoidPtr.update32",   mlw_ci_void_ptr_update32);
  env_function("C.VoidPtr.updateReal", mlw_ci_void_ptr_update_real);

  env_function("C.Memory.malloc",  mlw_ci_malloc);
  env_function("C.Memory.realloc", mlw_ci_realloc);
  env_function("C.Memory.free",    mlw_ci_free);
  env_function("C.Memory.copy",    mlw_ci_memcpy);

  env_function("C.CharPtr.fromString", mlw_ci_char_ptr_from_string);
  env_function("C.CharPtr.toString",   mlw_ci_char_ptr_to_string);
  env_function("C.CharPtr.toStringN",  mlw_ci_char_ptr_to_string_n);

  mlw_ci_os_init();
  mlw_ci_io_init();
}
