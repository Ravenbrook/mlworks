/* $HopeName: $
 *
 * $Log: comline.h,v $
 * Revision 1.3  1999/01/04 09:02:55  jamesr
 * [Bug #30447]
 * modifications for NT
 *
 * Revision 1.2  1994/05/17  21:51:49  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
1992-Nov-2-13:10 chrism = Created
1992-Oct-21-18:58 chrism = Created

*/
#ifndef _COMLINE_H
#define _COMLINE_H

#include "fwstream.h" /* FwObj */

/* error codes from command_line */

#define CL_FUNCERR -1
#define CL_BADOP   -2

/* defines for readline */

#define RL_EOF	   -1
#define RL_MAX_LINE 128

/**************************************
  
   input parameters: func( argv, cp, val )
         char **argv = ptr to ptr to next parameter in command line
         com_pair *cp = ptr to this function's com_pair
	 long val = 0 when called from command_line

   output: number of extra parameters consumed by this option
           return negative value if error
	   
***************************************/

typedef struct {
    char *op;
    int  (*func)();
    void *data;
} com_pair;

/*---- macros -----*/

#define sizearray( array ) (sizeof(array)/sizeof((array)[0]))

int      command_line(char **argv, int argc, com_pair *op_list, int size);
com_pair *com_check(char *op, com_pair *cp, int size);

int 	 readline( FwObj       *pDataStream,
		   FwStrRecord *pPermit,
		   int32       *data,
		   int         *icount, 
		   int         wcount,
		   FwRawByte  **wstore);

#endif
