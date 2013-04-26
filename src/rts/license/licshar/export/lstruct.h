/* $HopeName: $
 *
 */

#ifndef _LSTRUCT_H
#define _LSTRUCT_H

/* NB these structures are transmitted and use XDR routines
* If changed the XDR routines must be changed also.
* These really belong in lsrpc.h but it's more convenient to
* have them here.
*
* NB These structures also correspond to user visible structures on
* the client side in lsapi.h. These must also reflect any changes here.
*/

typedef struct {
  uint32 hostid, iaddr;
} addrs;

typedef struct {
  addrs       addr;
  uint32      nlic;  /* count of licenses on this locked node */
} locknode;

/* associated uid or gid with access level */

typedef struct {
  int32       id;
  uint16      level;
} level;

/* license flags */

#define LIC_TYPE        0x10
#define LIC_LOCKED      0x10
#define LIC_FLOAT       0
#define LIC_LEVEL       0x0f
#define LIC_USER_LOCKED 0x20
#define LIC_DUPLICATE   0xffffffff

/* access levels */

#define MAX_ACCESS      8
#define MIN_ACCESS      0  /* level 0 gives NO access i.e. no licence issued */

/* a license */

typedef struct {
  addrs       node;
  uint32      flags;  /* type of license (NB floats can be on locked nodes )*/
  int32       inode;  /* if locked node = index into lock_list, else -1  */
  int32       uid;
  uint32      pid;
  uint32      start;
  uint32      last;
} license;

typedef license *licensep;

/* structures used to pass user info back to clients */

#ifdef UNIX

struct ls_users_out {
  uint32 status;
  struct {
    u_int users_len;
    license **users_val;
  } users;
};

typedef struct ls_users_out ls_users_out;

#endif

#endif
