/* Copyright (C) 1996 Harlequin Ltd
 *
 * Any Solaris specific code which need to override the default code
 * in  ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.c,v $
 * Revision 1.8  1998/02/23 18:44:52  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.7  1997/11/17  18:50:38  jont
 * [Bug #30089]
 * Modify unix_rusage to return basis times
 *
 * Revision 1.6  1997/08/19  15:13:56  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.5  1997/05/22  09:12:26  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.4  1996/09/20  11:29:32  io
 * [Bug #1607]
 * remove getrusage and modify gettimeofday prototype
 *
 * Revision 1.3  1996/04/26  09:21:32  stephenb
 * Update wrt change in exn_raise_syserr signature.
 *
 * Revision 1.2  1996/03/29  15:02:01  stephenb
 * Replace the raising the unix exception with a call to the new exn_raise_syserr.
 *
 * Revision 1.1  1996/01/30  14:31:34  stephenb
 * new unit
 * There is only one unix.c file now, this file contains any support
 * code to make a particular flavour of Unix support the required Unix
 * interface.
 *
 */

#include "allocator.h"          /* ml_string */
#include "exceptions.h"		/* exn_raise_syserr */
#include "mltime.h"
#include "gc.h"                 /* declare_root, retract_root */
#include <sys/time.h>
#include <sys/resource.h>

#include <string.h>		/* strerror */
#include <errno.h>		/* errno */
#include "unixlocal.h"
#include "time_date.h"          /* mlw_time_make */

#include "pioc.h"
#include "syscalls.h"
#include <sys/procfs.h>		/* prusage_t, prpsinfo_t */

static mlval ml_time(struct timestruc *t)
{
  return mlw_time_make(t->tv_sec, t->tv_nsec/1000);
}

extern mlval unix_rusage(mlval unit)
{
  mlval utime, stime, result;

  /* on Solaris we can't do getrusage without the BSD-compatibility
   * library, which sucks, so we have to fake it : */

  prusage_t  usage;
  prpsinfo_t psinfo;

  if (pioc(PIOCPSINFO,&psinfo) == -1 ||
      pioc(PIOCUSAGE,&usage) == -1)
    exn_raise_syserr(ml_string(strerror(errno)), errno);

  utime = ml_time(&usage.pr_utime);
  declare_root(&utime, 0);
  stime = ml_time(&usage.pr_stime);
  declare_root(&stime, 0);

  result = allocate_record(16);
  retract_root(&utime);
  retract_root(&stime);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * idrss	integral resident set size
   * inblock	block input operations
   * isrss	currently 0
   * ixrss	currently 0
   * majflt	page faults requiring physical I/O
   * maxrss	maximum resident set size	Solaris : resident set size
   * minflt	page faults not requiring physical I/O
   * msgrcv	messages received
   * msgsnd	messages sent
   * nivcsw	involuntary context switches
   * nsignals	signals received
   * nswap	swaps voluntary
   * nvcsw	context switches
   * oublock	block output operations
   * stime	system time used
   * utime	user time used
   */

  FIELD(result,  0) = MLINT(psinfo.pr_rssize);
  FIELD(result,  1) = MLINT(usage.pr_inblk);
  FIELD(result,  2) = MLINT(0);
  FIELD(result,  3) = MLINT(0);
  FIELD(result,  4) = MLINT(usage.pr_majf);
  FIELD(result,  5) = MLINT(psinfo.pr_rssize);
  FIELD(result,  6) = MLINT(usage.pr_minf);
  FIELD(result,  7) = MLINT(usage.pr_msnd);
  FIELD(result,  8) = MLINT(usage.pr_mrcv);
  FIELD(result,  9) = MLINT(usage.pr_ictx);
  FIELD(result, 10) = MLINT(usage.pr_sigs);
  FIELD(result, 11) = MLINT(usage.pr_nswap);
  FIELD(result, 12) = MLINT(usage.pr_vctx);
  FIELD(result, 13) = MLINT(usage.pr_oublk);
  FIELD(result, 14) = stime;
  FIELD(result, 15) = utime;

  return result;
}
