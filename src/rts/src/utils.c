/*  ==== MISCELLANEOUS UTILITY FUNCTIONS ====
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  $Log: utils.c,v $
 *  Revision 1.24  1998/08/24 15:44:39  jont
 *  [Bug #70170]
 *  Add a fflush stderr at the end of message_end
 *
 * Revision 1.23  1998/08/17  13:28:43  jkbrook
 * [Bug #50100]
 * Remove use of env_lookup("license edition")
 *
 * Revision 1.22  1998/07/17  15:16:28  jkbrook
 * [Bug #30436]
 * Update edition names
 *
 * Revision 1.21  1998/06/11  14:48:24  jkbrook
 * [Bug #30411]
 * Adding FREE edition
 *
 * Revision 1.20  1998/05/27  10:13:26  mitchell
 * [Bug #30411]
 * Remove stray editing character
 *
 * Revision 1.19  1998/05/26  16:40:56  mitchell
 * [Bug #30411]
 * Support for time-limited runtime
 *
 * Revision 1.18  1998/04/15  15:23:16  jont
 * [Bug #20037]
 * Make fatal errors abort on re-entry
 *
 * Revision 1.17  1998/03/26  15:07:14  jont
 * [Bug #30090]
 * Add format_to_ml_string for use when making syserr
 *
 * Revision 1.16  1997/11/18  12:32:10  jont
 * [Bug #30089]
 * Remove include of mltime.h which is no longer needed
 *
 * Revision 1.15  1996/05/14  16:00:48  nickb
 * Add standard streams out-of-memory dialog.
 *
 * Revision 1.14  1996/01/12  14:57:25  matthew
 * Changing ] to [ in message_start
 *
 * Revision 1.13  1996/01/11  17:30:28  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.12  1995/08/03  11:02:01  matthew
 * Increasing bound on runtime message size
 *
 * Revision 1.11  1995/06/09  15:54:07  nickb
 * Add alloc_zero.
 *
 * Revision 1.10  1995/04/27  11:53:04  daveb
 * Added call to message_flusher to message_end.
 *
 * Revision 1.9  1995/02/23  16:48:34  nickb
 * Remove "bug-fix" which neither fixes the bug nor
 * compiles without warnings.
 *
 * Revision 1.8  1995/01/24  15:03:46  daveb
 * Replaced fixed bound on error messages.
 *
 * Revision 1.7  1994/12/09  15:44:13  jont
 * Change time.h to mltime.h
 *
 * Revision 1.6  1994/10/19  15:43:25  nickb
 * The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.5  1994/07/22  14:11:55  nickh
 * Should not terminate sprintf-written strings with a NUL.
 * Also restrict message length checks to the debugging runtime.
 *
 * Revision 1.4  1994/06/30  11:48:24  nickh
 * Add messaging function hooks.
 *
 * Revision 1.3  1994/06/29  14:48:56  jont
 * Add nonreturning to error
 *
 * Revision 1.2  1994/06/09  14:50:59  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:25:38  nickh
 * new file
 *
 *  Revision 1.22  1994/01/28  17:23:48  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.21  1993/08/26  18:45:57  daveb
 *  The runtime reads the module name from the consistency information in the
 *  file.  Therefore module_name() isn't needed any more.
 *
 *  Revision 1.20  1993/08/24  14:27:36  richard
 *  The is_ml_frame function didn't cope with shared closures.
 *
 *  Revision 1.19  1993/08/12  14:18:52  daveb
 *  Replaced basename with module_name.
 *
 *  Revision 1.18  1993/06/22  11:14:53  richard
 *  Moved stack backtrace here from GC and top-level handler.
 *
 *  Revision 1.17  1993/06/02  13:15:15  richard
 *  Added nonreturning qualifier to verror().
 *  Added missing include of extensions.h.
 *  Added prototype for getrusage().
 *
 *  Revision 1.16  1993/02/10  17:02:05  jont
 *  Changes for code vector reform, and also fixed a bug whereby time based
 *  profiling only worked on the first of a set of mutually recursive code
 *  vectors
 *
 *  Revision 1.15  1993/02/02  17:21:39  jont
 *  Made is_ml_frame check for the right sort of pointer (ie not a ref)
 *
 *  Revision 1.14  1993/02/01  16:04:24  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.13  1992/12/07  14:32:42  richard
 *  Added user_clock().
 *
 *  Revision 1.12  1992/10/01  15:37:37  richard
 *  Added ansi.h.
 *
 *  Revision 1.11  1992/08/24  15:44:36  richard
 *  More checks in is_ml_frame().
 *
 *  Revision 1.10  1992/08/18  09:48:47  richard
 *  Corrected ml_frame to return the code vector from the frame
 *  it is passed and not its parent frame.
 *
 *  Revision 1.9  1992/08/05  17:50:40  richard
 *  Code vectors are now tagged differently to strings.
 *  This information is used by is_ml_frame() to avoid finding
 *  assembler subroutines etc.
 *
 *  Revision 1.8  1992/07/21  13:54:52  richard
 *  Added is_ml_frame(), derived from is_ml_stack() in a storage manager
 *  independent way.  Implemented alloc().
 *
 *  Revision 1.7  1992/03/12  16:58:06  richard
 *  Made basename() take a const argument.
 *
 *  Revision 1.6  1992/03/11  11:46:50  richard
 *  Changed call to allocate_string() in basename() to include terminator.
 *
 *  Revision 1.5  1992/01/20  16:03:15  richard
 *  Changed message() and error() to use variable argument lists.
 *
 *  Revision 1.4  1992/01/09  15:55:13  richard
 *  Fixed an error in basename().
 *
 *  Revision 1.3  1991/12/23  13:18:44  richard
 *  Added basename().
 *
 *  Revision 1.2  91/12/19  13:36:23  richard
 *  Rewrote runtime_message() in terms of fputs so that it doesn't
 *  call malloc().  This can now be used before memory is initialized.
 * 
 *  Revision 1.1  91/10/18  13:03:11  davidt
 *  Initial revision
 */

