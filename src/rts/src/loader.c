/*  ==== MODULE LOADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Needs documenting.
 *
 *  Revision Log
 *  ------------
 *  $Log: loader.c,v $
 *  Revision 1.44  1998/09/30 14:53:23  jont
 *  [Bug #70108]
 *  Make sure stat.h is included before syscalls.h to avoid problems with lstat
 *
 * Revision 1.43  1998/08/21  16:36:05  jont
 * [Bug #30108]
 * Implement DLL based ML code
 *
 * Revision 1.42  1998/04/23  14:23:11  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.41  1998/04/22  15:06:06  jont
 * [Bug #70091]
 * Remove require_name from consistency info as it's not needed now
 *
 * Revision 1.40  1998/03/19  11:40:36  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.39  1998/03/19  10:52:11  jont
 * [Bug #70018]
 * Add cast to call to live_in_gen
 *
 * Revision 1.38  1998/02/27  14:37:05  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.37  1997/11/18  12:31:53  jont
 * [Bug #30089]
 * Remove include of mltime.h which is no longer needed
 *
 * Revision 1.36  1997/10/21  09:01:34  jont
 * [Bug #30089]
 * Timestamps changed to be pairs of integers representing
 * stamp div 10**6 and stamp mod 10**6
 *
 * Revision 1.35  1997/10/10  18:25:18  daveb
 * [Bug #20090]
 * Changed the module table to store the time stamps from the consistency
 * information, instead of the modification times of the files themselves.
 *
 * Revision 1.34  1997/07/22  11:57:24  jont
 * [Bug #20069]
 * Check validity of stack_params to make_ancill
 *
 * Revision 1.33  1997/06/03  16:26:34  jont
 * [Bug #30076]
 * Modify to make NONGC spills be counted in words
 *
 * Revision 1.32  1997/06/03  08:57:22  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.31  1997/02/10  14:05:01  matthew
 * Reverse bytes in read_real
 *
 * Revision 1.30  1996/06/26  11:40:44  stephenb
 * Fix #1439 - NT: Stack browswer frame hiding doesn't work properly.
 * Make read_delivered_name work for Win32 i.e. remove the assumption
 * that files use "/" as separators.
 *
 * Revision 1.29  1996/02/19  13:54:21  nickb
 * Delivered images still contain long empty loader_code tables.
 *
 * Revision 1.28  1996/02/16  14:40:16  nickb
 * Change to declare_global().
 *
 * Revision 1.27  1996/02/14  14:59:39  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.26  1996/01/11  16:46:45  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.25  1995/11/09  11:01:58  nickb
 * Strange bug in delivery names.
 *
 * Revision 1.24  1995/10/25  17:03:54  nickb
 * Change delivery names to make them recognisable to the debugger.
 *
 * Revision 1.23  1995/09/19  10:27:36  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.22  1995/07/27  09:37:00  nickb
 * Postpone loader_code_add() until the code object is complete.
 *
 * Revision 1.21  1995/05/05  14:21:19  jont
 * Make load_module static, as it's only called internally.
 *
 * Revision 1.20  1995/05/02  15:32:06  jont
 * Remove superfluous error causing line
 *
 * Revision 1.19  1995/05/02  14:30:48  jont
 * Handle unable to access mo files by returning an error which can be
 * translated into an exception
 *
 * Revision 1.18  1995/04/07  09:27:38  matthew
 * Use OBJECT_CODE_VERSION to check version of code
 *
 * Revision 1.17  1995/02/20  15:01:16  matthew
 * Adding ml_observer function
 *
 * Revision 1.16  1994/12/09  17:54:21  jont
 * Change file opening to be rb
 *
 * Revision 1.15  1994/12/09  15:42:01  jont
 * Change time.h to mltime.h
 *
 * Revision 1.14  1994/11/09  16:41:47  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.13  1994/10/07  16:54:02  jont
 * Changed to be more vigilant about spotting non-aligned code vector total size
 *
 * Revision 1.12  1994/10/06  11:51:09  jont
 * Added routine read_raw_word which does not attempt to change endian
 * before returning its result. This is used to determine the endianness
 * of each mo file. Put this one down to the horrors of imperative programming!
 *
 * Revision 1.11  1994/10/04  10:58:21  jont
 * Control change_endian on the code by machine specific value
 *
 * Revision 1.10  1994/09/07  10:33:13  nickb
 * Make incompatible timestamp message a warning (not a diagnostic).
 *
 * Revision 1.9  1994/07/25  09:49:32  nickh
 * Fix load_wordset to handle object version 14.
 *
 * Revision 1.8  1994/07/19  16:55:29  jont
 * Add callee saves to ancillary information
 *
 * Revision 1.7  1994/06/30  12:10:15  nickh
 * Change to code name delivery, and to printing of diagnostic messages.
 *
 * Revision 1.6  1994/06/24  15:21:30  jont
 * Increase version to 13
 *
 * Revision 1.5  1994/06/22  15:11:32  nickh
 * Fix interception treatment of loaded wordsets.
 *
 * Revision 1.4  1994/06/21  15:59:24  nickh
 * New ancillary structure.
 *
 * Revision 1.3  1994/06/13  11:53:55  nickh
 * Bump version number.
 *
 * Revision 1.2  1994/06/09  14:33:07  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:58:21  nickh
 * new file
 *
 *  Revision 1.61  1994/04/08  15:53:55  jont
 *  Add original require file names to consistency info.
 *
 *  Revision 1.60  1994/03/14  16:17:09  jont
 *  Fixed such that when timestamp tests find module missing, the same
 *  error is produced as if the time stamps weren't being done. In
 *  particular, errno is now set in this case.
 *
 *  Revision 1.59  1994/01/28  17:23:00  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.58  1994/01/10  13:43:20  matthew
 *  Added function internal_load_link for use by image builder and by the ml mo loader.
 *
 *  Revision 1.57  1993/12/22  11:37:32  jont
 *  Added delivery option which discards code vector names
 *
 *  Revision 1.56  1993/12/07  12:19:58  daveb
 *  Checked return value of mt_lookup_time.
 *
 *  Revision 1.55  1993/12/01  12:49:54  matthew
 *  Made it understand version 9 too.  There must be a better way of doing this!
 *
 *  Revision 1.54  1993/11/24  10:13:03  jont
 *  Changed to allow detection of inconsistent mo sets
 *
 *  Revision 1.53  1993/08/27  19:22:11  daveb
 *  Bug in read_opt_int (I wrote << instead of <<=).
 *
 *  Revision 1.52  1993/08/26  17:36:58  daveb
 *  load_module sets the module name from the consistency information in the
 *  file.
 *
 *  Revision 1.51  1993/08/12  11:24:32  daveb
 *  mt_lookup takes an extra argument.
 *
 *  Revision 1.50  1993/08/06  17:13:02  richard
 *  Increased the level of a diagnostic.
 *
 *  Revision 1.49  1993/06/18  08:52:33  daveb
 *  New object file format.  Runtime is compatible with old version.
 *
 *  Revision 1.48  1993/05/27  15:10:27  jont
 *  New version cos encapsulator has changed
 *
 *  Revision 1.47  1993/05/18  10:46:28  richard
 *  Changed the layout of code vectors in the encapsulator in order to
 *  reduce the amount of root juggling that would have been necessary
 *  to correct a bug calling the loader code observer.
 *
 *  Revision 1.46  1993/05/10  15:43:37  jont
 *  Fixed problem with superfluous mlupdate(spills, ...) outside scope
 *  of declare/retract. Removed superfluous reallocation of code vector.
 *  Added declare/retract round call to weak_add in loader_code_add
 *
 *  Revision 1.45  1993/04/15  13:37:46  richard
 *  All ancillary slots are now loaded.
 *
 *  Revision 1.44  1993/03/18  11:56:57  jont
 *  New version to account for code changes for leaf and intercept offset
 *
 *  Revision 1.43  1993/03/11  18:17:58  jont
 *  Moved ANCILLARY_SLOT_SIZE into values.h
 *
 *  Revision 1.42  1993/02/12  16:36:07  jont
 *  Changes for code vector reform
 *
 *  Revision 1.41  1993/02/01  14:47:24  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.40  1993/01/15  10:25:53  daveb
 *  Changed runtime_version to object_file_version.
 *
 *  Revision 1.39  1993/01/05  13:48:04  daveb
 *  Added version parameter to load_wordset.  Changed current version to 3,
 *  which has the new representation of lists.
 *
 *  Revision 1.38  1992/08/25  13:27:25  richard
 *  Changed the action when the loader finds a wrongly sized real
 *  number.  It now exits with an error code.
 *
 *  Revision 1.37  1992/08/18  11:19:17  richard
 *  Added missing root declarations.  (Oops)
 *
 *  Revision 1.36  1992/08/13  18:47:57  davidt
 *  Small change to the object file format.
 *
 *  Revision 1.35  1992/08/07  10:42:26  richard
 *  Implemented load_wordset.
 *
 *  Revision 1.34  1992/08/07  08:46:13  richard
 *  The loader keeps track of code vectors (again) but an observer
 *  function can be declared from any profiler.  This gives more
 *  flexibility for use by the memory auditer.
 *
 *  Revision 1.33  1992/08/05  17:22:41  richard
 *  Removed incorrect load_wordset() temporarily.
 *  Code vectors are now tagged differently to strings.
 *
 *  Revision 1.32  1992/08/04  15:01:27  richard
 *  Changed read_wordset to cope with a garbage collection caused by
 *  profile_new().
 *
 *  Revision 1.31  1992/07/29  14:22:41  richard
 *  The profiler, rather than the loader, maintains a list of code vectors.
 *
 *  Revision 1.30  1992/07/27  13:00:27  richard
 *  Changed delcare_code_vector() to declare_code(), exported it, and
 *  increased the size of the arrays it uses.
 *
 *  Revision 1.29  1992/07/20  12:24:38  richard
 *  Removed redundant include of "gc.h".
 *
 *  Revision 1.28  1992/07/15  17:24:28  richard
 *  Added load_wordset().
 *
 *  Revision 1.27  1992/07/14  09:21:17  richard
 *  Implemented load_code_vectors, and changed the way the loader
 *  interacts with the profiler.
 *
 *  Revision 1.26  1992/07/02  09:12:42  richard
 *  Returns ERROR to indicate error rather than IMPOSSIBLE.
 *
 *  Revision 1.25  1992/07/01  13:47:45  richard
 *  Changed module table types.  See modules.h.
 *
 *  Revision 1.24  1992/06/11  09:56:58  clive
 *  Fixes for the profiler
 *
 *  Revision 1.23  1992/05/12  19:45:54  jont
 *  Allowed comprehension of version 2, created when the magic number was
 *
 *  Revision 1.22  1992/05/05  09:54:01  clive
 *  Function called by value of ml_vector needs to declare it
 *
 *  Revision 1.21  1992/04/14  11:59:48  clive
 *  First version of the profiler
 *
 *  Revision 1.20  1992/03/20  15:49:05  richard
 *  Corrected calculatio of backpointers.
 *
 *  Revision 1.19  1992/03/20  14:46:26  richard
 *  New module format.  Added code to deal with different module versions.
 *
 *  Revision 1.18  1992/03/17  17:26:35  richard
 *  Changed error behaviour and parameterised the module table.
 *
 *  Revision 1.17  1992/02/13  16:13:57  clive
 *  Never closed any files - it does now
 *
 *  Revision 1.16  1992/01/14  13:32:03  richard
 *  Changed the call of callml to pass the closure rather than the ml_vector
 *
 *  Revision 1.15  1992/01/09  16:23:52  richard
 *  Fixed an error in the loading of codesets.
 *
 *  Revision 1.14  1991/12/23  13:18:42  richard
 *  Changed the name of the fatal runtime error handler to error().
 *
 *  Revision 1.13  91/12/20  17:07:39  richard
 *  Rewrote read_codeset so that it works.  Changed diagnostic output to be
 *  switchable.
 *  
 *  Revision 1.12  91/12/17  16:47:40  nickh
 *  add in_ML flag.
 *  
 *  Revision 1.11  91/12/17  16:35:41  richard
 *  Added code to add suffices to module names.  Restricted the sizes
 *  of reals to doubles only.
 *  
 *  Revision 1.10  91/11/11  18:00:57  jont
 *  Added read_real. Modified read_string to put the actual string length
 *  into the header word, as opposed to the padded length
 *  
 *  Revision 1.9  91/10/24  16:17:04  davidt
 *  Changed name of callml.h to interface.h
 *  
 *  Revision 1.8  91/10/23  16:46:51  davidt
 *  Fixed size put into backpointers in codesets to be in bytes as required.
 *  
 *  Revision 1.7  91/10/21  11:35:40  davidt
 *  Made some minor changes and finished implementation of read_codeset.
 *  read_codeset now reads each individual function in using one big
 *  read and also puts in the separating backpointers between functions
 *  in the same codeset.
 *  
 *  Revision 1.6  91/10/18  16:10:31  davidt
 *  Actually calls ML now! loader_error now takes three arguments.
 *  Strings now have a word_aligned size.
 *  
 *  Revision 1.5  91/10/17  16:58:47  davidt
 *  Big hacks all over the place which have nearly got the thing loading
 *  object files properly. Codesets are done properly yet.
 *  
 *  Revision 1.4  91/10/16  14:04:42  davidt
 *  Major revision after change to object file format (not quite
 *  finished yet).
 *  
 *  Revision 1.3  91/05/17  17:11:09  jont
 *  Reals allocated as strings
 *  
 *  Revision 1.2  91/05/15  15:32:14  jont
 *  Revised interface for second version of load format
 *  
 *  Revision 1.1  91/05/14  11:11:27  jont
 *  Initial revision
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <errno.h>
#include <memory.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "ansi.h"
#include "syscalls.h"
#include "mltypes.h"
#include "values.h"
#include "loader.h"
#include "objectfile.h"
#include "allocator.h"
#include "interface.h"
#include "endian.h"
#include "modules.h"
#include "diagnostic.h"
#include "utils.h"
#include "global.h"
#include "pervasives.h"
#include "options.h"
#include "gc.h"
#include "mach_values.h"
#include "cache.h"
#include "loader_local.h"	/* mlw_path_dir_separator, mlw_path_src_tag */
#include "mem.h"		/* GENERATION */

