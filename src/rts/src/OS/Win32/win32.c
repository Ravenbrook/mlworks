/* Copyright (C) 1994 Harlequin Ltd
 *
 * A misc. collection of Win32 routines needed to support various libraries,
 * but mainly OS.*.  For historic reasons many of the functions are prefixed
 * by win32_, but there is a rolling program to change the prefix to mlw_
 * to avoid any namespace collision problems.  Note that the change isn't
 * strictly necessary for static functions/values but for consistency
 * these have the mlw_ prefix too.
 *
 *  Revision Log
 *  ------------
 *  $Log: win32.c,v $
 *  Revision 1.50  1999/03/18 12:41:29  daveb
 *  [Bug #190523]
 *  Changes to the Windows structure.
 *
 * Revision 1.49  1999/03/18  12:28:28  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 * Revision 1.48  1998/11/03  14:30:08  jont
 * [Bug #70234]
 * Add calls to GetEnvironmentStrings and FreeEnvironmentStrings
 * and pass result as environment in call to CreateProcess
 *
 * Revision 1.47  1998/11/02  15:07:18  jont
 * [Bug #70238]
 * Use WaitForSingleObject istead of busy wait in Windows.execute
 *
 * Revision 1.46  1998/10/29  16:30:14  jont
 * [Bug #70232]
 * Pass correct command line to CreateProcess (70233)
 * Close leftover handles
 *
 * Revision 1.45  1998/10/27  15:58:22  jont
 * [Bug #70220]
 * Add reap function
 *
 * Revision 1.44  1998/10/12  16:29:11  jont
 * [Bug #30490]
 * Get streams from Windows.streamsOf in the right order (they were reversed)
 *
 * Revision 1.43  1998/10/02  09:56:13  jont
 * [Bug #50095]
 * Fix Windows.hasOwnConsole
 *
 * Revision 1.42  1998/08/21  14:09:29  jont
 * [Bug #30108]
 * Implement DLL based ML code
 *
 * Revision 1.41  1998/08/18  11:52:29  jont
 * [Bug #70153]
 * Add prototype for system_validate_ml_address
 *
 * Revision 1.40  1998/08/17  11:16:52  jont
 * [Bug #70153]
 * Add system_validate_ml_address
 *
 * Revision 1.39  1998/08/11  14:57:47  jont
 * [Bug #50094]
 * Fix problems where findExecutable is returning wrong answers
 *
 * Revision 1.38  1998/08/04  08:20:25  mitchell
 * [Bug #30461]
 * Add missing FindClose to  mlw_os_file_sys_full_path
 *
 * Revision 1.37  1998/07/03  12:32:17  mitchell
 * [Bug #30434]
 * Fix access path parameter passing for registry functions
 *
 * Revision 1.36  1998/06/17  14:48:16  johnh
 * [Bug #50083]
 * Convert from short filename to long.
 *
 * Revision 1.35  1998/06/05  14:24:58  mitchell
 * [Bug #30416]
 * Add support for CREATE_ALWAYS
 *
 * Revision 1.34  1998/04/22  12:31:24  johnh
 * [Bug #70042]
 * Fix fullPath to succeed on root directories.
 *
 * Revision 1.33  1998/04/21  11:37:01  jont
 * [Bug #70107]
 * Add a function to close file descriptors opened by _open_osfhandle
 *
 * Revision 1.32  1998/04/07  14:25:08  jont
 * [Bug #70086]
 * Add functions necessary to implement WINDOWS signature in basis
 *
 * Revision 1.31  1998/02/24  11:22:58  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.30  1998/01/16  15:39:35  jont
 * [Bug #70028]
 * Fix problem with trailing \
 * in mlval mlw_os_file_sys_full_path
 *
 * Revision 1.29  1997/10/30  10:53:24  johnh
 * [Bug #30233]
 * Fix create_process.
 *
 * Revision 1.28  1997/05/22  08:50:07  johnh
 * [Bug #01702]
 * mlw_win32_strerror moved to win32_error.h.
 *
 * Revision 1.27  1997/05/21  10:51:55  stephenb
 * [Bug #30142]
 * Change the type of a handle in mlw_dirstream from an int to a boxed
 * int since under Win95 the handle seems to have its bottom bits set.
 *
 * Revision 1.26  1997/03/27  16:23:51  andreww
 * [Bug #2004]
 * make win32_seek seek to current position when third arg=1
 *
 * Revision 1.25  1997/03/24  11:58:14  andreww
 * whoops, correcting previous bug numeber from 1431 -> 1968
 *
 * Revision 1.24  1997/03/24  11:31:41  andreww
 * [Bug #1968]
 * Have to fix stdIN, stdOut and stdErr on every image load.
 *
 * Revision 1.23  1997/03/05  17:48:33  jont
 * [Bug #1940]
 * Modify fullPath to raise OS.SysErr if the file/dir doesn't exist
 *
 * Revision 1.22  1996/11/22  14:21:41  daveb
 * Prevented reg_query_value from raising an exception.
 *
 * Revision 1.21  1996/10/28  10:54:59  stephenb
 * [Bug #1701]
 * mlw_os_process_getenv: remove redundant calls to declare/retract_root.
 *
 * Revision 1.20  1996/10/25  10:33:06  johnh
 * [Bug #1426]
 * Replaced Win32 environment with Windows registry.
 *
 * Revision 1.19  1996/08/22  12:00:39  stephenb
 * [Bug #1554]
 * Reimplement OS.IO.kind
 *
 * Revision 1.18  1996/08/19  13:28:17  stephenb
 * win32_open: change the mode to FILE_SHARE_READ|FILE_SHARE_WRITE so
 * that it is possible to open the same file as input and output.
 * This feature is used by test_suite/basis/os_io.sml to test out
 * the OS.IO stuff.
 *
 * Revision 1.17  1996/08/19  13:22:37  stephenb
 * mlw_os_error_msg: remove a debugging printf left over from
 * when this was originally being implemented.
 *
 * Revision 1.16  1996/07/15  16:35:20  andreww
 * Removing system-specific information from the names of the calls
 * to read, write, seek and close.
 *
 * Revision 1.15  1996/07/04  18:42:57  andreww
 * Debugging code of the win32 size and seek routines,
 * and adding handles for standard in, standard out and standard error
 * streams.
 *
 * Revision 1.14  1996/07/04  11:25:46  stephenb
 * Fix #1456 - add declare/retract roots where necessary.
 *
 * Revision 1.13  1996/06/13  12:55:37  stephenb
 * Add support for OS.FileSys.{setTime,isDir}.
 *
 * Revision 1.12  1996/06/13  10:10:04  stephenb
 * Change the filename part of the dirstream type to be a ref.
 * This is because it the filename is updated by the runtime and without
 * going via a ref, the GC gets confused.  Updated the OS.FileSys.*Dir
 * routines accordingly.
 *
 * Revision 1.10  1996/06/04  12:15:02  stephenb
 * Add more functions to support the latest revised basis definition.
 *
 * Revision 1.9  1996/05/28  13:08:18  stephenb
 * Add support for OS.errorName, OS.syserror and OS.errorMsg
 *
 * Revision 1.8  1996/05/07  12:09:18  stephenb
 * Add support for Time and OS.IO
 *
 * Revision 1.7  1996/04/22  12:47:12  brianm
 * Adding launch process with priority.
 *
 * Revision 1.6  1996/04/17  09:29:29  stephenb
 * Add various routines to support OS.Process.
 *
 * Revision 1.5  1996/04/11  16:19:33  brianm
 * Adding dde_init() call ...
 *
 * Revision 1.4  1996/04/01  09:41:09  stephenb
 * Rationalise the exception handling so that all the routines that
 * raise exceptions raise one that is compatible with Os.SysErr as
 * defined in the latest basis.
 *
 * Revision 1.3  1996/03/12  16:02:27  matthew
 * Adding set wd.
 *
 * Revision 1.2  1996/03/05  12:54:51  jont
 * Add support for osprimio in revised initial basis
 *
 * Revision 1.1  1996/02/20  10:19:28  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/win32.c
 *
 * Revision 1.12  1996/02/19  15:48:01  nickb
 * win32_environment memoizes the Windows environment. This is not
 * necessary: we can do it in ML if we decide it's a good idea.
 *
 * Revision 1.11  1996/02/16  12:51:41  nickb
 * Change to declare_global().
 *
 * Revision 1.10  1996/01/22  16:07:21  stephenb
 * Update the declare_global so that it uses the same name as the env_value
 * for the Win32 exception.
 *
 * Revision 1.9  1996/01/22  15:20:11  stephenb
 * Generally replace "win_nt" with "win32".
 * Change the name of the exceptions since they are no longer pervasive.
 * Removed any functions that are not actually made available on the ML side.
 *
 * Revision 1.8  1996/01/18  15:41:46  stephenb
 * Now that the name of the file has changed (nt -> win32), the
 * name of the corresponding .h file needs to change.
 *
 * Revision 1.7  1996/01/15  16:04:41  matthew
 * Adding directory functions
 *
 * Revision 1.6  1995/09/19  15:41:10  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.5  1995/08/02  15:33:57  jont
 * Remove windows.h
 *
 * Revision 1.4  1995/02/08  13:43:18  jont
 * Change environ to _environ
 *
 * Revision 1.3  1995/01/24  17:51:00  jont
 * Fix problem with realpath (nt_getpathname)
 *
 * Revision 1.2  1995/01/12  15:32:04  jont
 * Add getcd connecting to GetCurrentDirectory
 * Add get_path_name connecting to GetFullPathName
 *
 * Revision 1.1  1994/12/12  14:29:34  jont
 * new file
 *
 *
 */

