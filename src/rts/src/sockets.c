/* rts/src/sockets.c
 *
 * Functions for manipulating sockets
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * $Log: sockets.c,v $
 * Revision 1.3  1998/11/11 15:48:17  mitchell
 * [Bug #70242]
 * Modify includes to support Linux
 *
 * Revision 1.2  1998/11/10  17:01:03  mitchell
 * [Bug #70242]
 * Add missing include file for Windows
 *
 * Revision 1.1  1998/11/10  16:00:00  mitchell
 * new unit
 * [Bug #70242]
 *
 *
 */


#include <fcntl.h>
#include <assert.h>
#include <errno.h>	
#include <sys/types.h>	
#include <sys/stat.h>	
#include <stdlib.h>
#include <string.h>

#include "values.h"
#include "allocator.h"
#include "gc.h"
#include "environment.h"
#include "global.h"
#include "exceptions.h"
#include "utils.h"
#include "os_errors.h"	
#include "words.h"		
#include "sockets.h"		

#ifdef _WIN32
#include <io.h>		       
#include <winsock.h>
#define ioctl ioctlsocket

#else
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/param.h>
#define BSD_COMP
#include <sys/ioctl.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCKET int
#define INVALID_SOCKET -1
#define SOCKET_ERROR -1
extern int gethostname(char *name, int namelen);
#endif

#define ioctl_type unsigned long *

#ifndef MAXHOSTNAMELEN
#define MAXHOSTNAMELEN 256
#endif
#define MAX_SOCK_ADDR_SZB 1024


/* We ifdef the following function so we don't have to have platform-specific
 * sockets code at the sml level. */

#ifdef _WIN32
static mlval ml_fdtoiod(mlval arg)
{
  HANDLE io_desc= (HANDLE)CINT(arg);
  int fd= _open_osfhandle((long)io_desc, O_RDONLY);

  if (fd < 0) {
    int saved_errno= errno;
    (void)_close(fd);
    exn_raise_syserr(ml_string(
      "Cannot convert file descriptor to IO descriptor"), 0);
  }
  return MLINT(fd);
}

#else
static mlval ml_fdtoiod(mlval arg)
{
  return arg;
}
#endif


/* Utility function to convert a C string list to an ML one */

static mlval string_list_to_ml(char **list) 
{
  if (list == 0) return MLNIL;
  else {
    mlval result = MLNIL;
    mlval string = MLUNIT;
    char **lp = list;

    declare_root(&result, 0);
    declare_root(&string, 0);

    lp = list; while (*lp) lp++; /* Find the end of the list */

    while (--lp >= list) {
      string = ml_string(*lp);
      result = mlw_cons(string, result);
    }

    retract_root(&result);
    retract_root(&string);
    return result;
  }
}
    

/* A utility function build an ML representation of a C servent structure */
/* type servent = (string * string list * int * string) */

static mlval make_servent(struct servent *sp)
{
  mlval servent, name, aliases, protocol;
  name = ml_string(sp->s_name);
  declare_root(&name, 0);
  aliases = string_list_to_ml(sp->s_aliases);
  declare_root(&aliases, 0);
  protocol = ml_string(sp->s_proto);
  declare_root(&protocol, 0);

  servent = allocate_record(4);  
  FIELD(servent, 0) = name;
  FIELD(servent, 1) = aliases;
  FIELD(servent, 2) = MLINT(ntohs(sp->s_port));
  FIELD(servent, 3) = protocol;

  retract_root(&name);
  retract_root(&aliases);
  retract_root(&protocol);
  return servent;
}


/* Functions to retrieve servent information */

static mlval ml_getservbyname(mlval arg)
/* : (string  * string option) -> servent option */
{
  char *name = CSTRING(FIELD(arg, 0));
  char *prot;
  struct servent *sp;
  mlval prot_opt = FIELD(arg, 1);

  if (mlw_option_is_none(prot_opt)) 
    prot = (char *) 0;
  else
    prot = CSTRING(mlw_option_some(prot_opt));

  sp = getservbyname(name, prot);

  if (sp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_servent(sp));
}

static mlval ml_getservbyport(mlval arg)
/* : (int  * string option) -> servent option */
{
  int port = htons((short) (CINT(FIELD(arg, 0))));
  char *prot;
  struct servent *sp;
  mlval prot_opt = FIELD(arg, 1);

  if (mlw_option_is_none(prot_opt)) 
    prot = (char *) 0;
  else
    prot = CSTRING(mlw_option_some(prot_opt));

  sp = getservbyport(port, prot);

  if (sp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_servent(sp));
}


/* A utility function build an ML representation of a C netent structure */
/* type netent = (string * string list * PreSock.af * SysWord.word) */

static mlval make_netent(struct netent *np)
{
  mlval netent, name, aliases, addrtype, net;
  name = ml_string(np->n_name);
  declare_root(&name, 0);
  aliases = string_list_to_ml(np->n_aliases);
  declare_root(&aliases, 0);
  addrtype = allocate_word32();
  num_to_word32((unsigned)np->n_addrtype, addrtype);
  declare_root(&addrtype, 0);
  net = allocate_word32();
  num_to_word32((unsigned)np->n_net, net);
  declare_root(&net, 0);

  netent = allocate_record(4);  
  FIELD(netent, 0) = name;
  FIELD(netent, 1) = aliases;
  FIELD(netent, 2) = addrtype;
  FIELD(netent, 3) = net;

  retract_root(&name);
  retract_root(&aliases);
  retract_root(&addrtype);
  retract_root(&net);
  return netent;
}


