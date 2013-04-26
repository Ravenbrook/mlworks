/*  === TOP LEVEL OF RUNTIME SYSTEM ===
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This file contains the main() function, which parses the command
 *  line and performs actions accordingly, but belongs to the DLLized
 *  version of the runtime.
 *
 *  Revision Log
 *  ------------
 *  $Log: mlw_dll.c,v $
 *  Revision 1.9  1998/10/16 14:22:08  jont
 *  [Bug #70207]
 *  Move start_mlworks into separate file
 *
 * Revision 1.8  1998/09/16  15:04:35  jont
 * [Bug #70174]
 * Fix compiler warning from gcc
 *
 * Revision 1.7  1998/09/16  10:54:07  jont
 * [Bug #30108]
 * Move system specific stuff into os.c
 *
 * Revision 1.6  1998/07/17  16:48:51  jont
 * [Bug #30108]
 * Implement DLL based ML code
 *
 * Revision 1.5  1998/06/12  14:37:25  jkbrook
 * [Bug #30411]
 * Command-line option to act as free edition
 *
 * Revision 1.4  1998/04/14  13:37:25  mitchell
 * [Bug #50061]
 * Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.3  1998/02/23  18:23:24  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.2  1997/11/26  10:09:42  johnh
 * [Bug #30134]
 * add extra arg to save_excutable.
 *
 * Revision 1.1  1997/05/22  11:20:01  andreww
 * new unit
 * [Bug #30045]
 * conversion of main.c to work in a dll.
 *
 *
 */

#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "ansi.h"

#include "types.h"
#include "mltypes.h"

#include "values.h"
#include "profiler.h"
#include "license.h"
#include "options.h"
#include "mem.h"
#include "gc.h"
#include "loader.h"
#include "image.h"
#include "global.h"
#include "utils.h"
#include "allocator.h"
#include "interface.h"
#include "initialise.h"
#include "os.h"
#include "print.h"
#include "exec_delivery.h"
#include "pervasives.h"
#include "diagnostic.h"
#include "explore.h"
#include "state.h"
#include "environment.h"

#include "mlw_dll.h"
#include "mlw_ci_os.h"
#include "mlw_start.h"

mlw_ci_export int mlw_main(int argc, const char *const *argv)
{
  run_scheduler(start_mlworks, argc, argv, MLUNIT, NULL);
  stop_mlworks();
  return (EXIT_SUCCESS);
}

mlw_ci_export void trampoline(mlval setup, void (*declare)(void))
{
  int argc;
  const char *const *argv = parse_command_line(&argc);
  run_scheduler(start_mlworks, argc, argv, setup, declare);
  exit(0);
}