#include <windows.h>
#include <io.h>			/* _open_osfhandle, access */
#include <fcntl.h>		/* _open_osfhandle, O_RDONLY */
#include <assert.h>		/* assert */
#include <errno.h>		/* errno, ENOENT, ... etc. */
#include <sys/types.h>		/* _fstat, _open_osfhandle */
#include <sys/stat.h>		/* _fstat, _open_osfhandle */
#include <stdlib.h>
#include "win32.h"
#include "values.h"
#include "allocator.h"
#include "gc.h"
#include "environment.h"
#include "global.h"
#include "exceptions.h"
#include "utils.h"
#include "time_date.h"		/* mlw_time_to_file_time */
#include "os_errors.h"		/* mlw_os_syserror ... */
#include "win32_error.h"        /* mlw_win32_strerror ... */
#include "os.h"		        /* system_validate_ml_address ... */
#include "window.h"
#include "words.h"
#include "cache.h"

mlval win32_std_in;
mlval win32_std_out;
mlval win32_std_err;

/* the standard In/Out/Err handles have to be fixed up at every
 * invocation of MLWorks.  Otherwise, (e.g.) a batch compiler will try
 * to use the handle defined for the compiler that compiled it!
 */

static void fix_win32_std_io(const char *name, mlval *root, mlval value)
{
  if(root == &win32_std_in)
    mlw_ref_update(value,MLINT(GetStdHandle(STD_INPUT_HANDLE)));
  else if(root == &win32_std_out)
    mlw_ref_update(value,MLINT(GetStdHandle(STD_OUTPUT_HANDLE)));
  else if(root == &win32_std_err)
    mlw_ref_update(value,MLINT(GetStdHandle(STD_ERROR_HANDLE)));
  else
    error("fix_win32_std_io was called on a unknown root 0x%X", root);

  *root = value;
}


/*
 * OS.errorMsg : syserror -> string
 */
static mlval mlw_os_error_msg(mlval arg)
{
  unsigned int error_code= CWORD(arg);
  mlval error_msg;
  error_msg= ((error_code&0x1) == 0)
    ? mlw_win32_strerror(error_code>>1)
    : ml_string(strerror((int)(error_code>>1)));
  return error_msg;
}



/* Some utilities */

static inline mlval box(UINT x)
{
  mlval b = allocate_string(sizeof(x));
  memcpy(CSTRING(b), (char *)&x, sizeof(x));
  return(b);
}

static inline UINT unbox(mlval b)
{
  UINT x;
  memcpy((char *)&x, CSTRING(b), sizeof(x));
  return(x);
}

#define CHKEY(x) ((HKEY)unbox (x))
#define MLHKEY(x) ((mlval)box ((UINT)x))

#define CREGSAM(x) ((REGSAM)unbox (x))
#define MLREGSAM(x) ((mlval)box ((UINT)x))

mlval ml_hkey_classes_root;
mlval ml_hkey_current_user;
mlval ml_hkey_local_machine;
mlval ml_hkey_users;

/* REGISTRY FUNCTIONS */

/* Security Access Masks */

static REGSAM convert_sam_values (mlval arg)
{
  extern unsigned word32_to_num(mlval word32);
  return (word32_to_num (arg));
}

static mlval reg_close_key (mlval arg)
{
  HKEY hkey = CHKEY (arg);
  long result;

  result = RegCloseKey(hkey);
  if (result)
    exn_raise_syserr(mlw_win32_strerror(result), (result<<1));
  return (MLUNIT);
}

/* This function returns an HKEY option value as opposed to the
 * Windows functionality of returning an indication of success or failure */
static mlval reg_open_key_ex (mlval arg)
{
  HKEY hkey = CHKEY(FIELD(arg, 0));
  char *subkey = CSTRING(FIELD(arg, 1));
  REGSAM security_mask = (REGSAM) convert_sam_values (FIELD (arg, 2));
  HKEY return_key;
  int result;

  result = RegOpenKeyEx(hkey, subkey, 0, security_mask, &return_key);
  if (result) {
    return mlw_option_make_none();
  } else {
    return mlw_option_make_some(MLHKEY (return_key));
  }
}

/*
 * This function returns an create_result option value as opposed to the
 * Windows functionality of returning an indication of success or failure
 * datatype create_result = CREATED_NEW_KEY of hkey | OPENED_EXISTING_KEY of hkey
 * datatype options = VOLATILE | NON_VOLATILE
 */

static mlval reg_create_key_ex (mlval arg)
{
  HKEY hkey = CHKEY(FIELD(arg, 0));
  char *subkey = CSTRING(FIELD(arg, 1));
  int options = ((CINT(FIELD(arg, 2))) == 0) ? REG_OPTION_NON_VOLATILE : REG_OPTION_VOLATILE;
  REGSAM security_mask = (REGSAM) convert_sam_values (FIELD (arg, 3));
  HKEY return_key;
  SECURITY_ATTRIBUTES attr = {sizeof(SECURITY_ATTRIBUTES), NULL, TRUE};
  DWORD disposition;
  long result = RegCreateKeyEx(hkey, subkey, 0, NULL, options, security_mask, &attr, &return_key, &disposition);
  if (result == ERROR_SUCCESS) {
    int res_type = MLINT((disposition == REG_CREATED_NEW_KEY) ? 0 : 1);
    mlval create_result;
    mlval res_key = MLHKEY(return_key);
    declare_root(&res_key, 0);
    create_result = allocate_record(2);
    FIELD(create_result, 0) = res_type;
    FIELD(create_result, 1) = res_key;
    retract_root(&res_key);
    return mlw_option_make_some(create_result);
  } else {
    exn_raise_syserr(mlw_win32_strerror(result), (result<<1));
  }
}

/* This function only returns a string value of the key. */
static mlval reg_query_value_ex (mlval arg)
{
  HKEY hkey = CHKEY(FIELD(arg, 0));
  char *valuename = CSTRING(FIELD(arg, 1));
  mlval datas;
  DWORD datasize;
  long result;

  result = RegQueryValueEx(hkey, valuename, NULL, NULL, NULL, &datasize);
  if (result) {
    return ml_string (NULL); }
  else {
    /* datasize here INCLUDES the NULL character at the end of the string */
    datas = allocate_string(datasize);
    result = RegQueryValueEx(hkey, valuename, NULL, NULL,
			     CSTRING(datas), &datasize);
    if (result) {
      return ml_string (NULL);
    } else {
      return datas;
    }
  }
}

/* This function sets an open key to a string value. */
static mlval reg_set_value_ex (mlval arg)
{
  HKEY hkey = CHKEY(FIELD(arg, 0));
  char *valuename = CSTRING(FIELD(arg, 1));
  char *value = CSTRING(FIELD(arg, 2));
  long result = RegSetValueEx(hkey, valuename, 0, REG_SZ, value, strlen(value)+1);
  if (result == ERROR_SUCCESS) {
    return MLUNIT;
  } else {
    exn_raise_syserr(mlw_win32_strerror(result), (result<<1));
  }
}

/* This function deletes a subkey of a key. */
static mlval reg_delete_key (mlval arg)
{
  HKEY hkey = CHKEY(FIELD(arg, 0));
  char *valuename = CSTRING(FIELD(arg, 1));
  long result = RegDeleteKey(hkey, valuename);
  if (result == ERROR_SUCCESS) {
    return MLUNIT;
  } else {
    exn_raise_syserr(mlw_win32_strerror(result), (result<<1));
  }
}

/* ------------------------------------- */

static mlval win32_open(mlval argument)
{
  char const * file_name= CSTRING(FIELD(argument, 0));
  int acc = CINT(FIELD(argument, 1));
  int act = CINT(FIELD(argument,2));
  DWORD access= (acc == 0)
    ? GENERIC_READ
    : (acc == 1)
      ? GENERIC_READ | GENERIC_WRITE
      : GENERIC_WRITE;
  DWORD action = (act == 0) ? CREATE_ALWAYS 
              : ((acc == 1) ? OPEN_ALWAYS 
                            : OPEN_EXISTING);
  DWORD mode = FILE_SHARE_READ|FILE_SHARE_WRITE;
  HANDLE file_handle = CreateFile(file_name, access, mode,
				  NULL, action, FILE_ATTRIBUTE_NORMAL, NULL);

  if (file_handle == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());

  return MLINT(file_handle);
}




/*
 * file_desc -> unit
 * Raises: SysErr
 */
static mlval win32_close(mlval argument)
{
  HANDLE file_handle= (HANDLE)CINT(argument);
  if (CloseHandle(file_handle) == FALSE)
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}




/* the following is dummy --- it is required by pervasive library
 * for compatibility with the unix interface.  Since I don't know
 * how to do non-blocking input on win32, this function is never
 * called. This will change if ever I figure out how to do nonblocking IO
 */
static mlval win32_can_input(mlval ignore)
{
  mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}




static mlval win32_read(mlval argument)
{
  HANDLE file_handle = (HANDLE)(CINT(FIELD(argument, 0)));
  DWORD bytes_to_read = CINT(FIELD(argument, 1));
  DWORD bytes_read;
  char *buffer = alloc((size_t) bytes_to_read, "win32_read"), *s;
  mlval string;
  if (ReadFile(file_handle, buffer, bytes_to_read, &bytes_read, NULL) == TRUE) {
    string = allocate_string((size_t) (bytes_read+1));
    s = CSTRING(string);
    memcpy(s, buffer, (size_t) bytes_read);
    free(buffer);
    s[bytes_read] = '\0';
    return string;
  } else {
    mlw_raise_win32_syserr(GetLastError());
  }
}




static mlval win32_write(mlval argument)
{
  HANDLE file_handle = (HANDLE)(CINT(FIELD(argument, 0)));
  char *buffer = CSTRING(FIELD(argument, 1));
  unsigned int first = CINT(FIELD(argument, 2));
  DWORD bytes_to_write = CINT(FIELD(argument, 3));
  DWORD bytes_written;
  if (WriteFile(file_handle, buffer + first, bytes_to_write, &bytes_written, NULL) == TRUE)
    return MLINT(bytes_written);

  mlw_raise_win32_syserr(GetLastError());
}




/*
 * Win32OS.seek: file_desc * int * seek_direction -> int
 */