/* Functions to retrieve netent information */

#ifdef _WIN32
/* Windows doesn't seem to provide this information, so always return NONE */
static mlval ml_getnetbyname(mlval arg) { return mlw_option_make_none(); }
static mlval ml_getnetbyaddr(mlval arg) { return mlw_option_make_none(); }

#else
static mlval ml_getnetbyname(mlval arg)
/* : string -> netent option */
{ 
  char *name = CSTRING(arg);
  struct netent *np;
  np = getnetbyname(name);

  if (np == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_netent(np));
}

static mlval ml_getnetbyaddr(mlval arg)
/* : (SysWord.word * PreSock.af) -> netent option */
{ 
  unsigned long net = word32_to_num(FIELD(arg, 0));
  int type = CINT(FIELD(arg, 1));
  struct netent *np;

  np = getnetbyaddr(net, type);

  if (np == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_netent(np));
}
#endif /* _WIN32 */


/* A utility function build an ML representation of a C protoent structure */
/* type protoent = (string * string list * int) */

static mlval make_protoent(struct protoent *pp)
{
  mlval protoent, name, aliases;
  name = ml_string(pp->p_name);
  declare_root(&name, 0);
  aliases = string_list_to_ml(pp->p_aliases);
  declare_root(&aliases, 0);

  protoent = allocate_record(3);  
  FIELD(protoent, 0) = name;
  FIELD(protoent, 1) = aliases;
  FIELD(protoent, 2) = MLINT(pp->p_proto);

  retract_root(&name);
  retract_root(&aliases);
  return protoent;
}


/* Functions to retrieve protoent information */

static mlval ml_getprotbyname(mlval arg)
/* : string -> protoent option */
{ 
  char *name = CSTRING(arg);
  struct protoent *pp;
  pp = getprotobyname(name);

  if (pp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_protoent(pp));
}

static mlval ml_getprotbynum(mlval arg)
/* : int -> protoent option */
{ 
  int num = CINT(arg);
  struct protoent *pp;
  pp = getprotobynumber(num);

  if (pp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_protoent(pp));
}


/* A utility function build an ML representation of a C hostent structure */
/* type hostent = (string * string list * PreSock.af * PreSock.addr list) */

static mlval make_hostent(struct hostent *hp)
{
  mlval hostent, name, aliases, addrtype, addr, addrlist;
  int naddrs, i;
  name = ml_string(hp->h_name);
  declare_root(&name, 0);
  aliases = string_list_to_ml(hp->h_aliases);
  declare_root(&aliases, 0);
  addrtype = allocate_word32();
  num_to_word32((unsigned)hp->h_addrtype, addrtype);
  declare_root(&addrtype, 0);
  addrlist = MLNIL;
  declare_root(&addrlist, 0);

  for (naddrs = 0;  hp->h_addr_list[naddrs] != (char *)0;  naddrs++)
    continue;

  for (i = naddrs;  --i >= 0;  ) {
    addr = allocate_string(hp->h_length + 1);
    memcpy(CSTRING(addr), hp->h_addr_list[i], hp->h_length);
    CSTRING(addr)[hp->h_length] = '\0';
    addrlist = mlw_cons(addr, addrlist);
  }

  hostent = allocate_record(4);  
  FIELD(hostent, 0) = name;
  FIELD(hostent, 1) = aliases;
  FIELD(hostent, 2) = addrtype;
  FIELD(hostent, 3) = addrlist;

  retract_root(&name);
  retract_root(&aliases);
  retract_root(&addrtype);
  retract_root(&addrlist);
  return hostent;
}


/* Functions to retrieve host information */

static mlval ml_gethostbyname(mlval arg)
/* : string -> hostent option */
{ 
  char *name = CSTRING(arg);
  struct hostent *hp;
  hp = gethostbyname(name);

  if (hp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_hostent(hp)); 
}

static mlval ml_gethostbyaddr(mlval arg)
/* : PreSock.addr -> hostent option */
{ 
  char *addr = CSTRING(arg);
  struct hostent *hp;
  hp = gethostbyaddr(addr, sizeof(struct in_addr), AF_INET);

  if (hp == NULL)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(make_hostent(hp));
}


static mlval ml_gethostname(mlval arg)
/* : unit -> string */
{ 
  char hostname[MAXHOSTNAMELEN];
  if (gethostname (hostname, MAXHOSTNAMELEN) == SOCKET_ERROR)
    exn_raise_syserr(ml_string("Cannot determine host name"), 0);
  else
    return ml_string(hostname);
}


/* In C, system constants are usually integers.  We represent these in the ML
 * system as (int * string) pairs, where the integer is the C constant, and the
 * string is a short version of the symbolic name used in C (e.g., the constant
 * EINTR might be represented as (4, "INTR")).
 * This will break for large system constants... We should check for this
 * eventually.
 */

typedef struct {	/* The representation of system constants */
    int		id;
    char	*name;
} sys_const_t;

typedef struct {	/* a table of system constants. */
    int		numConsts;
    sys_const_t	*consts;
} sysconst_tbl_t;


