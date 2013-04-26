/* ===== LICENSING =====
 *
 * Platform-specific offsets for indexing into SHA output to
 * distinguish differently priced products
 *
 * Copyright (c) 1998 Harlequin Group plc
 *
 * $Log: license_offset.h,v $
 * Revision 1.1  1998/08/03 17:09:04  jkbrook
 * new unit
 * [Bug #30457]
 * Offsets to license codes should be platform- (not OS-) specific
 *
 *
 */

 extern int license_offset(int sha_len);

