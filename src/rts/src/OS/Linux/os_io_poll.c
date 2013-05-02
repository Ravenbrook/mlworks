/* Copyright (C) 1996 Harlequin Ltd
 *
 * Implements most of OS.IO.poll using select since Linux doesn't support poll.
 * This overrides the version in rts/src/OS/Unix/os_io_poll.[ch] that is
 * implemented using poll.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io_poll.c,v $
 * Revision 1.7  1998/02/24 11:19:01  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.6  1997/05/22  09:12:02  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.5  1996/10/24  08:36:49  stephenb
 * [Bug #1701]
 * mlw_os_io_poll_desc: remove redundant declare/retract_root.
 *
 * Revision 1.4  1996/10/08  10:35:59  stephenb
 * [Bug #1561]
 *   Problem: the select call was always indicating that
 *   there were no events detected for the given file descriptors.
 *
 *   Cause: the first argument to select was the number of file
 *   descriptors to check for events on.  This is correct according to
 *   the Linux manual page, but doesn't produce the desired results.
 *
 *   Fix: change the first argument to be the maximum file descriptor + 1
 *   (as indicated in Advanded Programming in the Unix Environment -
 *   W. Richard Stevens).
 *
 *   Removed some redundant (due to rts.alloc.rule.hybrid.args)
 *   declare/retract root calls and added some assertions to ensure that
 *   if the type does change in the future such that the declare/retract
 *   calls are necessary the result will be an easy to diagnose assertion
 *   rather than a mysterious and hard to reproduce GC error.
 *
 * Revision 1.3  1996/07/05  13:15:08  stephenb
 * Fix #1427 - poll doesn't filter descriptors.
 * Also added declare/retract_roots where necessary.
 *
 * Revision 1.2  1996/05/24  11:17:10  stephenb
 * Various changes to bring it into line with a post March 1996 basis spec.
 * These include: removing pollErr, introducing pollPri and isPri and making
 * poll raise SysErr if there are any errors.
 *
 * Revision 1.1  1996/05/07  12:19:38  stephenb
 * new unit
 *
 */


#include <assert.h>		/* assert */
#include <errno.h>		/* errno */
#include <sys/types.h>		/* select */
#include <sys/time.h>		/* select */
#include <unistd.h>		/* select */
#include "values.h"		/* FIELD, MLTAIL, mlw_cons ... etc.*/
#include "exceptions.h"		/* exn_raise_syserr */
#include "environment.h"	/* env_function ... etc. */
#include "allocator.h"		/* allocate_record, ml_string */
#include "gc.h"			/* declare_root */
#include "time_date.h"		/* mlw_time_make,mlw_time_sec,mlw_time_usec */
#include "os_io_poll.h"		/* os_poll_io_init */



/*
 * datatype event_set = EVENT_SET of int
 * datatype poll_desc = POLL_DESC of io_desc * event_set
 * datatype poll_info = POLL_INFO of poll_desc * event_set
 */
#define mlw_poll_desc_make() allocate_record(2)
#define mlw_poll_desc_fd(poll_desc) FIELD(poll_desc, 0)
#define mlw_poll_desc_events(poll_desc) FIELD(poll_desc, 1)

#define mlw_poll_info_make() allocate_record(2)
#define mlw_poll_info_desc(poll_info) FIELD(poll_info, 0)
#define mlw_poll_info_revents(poll_info) FIELD(poll_info, 1)



/*
 * The SML interface is based on SysV poll which is defined in terms of
 * event sets which indicate the type of events you are interested in.
 * The following codes are used to represent the three types of event
 * that SML knows about.  Note that the codes should have values of the 
 * form 2**n with each value being distinct and n in the range
 * [1, ML_MAX_INT_BITS].  This is so that it is easy to use bit masking
 * to check if a given value is defined.
 */
#define mlw_poll_event_in  0x1
#define mlw_poll_event_out 0x2
#define mlw_poll_event_pri 0x4


/* The final event type is the empty event and
 * should always have the value 0
 */
#define mlw_poll_event_none 0x0



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
  mlw_poll_desc_events(poll_desc)= MLINT(mlw_poll_event_none);

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
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|mlw_poll_event_in);
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
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|mlw_poll_event_out);
  return new_poll_desc;
}



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
  mlw_poll_desc_events(new_poll_desc)= MLINT(events|mlw_poll_event_pri);
  return new_poll_desc;
}



