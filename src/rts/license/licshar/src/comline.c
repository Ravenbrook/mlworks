/* $HopeName: $
 *
 * $Log: comline.c,v $
 * Revision 1.7  1999/01/04 09:03:05  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.6  1996/04/19  16:44:24  markt
 * [Bug #7857]
 * remove verbatim bracket-style comments from changelog (!!)
 *
 * Revision 1.5  1996/04/19  14:58:27  markt
 * [Bug #7857]
 * mismatched bracket-style C comments cause Irix6 compiler to complain
 *
 * Revision 1.4  1994/05/17  21:50:46  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
 *    1993-Jul-21-12:35 chrism
 *      readline now returns if blank line
1992-Nov-13-18:45 chrism = added check for interrupted system call
1992-Nov-2-13:07 chrism = Created
1992-Oct-21-18:58 chrism = Created

*/

#define FWSTREAM_ALLOW_DEPRECATED

#include <string.h>
#include <stdio.h>
#include <errno.h>
#include "comline.h"

int command_line(char **argv, int argc, com_pair *op_list, int size)
{
  char        *progname, *cptr;
  com_pair    *cp;
  int         used, total = 0;
  
  progname = *argv++;
        
  for( total = 0; total < argc-1; ++total){
    cptr = *argv++;
    if(  *cptr++  == '-' ){
      if( cp = com_check( cptr, op_list, size)){
	if( (used = (*cp->func)( argv, cp, 0L )) < 0 ) return CL_FUNCERR;
	total += used;
	argv += used;
      } else {                            /* undefined op in list */
	fprintf( stderr, "%s: undefined option '-%s'\n", progname, cptr );
	return CL_BADOP;
      }   
    } else {  /* parameter without option flag found */
      break;
    }
  }
  return total;       /* parsed ok */
}

com_pair * com_check(char *op, com_pair *cp, int size)
{
  while( size--){
    if(! strcmp( op, cp->op)) return cp;
    ++cp;
  }
  return (com_pair*) 0;
}

/* readline implemented in licserc:src:readperm.c */
