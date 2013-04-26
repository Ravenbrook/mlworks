/*
   $Log: lshared.h,v $
   Revision 1.23  1999/01/04 09:02:59  jamesr
   [Bug #30447]
   modifications for NT

 * Revision 1.22  1994/05/17  21:51:35  freeland
 * -inserting current code, with Log keyword and downcased #includes
 * 
    1993-Dec-9-13:41 chrism
        [Bug number: 1919] add unique id for rs6000
    1993-Nov-11-13:48 chrism
        remove statics from function declarations
    1993-Oct-18-14:31 chrism
        correct typo
    1993-Oct-15-17:28 chrism
        add etherid for alpha
    1993-Oct-9-14:39 chrism
        include netinet/in.h for htonl on snake
    1993-Oct-8-16:10 chrism
        add hton4l macro for littlendians
    1993-Sep-30-19:12 chrism
        remove 'level' from args of syslog in slogadm
    1993-Sep-30-14:45 chrism
        change logging macros for new style logging levels. changed
        Solaris back to using gethostid
 1993-Sep-14-08:51 john
        use our own getunameid on Solaris as well as snake
 1993-Sep-8-10:46 chrism
        declare next_permitfile and commandline
 1993-Jun-3-17:42 john
        make it work on clipper
 1993-Mar-8-15:37 chrism
         changed sloglerr to print error string rather than codes
 1993-Feb-4-15:18 chrism
        changing to version 2
1992-Nov-17-18:21 chrism = add uniqueid for snake
1992-Nov-12-12:20 chrism = log output in hex
1992-Nov-5-16:30 chrism = fixed bug in slog2n
1992-Nov-2-14:38 chrism = adding extra logging macros
1992-Oct-19-17:44 chrism = removed spurious syslog output
1992-Oct-16-13:44 chrism = add std types
1992-Oct-14-17:03 chrism = removed SYSLOG define
1992-Oct-7-13:43 chrism = Created

*/
/* lshared.h - defines shared by server and clients */

#ifndef _LSHARED_H
#define _LSHARED_H

#define free free_deprecated_use_freememq

#include <stdio.h>
#include "std.h"
#include "fwstream.h"
#include "fwfile.h"

#define ALIGN_SIZE 8

#ifdef UNIX

#include "std.h"
#include <netinet/in.h>

#ifdef snake
#include <sys/utsname.h>
#endif

#ifdef rs6000
#include <sys/utsname.h>
#endif
#endif


#if 0
#ifdef Solaris
#include <sys/systeminfo.h>
/* size suggested in manual on Solaris */
#define SYSINFO_BUF_SIZE 257
#endif
#endif

/****** macros ******/

#define same4l(a, b) ((a[0]==b[0]) && (a[1]==b[1]) && (a[2]==b[2]) && (a[3]==b[3]))
/* for alpha and lowbytefirst machines */
#define hton4l(a) {(a)[0] = htonl((a)[0]);(a)[1] = htonl((a)[1]);(a)[2] = htonl((a)[2]);(a)[3] = htonl((a)[3]);}


#ifdef SGI
#define uniqueid() (sysid((char*)0))
#else

/* Solaris may need same as snake */
#if defined(snake) || defined(rs6000)
#define uniqueid() (getunameid())
uint32 getunameid();
#else

#if defined( alpha ) || defined( dec )
#define uniqueid() (etherid())
uint32 etherid();
#else
#ifdef WIN32

#define uniqueid() (getdongleid())

#else

#define uniqueid() (gethostid())
#endif
#endif
#endif
#endif

/* Routines which could be shared but in fact are not */

void    commandline( int argc, char **argv );
FwObj*  open_permit( int32 pfindex, FwStrRecord *pName );
/* int8         *buildpath(); */
void    startmsg( FwTextString s1, FwTextString s2 );


#endif
