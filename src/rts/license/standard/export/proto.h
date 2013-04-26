/*
$Log: proto.h,v $
Revision 1.4  1994/06/19 08:55:57  freeland
-inserting current code, with Log keyword and downcased #includes

 1993-Mar-8-15:55 richardk
	add PROTOMIXED - only some platforms can cope with ansi-declarations
	(prototypes) combined with traditional-definitions.  Only these
	platforms should turn on USE_PROTOTYPES_MIXED.
1992-Jan-16-15:15 bear = Created
*/

/*********************************************************/
/* TITLE :  Harlequin Generic Prototype Definitions      */
/*                                                       */
/* FILE  :  proto.h                                      */
/*                                                       */
/* DATE  :  Wednesday, November 20, 1991 2:01:52 pm      */
/*                                                       */
/* ENV   :  any                                          */
/*                                                       */
/*********************************************************/

#ifndef PROTO_H
#define PROTO_H

#ifdef  USE_PROTOTYPES

#define PROTO(params)               params
#define PARAMS(ansi, traditional)   ansi

#else /* !USE_PROTOTYPES */

#define PROTO(params)               ()
#define PARAMS(ansi, traditional)   traditional

#endif  /* !USE_PROTOTYPES */


/* Some platforms do support ansi-protos mixed with trad-definitions.  */
/* Use PROTOMIXED to protect such ansi-protos, so others don't barf.   */

#if defined( USE_PROTOTYPES ) && defined( USE_PROTOTYPES_MIXED )
#define PROTOMIXED(params)               params
#else
#define PROTOMIXED(params)               ()
#endif


#endif  /* PROTO_H */

/* end of proto.h */
