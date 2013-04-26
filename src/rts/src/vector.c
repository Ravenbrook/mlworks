/*  ==== PERVASIVE VECTOR ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: vector.c,v $
 *  Revision 1.4  1998/02/23 18:43:49  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.3  1994/08/11  11:17:39  matthew
 * Use allocate_vector for making a vector -- Vector.length doesn't like pairs
 *
 * Revision 1.2  1994/06/09  14:55:01  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:31:27  nickh
 * new file
 *
Revision 1.2  1993/04/19  16:19:09  jont
Removed superfluous erroneous attempt to take head of list, which
caused bus error when list was empty

Revision 1.1  1993/03/22  19:09:00  jont
Initial revision

 *
 */

#include "vector.h"
#include "mltypes.h"
#include "values.h"
#include "allocator.h"
#include "environment.h"
#include "gc.h"

static mlval ml_vector(mlval argument) {
  size_t length = 0, i;
  mlval list, result;

  for(list = argument; list != MLNIL; list = MLTAIL(list))
    length++;

  declare_root(&argument, 0);
  result = allocate_vector(length);
  for(list = argument, i = 0; list != MLNIL; list = MLTAIL(list), i++) {
    FIELD(result, i) = MLHEAD(list);
  }
  retract_root(&argument);
  return result;
}

void vector_init()
{
  env_function("vector", ml_vector);
}