/* find_sysconst:
 *
 * Find the system constant with the given id in tbl, and allocate a pair
 * to represent it.  If the constant is not present, then return the
 * pair (~1, "<UNKNOWN>").
 */
static mlval find_sysconst (sysconst_tbl_t *tbl, int id)
{
  mlval name, pair;
  int   i;

  declare_root(&name, 0);

  for (i = 0;  i < tbl->numConsts;  i++) {
    if (tbl->consts[i].id == id) {
      name = ml_string (tbl->consts[i].name);
      pair = allocate_record(2);
      FIELD(pair, 0) = MLINT(id);
      FIELD(pair, 1) = name;
      retract_root(&name);
      return pair;
    }
  }
  /* here, we did not find the constant */
  name = ml_string ("<UNKNOWN>");
  pair = allocate_record(2);
  FIELD(pair, 0) = MLINT(-1);
  FIELD(pair, 1) = name;
  retract_root(&name);
  return pair;
} 

/* make_sysconst_list:
 *
 * Generate a list of system constants from the given table.
 */
static mlval make_sysconst_list (sysconst_tbl_t *tbl)
{
    int	  i;
    mlval name = MLUNIT;
    mlval pair = MLUNIT;
    mlval list = MLNIL;

    declare_root(&list, 0);
    declare_root(&name, 0);

    for (i = tbl->numConsts;  --i >= 0;  ) {
	name = ml_string (tbl->consts[i].name);
        pair = allocate_record(2);
        FIELD(pair, 0) = MLINT(tbl->consts[i].id);
        FIELD(pair, 1) = name;
	list = mlw_cons(pair, list);
    }

    retract_root(&name);
    retract_root(&list);
    return list;
} 


/** The table of address-family names **/
static sys_const_t	af_tbl[] = {
      {AF_UNIX,     (char *) "UNIX"},
      {AF_INET,     (char *) "INET"},
#ifdef AF_IMPLINK
      {AF_IMPLINK,  (char *) "IMPLINK"},
#endif
#ifdef AF_PUP
      {AF_PUP,      (char *) "PUP"},
#endif
#ifdef AF_CHAOS
      {AF_CHAOS,    (char *) "CHAOS"},
#endif
#ifdef AF_NS
      {AF_NS,       (char *) "NS"},
#endif
#ifdef AF_ISO
      {AF_ISO,      (char *) "ISO"},
#endif
#ifdef AF_ECMA
      {AF_ECMA,     (char *) "ECMA"},
#endif
#ifdef AF_DATAKIT
      {AF_DATAKIT,  (char *) "DATAKIT"},
#endif
#ifdef AF_CCITT
      {AF_CCITT,    (char *) "CCITT"},
#endif
#ifdef AF_SNA
      {AF_SNA,      (char *) "SNA"},
#endif
#ifdef AF_DECnet
      {AF_DECnet,   (char *) "DECnet"},
#endif
#ifdef AF_DLI
      {AF_DLI,      (char *) "DLI"},
#endif
#ifdef AF_LAT
      {AF_LAT,      (char *) "LAT"},
#endif
#ifdef AF_HYLINK
      {AF_HYLINK,   (char *) "HYLINK"},
#endif
#ifdef AF_APPLETALK
      {AF_APPLETALK,(char *) "APPLETALK"},
#endif
#ifdef AF_ROUTE
      {AF_ROUTE,    (char *) "ROUTE"},
#endif
#ifdef AF_RAW
      {AF_RAW,      (char *) "RAW"},
#endif
#ifdef AF_LINK
      {AF_LINK,     (char *) "LINK"},
#endif
#ifdef AF_NIT
      {AF_NIT,      (char *) "NIT"},
#endif
#ifdef AF_802
      {AF_802,      (char *) "802"},
#endif
#ifdef AF_OSI
      {AF_OSI,      (char *) "OSI"},
#endif
#ifdef AF_X25
      {AF_X25,      (char *) "X25"},
#endif
#ifdef AF_OSINET
      {AF_OSINET,   (char *) "OSINET"},
#endif
#ifdef AF_GOSIP
      {AF_GOSIP,    (char *) "GOSIP"},
#endif
#ifdef AF_SDL
      {AF_SDL,      (char *) "SDL"},
#endif
    };

sysconst_tbl_t	_Sock_AddrFamily = {
	sizeof(af_tbl) / sizeof(sys_const_t),
	af_tbl
    };

static mlval ml_listaddrfamilies(mlval arg)
/* : unit -> CI.system_const list */
{ 
  return make_sysconst_list(&_Sock_AddrFamily);
}

/** The table of socket-type names **/
static sys_const_t	st_tbl[] = {
      {SOCK_STREAM,   (char *) "STREAM"},
      {SOCK_DGRAM,    (char *) "DGRAM"},
#ifdef SOCK_RAW
      {SOCK_RAW,      (char *) "RAW"},
#endif
#ifdef SOCK_RDM
      {SOCK_RDM,      (char *) "RDM"},
#endif
#ifdef SOCK_SEQPACKET
      {SOCK_SEQPACKET,(char *) "SEQPACKET"},
#endif
    };

sysconst_tbl_t	_Sock_Type = {
	sizeof(st_tbl) / sizeof(sys_const_t),
	st_tbl
    };