/*  == Loaded code vector list ==  */

mlval loader_code;
void (*loader_code_observer)(mlval code) = NULL;

void (*loader_code_trace_observer)(mlval code) = NULL;

void loader_code_add(mlval code)
{
  declare_root(&code, 0);
  loader_code = weak_add(loader_code, code); /* This may call gc, hence declare */
  if(loader_code_observer != NULL)
    loader_code_observer(code);
  if(loader_code_trace_observer != NULL)
    loader_code_trace_observer(code);
  retract_root(&code);
}

static mlval disable(unsigned int index, mlval code)
{
  int type = SPACE_TYPE(code);
  int ok = 0;
  if (type == TYPE_RESERVED && validate_ml_address((void *)code)) {
    ok = 1;
  } else if (type == TYPE_ML_HEAP) {
    struct ml_heap *gen = VALUE_GEN(code);
    ok = live_in_gen(gen, (mlval *)code);
  }
  if (ok) {
    CCODE_SET_PROFILE(code,(mlval)NULL);
    return(code);
  } else {
    return DEAD;
  }
}

static void loader_code_fix(const char *name, mlval *root, mlval value)
{
  weak_apply(value, disable);
  *root = value;
}



/*  === INITIALISE LOADER ===
 *
 *  This functions declares external ML values as roots.
 */

