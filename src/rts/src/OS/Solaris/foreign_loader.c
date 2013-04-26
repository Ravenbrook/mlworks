/*  ==== FOREIGN OBJECT LOADER ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation  (* SOLARIS *)
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: foreign_loader.c,v $
 *  Revision 1.2  1997/02/28 11:42:34  stephenb
 *  [Bug #1932]
 *  Fixed open_symtab_file and setup_symtab to use the sh_link field
 *  to locate the .dynstr section for a .dynsym section.  Also added
 *  numerous assertions.
 *
 * Revision 1.1  1996/02/26  14:20:11  brianm
 * new unit
 * Moved from architecture specific location.
 *
 * Revision 1.7  1996/02/14  16:49:21  brianm
 * Adding support for detecting endianness of underlying machine.
 *
 * Revision 1.6  1995/04/24  22:34:07  brianm
 * Minor modifications ...
 *
 * Revision 1.5  1995/04/04  23:30:12  brianm
 * Making code GC-safe - removing explicit ML list building from C.
 * Adding interface for specifying RTLD_LAZY/RTLD_NOW.
 * Adding allocate_word32 and CWORD32.
 *
 * Revision 1.4  1995/03/24  19:41:43  brianm
 * Minor correction.
 *
 * Revision 1.3  1995/03/24  11:57:30  brianm
 * Updating foreign pointers to use Word32.
 * Added prototypes due to modification of header file.
 *
 * Revision 1.2  1995/03/01  16:25:35  brianm
 * Minor corrections.
 *
 * Revision 1.1  1995/03/01  10:00:25  brianm
 * new unit
 * Foreign Object loading routines
 *
 *
 */


#include <assert.h>
#include "mltypes.h"
#include "allocator.h"
#include "values.h"
#include "diagnostic.h"
#include "exceptions.h"
#include "environment.h"
#include "words.h"
#include "foreign_loader.h"

#include <dlfcn.h>      /* Run-Time Dynamic Linking libraries */ 
#include <libelf.h>     /* ELF libraries - Solaris            */

#include <fcntl.h>
#include <unistd.h>

#if 0

#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

#endif


#if FAKE_RTS

#include "fake_foreign_loader.h"
#include "mylib.h"
#include "fake_rts.h"

#endif


/* Macros */


#define INDEXPTR(base,index,size)  ((unsigned long int)(base) + ((size)*(index)))

#ifndef FAKE_RTS

#define bit(a)                     (1u << (a))
#define bitblk(hi,lo)              (bit(hi) | (bit(hi) - bit(lo)))
#define appmask(x,m)               ((x) & (m))
#define rshift(x,lo)               ((unsigned)(x) >> (lo))
#define getbitblk(u,hi,lo)         (appmask(rshift((u),(lo)),bitblk(1+(hi) - (lo),0)))

#endif


/* Local Procedure/Function stub decls. */

static void  setup_symtab(Elf *,Elf_Scn *,Elf_Scn*,int);
static char  *show_symtab_type(unsigned char);
static void  show_errmsg(void);

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

   load_mode lmode;
   int mode = RTLD_LAZY;

   path = CSTRING(FIELD(argument,0));
   lmode = CINT(FIELD(argument,1));

   switch (lmode) {
      case load_later  : mode = RTLD_LAZY; break;
      case load_now    : mode = RTLD_NOW;  break;
   }

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
   int i;
   int *data;

   ffun     =      (void *)unpack_foreign_value(FIELD(f_arg, 0));
   argv     =      (void *)unpack_foreign_value(FIELD(f_arg, 1));
   argc     =         CINT(FIELD(f_arg, 2));
   result   =  (unsigned *)unpack_foreign_value(FIELD(f_arg, 3));

   data = argv;
   i=0;
#if 0
   printf("<C>call_foreign_function ... \n");

   printf("argv = %i = 0x%x\n",(int)argv,(unsigned)argv);
   printf("argc = %i\n", argc);
   
   for (i=0;i<argc;i++)
      printf("  ARG[ %i ] = %i = 0x%x\n",i,(int)data[i],(unsigned)data[i]);
#endif

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


/* OS specific - Solaris */
/* Uses: ELF             */

