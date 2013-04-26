/* Copyright (C) 1996 Harlequin Ltd
 *
 * An interface to exporting functions (unix version).
 *
 * $Log: export.c,v $
 * Revision 1.10  1998/06/09 15:11:00  mitchell
 * [Bug #30419]
 * Move free edition check to rts:src:system.c
 *
 * Revision 1.9  1998/05/12  10:26:20  johnh
 * [Bug #30303]
 * Disable image saving on student edition.
 *
 * Revision 1.8  1998/02/23  18:45:43  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.7  1997/11/26  12:08:21  johnh
 * [Bug #30134]
 * Change deliverFn - can no longer save an image.
 *
 * Revision 1.6  1996/09/25  09:35:06  stephenb
 * Factored deliverFn into three new functions: child_process,
 * parent_process and report_fork_failure.  Added a block comment to
 * each one explaining what it does.  Also added some assertions
 * and more explanation in the waitpid section.
 *
 * Revision 1.5  1996/09/24  14:32:47  stephenb
 * [Bug #1612]
 * Altered the waitpid loop so that notice is taken of the
 * return value of waitpid so that it can be restarted if
 * it is interrupted.
 *
 * Revision 1.4  1996/08/06  10:46:56  jont
 * [Bug #1513]
 * Prevent messages coming out in the podium from the child process during deliver
 *
 * Revision 1.3  1996/08/05  13:20:27  jont
 * [Bug #1528]
 * Fixing problems when open fails delivering executables
 *
 * Revision 1.2  1996/05/01  08:53:11  nickb
 * Change arguments of deliverFn.
 *
 * Revision 1.1  1996/02/20  10:19:27  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/unix_export.c
 *
 * Revision 1.4  1996/02/19  17:12:13  nickb
 * Get rid of ad-hoc root clearing.
 *
 * Revision 1.3  1996/02/16  12:33:05  nickb
 * Change to global_pack().
 *
 * Revision 1.2  1996/02/14  15:16:02  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.1  1996/02/08  17:34:26  jont
 * new unit
 *
 *
 */

#include "syscalls.h"
#include <sys/types.h>
#include <errno.h>		/* errno, EINTR, EAGAIN, ... */
#include <sys/wait.h>		/* WIFERXITED, ... */
#include <unistd.h>
#include <assert.h>		/* assert */

#include "diagnostic.h"
#include "gc.h"
#include "exceptions.h"
#include "main.h"
#include "global.h"
#include "allocator.h"
#include "image.h"
#include "export.h"
#include "exec_delivery.h"
#include "utils.h"
#include "license.h"
#include "mlw_mklic.h"


/* The child process is in charge of saving the image/executable to disk.
 *
 * The argument is of the form: string * (unit -> unit) * bool
 * where the string is the name of the output file, the boolean controls
 * whether an executable (MLTRUE) or image (MLFALSE) is saved and 
 * the unit function is the function to call when the image/executable
 * is executed.
 * 
 * The child process exits with 0 if all is well, a results indicates
 * some known error and -1 indicates that something wacky has gone on.
 */
static void child_process(mlval argument)
{
  mlval global;
  mlval filename= FIELD(argument, 0);
  image_continuation= FIELD(argument, 1); /* global, and hence a root */
  
  messager_function= NULL;
  message_flusher= NULL; /* Prevent any messages going to the podium from the child */
  declare_root(&filename, 1);
  
  global= global_pack(1);	/* 1 = delivery */
  declare_root(&global, 1);

  gc_clean_image(global);
  
  DIAGNOSTIC(1,"save_executable being called",0,0);
  if (save_executable(CSTRING(filename), global, APP_CURRENT) == MLERROR) {
    DIAGNOSTIC(1,"save_executable failed, exiting with errno %d",errno,0);
    exit(errno ? errno : -1);
  } else {
    DIAGNOSTIC(1,"save_executable succeeded, exiting with errno %d",errno,0);
  }
  
  exit(0);
}



/* All this does is wait for the child process to complete and raise
 * an appropriate exception if there is an error.  If all goes well
 * it currently just returns MLUNIT otherwise it will raise an exception.
 *
 * wait.signal: waitpid has been interrupted by a signal, so try it again.
 *   Note that this should not happen under SunOS, since it 
 *   automatically restarts system calls but the redundancy
 *   doesn't hurt.
 *
 * wait.other: the status could be true for WIFSTOPPED (and perhaps other OS
 *   specific tests).  Not entirely sure what to do in these cases, 
 *   so for now just output a diagnostic and try waiting again.
 */
static mlval parent_process(pid_t child_pid)
{
  int status;
  DIAGNOSTIC(4, "Setting delivery child pid is %d", child_pid, 0);

  for (;;) {
    pid_t pid= waitpid(child_pid, &status, 0);
    if (pid < 0) {		/* wait.signal */
      assert(errno == EINTR);	
      continue;
    }
    assert(child_pid == pid);
    if (WIFSIGNALED(status)) {
      /* Child terminated by signal */
      exn_raise_format(perv_exn_ref_save,
		       "Delivery process terminated by signal %d",
		       WTERMSIG(status));
    }

    if (WIFEXITED(status))
      break;

    /* wait.other */
    DIAGNOSTIC(1, "non-fatal but unusual waitpid status %x", status, 0);
  }

  switch(WEXITSTATUS(status)) {
  case 0:
    break;
  case EIMPL:
    exn_raise_string(perv_exn_ref_save, "Function save not implemented");
  case EIMAGEWRITE:
    exn_raise_string(perv_exn_ref_save, "Error writing opened image file");
  case EIMAGEREAD: /* An error occurred reading the image. */
    exn_raise_string(perv_exn_ref_save, "Unable to read original executable file");
  case EIMAGEOPEN:
    exn_raise_string(perv_exn_ref_save, "Unable to open image file");
  case EIMAGEALLOC:
    exn_raise_string(perv_exn_ref_save, "Unable to allocate memory to create image file");
  default:
    exn_raise_string(perv_exn_ref_save, "Unexpected error from deliverFn");
  }
  return MLUNIT; /* Should later change to return to MLWorks */
}



static void report_fork_failure(void)
{
  switch(errno) {
  case EAGAIN:
    exn_raise_string(perv_exn_ref_save,
		     "Too many processes running to fork deliverfn process");
  case ENOMEM:
    exn_raise_string(perv_exn_ref_save,
		     "Insufficient memory to fork deliverFn process");
  default: 
    exn_raise_format(perv_exn_ref_save,
		     "fork() returned an unexpected error code %d", errno);
  }
}



mlval deliverFn(mlval argument)
{
  pid_t pid= fork();
    
  if(pid == -1) {
    report_fork_failure();
    return MLUNIT;		/* not reached, keep dump compilers happy */
  } else if (pid == 0) {
    child_process(argument);
    return MLUNIT;		/* not reached, keep dump compilers happy */
  } else {
    return parent_process(pid);
  }
}