mlval load_external = MLUNIT;

void load_init(void)
{
  declare_root(&load_external, 0);
  loader_code = weak_new(256);
  declare_global("loaded code list", &loader_code,
		 GLOBAL_DEFAULT+GLOBAL_WEAK_LIST, NULL, loader_code_fix, NULL);
}



/*  == Bulletproof object file reading functions ==
 *
 *  These functions read data from a stream and cause a non-local jump to
 *  `problem' if an error occurs.
 *
 *  NOTE: I'm not sure that the endian changing code is necessary or
 *  correct.
 */

static jmp_buf problem;

static void safe_read(void *whither, size_t size, size_t number, FILE *stream)
{
  if(fread(whither, size, number, stream) != number)
    longjmp(problem, feof(stream) ? ELOADFORMAT : ELOADREAD);
}

static int safe_read_byte(FILE *stream)
{
  int c;

  c = getc(stream);
  if (c == -1)
    longjmp(problem, feof(stream) ? ELOADFORMAT : ELOADREAD);
  return c;
}

static word read_raw_word(FILE *stream)
{
  word w;

  fread(&w, sizeof(word), 1, stream);
  return(w);
}

static word read_word(FILE *stream)
{
  word w;

  fread(&w, sizeof(word), 1, stream);
  change_endian(&w, 1);
  return(w);
}

