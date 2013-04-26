/* $HopeName: $
 *
 */

#ifndef _inc_lsfile
#define _inc_lsfile

/* data unique to each permit file read. NB may not be initialised if file rejected */

struct pfiledat {
  uint32      permit_id;              /* unique permit file id */
  int32       version;                /* version of permit */
  char        *lockstring;            /* server permit data */
  /* char        *path;         */         /* full path of this file */
  FwTextString path;                  /* full path of this file */
  int32       errcode;                /* code of first error that occurred */
  int32       value;                  /* any value associated with errcode */
} ;

typedef struct pfiledat pfiledat;

#endif
