/*  ==== ML TYPES ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  $Id: mltypes.h,v 1.4 1994/12/05 15:14:50 jont Exp $
 */


#ifndef mltypes_h
#define mltypes_h

#include "types.h"

#include <stddef.h>


/*  == ML value type ==
 *
 *  ML values are tagged 32-bit words.
 */

typedef word mlval;


/*  == ML array header ==
 *
 *  Since ML arrays are updatable they must be chained together so that
 *  pointers to information younger than the array itself can be fixed if
 *  that data is moved.  The first three words of each ML array object
 *  correspond to the ml_array_header union below.
 */

union ml_array_header
{
  struct
  {
    word header;
    union ml_array_header *forward;
    union ml_array_header *back;
    mlval element[1];		/* the elements of the array */
  } the;
};

/*  == Code vector headers ==
 *
 *  A code vector begins with a garbage-collectible field pointing the
 *  the ancillary (see tags.h). Code items within a code vector have
 *  some extra fields immediately before the actual code.
 */

struct code_vector_header
{
  mlval header;
  mlval ancillary;
  word contents[1];
};

struct code_item_header
{
  mlval header;
  mlval ancill;			/* Ancillary field */
  word instruction[1];		/* the instructions */
};

#endif