static mlval ml_listsocktypes(mlval arg)
/* : unit -> PreSock.system_const list */
{ 
  return make_sysconst_list(&_Sock_Type);
}


/* A utility function for handling the socket control flags with bool values */

static mlval sock_controlflg (mlval arg, int option)
{
  SOCKET   sock = CINT(FIELD(arg, 0));
  mlval ctl = FIELD(arg, 1);
  int	flg, sts;

  if (mlw_option_is_none(ctl)) {
    socklen_t optSz = sizeof(int);
    sts = getsockopt (sock, SOL_SOCKET, option, (char *)&flg, &optSz);
    assert((sts == SOCKET_ERROR) || (optSz == sizeof(int)));
    if (sts == SOCKET_ERROR)
      exn_raise_syserr(ml_string("getsockopt failed"), 0);
  } else {
    flg = CBOOL(mlw_option_some(ctl));
    sts = setsockopt (sock, SOL_SOCKET, option, (char *)&flg, sizeof(int));
    if (sts == SOCKET_ERROR)
      exn_raise_syserr(ml_string("setsockopt failed"), 0);
  }

  return (flg ? MLTRUE : MLFALSE);
} /* end of sock_controlflg */


/* Socket control functions */

static mlval ml_ctldebug(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_DEBUG);
}

static mlval ml_ctlreuseaddr(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_REUSEADDR);
}

static mlval ml_ctlkeepalive(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_KEEPALIVE);
}

static mlval ml_ctldontroute(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_DONTROUTE);
}

/* ml_ctllinger : (sockFD * int option option) -> int option
 *
 * Set/get the SO_LINGER option as follows:
 *   NONE		=> get current setting
 *   SOME(NONE)		=> disable linger
 *   SOME(SOME t)	=> enable linger with timeout t.
 */

static mlval ml_ctllinger(mlval arg)
{
  SOCKET        sock = CINT(FIELD(arg, 0));
  mlval         ctl =  FIELD(arg, 1);
  struct linger optVal;
  int	        sts;

  if (mlw_option_is_none(ctl)) {
    socklen_t optSz = sizeof(struct linger);
    sts = getsockopt (sock, SOL_SOCKET, SO_LINGER, (char *)&optVal, &optSz);
    assert((sts == SOCKET_ERROR) || (optSz == sizeof(struct linger)));
  } else {
    ctl = mlw_option_some(ctl);
    if (mlw_option_is_none(ctl)) {
      /* argument is SOME(NONE); disable linger */
      optVal.l_onoff = 0;
    } else {
      /* argument is SOME t; enable linger */
      optVal.l_onoff = 1;
      optVal.l_linger = CINT(mlw_option_some(ctl));
    }
    sts = setsockopt (sock, SOL_SOCKET, SO_LINGER, 
                      (char *)&optVal, sizeof(struct linger));
  }

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("get/setsockopt failed"), 0);
  else if (optVal.l_onoff == 0)
    return mlw_option_make_none();
  else 
    return mlw_option_make_some(MLINT(optVal.l_linger));
} /* end of ml_ctllinger */


static mlval ml_ctlbroadcast(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_BROADCAST);
}

static mlval ml_ctloobinline(mlval arg)
/* : (sockFD * bool option) -> bool */
{ 
  return sock_controlflg (arg, SO_OOBINLINE);
}

static mlval ml_ctlsndbuf(mlval arg)
/* : (sockFD * int option) -> int */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval ctl = FIELD(arg, 1);
  int   sz, sts;

  if (mlw_option_is_none(ctl)) {
    socklen_t optSz = sizeof(int);
    sts = getsockopt (sock, SOL_SOCKET, SO_SNDBUF, (char *)&sz, &optSz);
    assert((sts == SOCKET_ERROR) || (optSz == sizeof(int)));
  } else {
    sz = CINT(mlw_option_some(ctl));
    sts = setsockopt (sock, SOL_SOCKET, SO_SNDBUF, (char *)&sz, sizeof(int));
  }

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("get/setsockopt failed"), 0);
  else
    return MLINT(sz);
}

static mlval ml_setnbio(mlval arg)
/* : (sockFD * bool) -> unit */
{ 
  int n, sts;
  SOCKET sock = CINT(FIELD(arg, 0));

#ifdef USE_FCNTL_FOR_NBIO
  n = fcntl(F_GETFL, sock);
  if (n < 0)
    exn_raise_syserr(ml_string("fnctl failed"), 0);
  if (FIELD(arg, 1) == MLTRUE)
    n |= O_NONBLOCK;
  else
    n &= ~O_NONBLOCK;
  sts = fcntl(F_SETFL, sock, n);
#else
  n = (FIELD(arg, 1) == MLTRUE);
  sts = ioctl (sock, FIONBIO, (ioctl_type)&n);
#endif

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("ioctl failed"), 0);
  else
    return MLUNIT;
}

static mlval ml_getnread(mlval arg)
/* : sockFD -> int */
{ 
  int n, sts;

  sts = ioctl (CINT(arg), FIONREAD, (ioctl_type)&n);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("ioctl failed"), 0);
  else
    return MLINT(n);
}

static mlval ml_getatmark(mlval arg)
/* : sockFD -> bool */
{ 
  int n, sts;

  sts = ioctl (CINT(arg), SIOCATMARK, (ioctl_type)&n);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("ioctl failed"), 0);
  else if (n == 0)
    return MLFALSE;
  else
    return MLTRUE;
}