static mlval read_pair(FILE *stream)
{
  word a = read_word(stream);
  word b = read_word(stream);
  return mlw_cons(MLINT(a), MLINT(b));
}

static int pairs_eq(mlval pair1, mlval pair2)
{
  return ((FIELD(pair1, 0) == FIELD(pair2, 0)) && (FIELD(pair1, 1) == FIELD(pair2, 1)));
}

static word read_opt_int(FILE *stream)
{
  unsigned char c;
  word w;

  c = safe_read_byte(stream);
  if (c == 255)
    w = read_word(stream);
  else if (c == 254) {
    w = (word)safe_read_byte(stream);
    w <<= 8;
    w += (word)safe_read_byte(stream);
  }
  else
    w = (word)c;
  return w;
}

static mlval read_real(FILE *stream)
{
  double the_real;

  mlval ml_real = allocate_real();
  safe_read(&the_real, sizeof(double), 1, stream);

  /* REVERSE_REAL_BYTES defined in mach_values.h for I386 */
  #ifdef REVERSE_REAL_BYTES
  {
    char *bottom = (char *)&the_real;
    char *top = bottom + sizeof(double) - 1;
    while (top > bottom)
      {
	char t = *bottom;
	*bottom = *top;
	*top = t;
	bottom++;
	top--;
      }
  }
  #endif

  (void)SETREAL(ml_real, the_real);
  return(ml_real);
}

static mlval read_string(word string_size, FILE *stream)
{
  mlval ml_string = allocate_string(string_size);

  safe_read(CSTRING(ml_string), word_align(string_size), 1, stream);
  return(ml_string);
}



/* This function is called when loading modules into a debugging
runtime invoked with the -delivery switch. It abbreviates long code
names (from building MLWorks):

"initial_listener[/home/ml/sml/MLW/src/interpreter/_tty_listener.sml:320,7 to 320,54]" becomes "initial_listener[ interpreter._tty_listener:320]"

It's not completely straightforward; some code names include two
location strings:

"Builtin o of pad argument 1[/nfs/ml/home/ml/sml/MLW/src/sparc/_sparc_assembly.sml:465,23 to 467,25] and decode_load_and_store'[/nfs/ml/home/ml/sml/MLW/src/sparc/_sparc_assembly.sml:474,7 to 483,38]"

becomes 

"Builtin o of pad argument 1[ sparc._sparc_assembly:465] and decode_load_and_store'[ sparc._sparc_assembly:474]"

*/

static mlval read_delivery_name(word string_size, FILE *stream)
{
  char *str = (char*)malloc(string_size);
  char *start_of_locn = str, *end_of_locn, *workptr;
  mlval result_string;

  safe_read (str,word_align(string_size),1,stream);

  while (((start_of_locn = strchr(start_of_locn,'[')) != NULL) &&
	 ((end_of_locn = strchr(start_of_locn,']')) != NULL)) {

    /* found a location string, from start_of_locn to end_of_locn */

    /* remove "foo/bar/baz/src/" substring */
    workptr = strstr(start_of_locn+1, mlw_path_src_tag);
    if ((workptr != NULL) && (workptr < end_of_locn)) {
      start_of_locn[1] = ' '; /* distinguishing delivered code names */
      strcpy (start_of_locn+2,workptr+5);
      end_of_locn -= (workptr+3-start_of_locn);

      /* change remaining slashes to dots */
      workptr = start_of_locn;
      while (((workptr = strchr(workptr, mlw_path_dir_separator)) != NULL) &&
	     (workptr < end_of_locn))
	*workptr = '.';

      /* remove any ".sml" */
      if (((workptr = strstr(start_of_locn,".sml")) != NULL) &&
	  (workptr < end_of_locn)) {
	strcpy(workptr,workptr+4);	
	end_of_locn -= 4;
      }
    }
    
    /* remove ",45 to 456,65" tail of the location string */
    if ((workptr = strchr(start_of_locn,',')) != NULL)
      strcpy(workptr,end_of_locn);

    start_of_locn = end_of_locn;
  }

  result_string = ml_string (str);
  free(str);
  return result_string;
}

static word read_cons_size(FILE *stream)
{
  word list_size;

  fseek(stream, HEADER_SIZE, 0);
  list_size = read_opt_int(stream);
  DIAGNOSTIC(3, "             stream = 0x%X, cons_size = %u)", stream, list_size);
  return list_size;
}

static mlval read_name(FILE *stream)
{
  mlval name;
  word string_size;
  
  string_size = read_opt_int(stream);
  name = allocate_string(string_size + 1);
  safe_read(CSTRING(name), string_size, 1, stream);
  CSTRING(name)[string_size] = '\0';
  return name;
}

/* make ancillary word with checking */