static mlval win32_seek(mlval argument)
{
  HANDLE file_handle = (HANDLE)(CINT(FIELD(argument, 0)));
  int meth = CINT(FIELD(argument,2));
  long newPos = CINT(FIELD(argument, 1));
  DWORD moveMethod = (meth == 0) ? FILE_BEGIN :
                                   ((meth == 1) ? FILE_CURRENT : FILE_END);
  DWORD result = SetFilePointer(file_handle, newPos, NULL, moveMethod);
  if (result == 0xffffffff)
    mlw_raise_win32_syserr(GetLastError());
  return MLINT(result);
}



static mlval win32_size(mlval argument)
{
  HANDLE file_handle = (HANDLE)(CINT(argument));
  DWORD size = GetFileSize(file_handle, NULL);
  if (size == 0xffffffff)
    mlw_raise_win32_syserr(GetLastError());

  if (size > ML_MAX_INT)
    exn_raise_syserr(ml_string("File Too Large"), 0);

  return MLINT(size);
}


/*
 * Unlike opendir under Unix, FindFirstFile returns a handle and also
 * the first file found.  Therefore the distream needs to contain the
 * name of the file that was last found so that when readDir is called
 * it returns this and then retrieves the next one.
 *
 * Win32 doesn't have a direct equivalent of rewinddir, so that
 * is implemented by closing the HANDLE and reopening it on the given
 * directory.  To support this, the directory name needs to be stored
 * in the dirstream.
 */

#define mlw_dirstream_make() allocate_record(3)
#define mlw_dirstream_dir_name(ds)   FIELD(ds, 0)
#define mlw_dirstream_dir_handle(ds) FIELD(ds, 1)
#define mlw_dirstream_file_name(ds)  FIELD(ds, 2)



/*
 * OS.FileSys.openDir : string -> dirstream
 */
static mlval mlw_os_file_sys_open_dir(mlval arg)
{
  char dir_name[MAX_PATH];
  WIN32_FIND_DATA file_data;
  HANDLE handle;
  mlval ml_file_name, ml_file_name_ref;
  mlval ml_handle, ml_handle_ref;
  mlval dirstream;

  strcpy(dir_name, CSTRING(arg));
  if (dir_name == "") 
    strcpy(dir_name, "*");
  else
    sprintf(dir_name, "%s\\*", get_long_name(dir_name));

  handle = FindFirstFile(dir_name, &file_data);

  if (handle == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());

  declare_root(&arg, 0);
  ml_file_name= ml_string(file_data.cFileName);
  ml_file_name_ref= mlw_ref_make(ml_file_name);
  declare_root(&ml_file_name_ref, 0);
  ml_handle= box((UINT)handle);
  ml_handle_ref= mlw_ref_make(ml_handle);
  declare_root(&ml_handle_ref, 0);
  dirstream= mlw_dirstream_make();
  mlw_dirstream_dir_name(dirstream)= ml_string (dir_name);
  mlw_dirstream_dir_handle(dirstream)= ml_handle_ref;
  mlw_dirstream_file_name(dirstream)= ml_file_name_ref;
  retract_root (&ml_handle_ref);
  retract_root (&ml_file_name_ref);
  retract_root(&arg);
  return dirstream;
}



/*
 * OS.FileSys.readDir : dirstream -> string option
 */
static mlval mlw_os_file_sys_read_dir(mlval arg)
{
  WIN32_FIND_DATA file_data;
  mlval result;
  HANDLE handle= (HANDLE)unbox(mlw_ref_value(mlw_dirstream_dir_handle(arg)));

  if (handle == INVALID_HANDLE_VALUE)
    exn_raise_syserr(ml_string("OS.FileSys.readDir: attempt to read from closed dirstream"), 0);

  if (!FindNextFile(handle, &file_data)) {
    if (GetLastError() != ERROR_NO_MORE_FILES)
      mlw_raise_win32_syserr(GetLastError());
    return mlw_option_make_none();
  } else {
    mlval ml_file_name;
    declare_root(&arg, 0);
    ml_file_name= ml_string(file_data.cFileName);
    result= mlw_ref_value(mlw_dirstream_file_name(arg));
    declare_root(&result, 0);
    mlw_ref_update(mlw_dirstream_file_name(arg), ml_file_name);
    retract_root(&result);
    retract_root(&arg);
    return mlw_option_make_some(result);
  }
}




/*
 * OS.FileSys.rewindDir : dirstream -> unit
 *
 * Win32 doesn't have a direct equivalent of rewinddir, so the following
 * implements it by closing the dirstream and then reopening it on the
 * original directory.
 */
static mlval mlw_os_file_sys_rewind_dir(mlval arg)
{
  WIN32_FIND_DATA file_data;
  LPCSTR dir_name;
  HANDLE handle= (HANDLE)unbox(mlw_ref_value(mlw_dirstream_dir_handle(arg)));
  mlval boxed_handle;
  mlval ml_file_name;

  if (handle == INVALID_HANDLE_VALUE)
    exn_raise_syserr(ml_string("OS.FileSys.rewindDir: attempt to rewind closed dirstream"), 0);

  if (!FindClose(handle))
    mlw_raise_win32_syserr(GetLastError());

  dir_name= CSTRING(mlw_dirstream_dir_name (arg));
  if ((handle= FindFirstFile(dir_name, &file_data)) == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());

  declare_root(&arg, 0);
  boxed_handle= box((UINT)handle);
  mlw_ref_update(mlw_dirstream_dir_handle(arg), boxed_handle);
  ml_file_name= ml_string(file_data.cFileName);
  mlw_ref_update(mlw_dirstream_file_name(arg), ml_file_name);
  retract_root(&arg);

  return MLUNIT;
}




/*
 * OS.FileSys.closeDir : dirstream -> unit
 */
static mlval mlw_os_file_sys_close_dir(mlval arg)
{
  HANDLE handle= (HANDLE)unbox(mlw_ref_value(mlw_dirstream_dir_handle(arg)));
  mlval boxed_handle;

  if (handle == INVALID_HANDLE_VALUE)
    return MLUNIT;

  if (!FindClose(handle))
    mlw_raise_win32_syserr(GetLastError());

  declare_root(&arg, 0);
  boxed_handle= box((UINT)INVALID_HANDLE_VALUE);
  mlw_ref_update(mlw_dirstream_dir_handle(arg), boxed_handle);
  retract_root(&arg);
  return MLUNIT;
}




/*
 * OS.FileSys.chDir : string -> unit
 */
static mlval mlw_os_file_sys_ch_dir(mlval arg)
{
  char const * new_dir= CSTRING(arg);
  if (!SetCurrentDirectory(new_dir))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}




/*
 * OS.FileSys.getDir : unit -> string
 *
 * If GetCurrentDirectory can locate the current directory, but cannot
 * write it back to the buffer because it is not large enough, it returns
 * the size the buffer needs to be.  The following tries to make use of
 * this information to always return the path if at all possible.
 * Unfortunately, this does tend to make it rather cryptic.
 */
static mlval mlw_os_file_sys_get_dir(mlval unit)
{
  char fixed_buffer[MAX_PATH];
  char * buffer= fixed_buffer;
  DWORD buffer_size= MAX_PATH;
  DWORD size= GetCurrentDirectory(buffer_size, buffer);

  if (size == 0)
    mlw_raise_win32_syserr(GetLastError());

  if (size >= buffer_size) {
    buffer_size= size;
    if ((buffer= malloc(buffer_size)) == 0)
      mlw_raise_c_syserr(errno);
    (void)memcpy(buffer, fixed_buffer, size);
    if ((size= GetCurrentDirectory(buffer_size, buffer)) == 0) {
      free(buffer);
      mlw_raise_win32_syserr(GetLastError());
    }
    assert(size == buffer_size-1);
  }

  {
    mlval path= ml_string(buffer);
    if (buffer != fixed_buffer)
      free(buffer);
    return path;
  }
}




/*
 * OS.FileSys.mkDir: string -> unit
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_mk_dir(mlval arg)
{
  char const * dir_name= CSTRING(arg);
  SECURITY_ATTRIBUTES attributes= {sizeof(SECURITY_ATTRIBUTES), NULL, TRUE};
  if (!CreateDirectory(dir_name, &attributes))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}



/*
 * OS.FileSys.rmDir: string -> unit
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_rm_dir(mlval arg)
{
  char const * dir_name= CSTRING(arg);
  if (!RemoveDirectory(dir_name))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}



/*
 * OS.FileSys.isDir: string -> bool
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_is_dir(mlval arg)
{
  LPCTSTR dir_name= CSTRING(arg);
  DWORD file_attributes= GetFileAttributes(dir_name);
  if (file_attributes == 0xffffffff)
    mlw_raise_win32_syserr(GetLastError());
  return MLBOOL((file_attributes & FILE_ATTRIBUTE_DIRECTORY) == FILE_ATTRIBUTE_DIRECTORY);
}

/* This function faults bad values returned by GetFullPathName */

static void fail_buffer(char *buffer)
{
#define BAD_FILE_NAME "Bad file name from GetFullPathName "
  /* This should never happen (it would be a bug in GetFullPathName) */
  mlval ml_error = MLUNIT;
  char *c_error = malloc(strlen(BAD_FILE_NAME) + strlen(buffer) + 1);
  strcpy(c_error, BAD_FILE_NAME);
  strcat(c_error, buffer);
  ml_error = ml_string(c_error);
  free(c_error);
  free(buffer);
  exn_raise_syserr(ml_error, 0);
}

/* This function checks values returned by GetFullPathName */
static void check_root(char *root, char *buffer)
{
  if (*root == '\0') fail_buffer(buffer);
}

/*
 * OS.FileSys.fullPath: string -> string
 * Raises: OS.SysErr
 *
 * See mlw_os_file_sys_get_dir comment for the reasons why the following is
 * baroque.
 */
