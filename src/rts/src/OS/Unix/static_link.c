/* Addition to MLWorks runtime to allow it to link statically under
 * some versions of Unix.  Dynamic linking is not a problem.  Added by
 * Nick Haines, 1994-06-14. This file is part of the X11R5
 * distribution, and the comment below explains it quite well. */

/* This was originally used for the SunOS version of MLWorks.  It was
   also required under Solaris 2.2. (Added by Nick Haines 1994-07-07).
   And turned out to be needed for Irix and Linux as well.  */

/* This caused problems under Solaris 2.3 and 2.4.  Some other libraries
 * called dlopen(), and those calls were linked to these stubs.  This
 * meant that main-static couldn't look up host names in DISPLAY variables.
 * See Bug 1576.  Dave Berry 1996-09-02
 */

/* This file moved to OS/Unix, because it is the same for all versions
   of Unix that use it.  Also added Log.  Dave Berry 1996-10-08. */

/* $Log: static_link.c,v $
 * Revision 1.2  1996/10/09 16:45:00  daveb
 * Added warning message in the event that this version of dlopen() is ever
 * actually called.
 * Also moved declarations of these functions into static_link_local.h, and
 * corrected the types of the arguments.
 *
 * Revision 1.1  1996/10/09  10:27:14  daveb
 * new unit
 * Dummy implementation of dlopen(), etc.  Moved here from the OS-specific
 * directories.
 *  */

/*
 * Stub interface to dynamic linker routines
 * that SunOS uses but didn't ship with 4.1.
 *
 * The C library routine wcstombs in SunOS 4.1 tries to dynamically
 * load some routines using the dlsym interface, described in dlsym(3x).
 * Unfortunately SunOS 4.1 does not include the necessary library, libdl.
 *
 * The R5 Xlib uses wcstombs.  If you link dynamically, your program can
 * run even with the unresolved reference to dlsym.  However, if you
 * link statically, you will encounter this bug.  One workaround
 * is to include these stub routines when you link.
 */

#include "utils.h"
#include "static_link_local.h"

void *dlopen(const char* pathname, int mode)
{
    message_start();
    message_string("Warning: dummy dlopen called with argument `");
    message_string(pathname);
    message_string("'.\n");
    message_string(" The statically-linked runtime has failed to load this library.");
    message_end();
    return 0;
}

void *dlsym(void *handle, const char *name)
{
    return 0;
}

int dlclose(void *handle)
{
    return -1;
}

char *dlerror(void)
{
  return 0;
}