static mlval ml_ctlnodelay(mlval arg)
/* : (sock * bool option) -> bool */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval	ctl =  FIELD(arg, 1);
  int flg;
  int sts;

  if (mlw_option_is_none(ctl)) {
    socklen_t optSz = sizeof(int);
    sts = getsockopt (sock, IPPROTO_TCP, TCP_NODELAY, (char *)&flg, &optSz);
    assert((sts == SOCKET_ERROR) || (optSz == sizeof(int)));
  } else {
    flg = (int)CBOOL(mlw_option_some(ctl));
    sts = setsockopt (sock, IPPROTO_TCP, TCP_NODELAY, (char *)&flg, sizeof(int));
  }

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("setsockopt failed"), 0);
  else
    return (flg ? MLTRUE : MLFALSE);
}

static mlval ml_geterror(mlval arg)
/* : sockFD -> bool */
{ 
  SOCKET sock = CINT(arg);
  int flg, sts;
  socklen_t optSz = sizeof(int);

  sts = getsockopt (sock, SOL_SOCKET, SO_ERROR, (char *)&flg, &optSz);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("getsockopt failed"), 0);
  else
    return (flg ? MLTRUE : MLFALSE);
}


/* Socket properties accessor functions */

static mlval ml_gettype(mlval arg)
/* : sockFD -> CI.system_const */
{ 
  SOCKET sock = CINT(arg);
  int flg, sts;
  socklen_t optSz = sizeof(int);

  sts = getsockopt (sock, SOL_SOCKET, SO_TYPE, (char *)&flg, &optSz);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("getsockopt failed"), 0);
  else
    return find_sysconst (&_Sock_Type, flg);
}

static mlval ml_getpeername(mlval arg)
/* : sockFD -> addr */
{ 
  SOCKET  sock = CINT(arg);
  char addrBuf[MAX_SOCK_ADDR_SZB];
  socklen_t addrLen = MAX_SOCK_ADDR_SZB;
  int  sts;

  sts = getpeername (sock, (struct sockaddr *)addrBuf, &addrLen);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("getpeername failed"), 0);
  else {
    mlval result = allocate_string(addrLen + 1);
    memcpy(CSTRING(result), addrBuf, addrLen);
    CSTRING(result)[addrLen] = '\0';
    return(result);
  }
}

static mlval ml_getsockname(mlval arg)
/* : sockFD -> addr */
{ 
  SOCKET  sock = CINT(arg);
  char addrBuf[MAX_SOCK_ADDR_SZB];
  socklen_t addrLen = MAX_SOCK_ADDR_SZB;
  int  sts;

  sts = getsockname (sock, (struct sockaddr *)addrBuf, &addrLen);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("getsockname failed"), 0);
  else {
    mlval result = allocate_string(addrLen + 1);
    memcpy(CSTRING(result), addrBuf, addrLen);
    CSTRING(result)[addrLen] = '\0';
    return(result);
  }
}

static mlval ml_getaddrfamily(mlval arg)
/* : addr -> af */
{ 
  struct sockaddr *addr = (struct sockaddr *)CSTRING(arg);

  return find_sysconst (&_Sock_AddrFamily, ntohs(addr->sa_family));
}


/* Now comes the main socket functions */

static mlval ml_accept(mlval arg)
/* : int -> (int * addr) */
{ 
  SOCKET  sock = CINT(arg);
  char addrBuf[MAX_SOCK_ADDR_SZB];
  socklen_t addrLen = MAX_SOCK_ADDR_SZB;
  SOCKET newSock;

  newSock = accept (sock, (struct sockaddr *)addrBuf, &addrLen); 

  if (newSock == INVALID_SOCKET)
    exn_raise_syserr(ml_string("accept failed"), 0);
  else {
    mlval res;
    mlval addr = allocate_string(addrLen + 1);
    declare_root(&addr, 0);
    memcpy(CSTRING(addr), addrBuf, addrLen);
    CSTRING(addr)[addrLen] = '\0'; 
    res = allocate_record(2);
    FIELD(res, 0) = MLINT(newSock);
    FIELD(res, 1) = addr; 
    retract_root(&addr); 
    return res;
  }
}

static mlval ml_bind(mlval arg)
/* : (int * addr) -> unit */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval	addr = FIELD(arg, 1);
  int sts;

  sts = bind (sock, (struct sockaddr *)CSTRING(addr), 
                    LENGTH(GETHEADER(addr)));

  if (sts == SOCKET_ERROR) {
    exn_raise_syserr(ml_string("bind failed"), 0); }
  else 
    return MLUNIT;
}

static mlval ml_connect(mlval arg)
/* : (int * addr) -> unit */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval	addr = FIELD(arg, 1);
  int sts;

  sts = connect (sock, (struct sockaddr *)CSTRING(addr), 
                       LENGTH(GETHEADER(addr)));

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("connect failed"), 0);
  else 
    return MLUNIT;
}

static mlval ml_listen(mlval arg)
/* : (int * int) -> unit */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  int backlog = CINT(FIELD(arg, 1));
  int sts;

  sts = listen (sock, backlog);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("listen failed"), 0);
  else 
    return MLUNIT;
}

