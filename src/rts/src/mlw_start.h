/*  === start_mlworks function ===
 *
 * Copyright (C) 1998, Harlequin Group plc
 * All rights reserved
 *
 *  Revision Log
 *  ------------
 *  $Log: mlw_start.h,v $
 *  Revision 1.1  1998/10/16 14:24:41  jont
 *  new unit
 *  Extract start_mlworks into one file to avoid duplication
 *
 *
 */

#ifndef _mlw_start_h
#define _mlw_start_h

#include "mltypes.h"
#include "mlw_start.h"

extern void stop_mlworks(void);

extern int start_mlworks(int argc, const char *const *argv, mlval setup, void (*declare)(void));

#endif

