/*  ==== PERVASIVE VECTOR ====
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