extern mlval make_ancill(word saves,
			 word spill,
			 word leaf,
			 int intercept, /* signed! */
			 word stack_param,
			 word code_no)
{
  if (spill % sizeof(mlval) != 0) {
    error("Trying to load code vector with non word aligned nongc spill area (%x)",
	  spill);
  }
  spill /= sizeof(mlval);
  if (code_no > CCODE_MAX_NUMBER)
    error ("Trying to load object code vector with too many items : %x",
	   code_no);
  if (intercept > CCODE_MAX_INTERCEPT || intercept < -1)
    error ("Trying to load object code with intercept offset too large : %d, %x",
	   intercept, CCODE_MAX_INTERCEPT);
  if (spill > CCODE_MAX_NONGC)
    error ("Trying to load object code with too many non-gc spill slots : %x",
	   spill);

  /* don't check leaf; it's a boolean */

  if (stack_param > CCODE_MAX_ARGS)
    error ("Trying to load object code with too many stacked parameters : %x",
	   stack_param);

  return CCODE_MAKE_ANCILL(saves, spill,leaf,intercept,stack_param, code_no);
}

/*  == Load codeset ==
 *
 *  A codeset is a set of procedures which are allocated in the same
 *  code vector.  The procedures have back-pointers to the start of the
 *  string between them so that the garbage collector knows what to do
 *  with them.  The code sizes in the input file do not take account
 *  of the back pointers, and so these are inserted here.
 *
 *  The start address of each procedure is inserted into the array objects.
 *
 *  The delivery option affects how code names read are treated.
 */

static int read_codeset(unsigned int nr_procedures,
			 mlval objects,
			 FILE *stream,
			 unsigned int version,
			 int delivery)
{
  mlval vector, ancillary, *next;
  mlval names, profiles;
  size_t i, offset, length, file_length;
  word *proc_positions;

  DIAGNOSTIC(3, "read_codeset(nr_procedures = %u, objects = 0x%X",
	        nr_procedures, objects);
  DIAGNOSTIC(3, "             stream = 0x%X, version = %d)", stream, version);

  declare_root(&objects, 0);

  /* Read and calculate the length of code vector required.  This is one */
  /* word for each instruction, plus two words per code item for the item */
  /* header, plus one words for the ancillary pointer. */

  file_length = read_word(stream);
  if(word_align(file_length) != file_length) {
    errno = ELOADALIGN;
    return(MLERROR);
  }

  length = file_length/sizeof(word) + 2*nr_procedures + 1;

  /* build the record of names */
  if (nr_procedures == 1) {	/* by far the commonest case */

    size_t size = read_word(stream);
    mlval name = (delivery ? read_delivery_name(size,stream)
		  : read_string(size,stream));
    declare_root (&name, 0);
    DIAGNOSTIC(3, "  name = %s",CSTRING(name),0);
    names = allocate_record(1);
    FIELD(names,0) = name;
    retract_root (&name);
    declare_root (&names, 0);

  } else {
    /* not such a common case */
    /* have to allocate an array for the names, read them in, then copy to a record */

    mlval names_array = allocate_array(nr_procedures);
    for (i=0; i<nr_procedures; ++i)
      MLUPDATE(names_array, i, MLUNIT);
    declare_root(&names_array, 0);

    for (i=0; i<nr_procedures; ++i) {
      size_t size = read_word(stream);
      mlval name = (delivery ? read_delivery_name(size,stream)
		    : read_string(size,stream));
      MLUPDATE(names_array, i, name);
    }
    /* Now copy to a record */
    names = allocate_record(nr_procedures);
    for (i=0; i<nr_procedures;i++)
      FIELD(names,i) = MLSUB(names_array,i);
    retract_root(&names_array);
    declare_root(&names, 0);
  }

  profiles = allocate_record(nr_procedures);
  for (i=0; i < nr_procedures; i++)
    FIELD(profiles,i) = (mlval) 0;
  declare_root (&profiles, 0);

  /* If we're not interceptible, we don't create an array or put a
     slot in the ancillary record for the intercept functions*/

  {
    word interceptible = read_word(stream);
    if (interceptible) {
      mlval interfns = allocate_array(nr_procedures);
      for(i=0; i<nr_procedures; ++i)
	MLUPDATE(interfns, i, MLUNIT);
      declare_root(&interfns, 0);
      ancillary = allocate_record (3);
      FIELD(ancillary,ANC_INTERFNS) = interfns;
      retract_root(&interfns);
    } else
      ancillary = allocate_record (2);
  }

  FIELD(ancillary,ANC_PROFILES) = profiles;
  FIELD(ancillary,ANC_NAMES) = names;

  retract_root (&names);
  retract_root (&profiles);
  declare_root (&ancillary, 0);

  vector = allocate_code(length);
  CCVANCILLARY(vector) = ancillary;
  declare_root(&vector, 0);
  retract_root(&ancillary);

  /* Read the code items */

  DIAGNOSTIC(3, "code vector 0x%X of %d items", vector, nr_procedures);

  proc_positions = (word*)alloc(sizeof(word)*nr_procedures,
				"Code loading procedure positions");
  offset = 2;
  for(i=0; i<nr_procedures; ++i) {
    word size, position, spill, saves, leaf, stack_param;
    int intercept;
    mlval code;

    /* Read the position in the closure */
    position = read_word(stream);
    proc_positions[i] = position;

    /* Read the ancillary information: number of non-GC spills, */
    /* the leaf flag, the intercept offset */
    /* and the number of stacked parameters */

    spill = read_word(stream);
    saves = read_word(stream);
    leaf = read_word(stream) ? 1 : 0;
    intercept = CINT(MLINT(read_word(stream)));	/* to get the sign right */
    stack_param = read_word(stream);

    /* Now insert the actual code into the vector */

    next = (mlval *)OBJECT(vector) + offset;
    code = MLPTR(POINTER, next);

    /* Insert a BACKPTR to the real header. */
    *next = MAKEHEAD(BACKPTR, offset * sizeof(mlval));

    /* Insert the code pointer into the closure */
    MLUPDATE(objects, position, code);

    /* Make the ancillary number */
    next[1] = make_ancill(saves, spill,leaf,intercept, stack_param,i);

    size = read_word(stream);
    safe_read(&next[2], size, 1, stream);
    if (change_code_endian) change_endian(&next[2], size);
    cache_flush((void*) &next[2], (size_t) size);

    offset += double_align(size + 2*sizeof(mlval))/sizeof(mlval);

    DIAGNOSTIC(3, "  %3u: 0x%X", i, code);
    DIAGNOSTIC(3, "       position %u  length 0x%X bytes", position, size);
    DIAGNOSTIC(3, "       non-GC spills %u  %sleaf", spill, leaf ? "" : "non-");
    DIAGNOSTIC(3, "       intercept offset %d", intercept, 0);

  }

  /* Have to apply loader_code_add() to all the code items after the whole
   * code object is complete */

  for(i=0; i<nr_procedures; ++i) {
    mlval code = MLSUB(objects, proc_positions[i]);
    loader_code_add(code);	/* this could cause a GC */
  }
  free(proc_positions);

  retract_root(&vector);
  retract_root(&objects);
  return 0;
}