#include "ansi.h"
#include "syscalls.h"
#include "utils.h"
#include "alloc.h"
#include "extensions.h"
#include "exceptions.h"
#include "allocator.h"
#include "license.h"
#include "mlw_mklic.h"
#include "environment.h"

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

void (*messager_function)(const char * message) = NULL;
void (*message_flusher)(void) = NULL;

#define MAXIMUM_RUNTIME_MESSAGE_SIZE 256

void message_string (const char *string)
{
  if (messager_function)
    messager_function(string);
  else
    fputs(string,stderr);
}

void vmessage_content(const char *format, va_list arg)
{
  char message_buffer[MAXIMUM_RUNTIME_MESSAGE_SIZE+1];
  int length;

  length = vsprintf(message_buffer, format, arg);

#ifdef DEBUG

#ifdef SPRINTF_IS_BROKEN
  length = strlen(message_buffer);
#endif

  if (length > MAXIMUM_RUNTIME_MESSAGE_SIZE)
    error ("Runtime message too long : %u %s\n",length, message_buffer);

#endif

  message_string(message_buffer);
}

extern void message_content (const char *format, ...)
{
  va_list arg;
  
  va_start (arg,format);
  vmessage_content (format, arg);
  va_end (arg);
}

extern void message_start (void)
{
  message_string("[");
}

extern void message_end (void)
{
  if (messager_function) {
    messager_function("]\n");
    if (message_flusher)
      message_flusher ();
  } else {
    fputs("]\n",stderr);
    fflush(stderr);
  }
}

extern void message(const char *format, ...)
{
  va_list arg;

  va_start (arg,format);
  message_start();
  vmessage_content(format, arg);
  message_end();
  va_end (arg);
}

