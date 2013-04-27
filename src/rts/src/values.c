/*  ==== ML VALUE TOOLS ====
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
 *  $Log: values.c,v $
 *  Revision 1.7  1998/02/23 18:43:36  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.6  1996/08/27  13:41:14  stephenb
 * mlupdate: change the type of subscript argument to a word
 * so it is less likely that someone will pass an MLINT as
 * a subscript rather than a plain C int.
 *
 * Also took the opportunity to rename mlupdate -> mlw_update
 * in line with rolling program to have "mlw" prefix on all
 * external symbols.
 *
 * Revision 1.5  1996/07/10  09:38:46  stephenb
 * Add some documentation to cons and update the mlw_option_make_some
 * description to indicate that the argument is now declared/retracted
 * as a root by mlw_option_make_some.
 *
 * Revision 1.4  1996/05/10  10:59:27  stephenb
 * mlw_option_make_some: fix so that it returns the constructed value not
 * the argument!
 *
 * Revision 1.3  1996/05/07  09:10:44  stephenb
 * Add support for Option type.
 *
 * Revision 1.2  1994/06/09  14:48:31  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:21:00  nickh
 * new file
 *
 *  Revision 1.29  1993/04/19  13:08:12  richard
 *  Removed rusty value printer.  (Now in print.c.)
 *
 *  Revision 1.28  1993/02/04  12:32:02  jont
 *  Changes for code vector reform.
 *
 *  Revision 1.27  1993/02/01  16:04:20  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.26  1993/01/14  14:52:32  daveb
 *  Changed cons to use the new list representation.
 *
 *  Revision 1.25  1992/10/29  11:11:21  richard
 *  Fixed some mistakes in string output.
 *
 *  Revision 1.24  1992/08/24  15:20:27  richard
 *  Corrected the printing of bytearrays and reals.
 *
 *  Revision 1.23  1992/08/24  10:52:14  richard
 *  Corrected printing of bytearrays.
 *
 *  Revision 1.22  1992/07/27  17:38:45  richard
 *  Added exn_name(), exn(), and ref().
 *
 *  Revision 1.21  1992/07/22  15:30:33  clive
 *  Weak array printing
 *
 *  Revision 1.20  1992/07/20  13:30:36  richard
 *  Removed storage manager specific stuff from value printing.
 *
 *  Revision 1.19  1992/07/15  15:35:33  richard
 *  Corrected mlupdate.
 *
 *  Revision 1.18  1992/07/01  13:21:54  richard
 *  Added mlupdate().
 *
 *  Revision 1.17  1992/03/25  09:50:09  richard
 *  Improved polymorphic equality function.
 *
 *  Revision 1.16  1992/03/20  15:24:37  richard
 *  Added code to val_print() to deal with shared closures.
 *
 *  Revision 1.15  1992/03/18  13:32:02  richard
 *  Generalised parameter mechanism to val_print().
 *
 *  Revision 1.14  1992/03/11  12:37:50  richard
 *  Miscellaneous minor improvements and changes to printing to deal with
 *  the new memory arrangement.
 *
 *  Revision 1.13  1992/03/06  16:13:14  clive
 *  Equality for strings was also checking the nulls, but there is currently some
 *  error so that some strings are not null terminated
 *
 *  Revision 1.12  1992/03/06  14:33:10  clive
 *  equality for strings now uses memcmp
 *
 *  Revision 1.11  1992/02/27  11:04:20  clive
 *   Needed to use declare_root around calls to allocate in case a garbage collection was
 *  forced
 *
 *  Revision 1.10  1992/02/25  15:48:45  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.9  1992/02/17  11:15:25  richard
 *  Added parameters to string_print() to limit the length of strings.
 *  Added other cases to tuple printing to spot records on the stack and outside
 *  the heap.
 *  Added a missing `break' after array printing.
 *
 *  Revision 1.8  1992/02/14  17:08:22  richard
 *  Added extra debugging information to val_print.  This is switched on with the
 *  `-i' option.  (See main.c)
 *
 *  Revision 1.7  1992/01/20  15:35:25  richard
 *  Modified polymorphic equality to work with REFPTRs.
 *
 *  Revision 1.6  1992/01/16  14:11:38  richard
 *   Changed the way that arrays are printed, as the primary tag for an array
 *  is now REFPTR.
 *
 *  Revision 1.5  1992/01/14  15:51:12  richard
 *  Added BACKPTR to the printing routine.
 *
 *  Revision 1.4  1991/12/23  13:18:38  richard
 *  Added some missing #include's.  Added void casts to some
 *  unused results.
 *
 *  Revision 1.3  91/12/17  14:03:48  richard
 *  Removed debugging code and added printing of reals.
 *  Added pointer equality as a short cut.
 *  
 *  Revision 1.2  91/12/16  11:02:18  richard
 *  Wrote polymorphic equality and list cons.
 *  
 *  Revision 1.1  91/12/13  16:15:50  richard
 *  Initial revision
 *  
 */


