/*  ==== ML TYPES ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