static mlval mlw_os_file_sys_full_path(mlval arg)
{
  char const * path= CSTRING(arg);
  char fixed_buffer[MAX_PATH];
  char * buffer= fixed_buffer;
  DWORD buffer_size= MAX_PATH;
  char *final_name;
  DWORD size= GetFullPathName(path, MAX_PATH, buffer, &final_name);

  if (size == 0)
    mlw_raise_win32_syserr(GetLastError());
  if (size >= buffer_size) {
    buffer_size= size;
    if ((buffer= malloc(buffer_size)) == 0)
      mlw_raise_c_syserr(errno);
    (void)memcpy(buffer, fixed_buffer, buffer_size);
    if ((size= GetFullPathName(buffer, buffer_size, buffer, &final_name)) == 0) {
      free(buffer);
      mlw_raise_win32_syserr(GetLastError());
    }
    assert(size == buffer_size - 1);
  }
  /* Now check for and remove a trailing \ (except for root directories) */
  {
    DWORD i = strlen(buffer);
    /* We start by looking for something of the form \\foo\bar\ or a:\ */
    char *root = buffer;
    if (*root == '\\') {
      root++; /* Skip first \ */
      if (*root != '\\') {
	fail_buffer(buffer);
      }
      root++; /* Skip second \ */
      do {
	root++; /* Skip foo section */
      } while (*root != '\\' && *root != '\0');
      check_root(root, buffer);
      root++; /* Skip third \ */
      check_root(root, buffer);
      do {
	root++; /* Skip bar section */
      } while (*root != '\\' && *root != '\0');
      check_root(root, buffer);
      root++; /* Skip fourth \ */
    } else {
      if (strlen(root) < 3 || root[1] != ':' || root[2] != '\\')
	fail_buffer(buffer);
      root += 3;
    }
    if ((root < (buffer + i)) && (buffer[i-1] == '\\'))
      buffer[i-1] = '\0'; /* Remove trailing \ except from file system roor */
  }

  size = strlen(buffer);

  /* Now check that this file exists, and raise syserr if not */
  /* FindFirstFile fails if given the root directory, so don't call it 
   * if the buffer contains the root directory.
   */
  if ((size != 3) || (buffer[2] != '\\')) {
    WIN32_FIND_DATA file_data;
    HANDLE file_handle = FindFirstFile(buffer, &file_data);

    if (file_handle == INVALID_HANDLE_VALUE) {
      if (buffer != fixed_buffer) free(buffer);
      mlw_raise_win32_syserr(GetLastError());
    }
    FindClose(file_handle);
  }

  {
    mlval path= ml_string(buffer);
    if (buffer != fixed_buffer)
      free(buffer);
    return path;
  }
}




/*
 * OS.FileSys.modTime: string -> Time.time
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_mod_time(mlval arg)
{
  char const * file_name= CSTRING(arg);
  WIN32_FIND_DATA file_data;
  HANDLE file_handle= FindFirstFile(file_name, &file_data);  
  mlval mod_time;
  if (file_handle == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());

  mod_time= mlw_time_from_file_time(&file_data.ftLastWriteTime);
  if (FindClose(file_handle) == FALSE) {
    message_start();
    message_content("MLWorks non-fatal error: could not close ");
    message_string(file_name);
    message_end();
  }
  return mod_time;
}




/*
 * OS.FileSys.fileSize: string -> Position.int
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_file_size(mlval arg)
{
  char const * file_name= CSTRING(arg);
  WIN32_FIND_DATA file_data;
  HANDLE file_handle= FindFirstFile(file_name, &file_data);
  mlval file_size;

  if (file_handle == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());

  if (file_data.nFileSizeHigh != 0 || file_data.nFileSizeLow > ML_MAX_INT)
    exn_raise_syserr(ml_string("OS.FileSys.fileSize: file too large"), 0);

  file_size= MLINT(file_data.nFileSizeLow);
  if (FindClose(file_handle) == FALSE) {
    message_start();
    message_content("MLWorks non-fatal error: could not close ");
    message_string(file_name);
    message_end();
  }
  return file_size;
}




/*
 * OS.FileSys.setTime_: string * Time.time -> unit
 * Raises: OS.SysErr
 */
