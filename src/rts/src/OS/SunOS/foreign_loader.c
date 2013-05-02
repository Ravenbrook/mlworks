/*  ==== FOREIGN OBJECT LOADER ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Implementation
 *  --------------
 *  This implementation provides dummy stubs for those ML ports
 *  where foreign object loading is not yet supported.  
 *
 *  Revision Log
 *  ------------
 *  $Log: foreign_loader.c,v $
 *  Revision 1.1  1996/02/26 14:20:25  brianm
 *  new unit
 *  Moved from architecture specific location.
 *
 * Revision 1.6  1996/02/14  16:33:11  brianm
 * Adding support for detecting endianness of underlying machine.
 *
 * Revision 1.5  1995/05/04  18:45:49  brianm
 * New foreign_loader code using libdl library and a.out file format.
 *
 * Revision 1.4  1995/04/04  00:42:06  brianm
 * Adding new symtable functions ....
 *
 * Revision 1.3  1995/03/24  12:19:09  brianm
 * Adding prototypes due to modification of header file.
 * Simplified code to yield `unimplemented' exception.
 *
 * Revision 1.2  1995/03/01  17:43:19  brianm
 * minor corrections
 *
 * Revision 1.1  1995/03/01  10:24:20  brianm
 * new unit
 * Foreign Object loading routines
 *
 *
 */

#include "ansi.h"
#include "mltypes.h"
#include "allocator.h"
#include "values.h"
#include "diagnostic.h"
#include "exceptions.h"
#include "environment.h"
#include "words.h"
#include "foreign_loader.h"


#include <dlfcn.h>      /* Run-Time Dynamic Linking libraries */ 
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <a.out.h>
#include <stab.h>

#if FAKE_RTS

#include "fake_foreign_loader.h"
#include "mylib.h"
#include "fake_rts.h"

#endif

/* External symbols that should be defined - and don't seem to be */

extern int    fclose(FILE *);
extern size_t fread(void *, size_t, size_t, FILE *);
extern int    fprintf(FILE *, const char *, ...);

extern int  fseek(FILE *, long, int);



/* Macros */

#define bit(a)                     (1u << (a))
#define bitblk(hi,lo)              (bit(hi) | (bit(hi) - bit(lo)))
#define appmask(x,m)               ((x) & (m))
#define rshift(x,lo)               ((unsigned)(x) >> (lo))
#define getbitblk(u,hi,lo)         (appmask(rshift((u),(lo)),bitblk(1+(hi) - (lo),0)))



/* Local Procedure/Function stub decls. */

static struct exec *read_header(void);
static void read_symtab(void);

static int  check_type(unsigned char);
static char  *show_symtab_type(unsigned char);

static mlval pack_foreign_value(void *);
static void  *unpack_foreign_value(mlval);


/* Forward decls. of exported ML functions */

static mlval load_foreign_object(mlval);
static mlval lookup_foreign_value(mlval);
static mlval call_unit_function(mlval);
static mlval call_foreign_function(mlval);

static mlval open_symtab_file(mlval);
static mlval next_symtab_entry(mlval);
static mlval close_symtab_file(mlval);

/* Definitions */


#define raise_error(str)   exn_raise_string(perv_exn_ref_value, (str))


enum load_mode {load_later, load_now};

typedef enum load_mode load_mode;


/* ==== <ML> load_foreign_object : (string * load_mode) -> foreign_object
 *
 *  Given a pathname (as a string), this dynamiclly links, using the
 *  specified load_mode, the executable object file and returns a
 *  foreign_object pointer.
 */
static mlval load_foreign_object(mlval argument)
{
   char      *path;
   unsigned  *handle;
   mlval result;
   int mode = RTLD_LAZY;

   path = CSTRING(FIELD(argument,0));

   /* SunOS doesn't support RTLD_NOW option ...
   load_mode lmode;

   lmode = CINT(FIELD(argument,1));

   switch (lmode) {
      case load_later  : mode = RTLD_LAZY; break;
      case load_now    : mode = RTLD_NOW;  break;
   }
   */

   handle = (unsigned *)dlopen(path,mode);

   if (handle == NULL) raise_error("Shared object not found ...\n");

   result = allocate_word32();
   num_to_word32((unsigned)handle,result);
 
   return(result);
}

/* ==== <ML> lookup_foreign_value : (foreign_object * string) -> foreign_value
 *
 *  Given a name (as a ML string) and a foreign object, this looks up
 *  the foreign value within the given foreign object.
 */
static mlval lookup_foreign_value(mlval arg)
{
   mlval fstruct, word;
   char *name;
   void *object;

   fstruct = FIELD(arg,0);
   name    = CSTRING(FIELD(arg,1));

   word    = FIELD(fstruct,2);

   object  = dlsym((void *)word32_to_num(word),name);

   if (object == NULL) raise_error("Named value not found in object.\n");

   return(pack_foreign_value(object));
}

