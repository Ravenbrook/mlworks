/*  === LICENSE-KEY VALIDATION ===
 *
 *  Copyright (C) 1992, 1998 Harlequin Group plc
 *
 *  Description
 *  -----------
 *  The license function is a black box which takes care of licensing.
 *
 *  Revision Log
 *  ------------
 *  $Log: validate_license.h,v $
 *  Revision 1.1  1998/07/15 15:08:23  jkbrook
 *  new unit
 *  [Bug #30435]
 *  Standalone license-validator and dot-file writer
 *
 */

extern enum license_check_result license_validate(char *name, char *code);

extern int license_store(char *name);

