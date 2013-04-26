/*  ==== PERVASIVE TIME ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: system.c,v $
 *  Revision 1.35  1998/08/17 13:41:51  jkbrook
 *  [Bug #50100]
 *  Remove use of env_lookup("license edition")
 *
 * Revision 1.34  1998/07/17  15:15:50  jkbrook
 * [Bug #30436]
 * Update edition names
 *
 * Revision 1.33  1998/06/12  09:01:41  jkbrook
 * [Bug #30411]
 * Adding FREE edition
 *
 * Revision 1.32  1998/06/10  14:09:52  mitchell
 * [Bug #30419]
 * Fix missing include of license.h
 *
 * Revision 1.31  1998/06/09  15:11:00  mitchell
 * [Bug #30419]
 * Disable session saving and delivery in free edition
 *
 * Revision 1.30  1998/02/23  18:35:27  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.29  1997/11/26  10:09:18  johnh
 * [Bug #30134]
 * add extra arg to save_excutable.
 *
 * Revision 1.28  1997/11/18  12:32:20  jont
 * [Bug #30089]
 * Remove include of mltime.h which is no longer needed
 *
 * Revision 1.27  1997/06/30  11:18:13  andreww
 * [Bug #20014]
 * cleaning up.
 *
 * Revision 1.25  1997/06/13  13:32:42  jkbrook
 * [Bug #50004]
 * Merging changes from 1.0r2c2 into 2.0m0
 *
 * Revision 1.24.9.3  1997/06/09  10:38:50  daveb
 * [Bug #50004]
 * Moved test for file creation from ml_deliver_function to Win32-specific code.
 *
 * Revision 1.24.9.2  1997/05/20  17:02:01  daveb
 * [Bug #02035]
 * Check that file can be written before beginning to deliver.
 *
 * Revision 1.24.9.1  1997/05/12  10:44:51  hope
 * branched from 1.24
 *
 * Revision 1.24  1996/09/06  14:56:55  jont
 * Add CSTRING to use of load_external in error message
 *
 * Revision 1.23  1996/07/29  10:05:20  stephenb
 * Add a comment to arguments explaining why there is no retract_root
 * to match the declare_root.
 *
 * Revision 1.22  1996/05/01  08:53:14  nickb
 * Change to save_executable.
 *
 * Revision 1.21  1996/04/17  10:33:30  stephenb
 * Remove ml_system and ml_exit.  They are now provided in OS/{Win32,Unix}
 * since they raise OS specific values on error.
 *
 * Revision 1.20  1996/03/19  15:02:11  daveb
 * Made the ELOADEXTERNAL error message include the value of load_external.
 *
 * Revision 1.19  1996/02/16  15:41:18  nickb
 * Change to global_pack().
 *
 * Revision 1.18  1996/02/14  15:10:37  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.17  1996/02/14  10:20:36  jont
 * Add a dummy return value to ml_exit to keep VC++ happy
 *
 * Revision 1.16  1996/02/08  17:53:23  jont
 * Include export.h, which now has the interface to do_exportFn
 *
 * Revision 1.15  1996/01/16  12:02:01  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.14  1995/09/26  14:39:11  jont
 * Add executable image save
 *
 * Revision 1.13  1995/09/19  10:31:25  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.12  1995/09/15  14:33:24  jont
 * Work on using fork for exportFn
 *
 * Revision 1.11  1995/09/13  14:09:43  jont
 * Remove extra garbage collections during exportFn
 *
 * Revision 1.10  1995/09/13  10:03:05  jont
 * Add ml_save_function for use by exportFn
 *
 * Revision 1.9  1995/06/09  15:09:12  nickb
 * Move profiler interface to profiler.c
 *
 * Revision 1.8  1995/05/05  14:20:58  jont
 * Change call to internal_load_link not be verbose
 *
 * Revision 1.7  1995/05/02  14:45:05  jont
 * Make error strings consistent by removing full stops.
 * Add file names to error messages where files are mentioned
 *
 * Revision 1.6  1994/12/09  15:43:51  jont
 * Change time.h to mltime.h
 *
 * Revision 1.5  1994/08/30  15:07:10  matthew
 * filename needs to be a root in ml_image_save
 *
 * Revision 1.4  1994/06/24  10:50:38  nickh
 * Declare profiler result as a root.
 *
 * Revision 1.3  1994/06/21  16:02:03  nickh
 * New ancillary structure and forced GC on image save.
 *
 * Revision 1.2  1994/06/09  14:49:36  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:23:32  nickh
 * new file
 *
 *  Revision 1.13  1994/03/24  18:12:38  nickh
 *  New profiler, with a slightly different interface.
 *
 *  Revision 1.12  1994/01/10  13:43:58  matthew
 *  Added ml_load_link
 *
 *  Revision 1.11  1993/06/02  13:09:40  richard
 *  Fixed benign =/== confusion.
 *
 *  Revision 1.10  1993/06/01  12:13:28  richard
 *  *** empty log message ***
 *
 *  Revision 1.9  1993/05/17  13:10:01  richard
 *  Corrected the profile selector to select everything when passed
 *  an empty list.
 *
 *  Revision 1.8  1993/04/14  13:29:29  richard
 *  Moved UNIX stuff to unix.c.
 *
 *  Revision 1.7  1993/04/02  14:31:59  jont
 *  New exception for bad iage when reading table of contents
 *
 *  Revision 1.6  1993/03/11  18:33:57  jont
 *  Added code to do image cleaning, and connected it into the rts
 *
 *  Revision 1.5  1993/02/25  09:56:42  nosa
 *  A minor Bug Fix
 *
 *  Revision 1.4  1993/02/24  14:08:56  nosa
 *  Implemented a multi-level profiler
 *
 *  Revision 1.3  1993/02/01  16:04:36  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.2  1992/12/18  15:22:31  clive
 *  Made the profiler take the generalised streams
 *
 *  Revision 1.1  1992/11/03  12:51:24  richard
 *  Initial revision
 *
 */

