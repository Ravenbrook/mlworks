/*
 * endian.c
 * Handle endian change requirements.
 * $Log: endian.c,v $
 * Revision 1.4  1996/02/14 10:09:49  jont
 * Change type of a loop variable to avoid compiler warnings under VC++
 *
 * Revision 1.3  1994/10/03  14:14:33  jont
 * Fix change_endian to work correctly
 *
 * Revision 1.2  1994/06/09  14:34:10  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:59:34  nickh
 * new file
 *
 * Revision 1.6  1992/05/12  15:13:01  jont
 * Changed to allow old or new magic numbers (will later lose old one)
 *
 * Revision 1.5  1992/03/17  14:27:57  richard
 * Changed error behaviour and tidied up.
 *
 * Revision 1.4  1991/10/21  09:34:13  davidt
 * change_endian now changes a number of words (this is so that we can
 * call change_endian on a complete piece of code).
 *
 * Revision 1.3  91/10/18  16:14:48  davidt
 * loader_error now takes 3 arguments.
 * 
 * Revision 1.2  91/10/17  16:58:21  davidt
 * Moved MAGIC_ENDIAN into objectfile.h and tidied up a bit,
 * including doing the renaming of types to come into line
 * with the rest of the run-time system.
 * 
 * Revision 1.1  91/05/14  11:11:04  jont
 * Initial revision
 * 
 * Copyright (c) Harlequin 1991.
 */

#include "types.h"
#include "endian.h"
#include "objectfile.h"

/*
 * Either change == ENDIAN_OK or change == WRONG_ENDIAN
 * with the obvious meanings.
 */

#define ENDIAN_OK	0
#define WRONG_ENDIAN	1

static int change = ENDIAN_OK;

/*
 * Check if we need to change endian.
 */

int find_endian(word magic)
{
  switch(magic)
  {
    case OLD_GOOD_MAGIC:
    case GOOD_MAGIC:
    change = ENDIAN_OK;
    return(1);

    case NOT_SO_GOOD_MAGIC:
    change = WRONG_ENDIAN;
    return(1);
    break;
  }

  return(0);
}

/*
 * Change the endianness of a number of words.
 */

void change_endian (word *words, size_t length)
{
  if(change == WRONG_ENDIAN)
  {
    char *ptr = (char *)words;
    int temp;
    unsigned loop;
    for (loop=0; loop<length; ++loop)
    {
      temp = ptr[0];
      ptr[0] = ptr[3];
      ptr[3] = temp; /* The outside pair */
      temp = ptr[1];
      ptr[1] = ptr[2];
      ptr[2] = temp; /* The middle pair */
      ptr += 4;
    }
  }
}
