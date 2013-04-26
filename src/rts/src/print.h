/*  ==== RUNTIME VALUE PRINTER ====
 *
 *  Copyright (C) 1993 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  The value printer uses runtime tagging information to print ML objects.
 *  This is a crucial tool for debugging.
 *
 *  Revision Log
 *  ------------
 *  $Log: print.h,v $
 *  Revision 1.3  1995/03/28 12:57:58  nickb
 *  Add printing on the message stream.
 *
 * Revision 1.2  1994/06/09  14:45:35  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:15:04  nickh
 * new file
 *
 *  Revision 1.1  1993/04/21  12:59:45  richard
 *  Initial revision
 *
 */

#ifndef print_h
#define print_h


#include "mltypes.h"

struct print_options
{
  size_t depth_max;		/* zero for no limit */
  size_t string_length_max;	/* zero for no limit */
  int indent;			/* indented layout */
  int tags;			/* show tagging information */
};

struct print_options print_defaults;

void print(struct print_options *options, FILE *stream, mlval value);

void message_print (struct print_options *options, mlval value);

#endif