/*  === LOAD AN ML MODULE ===
 *
 *  Loading a module consists of reading ML objects from the module file and
 *  putting them in an ML record which record becomes the closure of the
 *  setup function for the module.
 *
 * This also checks the consistency of the loading if required.
 *
 * The delivery option affects how code names are treated.
 */

static mlval load_module(const char *filename, mlval *mod_name, mlval *source_time,
			 mlval modules, int verbose, int dont_check_cons, int delivery)
{
  unsigned int i, opcode, module_size, table_size, code_offset, version;
  mlval objects = MLUNIT, closure, mo_time = MLUNIT;
  mlval require_name = MLUNIT;
  FILE *volatile stream;
  size_t length, cons_size;

  /* Attempt to open object file with the given name.  If that fails */
  /* and the name doesn't end in `.mo', try adding that. */
  stream = fopen(filename, "rb");

  if(stream == NULL &&
     strcmp(filename + (length = (unsigned)strlen(filename)) - 3u, ".mo"))
  {
    char *name_with_suffix = (char *)malloc(length + 3 + 1);

    if(name_with_suffix == NULL)
    {
      errno = ELOADALLOC;
      return(MLERROR);
    }

    strcpy(name_with_suffix, filename);
    strcpy(name_with_suffix + length, ".mo");

    stream = fopen(name_with_suffix, "rb");

    free(name_with_suffix);
  }

  if(stream == NULL)
  {
    errno = ELOADOPEN;
    return(MLERROR);
  }

  declare_root(&modules, 0);
  declare_root(&objects, 0);
  declare_root(&mo_time, 0);
  declare_root(&require_name, 0);

  /* Set up an error handler for the reading functions.  See read() above. */
  {
    int code = setjmp(problem);

    if(code != 0)
    {
      errno = code;
      retract_root(&modules);
      retract_root(&objects);
      retract_root(&require_name);
      retract_root(&mo_time);
      fclose(stream);
      return(MLERROR);
    }
  }

  /* Find endianess of object file, check the version number and code */
  /* size, and seek to the start of the code. */
  if(!find_endian(read_raw_word(stream)))
  {
    errno = ELOADFORMAT;
    return(MLERROR);
  }

  version = read_word(stream);

  /* Check that the version of the mo is compatible with the current loader */
  /* see objectfile.h for OBJECT_CODE_VERSION */

  if(version < OBJECT_CODE_VERSION)
    longjmp(problem, ELOADVERSION);

  /* Get code offset */

  code_offset = read_word(stream);
  cons_size = read_cons_size(stream);

  *mod_name = read_name(stream);

  *source_time = read_pair(stream);
  /* This is the first item of the consistency information */
  /* We don't care about the time here */

  while (--cons_size > 0) {
    /* Check the other time stamps */
    require_name = read_name(stream);

    mo_time = read_pair(stream);
    if (!dont_check_cons) {
      mlval mt_time = mt_lookup_time(modules, require_name, *mod_name);
      if (mt_time == MLERROR) {
	load_external = require_name;
	longjmp(problem, ELOADEXTERNAL);
      }
      if (!pairs_eq(mo_time,mt_time)) {
	message_start();
	message_string("Warning: module '");
	message_string(CSTRING(*mod_name));
	message_string("' references module '");
	message_string(CSTRING(require_name));
	message_string("' with incompatible time stamp. Recompilation recommended.");
	message_end();
#ifdef DIAGNOSTICS
	if (4 <= diagnostic_level) {
	  unsigned int *foo = (unsigned int *)(((int)mo_time)-1);
	  int len,i;
	  message_stderr("mo_time = 0x",0,0);
	  len = LENGTH(foo[-1]);
	  for(i=0;i<len;i++)
	    message_stderr(" %x",foo[i]);
	  
	  foo = (unsigned int *)((int)(mt_lookup_time(modules, require_name, *mod_name))-1);
	  message_stderr("\nrequire_time = 0x");
	  len = LENGTH(foo[-1]);
	  for(i=0;i<len;i++)
	    message_stderr(" %x",foo[i]);
	}
	message_stderr("\n");
#endif /* DIAGNOSTICS */
      }
    }
  }

  /* Seek to the code */

  fseek(stream, (signed int) code_offset, 0);

  if (verbose) {
    message_start();
    message_string("Loading module `");
    message_string(CSTRING(*mod_name));
    message_string("'");
    message_end();
  }

  module_size = read_word(stream);
  table_size = read_word(stream);

  DIAGNOSTIC(4, "  module size %d  table size %d", module_size, table_size);

  /* Get a vector if appropriate size */
  objects = allocate_array(table_size);
  for(i = 0; i < table_size; i++)
    MLUPDATE(objects, i, MLUNIT);

  /* Load objects into vector */
  for (i = 0; i < module_size; i++)
  {
    opcode = read_word(stream);

    switch (opcode)
    {
      case OPCODE_CODESET:
      {
	word codeset_size = read_word(stream);
	if (read_codeset(codeset_size, objects, stream, version, delivery) == MLERROR)
	  longjmp(problem, errno);
      }
      break;

      case OPCODE_REAL:
      {
	word offset = read_word(stream);
	word real_size = read_word(stream);

	if(real_size != 2)
	  longjmp(problem, ELOADFORMAT);

        DIAGNOSTIC(4, "  real to position 0x%lX", offset, 0);

	{
	  mlval temp = read_real(stream);  /* Do NOT inline this */
	  MLUPDATE(objects, offset, temp);
	}
      }
      break;

      case OPCODE_STRING:
      {
	word offset = read_word(stream);
	word string_size = read_word(stream);

        DIAGNOSTIC(4, "  string to position 0x%lX", offset, 0);

	{
	  mlval temp = read_string(string_size,stream);  /* Do NOT inline this */
	  MLUPDATE(objects, offset, temp);
	}
      }
      break;

      case OPCODE_EXTERNAL:
      {
	/* Find out the name of the module referred to by the external */
	/* and look it up in the module table. */
	word offset = read_word(stream);
	word string_size = read_word(stream);
	mlval name = read_string(string_size, stream);
	mlval module = mt_lookup(modules, name, *mod_name);

	if(module == MLERROR)
	{
	  load_external = name;
	  longjmp(problem, ELOADEXTERNAL);
	}

        DIAGNOSTIC(4, "  external reference to module %s in "
		      "position 0x%lX", CSTRING(name), offset);

	MLUPDATE(objects, offset, module);
      }
      break;

      default:
      longjmp(problem, ELOADFORMAT);
    }
  }

  fclose(stream);


  closure = allocate_record(table_size);
  for(i=0; i<table_size; ++i)
    FIELD(closure, i) = MLSUB(objects, i);

  retract_root(&modules);
  retract_root(&require_name);
  retract_root(&mo_time);
  retract_root(&objects);

/* The consistency information follows on immediately from the code */

  return(closure);
}


