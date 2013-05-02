/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Implements most of OS.IO.poll using poll.
 *
 * This would have been pushed into rts/src/OS/Unix/unix.c were it not for
 * the fact that Linux does not support poll, it only has select and so
 * needs a completely different implementation.
 *
 * Unless this implementation is being overriden by an OS specific version
 * (as it is under Linux), you will need to create the file
 * rts/src/OS/$OS/os_io_poll_local.h to hold any OS specific declarations. 
 * For example, under SunOS, neither poll or strerror are declared in any
 * header file, so they need to be declared in os_io_poll_local.h.
 *
 * Given that os_io_poll_local.h tends to be empty for other Unix platforms
 * then with hindsight, it would probably be better to define a default
 * os_io_poll_local.h which contains no declarations in this directory.
 * Then it would only be necessary to create one in the OS specific directory
 * if it really did require any declarations (i.e. currently SunOS).
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io_poll.c,v $
 * Revision 1.8  1998/02/23 18:47:31  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.7  1997/05/22  08:43:25  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.6  1996/10/24  08:36:21  stephenb
 * [Bug #1701]
 * mlw_os_io_poll_desc: remove redundant declare/retract_root.
 *
 * Revision 1.5  1996/08/06  13:15:02  stephenb
 * Update to gcc-2.7.2: replace strings.h with string.h
 *
 * Revision 1.4  1996/07/10  09:53:00  stephenb
 * Add more documentation and also optimise the root declaration
 * stuff so that declare/retract_root are not unnecessarily called.
 *
 * Revision 1.3  1996/07/04  13:20:33  stephenb
 * Fix #1456 - add declare/retract roots where necessary.
 *
 * Revision 1.2  1996/05/23  14:13:25  stephenb
 * Various changes to bring it into line with a post March 1996 basis spec.
 * These include: removing pollErr, introducing pollPri and isPri and making
 * poll raise SysErr if there are any errors.
 *
 * Revision 1.1  1996/05/07  11:36:09  stephenb
 * new unit
 *
 */

#include <assert.h>
#include <stropts.h>		/* INFTIM */
#include <poll.h>		/* struct pollfd */
#include <errno.h>		/* errno */
#include <string.h>		/* strerror */
#include "values.h"		/* FIELD, MLTAIL, cons ... etc.*/
#include "exceptions.h"		/* exn_raise_syserr */
#include "environment.h"	/* env_function ... etc. */
#include "global.h"		/* declare_global */
#include "allocator.h"		/* allocate_record, ml_string */
#include "gc.h"			/* declare_root */
#include "alloc.h"		/* malloc, free */
#include "time_date.h"		/* mlw_time_make,mlw_time_sec,mlw_time_usec */
#include "os_io_poll_local.h"
#include "os_io_poll.h"		/* os_poll_io_init */



/* Some macros which partially hide the internal structure of
 * poll_desc and poll_info as defined in unix/_os_io.sml
 * Obviously you shouldn't alter the following without also
 * updating the datatype declarations in the above file.
 */
#define mlw_poll_desc_make() allocate_record(2)
#define mlw_poll_desc_fd(poll_desc) FIELD(poll_desc, 0)
#define mlw_poll_desc_events(poll_desc) FIELD(poll_desc, 1)

#define mlw_poll_info_make() allocate_record(2)
#define mlw_poll_info_desc(poll_info) FIELD(poll_info, 0)
#define mlw_poll_info_revents(poll_info) FIELD(poll_info, 1)



/* An io_desc is currently implemented as an integer.
 * Because of this there is no need to declare as a root
 * any io_desc that is an argument to a function in which
 * any allocation is done.  However, to ensure that the
 * code doesn't break in mysterious ways should the 
 * structure of an io_desc change, the following should
 * be sprinkled liberally around the code to ensure that
 * if the representation does change we get to know about
 * it here straight away.
 */
#define mlw_os_io_poll_is_io_desc(arg) (!MLVALISPTR(arg))



/*
 * Implements OS.IO.pollDesc: io_desc -> poll_desc option
 *
 * XXX: Currently makes no attempt to check if the descriptor is suitable
 * for polling.  In a private message Reppy suggested that fstat could
 * be used to determine if the descriptor is suitable.
 */
static mlval mlw_os_io_poll_desc(mlval arg)
{
  mlval poll_desc;

  assert(mlw_os_io_poll_is_io_desc(arg));
  poll_desc= mlw_poll_desc_make();
  mlw_poll_desc_fd(poll_desc)= arg;
  mlw_poll_desc_events(poll_desc)= MLINT(0);

  return mlw_option_make_some(poll_desc);
}




/*
 * OS.IO.pollIn: poll_desc -> poll_desc
 *
 */
static mlval mlw_os_io_poll_in(mlval arg)
{
  int events= CINT(mlw_poll_desc_events(arg));
  mlval io_desc= mlw_poll_desc_fd(arg);
  mlval new_poll_desc;

  assert(mlw_os_io_poll_is_io_desc(io_desc));

  new_poll_desc= mlw_poll_desc_make();
  mlw_poll_desc_fd(new_poll_desc)= io_desc;
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|POLLIN);
  return new_poll_desc;
}




