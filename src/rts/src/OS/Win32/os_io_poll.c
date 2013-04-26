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
 * Implements most of OS.IO.poll using select since Win32 doesn't support poll.
 * This has hardly been tested since there is currently no way to create
 * a socket.  Roll on the standard Socket Library.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_io_poll.c,v $
 * Revision 1.10  1998/07/16 11:30:21  jont
 * [Bug #20135]
 * Sort out return code handling from WSA functions
 *
 * Revision 1.9  1998/02/24  11:21:56  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.8  1997/05/22  09:16:47  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr to include an mlval string.
 *
 * Revision 1.7  1996/10/24  08:37:12  stephenb
 * [Bug #1701]
 * mlw_os_io_poll_desc: remove redundant declare/retract_root.
 *
 * Revision 1.6  1996/10/08  10:57:51  stephenb
 * Do the same declare/root retract cleanup that was done as
 * part of fix 1561 for Linux.
 *
 * Revision 1.5  1996/07/04  14:48:28  stephenb
 * How oh how did I manage to check this in without compiling it!
 * s/retrace/retract/
 *
 * Revision 1.4  1996/07/04  12:00:54  stephenb
 * Fix #1456 - add declare/retract roots.
 *
 * Revision 1.3  1996/06/14  11:18:18  stephenb
 * Make mlw_os_io_poll take account of non-NONE timeouts and filter the
 * result list so that it only contains info for those descriptors that
 * have an event associated with them.
 *
 * Revision 1.2  1996/05/24  11:17:35  stephenb
 * Various changes to bring it into line with a post March 1996 basis spec.
 * These include: removing pollErr, introducing pollPri and isPri and making
 * poll raise SysErr if there are any errors.
 *
 * Revision 1.1  1996/05/07  12:37:47  stephenb
 * new unit
 *
 */


#include <windows.h>		/* select */
#if !defined(_WIN32) && !defined(WIN32)
#include <ver.h>
#endif
#include <assert.h>		/* assert */
#include <stdlib.h>		/* atexit */
#include "values.h"		/* FIELD, MLTAIL, cons ... */
#include "exceptions.h"		/* exn_raise_syserr */
#include "environment.h"	/* env_function, ... */
#include "allocator.h"		/* allocate_record, ml_string */
#include "gc.h"			/* declare_root, ... */
#include "utils.h"		/* error, message_stderr */
#include "time_date.h"		/* mlw_time_make, ... */
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
#define mlw_poll_event_pri 0x3


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
 * for polling.
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
 * If and when the Socket Library is fully defined, this could probably
 * be defined in SML.  Until that time, this is difficult to test because
 * there is no way of creating a legal socket in MLWorks.
 *
 * NOTE: development library page for select notes that the first argument
 * to select is ignored -- it is only there for compatability.  Nevertheless
 * the correct value is generated, just in case.
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
    struct timeval timeout;
    mlw_time_to_timeval(mlw_option_some(optional_timeout), &timeout);
    status= select(max_fd+1, &in_fds, &out_fds, &pri_fds, &timeout);
  }

  if (status < 0) {
    exn_raise_syserr(ml_string("OS.IO.poll failed"), WSAGetLastError());
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




/* Ideally the error messages in mlw_socket_open and mlw_socket_close
 * should be generated from winerror.h or an equivalent.  Until that
 * time we have to make do with the following hard coded versions.
 */
static void mlw_socket_open(void)
{
  WORD requested_version= MAKEWORD(1, 1);
  WSADATA actual_version;
  int status= WSAStartup(requested_version, &actual_version);
  switch (status) {
  case 0:
    break;
  case WSASYSNOTREADY:
    error("WSASYSNOTREADY (%d): Network subsystem is not ready for network communication", WSASYSNOTREADY);
  case WSAVERNOTSUPPORTED:
    error("WSAVERNOTSUPPORTED (%d): The version of Windows Socket support requested is not supported by installed Windows Socket implementation", WSAVERNOTSUPPORTED);
  case WSAEINPROGRESS:
    error("WSAEINPROGRESS (%d): A blocking Windows Socket 1.1 operation is in progress", WSAEINPROGRESS);
  case WSAEPROCLIM:
    error("WSAEPROCLIM (%d): Limit on the number of tasks supported by the Windows Sockets implementation has been reached.", WSAEPROCLIM);
  case WSAEFAULT:
    error("WSAEFAULT (%d): The lpWSAData is not a valid pointer.", WSAEFAULT);
  default:
    message("Invalid return code (%d) from WSAStartup", status);
  }
}




static void mlw_socket_close(void)
{
  int status= WSACleanup();
  if (status == SOCKET_ERROR) {
    status = WSAGetLastError();
  } else {
    status = 0;
  }
  switch (status) {
  case 0:
    break;
  case WSANOTINITIALISED:
    message("WSANOTINITIALISED (%d): Windows Sockets were not initialised", WSANOTINITIALISED);
    break;
  case WSAENETDOWN:
    message("WSAENETDOWN (%d): network subsystem has failed.", WSAEINPROGRESS);
    break;
  case WSAEINPROGRESS:
    message("WSAEINPROGRESS (%d): a blocking Windows Sockets operation is in progress.", WSAEINPROGRESS);
    break;
  default:
    message("Invalid return code (%d) from WSACleanup", status);
  }
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
  mlw_socket_open();
  if (atexit(mlw_socket_close) != 0)
    message("MLWorks could not register a socket cleanup function.\n Consequently socket resources may still be allocated when MLWorks terminates.");
}