/* ==== <ML> call_unit_function : foreign_object -> unit
 *
 *  Calls a foreign unit function (included for testing purposes only).
 */
static mlval call_unit_function(mlval f_val)
{
   void (*f)(void);

   f = (void (*)(void))unpack_foreign_value(f_val);
   (*f)();

   return(MLUNIT);
}


/* ==== <ML> call_foreign_function : (function * memory * int * memory) -> unit
 *
 *  Calls a foreign function on a given array of (4 byte) argument values and
 *  returning a 4 byte value.  The integer argument specifies the number of
 *  arguments to be passed.
 */
static mlval call_foreign_function(mlval f_arg)
{
   void *ffun;
   void *argv;
   int argc;
   unsigned *result;

   ffun     =      (void *)unpack_foreign_value(FIELD(f_arg, 0));
   argv     =      (void *)unpack_foreign_value(FIELD(f_arg, 1));
   argc     =         CINT(FIELD(f_arg, 2));
   result   =  (unsigned *)unpack_foreign_value(FIELD(f_arg, 3));

   *result  =  (unsigned)call_ffun(ffun,argv,argc);

   return(MLUNIT);
}

extern mlval call_ffun_error(int argv)
{
   fprintf(stderr,"Too many args to foreign function:\n");
   fprintf(stderr,"Number of supplied args = %i (max: %i)\n",argv,MAX_FI_ARG_LIMIT);
   return(MLINT(0));
}


/* ==== <ML> check_big_endian : unit -> bool
 *
 *  Returns true for big_endian encoding 
 *
 */
static mlval check_big_endian (mlval argument)
{
   unsigned i = 1;
   char *bytes;

   bytes = (char *)&i;

   if (0 != bytes[3]) { return(MLTRUE); };

   return(MLFALSE);
}



/* OS specific - SunOS */
/* Uses: a.out format  */

/* ==== Extracting a symbol table ====

   The intention in the following code is to produce a stream of
   strings extracted from an a.out format file as part of creating an
   ML version of the symbol table info.  However, to avoid
   complications with ML's GC, we need to avoid ML list creation
   within C.

   The idea is that we provide ML-usable routines for:

     - opening an a.out format file.

     - getting the next symtab entry (as an ML string ...), returning
       the null string at the end.

     - closing the a.out file.

   and then ML uses these to generate an ML list from ML - which will
   then be GC-safe.  (Creating ML objects in C can invalidate mlval
   objects since the GC can move them around - suitable care is needed
   to make C copies of data.)

   To simplify the ML interface, some state is maintained in C for
   this.  This means that only one file can be processed at a time.

*/


/**********************************/
/*                                */
/* SYMTAB READING STATE VARIABLES */
/*                                */
/**********************************/

static FILE *fp               = NULL;     /* Active if non-NULL */
static struct exec *header    = NULL;
static struct nlist *symtab   = NULL;
static char *strtab           = NULL;
static long symtab_len        = 0;
static long index             = 0;


struct exec *read_header()
{
  /* External variables :

     FILE *fp;
   */

  struct exec *header;

  header = malloc(sizeof(struct exec));

  fread(header,sizeof(struct exec),1,fp);
  return(header);
}

static void read_symtab()
{
  /* External variables :

     FILE *fp
     struct exec *header
     struct nlist *symtab
     char  *strtab
     long symtab_len
     long index
  */

  /* Local variables */

  int i;

  long symtab_offset;
  long strtab_offset;

  long symtab_size;

  int  strtab_size   = 0;
  int  strtab_len    = 0;
  int  strtab_start  = 0;

  struct nlist *entry;
  long symaddr;

  symtab_offset  = N_SYMOFF(*header);
  strtab_offset  = N_STROFF(*header);
  symtab_size   = header -> a_syms;


  /* allocate memory for symbol table */
  symtab = malloc((unsigned)symtab_size);

  /* access file for symbol table */
  fseek(fp,symtab_offset,0);
  symtab_len = symtab_size/sizeof(struct nlist);
  fread(symtab,sizeof(struct nlist),(unsigned)symtab_len,fp);

  index = 0;

  /* set position for string table */
  fseek(fp,strtab_offset,0);
  fread(&strtab_size,sizeof(int),1,fp);

  /* allocate memory for string table */
  strtab = malloc((unsigned)strtab_size);

  strtab_len = strtab_size/sizeof(char) - sizeof(int);
  fread(strtab,sizeof(char),(unsigned)strtab_len,fp);

  strtab_start = (int)strtab - sizeof(int);

  /* Now loop through symbol table, fixing up string pointers */
  for (i=0; i < symtab_len; i++)
     {
       entry = &symtab[i];
       symaddr = (entry -> n_un).n_strx;
       if (symaddr != 0)
	 {
	   (entry -> n_un).n_name = (char *)(strtab_start + symaddr + 1);
           /* Adding one to the string pointer here loses the first
              character which will generally be an underscore where it
              counts for us.
            */
	 }
     };
}


