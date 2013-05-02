/* Copyright 1997 The Harlequin Group Limited.  All rights reserved.
**
** This is the OS dependent part of the C<->ML interface.
** Implements dynamic loading of shared objects via LoadLibrary.
**
** Revision Log
** ------------
**
** $Log: mlw_ci_os.c,v $
** Revision 1.4  1998/02/24 11:21:40  jont
** [Bug #70018]
** Modify declare_root to accept a second parameter
** indicating whether the root is live for image save
**
 * Revision 1.3  1997/06/30  12:31:38  stephenb
 * [Bug #30029]
 * Add mlw_ci_raise_syserr
 *
 * Revision 1.2  1997/05/21  15:40:03  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.1  1997/05/06  11:10:16  stephenb
 * new unit
 * [Bug #30030]
 *
**
*/

#include <windows.h>		/* LoadLibrary, GetProcAddress */
#include "exceptions.h"		/* exn_raise_syserr */
#include "gc.h"			/* declare_root, retract_root */
#include "global.h"		/* declare_global, GLOBAL_DEFAULT */
#include "allocator.h"          /* ml_string */
#include "mlw_ci.h"
#include "mlw_ci_globals.h"	/* mlw_c_init_globals */
#include "mlw_ci_os_init.h"	/* mlw_ci_os_init */
#include "win32_error.h"	/* mlw_raise_c_syerr */



mlw_ci_export mlw_val mlw_ci_raise_syserr(int i)
{
  mlw_raise_c_syserr(i);
  return mlw_val_unit;		/* not reached */
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
** Keep this in sync with <URI:hope://MLWsrc/rts/src/OS/Unix/mlw_ci_os.c>.
*/
static mlw_val mlw_ci_files;



/*
** MLWorksDynamicLibrary.openLibrary : string * string -> MLWorksDynamicLibary.library
**
*/
static mlw_val mlw_ci_file_open_file(mlw_val arg)
{
  LPCSTR file_name= file_name= mlw_ci_str_to_charp(mlw_arg(arg, 0));
  LPCSTR init_name= mlw_ci_str_to_charp(mlw_arg(arg, 1));
  HINSTANCE dll_handle;

  if ((dll_handle= LoadLibrary(file_name)) == NULL) {
    mlw_raise_win32_syserr(GetLastError());
  } else {
    FARPROC init_function= GetProcAddress(dll_handle, init_name);
    if (init_function == NULL) {
      mlw_raise_win32_syserr(GetLastError());
    } else {
      declare_root(&arg, 0);
      init_function();
      retract_root(&arg);
    }
  }

  mlw_ci_files= mlw_cons(arg, mlw_ci_files);
  return mlw_ci_void_ptr_from_voidp(dll_handle);
}




/*
** MLWorksDynamicLibrary.closeLibrary : (MLWorksDynamicLibrary.library * string option) -> unit
**
*/
static mlw_val mlw_ci_file_close_file(mlw_val arg)
{
  HMODULE dll_handle= mlw_ci_void_ptr_to_voidp(mlw_arg(arg, 0));
  mlw_val optional_fin= mlw_arg(arg, 1);
  if (!mlw_val_option_is_none(optional_fin)) {
    LPCSTR fini_name= mlw_ci_str_to_charp(mlw_val_option_some(optional_fin));
    FARPROC fini_function= GetProcAddress(dll_handle, fini_name);
    if (fini_function == NULL) {
      mlw_raise_win32_syserr(GetLastError());
    } else {
      fini_function();
    }
  }
  if (FreeLibrary(dll_handle) != 0) 
    mlw_raise_win32_syserr(GetLastError());
  return mlw_val_unit;
}



/*
** Called as a fixup for the C.files root.
** It loads all the .DLL files.
*/
static void mlw_ci_load_files(mlw_val files)
{
  mlw_val fs= files;
  declare_root(&fs, 0);
  for (; fs != MLNIL; fs= MLTAIL(fs)) {
    mlw_val h= MLHEAD(fs);
    LPCSTR file_name= mlw_ci_str_to_charp(mlw_val_rec_field(h, 0));
    LPCSTR init_name= mlw_ci_str_to_charp(mlw_val_rec_field(h, 1));
    HINSTANCE dll_handle;
    if ((dll_handle= LoadLibrary(file_name)) == NULL) {
      retract_root(&fs);
      mlw_raise_win32_syserr(GetLastError());
    } else {
      FARPROC init_function= GetProcAddress(dll_handle, init_name);
      if (init_function == NULL) {
	retract_root(&fs);
	mlw_raise_win32_syserr(GetLastError());
      } else {
	/* XXX: If this raises an exception, the fs root will be left
         * dangling 
	 */
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
  mlw_ci_register_function("C.File.openFile",  mlw_ci_file_open_file);
  mlw_ci_register_function("C.File.closeFile", mlw_ci_file_close_file);
}
