/*  === TOP LEVEL OF RUNTIME SYSTEM ===
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
 *  This file contains the main() function, which parses the command
 *  line and performs actions accordingly.
 *
 *  Revision Log
 *  ------------
 *  $Log: main.c,v $
 *  Revision 1.13  1998/10/16 14:08:52  jont
 *  [Bug #70207]
 *  Move start_mlworks into separate file
 *
 * Revision 1.12  1998/09/16  11:57:05  jont
 * [Bug #30108]
 * Add extra parameters to run_scheduler for DLL work
 *
 * Revision 1.11  1998/06/12  14:39:23  jkbrook
 * [Bug #30411]
 * Add command-line option to behave as Free edition
 *
 * Revision 1.10  1998/04/14  13:37:28  mitchell
 * [Bug #50061]
 * Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.9  1998/02/23  18:22:48  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.8  1997/11/26  10:09:28  johnh
 * [Bug #30134]
 * add extra arg to save_excutable.
 *
 * Revision 1.7  1997/04/11  14:03:22  jont
 * [Bug #1833]
 * Change instances of "modules" in runtime usage message to "object files"
 *
 * Revision 1.6  1997/03/10  09:11:54  stephenb
 * [Bug #1925]
 * stop_mlworks: set the messager_function to NULL before a message
 * is output so that the message always goes to the tty.
 *
 * Revision 1.5  1996/12/23  15:52:04  jont
 * [Bug #1880]
 * Remove expiry date protection checking from MLWorks
 *
 * Revision 1.4  1996/10/25  15:05:26  nickb
 * Change explorer entry.
 * .,
 *
 * Revision 1.3  1996/10/23  12:46:53  jont
 * [Bug #1693]
 * Don't hang on license failure when running in batch mode
 *
 * Revision 1.2  1996/10/17  13:15:34  jont
 * Merging in license server stuff
 *
 * Revision 1.1.2.3  1996/10/15  14:44:49  jont
 * Release the license when terminating
 *
 * Revision 1.1.2.2  1996/10/09  12:16:23  nickb
 * Name change: license -> license_init.
 *
 * Revision 1.1.2.1  1996/10/07  16:13:15  hope
 * branched from 1.1
 *
 * Revision 1.1  1996/08/27  16:29:51  nickb
 * new unit
 * Portable main.c at last.
 *
 */

#include <stdlib.h>
#include "threads.h"
#include "mlw_start.h"
#include "values.h"
#include "main.h"

int main(int argc, const char *const *argv)
{
  run_scheduler(start_mlworks, argc, argv, MLUNIT, NULL);
  return (EXIT_SUCCESS);
}
