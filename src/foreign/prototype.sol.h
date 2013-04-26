/*
   Prototypes of some standard functions 
   (sometimes these don't exist)
*/

/* include <sys/stdtypes.h> */

#include <sys/types.h>  /* Solaris */
#include <stdio.h>

extern int _flsbuf();

extern int    fclose(FILE *);
extern size_t fread(void *, size_t, size_t, FILE *);
extern int    printf(const char *, ...);

extern int    scanf(const char *, ...);
/*
extern int    sscanf(char *,const char *, ...);
*/

extern int  fseek(FILE *, long, int);
extern long ftell(FILE *);

extern char *strncat(char *, const char *, size_t);
extern char *strncpy(char *, const char *, size_t);
