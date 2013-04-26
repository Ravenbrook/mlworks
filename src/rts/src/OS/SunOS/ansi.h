/*  ==== ANSI COMPATABILITY HEADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header defines some things which are part of the ANSI standard but
 *  missing from the C compiler / environment.
 * 
 *  See also syscalls.h, which contains prototypes for system calls
 *  which are not prototyped in include files
 * 
 *  $Log: ansi.h,v $
 *  Revision 1.11  1997/06/27 12:25:53  stephenb
 *  [Bug #30029]
 *  Add prototypes for setbuff and setvbuff.
 *
 * Revision 1.10  1996/11/21  16:32:20  jont
 * [Bug #1802]
 * Add declaration of tolower because the crappy SunOS header files don't have it
 * Also add declaration of memset
 *
 */

#ifndef ansi_h
#define ansi_h

#include <stdarg.h>
#include <stdio.h>
#include <sys/types.h>
#include <time.h>

/* Gnu C fails to define a bunch of ANSI constant macros */

#ifdef __GNUC__
#define EXIT_SUCCESS	0
#define EXIT_FAILURE	1
#define FILENAME_MAX	1024	/* from the manual */
#define FOPEN_MAX	0	/* guaranteed number */
#define CLOCKS_PER_SEC	1000000
#define SEEK_SET	0
#define SEEK_CUR	1
#define SEEK_END	2
#endif /* __GNUC__ */

/* on the Suns, the include files in /usr/include do not include
declarations for a large number of ANSI functions. We remedy that
here. */

/* stdio.h things */

extern int fclose (FILE *stream);
extern int fflush (FILE *stream);
extern int fgetc (FILE *stream);
extern int ungetc (int c, FILE *stram);
extern int fputc (int c, FILE *stream);
extern int printf (const char *format, ...);
extern int vprintf (const char *format, va_list arg);
extern int fprintf (FILE *stream, const char *format, ...);
extern int vfprintf (FILE *stream, const char *format, va_list arg);
extern int vsprintf (char *s, const char *format, va_list arg);
extern int fputs (const char *s, FILE *stream);
extern int fscanf (FILE *stream, const char *format, ...);
extern int sscanf (const char *s, const char *format, ...);
extern int fseek (FILE *stream, long int offset, int whence);
extern int remove(char *);
extern size_t fread (void *ptr, size_t size, size_t nmemb, FILE *stream);
extern size_t fwrite (const void *, size_t, size_t, FILE *);
extern int setvbuf(FILE *, char *, int, size_t);
extern int setbuf(FILE *, char *);
extern void perror(char const *);

/* This macro should be defined on systems for which the
 * implementations of sprintf and vsprintf do _not_ return the number
 * of characters written. I don't care what they _do_ return */

#define SPRINTF_IS_BROKEN

/* these functions are used in the macro definitions of putc and getc
but not declared in stdio.h */

extern int _filbuf(FILE *stream);

#ifdef __GNUC__
extern int _flsbuf(unsigned char c, FILE *stream);
#else
extern int _flsbuf(FILE *stream);
#endif

/* time.h things */

#ifndef __GNUC__
typedef long clock_t;
#endif
extern size_t strftime (char *s, size_t maxsize, const char *format,
			const struct tm *timeptr);
extern time_t time (time_t *timer);
extern clock_t clock(void);
extern mktime(struct tm *timeptr);

/* stdlib.h things */

extern int system(const char *string);
extern long strtol(char const *str, char **ptr, int base);

/* ctype things */

extern int tolower(int);

/* string.h things */

extern void *memset(void *, int, size_t);

/* 
 * raise() is not defined in SunOS, unlike sensible systems.
 */

#define raise(sig_no) (kill (getpid(), sig_no))

#endif