static mlval mlw_os_file_sys_set_time(mlval arg)
{
  LPCTSTR file_name= CSTRING(FIELD(arg, 0));
  SECURITY_ATTRIBUTES security_attributes= {sizeof(SECURITY_ATTRIBUTES), NULL, TRUE};
  FILETIME file_time;
  HANDLE file_handle= CreateFile(file_name, GENERIC_WRITE, 0, &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
  if (file_handle == INVALID_HANDLE_VALUE)
    mlw_raise_win32_syserr(GetLastError());
  mlw_time_to_file_time(FIELD(arg, 1), &file_time);
  if (!SetFileTime(file_handle, NULL, &file_time, &file_time))
    mlw_raise_win32_syserr(GetLastError());
  if (!CloseHandle(file_handle))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}




/*
 * OS.FileSys.remove : string -> unit
 */
static mlval mlw_os_file_sys_remove(mlval arg)
{
  char const *file_name= CSTRING(arg);
  if (!DeleteFile(file_name))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}




/*
 * OS.FileSys.rename : { new: string, old: string} -> unit
 */
static mlval mlw_os_file_sys_rename(mlval arg)
{
  char const *old= CSTRING(FIELD(arg, 1));
  char const *new= CSTRING(FIELD(arg, 0));
  if (!MoveFile(old, new))
    mlw_raise_win32_syserr(GetLastError());
  return MLUNIT;
}



/*
 * OS.FileSys.access : (string * access_mode list) -> bool
 *
 * The description states that :-
 *
 *   ... only raise OS.SysError for errors unrelated to resolving the
 *   pathname and the related permissions, such as being interrupted
 *   by a signal during the the system call.
 *
 * Which seems to leave it to the implementor to decide exactly what
 * are "errors unrelated to resolving the pathname".
 *
 * Note that although Visual C++ compatability library provides access
 * the documentation doesn't list any flag/value to test if a file is
 * executable.  I don't have the time or the inclination to determine
 * if it can really detect executable files using some undocumented flag
 * so I've implemented access using _fstat.
 */
static int
mlw_os_file_sys_access_mode_ml_to_c[]= {_S_IEXEC, _S_IREAD, _S_IWRITE};


#define mlw_os_file_sys_n_access_modes \
  (sizeof(mlw_os_file_sys_access_mode_ml_to_c)/sizeof(mlw_os_file_sys_access_mode_ml_to_c[0]))


static mlval mlw_os_file_sys_access(mlval arg)
{
  char const * path= CSTRING(FIELD(arg, 0));
  mlval modes= FIELD(arg, 1);
  int access_mode= 0;
  int stat_status;
  struct _stat st;

  for (; !MLISNIL(modes); modes= MLTAIL(modes)) {
    int ml_mode= CINT(MLHEAD(modes));
    assert(ml_mode >= 0 && ml_mode <= mlw_os_file_sys_n_access_modes);
    access_mode |= mlw_os_file_sys_access_mode_ml_to_c[ml_mode];
  }
  if ((stat_status= _stat(path, &st)) < 0) {
    switch (errno) {
    case ENOENT:
      return MLFALSE;
    default:
      mlw_raise_c_syserr(errno);
    }
  }
  return MLBOOL((st.st_mode & access_mode) == access_mode);
}




/*
 * OS.FileSys.tmpName : unit -> string
 *
 * See mlw_os_file_sys_get_dir comment for the reasons why the following is
 * broque.
 */
static mlval mlw_os_file_sys_tmp_name(mlval unit)
{
  char fixed_dir[MAX_PATH];
  char * dir= fixed_dir;
  DWORD dir_size= MAX_PATH;
  DWORD size= GetTempPath(dir_size, dir);

  if (size == 0)
    mlw_raise_win32_syserr(GetLastError());

  if (size >= dir_size) {
    if ((dir= malloc(size)) == 0)
      mlw_raise_c_syserr(errno);
    (void)memcpy(dir, fixed_dir, size);
    dir_size= size;
    if ((size= GetTempPath(dir_size, dir)) == 0) {
      free(dir);
      mlw_raise_win32_syserr(GetLastError());
    }
    assert(size == dir_size-1);
  }

  {
    mlval path;
    char * buffer= malloc(size+MAX_PATH); /* could be more accurate */
    if (buffer == 0)
      mlw_raise_c_syserr(errno);
    if (GetTempFileName(dir, "MLW", 1, buffer) != 1) {
      if (dir != fixed_dir);
      free(dir);
      free(buffer);
      mlw_raise_win32_syserr(GetLastError());
    }
    path= ml_string(buffer);
    free(buffer);
    if (dir != fixed_dir)
      free(dir);
    return path;
  }
}




/*
 * OS.Process.exit: word32 -> 'a
 */
static mlval mlw_os_process_exit(mlval exit_code)
{
  exit(unbox(exit_code));
  return MLUNIT;		/* keep dumb compilers happy */
}



/*
 * OS.Process.system: string -> word32
 * Raises: OS.SysErr
 */
static mlval mlw_os_process_system(mlval arg)
{
  char const * command= CSTRING(arg);
  int status= system(command);
  if (status == -1 || status == 127)
    mlw_raise_c_syserr(errno);

  return box(status);
}



/*
 * OS.Process.getenv: string -> string option
 *
 * This is the same as the Unix version and so could probably
 * move to a common file such as rts/src/system.c
 */
static mlval mlw_os_process_getenv(mlval arg)
{
  char const * name= CSTRING(arg);
  char const * value= getenv(name);
  if (value == NULL) {
    return mlw_option_make_none();
  } else {
    return mlw_option_make_some(ml_string(value));
  }
}




/*
 * The following values are C versions of the values defined
 * in the Kind structure in win32/os_io.sml.
 *
 * In an ideal world the SML & C versions would be generated
 * from a common source to avoid possible update problems.
 */
#define mlw_os_io_kind_file    MLINT(1)
#define mlw_os_io_kind_dir     MLINT(2)
#define mlw_os_io_kind_symlink MLINT(3)
#define mlw_os_io_kind_tty     MLINT(4)
#define mlw_os_io_kind_pipe    MLINT(5)
#define mlw_os_io_kind_socket  MLINT(6)
#define mlw_os_io_kind_device  MLINT(7)



/*
 * OS.IO.kind : io_desc -> io_desc_kind
 * Raises: OS.SysErr
 *
 * Much the same as the Unix version, except that Win32 supports less
 * kinds.
 *
 * Could implement this with native Win32 calls such as
 * GetFileType and GetFileInformationByHandle, but this doesn't
 * seem to provide as much information as _fstat (presumably
 * there is some other Win32 call I'm missing which does).
 *
 * Note that this is the only OS.IO routine implemented here.
 * All the poll related routines are implemented in os_io_poll.[ch]
 */

static mlval mlw_os_io_kind(mlval arg)
{
  struct _stat st;
  int io_desc= CINT(arg);

  if (_fstat(io_desc, &st) < 0)
    mlw_raise_c_syserr(errno);

  switch (st.st_mode & _S_IFMT) {
  case _S_IFREG:
    return isatty(io_desc) ? mlw_os_io_kind_tty : mlw_os_io_kind_file;
  case _S_IFDIR:
    return mlw_os_io_kind_dir;
  case _S_IFIFO:
    return mlw_os_io_kind_socket;
  case _S_IFCHR:
    return mlw_os_io_kind_device;
  default:
    exn_raise_syserr(ml_string("OS.IO.kind: unknown io_desc kind"), 0);
  }
}




/*
 * Win32.fdToIOD: file_desc -> io_desc
 *
 * Converts a HANDLE into a Unix style file descriptor
 * for use by the VC++ compatability library routines.
 * The name comes from POSIX.FileSys.fdToIOD.
 *
 * The VC++ manual isn't very clear on if and when these
 * descriptors should be closed (presumably by _close).
 * Currently no attempt is made to close them.
 * But now there is, as not doing so eventually causes
 * fopen to fail. See mlw_win32_close_iod
 */

static mlval mlw_win32_fd_to_io_desc(mlval arg)
{
  HANDLE io_desc= (HANDLE)CINT(arg);
  int fd= _open_osfhandle((long)io_desc, O_RDONLY);

  if (fd < 0) {
    int saved_errno= errno;
    (void)_close(fd);
    mlw_raise_c_syserr(saved_errno);
  }
  return MLINT(fd);
}

/*
 * mlw_win32_close_iod
 * Note that this routine will automatically close the result
 * of CreateFile if the handle was acquired using _open_osfhandle
 * on the result of CreateFile. So under those circumstances,
 * eg in __os_prim_io.sml, if we close an ioDesc, we should then not
 * try to close the fd as this will fail.
 */

static mlval mlw_win32_close_iod(mlval arg)
{
  int fd = CINT(arg);
  (void)_close(fd);
  return MLUNIT;
}


#define ML_BACKGROUND_PRIORITY  0
#define ML_NORMAL_PRIORITY      1
#define ML_HIGH_PRIORITY        2
#define ML_REALTIME_PRIORITY    3


static mlval win32_create_process (mlval arg)
{
   BOOL                 result;
   STARTUPINFO          startup_info;
   PROCESS_INFORMATION  proc_info;
   DWORD                PriorityClass, CreationFlags;

   char *cmd_line;
   long int priority;

   cmd_line = CSTRING(  FIELD(arg,0));
   priority = CINT(     FIELD(arg,1));

   switch (priority) {
   case ML_NORMAL_PRIORITY :
        PriorityClass = NORMAL_PRIORITY_CLASS;
        break;

   case ML_HIGH_PRIORITY :
        PriorityClass = HIGH_PRIORITY_CLASS;
        break;

   case ML_BACKGROUND_PRIORITY :
        PriorityClass = IDLE_PRIORITY_CLASS;
        break;

   case ML_REALTIME_PRIORITY :
        PriorityClass = REALTIME_PRIORITY_CLASS;
        break;

   default :
        PriorityClass = NORMAL_PRIORITY_CLASS;
   }

   GetStartupInfo(&startup_info);   /* Grab current Startup_info for Windows etc. */

   CreationFlags = CREATE_NEW_CONSOLE;
   CreationFlags = CreationFlags | PriorityClass;

   result =
      CreateProcess( (LPCTSTR)NULL,                 /* Module (i.e. command) name */
		     (LPTSTR)cmd_line,              /* Command args */
		     (LPSECURITY_ATTRIBUTES)NULL,   /* Process security */
		     (LPSECURITY_ATTRIBUTES)NULL,   /* Thread  security */
		     FALSE,                         /* Handle inheritance flag */
		     CreationFlags,                 /* Creation flags */
		     (LPVOID)NULL,                  /* Environment */
		     (LPCTSTR)NULL,                 /* Current directory */
		     (LPSTARTUPINFO)&startup_info,        /* Start up info */
		     (LPPROCESS_INFORMATION)&proc_info    /* Process information */
		   );
   /* Now avoid hanging onto the process and main thread handles */
   CloseHandle(proc_info.hThread);
   CloseHandle(proc_info.hProcess);
   return MLBOOL(result != 0);
}

/* Time.time -> Time.time */
static mlval ml_filetimetolocalfiletime(mlval arg)
{
  FILETIME ft, converted;
  mlw_time_to_file_time(arg, &ft);
  if (FileTimeToLocalFileTime(&ft, &converted)) {
    return mlw_time_from_file_time(&converted);
  } else {
    mlw_raise_win32_syserr(GetLastError()); /* Shouldn't happen, indicates bug in MS */
  }
}

/* Time.time -> Time.time */
static mlval ml_localfiletimetofiletime(mlval arg)
{
  FILETIME ft, converted;
  mlw_time_to_file_time(arg, &ft);
  if (LocalFileTimeToFileTime(&ft, &converted)) {
  return mlw_time_from_file_time(&converted);
  } else {
    mlw_raise_win32_syserr(GetLastError()); /* Shouldn't happen, indicates bug in MS */
  }
}

/*
 * string ->
 *    {volumeName: string,
 *     systemName: string,
 *     serialNumber: SysWord.word,
 *     maximumComponentLength: int,
 *     flags: SysWord.word}
 */
static mlval ml_getvolumeinformation(mlval arg)
{
  char volumeName[MAX_PATH+1];
  DWORD serial;
  DWORD component_length;
  DWORD flags;
  char fixed_buffer[MAX_PATH+1];
  BOOL res = GetVolumeInformation(CSTRING(arg), volumeName, MAX_PATH, &serial, &component_length, &flags,
				  fixed_buffer, MAX_PATH);
  if (res == TRUE) {
    mlval volName;
    mlval sysName;
    mlval serNum;
    mlval result;
    volName = ml_string(volumeName);
    declare_root(&volName, 0);
    sysName = ml_string(fixed_buffer);
    declare_root(&sysName, 0);
    serNum = box(serial);
    declare_root(&serNum, 0);
    result = allocate_record(4);
    FIELD(result, 0) = MLINT(component_length);
    FIELD(result, 1) = serNum;
    FIELD(result, 2) = sysName;
    FIELD(result, 3) = volName;
    retract_root(&volName);
    retract_root(&sysName);
    retract_root(&serNum);
    return result;
  } else {
    mlw_raise_win32_syserr(GetLastError());
  }
}

/* string -> string option */
static mlval ml_find_executable(mlval arg)
{
  char *name = CSTRING(arg);
  char fixed_buffer[MAX_PATH+1];
  HINSTANCE handle = FindExecutable(name, NULL, fixed_buffer);
  if ((DWORD)handle < 32) {
    switch((DWORD)handle) {
    case 0:
      exn_raise_syserr(ml_string("System out of resource during Windows.findExecutable"), 0);
    case ERROR_FILE_NOT_FOUND:
      return mlw_option_make_none();
    case ERROR_PATH_NOT_FOUND:
      /* This should only occur when parameter 2 to Findexecutable is not NULL */
      exn_raise_syserr(ml_string("A path was not found during Windows.findExecutable"), 0);
    case ERROR_BAD_FORMAT:
      exn_raise_syserr(format_to_ml_string("file '%s' does not specify a valid Win32 executable", name), 0);
    default: mlw_raise_win32_syserr(GetLastError());
    }
  } else {
    return mlw_option_make_some(ml_string(fixed_buffer));
  }
}

static char *get_args(mlval list, const char *fun)
{
  mlval list1;
  char *args;
  unsigned int len = 0;
  for (list1 = list; list1 != MLNIL; list1 = MLTAIL(list1)) {
    char *head = CSTRING(MLHEAD(list1));
    len += strlen(head) + 1; /* Allow room for a space or a terminator */
  }
  args = malloc(len+1);
  *args = '\0';
  if (args == NULL) {
    exn_raise_syserr(format_to_ml_string("Failed to concatenate args for %s", fun), 0);
  } else {
    for (list1 = list; list1 != MLNIL; list1 = MLTAIL(list1)) {
      char *head = CSTRING(MLHEAD(list1));
      strcat(args, head);
      strcat(args, " ");
    }
    args[strlen(args)] = '\0'; /* Get rid of terminating space */
  }
  return args;
}

/*
 * shell_execute is called by ml_open_document and ml_launch_application.
 * It calls ShellExecute, frees the arguments, and checks the result status.
 */
static void shell_execute (char *name, char* c_args, char* fn)
{
  HINSTANCE handle = ShellExecute(NULL, "open", name, c_args, NULL, SW_NORMAL);
  free(c_args);
  if ((DWORD)handle < 32) {
    switch((DWORD)handle) {
    case SE_ERR_OOM:
    case 0:
      exn_raise_syserr(format_to_ml_string("System out of resource during %s", fn), 0);
#ifdef Win95
    case SE_ERR_FNF:
#else
    case ERROR_FILE_NOT_FOUND:
#endif
      exn_raise_syserr(format_to_ml_string("file '%s' not found", name), 0);
#ifdef Win95
    case SE_ERR_PNF:
#else
    case ERROR_PATH_NOT_FOUND:
#endif
      exn_raise_syserr(format_to_ml_string("A path was not found during %s", fn), 0);
    case ERROR_BAD_FORMAT:
      exn_raise_syserr(format_to_ml_string("file '%s' does not specify a valid Win32 executable", name), 0);
    case SE_ERR_ACCESSDENIED:
      exn_raise_syserr(format_to_ml_string("Access denied to '%s'", name), 0);
    case SE_ERR_ASSOCINCOMPLETE:
      exn_raise_syserr(format_to_ml_string("Association to '%s' incomplete or invalid", name), 0);
    case SE_ERR_DDEBUSY:
      exn_raise_syserr(format_to_ml_string("The DDE transaction could not be completed because other DDE transactions were being processed during %s", fn), 0);
    case SE_ERR_DDEFAIL:
      exn_raise_syserr(format_to_ml_string("DDE transaction failed during %s", fn), 0);
    case SE_ERR_DDETIMEOUT:
      exn_raise_syserr(format_to_ml_string("The DDE transaction request timed out during %s", fn), 0);
    case SE_ERR_DLLNOTFOUND:
      exn_raise_syserr(ml_string("DLL not found"), 0);
    case SE_ERR_NOASSOC:
      exn_raise_syserr(format_to_ml_string("No application associated with the given filename extension in '%s'", name), 0);
    case SE_ERR_SHARE:
      exn_raise_syserr(format_to_ml_string("A sharing violation occurred during %s of '%s'", fn, name), 0);
    default: mlw_raise_win32_syserr(GetLastError());
    }
  }
}

static mlval ml_launch_application(mlval arg)
{
  char *name = CSTRING(FIELD(arg, 0));
  mlval args = FIELD(arg, 1);
  char *c_args = get_args(args, "Windows.shellExecute");
  shell_execute (name, c_args, "Windows.launchApplication");
  return MLUNIT;
}

static mlval ml_open_document(mlval arg)
{
  char *name = CSTRING(arg);
  shell_execute (name, NULL, "Windows.openDocument");
  return MLUNIT;
}


static BOOL CALLBACK find_child_console(HWND hwnd, DWORD pid)
{
  DWORD thread_id;
  DWORD process_id;

  thread_id = GetWindowThreadProcessId (hwnd, &process_id);
  if (thread_id) {
    if (process_id == pid) {
      char window_class[32];
      GetClassName (hwnd, window_class, sizeof (window_class));
      if (strcmp(window_class, "tty") == 0 ||
	  strcmp(window_class, "ConsoleWindowClass") == 0) {
	return FALSE;
      }
    }
  }
  /* keep looking */
  return TRUE;
}

static mlval ml_has_console(mlval arg)
{
  HANDLE console_handle =
    CreateFile("CONOUT$",
	       GENERIC_READ | GENERIC_WRITE,
	       FILE_SHARE_READ | FILE_SHARE_WRITE,
	       NULL,
	       OPEN_EXISTING,
	       0,
	       NULL);
  if (console_handle == INVALID_HANDLE_VALUE) {
    mlw_raise_win32_syserr(GetLastError());
  } else {
    if (EnumWindows(find_child_console, (LPARAM)GetCurrentProcessId()) == TRUE) {
      return MLFALSE;
    } else {
      return MLTRUE;
    }
  }
}

#define BUFSIZE 4096

/* XXX: The error cases in ml_execute don't close the duplicated handles.
 * Is this a problem?  -- daveb, 26/1/99.
 */
static mlval ml_execute(mlval arg)
{
  HANDLE hChildStdinRd, hChildStdinWr, hChildStdinWrDup,
    hChildStdoutRd, hChildStdoutWr, hChildStdoutRdDup,
    hSaveStdin, hSaveStdout;
  PROCESS_INFORMATION piProcInfo;
  STARTUPINFO siStartInfo;
  mlval name = FIELD(arg, 0);
  mlval args = FIELD(arg, 1);
  char *c_args = get_args(mlw_cons(name, args), "Windows.execute");
  SECURITY_ATTRIBUTES saAttr;
  BOOL fSuccess;
  LPVOID env;
  BOOL created_console;
  
  /* Set the bInheritHandle flag so pipe handles are inherited. */
  saAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
  saAttr.bInheritHandle = TRUE;
  saAttr.lpSecurityDescriptor = NULL;

  /* First we allocate a console, if we don't have one already */
  created_console = AllocConsole();
 
  hSaveStdout = GetStdHandle(STD_OUTPUT_HANDLE);
  if (!CreatePipe(&hChildStdoutRd, &hChildStdoutWr, &saAttr, 0))
    exn_raise_syserr(ml_string("Stdout pipe creation failed in Windows.execute"), 0);
  if (!SetStdHandle(STD_OUTPUT_HANDLE, hChildStdoutWr)) {
    CloseHandle(hChildStdoutRd);  /* Get rid of the pipe */
    CloseHandle(hChildStdoutWr);
    exn_raise_syserr(ml_string("Redirecting stdOut failed in Windows.execute"), 0);
  }
  fSuccess = DuplicateHandle(GetCurrentProcess(), hChildStdoutRd,
			     GetCurrentProcess(), &hChildStdoutRdDup , 0,
			     FALSE,
			     DUPLICATE_SAME_ACCESS);
  if( !fSuccess ) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    CloseHandle(hChildStdoutRd);  /* Get rid of the pipe */
    CloseHandle(hChildStdoutWr);
    exn_raise_syserr(ml_string("DuplicateHandle failed on stdOut in Windows.execute"), 0);
  }
  CloseHandle(hChildStdoutRd);

  hSaveStdin = GetStdHandle(STD_INPUT_HANDLE);
  if (! CreatePipe(&hChildStdinRd, &hChildStdinWr, &saAttr, 0)) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    CloseHandle(hChildStdoutWr); /* Get rid of the pipe */
    exn_raise_syserr(ml_string("Stdin pipe creation failed in Windows.execute"), 0);
  }
  if (! SetStdHandle(STD_INPUT_HANDLE, hChildStdinRd)) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    CloseHandle(hChildStdoutWr); /* Get rid of the pipes */
    CloseHandle(hChildStdinRd);
    CloseHandle(hChildStdinWr);
    exn_raise_syserr(ml_string("Redirecting StdIn failed in Windows.execute"), 0);
  }
  fSuccess = DuplicateHandle(GetCurrentProcess(), hChildStdinWr,
			     GetCurrentProcess(), &hChildStdinWrDup, 0,
			     FALSE,                  // not inherited
			     DUPLICATE_SAME_ACCESS);
  if (! fSuccess) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    CloseHandle(hChildStdoutWr); /* Get rid of the pipes */
    CloseHandle(hChildStdinRd);
    CloseHandle(hChildStdinWr);
    exn_raise_syserr(ml_string("DuplicateHandle failed on stdIn in Windows.execute"), 0);
  }
  CloseHandle(hChildStdinWr);

  ZeroMemory(&siStartInfo, sizeof(STARTUPINFO));
  siStartInfo.cb = sizeof(STARTUPINFO);
  env = GetEnvironmentStrings();
  if (CreateProcess(NULL, c_args, NULL, NULL, TRUE, 0, env, NULL, &siStartInfo, &piProcInfo) == FALSE) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    SetStdHandle(STD_INPUT_HANDLE, hSaveStdin);   /* Restore original stdIn */
    CloseHandle(hChildStdoutWr); /* Get rid of the pipes */
    CloseHandle(hChildStdinRd);
    (void)FreeEnvironmentStrings(env);
    mlw_raise_win32_syserr(GetLastError());
  }
  (void)FreeEnvironmentStrings(env);
  CloseHandle(piProcInfo.hThread); /* We don't need this, so we close it straight away */
  SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
  SetStdHandle(STD_INPUT_HANDLE, hSaveStdin);   /* Restore original stdIn */
  CloseHandle(hChildStdoutWr); /* Get rid of the pipes */
  CloseHandle(hChildStdinRd);

  /* Here we need to create something to hold the stdOut and stdIn so we can return them to ML */
  /* We also need the process handle so we can reap */
  {
    mlval streams = allocate_record(2);
    mlval proc;
    FIELD(streams, 0) = MLINT(hChildStdoutRdDup);
    FIELD(streams, 1) = MLINT(hChildStdinWrDup);
    declare_root(&streams, 0);
    proc = allocate_record(2);
    FIELD(proc, 0) = streams;
    FIELD(proc, 1) = MLINT(piProcInfo.hProcess);
    retract_root(&streams);
    if (created_console)
      FreeConsole ();
    return proc;
  }
}