static mlval ml_close(mlval arg)
/* : int -> unit */
{ 
  int status;
  SOCKET fd = CINT(arg);

#ifdef _WIN32
  status = closesocket(fd);
#else
  status = close(fd);
#endif

  if (status == SOCKET_ERROR) {
    perror ("Whats going on...");
    exn_raise_syserr(ml_string("close failed"), 0); 
  } else
    return MLUNIT;
}

static mlval ml_shutdown(mlval arg)
/* : (int * int) -> unit */
{ 
  if (shutdown (CINT(FIELD(arg, 0)), CINT(FIELD(arg, 1))) == SOCKET_ERROR)
    exn_raise_syserr(ml_string("shutdown failed"), 0);
  else
    return MLUNIT;
}

static mlval ml_sendbuf(mlval arg)
/* : (int * w8vector * int * int * bool * bool) -> int 
 * Send data from the buffer; bytes is either a Word8Array.array, or
 * a Word8Vector.vector.  The arguemnts are: socket, data buffer, start
 * position, number of bytes, OOB flag, and don't_route flag.
 */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval buffer = FIELD(arg, 1);
  int	nbytes = CINT(FIELD(arg, 3));
  char	*data; 
  int	flgs, n;

  if (SECONDARY(GETHEADER(buffer)) == STRING)
    data = CSTRING(buffer) + CINT(FIELD(arg, 2));
  else
    data = (char *)CBYTEARRAY(buffer) + CINT(FIELD(arg, 2));

  /* initialize the flags */
  flgs = 0;
  if (FIELD(arg, 4) == MLTRUE) flgs |= MSG_OOB;
  if (FIELD(arg, 5) == MLTRUE) flgs |= MSG_DONTROUTE;

  n = send (sock, data, nbytes, flgs);

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("send failed"), 0);
  else
    return MLINT(n);
}

static mlval ml_sendbufto(mlval arg)
/* : (sock * w8vector * int * int * bool * bool * addr) -> int
 *
 * Send data from the buffer; bytes is either a Word8Array.array, or
 * a Word8Vector.vector.  The arguments are: socket, data buffer, start
 * position, number of bytes, OOB flag, don't_route flag, and destination address.
 */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  mlval buffer = FIELD(arg, 1);
  int   nbytes = CINT(FIELD(arg, 3));
  mlval	addr = FIELD(arg, 6);
  char	*data;
  int	flgs, n;

  if (SECONDARY(GETHEADER(buffer)) == STRING)
    data = CSTRING(buffer) + CINT(FIELD(arg, 2));
  else
    data = (char *)CBYTEARRAY(buffer) + CINT(FIELD(arg, 2));

  /* initialize the flags. */
  flgs = 0;
  if (FIELD(arg, 4) == MLTRUE) flgs |= MSG_OOB;
  if (FIELD(arg, 5) == MLTRUE) flgs |= MSG_DONTROUTE;

  n = sendto (
        sock, data, nbytes, flgs,
        (struct sockaddr *)CBYTEARRAY(addr), LENGTH(GETHEADER(addr)));

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("sendto failed"), 0);
  else
    return MLINT(n);
}

static mlval ml_recv(mlval arg)
/* : (int * int * bool * bool) -> w8vector 
 * The arguments are: socket, number of bytes, OOB flag and peek flag; the
 * result is the vector of bytes received.
 */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  int nbytes = CINT(FIELD(arg, 1));
  int flag = 0;
  mlval vec;
  int n;

  if (FIELD(arg, 2) == MLTRUE) flag |= MSG_OOB;
  if (FIELD(arg, 3) == MLTRUE) flag |= MSG_PEEK;

  /* allocate the vector; note that this might cause a GC */
  vec = allocate_string(nbytes + 1);

  n = recv (sock, CSTRING(vec), nbytes, flag);

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("recv failed"), 0);
  else if (n < nbytes) {
    mlval newvec;
    declare_root(&vec, 0);
    newvec = allocate_string(n+1);
    memcpy(CSTRING(newvec), CSTRING(vec), n);
    CSTRING(newvec)[n] = '\0';
    retract_root(&vec);
    return newvec;
  }
  else {
    CSTRING(vec)[nbytes] = '\0';
    return vec;
  }
}

static mlval ml_recvbuf(mlval arg)
/* : (int * w8array * int * int * bool * bool) -> int 
 * The arguments are: socket, data buffer, start position, number of
 * bytes, OOB flag and peek flag.
 */
{ 
  SOCKET sock = CINT(FIELD(arg, 0));
  char *start = (char *)CBYTEARRAY(FIELD(arg, 1)) + CINT(FIELD(arg, 2));
  int  nbytes = CINT(FIELD(arg, 3));
  int  flag = 0;
  int  n;

  if (FIELD(arg, 4) == MLTRUE) flag |= MSG_OOB;
  if (FIELD(arg, 5) == MLTRUE) flag |= MSG_PEEK;

  n = recv (sock, start, nbytes, flag);

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("recv failed"), 0);
  else
    return MLINT(n);
}

