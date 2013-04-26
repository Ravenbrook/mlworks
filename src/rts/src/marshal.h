/*  ==== MARSHALLING ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  Marshalling is a name for the process of packing objects into an array
 *  of bytes.  This module provides general functions for marshalling and
 *  unmarshalling.
 *
 *  marshal - v. 1. tr. arrange (soldiers, facts, one's thoughts, etc.) in
 *  due order. 							     [COED]
 *
 *  Revision Log
 *  ------------
 *  $Log: marshal.h,v $
 *  Revision 1.2  1994/06/09 14:42:47  nickh
 *  new file
 *
 * Revision 1.1  1994/06/09  11:10:50  nickh
 * new file
 *
 *  Revision 1.1  1992/10/29  12:57:57  richard
 *  Initial revision
 *
 */

#ifndef marshal_h
#define marshal_h


/*  == Marshalled sizes ==
 *
 *  These macros define the maximum number of bytes required to marshal
 *  objects of various types.
 */

#define MARSHAL_SIZE_INT	((sizeof(int)*8+6)/7)
#define MARSHAL_SIZE_UINT	((sizeof(int)*8+6)/7)
#define MARSHAL_SIZE_LONG	((sizeof(long)*8+6)/7)
#define MARSHAL_SIZE_ULONG	((sizeof(long)*8+6)/7)
#define MARSHAL_SIZE_CHAR	1


/*  === MARSHAL OBJECTS ===
 *
 *  `marshal' takes an output buffer, a marshalling description, and a list
 *  of objects, and encodes the objects into the buffer according to the
 *  description.  It returns a pointer to the first unused byte in the
 *  buffer.
 *
 *  `unmarshal' reverses the operation of `marshal'.  It takes an input
 *  buffer containing marshalled objects, a marshalling description (which
 *  must be the same as that used to create the contents of the buffer), and
 *  a list of _pointers_to_ objects.  It returns a pointer to the first
 *  unused byte in the buffer.
 *
 *  A marshalling description is a string consisting of the following
 *  characters, each of which corresponds to an object of the indicated type
 *  in the argument list:
 *	c  [signed/unsigned] char
 *      s  [signed/unsigned] short
 *	i  [signed/unsigned] int
 *	l  [signed/unsigned] long int
 *
 *  Error conditions are indicated by returning NULL and setting errno.
 */

enum /* errno */
{
  EMARSHALDESC = 1	/* illegal description string */
};

extern char *marshal(char *out, const char *desc, ...);
extern char *unmarshal(char *in, const char *desc, ...);


#endif
