/*  ==== PROCESS IOCTL FUNCTIONS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd
 *
 *  Description
 *  -----------

 *  This provides /proc ioctl calls for the current process to the
 *  rest of the Solaris-specific runtime.
 *
 *  $Log: pioc.c,v $
 *  Revision 1.2  1997/03/07 11:27:53  stephenb
 *  [Bug #1898]
 *  pioc_init: open the proc file as O_RDONLY rather than O_RDWR since
 *  the file is not written to.
 *
 * Revision 1.1  1995/02/23  16:03:59  nickb
 * new unit
 * Process control file ioctl.
 *
 */

#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include "pioc.h"
#include "utils.h"
#include "diagnostic.h"

static int self_proc_fd = 0;

extern void pioc_init(void)
{
  int pid = getpid();
  char filename[] = "/proc/000000";

  sprintf(filename,"/proc/%d",pid);
  DIAGNOSTIC(2,"opening %s for process control",filename,0);
  self_proc_fd = open(filename, O_RDONLY);
  if (self_proc_fd == -1)
    error("error on opening process control file; errno set to %d",errno);
}

extern int pioc(int code, void *p)
{
  if (self_proc_fd == 0)
    error ("pioc() called before process control file opened.");
  return ioctl(self_proc_fd, code, p);
}