static mlval ml_execute_null_streams(mlval arg)
{
  HANDLE hNullDevice, hSaveStdin, hSaveStdout, hSaveStderr;
  PROCESS_INFORMATION piProcInfo;
  STARTUPINFO siStartInfo;
  mlval name = FIELD(arg, 0);
  mlval args = FIELD(arg, 1);
  char *c_args = get_args(mlw_cons(name, args), "Windows.simpleExecute");
  SECURITY_ATTRIBUTES saAttr;
  /*  BOOL fSuccess;  */
  LPVOID env;

  /* Set the bInheritHandle flag so pipe handles are inherited. */
  saAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
  saAttr.bInheritHandle = TRUE;
  saAttr.lpSecurityDescriptor = NULL;

  hNullDevice = CreateFile("NUL:", GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE,
				   NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
  if (hNullDevice == INVALID_HANDLE_VALUE)
    exn_raise_syserr(ml_string("Failed to open null device in Windows.simpleExecute"), 0);

  hSaveStdout = GetStdHandle(STD_OUTPUT_HANDLE);
  if (!SetStdHandle(STD_OUTPUT_HANDLE, hNullDevice)) {
    CloseHandle(hNullDevice);
    exn_raise_syserr(ml_string("Redirecting STDOUT failed in Windows.simpleExecute"), 0);
  }

  hSaveStdin = GetStdHandle(STD_INPUT_HANDLE);
  if (! SetStdHandle(STD_INPUT_HANDLE, hNullDevice)) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    CloseHandle(hNullDevice);
    exn_raise_syserr(ml_string("Redirecting Stdin failed in Windows.simpleExecute"), 0);
  }

  hSaveStderr = GetStdHandle(STD_ERROR_HANDLE);
  if (! SetStdHandle(STD_ERROR_HANDLE, hNullDevice)) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    SetStdHandle(STD_INPUT_HANDLE, hSaveStdin); /* Restore original stdin */
    CloseHandle(hNullDevice);
    exn_raise_syserr(ml_string("Redirecting Stderr failed in Windows.simpleExecute"), 0);
  }

  ZeroMemory(&siStartInfo, sizeof(STARTUPINFO));
  siStartInfo.cb = sizeof(STARTUPINFO);
  env = GetEnvironmentStrings();
  if (CreateProcess(NULL, c_args, NULL, NULL, TRUE, 0, env, NULL, &siStartInfo, &piProcInfo) == FALSE) {
    SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
    SetStdHandle(STD_INPUT_HANDLE, hSaveStdin);   /* Restore original stdIn */
    SetStdHandle(STD_ERROR_HANDLE, hSaveStderr);   /* Restore original stdErr */
    CloseHandle(hNullDevice);
    (void)FreeEnvironmentStrings(env);
    mlw_raise_win32_syserr(GetLastError());
  }

  (void)FreeEnvironmentStrings(env);
  CloseHandle(piProcInfo.hThread); /* We don't need this, so we close it straight away */
  SetStdHandle(STD_OUTPUT_HANDLE, hSaveStdout); /* Restore original stdOut */
  SetStdHandle(STD_INPUT_HANDLE, hSaveStdin);   /* Restore original stdIn */
  SetStdHandle(STD_ERROR_HANDLE, hSaveStderr);   /* Restore original stdErr */
  CloseHandle(hNullDevice);

  /* Here we need to create dummy stdIn/stdOut values so we can return them to ML */
  /* We also need the process handle so we can reap */
  {
    mlval streams = allocate_record(2);
    mlval proc;
    FIELD(streams, 0) = MLINT(0);
    FIELD(streams, 1) = MLINT(0);
    declare_root(&streams, 0);
    proc = allocate_record(2);
    FIELD(proc, 0) = streams;
    FIELD(proc, 1) = MLINT(piProcInfo.hProcess);
    retract_root(&streams);
    return proc;
  }
}


