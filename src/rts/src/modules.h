/*  ==== MODULE TABLE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  These functions provide a lookup table from module names to modules.
 *
 *  Revision Log
 *  ------------
 *  $Log: modules.h,v $
 *  Revision 1.3  1998/07/06 10:13:39  jont
 *  [Bug #30108]
 *  Implement DLL based ML code
 *
 * Revision 1.2  1994/06/09  14:43:38  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:12:07  nickh
 * new file
 *
 *  Revision 1.7  1993/11/22  16:50:32  jont
 *  Added extra function to lookup module timestamp
 *  Changed mt_add to accept extra parameter for module timestamp
 *
 *  Revision 1.6  1993/08/12  13:43:42  daveb
 *  mt_lookup looks along the module path.
 *
 *  Revision 1.5  1992/08/26  15:50:47  richard
 *  The module table is now a pervasive value.
 *
 *  Revision 1.4  1992/07/01  14:40:24  richard
 *  Changed modules to be an entirely ML type to make them storage
 *  manager independent.
 *
 *  Revision 1.3  1992/03/17  13:29:20  richard
 *  Rewrote and generalised.
 *
 *  Revision 1.2  1992/03/11  11:30:27  richard
 *  Improved documentation slightly.
 *
 *  Revision 1.1  1991/10/17  15:15:11  davidt
 *  Initial revision
 */

#ifndef modules_h
#define modules_h


#include "mltypes.h"
#include "values.h"


extern mlval mt_empty(void);
extern mlval mt_add(mlval table, mlval name, mlval structure, mlval time);
extern mlval mt_lookup(mlval table, mlval name, mlval parent);
extern mlval mt_lookup_time(mlval table, mlval name, mlval parent);
extern void mt_update(mlval structure, mlval name, mlval time);

#endif
