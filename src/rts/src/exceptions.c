/*  === PERVASIVE EXCEPTIONS ===
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
 *  $Log: exceptions.c,v $
 *  Revision 1.17  1998/03/26 16:20:31  jont
 *  [Bug #30090]
 *  Remove perv_exn_ref_io
 *
 * Revision 1.16  1998/02/23  18:01:26  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.15  1997/08/19  15:14:07  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.14  1997/05/22  08:32:23  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr to include an ml string.
 *
 * Revision 1.13  1996/06/04  13:33:31  io
 * add exn Size
 *
 * Revision 1.12  1996/04/22  14:30:14  stephenb
 * exn_raise_syserr: change the second argument to an int and
 * make it raise (string * NONE) if the int is 0.
 *
 * Revision 1.11  1996/04/19  10:00:42  matthew
 * Removing some exceptions
 *
 * Revision 1.10  1996/03/29  10:04:22  stephenb
 * Add exn_raise_syserror and corresponding exception to support
 * latest verison of OS.* in the basis.
 *
 * Revision 1.9  1996/02/16  12:42:15  nickb
 * Change to declare_global().
 *
 * Revision 1.8  1996/01/22  11:28:55  matthew
 * Adding exceptions initialized value
 *
 * Revision 1.7  1996/01/16  12:09:19  nickb
 * Remove StorageManager exception.
 *
 * Revision 1.6  1995/07/20  16:37:53  jont
 * Add exception Overflow
 *
 * Revision 1.5  1995/03/15  17:37:22  nickb
 * Add threads exception.
 *
 * Revision 1.4  1994/10/19  15:14:18  nickb
 * The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.3  1994/06/28  14:31:50  jont
 * Add nonreturning to function declarations
 *
 * Revision 1.2  1994/06/09  14:49:52  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:24:05  nickh
 * new file
 *
 *  Revision 1.9  1994/01/28  17:39:00  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.8  1993/07/23  11:11:36  richard
 *  Added X exception.
 *
 *  Revision 1.7  1993/06/02  13:07:23  richard
 *  Added extra parentheses around conditionals as suggested by GCC 2.
 *  Improved use of const.
 *
 *  Revision 1.6  1993/04/20  12:49:07  richard
 *  Removed obsolete CLMError exception.  Added Unix and Trace exceptions.
 *  Added exn_raise_strings() to deal with errors from streams.c.
 *
 *  Revision 1.5  1993/04/02  14:18:38  jont
 *  New exception for bad iage when reading table of contents
 *
 *  Revision 1.4  1993/03/31  16:28:24  jont
 *  Made the size of the exception string buffer a #define value
 *
 *  Revision 1.3  1993/02/01  16:04:46  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.2  1993/01/05  16:46:45  richard
 *  Added more floating point exceptions.
 *
 *  Revision 1.1  1992/11/02  14:51:16  richard
 *  Initial revision
 *
 */

#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <memory.h>
#include <string.h>

#include "exceptions.h"
#include "values.h"
#include "global.h"
#include "environment.h"
#include "interface.h"
#include "utils.h"
#include "allocator.h"
#include "ansi.h"
#include "gc.h"

mlval exns_initialised;
mlval exn_default;
mlval perv_exn_ref_size;
mlval perv_exn_ref_div;
mlval perv_exn_ref_overflow;
mlval perv_exn_ref_substring;
mlval perv_exn_ref_profile;
mlval perv_exn_ref_save;
mlval perv_exn_ref_value;
mlval perv_exn_ref_load;
mlval perv_exn_ref_table;
mlval perv_exn_ref_string_to_real;
mlval perv_exn_ref_ln;
mlval perv_exn_ref_abs;
mlval perv_exn_ref_exp;
mlval perv_exn_ref_sqrt;
mlval perv_exn_ref_unbound;
mlval perv_exn_ref_signal;
mlval perv_exn_ref_trace;
mlval perv_exn_ref_threads;
mlval perv_exn_ref_syserr;

static mlval exception_name;


