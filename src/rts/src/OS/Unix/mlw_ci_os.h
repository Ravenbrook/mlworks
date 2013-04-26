/* Copyright 1997 The Harlequin Group Limited.  All rights reserved.
**
** Any ML<->C interface OS specific declarations (other than init functions)
** go here.
** 
** As it happens nothing is currently exported from mlw_ci_os.c
**
** Revision Log
** ------------
** $Log: mlw_ci_os.h,v $
** Revision 1.1  1997/05/07 08:29:11  stephenb
** new unit
** [Bug #30030]
**
*/

/*
** The export expands to nothing under Unix since the default is 
** that all functions are exported from a .so.
*/
#define mlw_ci_export