static mlval ml_recvfrom(mlval arg)
/* : (int * int * bool * bool) -> (w8vector * addr) 
 * The arguments are: socket, number of bytes, OOB flag and peek flag.  The
 * result is the vector of bytes read and the source address.
 */
{ 
  char	addrBuf[MAX_SOCK_ADDR_SZB];
  socklen_t addrLen = MAX_SOCK_ADDR_SZB;
  SOCKET sock = CINT(FIELD(arg, 0));
  int	nbytes = CINT(FIELD(arg, 1));
  int	flag = 0;
  mlval vec;
  int	 n;

  if (FIELD(arg, 2) == MLTRUE) flag |= MSG_OOB;
  if (FIELD(arg, 3) == MLTRUE) flag |= MSG_PEEK;

  /* allocate the vector; note that this might cause a GC */
  vec = allocate_string(nbytes + 1);

  n = recvfrom (
        sock, CSTRING(vec), nbytes, flag,
        (struct sockaddr *)addrBuf, &addrLen);

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("recv failed"), 0);
  else {
    mlval addr, res;
    declare_root(&vec, 0);
    addr = allocate_string(addrLen);
    memcpy(CSTRING(addr), addrBuf, addrLen);
    declare_root(&addr, 0);

    if (n < nbytes) {
      /* we need to correct the length in the descriptor */
      mlval newvec = allocate_string(n + 1);
      memcpy(CSTRING(newvec), CSTRING(vec), n);
      CSTRING(newvec)[n] = '\0';
      vec = newvec;
    } else {
      CSTRING(vec)[nbytes] = '\0';
    }

    res = allocate_record(2);
    FIELD(res, 0) = vec;
    FIELD(res, 1) = addr;
    retract_root(&addr);
    retract_root(&vec);
    return res;
  }
}

static mlval ml_recvbuffrom(mlval arg)
/* : (int * w8array * int * int * bool * bool) -> (int * addr) 
 * The arguments are: socket, data buffer, start position, number of
 * bytes, OOB flag and peek flag.  The result is number of bytes read and
 * the source address.
 */
{ 
  char addrBuf[MAX_SOCK_ADDR_SZB];
  socklen_t addrLen = MAX_SOCK_ADDR_SZB;
  SOCKET sock = CINT(FIELD(arg, 0));
  char *start = (char *)CBYTEARRAY(FIELD(arg, 1)) + CINT(FIELD(arg, 2));
  int  nbytes = CINT(FIELD(arg, 3));
  int  flag = 0;
  int  n;

  if (FIELD(arg, 4) == MLTRUE) flag |= MSG_OOB;
  if (FIELD(arg, 5) == MLTRUE) flag |= MSG_PEEK;

  n = recvfrom (sock, start, nbytes, flag, (struct sockaddr *)addrBuf, &addrLen);

  if (n == SOCKET_ERROR)
    exn_raise_syserr(ml_string("recvfrom failed"), 0);
  else {
    mlval addr = allocate_string(addrLen + 1);
    mlval res;
    declare_root(&addr, 0);
    memcpy(CSTRING(addr), addrBuf, addrLen);
    CSTRING(addr)[addrLen] = '\0';
    res = allocate_record(2);
    FIELD(res, 0) = MLINT(n);
    FIELD(res, 1) = addr;
    retract_root(&addr);
    return res;
  }
}

static mlval ml_socket(mlval arg)
/* : (int * int * int) -> sock */
{ 
  int	 domain = CINT(FIELD(arg, 0));
  int	 type = CINT(FIELD(arg, 1));
  int	 protocol = CINT(FIELD(arg, 2));
  SOCKET sock;

  sock = socket (domain, type, protocol);
  if (sock == INVALID_SOCKET)
    exn_raise_syserr(ml_string("socket failed"), 0);
  else
    return MLINT(sock);
}

static mlval ml_socketpair(mlval arg)
/* : (int * int * int) -> (sock * sock) */
{ 
#ifdef _WIN32
  exn_raise_syserr(ml_string("socketPair not implemented on Windows"), 0);
  return MLUNIT;
#else
  int domain = CINT(FIELD(arg, 0));
  int type = CINT(FIELD(arg, 1));
  int protocol = CINT(FIELD(arg, 2));
  int sts, sock[2];

  sts = socketpair (domain, type, protocol, sock);

  if (sts == SOCKET_ERROR)
    exn_raise_syserr(ml_string("socketpair failed"), 0);
  else {
    mlval res = allocate_record(2);
    FIELD(res, 0) = MLINT(sock[0]);
    FIELD(res, 1) = MLINT(sock[1]);
    return res;
  }
#endif
}


/* Finally some conversion functions to/from addresses */

static mlval ml_tounixaddr(mlval arg)
/* : string -> PreSock.addr */
{ 
#ifdef _WIN32
  exn_raise_syserr(ml_string("toUnixAddr not implemented on Windows"), 0);
  return MLUNIT;
#else
  char *path = CSTRING(arg);
  struct sockaddr_un addr;
  int len;
  mlval result;

  memset(&addr, 0, sizeof(struct sockaddr_un));

  addr.sun_family = AF_UNIX;
  strcpy (addr.sun_path, path);
#ifdef SOCKADDR_HAS_LEN
  len = strlen(path)+sizeof(addr.sun_len)+sizeof(addr.sun_family)+1;
  addr.sun_len = len;
#else
  len = strlen(path)+sizeof(addr.sun_family);
#endif

  result = allocate_string(len + 1);
  memcpy(CSTRING(result), &addr, len);
  CSTRING(result)[len] = '\0';
  return(result);
#endif
}

