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
 * Revision Log
 * ------------
 * $Log: mlw_ci_io.c,v $
 * Revision 1.1  1997/07/01 08:44:31  stephenb
 * new unit
 * ** No reason given. **
 *
 */

#include <stdio.h>
#include "ansi.h"		/* for SunOS which doesn't have prototypes */
#include "mlw_ci.h"
#include "mlw_ci_io.h"


static mlw_val mlw_ci_clearerr(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  clearerr(file);
  return mlw_val_unit;
}


static mlw_val mlw_ci_fclose(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  int result= fclose(file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_ferror(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  int result= ferror(file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_feof(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  int result= feof(file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_fgetc(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  int result= fgetc(file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_fopen(mlw_val arg)
{
  char const * file_name= mlw_ci_str_to_charp(mlw_arg(arg, 0));
  char const * mode= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  FILE * file= fopen(file_name, mode);
  return mlw_ci_void_ptr_from_voidp((void *)file);
}



static mlw_val mlw_ci_fputc(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  char c= mlw_ci_char_to_char(mlw_arg(arg, 1));
  int result= fputc(c, file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_fputs(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  char const * s= mlw_ci_char_ptr_to_charp(mlw_arg(arg, 1));
  int result= fputs(s, file);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_fput_string(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  char const * s= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  int result= fputs(s, file);
  return mlw_ci_int_from_int(result);
}




static mlw_val mlw_ci_fflush(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  int result= fflush(file);
  return mlw_ci_int_from_int(result);
}





static mlw_val mlw_ci_fread(mlw_val arg)
{
  void * p= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  size_t size= (size_t)mlw_ci_ulong_to_ulong(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_ci_ulong_to_ulong(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fread(p, size, nobj, file);
  return mlw_ci_ulong_from_ulong(result);
}



static mlw_val mlw_ci_fread_char_array(mlw_val arg)
{
  char * p= mlw_ci_char_array_to_charp(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fread((void *)(p+offset), sizeof(char), nobj, file);
  return mlw_val_int_from_int(result);
}



static mlw_val mlw_ci_fread_real_array(mlw_val arg)
{
  double * p= mlw_ci_real_array_to_doublep(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fread((void *)(p+offset), sizeof(double), nobj, file);
  return mlw_val_int_from_int(result);
}



static mlw_val mlw_ci_freopen(mlw_val arg)
{
  char const * file_name= mlw_ci_str_to_charp(mlw_arg(arg, 0));
  char const * mode= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 2));
  FILE * result= freopen(file_name, mode, file);
  return mlw_ci_void_ptr_from_voidp((void *)result);
}



static mlw_val mlw_ci_fseek(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  long offset= mlw_ci_long_to_long(mlw_arg(arg, 1));
  int dir= mlw_ci_int_to_int(mlw_arg(arg, 2));
  int result= fseek(file, offset, dir);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_ftell(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(arg);
  long result= ftell(file);
  return mlw_ci_long_from_long(result);
}




static mlw_val mlw_ci_fwrite(mlw_val arg)
{
  void const * p= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  size_t size= (size_t)mlw_ci_ulong_to_ulong(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_ci_ulong_to_ulong(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite(p, size, nobj, file);
  return mlw_ci_ulong_from_ulong(result);
}



static mlw_val mlw_ci_fwrite_string(mlw_val arg)
{
  char const * p= mlw_ci_str_to_charp(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite((void *)(p+offset), sizeof(char), nobj, file);
  return mlw_val_int_from_int(result);
}



static mlw_val mlw_ci_fwrite_char_array(mlw_val arg)
{
  char const * p= (void *)mlw_ci_char_array_to_charp(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite((void *)(p+offset), sizeof(char), nobj, file);
  return mlw_val_int_from_int(result);
}




static mlw_val mlw_ci_fwrite_char_vector(mlw_val arg)
{
  char const * p= (void *)mlw_ci_char_vector_to_charp(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite((void *)(p+offset), sizeof(char), nobj, file);
  return mlw_val_int_from_int(result);
}


static mlw_val mlw_ci_fwrite_real_array(mlw_val arg)
{
  double const * p= mlw_ci_real_array_to_doublep(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite((void *)(p+offset), sizeof(double), nobj, file);
  return mlw_val_int_from_int(result);
}




static mlw_val mlw_ci_fwrite_real_vector(mlw_val arg)
{
  double const * p= (void *)mlw_ci_real_vector_to_doublep(mlw_arg(arg, 0));
  size_t offset= (size_t)mlw_val_int_to_int(mlw_arg(arg, 1));
  size_t nobj= (size_t)mlw_val_int_to_int(mlw_arg(arg, 2));
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 3));
  int result= fwrite((double *)(p+offset), sizeof(double), nobj, file);
  return mlw_val_int_from_int(result);
}





static mlw_val mlw_ci_setvbuf(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  char * buff= mlw_ci_char_ptr_to_charp(mlw_arg(arg, 1));
  int mode= mlw_ci_int_to_int(mlw_arg(arg, 2));
  size_t size= (size_t)mlw_ci_ulong_to_ulong(mlw_arg(arg, 3));
  int result= setvbuf(file, buff, mode, size);
  return mlw_ci_int_from_int(result);
}



static mlw_val mlw_ci_perror(mlw_val arg)
{
  char const * s= mlw_ci_char_ptr_to_charp(arg);
  perror(s);
  return mlw_val_unit;
}



static mlw_val mlw_ci_perror_string(mlw_val arg)
{
  char const * s= mlw_ci_str_to_charp(arg);
  perror(s);
  return mlw_val_unit;
}



static mlw_val mlw_ci_setbuf(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  char * buff= mlw_ci_char_ptr_to_charp(mlw_arg(arg, 1));
  setbuf(file, buff);
  return mlw_val_unit;
}




static mlw_val mlw_ci_ungetc(mlw_val arg)
{
  FILE * file= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  int c= mlw_ci_int_to_int(mlw_arg(arg, 1));
  int result= ungetc(c, file);
  return mlw_ci_int_from_int(result);
}




static mlw_val mlw_ci_stdin(mlw_val arg)
{
  return mlw_ci_void_ptr_from_voidp(stdin);
}



static mlw_val mlw_ci_stdout(mlw_val arg)
{
  return mlw_ci_void_ptr_from_voidp(stdout);
}




static mlw_val mlw_ci_stderr(mlw_val arg)
{
  return mlw_ci_void_ptr_from_voidp(stderr);
}





mlw_ci_export void mlw_ci_io_init(void)
{
  mlw_ci_register_function("mlw clearerr",           mlw_ci_clearerr);
  mlw_ci_register_function("mlw fclose",             mlw_ci_fclose);
  mlw_ci_register_function("mlw ferror",             mlw_ci_ferror);
  mlw_ci_register_function("mlw feof",               mlw_ci_feof);
  mlw_ci_register_function("mlw fgetc",              mlw_ci_fgetc);
  mlw_ci_register_function("mlw fopen",              mlw_ci_fopen);
  mlw_ci_register_function("mlw fputc",              mlw_ci_fputc);
  mlw_ci_register_function("mlw fputs",              mlw_ci_fputs);
  mlw_ci_register_function("mlw fput string",        mlw_ci_fput_string);
  mlw_ci_register_function("mlw fflush",             mlw_ci_fflush);
  mlw_ci_register_function("mlw fread",              mlw_ci_fread);
  mlw_ci_register_function("mlw fread char array",   mlw_ci_fread_char_array);
  mlw_ci_register_function("mlw fread real array",   mlw_ci_fread_real_array);
  mlw_ci_register_function("mlw freopen",            mlw_ci_freopen);
  mlw_ci_register_function("mlw fseek",              mlw_ci_fseek);
  mlw_ci_register_function("mlw ftell",              mlw_ci_ftell);
  mlw_ci_register_function("mlw fwrite char array",  mlw_ci_fwrite_char_array);
  mlw_ci_register_function("mlw fwrite char vector", mlw_ci_fwrite_char_vector);
  mlw_ci_register_function("mlw fwrite real array",  mlw_ci_fwrite_real_array);
  mlw_ci_register_function("mlw fwrite real vector", mlw_ci_fwrite_real_vector);
  mlw_ci_register_function("mlw fwrite string",      mlw_ci_fwrite_string);
  mlw_ci_register_function("mlw fwrite",             mlw_ci_fwrite);
  mlw_ci_register_function("mlw perror",             mlw_ci_perror);
  mlw_ci_register_function("mlw perror string",      mlw_ci_perror_string);
  mlw_ci_register_function("mlw setvbuf",            mlw_ci_setvbuf);
  mlw_ci_register_function("mlw setbuf",             mlw_ci_setbuf);
  mlw_ci_register_function("mlw ungetc",             mlw_ci_ungetc);

  mlw_ci_register_function("mlw stdin",              mlw_ci_stdin);
  mlw_ci_register_function("mlw stdout",             mlw_ci_stdout);
  mlw_ci_register_function("mlw stderr",             mlw_ci_stderr);
}