/*
 * NB, we probably need to do something about these streams
 * when we stop and restart, as they will no longer be valid
 * Turns out the basis does this for us
 */

static mlval ml_streams_of(mlval arg)
{
  return (FIELD(arg, 0)); /* The arg is a pair of the streams and the process handle */
}


/*
 * reap a windows function, ie wait for it to die and return its status
 */

static mlval ml_reap(mlval arg)
{
  HANDLE hProcess = (HANDLE)(CINT(FIELD(arg, 1)));
  mlval streams = FIELD(arg, 0);
  HANDLE out = (HANDLE)(CINT(FIELD(streams, 0)));
  HANDLE in = (HANDLE)(CINT(FIELD(streams, 1)));
  DWORD status;
  DWORD res = WaitForSingleObject(hProcess, INFINITE);

  switch(res) {
  case WAIT_OBJECT_0:
    if (GetExitCodeProcess(hProcess, &status)) {
      /* Close our resources */
      CloseHandle(hProcess);
      CloseHandle(in);
      CloseHandle(out);
      return box(status);
    };
    /* Fall through */
  case WAIT_FAILED:
  default:
    {
      /* Failed */
      int error = GetLastError();
      mlw_raise_win32_syserr(error);
    }
  }
}


/* === Handle uniqueness of DLLs and SOs
 *
 * During DLL init we set up a table
 * chained through the dlls, each element of which
 * conforms to the following struct
 * struct info {
 * unsigned long stamp1, stamp2, stamp3, stamp4; A GUID
 * unsigned long *text_start,
 *               *data_start,
 *               *text_end,
 *               *data_end; The text and data bounds of this dll
 * struct info *next; A pointer to the next element, or NULL(0)
 * char          name[]; A name by which this can be identified
 * }
 *
 * At environment init we translate this table
 * into a global root with the following semantics
 * At save:    Save the table away in the image
 * At deliver: Save the table away in the image (unclear what to do here)
 * At reload:  Compare the table from the image with the one we have
 *             and error exit if different in the stamps
 *             If different in the addresses, fix up the heap
 */

typedef struct dll_info *dll_info_ptr;

typedef struct dll_info
{
  word stamp1, stamp2, stamp3, stamp4;
  word text_start, data_start, text_end, data_end;
  dll_info_ptr next;
  char name; /* Really an inline string */
} dll_info;

static mlval shared_object_info = MLNIL;

static void fix(mlval *what, dll_info_ptr old, dll_info_ptr new)
{
  mlval value = *what;
  if (MLVALISPTR(value)) {
    word addr = (word)value;
    while (old != NULL) {
      word text_start = old->text_start;
      word text_end = old->text_end;
      word data_start = old->data_start;
      word data_end = old->data_end;
      word new_text_start = new->text_start;
      word new_data_start = new->data_start;
      /*
      printf("fix 0x%p(0x%x)\n", what, value);
      */
      if (addr >= text_start && addr < text_end) {
	*what = (mlval)(addr + new_text_start - text_start);
	/*
	if (value != *what)
	  printf("fix 0x%p(0x%x) to 0x%x\n", what, value, *what);
	  */
	break;
      } else if (addr >= data_start && addr < data_end) {
	*what = (mlval)(addr + new_data_start - data_start);
	/*
	if (value != *what)
	  printf("fix 0x%p(0x%x) to 0x%x\n", what, value, *what);
	  */
	break;
      }
      old = old->next;
      new = new->next;
    }
  } else {
    return;
  }
}

static void scan(mlval *start, mlval *end, dll_info_ptr old, dll_info_ptr new)
{
  while(start < end) {
    mlval value = *start;
    
    switch(PRIMARY(value)) {
      case INTEGER0:
      case INTEGER1:
      case PRIMARY6:
      case PRIMARY7:
      ++start;
      break;
      
      case HEADER:
      switch(SECONDARY(value)) {
	case STRING:
	case BYTEARRAY:
	start = (mlval *)double_align((byte *)(start+1) + LENGTH(value));
	continue;

	case CODE:
	fix(start+1, old, new);
	cache_flush((void*)(start+2), (LENGTH(value)+1) * sizeof(mlval));
	start += LENGTH(value)+1;
	continue;
	
	case ARRAY:
	case WEAKARRAY:
	{
	  union ml_array_header *array = (union ml_array_header *)start;
	  /* No need to deal with forward or backward pointers */
	  /* As these can't go through the dll area */
	  start = &array->the.element[0];
	}
	break;
	
	default:
	++start;
      }
      break;
      
      default:
      fix(start, old, new);
      ++start;
    }
  }
}

static void display_bounds(dll_info_ptr old, dll_info_ptr new)
{
  while (old != NULL) {
    printf("DLL %s has bounds 0x%x - 0x%x (text), 0x%x - 0x%x (data) moved to 0x%x - 0x%x, 0x%x - 0x%x\n",
	   &old->name, old->text_start, old->text_end, old->data_start, old->data_end,
	   new->text_start, new->text_end, new->data_start, new->data_end);
    old = old->next;
    new = new->next;
  }
}

static void fix_heap(dll_info_ptr old, dll_info_ptr new)
{
  struct ml_heap *gen;
  /*
  display_bounds(old, new);
  */
  /* Modelled on the relevant part of image_load_common from <URI://MLWrts/src/image.c> */
  for(gen = creation; gen != NULL; gen = gen->parent) {
    struct ml_static_object *stat = gen->statics.forward;
    /* No need to look at entry lists, as we have no static reference objects */
    /* Fix the static object chain */
    while(stat != &gen->statics) {
      mlval header = stat->object[0];
      mlval secondary = SECONDARY(header);
      mlval length = LENGTH(header);
      size_t size = OBJECT_SIZE(secondary,length);
      mlval *base = &stat->object[0];
      mlval *top = (mlval*) ((byte*)base + size);

      stat->gen = gen;
      scan(base, top, old, new);

      stat = stat->forward;
    }
    /* Now do the rest of the normal heap */
    scan(gen->start, gen->top, old, new);
  }
}

void put_nibble(unsigned char x)
{
  char s[2];
  s[1] = '\0';
  s[0] = (x < 10) ? '0' + x : 'a' + x - 10;
  fputs(s, stdout);
}

/*
void put_byte(unsigned char x)
{
  put_nibble((x >> 4) & 0xf);
  put_nibble(x & 0xf);
}

void put_short(unsigned short x)
{
  put_byte((x >> 8) & 0xff);
  put_byte(x & 0xff);
}

void put_long(unsigned long x)
{
  put_short((unsigned short)((x >> 16) & 0xffff));
  put_short((unsigned short)(x & 0xffff));
}
*/

static unsigned long *time_stamps = NULL;

int dll_validate(void *addr)
{
  dll_info_ptr ptr = (dll_info_ptr)time_stamps;
  while (ptr != NULL) {
    word text_start = ptr->text_start;
    word text_end = ptr->text_end;
    word data_start = ptr->data_start;
    word data_end = ptr->data_end;
    if ((word)addr >= text_start && (word)addr < text_end) {
      return 1;
    } else if ((word)addr >= data_start && (word)addr < data_end) {
      return 1;
    }
    ptr = ptr->next;
  }
  return 0;
}

void register_time_stamp(unsigned long *addr)
{
  /*
  fputs("stamp found address: ", stdout);
  put_long((unsigned long)addr);
  fputs("\nvalue: ", stdout);
  put_long(addr[0]);
  fputs(", ", stdout);
  put_long(addr[1]);
  fputs(", ", stdout);
  put_long(addr[2]);
  fputs(", ", stdout);
  put_long(addr[3]);
  fputs(", ", stdout);
  put_long(addr[4]);
  fputs(", ", stdout);
  put_long(addr[5]);
  fputs(", ", stdout);
  put_long(addr[6]);
  fputs(", ", stdout);
  put_long(addr[7]);
  fputs("\n", stdout);
  */
  /* Now save them away */
  if (time_stamps == NULL) {
    time_stamps = addr;
  } else {
    unsigned long *stamps = time_stamps;
    while (stamps[8] != 0) {
      /*
      fputs("Following stamp at ", stdout);
      put_long((unsigned long)stamps);
      fputs(" to ", stdout);
      put_long(stamps[8]);
      fputs("\n", stdout);
      */
      stamps = (unsigned long *)(stamps[8]);
    }
    stamps[8] = (unsigned long)addr;
  }
}