#include "mltypes.h"
#include "gc.h"
#include "values.h"
#include "allocator.h"
#include "utils.h"
#include "diagnostic.h"
#include "state.h"

#include <stdio.h>
#include <ctype.h>
#include <string.h>


/*  == Update an array element ==
 *
 *  An updated array needs to be unlinked from its entry list and linked to
 *  the modified list.
 */

void mlw_update(mlval a, word subscript, mlval value)
{
  union ml_array_header *array = (union ml_array_header *)(a-REFPTR);

  if(array->the.forward != NULL)
  {
    if(array->the.back != NULL)
    {
      array->the.forward->the.back = array->the.back;
      array->the.back->the.forward = array->the.forward;
    }
    array->the.forward = NULL;
    array->the.back = GC_MODIFIED_LIST;
    GC_MODIFIED_LIST = array;
  }

  array->the.element[subscript] = value;
}


/*  === LIST CONSTRUCTOR ===  */


/* If you are tempted to remove the declare/retract roots in the
 * following, then think again.  They must be there as they
 * are here protect the head and tail values in this function
 * against movement not the head and tail values as seen by
 * the caller.
 *
 * This comment is true for other functions that
 * allocate and so they refer to this one rather than repeating
 * the explanation.  Therefore if you update this one, try and make
 * sure it is still valid for them too (to find them search for
 * a reference to mlw_cons).
 */
mlval mlw_cons(mlval head, mlval tail)
{
  mlval result;

  declare_root(& head, 0);
  declare_root(& tail, 0);
  result = allocate_record(2);
  retract_root(& head);
  retract_root(& tail);

  FIELD(result, 0) = head;
  FIELD(result, 1) = tail;

  return(result);
}



/*  == Make an exception name ==
 *
 *  An ML exception name is a pair consisting of a unique (ref unit) and a
 *  string.
 */

mlval exn_name(const char *name)
{
  mlval exn_name, unique, string;

  unique = allocate_array(1);
  MLUPDATE(unique, 0, MLUNIT);
  declare_root(&unique, 0);
  string = ml_string(name);
  declare_root(&string, 0);
  exn_name = allocate_record(2);
  FIELD(exn_name, 0) = unique;
  FIELD(exn_name, 1) = string;
  retract_root(&string);
  retract_root(&unique);

  return(exn_name);
}



/*  == Make an exception packet ==
 *
 *  An exception packet is a pair consisting of an exception name and its
 *  argument.
 */

mlval exn(mlval exn_name, mlval arg)
{
  mlval exn;

  declare_root(&exn_name, 0);
  declare_root(&arg, 0);
  exn = allocate_record(2);
  FIELD(exn, 0) = exn_name;
  FIELD(exn, 1) = arg;
  retract_root(&arg);
  retract_root(&exn_name);

  return(exn);
}




/* See mlw_cons comment as to why the declare/retract roots
 * are necessary here.
 */
mlval mlw_ref_make(mlval value)
{
  mlval r;

  declare_root(&value, 0);
  r= allocate_array(1);
  retract_root(&value);
  mlw_update(r, 0, value);

  return r;
}




/* See mlw_cons comment as to why the declare/retract roots
 * are necessary here.
 */
mlval mlw_option_make_some(mlval arg)
{
  mlval some;
  declare_root(&arg, 0);
  some= allocate_record(2);
  FIELD(some, 0)= MLINT(1);
  FIELD(some, 1)= arg;
  retract_root(&arg);
  return some;
}