/*
 * OS.IO.poll: (poll_desc list * Time.time option) -> poll_info list
 *
 * NOTE: The Linux manual page states that the first argument to select
 * should be "numfds" but does not expand on that.  If this is taken
 * literally to be the number of file descriptors, then you won't get
 * the correct results.  As is stated in :-
 *
 *   Advanced Unix Programming in the Unix Environment
 *   W. Richard Stevens
 *   Addison Wesley
 *
 * the first argument actually should be the maximum file descriptor
 * plus one.
 */
static mlval mlw_os_io_poll(mlval arg)
{
  mlval poll_descs= FIELD(arg, 0);
  mlval optional_timeout= FIELD(arg, 1);
  mlval poll_infos= MLNIL;
  mlval l;
  int status;
  int max_fd= -1;
  fd_set in_fds, out_fds, pri_fds;

  FD_ZERO(&in_fds);
  FD_ZERO(&out_fds);
  FD_ZERO(&pri_fds);
  for (l= poll_descs; !MLISNIL(l); l= MLTAIL(l)) {
    mlval poll_desc= MLHEAD(l);
    int fd= CINT(mlw_poll_desc_fd(poll_desc));
    int events= CINT(mlw_poll_desc_events(poll_desc));
    if (fd > max_fd)
      max_fd= fd;
    if (events&mlw_poll_event_in)
      FD_SET(fd, &in_fds);
    if (events&mlw_poll_event_out)
      FD_SET(fd, &out_fds);
    if (events&mlw_poll_event_pri)
      FD_SET(fd, &pri_fds);
  }

  if (mlw_option_is_none(optional_timeout)) {
    status= select(max_fd+1, &in_fds, &out_fds, &pri_fds, NULL);
  } else {
    mlval timeout= mlw_option_some(optional_timeout);
    struct timeval tv;
    tv.tv_sec= mlw_time_sec(timeout);
    tv.tv_usec= mlw_time_usec(timeout);
    status= select(max_fd+1, &in_fds, &out_fds, &pri_fds, &tv);
  }

  if (status < 0) {
    exn_raise_syserr(ml_string(strerror(errno)), errno);
  } else if (status > 0) {
    declare_root(&l, 0);
    declare_root(&poll_infos, 0);
    for (l= poll_descs; !MLISNIL(l); l= MLTAIL(l)) {
      mlval poll_desc= MLHEAD(l);
      int fd= CINT(mlw_poll_desc_fd(poll_desc));
      int events= CINT(mlw_poll_desc_events(poll_desc));
      int revents= 0;
      if (events&mlw_poll_event_in && FD_ISSET(fd, &in_fds))
	revents |= mlw_poll_event_in;
      if (events&mlw_poll_event_out && FD_ISSET(fd, &out_fds))
	revents |= mlw_poll_event_out;
      if (events&mlw_poll_event_pri && FD_ISSET(fd, &pri_fds))
	revents |= mlw_poll_event_pri;
      if (revents != 0) {
	mlval poll_info= mlw_poll_info_make();
	mlw_poll_info_desc(poll_info)= MLHEAD(l);
	mlw_poll_info_revents(poll_info)= MLINT(revents);
	poll_infos= mlw_cons(poll_info, poll_infos);
      } else {
	/* no events detected for this descriptor */
      }
    }
    retract_root(&poll_infos);
    retract_root(&l);
  } else {
    /* timeout or no events for any descriptor, just return the empty list */
  }

  return poll_infos;
}




/*
 * OS.IO.isIn: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_in(mlval arg)
{
  int revents= CINT(mlw_poll_info_revents(arg));
  return MLBOOL(revents&mlw_poll_event_in);
}



/*
 * OS.IO.isOut: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_out(mlval arg)
{
  int revents= CINT(mlw_poll_info_revents(arg));
  return MLBOOL(revents&mlw_poll_event_out);
}



/*
 * OS.IO.isPri: poll_info -> bool
 *
 */
static mlval mlw_os_io_is_pri(mlval arg)
{
  int revents= CINT(mlw_poll_info_revents(arg));
  return MLBOOL(revents&mlw_poll_event_pri);
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
