/*  ==== EXECUTABLE FILE DELIVERY AND EXECUTION ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This code deals with delivery executables rather than heap images.
 *  There are two halves to this. Firstly, writing such an object,
 *  and secondly, rerunning it
 *
 *  $Log: exec_delivery.h,v $
 *  Revision 1.5  1998/04/14 12:42:06  mitchell
 *  [Bug #50061]
 *  Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.4  1997/11/26  10:09:56  johnh
 * [Bug #30134]
 * save_exceutable takes extra arg to save exe as console or windows app.
 *
 * Revision 1.3  1996/08/27  16:29:01  nickb
 * Change return values for load_.
 *
 * Revision 1.2  1996/05/01  08:53:16  nickb
 * Change to save_executable.
 *
 * Revision 1.1  1995/09/26  15:15:26  jont
 * new unit
 *
 */

#ifndef exec_delivery_h
#define exec_delivery_h

#include "mltypes.h"

#define APP_CONSOLE 0
#define APP_WINDOWS 1
#define APP_CURRENT 2

extern mlval save_executable(char *to, mlval heap, int console_app);
/* Save a re-executable version of the current system */
/* We need to know where the current runtime is */ 
/* in order to acquire its other sections */
/* returns 0 if ok, 1 on error of some sort (with errno set) */

extern int load_heap_from_executable
  (mlval *heap, const char *runtime, int just_check);
/* Reload the heap from within the executable, or just check if there is
   such an executable */

/* Returns: */
/* 0 if done */
/* 1 if no image section or exec images not supported (in which case
   we continue as before) */
/* 2 if an error has occurred and errno is set */

#endif