/* ==== Extracting a symbol table ====

   The intention in the following code is to produce a stream of strings
   extracted from an ELF file as part of creating an ML version of the
   symbol table info.  However, to avoid complications with ML's GC, we
   need to avoid ML list creation within C.

   The idea is that we provide ML-usable routines for:

     - opening an ELF format file.

     - getting the next symtab entry (as an ML string ...), returning
       the null string at the end.

     - closing the ELF format file.

   and then ML uses these to generate an ML list from ML - which will
   then be GC-safe.  (Creating ML objects in C can invalidate mlval
   objects since the GC can move them around - suitable care is needed to
   make C copies of data.)

   To simplify the ML interface, some state is maintained in C for this.
   This means that only one ELF file can be processed at a time.
*/


/**********************************/
/*                                */
/* SYMTAB READING STATE VARIABLES */
/*                                */
/**********************************/

static int fd             = -1;     /* Active if +ve */
static int entry          = -1;     /* Valid if +ve */
static int entries        = -1;     /* Valid if +ve */
static int sh_num         = -1;     /* Valid if +ve */
static Elf *elf           = (Elf *)NULL;
static Elf32_Sym *symtab  = (Elf32_Sym  *)NULL;
static char      *strtab  = (char *)NULL;


static mlval open_symtab_file(mlval argument)
{

   /* External Variables
      extern int fd;
      extern Elf *elf;
   */

   /* Local Variables */
   Elf32_Ehdr *ehdr;
   Elf_Scn    *scn;

   char *path;

   if (fd >= 0) { return(MLFALSE); };
   
   path = CSTRING(argument);
   fd = open(path, O_RDONLY);

   if (fd < 0) { return(MLFALSE); };

   /* Reset ELF error number ... */
   elf_errno();

   /* Check ELF version ... */
   if (elf_version(EV_CURRENT) == EV_NONE)
     { show_errmsg();
       return(MLFALSE);
     };

   /*  Begin ELF processing of file - allocate ELF descriptor.
    *  This also initially allocates internal memory used for ELF ...
    */
   elf = elf_begin(fd,ELF_C_READ,(Elf *)NULL);

   /* Get ELF header ... */
   ehdr = elf32_getehdr(elf);

   scn = (Elf_Scn *)NULL;

   /* Find symbol table section ... it's the first one of type SHT_DYNSYM */ 
   while ((scn = elf_nextscn(elf, scn)) != NULL) {
     Elf32_Shdr *shdr= elf32_getshdr(scn);
     assert(shdr != (Elf32_Shdr *)0);
     if (shdr->sh_type == SHT_DYNSYM) {
       Elf32_Shdr * dynstr_hdr;
       Elf_Scn * dynstr= elf_getscn(elf, shdr->sh_link);
       assert(dynstr != (Elf_Scn *)0);
       dynstr_hdr= elf32_getshdr(dynstr);
       assert(dynstr_hdr != (Elf32_Shdr *)0);
       assert(dynstr_hdr->sh_type == SHT_STRTAB);
       setup_symtab(elf, scn, dynstr,(int)(ehdr -> e_shnum));
       break;
     }
   }
   /* Initialisation completed */
   return(MLTRUE);
}


static void setup_symtab(Elf *elf, Elf_Scn *symscn, Elf_Scn *strscn, int head_num)
{
  /* External Variables
     extern int        entry;
     extern int        entries;
     extern int        sh_num;
     extern Elf32_Sym  *symtab;
     extern char       *strtab;
  */

  /* Local Variables */
  Elf_Data   *symdata;
  Elf_Data   *strdata;

  int size;

  symdata = elf_getdata(symscn,(Elf_Data *)NULL);
  assert(symdata->d_type == ELF_T_SYM);
  size    = (int)(symdata -> d_size);
  entries = (int)(size/sizeof(Elf32_Sym));
  symtab  = (Elf32_Sym *)(symdata -> d_buf);

  strdata = elf_getdata(strscn,(Elf_Data *)NULL);
  assert(strdata->d_type == ELF_T_BYTE);
  strtab  = (char *)(strdata -> d_buf);

  sh_num  = head_num;
  entry = 0;
}