static dll_info_ptr make_image_stamps(mlval list)
{
  mlval head;
  if (list != MLNIL) {
    dll_info_ptr tail = make_image_stamps(MLTAIL(list));
    dll_info_ptr result = malloc(sizeof(struct dll_info));
    if (result == NULL) {
      error_without_alloc("failed to allocate dll_info structure when fixing dll relocation");
    };
    result->next = tail;
    head = MLHEAD(list);
    result->stamp1 = word32_to_num(FIELD(head, 0));
    result->stamp2 = word32_to_num(FIELD(head, 1));
    result->stamp3 = word32_to_num(FIELD(head, 2));
    result->stamp4 = word32_to_num(FIELD(head, 3));
    result->text_start = word32_to_num(FIELD(head, 4));
    result->data_start = word32_to_num(FIELD(head, 5));
    result->text_end = word32_to_num(FIELD(head, 6));
    result->data_end = word32_to_num(FIELD(head, 7));
    /* Don't both with the name as we won't be accessing it */
    return result;
  } else {
    return NULL;
  }
}

static mlval initialise_shared_object_info(unsigned long *stamps)
{
  if (stamps == NULL) {
    return MLNIL;
  } else {
    mlval name = MLUNIT;
    mlval record = MLUNIT;
    mlval word32 = MLUNIT;
    mlval temp = MLUNIT;
    mlval result = initialise_shared_object_info((unsigned long *)(stamps[8]));
    /* Get result from tail of list first */
    int i;
    declare_root(&name, 0);
    declare_root(&record, 0);
    declare_root(&temp, 0);
    declare_root(&result, 0);
    temp = allocate_array(8);
    /* We need an array because we're going to allocate and update */
    for (i=0; i<8; ++i) {
      MLUPDATE(temp, i, MLUNIT);
    }
    name = ml_string((char *)(stamps+9));
    for (i = 0; i< 8; ++i) {
      word32 = allocate_word32();
      num_to_word32(stamps[i], word32);
      MLUPDATE(temp, i, word32);
      /* Copy in unique stamp plus memory limits */
    }
    record = allocate_record(9);
    FIELD(record, 8) = name;
    for (i = 0; i< 8; ++i) {
      FIELD(record, i) = MLSUB(temp, i);
      /* Put this stuff in the right place */
    }
    result = mlw_cons(record, result);
    retract_root(&name);
    retract_root(&record);
    retract_root(&temp);
    retract_root(&result);
    return result;
  }
}

static void check_loaded_shared_object_info(const char *name, mlval *root, mlval value)
{
  /* We're given the global name, the heap image root and the value for this name */
  mlval head;
  mlval list = value;
  int i;
  char *image_name;
  unsigned long *stamps = time_stamps;
  dll_info_ptr image_stamps;
  /*
  printf("Check_Loaded_Shared_Object_Info of %s\n", name);
  */
  while (list != MLNIL) {
    head = MLHEAD(list);
    image_name = CSTRING(FIELD(head, 8));
    if (stamps == NULL) {
      error("DLL %s found in image but not loaded\n", image_name);
    }
    if (strcmp(image_name, (char *)(stamps+9)) != 0) {
      error("DLL %s found in image but %s loaded\n", image_name, (char *)(stamps+9));
    }
    for (i = 0; i < 4; ++i) {
      if (stamps[i] != word32_to_num(FIELD(head, i))) {
	error("Consistency failure for DLL %s\n", image_name);
      }
    }
    /*
    printf("DLL %s found\n", CSTRING(FIELD(head, 8)));
    */
    list = MLTAIL(list);
    stamps = (unsigned long *)(stamps[8]);
  }
  image_stamps = make_image_stamps(value);
  fix_heap(image_stamps, (dll_info_ptr)time_stamps);
  *root = initialise_shared_object_info(time_stamps);
  /* Reinitialise as image loading will have wiped this */
  return;
}

extern int system_validate_ml_address(void *addr)
{
  return dll_validate(addr);
  return 0;
  /* Temporary implementation until shared objects done */
}

void win32_init(void)
{

  /* first: set up the standard IO.  On win32, these have to be
   * fixed every time an image is loaded, otherwise we'll attempt
   * to IO via handles declared in the compiler.
   * note that we declare references to the handle, so that
   * the win32 and unix interfaces to the pervasive library are
   * uniform with minimal fuss.
   */

  win32_std_in = mlw_ref_make(MLINT(GetStdHandle(STD_INPUT_HANDLE)));
  declare_global("pervasive win32 std in", &win32_std_in,
		 GLOBAL_DEFAULT, NULL, fix_win32_std_io, NULL);
  env_value("system io standard input",win32_std_in);

  win32_std_out = mlw_ref_make(MLINT(GetStdHandle(STD_OUTPUT_HANDLE)));
  declare_global("pervasive win32 std out", &win32_std_out,
		 GLOBAL_DEFAULT, NULL, fix_win32_std_io, NULL);
  env_value("system io standard output",win32_std_out);

  win32_std_err = mlw_ref_make(MLINT(GetStdHandle(STD_ERROR_HANDLE)));
  declare_global("pervasive win32 std err", &win32_std_err,
		 GLOBAL_DEFAULT, NULL, fix_win32_std_io, NULL);
  env_value("system io standard error", win32_std_err);



  ml_hkey_classes_root = MLHKEY (HKEY_CLASSES_ROOT);
  declare_global("nt reg hkey classes root", &ml_hkey_classes_root,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("nt reg hkey classes root", ml_hkey_classes_root);

  ml_hkey_current_user = MLHKEY (HKEY_CURRENT_USER);
  declare_global("nt reg hkey current user", &ml_hkey_current_user,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("nt reg hkey current user", ml_hkey_current_user);

  ml_hkey_local_machine = MLHKEY (HKEY_LOCAL_MACHINE);
  declare_global("nt reg hkey local machine", &ml_hkey_local_machine,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("nt reg hkey local machine", ml_hkey_local_machine);

  ml_hkey_users = MLHKEY (HKEY_USERS);
  declare_global("nt reg hkey users", &ml_hkey_users,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  env_value("nt reg hkey users", ml_hkey_users);


  env_function("system os win32 open", win32_open);
  env_function("system os win32 size", win32_size);

  env_function("system io close", win32_close);
  env_function("system io write", win32_write);
  env_function("system io read", win32_read);
  env_function("system io seek", win32_seek);
  env_function("system io can input", win32_can_input);

  env_function("OS.errorMsg",  mlw_os_error_msg);
  env_function("OS.errorName", mlw_os_error_name);
  env_function("OS.syserror",  mlw_os_syserror);

  env_function("OS.FileSys.openDir",   mlw_os_file_sys_open_dir);
  env_function("OS.FileSys.readDir",   mlw_os_file_sys_read_dir);
  env_function("OS.FileSys.rewindDir", mlw_os_file_sys_rewind_dir);
  env_function("OS.FileSys.closeDir",  mlw_os_file_sys_close_dir);
  env_function("OS.FileSys.chDir",     mlw_os_file_sys_ch_dir);
  env_function("OS.FileSys.getDir",    mlw_os_file_sys_get_dir);
  env_function("OS.FileSys.mkDir",     mlw_os_file_sys_mk_dir);
  env_function("OS.FileSys.isDir",     mlw_os_file_sys_is_dir);
  env_function("OS.FileSys.rmDir",     mlw_os_file_sys_rm_dir);
  env_function("OS.FileSys.fullPath",  mlw_os_file_sys_full_path);
  env_function("OS.FileSys.modTime",   mlw_os_file_sys_mod_time);
  env_function("OS.FileSys.fileSize",  mlw_os_file_sys_file_size);
  env_function("OS.FileSys.setTime_",  mlw_os_file_sys_set_time);
  env_function("OS.FileSys.remove",    mlw_os_file_sys_remove);
  env_function("OS.FileSys.rename",    mlw_os_file_sys_rename);
  env_function("OS.FileSys.access",    mlw_os_file_sys_access);
  env_function("OS.FileSys.tmpName",   mlw_os_file_sys_tmp_name);

  env_function("OS.IO.kind", mlw_os_io_kind);

  env_function("Win32.fdToIOD", mlw_win32_fd_to_io_desc);
  env_function("Win32.closeIOD", mlw_win32_close_iod);

  env_function("system os exit",   mlw_os_process_exit);
  env_function("system os system", mlw_os_process_system);
  env_function("system os getenv", mlw_os_process_getenv);

  env_function("system os win32 create_process", win32_create_process);

  /* Registry stuff */
  env_function("nt reg close key", reg_close_key);
  env_function("nt reg create key ex", reg_create_key_ex);
  env_function("nt reg open key ex", reg_open_key_ex);
  env_function("nt reg query value ex", reg_query_value_ex);
  env_function("nt reg set value ex", reg_set_value_ex);
  env_function("nt reg delete key", reg_delete_key);

  /* File system */
  env_function("Windows.fileTimeToLocalFileTime", ml_filetimetolocalfiletime);
  env_function("Windows.localFileTimeToFileTime", ml_localfiletimetofiletime);
  env_function("Windows.getVolumeInformation", ml_getvolumeinformation);

  /* Processes */
  env_function("Windows.findExecutable", ml_find_executable);
  env_function("Windows.openDocument", ml_open_document);
  env_function("Windows.launchApplication", ml_launch_application);
  env_function("Windows.hasOwnConsole", ml_has_console);
  env_function("Windows.execute", ml_execute);
  env_function("Windows.executeNullStreams", ml_execute_null_streams);
  env_function("Windows.streamsOf", ml_streams_of);
  env_function("Windows.reap", ml_reap);

  /* DLL/SO initialisation */
  declare_global("shared_object_info", &shared_object_info, GLOBAL_DEFAULT,
		 NULL, check_loaded_shared_object_info, NULL);
  shared_object_info = initialise_shared_object_info(time_stamps);
}
