/* ===== LICENSING =====
 *
 *  Index into SHA result for NT
 *
 * Copyright (c) 1998 Harlequin Group plc
 *
 * $Log: license_offset.c,v $
 * Revision 1.1  1998/08/03 17:09:59  jkbrook
 * new unit
 * [Bug #30457]
 * Offsets to license codes should be platform- (not OS-) specific
 *
 *  
 */

 /* for I386-based platforms, take the first CHECK_CHARS characters */

 extern int license_offset (int sha_len) 
 {
    return 0;
 }

