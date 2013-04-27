/*  ==== MISCELLANEOUS UTILITY FUNCTIONS ====
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
 *  $Log: utils.h,v $
 *  Revision 1.11  1998/05/26 15:40:12  mitchell
 *  [Bug #30411]
 *  Support for time-limited runtime
 *
 * Revision 1.10  1998/05/19  14:41:24  jont
 * [Bug #70120]
 * Make error_without_alloc nonreturning
 *
 * Revision 1.9  1998/03/26  15:02:43  jont
 * [Bug #30090]
 * Add format_to_ml_string for use when making syserr
 *
 * Revision 1.8  1996/05/14  13:23:08  nickb
 * Add standard streams out-of-memory dialog.
 *
 * Revision 1.7  1996/01/11  16:39:42  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.6  1995/06/09  15:54:25  nickb
 * Add alloc_zero.
 *
 * Revision 1.5  1995/01/24  14:29:54  daveb
 * Removed MAXIMUM_RUNTIME_MESSAGE_SIZE, which was not used.
 *
 * Revision 1.4  1994/10/19  15:22:33  nickb
 * The method of declaring functions to be non-returning has changed.
 *
 * Revision 1.3  1994/06/30  11:48:20  nickh
 * Add messaging function hooks.
 *
 * Revision 1.2  1994/06/09  14:47:08  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:18:18  nickh
 * new file
 *
 *  Revision 1.10  1993/08/26  18:46:15  daveb
 *  The runtime reads the module name from the consistency information in the
 *  file.  Therefore module_name() isn't needed any more.
 *
 *  Revision 1.9  1993/08/12  13:48:52  daveb
 *  Replaced basename with module_name.
 *
 *  Revision 1.8  1993/06/22  11:14:42  richard
 *  Moved stack backtrace here from GC and top-level handler.
 *
 *  Revision 1.7  1992/07/20  10:09:52  richard
 *  Added is_ml_frame().
 *
 *  Revision 1.6  1992/06/30  09:40:31  richard
 *  Moved some declarations to storeman.h.
 *
 *  Revision 1.5  1992/03/12  16:47:55  richard
 *  Made basename() take a const argument.
 *
 *  Revision 1.4  1992/01/20  16:00:20  richard
 *  Changed message() and error() to use variable argument lists.
 *
 *  Revision 1.3  1991/12/23  13:18:45  richard
 *  Changed the names of runtime_error() and runtime_message() to preserve
 *  the six-character monocase uniqueness required by ANSI.  Added basename().
 *
 *  Revision 1.2  91/12/19  16:01:42  richard
 *  Added an exit code to runtime_error().
 * 
 *  Revision 1.1  91/10/18  13:08:35  davidt
 *  Initial revision
 */


#ifndef utils_h
#define utils_h

#include <stdio.h>
#include <time.h>
#include <stdarg.h>

#include "extensions.h"
#include "mltypes.h"

/* Runtime messages */

/* NOTE: a fixed-sized buffer is used to format messages. Messages
 * containing strings of unknown length (e.g. file names, paths,
 * unrecognised command-line options), must therefore be split up
 * using message_start(), message_end() and passing the strings using
 * message_string().
 *
 *** Failure to observe this discipline may cause memory corruption ***/

/* The function message() writes a [bracketed] message to the MLWorks
 * message 'stream' in a manner similar to fprintf().
 *
 * If messager_function is non-NULL, it is applied to the formatted
 * message (it might, for instance, putthe message in a window). If
 * message_flusher is non-NULL, it is then applied.
 *
 * If messager_function is NULL, the message is printed to stderr. 
 */
extern void (*messager_function) (const char * message);
extern void (*message_flusher)(void);

extern void message(const char *format, ...);

/* These functions can be used to construct large messages. They
 * output strings in the same manner as message() above, but the
 * message brackets [ ... ] are output by message_start() and
 * message_end, and {v}message_content() can be used to output 
 * intervening parts of the message. 
 *
 * message_string() MUST be used when outputting strings of unknown
 * length. */

extern void message_start(void);
extern void message_end(void);
extern void message_content(const char *format, ...);
extern void message_string(const char *string);

extern void vmessage_content(const char *format, va_list arg);

/* The functions message_stderr() and error() write a message to
 *  stderr using fprintf(). error() displays the message as a fatal
 *  error message and terminates the runtime system.  It does not
 *  return.  It may call malloc() and therefore should not be called
 *  before the C heap is allocated. 
 */

extern void message_stderr(const char *format, ...);
nonreturning (extern void, error,(const char *format, ...));

/* error_without_alloc prints an error message to stderr and exits
 * without calling anything which allocates (as printf does sometimes).
 * This is for use before the arena is initialized. */

nonreturning(extern void, error_without_alloc, (const char *string));

/*  alloc() is a variation on malloc() which, if unable to allocate memory,
 *  causes a fatal error in a manner similar to error(). */

extern void *alloc(size_t size, const char *format, ...);
extern void *alloc_zero(size_t size, const char *format, ...);

/* standard_out_of_memory_dialog uses the standard streams to conduct
 * an out-of-memory dialog with the user. It returns non-zero iff a
 * retry is appropriate. */

extern int standard_out_of_memory_dialog(unsigned long int attempt,
					 size_t extent,
					 size_t size);

extern void display_simple_message_box(const char *message);

extern mlval format_to_ml_string(const char *format, ...);

#endif
