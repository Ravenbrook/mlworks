/* $HopeName: $
 *
 */

#ifndef LSRPC_ST
#define LSRPC_ST

#include "lsfile.h"

#ifndef UNIX
typedef unsigned int u_int;
#endif

struct ls_challenge_in {
  uint32 reserved;
  uint32 secret;
  struct {
    u_int data_len;
    uint8 *data_val;
  } data;
};
typedef struct ls_challenge_in ls_challenge_in;

struct ls_challenge_out {
  char data[16];
};
typedef struct ls_challenge_out ls_challenge_out;

struct ls_node_info {
  uint32 hostid;
  uint32 iaddr;
  uint32 pid;
  uint32 time;
};
typedef struct ls_node_info ls_node_info;


struct ls_domain {
  struct {
    u_int size;             /* size of this domain */
    uint32 *addr;           /* domain = array of inet addresses */
  } members;
  uint32 state;                   /* server's state flags in this domain */
  uint32 ncontacts;               /* contact count for masters */
  int32   who;                    /* server's index in this domain or -1 */
  int32   master;                 /* index of current acting master in domain */
};
typedef struct ls_domain ls_domain;


struct ls_hqn_state {
  struct {
    u_int len;              /* number of domains held by server */
    ls_domain *dom;         /* -> array of domains */
  } domlist;
};
typedef struct ls_hqn_state ls_hqn_state;


struct ls_request_in {
  char *license_system;
  char *publisher_name;
  char *product_name;
  char *product_version;
  uint32 units_required;
  ls_node_info node;
  char *log_comment;
  uint32 flags;
  ls_challenge_in challenge;
};
typedef struct ls_request_in ls_request_in;


struct ls_request_out {
  uint32 status;
  uint32 units;
  uint32 handle;
  ls_domain *domain;
  ls_challenge_out challenge;
};
typedef struct ls_request_out ls_request_out;


struct ls_update_in {
  uint32 handle;
  uint32 units_consumed;
  int32 units_required;
  ls_node_info node;
  char *log_comment;
  ls_challenge_in challenge;
};
typedef struct ls_update_in ls_update_in;


struct ls_update_out {
  uint32 status;
  uint32 units_available;
  ls_challenge_out challenge;
};
typedef struct ls_update_out ls_update_out;

struct ls_release_in {
  uint32 handle;
  uint32 units;
  ls_node_info node;
  char *log_comment;
};
typedef struct ls_release_in ls_release_in;


struct ls_query_in {
  uint32 handle;
  ls_node_info node;
  uint32 infotype;
  uint32 bufsize;
};
typedef struct ls_query_in ls_query_in;


struct ls_query_out {
  uint32 status;
  uint32 value;
  struct {
    u_int data_len;
    char *data_val;
  } data;
};
typedef struct ls_query_out ls_query_out;


struct ls_verify_data {
  int who;                /* hqnserver index = 1 upwards */
  ls_hqn_state *data;
};
typedef struct ls_verify_data ls_verify_data;

struct ls_msg_out {
  uint32 status;
  char *msg;
};
typedef struct ls_msg_out ls_msg_out;

struct ls_admin_in {
  uint32 func;
  uint32 data[4];
};
typedef struct ls_admin_in ls_admin_in;

struct ls_server_data {
  char *license_system;
  int32 nservers;
  int32 nproducts;
  int32 nexproducts;
  int32 logflags;
  ls_hqn_state *state;
  struct {
    uint32 pfiles_len;
    pfiledat *pfiles_val;
  } pfiles;
};
typedef struct ls_server_data ls_server_data;

struct ls_product_data {
  struct {
    uint32 pub_len;
    char *pub_val;
  } pub;
  struct {
    uint32 prod_len;
    char *prod_val;
  } prod;
  struct {
    uint32 vers_len;
    char *vers_val;
  } vers;
  char *pfile;
  ls_domain *domain;
  uint32 policy;
  int32 nlocklic;
  int32 nlockleft;
  int32 nflotlic;
  int32 nflotleft;
  int32 start;
  int32 end;
  uint32 crashout;
  uint32 timeout;
  struct {
    uint32 nodes_len;
    locknode *nodes_val;
  } nodes;
  struct {
    uint32 exc_len;
    uint32 *exc_val;
  } exc;
  struct {
    uint32 user_len;
    int32 *user_val;
  } user;
  struct {
    uint32 ulev_len;
    level *ulev_val;
  } ulev;
  struct {
    uint32 glev_len;
    level *glev_val;
  } glev;
};
typedef struct ls_product_data ls_product_data;

struct ls_admin_out {
  int32 type;
  union {
    int32 status;
    ls_product_data product;
    struct {
      uint32 users_len;
      licensep *users_val;
    } users;
    ls_server_data server;
    uint32 value;
  } ls_admin_out_u;
};
typedef struct ls_admin_out ls_admin_out;


#endif
