/* ===== LICENSING =====
 *
 *  Index into SHA result for Solaris
 *
 * Copyright (c) 1998 Harlequin Group plc
 *
 * $Log: license_offset.c,v $
 * Revision 1.1  1998/08/03 17:09:23  jkbrook
 * new unit
 * [Bug #30457]
 * Offsets to license codes should be platform- (not OS-) specific
 *
 *  
 */

 #include "mlw_mklic.h"
 #include "license_offset.h"

 /* for commercial Unix platforms, take the last CHECK_CHARS characters */

 extern int license_offset (int sha_len) 
 {
    return sha_len - CHECK_CHARS;
 };

