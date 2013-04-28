/*  ==== C-IMPLEMENTED PERVASIVES ====
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
 *  The pervasives.c file implements various ML functions values which are
 *  exported to the pervasive environment of ML via the runtime environment
 *  (see environment.h).
 *
 *  Revision Log
 *  ------------
 *  Revision log: $Log: pervasives.h,v $
 *  Revision log: Revision 1.3  1996/01/15 17:30:16  nickb
 *  Revision log: Remove "storage manager" interface; replace it with regular functions.
 *  Revision log:
 * Revision 1.2  1994/06/09  14:45:05  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:14:10  nickh
 * new file
 *
 *  Revision 1.27  1992/10/28  14:19:35  richard
 *  General reorganization of the pervasives into separate files.
 *
 *  Revision 1.26  1992/10/02  10:48:26  matthew
 *  Added a CLM exception
 *
 *  Revision 1.25  1992/08/26  15:44:54  richard
 *  The module table is now a pervasive value.
 *  Added exn_unbound to be raised when env_lookup() fails.
 *
 *  Revision 1.24  1992/08/17  10:55:59  richard
 *  Added a prototype for the interrupt_handler.
 *
 *  Revision 1.23  1992/07/28  13:28:54  richard
 *  Removed exported ML functions.  C pervasives are now added to
 *  the runtime environment instead.
 *
 *  Revision 1.22  1992/07/22  14:04:30  clive
 *  Added weak array support code
 *
 *  Revision 1.21  1992/07/16  10:30:38  clive
 *  Removed breakpointing C functiond
 *
 *  Revision 1.20  1992/07/16  10:24:58  richard
 *  The gc_message_level is now a pervasive ref cell, so it can be updated
 *  by the ML code.
 *
 *  Revision 1.19  1992/07/09  14:44:05  clive
 *  Added an explicit function for calling the debugger
 *
 *  Revision 1.18  1992/07/07  16:19:08  clive
 *  Added a manual call of the debugger for the interpreter
 *
 *  Revision 1.17  1992/06/23  13:31:38  clive
 *  Added some breakpointing stuff
 *
 *  Revision 1.16  1992/06/19  15:43:44  jont
 *  Added ml_require function for use by interpreter
 *
 *  Revision 1.15  1992/06/12  18:27:03  jont
 *  Added functions required by interpretive system
 *
 *  Revision 1.14  1992/06/11  10:46:25  clive
 *  Added utilities that the debugger needs
 *
 *  Revision 1.13  1992/05/18  11:43:49  clive
 *  Added timers and code for compiling the make system
 *
 *  Revision 1.12  1992/04/24  15:44:09  jont
 *  Added ml_exn_name
 *
 *  Revision 1.11  1992/03/12  16:06:23  richard
 *  Added lookahead() and pervasives_init().
 *
 *  Revision 1.10  1992/03/10  12:44:45  clive
 *  ml_eof added
 *
 *  Revision 1.9  1992/02/25  14:06:55  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.8  1992/02/18  17:10:27  richard
 *  Added string comparisons and substring.
 *
 *  Revision 1.7  1992/02/06  18:14:19  jont
 *  Added ml_call_compiled_code
 *
 *  Revision 1.6  1992/01/22  08:11:11  richard
 *  Added integer operations.
 *
 *  Revision 1.5  1991/12/17  14:48:36  richard
 *  Added functions for real numbers.
 *
 *  Revision 1.4  91/12/16  12:48:12  richard
 *  Added ml_size and ml_append.
 *  
 *  Revision 1.3  91/12/13  16:49:17  richard
 *  Added ord, chr, explode, implode, and a dodgy version of equal.
 *  
 *  Revision 1.2  91/12/04  16:20:58  richard
 *  Added pervasives for file input and output.
 *  
 *  Revision 1.1  91/11/28  16:07:46  richard
 *  Initial revision
 *  
 */

#ifndef pervasives_h

#include "mltypes.h"

#include <signal.h>


/*  === INITIALISE THE PERVASIVES ===
 *
 *  Carries out any internal initialisation and initialises the runtime
 *  environment (see environment.h).
 */

void pervasives_init(void);


/*  == The global module list ==
 *
 *  This is a ref to the list of modules that have been loaded by main() or
 *  ML.
 */

extern mlval modules;

/* gc_message_level is a ref cell set to the value supplied to the `-c'
 * option on the runtime system command line, or set by the ML code. */

extern mlval gc_message_level;

/* max_stack_blocks is a ref cell set to the value supplied to the `-stack'
 * option on the runtime system command line, or set by the ML code. */

extern mlval max_stack_blocks;

/* perv_lookup is called directly from the ML/C interface */

extern mlval perv_lookup (mlval string);

#endif
