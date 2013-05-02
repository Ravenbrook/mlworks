/* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * This is the OS dependent part of the C<->ML interface.
 * Implements dynamic loading of shared objects via dlopen(3).
 * 
 * Revision Log
 * ------------
 * $Log: mlw_ci_os.c,v $
 * Revision 1.4  1998/02/23 19:03:53  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.3  1997/07/01  14:29:47  stephenb
 * [Bug #30029]
 * Propagate renaming changes made in mlw_ci.h
 *
 * Revision 1.2  1997/05/22  08:42:37  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.1  1997/05/06  11:10:49  stephenb
 * new unit
 * [Bug #30030]
 *
 *
 */

#include <dlfcn.h>		/* dlopen */
#include "exceptions.h"		/* exn_raise_syserr */
#include "gc.h"			/* declare_root, retract_root */
#include "global.h"		/* declare_global, GLOBAL_DEFAULT */
#include "environment.h"	/* env_function */
#include "allocator.h"          /* ml_string */
#include "mlw_ci.h"
#include "mlw_ci_globals.h"	/* mlw_c_init_globals */
#include "mlw_ci_os_init.h"	/* mlw_c_os_init */
#include "mlw_syserr.h"		/* mlw_c_raise_syserr */


mlw_ci_export mlw_val mlw_ci_raise_syserr(int i)
{
  mlw_raise_syserr(i);
  return mlw_val_unit;		/* never gets here. */
}



/*
** An ML list of pairs of the form (file_name, init_function_name).
** This indicates which .DLL files have been loaded into MLWorks.
** 
** A list suffices because the only requirements of the collection
** are :-
** 
** 1) it should be cheap in time and space to add an element to the collection.
** 2) it should should support a reasonably direct method of either
**    applying a function to each element in the collection or iterating
**    over each element.
**
** Keep this in sync with <URI:hope://MLWsrc/rts/src/OS/Win32/mlw_ci_os.c>.
*/
static mlw_val mlw_ci_files;


/*
** MLWorksDynamicLibrary.openLibrary : string * string -> MLWorksDynamicLibary.library
**
*/
static mlw_val mlw_ci_file_open_file(mlw_val arg)
{
  char const * file_name= mlw_ci_str_to_charp(mlw_arg(arg, 0));
  char const * init_name= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  void * file_handle= dlopen(file_name, 1);
  
  if (file_handle == (void *)0) {
    exn_raise_syserr(ml_string(dlerror()), 0);
  } else {
    void (*init_function)()= dlsym(file_handle, init_name);
    if (init_function == NULL) {
      exn_raise_syserr(ml_string(dlerror()), 0);
    } else {
      declare_root(&arg, 0);
      init_function();
      retract_root(&arg);
    }
  }

  mlw_ci_files= mlw_cons(arg, mlw_ci_files);
  return mlw_ci_void_ptr_from_voidp(file_handle);
}



#if 0
/*
** C.File.lookup : C.File.file option * string -> ('d, 'r) -> C.FunPtr.ptr
**
** The idea is to extract the address of a C function so that it can
** be passed around in ML and unltimately passed back to C where it
** may be applied.
**
** It is commented out because it hasn't been tested yet.
*/

static mlw_val mlw_ci_file_lookup(mlw_val arg)
{
  mlw_val optional_handle= mlw_arg(arg, 0);
  char const * function_name= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  void * handle= mlw_val_option_is_none(optional_handle)
    ? (void *)0
    : mlw_ci_void_ptr_to_voidp(optional_handle);
  void *function= dlsym(handle, function_name);
  if (function == (void *)0) {
    /* XXX: do something */
  }
  return mlw_val_c_void_ptr_from_voidp(function);
}
#endif



/*
** MLWorksDynamicLibrary.closeLibrary : (MLWorksDynamicLibrary.library * string option) -> unit
**
*/
static mlw_val mlw_ci_file_close_file(mlw_val arg)
{
  void *file_handle= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  mlw_val optional_fin= mlw_arg(arg, 1);
  if (!mlw_val_option_is_none(optional_fin)) {
    char const * fini_function_name= mlw_ci_str_to_charp(mlw_val_option_some(optional_fin));
    void (*fini_function)()= dlsym(file_handle, fini_function_name);
    if (fini_function == NULL) {
      exn_raise_syserr(ml_string(dlerror()), 0);
    } else {
      fini_function();
    }
  }
  if (dlclose(file_handle) != 0) 
    exn_raise_syserr(ml_string(dlerror()), 0);
  return mlw_val_unit;
}



/*
** Called as a fixup for the C.files root.
** It loads all the .so files.
*/
static void mlw_ci_load_files(mlw_val files)
{
  mlw_val fs= files;
  declare_root(&fs, 0);
  for (; fs != MLNIL; fs= MLTAIL(fs)) {
    mlw_val h= MLHEAD(fs);
    char const * file_name= CSTRING(FIELD(h, 0));
    char const * init_name= CSTRING(FIELD(h, 1));
    void * file_handle= dlopen(file_name, 1);

    if (file_handle == (void *)0) {
      retract_root(&fs);
      exn_raise_syserr(ml_string(dlerror()), 0);
    } else {
      void (*init_function)()= dlsym(file_handle, init_name);
      if (init_function == NULL) {
	retract_root(&fs);
	exn_raise_syserr(ml_string(dlerror()), 0);
      } else {
	init_function();
      }
    }
  }
  retract_root(&fs);
}



static void mlw_ci_load(char const *name, mlw_val *root, mlw_val value)
{
  mlw_ci_load_files(value);
  *root= value;
}


/*
** mlw_ci_init_globals creates a global that will hold the list of
** loaded .dlls.  This must be called before the global representing
** the environment is declared.  See the following for more info
** <URI:spring://ML_Notebook/Design/FI/Core#stub.c.c.reload-order>
*/
void mlw_ci_init_globals(void)
{
  mlw_ci_files= MLNIL;
  declare_global("C.files", &mlw_ci_files, GLOBAL_DEFAULT, NULL, mlw_ci_load, NULL);
}



/*
** mlw_ci_os_init initialises any OS specific parts of the ML<->C interface.
** This should be called from the OS-independent initialisation --
** <URI:hope://MLWsrc/rts/src/mlw_ci.c#mlw_ci_init>.
*/
void mlw_ci_os_init(void)
{
  env_function("C.File.openFile",  mlw_ci_file_open_file);
  env_function("C.File.closeFile", mlw_ci_file_close_file);
}