extern void message_stderr(const char *format, ...)
{
  va_list arg;

  putc('[',stderr);
  va_start(arg, format);
  vfprintf(stderr, format, arg);
  va_end(arg);
  fputs("]\n",stderr);
  fflush(stderr);
}

/* Have to give a prototype so we know it's non-returning */

nonreturning(static void, verror,
	     (const char *pfx, const char *format, va_list arg));

static void verror(const char *prefix,
		   const char *format,
		   va_list arg)
{
  fprintf(stderr, "%s:\n ", prefix);
  vfprintf(stderr, format, arg);
  putc('\n', stderr);
  fflush(stderr);
  exit(EXIT_FAILURE);
}

static int aborting = 0;

void error(const char *format, ...)
{
  va_list arg;
  if (aborting) abort();
  aborting = 1;
  va_start(arg, format);
  verror("Fatal error in runtime system", format, arg);
}

/* error_without_alloc has to print an error message and exit without
calling anything which allocates (as printf does sometimes). This is
for use before the arena is initialized. */

extern void error_without_alloc(const char *string)
{
  fputs("Fatal error in runtime system: \n", stderr);
  fputs(string, stderr);
  exit(EXIT_FAILURE);
}

void *alloc(size_t size, const char *format, ...)
{
  void *p = malloc(size);
  va_list arg;

  if(p == NULL)
  {
    va_start(arg, format);
    verror("Fatal allocation error in runtime system", format, arg);
  }

  return(p);
}

void *alloc_zero(size_t size, const char *format, ...)
{
  void *p = calloc(1,size);
  va_list arg;

  if(p == NULL)
  {
    va_start(arg, format);
    verror("Fatal zeroing allocation error in runtime system", format, arg);
  }

  return(p);
}

/* standard_out_of_memory_dialog uses the standard streams to conduct
 * an out-of-memory dialog with the user. It returns non-zero iff a
 * retry is appropriate. */

int standard_out_of_memory_dialog(unsigned long int attempt,
				  size_t extent,
				  size_t size)
{
  putc('\n', stderr);
  message_stderr("Unable to obtain virtual memory "
		 "(%uMb used, %uKb requested);\n"
		 "Enter q to quit mlworks, c to continue.",
		 extent >> 20, size >> 10);
  while (1) {
    int c = getchar();
    if (c == EOF || c == 'q')
      return 0; /* abort */
    else if (c == 'c')
      return 1;	/* retry */
  }
}


/* Bounded elapsed time */

#define COUNT_DOWN  5        /* MINUTES */
#define MAX_ELAPSED_TIME 60  /* MINUTES */

static time_t  start_time = 0;
static int     max_elapsed_time = (MAX_ELAPSED_TIME - COUNT_DOWN) * 60;
static int     count_down = COUNT_DOWN;

void check_elapsed_time(void)
{
  if ((license_edition != PERSONAL) && !act_as_free) /* Do nothing */;
  else if (start_time == 0) start_time = time(NULL);
  else {
    long so_far;
    so_far = (long)(difftime(time(NULL), start_time));
    if (so_far > max_elapsed_time) {
      char message[80];
      if (count_down > 0) {
        if (count_down == 1) 
          sprintf(message, "This session of Free MLWorks will stop in 1 minute\n");
        else
          sprintf(message, "This session of Free MLWorks will stop in %d minutes\n",
                           count_down);
        display_simple_message_box(message);
        count_down--;
        start_time = time(NULL);
        max_elapsed_time = 60; 
      } else {
        display_simple_message_box("Free MLWorks time limit has been exceeded\n");
        exit(EXIT_FAILURE);
      }
    }   
  }
}

mlval format_to_ml_string(const char *format, ...)
{
  va_list arg;
  char buffer[EXN_RAISE_FORMAT_BUFFER_SIZE+1];

  va_start(arg, format);
  vsprintf(buffer, format, arg);
  va_end(arg);

  return ml_string(buffer);
}