/* internal_load_link, called from main.c to load a module, and also
 * callable from ML to load a .mo file into a running image.
 * 
 * The delivery option doesn't do anything at present. */

mlval internal_load_link(const char *filename, 
			 mlval *mod_name_ptr,
			 int verbose, 
			 int dont_check_cons,
			 int delivery)
{
  mlval closure;
  mlval structure;
  mlval time;

  declare_root(mod_name_ptr, 0);
  declare_root(&time, 0);

  closure = load_module(filename, mod_name_ptr, &time, DEREF(modules),
			verbose, dont_check_cons, delivery);

  if(closure == MLERROR)
    {
      retract_root(mod_name_ptr);
      retract_root(&time);
      return (MLERROR);
    }
  else
    {
      structure = callml(closure, closure);
      {
	mlval temp = mt_add(DEREF(modules), *mod_name_ptr, structure, time);
	/* Do NOT inline this */
	MLUPDATE(modules, 0, temp);
      }
      retract_root(mod_name_ptr);
      retract_root(&time);

      return(structure);
    }
}


/*  === LOAD A COMPILED WORDSET ===
 *
 *  From main/code_module.sml:MachTypes:

 datatype wordset =
    WORD_SET of
    {a_names:string list,
    b: {a_clos:int,
        b_spills:int,
	c_saves:int,
	d_code:string} list,
    c_leafs:bool list,
    d_intercept:int list,
    e_stack_parameters:int list}
 *
 *  The first argument to load_wordset is the runtime version required for
 *  this wordset.
 *
 *  See also: read_codeset() which loads the same object from a `.mo' file.
 */