static mlval next_symtab_entry(mlval argument)
{

  /* External Variables:
     extern int        entry;
     extern int        entries;
     extern int        sh_num;
     extern Elf32_Sym  *symtab;
     extern char       *strtab;
  */

  /* Local Variables */
  Elf32_Sym    *symentry;
  Elf32_Word   st_name;
  Elf32_Addr   st_value;
  Elf32_Half   st_shndx;

  unsigned char st_info, st_bind, st_type;

  char buf[BUFSIZ];
  char *bufptr;

  int i;

  mlval result = ml_string("");

  /* Check for valid processing and end of symtab */
  if ((fd < 0) || (entry >= entries)) { return(result); };


  /* Iterate through entries to find something interesting to return */

  for(i=entry;i<entries;i++){

     symentry = (Elf32_Sym *)INDEXPTR(symtab,i,sizeof(Elf32_Sym));

     st_info   =  symentry -> st_info;
     st_bind   =  ELF32_ST_BIND(st_info);
     st_type   =  ELF32_ST_TYPE(st_info);

     st_shndx  =  symentry -> st_shndx;

     if ((st_bind == STB_GLOBAL) && (0 < st_shndx) && (st_shndx < sh_num))
       { /* Symbol is global and possibly relevent ... */

	 switch (st_type) {
	    case STT_FUNC : /* FALL-THROUGH */
	    case STT_OBJECT :
		 { /* get symbol name */

		   st_name   =  symentry -> st_name;
		   st_value  =  symentry -> st_value;

		   strcpy(buf,(char *)(strtab + st_name)); 

		   /* move bufptr to end of symbol name ... */
		   bufptr = (char *)(buf + strlen(buf));

		   /* ... and add in some other info ... */
		   sprintf( bufptr, " %s:type 0x%x:value"
			  , show_symtab_type(st_type)
			  , (unsigned int)st_value
			  );

		   /* turn string into an ML object */
		   result = ml_string(buf);

                   /* Save next entry position */
                   entry = i + 1;

                   return(result);

		   break;
		 };

	    default : break;
	 };
       };
  };

  entry = entries; /* Loop is exhausted */

  return(result);
}


static mlval close_symtab_file(mlval argument)
{
   /* External Variables
      extern int        fd;
      extern int        entry;
      extern int        entries;
      extern int        sh_num;
      extern Elf        *elf;
      extern Elf32_Sym  *symtab;
      extern char       *strtab;
   */

   close(fd);      /* Close the file descriptor     */
   elf_end(elf);   /* Deallocate memory used in Elf */ 

   fd = entry = entries = sh_num = -1;

   elf     =  (Elf *)NULL;
   symtab  =  (Elf32_Sym  *)NULL;
   strtab  =  (char *)NULL;

   return(MLUNIT);
}

static char *show_symtab_type(unsigned char st_type)
{
   static char msg[20];

   switch (st_type) {
       case STT_NOTYPE   : strcpy(msg,"none=STT_NOTYPE");  break;
       case STT_OBJECT   : strcpy(msg,"var=STT_OBJECT");   break;
       case STT_FUNC     : strcpy(msg,"code=STT_FUNC");    break;
       case STT_SECTION  : strcpy(msg,"none=STT_SECTION"); break;
       case STT_FILE     : strcpy(msg,"none=STT_FILE");    break;
       case STT_NUM      : strcpy(msg,"none=STT_NUM");     break;
       case STT_LOPROC   : strcpy(msg,"none=STT_LOPROC");  break;
       case STT_HIPROC   : strcpy(msg,"none=STT_HIPROC");  break;
       default           : strcpy(msg,"none=**unknown**"); break;
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

#if 0
   printf("pack: pointer = (0x%x)\n",ptr);
   printf("pack: result = (0x%x)\n",result);
#endif
   
   return(result);
}

static void *unpack_foreign_value(mlval object)
{
   unsigned *ptr;

   ptr = (unsigned *)CWORD32(object);

#if 0
   printf("unpack: pointer = (0x%x)\n",*ptr);
#endif

   return((void *)*ptr);
}

static void show_errmsg(void)
{
   printf("*** %s\n", elf_errmsg(elf_errno()));
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