/*
 * OS.IO.pollOut: poll_desc -> poll_desc
 *
 */
static mlval mlw_os_io_poll_out(mlval arg)
{
  int events= CINT(mlw_poll_desc_events(arg));
  mlval io_desc= mlw_poll_desc_fd(arg);
  mlval new_poll_desc;
  
  assert(mlw_os_io_poll_is_io_desc(io_desc));
  new_poll_desc= mlw_poll_desc_make();
  mlw_poll_desc_fd(new_poll_desc)= io_desc;
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|POLLOUT);
  return new_poll_desc;
}




/* Reppy didn't give an explicit description of what "priority" means.
 * This could include POLLWRBAND and POLLRDBAND but since SunOS
 * doesn't support them (and I can't be bothered to set up an #ifdef
 * or separate header file for this one case) I'm taking it to mean
 * high priority only ... - stephenb
 */
#define mlw_event_priority POLLPRI



/*
 * OS.IO.pollPri: poll_desc -> poll_desc
 *
 */
static mlval mlw_os_io_poll_pri(mlval arg)
{
  int events= CINT(mlw_poll_desc_events(arg));
  mlval io_desc= mlw_poll_desc_fd(arg);
  mlval new_poll_desc;

  assert(mlw_os_io_poll_is_io_desc(io_desc));

  new_poll_desc= mlw_poll_desc_make();
  mlw_poll_desc_fd(new_poll_desc)= io_desc;
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|mlw_event_priority);
  return new_poll_desc;
}



/*
 * OS.IO.poll presents a list of descriptors but the poll operation
 * expects an array of descriptors.  Therefore, the following implements a 
 * stretchy array of descriptors which makes the conversion process 
 * simpler.  Note that to avoid leaking or allocating/deallocating on
 * every call, a static fixed sized buffer is initially used and this
 * flips to a dynamically allocated one if the buffer overflows.
 */

#define pollfd_buffer_init_max_elems 10
static struct pollfd pollfd_default_buffer[pollfd_buffer_init_max_elems];
static size_t pollfd_buffer_max_elems= pollfd_buffer_init_max_elems;
static size_t pollfd_buffer_nelems=    pollfd_buffer_init_max_elems;
static struct pollfd * pollfd_buffer=  pollfd_default_buffer;


static void pollfd_buffer_open(void)
{
  /* this is a nop since all the variables are initialised statically
   * and then maintained by pollfd_buffer_and and pollfd_buffer_close
   */
  assert(pollfd_buffer_nelems <= pollfd_buffer_max_elems);
}




static void pollfd_buffer_add(int fd, int events)
{
  if (pollfd_buffer_nelems == pollfd_buffer_max_elems) {
    size_t new_max;
    struct pollfd * new_buffer;

    if (pollfd_buffer_nelems == pollfd_buffer_init_max_elems) {
      new_max= pollfd_buffer_init_max_elems*2;
      if ((new_buffer= (struct pollfd *)malloc(new_max*sizeof(struct pollfd))) == 0) {
	pollfd_buffer_nelems= 0;
	exn_raise_syserr(ml_string(strerror(errno)), errno);
      }
      memcpy(new_buffer, pollfd_buffer, pollfd_buffer_init_max_elems*sizeof(struct pollfd));

    } else {
      new_max= pollfd_buffer_max_elems * 2;
      new_buffer= (struct pollfd *)realloc(pollfd_buffer, new_max*sizeof(struct pollfd));
      if (new_buffer == (struct pollfd *)0) {
	int saved_errno= errno;
	free(pollfd_buffer);
	pollfd_buffer= pollfd_default_buffer;
	pollfd_buffer_nelems= 0;
	pollfd_buffer_max_elems= pollfd_buffer_init_max_elems;
	exn_raise_syserr(ml_string(strerror(saved_errno)), saved_errno);
      }
    }

    pollfd_buffer= new_buffer;
    pollfd_buffer_max_elems= new_max;
  }

  pollfd_buffer[pollfd_buffer_nelems].fd= fd;
  pollfd_buffer[pollfd_buffer_nelems].events= events;
  pollfd_buffer[pollfd_buffer_nelems].revents= 0;
  pollfd_buffer_nelems += 1;
}