static mlval open_symtab_file(mlval argument)
{

   /* External Variables:
     FILE *fp;
     struct exec *header;
   */

   /* Local Variables */

   char *path;

   if (fp != NULL) { return(MLFALSE); };
   
   path = CSTRING(argument);

   fp = fopen(path,"r");
   if (fp == NULL) { return(MLFALSE); };

   header = read_header();
   read_symtab();

   return(MLTRUE);
}



static mlval next_symtab_entry(mlval argument)
{
  /* External variables :

     FILE *fp;
     struct nlist *symtab;
     long symtab_len;
     long index;
  */

  /* Local Variables */

  struct nlist *entry;
  unsigned char type;
  unsigned int  value;

  char buf[BUFSIZ];
  char *bufptr;

  int i;

  mlval result = ml_string("");

  /* Check for valid processing and end of symtab */
  if ( (fp = NULL) || (index >= symtab_len) ) return(result);

  /* Iterate through symbol table to find something interesting to return */

  for(i=index;i<symtab_len;i++)
  {
     entry = &symtab[i];
     type = (entry -> n_type);

     if (check_type(type))
       {
	 strcpy(buf,(entry -> n_un).n_name); 

         /* Skip clutter ... */
         if ( (strlen(buf) == 5) &&
              ( (strcmp("etext",buf) == 0) ||
                (strcmp("edata",buf) == 0)
              )
            )
           continue;

         /* extract value ... */
         value = entry -> n_value;

	 /* move bufptr to end of symbol name ... */
	 bufptr = (char *)(buf + strlen(buf));

	 /* ... and add in some other info ... */
	 sprintf(bufptr, " %s:type 0x%x:value", show_symtab_type(type), value);

	 /* turn string into an ML object */
	 result = ml_string(buf);

	 /* Save next index position */
	 index = i + 1;

	 return(result);
       };
  };

  index = symtab_len; /* Loop is exhausted */

  return(result);
}


static mlval close_symtab_file(mlval argument)
{
   /* External variables:

      FILE *fp
      struct exec *header
      struct nlist *symtab
      char *strtab
      long symtab_len
      long index
    */

   fclose(fp);
   fp = NULL;

   free(header);
   header = NULL;

   free(symtab);
   symtab = NULL;

   free(strtab);
   strtab = NULL;

   symtab_len = index = 0;

   return(MLUNIT);
}


static int check_type (unsigned char type)
   {
     switch (type & ~1u)  /* mask off bit 0 - external flag */
	{
	  case N_TEXT    : 
	  case N_DATA    : return(((type & 1) == 1u)); /* External symbol */ 
	  default        : return(0);
	};
   }

static char *show_symtab_type(unsigned char n_type)
{
   static char msg[20];

   switch (n_type & ~1u) {
       case N_UNDF   : strcpy(msg,"none=N_UNDF");  break;
       case N_ABS    : strcpy(msg,"none=N_ABS");  break;
       case N_TEXT   : strcpy(msg,"code=N_TEXT");  break;
       case N_DATA   : strcpy(msg,"var=N_DATA");  break;
       case N_BSS    : strcpy(msg,"none=N_BSS");  break;
       case N_COMM   : strcpy(msg,"none=N_COMM");  break;
       case N_FN     : strcpy(msg,"none=N_FN");  break;
       default       : strcpy(msg,"none=**unknown**"); break;
   };

   return(msg);
}

static mlval pack_foreign_value(void *ptr)
{
   mlval result;
   unsigned *object;

   result  = allocate_word32();

   object  = (unsigned *)CWORD32(result);
   *object = (unsigned)ptr;
   
   return(result);
}

static void *unpack_foreign_value(mlval object)
{
   unsigned *ptr;

   ptr = (unsigned *)CWORD32(object);

   return((void *)*ptr);
}



void foreign_init(void)
{
  env_function("load foreign object",   load_foreign_object);
  env_function("lookup foreign value",  lookup_foreign_value);

  env_function("call unit function",    call_unit_function);
  env_function("call foreign function", call_foreign_function);

  env_function("open symtab file",  open_symtab_file);
  env_function("next symtab entry", next_symtab_entry);
  env_function("close symtab file", close_symtab_file);

  env_function("big endian flag", check_big_endian);
}
