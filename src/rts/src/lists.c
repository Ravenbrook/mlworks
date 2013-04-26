/*  ==== PERVASIVE LISTS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: lists.c,v $
 *  Revision 1.3  1998/02/23 18:17:45  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.2  1994/06/09  14:38:05  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:05:13  nickh
 * new file
 *
 *  Revision 1.5  1993/02/01  16:13:18  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.4  1993/01/14  14:59:27  daveb
 *  Temporary disabling assembler version of append, pending debugging
 *  of new version.
 *
 *  Revision 1.3  1993/01/14  13:16:18  daveb
 *  Changed definition of append to use new representation of lists.
 *
 *  Revision 1.2  1992/11/25  15:46:10  clive
 *  Added an assembler routine to do append
 *
 *  Revision 1.1  1992/10/23  16:15:44  richard
 *  Initial revision
 *
 */


#include "lists.h"
#include "mltypes.h"
#include "values.h"
#include "environment.h"
#include "gc.h"
#include "allocator.h"

static mlval first, second, tmp;

/*  == Append lists ==
 *
 *  This function could be written in ML, but is included here for
 *  efficiency.  It is rather sneaky.
 *
 *  It makes two passes over the first list.  On the first pass it attaches
 *  a list of MLUNITs to the front of the second list.  On the second pass
 *  it fills the new cells in with the contents of the first list.  It it
 *  alright to update the new cells because they are guaranteed to be
 *  younger than anything else.
 */

#define CONS_SIZE 2

static mlval append(mlval argument)
{
  mlval t, r;
  size_t length = 0;

  first = FIELD(argument, 0);
  second = FIELD(argument, 1);

  for(tmp = first; tmp != MLNIL; tmp = MLTAIL(tmp))
    length++;

  while(length > 0)
  {
    mlval *multiple_allocation;
    int multiple_allocated =
	  allocate_multiple(CONS_SIZE,length,&multiple_allocation);

    if(multiple_allocated)
    {
      length -= multiple_allocated;
      for(; multiple_allocated > 0;
	  multiple_allocated--, multiple_allocation += CONS_SIZE)
      {
	multiple_allocation[0] = MLUNIT;
	multiple_allocation[1] = second;
	second = MLPTR(PAIRPTR, &multiple_allocation[0]);
      }
    }
    else	
    {
      length--;
      tmp = allocate_record(2);
      FIELD(tmp, 0) = MLUNIT;
      FIELD(tmp, 1) = second;
      second = tmp;
    }
  }

  for(r = first, t = second; r != MLNIL; r = MLTAIL(r), t = MLTAIL(t))
    MLHEAD(t) = MLHEAD(r);

  t = second;
  first = second = tmp = MLUNIT;

  return(t);
}


/*  === INITIALISE ===  */

void lists_init()
{
  first = second = tmp = MLUNIT;
  declare_root(&first, 0);
  declare_root(&second, 0);
  declare_root(&tmp, 0);

  env_function("list append", append);
}