void exn_init()
{
  exns_initialised = ref (MLFALSE);
  declare_global("exception exns_initialised", &exns_initialised,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value ("exception exns_initialised", exns_initialised);

  exn_default = exn(exn_name("default runtime exception"), MLUNIT);
  declare_global("default runtime exception", &exn_default,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  perv_exn_ref_size = ref(exn_default);
  declare_global("pervasive exception Size", &perv_exn_ref_size,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Size", perv_exn_ref_size);

  perv_exn_ref_div = ref(exn_default);
  declare_global("pervasive exception Div", &perv_exn_ref_div, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Div", perv_exn_ref_div);

  perv_exn_ref_overflow = ref(exn_default);
  declare_global("pervasive exception Overflow", &perv_exn_ref_overflow, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Overflow", perv_exn_ref_overflow);

  perv_exn_ref_substring = ref(exn_default);
  declare_global("pervasive exception Substring", &perv_exn_ref_substring, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Substring", perv_exn_ref_substring);

  perv_exn_ref_save = ref(exn_default);
  declare_global("pervasive exception Save", &perv_exn_ref_save, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Save", perv_exn_ref_save);

  perv_exn_ref_profile = ref(exn_default);
  declare_global("pervasive exception Profile", &perv_exn_ref_profile, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Profile", perv_exn_ref_profile);

  perv_exn_ref_value = ref(exn_default);
  declare_global("pervasive exception Value", &perv_exn_ref_value, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Value", perv_exn_ref_value);

  perv_exn_ref_unbound = ref(exn_default);
  declare_global("pervasive exception Unbound", &perv_exn_ref_unbound, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Unbound", perv_exn_ref_unbound);

  perv_exn_ref_load = ref(exn_default);
  declare_global("pervasive exception Load", &perv_exn_ref_load, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Load", perv_exn_ref_load);

  perv_exn_ref_table = ref(exn_default);
  declare_global("pervasive exception Table", &perv_exn_ref_table, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Table", perv_exn_ref_table);

  perv_exn_ref_ln = ref(exn_default);
  declare_global("pervasive exception Ln", &perv_exn_ref_ln, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Ln", perv_exn_ref_ln);

  perv_exn_ref_abs = ref(exn_default);
  declare_global("pervasive exception Abs", &perv_exn_ref_abs, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Abs", perv_exn_ref_abs);

  perv_exn_ref_exp = ref(exn_default);
  declare_global("pervasive exception Exp", &perv_exn_ref_exp, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Exp", perv_exn_ref_exp);

  perv_exn_ref_sqrt = ref(exn_default);
  declare_global("pervasive exception Sqrt", &perv_exn_ref_sqrt, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("exception Sqrt", perv_exn_ref_sqrt);

  perv_exn_ref_string_to_real = ref(exn_default);
  env_value("exception StringToReal", perv_exn_ref_string_to_real);
  declare_global("pervasive exception StringToReal",
		 &perv_exn_ref_string_to_real, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  perv_exn_ref_signal = ref(exn_default);
  env_value("exception Signal", perv_exn_ref_signal);
  declare_global("pervasive exception Signal", &perv_exn_ref_signal, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  perv_exn_ref_trace = ref(exn_default);
  env_value("exception Trace", perv_exn_ref_trace);
  declare_global("pervasive exception Trace", &perv_exn_ref_trace, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  perv_exn_ref_threads = ref(exn_default);
  env_value("exception Threads", perv_exn_ref_threads);
  declare_global("pervasive exception Threads", &perv_exn_ref_threads, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);


  perv_exn_ref_syserr = ref(exn_default);
  env_value("exception syserr", perv_exn_ref_syserr);
  declare_global("pervasive exception syserr", &perv_exn_ref_syserr, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  exception_name = MLUNIT;
  declare_root(&exception_name, 0);
}


void exn_raise(mlval exn_ref)
{
  c_raise(DEREF(exn_ref));
}

void exn_raise_ml_string(mlval exn_ref, mlval ml_str)
{
  mlval name;

  exception_name = FIELD(DEREF(exn_ref), 0);
  name = exception_name;
  exception_name = MLUNIT;
  c_raise(exn(name, ml_str));
}

void exn_raise_string(mlval exn_ref, const char *string)
{
  exn_raise_ml_string(exn_ref, ml_string(string));
}

void exn_raise_strings(mlval exn_ref, ...)
{
  va_list arg;
  size_t total;
  const char *arg_string;
  char *to, *buffer;
  mlval string, name;

  /* Calculate the total length of the strings in the argument list. */

  va_start(arg, exn_ref);
  total = 0;
  while((arg_string = va_arg(arg, const char *)))
    total += strlen(arg_string);
  va_end(arg);

  /* Concatenate the argument strings into a C buffer.  (NOTE: an ML string */
  /* can't be allocated until they've been copied because they might be on */
  /* the heap. */

  buffer = to = alloc(total, "exn_raise_strings");
  va_start(arg, exn_ref);
  while((arg_string = va_arg(arg, const char *)))
  {
    size_t length = strlen(arg_string);
    memcpy(to, arg_string, length);
    to += length;
  }
  va_end(arg);

  /* Allocate an ML string and copy the buffer into it. */

  exception_name = FIELD(DEREF(exn_ref), 0);
  string = allocate_string(total+1);
  name = exception_name;
  exception_name = MLUNIT;

  memcpy(CSTRING(string), buffer, total);
  CSTRING(string)[total] = '\0';
  free(buffer);

  c_raise(exn(name, string));
}

void exn_raise_int(mlval exn_ref, int i)
{
  c_raise(exn(FIELD(DEREF(exn_ref), 0), MLINT(i)));
}



/* Raise an Os.SysErr exception.  This has the form :-
** 
**   type syserror = int
**   exception SysErr of (string * syserror option)
**
** If the error_code is 0 then (string * NONE) will be raised.
*/
void exn_raise_syserr(mlval error_message, int error_code)
{
  mlval option,  exn_packet;

  declare_root(&error_message, 0);

  if (error_code == 0) {
    option= MLINT(0);
  } else {
    option= allocate_record(2);
    FIELD(option, 0)= MLINT(1);
    FIELD(option, 1)= MLINT(error_code);
  }
  declare_root(&option, 0);

  exn_packet= allocate_record(2);
  FIELD(exn_packet, 0)= error_message;
  FIELD(exn_packet, 1)= option;
  retract_root(&option);
  retract_root(&error_message);

  c_raise(exn(FIELD(DEREF(perv_exn_ref_syserr), 0), exn_packet));
}



void exn_raise_format(mlval exn_ref, const char *format, ...)
{
  va_list arg;
  char buffer[EXN_RAISE_FORMAT_BUFFER_SIZE+1];
  mlval name, s;

  va_start(arg, format);
  vsprintf(buffer, format, arg);
  va_end(arg);

  exception_name = FIELD(DEREF(exn_ref), 0);
  s = ml_string(buffer);
  name = exception_name;
  exception_name = MLUNIT;
  c_raise(exn(name, s));
}
