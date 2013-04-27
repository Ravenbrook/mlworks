/*  ==== MODULE LOADER ====
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
 *  Description
 *  -----------
 *  The loader reads a file in ML module format and executes the module
 *  setup procedure with the parameters specified therein.  This yields a
 *  module structure: the result of the compilation unit represented by the
 *  module.
 *
 *  The loader also supplies functions for the `loading' of compiler results
 *  already on the heap, for use by the interpreter.
 *
 *  Revision Log
 *  ------------
 *  $Log: loader.h,v $
 *  Revision 1.6  1998/07/23 11:08:01  jont
 *  [Bug #30108]
 *  Implement DLL based ML code
 *
 * Revision 1.5  1998/03/18  11:49:51  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.4  1995/05/05  14:17:17  jont
 * Make load_module static, as it's only called internally.
 *
 * Revision 1.3  1995/02/20  14:41:31  matthew
 * Adding ml_observer function
 *
 * Revision 1.2  1994/06/09  14:41:20  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:09:08  nickh
 * new file
 *
 *  Revision 1.22  1994/01/10  13:41:58  matthew
 *  > Added function internal_load_link for use by image builder and by the ml mo loader.
 *
 *  Revision 1.21  1993/12/22  11:38:04  jont
 *  Added delivery option which discards code vector names
 *
 *  Revision 1.20  1993/11/23  12:03:49  jont
 *  Changed type of load_module to allow extra parameter to indicate whether
 *  to check for inconsistent sets of mos
 *
 *  Revision 1.19  1993/08/26  16:04:07  daveb
 *  load_module sets the module name from the consistency information in the
 *  file.
 *
 *  Revision 1.18  1993/03/12  13:30:04  richard
 *  Removed fatal errors and replaced them with error codes.
 *
 *  Revision 1.17  1992/08/07  08:27:30  richard
 *  The loader keeps track of code vectors (again) but an observer
 *  function can be declared from any profiler.  This gives more
 *  flexibility for use by the memory auditer.
 *
 *  Revision 1.16  1992/07/29  14:22:55  richard
 *  The profiler, rather than the loader, maintains a list of code vectors.
 *
 *  Revision 1.15  1992/07/27  13:00:26  richard
 *  Added declare_code().
 *
 *  Revision 1.14  1992/07/15  17:24:27  richard
 *  Added load_wordset().
 *
 *  Revision 1.13  1992/07/14  08:16:39  richard
 *  Added load_code_vectors, and removed profile parameter from load_module().
 *
 *  Revision 1.12  1992/07/02  09:12:43  richard
 *  Returns ERROR to indicate error rather than IMPOSSIBLE.
 *
 *  Revision 1.11  1992/07/01  13:47:48  richard
 *  Changed module table types.  See modules.h.
 *
 *  Revision 1.10  1992/04/13  16:32:31  clive
 *  First version of the profiler
 *
 *  Revision 1.9  1992/03/20  14:42:14  richard
 *  Added new error: ELOADVERSION.
 *
 *  Revision 1.8  1992/03/17  17:24:55  richard
 *  Changed error behaviour and parameterised the module table.
 *
 *  Revision 1.7  1991/12/23  11:33:55  richard
 *  Added a missing #include.
 *
 *  Revision 1.6  91/12/17  16:49:08  nickh
 *  add in_ML flag.
 *  
 *  Revision 1.5  91/10/18  14:56:30  davidt
 *  Made loader_error now take an extra argument.
 *  
 *  Revision 1.4  91/10/17  16:10:47  davidt
 *  Put in loader_error macro. load_module now takes different arguments,
 *  partly to deal with the slightly different behaviour required
 *  when we load the last module.
 *  
 *  Revision 1.3  91/10/16  13:32:49  davidt
 *  I intend to change the loader so that it returns the pointer
 *  to the module and the main program updates the table of modules
 *  (instead of load_module side-effecting the table of modules).
 *  
 *  Revision 1.2  91/05/15  15:29:51  jont
 *  Revised interface for second version of load format
 *  
 *  Revision 1.1  91/05/14  11:08:54  jont
 *  Initial revision
 */


#ifndef loader_h
#define loader_h

#include <stdio.h>
#include <stdlib.h>

#include "mltypes.h"
#include "modules.h"



/*  === INITIALISE LOADER ===
 *
 *  This should be called once before any other function in this module.
 */

extern void load_init(void);



/*  == Loaded code vector list ==
 *
 *  The loader maintains a weak list of all code vectors it has loaded.
 *  (See global.h for functions which manipulate such lists.)
 *
 *  A profiler of some sort may need to observe the appearance of new code
 *  vectors in order to initialise profiling tables.  The function pointer
 *  loader_code_observer is called on each new code vector if not NULL.
 *
 *  On image the profiler slots of all code vectors are intialised to
 *  PROFILE_DISABLE.
 */

extern mlval loader_code;
extern void (*loader_code_observer)(mlval code);
extern void (*loader_code_trace_observer)(mlval code);

extern void loader_code_add(mlval code); /* Allow dll based stuff to call this */

/*  === LOAD AN ML MODULE ===
 *
 *  See header comment for description.  The paramters are the filename of
 *  the module file to read, a table of modules which might be used as
 *  external parameters to the module.  The function reads the contents of
 *  the module file and constructs the top-level function of the module on
 *  the heap.  The result is the closure for this function which, when
 *  applied to itself, yields the module result structure.
 *
 *  In the event of an error `errno' is set to one of the enum values below
 *  and ERROR is returned.
 *
 *  In the event of an ELOADEXTERNAL error, `load_external' is assigned the
 *  name of the module referenced.  This variable should not be changed
 *  otherwise.
 */

enum /* errno */
{
  ELOADREAD = 1,	/* An error occurred reading the file. */
  ELOADOPEN,		/* Unable to open the file specified. */
  ELOADALLOC,		/* Unable to allocate memory at some point. */
  ELOADVERSION,		/* The module version is incompatable with the loader. */
  ELOADFORMAT,		/* The module file is not in the proper format. */
  ELOADEXTERNAL		/* A module referenced wasn't in the table. */
};

extern mlval load_external;

extern mlval internal_load_link (const char *filename,
				 mlval *mod_name,
				 int verbose, 
				 int dont_check_cons,
				 int delivery);

/*  === LOAD A COMPILED WORD SET ===
 *
 *  Part of the result of a compilation is a wordset (see MachTypes) which
 *  represents a set of functions to be loaded into one code vector.  This
 *  function takes a wordset on the heap and `loads it' into a code vector.
 *
 *  The result is a list of pairs of positions and code pointers, or ERROR
 *  if an error occurs, in which case errno is set.
 */

enum /* errno */
{
  ELOADNEWER = 1,	/* code is in newer format than expected */
  ELOADOLDER,		/* code is in older format than expected */
  ELOADALIGN,		/* a code string is of unaligned length */
  ELOADEMPTY		/* the wordset was empty */
};

extern mlval load_wordset(mlval wordset);

/* Make ancillary stuff */
extern mlval make_ancill(word saves,
			 word spill,
			 word leaf,
			 int intercept, /* signed! */
			 word stack_param,
			 word code_no);

#endif
