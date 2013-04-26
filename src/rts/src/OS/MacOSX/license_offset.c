/* ===== LICENSING =====
 *
 *  Index into SHA result for Linux
 *
 * Copyright (c) 1998 Harlequin Group plc
 *
 * $Log: license_offset.c,v $
 * Revision 1.1  1998/08/03 17:09:46  jkbrook
 * new unit
 * [Bug #30457]
 * Offsets to license codes should be platform- (not OS-) specific
 *
 *  
 */

 #include "mlw_mklic.h"
 #include "license_offset.h"

 /* for all i386 platforms, take the first CHECK_CHARS characters */

 extern int license_offset (int sha_len) 
 {
    return 0;
 };

