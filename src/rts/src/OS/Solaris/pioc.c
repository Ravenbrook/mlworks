/*  ==== PROCESS IOCTL FUNCTIONS ====
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