#include <stdlib.h>
#include <errno.h>
#include <string.h>

#include "system.h"
#include "exceptions.h"
#include "mltypes.h"
#include "values.h"
#include "gc.h"
#include "allocator.h"
#include "environment.h"
#include "main.h"
#include "profiler.h"
#include "ansi.h"
#include "interface.h"
#include "global.h"
#include "loader.h"
#include "utils.h"
#include "intercept.h"
#include "pervasives.h"
#include "event.h"
#include "threads.h"
#include "diagnostic.h"
#include "image.h"
#include "exec_delivery.h"
#include "export.h"
#include "mlw_mklic.h"
#include "license.h"

static mlval ml_save_image(mlval argument)
{
  mlval global, filename;

  /* license_edition is a global C enum */

  if ((license_edition == PERSONAL) || act_as_free) {
    display_simple_message_box(
      "Saving images is not enabled in the Personal edition of MLWorks");
    return MLUNIT;
  }

  filename = FIELD(argument, 0);
  image_continuation = FIELD(argument, 1);
  declare_root(&filename, 1);

  global = global_pack(0);	/* 0 = not delivery */
  declare_root(&global, 1);

  {
    mlval old_message_level = MLSUB(gc_message_level,0);
    MLUPDATE(gc_message_level,0,MLINT(-1));
    gc_collect_all();
    MLUPDATE(gc_message_level,0,old_message_level);
  }

  argument = allocate_record(2);
  FIELD(argument, 0) = filename;
  FIELD(argument, 1) = global;
  retract_root(&filename);
  retract_root(&global);

  if(image_save(argument) == MLERROR)
    switch(errno)
    {
      case EIMPL:
      exn_raise_string(perv_exn_ref_save, "Image save not implemented");

      case EIMAGEWRITE:
      exn_raise_string(perv_exn_ref_save, "Error writing opened image file");

      case EIMAGEOPEN:
      exn_raise_string(perv_exn_ref_save, "Unable to open image file");

      default:
      exn_raise_string(perv_exn_ref_save, "Unexpected error from image_save()");
    }

  argument = image_continuation;
  image_continuation = MLUNIT;
  return(argument);
}

static mlval ml_save_exec_image(mlval argument)
{
  mlval global, filename;

  if ((license_edition == PERSONAL) || act_as_free) {
    display_simple_message_box(
      "Saving executables is not enabled in the Personal edition of MLWorks");
    return MLUNIT;
  }

  filename = FIELD(argument, 0);
  image_continuation = FIELD(argument, 1);
  declare_root(&filename, 1);

  global = global_pack(0);	/* 0 = not delivery */
  declare_root(&global, 1);

  {
    mlval old_message_level = MLSUB(gc_message_level,0);
    MLUPDATE(gc_message_level,0,MLINT(-1));
    gc_collect_all();
    MLUPDATE(gc_message_level,0,old_message_level);
  }

  retract_root(&filename);
  retract_root(&global);

  if(save_executable(CSTRING(filename), global, APP_CURRENT) == MLERROR)
    switch(errno)
    {
      case EIMPL:
      exn_raise_string(perv_exn_ref_save, "Executable image save not implemented");

      case EIMAGEWRITE:
      exn_raise_string(perv_exn_ref_save, "Error writing opened image file");

      case EIMAGEOPEN:
      exn_raise_string(perv_exn_ref_save, "Unable to open image file");

      default:
      exn_raise_string(perv_exn_ref_save, "Unexpected error from image_save()");
    }

  argument = image_continuation;
  image_continuation = MLUNIT;
  return(argument);
}

static mlval ml_deliver_function(mlval argument)
{
  if ((license_edition == PERSONAL) || act_as_free) {
    display_simple_message_box(
      "Delivering executables is not enabled in the Personal edition of MLWorks");
    /* exn_raise_string(perv_exn_ref_save, 
         "Delivery not enabled for this edition"); */
    return MLUNIT;
  }

  declare_root(&argument, 1);
  gc_collect_all(); /* Do a full gc before forking */
  retract_root(&argument);
  return deliverFn(argument);
}