mlval load_wordset(mlval argument)
{
  size_t length = 0, offset;
  mlval result = MLNIL, vector, list = MLUNIT, code = MLUNIT;
  unsigned int version = CINT(FIELD(argument, 0)), i, nr_procedures = 0;
  mlval wordset = FIELD(argument, 1);
  mlval names, ancillary, profiles, interceptible, leafs;
  mlval intercepts, stack_params;

  DIAGNOSTIC(2, "load_wordset(version = %d, wordset = 0x%X)", version, wordset);

  if(version != OBJECT_FILE_VERSION)
  {
    errno = version > OBJECT_FILE_VERSION ? ELOADNEWER : ELOADOLDER;
    return(MLERROR);
  }

  /* Calculate the length of the code vector and perform consistency checks. */

  for(list=FIELD(wordset, 1); list!=MLNIL; list=MLTAIL(list))
  {
    mlval quadruple = MLHEAD(list);
    size_t l = word_align(CSTRINGLENGTH(FIELD(quadruple,3)));
    if(word_align(l) != l)
    {
      errno = ELOADALIGN;
      return(MLERROR);
    }
    /* One for back pointer, one for number within set */
    length += l/sizeof(word) + 2;

    ++nr_procedures;
  }

  if(length == 0)
  {
    errno = ELOADEMPTY;
    return(MLERROR);
  }

  DIAGNOSTIC(3, "  nr_procedures=%u  length=%u", nr_procedures, length);

  declare_root(&wordset, 0);

  /* Create the names record */
  names = allocate_record(nr_procedures);
  DIAGNOSTIC(3, "  function names record 0x%X:", names, 0);
  for (i=0, list=FIELD(wordset, 0); i<nr_procedures; ++i, list=MLTAIL(list))
  {
    FIELD(names,i) = MLHEAD(list);
    DIAGNOSTIC(3, "    %3d: `%s'", i, CSTRING(MLHEAD(list)));
  }
  declare_root (&names, 0);

  profiles = allocate_record(nr_procedures);
  for (i=0; i < nr_procedures; i++)
    FIELD(profiles,i) = (mlval) 0;
  declare_root (&profiles, 0);

  /* Determine whether any code items are interceptible. */

  interceptible = 0;
  for(list=FIELD(wordset, 3); list!=MLNIL; list=MLTAIL(list))
    interceptible |= (MLHEAD(list) != MLINT(-1));

  if (interceptible) {
    mlval interfns = allocate_array(nr_procedures);
    for(i=0; i<nr_procedures; ++i)
      MLUPDATE(interfns, i, MLUNIT);
    declare_root(&interfns, 0);
    ancillary = allocate_record (3);
    FIELD(ancillary,ANC_INTERFNS) = interfns;
    retract_root(&interfns);
  } else
    ancillary = allocate_record (2);
    
  FIELD(ancillary,ANC_PROFILES) = profiles;
  FIELD(ancillary,ANC_NAMES) = names;

  retract_root (&profiles);
  retract_root (&names);
  declare_root (&ancillary, 0);

  vector = allocate_code(length+1);
  CCVANCILLARY(vector) = ancillary;

  declare_root(&vector, 0);
  retract_root(&ancillary);

  retract_root(&wordset);

  /* only root now is vector; have to declare these next four as roots
     because they will be pointing into the wordset structure when we do
     allocation. */

  declare_root(&list, 0);
  declare_root(&leafs, 0);
  declare_root(&intercepts, 0);
  declare_root(&stack_params, 0);

  /* this will be pointing to the list of results that we build up */

  declare_root(&result, 0);

  /* this will be pointing at the current code item when we do a cons */

  declare_root(&code, 0);

  DIAGNOSTIC(3, "  code vector 0x%X", vector, 0);

  /* prepare for the loop: */

  offset = 2;
  list=FIELD(wordset, 1);
  leafs=FIELD(wordset,2);
  intercepts=FIELD(wordset,3);
  stack_params=FIELD(wordset,4);
  /* do the loop: */

  for(i=0; list!=MLNIL; ++i)
  {
    mlval quad = MLHEAD(list);		  /* (position,non_gcs,saves,code) */
    mlval string = FIELD(quad, 3);	  /* the code itself */
    mlval position = FIELD(quad, 0);	  /* the position in the closure */
    word spills = CINT(FIELD(quad,1));	  /* the number of non-GC spills */
    word saves = CINT(FIELD(quad,2));	  /* the number of callee saves */
    word leaf = CINT(MLHEAD(leafs));	  /* is it a leaf? */
    int intercept = CINT(MLHEAD(intercepts)); /* where to intercept it? */
    int stack_param = CINT(MLHEAD(stack_params)); /* How many stacked parameters */
    size_t length = CSTRINGLENGTH(string); /* size of the code itself */
    mlval *next = (mlval *)OBJECT(vector) + offset; /* where do we write it? */
    mlval pair;

    code = MLPTR(POINTER, next);

    next[0] = MAKEHEAD(BACKPTR, offset * sizeof(mlval));

    next[1] = make_ancill(saves, spills,leaf,intercept, stack_param,i);

    memcpy((char *)&next[2], CSTRING(string), length);
    cache_flush((void *)&next[2], length);

    DIAGNOSTIC(3, "    %3d: position %d", i, position);
    DIAGNOSTIC(3, "         offset 0x%X  spills %u", offset, CINT(FIELD(quad, 1)));

    /* prepare for next time around the loop: */

    offset += double_align(length + 2*sizeof(mlval))/sizeof(mlval);
    intercepts = MLTAIL(intercepts);
    leafs = MLTAIL(leafs);
    list = MLTAIL(list);
    stack_params = MLTAIL(stack_params);

    /* build the result pair and cons it onto the list */

    pair = allocate_record(2);
    FIELD(pair, 0) = position;
    FIELD(pair, 1) = code;
    result = mlw_cons(pair, result);
  }

  /* When the code object is complete, we can apply loader_code_add() */

  for (list = result; list != MLNIL; list = MLTAIL(list)) {
    mlval pair = MLHEAD(list);
    loader_code_add(FIELD(pair,1));
  }

  retract_root(&list);
  retract_root(&leafs);
  retract_root(&intercepts);
  retract_root(&stack_params);
  retract_root(&vector);
  retract_root(&code);
  retract_root(&result);

  return(result);
}
