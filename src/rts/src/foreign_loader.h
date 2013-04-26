/*  ==== FOREIGN OBJECT LOADER ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  Provides core C/ML interface to foreign loader - based upon
 *  OS-provided run-time dynamic linking libraries (libdl).
 *
 *  Revision Log
 *  ------------
 *  $Log: foreign_loader.h,v $
 *  Revision 1.3  1995/03/23 16:45:41  brianm
 *  Restricting exported functions and added ifndef locks to prevent multiple loading.
 *
 * Revision 1.2  1995/03/01  15:51:43  brianm
 * Minor corrections.
 *
 * Revision 1.1  1995/03/01  09:51:14  brianm
 * new unit
 * Header for foreign object loading
 * */

#ifndef foreign_loader_h
#define foreign_loader_h

#include "fi_call_stub.h"

/* ==== Error hook for foreign interface call ====
 *
 *  Function called when num. args to foreign function is too large.
 *  (i.e. exceeds MAX_FI_ARG_LIMIT, defined in fi_call_stub.h).
 *
 */
extern mlval call_ffun_error(int);

/* ==== Foreign loader init function ====
 *
 *  Code to export foreign loading interface functions into the ML
 *  environment.
 *
 */
extern void  foreign_init(void);

#endif
