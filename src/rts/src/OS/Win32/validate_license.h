/*  === LICENSE-KEY VALIDATION ===
 *
 *  Copyright (C) 1998 Harlequin Group plc
 *
 *  Description
 *  -----------
 *  The license function is a black box which takes care of licensing.
 *
 *  Revision Log
 *  ------------
 *  $Log: validate_license.h,v $
 *  Revision 1.1  1998/07/22 16:36:29  jkbrook
 *  new unit
 *  [Bug #30435]
 *  Import validation and storage function from DLL
 *
 *
 */

extern enum license_check_result validate_and_install_license(char *name, char *code);

