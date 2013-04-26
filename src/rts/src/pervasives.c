/*  ==== C-IMPLEMENTED PERVASIVES ====
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  The pervasive C functions and values are added to the runtime
 *  environment (see environment.h) by pervasives_init().
 *
 *  Functions which allocate objects on the heap must be very careful to
 *  declare any pointers held in C as `roots' to that the garbage collector
 *  can fix them in the event of a collection.  An array of pre-declared
 *  roots is set up by the initialisation function for this purpose, as
 *  declaring and retracting roots is fairly expensive.
 *
 *  Revision Log
 *  ------------
 *  Revision log: $Log: pervasives.c,v $
 *  Revision log: Revision 1.18  1999/03/09 14:56:39  johnh
 *  Revision log: [Bug #190506]
 *  Revision log: Remove old FI - references to foreign_loader.
 *  Revision log:
 * Revision 1.17  1998/04/27  15:37:48  jkbrook
 * [Bug #30354]
 * Temporarily restore old FI to distribution
 *
 * Revision 1.16  1997/05/22  14:34:52  stephenb
 * [Bug #30121]
 * Move to new FI: remove the reference to foreign_loader.h
 * Also removed the ^H from the previous log message.
 *
 * Revision 1.15  1996/07/26  13:02:19  davids
 * [Change by daveb] We ran into problems rebuilding the runtime for David
 * Silver on dedekind.  The linker complained about an undefined symbol ref.
 * This is actually #defined in values.h, and we don't know what the
 * underlying problem was.  Replaced ref with mlw_ref_make to fix it.
 *
 * Revision 1.14  1996/04/15  13:27:50  jont
 * Initialise max_stack_blocks to a sensible default which will enter
 * the debugger if exceded
 *
 * Revision 1.13  1996/02/19  14:42:13  nickb
 * Module table global root flags.
 *
 * Revision 1.12  1996/02/16  12:55:51  nickb
 * Change to declare_global().
 *
 * Revision 1.11  1996/02/14  15:06:56  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.10  1996/01/16  11:55:15  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.9  1995/09/12  13:05:16  jont
 * Add parameter to sm_interface to control whether stack_crawl is done
 *
 * Revision 1.8  1995/07/06  23:25:39  brianm
 * Adding libml_init().
 *
 * Revision 1.7  1995/03/28  13:47:23  nickb
 * Thread system changes.
 *
 * Revision 1.6  1995/03/17  15:37:51  brianm
 * Adding pack_words_init function.
 *
 * Revision 1.5  1995/03/12  15:03:55  brianm
 * Adding words_init()
 *
 * Revision 1.4  1995/02/28  18:03:26  brianm
 * Adding Foreign Interface init. function ...
 *
 * Revision 1.3  1994/12/09  15:42:29  jont
 * Change time.h to mltime.h
 *
 * Revision 1.2  1994/06/09  14:49:21  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:22:59  nickh
 * new file
 *
 *  Revision 1.88  1993/04/26  11:51:05  richard
 *  Increased diagnostic levels.
 *
 *  Revision 1.87  1993/04/21  16:04:02  richard
 *  Removed defunct Editor interface and added sytem calls to enable
 *  its replacement.
 *
 *  Revision 1.86  1993/04/15  13:10:15  richard
 *  Removed old clm stuff.  Added unix_init().
 *
 *  Revision 1.85  1993/03/23  17:58:17  jont
 *  Added vi_init
 *
 *  Revision 1.84  1993/03/22  18:48:11  jont
 *  Added call to vector_init
 *
 *  Revision 1.83  1993/03/10  15:52:37  jont
 *  Added load file environment function
 *
 *  Revision 1.82  1993/02/01  16:04:43  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.81  1993/01/11  13:28:01  richard
 *  Added x_init().  Corrected raise of Unbound exception.
 *
 *  Revision 1.80  1992/11/11  11:15:26  clive
 *  Needed to initialise the tracing
 *
 *  Revision 1.79  1992/11/02  16:09:09  richard
 *  Moved everything out into separate files grouped by function.
 *
 *  Revision 1.78  1992/10/15  13:41:46  richard
 *  Added calls to alter working directory.
 *
 *  Revision 1.77  1992/10/12  16:20:58  clive
 *  Now we use mark's assembler multiply
 *
 *  Revision 1.76  1992/10/07  08:39:09  clive
 *  Definition of call_debugger has changed
 *
 *  Revision 1.75  1992/10/02  10:07:51  matthew
 *  Update for CLM functions
 *
 *  Revision 1.74  1992/10/02  09:42:45  richard
 *  Removed use of uname() which doesn't work on enough
 *  versions of SunOS.
 *
 *  Revision 1.73  1992/10/01  15:41:30  richard
 *  Added ansi.h and time functions.
 *
 *  Revision 1.72  1992/09/28  16:59:04  matthew
 *  Added scan_real function and bug fixes in real printing.
 *
 *  Revision 1.71  1992/09/23  16:15:55  daveb
 *  Added ml_clear_eof function.
 *
 *  Revision 1.70  1992/09/09  16:48:31  richard
 *  Added a new `explode' function using allocate multiple.  Much
 *  much faster.
 *
 *  Revision 1.69  1992/09/01  13:48:49  richard
 *  Changed system information stuff to functions.
 *  Added argument passing.
 *
 *  Revision 1.68  1992/08/28  15:16:07  clive
 *  Added a function to get the debug string from a code string
 *
 *  Revision 1.67  1992/08/28  10:54:35  richard
 *  Reverted the environment to a function.
 *  Added dummy definitions for some old builtins.
 *
 *  Revision 1.66  1992/08/27  16:05:05  richard
 *  Added floating point error handling.
 *
 *  Revision 1.65  1992/08/26  15:48:54  richard
 *  The module table is now a pervasive value.
 *  Changes to the MLWorks structure including the export of
 *  the Unix environment.
 *  Added ml_print_real().
 *
 *  Revision 1.64  1992/08/24  16:55:33  richard
 *  Added bytearray operations.
 *
 *  Revision 1.63  1992/08/24  10:52:19  richard
 *  Added bytearray operations and rebound some system stuff.
 *
 *  Revision 1.62  1992/08/22  14:39:41  clive
 *  Adedd stop_single_stepping
 *
 *  Revision 1.61  1992/08/22  14:35:10  clive
 *  Fixed a bug in the tag_as_interesting functions
 *
 *  Revision 1.60  1992/08/19  15:03:24  richard
 *  Added unsafe value utilities.
 *
 *  Revision 1.59  1992/08/18  15:43:32  richard
 *  Corrected root problem in ml_input.
 *  Added value utilities for converting various things.
 *  Added output functions for reals and ints.
 *
 *  Revision 1.58  1992/08/17  10:55:19  richard
 *  Added the `gc interface' to the pervasive environment.
 *
 *  Revision 1.57  1992/08/14  13:53:25  richard
 *  Corrected open mode in reopen_out().
 *
 *  Revision 1.56  1992/08/13  11:39:11  clive
 *  Added a function to get header information from an ml_object
 *
 *  Revision 1.55  1992/08/11  15:29:25  clive
 *  Work on tracing
 *
 *  Revision 1.54  1992/08/10  12:49:02  richard
 *  Added load_wordset to function tables.
 *
 *  Revision 1.53  1992/08/07  14:00:35  clive
 *  Changed the functionality of some of the debugger functions - added support
 *  for tracing
 *
 *  Revision 1.52  1992/08/07  10:09:27  richard
 *  The type of weak_apply changed.
 *
 *  Revision 1.51  1992/08/05  16:02:08  davidt
 *  Added seek and reopen to ml pervasives.
 *
 *  Revision 1.50  1992/08/05  13:49:44  richard
 *  Added stuff to fix streams on image load.  Corrected the interpretation
 *  of error codes from the profiler.
 *
 *  Revision 1.49  1992/08/04  12:37:52  richard
 *  Changed interrupt to prevent inescapable loops in the runtime
 *  system.
 *
 *  Revision 1.48  1992/07/31  13:31:48  clive
 *  Added call_function temporarily
 *
 *  Revision 1.47  1992/07/29  13:31:09  clive
 *  Changed call_debugger
 *
 *  Revision 1.46  1992/07/28  14:09:24  richard
 *  Pervasive C functions and values are now added to a runtime environment
 *  rather than being exported to a table.
 *  Reimplemented stream stuff.
 *  C functions now raise exceptions directly rather than returning error
 *  codes to ML stubs.
 *
 *  Revision 1.46  1992/07/23  16:18:51  richard
 *  Corrected the implementation of ml_image_save to use the global root
 *  manager.
 *
 *  Revision 1.44  1992/07/22  16:59:56  clive
 *  Added weak array support code
 *
 *  Revision 1.43  1992/07/21  15:26:33  richard
 *  Added experimental functions to perform profiling, image save,
 *  and efficient calls to C from ML.  Changed non-ANSI use of
 *  __asm__ to calls to the ML to C interface.
 *
 *  Revision 1.42  1992/07/16  16:34:21  richard
 *  Implemented a re-entrant version of ml_require and an experimental
 *  ml_save_image().
 *
 *  Revision 1.41  1992/07/16  16:04:13  clive
 *  Took out breakpoint setting functions; used is_ml_frame in get_next_frame
 *  Added the single_stepping hook
 *
 *  Revision 1.40  1992/07/16  10:24:55  richard
 *  The gc_message_level is now a pervasive ref cell, so it can be updated
 *  by the ML code.
 *
 *  Revision 1.39  1992/07/14  16:41:48  clive
 *  Constant in get_next_frame changed from 11 to 12
 *
 *  Revision 1.38  1992/07/14  16:06:25  richard
 *  Changed total_gc_time to gc_clock.
 *
 *  Revision 1.37  1992/07/14  09:31:26  clive
 *  get_next_frame now additionally returns the PC offset into the code string
 *
 *  Revision 1.36  1992/07/10  14:07:15  clive
 *  Added an explicit function for calling the debugger
 *
 *  Revision 1.35  1992/07/08  15:11:45  clive
 *  Added a manual call of the debugger for the interpreter
 *
 *  Revision 1.34  1992/07/03  09:27:30  richard
 *  Lots of tidying up, and some changes to the interrupt handler.
 *
 *  Revision 1.33  1992/07/01  16:23:03  richard
 *  Some tidying, and a change to ml_require() to use a global
 *  module table.
 *
 *  Revision 1.32  1992/06/23  16:34:30  clive
 *  Added some breakpointing stuff
 *
 *  Revision 1.31  1992/06/22  16:22:29  clive
 *  Changed ml_get_next_frame to not return a third "exnp" argument
 *
 *  Revision 1.30  1992/06/22  14:58:21  clive
 *  Added some things for the debugger
 *
 *  Revision 1.29  1992/06/12  18:26:49  jont
 *  Added functions required by interpretive system
 *
 *  Revision 1.28  1992/06/11  11:43:35  clive
 *  Added utilities that the debugger needs
 *
 *  Revision 1.27  1992/05/18  12:52:48  clive
 *  Added timers and code for compiling the make system
 *
 *  Revision 1.26  1992/05/14  13:48:18  jont
 *  Corrected implementation of string < and > (== for =)
 *
 *  Revision 1.25  1992/05/13  14:50:18  jont
 *  fixed mod and div to give the correct answers according to the
 *  definition
 *
 *  Revision 1.24  1992/05/12  15:05:40  jont
 *  Changed to check properly for overflow on multiply
 *
 *  Revision 1.23  1992/04/24  15:43:41  jont
 *  Added ml_exn_name
 *
 *  Revision 1.22  1992/04/02  10:30:58  richard
 *  Removed debugging message and corrected append.
 *
 *  Revision 1.21  1992/04/01  14:29:43  richard
 *  Fixed some more problems with roots.  Reimplemented append so that
 *  it works.
 *
 *  Revision 1.20  1992/04/01  09:59:05  richard
 *  Rewrote a lot of bad code concerned with roots.
 *
 *  Revision 1.19  1992/03/18  13:39:18  richard
 *  Rewrote file handling functions to deal with arbitrary numbers
 *  of files.  Tidied up.
 *
 *  Revision 1.18  1992/03/10  13:40:35  clive
 *  New Io system and substring
 *
 *  Revision 1.17  1992/03/06  16:33:37  clive
 *  ml_explode and ml_implode did not null-terminate the strings that they produced
 *
 *  Revision 1.16  1992/03/05  17:06:37  clive
 *  Typo's in string_equality
 *
 *  Revision 1.15  1992/03/04  16:01:45  clive
 *  Strings now use memcmp etc to allow null characters within the string
 *
 *  Revision 1.14  1992/02/27  11:12:03  clive
 *  Needed to use declare_root around calls to allocate in case a garbage collection was
 *  forced
 *
 *  Revision 1.13  1992/02/25  15:49:52  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.12  1992/02/18  17:10:23  richard
 *  Added string comparison and a stub for substring.
 *
 *  Revision 1.11  1992/02/18  10:24:05  clive
 *  Got rid of the val_print call in implode
 *
 *  Revision 1.10  1992/02/06  18:14:52  jont
 *  Added dummy implementation of ml_call_compiled_code ready for
 *  when we can be an interpreter style system
 *
 *  Revision 1.9  1992/01/22  08:11:11  richard
 *  Added integer operations.
 *
 *  Revision 1.8  1992/01/02  16:14:47  richard
 *  Corrected the definition of implode to accept a list of strings
 *  of any length.
 *
 *  Revision 1.7  1991/12/23  11:30:10  richard
 *  Added void casts to some unused results.
 *
 *  Revision 1.6  91/12/20  17:15:27  richard
 *  Changed diagnostic output so that it is switchable.
 *
 *  Revision 1.5  91/12/17  15:19:55  richard
 *  Commented out real number functions until we have some ANSI headers.
 *
 *  Revision 1.4  91/12/16  14:25:42  richard
 *  Added error handling to ml_input and ml_output.  Added ml_size and
 *  ml_append.  Moved cons to values.c
 *
 *  Revision 1.3  91/12/13  16:49:42  richard
 *  Added ord, chr, explode, implode, and a dodgy version of equal.
 *
 *  Revision 1.2  91/12/09  16:28:32  richard
 *  Wrote pervasives for file input and output.
 *
 *  Revision 1.1  91/11/28  14:48:24  richard
 *  Initial revision
 *
 */