static void pollfd_buffer_close(void)
{
  if (pollfd_buffer != pollfd_default_buffer) {
    free(pollfd_buffer);
    pollfd_buffer= pollfd_default_buffer;
    pollfd_buffer_max_elems= pollfd_buffer_init_max_elems;
  }
  pollfd_buffer_nelems= 0;
}





/*
 * OS.IO.poll: (poll_desc list * Time.time option) -> poll_info list
 *
 */
static mlval mlw_os_io_poll(mlval arg)
{
  mlval poll_descs= FIELD(arg, 0);
  mlval optional_timeout= FIELD(arg, 1);
  int   msec_timeout;
  mlval poll_infos= MLNIL;
  mlval l;
  int status;

  pollfd_buffer_open();

  for (l= poll_descs; !MLISNIL(l); l= MLTAIL(l)) {
    mlval poll_desc= MLHEAD(l);
    int fd= CINT(mlw_poll_desc_fd(poll_desc));
    int events= CINT(mlw_poll_desc_events(poll_desc));
    pollfd_buffer_add(fd, events);
  }

  if (mlw_option_is_none(optional_timeout)) {
    msec_timeout= INFTIM;
  } else {
    mlval timeout= mlw_option_some(optional_timeout);
    long secs= mlw_time_sec(timeout);
    long usecs= mlw_time_usec(timeout);
    msec_timeout= secs*mlw_time_msecs_per_sec
                + usecs/(mlw_time_usecs_per_sec/mlw_time_msecs_per_sec);
  }

  status= poll(pollfd_buffer, pollfd_buffer_nelems, msec_timeout);
  if (status < 0) {
    exn_raise_syserr(ml_string(strerror(errno)), errno);
  } else if (status > 0) {
    size_t i= 0;
    declare_root(&l, 0);
    declare_root(&poll_infos, 0);
    for (l= poll_descs; !MLISNIL(l); l= MLTAIL(l), i += 1) {
      short revents= pollfd_buffer[i].revents;
      if (revents & (POLLERR|POLLHUP|POLLNVAL)) {
	/* an error so clean up and raise an exception */
	retract_root(&l);
	retract_root(&poll_infos);
	pollfd_buffer_close();
	exn_raise_syserr(ml_string("OS.IO.poll error"), 0);
      } else if (revents != 0) {
	mlval poll_info;
	poll_info= mlw_poll_info_make();
	mlw_poll_info_desc(poll_info)= MLHEAD(l);
	mlw_poll_info_revents(poll_info)= MLINT(revents);
	poll_infos= cons(poll_info, poll_infos);
      }
    }
    retract_root(&poll_infos);
    retract_root(&l);
  } else {
    /* timeout or no descriptors so just return the empty list */
  }

  pollfd_buffer_close();
  return poll_infos;
}




/*
 * OS.IO.isIn: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_in(mlval arg)
{
  short revents= CINT(mlw_poll_info_revents(arg));
  return (revents&POLLIN) ? MLTRUE : MLFALSE;
}



/*
 * OS.IO.isOut: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_out(mlval arg)
{
  short revents= CINT(mlw_poll_info_revents(arg));
  return (revents&POLLOUT) ? MLTRUE : MLFALSE;
}



/*
 * OS.IO.isPri: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_pri(mlval arg)
{
  short revents= CINT(mlw_poll_info_revents(arg));
  return (revents&mlw_event_priority) ? MLTRUE : MLFALSE;
}




void mlw_os_io_poll_init(void)
{
  env_function("OS.IO.pollDesc", mlw_os_io_poll_desc);
  env_function("OS.IO.pollIn",   mlw_os_io_poll_in);
  env_function("OS.IO.pollOut",  mlw_os_io_poll_out);
  env_function("OS.IO.pollPri",  mlw_os_io_poll_pri);
  env_function("OS.IO.poll",     mlw_os_io_poll);
  env_function("OS.IO.isIn",     mlw_os_io_is_in);
  env_function("OS.IO.isOut",    mlw_os_io_is_out);
  env_function("OS.IO.isPri",    mlw_os_io_is_pri);
}