static mlval ml_image_table(mlval argument)
{
  argument = image_table(argument);
  if(argument == MLERROR)
    switch(errno)
    {
      case EIMPL:
      exn_raise_string(perv_exn_ref_save, "Image table not implemented");

      case EIMAGEREAD:
      exn_raise_string(perv_exn_ref_save, "Error reading opened image file");

      case EIMAGEOPEN:
      exn_raise_string(perv_exn_ref_save, "Unable to open image file");

      default:
      exn_raise_string(perv_exn_ref_save,
		       "Unexpected error from image_table()");
    }

  return(argument);
}




/* arguments: unit -> string list
 *
 * To avoid consing up the list each time this is called, the list
 * is created once and cached.  This is the reason for the declare_root
 * with no corresponding retract_root.
 */
static mlval arguments(mlval unit)
{
  static mlval result= DEAD;
  int i;

  if(result == DEAD)
  {
    result = MLNIL;
    declare_root(&result, 0);

    for(i=module_argc-1; i >= 0; --i) {
      mlval temp= ml_string(module_argv[i]);  /* Do NOT inline this */
      result= mlw_cons(temp, result);
    }
  }

  return result;
}

static mlval name(mlval unit)
{
  mlval string = ml_string(runtime);
  return string;
}





static mlval clean_code(unsigned int index, mlval code)
{
  /* maybe we should do something for the names? */

  CCODE_SET_PROFILE(code,(mlval)NULL);
  if (CCODE_CAN_INTERCEPT(code)) {
    code_nop(code);		/* turn off intercepting */
    CCODE_SET_INTERFN(code,MLUNIT);
  }
  return(code);
}

static mlval ml_clean_image(mlval unit)
{
  weak_apply(loader_code, clean_code);
  return(MLUNIT);
}

static mlval ml_load_wordset(mlval wordset)
{
  mlval result = load_wordset(wordset);

  if(result == MLERROR)
    switch(errno)
    {
      case ELOADNEWER:
      exn_raise_string(perv_exn_ref_load, "Newer format than expected");

      case ELOADOLDER:
      exn_raise_string(perv_exn_ref_load, "Older format than expected");

      case ELOADALIGN:
      exn_raise_string(perv_exn_ref_load, "Code string of unaligned length");

      case ELOADEMPTY:
      exn_raise_string(perv_exn_ref_load, "Empty wordset");

      default:
      error("load_wordset() returned an unexpected error code %d", errno);
    }

  return(result);
}

/* This should raise an exception when an error occurs */
static mlval ml_load_link(mlval arg)
{
  const char *filename = CSTRING(arg);
  /* Maybe this should use options properly -- how are they propagated here? */

  mlval mod_name = MLUNIT;
  mlval result = internal_load_link(filename,&mod_name,0,1,0);

  if(result == MLERROR)
    switch(errno)
      {
      case ELOADREAD:
	exn_raise_format (perv_exn_ref_load,"The loader was unable to read from the file '%s'", filename);
      case ELOADOPEN:
	exn_raise_format (perv_exn_ref_load,"The loader was unable to open the file '%s'", filename);
      case ELOADALLOC:
	exn_raise_string (perv_exn_ref_load,"The loader was unable to allocate enough memory");
      case ELOADVERSION:
	exn_raise_format (perv_exn_ref_load,"The file '%s' contains a module of a version the loader does not understand", filename);
      case ELOADFORMAT:
	exn_raise_format (perv_exn_ref_load,"The file '%s' is not in the correct loader format", filename);
      case ELOADEXTERNAL:
	exn_raise_format (perv_exn_ref_load,"The module in the file '%s' references an unloaded external module '%s'", filename, CSTRING(load_external));
      default:
	exn_raise_string (perv_exn_ref_load,"The loader returned an invalid error code.");
      }
  else
    {
      mlval pair;
      declare_root (&mod_name, 0);
      declare_root (&result, 0);
      pair = allocate_record(2);
      FIELD(pair, 0) = mod_name;
      FIELD(pair, 1) = result;
      retract_root (&mod_name);
      retract_root (&result);
      return(pair);
    }
}

static mlval ml_collect_gen(mlval arg)
{
  int number = CINT(arg);
  if (number >= 0)
    gc_collect_gen((unsigned int)number);
  return MLUNIT;
}

static mlval ml_collect_all(mlval unit)
{
  gc_collect_all();
  return MLUNIT;
}

static mlval ml_promote_all(mlval unit)
{
  gc_promote_all();
  return MLUNIT;
}

void system_init()
{
  env_function("system os name", name);
  env_function("system os arguments", arguments);
  env_function("system load wordset", ml_load_wordset);
  env_function("system load link",ml_load_link);
  env_function("image save", ml_save_image);
  env_function("exec image save", ml_save_exec_image);
  env_function("image table", ml_image_table);
  env_function("function deliver", ml_deliver_function);
  env_function("clean code vectors", ml_clean_image);

  env_function("gc collect generation", ml_collect_gen);
  env_function("gc collect all", ml_collect_all);
  env_function("gc promote all", ml_promote_all);
  env_function("gc collections", gc_collections);
}