#include <errno.h>

#include "ansi.h"
#include "pervasives.h"
#include "diagnostic.h"
#include "global.h"
#include "environment.h"
#include "gc.h"
#include "modules.h"
#include "allocator.h"
#include "exceptions.h"
#include "integers.h"
#include "lists.h"
#include "reals.h"
#include "streams.h"
#include "strings.h"
#include "system.h"
#include "mltime.h"
#include "value.h"
#include "bytearrays.h"
#include "vector.h"
#include "stacks.h"
#include "trace.h"
#include "words.h"
#include "pack_words.h"

/*  The message level is initialised to a ref cell containing an integer,
 *  and is used by the garbage collector to determine whether to print
 *  messages. */

mlval gc_message_level = MLUNIT;

/* The stack block limit is initialised to a ref cell containing an
 * integer, and is used by the memory manager to determine when stack
 * overflow occurs. */

mlval max_stack_blocks = MLUNIT;

/*  == Module list ==
 *
 *  See main() and modules.h.
 */

mlval modules = MLUNIT;


/*  === LOOK UP A RUNTIME BINDING ===
 *
 *  This function is called from ML in order to look up a function or value
 *  bound in the runtime environment.
 */

mlval perv_lookup(mlval string)
{
  mlval value = env_lookup(CSTRING(string));

  DIAGNOSTIC(2, "perv_lookup(\"%s\")", CSTRING(string), 0);

  if(value == MLERROR)
    exn_raise_string(perv_exn_ref_unbound, CSTRING(string));

  return(value);
}

static mlval save_modules(const char *name, mlval *root, int deliver)
{
  if (deliver) {	/* clean down the module table */
    MLUPDATE(modules,0,mt_empty());
  }
  return modules;
}

/*  === INITIALISE THE LIBRARY ===  */

void pervasives_init(void)
{
  gc_message_level = allocate_array(1);
  MLUPDATE(gc_message_level, 0, MLINT(2));
  declare_global("gc message level", &gc_message_level,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("gc message level", gc_message_level);

  max_stack_blocks = allocate_array(1);
  MLUPDATE(max_stack_blocks, 0, MLINT(320)); /* About 20Mb */
  declare_global("mem max stack blocks", &max_stack_blocks,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("mem max stack blocks", max_stack_blocks);

  modules = mlw_ref_make(mt_empty());
  declare_global("module list", &modules,
		 0 /* no flags! */, save_modules, NULL, NULL);
  env_value("system module root", modules);

  exn_init();
  integers_init();
  lists_init();
  reals_init();
  streams_init();
  strings_init();
  system_init();
  time_init();
  value_init();
  bytearrays_init();
  vector_init();
  stacks_init();
  trace_init();
  words_init();
  pack_words_init();
}
