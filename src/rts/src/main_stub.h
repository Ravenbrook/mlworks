/*  === TOP LEVEL OF RUNTIME SYSTEM ===
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This file simply loads the runtime dynamic library and passes it
 *  the command line arguments directly.
 *
 *  Revision Log
 *  ------------
 *  $Log: main_stub.h,v $
 *  Revision 1.1  1997/05/21 16:57:29  andreww
 *  new unit
 *  [Bug #30045]
 *  Small piece of C to act as a workaround rts that calls the runtime DLL.
 *
 *
 *
 */

extern mlval image_continuation;

extern int module_argc;        /* arguments to be passed to ML */
extern const char *const *module_argv;

extern int mono;		 /* running on a mono screen? */

extern int main(int argc, const char *const *argv);

extern const char *runtime;   /* The executable we started from */

