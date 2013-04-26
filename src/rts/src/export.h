/* ==== EXPORTING FUNCTIONS ====
 * 
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * Description
 * -----------
 * This file abstracts the OS-specific exporting code
 *
 * $Log: export.h,v $
 * Revision 1.2  1996/02/16 12:22:44  nickb
 * "export" is becoming "deliver".
 *
 * Revision 1.1  1996/02/08  17:34:06  jont
 * new unit
 *
 *
 */

#ifndef export_h
#define export_h

#include "mltypes.h"

/* This item is used by delivery. The MLWorks process forks a child
 * process so that garbage collection in this process does not
 * affect the main heap. */

extern mlval deliverFn(mlval);

#endif /* export_h */