static mlval ml_fromunixaddr(mlval arg)
/* : PreSock.addr -> string */
{ 
#ifdef _WIN32
  exn_raise_syserr(ml_string("fromUnixAddr not implemented on Windows"), 0);
  return MLUNIT;
#else
  struct sockaddr_un *addr = (struct sockaddr_un *)CSTRING(arg);

  assert(addr->sun_family == AF_UNIX);

  return ml_string(addr->sun_path);
#endif
}

static mlval ml_toinetaddr(mlval arg)
/* : (in_addr * int) -> addr */
{ 
  struct sockaddr_in addr;
  mlval result;
  int len = sizeof(struct sockaddr_in);
  memset(&addr, 0, len);

  addr.sin_family = (short)AF_INET;
  memcpy (&addr.sin_addr, CSTRING(FIELD(arg, 0)), sizeof(struct in_addr));
  addr.sin_port = htons((short)CINT(FIELD(arg, 1)));

  result = allocate_string(len + 1);
  memcpy(CSTRING(result), &addr, len);
  CSTRING(result)[len] = '\0';
  return(result);
}

static mlval ml_frominetaddr(mlval arg)
/* : addr -> (in_addr * int) */
{ 
  struct sockaddr_in *addr = (struct sockaddr_in *)CSTRING(arg);
  mlval inAddr, res;
  int len = sizeof(struct sockaddr_in);

  assert (addr->sin_family == AF_INET);

  inAddr = allocate_string(len + 1);
  memcpy(CSTRING(inAddr), &(addr->sin_addr), len);
  CSTRING(inAddr)[len] = '\0';
  declare_root(&inAddr, 0);

  res = allocate_record(2);
  FIELD(res, 0) = inAddr;
  FIELD(res, 1) = MLINT(ntohs(addr->sin_port));
  retract_root(&inAddr);
  return res;
}

static mlval ml_inetany(mlval arg)
/* : int -> addr */
{ 
  struct sockaddr_in addr;
  mlval result = MLUNIT;
  int len = sizeof(struct sockaddr_in);

  memset(&addr, 0, len);

  addr.sin_family = AF_INET;
  addr.sin_addr.s_addr = htonl(INADDR_ANY);
  addr.sin_port = htons((short)CINT(arg));

  result = allocate_string(len + 1);
  memcpy(CSTRING(result), &addr, len);
  CSTRING(result)[len] = '\0';
  return(result);
}

extern void sockets_init(void)
{
  env_function("system os getServByName", ml_getservbyname);
  env_function("system os getServByPort", ml_getservbyport);
  env_function("system os getHostByName", ml_gethostbyname);
  env_function("system os getHostByAddr", ml_gethostbyaddr);
  env_function("system os getNetByName", ml_getnetbyname);
  env_function("system os getNetByAddr", ml_getnetbyaddr);
  env_function("system os getProtByName", ml_getprotbyname);
  env_function("system os getProtByNum", ml_getprotbynum);
  env_function("system os getHostName", ml_gethostname);
  env_function("system os toUnixAddr", ml_tounixaddr);
  env_function("system os fromUnixAddr", ml_fromunixaddr);
  env_function("system os sendBuf", ml_sendbuf);
  env_function("system os sendBufTo", ml_sendbufto);
  env_function("system os recv", ml_recv);
  env_function("system os recvBuf", ml_recvbuf);
  env_function("system os recvFrom", ml_recvfrom);
  env_function("system os recvBufFrom", ml_recvbuffrom);
  env_function("system os socket", ml_socket);
  env_function("system os socketPair", ml_socketpair);
  env_function("system os toInetAddr", ml_toinetaddr);
  env_function("system os fromInetAddr", ml_frominetaddr);
  env_function("system os inetany", ml_inetany);
  env_function("system os ctlNODELAY", ml_ctlnodelay);
  env_function("system os listAddrFamilies", ml_listaddrfamilies);
  env_function("system os listSockTypes", ml_listsocktypes);
  env_function("system os ctlDEBUG", ml_ctldebug);
  env_function("system os ctlREUSEADDR", ml_ctlreuseaddr);
  env_function("system os ctlKEEPALIVE", ml_ctlkeepalive);
  env_function("system os ctlDONTROUTE", ml_ctldontroute);
  env_function("system os ctlLINGER", ml_ctllinger);
  env_function("system os ctlBROADCAST", ml_ctlbroadcast);
  env_function("system os ctlOOBINLINE", ml_ctloobinline);
  env_function("system os ctlSNDBUF", ml_ctlsndbuf);
  env_function("system os getTYPE", ml_gettype);
  env_function("system os getERROR", ml_geterror);
  env_function("system os getPeerName", ml_getpeername);
  env_function("system os getSockName", ml_getsockname);
  env_function("system os setNBIO", ml_setnbio);
  env_function("system os getNREAD", ml_getnread);
  env_function("system os getATMARK", ml_getatmark);
  env_function("system os getAddrFamily", ml_getaddrfamily);
  env_function("system os accept", ml_accept);
  env_function("system os bind", ml_bind);
  env_function("system os connect", ml_connect);
  env_function("system os listen", ml_listen);
  env_function("system os close", ml_close);
  env_function("system os shutdown", ml_shutdown);
  env_function("system os fdToIOD", ml_fdtoiod);
}
