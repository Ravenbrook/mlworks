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
 *  Revision 1.3  1997/03/07 11:16:49  stephenb
 *  [Bug #1871]
 *  open_symtab_file: removed the calls to printf(3).
 *  get_export_symtab: removed the calls to exit(1).
 *
 * Revision 1.2  1996/12/18  11:55:08  stephenb
 * [Bug #1868]
 * Change various uses of #if 1 -> #if 0 so that that code contained
 * by the #if is not run.  This stops various bits of debugging info
 * being displayed when a user calls a foreign function.
 *
 * Revision 1.1  1996/02/26  14:20:00  brianm
 * new unit
 * Moved from architecture specific location.
 *
 * Revision 1.5  1996/02/14  16:44:09  brianm
 * Minor corrections to check_big_endian function ...
 *
 * Revision 1.4  1996/02/14  16:16:56  brianm
 * New version - implementing Win32/WinNT support.
 *
 * Revision 1.3  1995/03/24  12:19:37  brianm
 * Adding prototypes due to modification of header file.
 * Simplified code to yield `unimplemented' exception.
 *
 * Revision 1.2  1995/03/08  15:01:22  brianm
 * Minor corrections.
 *
 * Revision 1.1  1995/03/01  10:54:56  brianm
 * new unit
 * Foreign Object loading routines
 *
 *
 */


#include "mltypes.h"
#include "allocator.h"
#include "values.h"
#include "diagnostic.h"
#include "exceptions.h"
#include "environment.h"
#include "words.h"
#include "foreign_loader.h"

#include <windows.h>

#if !defined(_WIN32) && !defined(WIN32)
#include <ver.h>
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


/* Macros */

#define bit(a)                     (1u << (a))
#define bitblk(hi,lo)              (bit(hi) | (bit(hi) - bit(lo)))
#define appmask(x,m)               ((x) & (m))
#define rshift(x,lo)               ((unsigned)(x) >> (lo))
#define getbitblk(u,hi,lo)         (appmask(rshift((u),(lo)),bitblk(1+(hi) - (lo),0)))


/* Forward decls. of `exported' ML functions - (see foreign_init) */

static mlval load_foreign_object (mlval);
static mlval lookup_foreign_value (mlval);
static mlval call_unit_function (mlval);
static mlval call_foreign_function (mlval);

static mlval open_symtab_file (mlval);
static mlval next_symtab_entry (mlval);
static mlval close_symtab_file (mlval);

/* Local Procedure/Function stub decls. */

static mlval pack_foreign_value(void *);
static void  *unpack_foreign_value(mlval);


/* Definitions */

#define raise_error(str)   exn_raise_string(perv_exn_ref_value, (str))


/* Global variables */

static char errmsgbuf[BUFSIZ];


/* Code */

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
   mlval     result;

   path = CSTRING(FIELD(argument,0));

   handle = (unsigned *)LoadLibrary(path);

   if (handle == NULL) {
     sprintf(errmsgbuf,"LoadLibrary failed : %i\n",  GetLastError());
     raise_error(errmsgbuf);
   };

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

   object  = GetProcAddress((void *)word32_to_num(word),name);

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
   argc     =              CINT(FIELD(f_arg, 2));
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


/*  OS specific part : WinNT   */

/* Types */


typedef struct _export_entry {
    char     *Name;
    USHORT    Ordinal;
    ULONG    *Code;
} export_entry;

typedef struct _export_symtab {
    int Size;
    export_entry *Table;
} export_symtab;


/* Local Procedure/Function stub decls. */

static void cleanup_open_symtab (void);

static export_symtab *get_export_symtab (ULONG);
static ULONG section_size (IMAGE_SECTION_HEADER *);
static IMAGE_SECTION_HEADER *RVA_to_psection (ULONG);
static ULONG RVA_to_file_pointer (ULONG);

static char **get_name_table(int);


/* Definitions */

#define IMAGE_FILE    0
#define OBJECT_FILE   1
#define DOS_MAGIC     0x5a4d       /* DOS Magic number = "MZ" */


/* ==== Extracting a symbol table ====

   The following code produces a stream of strings
   extracted from an PE executable file as part of creating an ML version of the
   symbol table info.  However, to avoid complications with ML's GC, we
   need to avoid ML list creation within C.

   The idea is that we provide ML-usable routines for:

     - opening an PE format file.

     - getting the next symtab entry (as an ML string ...), returning
       the null string at the end.

     - closing the PE format file.

   and then ML uses these to generate an ML list from ML - which will
   then be GC-safe.  (Creating ML objects in C can invalidate mlval
   objects since the GC can move them around - suitable care is needed to
   make C copies of data.)

   To simplify the ML interface, some state is maintained in C for this.
   This means that only one executable file can be processed at a time.

Some details of the PE file format interface.
=============================================

Terminology:

   Image File
       An image file is produced from object files by the link-loader.  It will
       have various extra sections added and the RVA's computed for use in an
       image.  All external references will have been resolved and relocation
       information computed.

   Object File
       An object file is produced as output by a compiler and is generally
       incomplete i.e.  contains unresolved external references.  Also,
       various sections added by the linker will be absent (e.g. standard
       MS-DOS stub and header).

   Image Base
       The preferred address for loading the image into memory.  If loaded
       here, no fix-up relocations need be done.  Typical values are:

        -  0x10000  - Windows NT (Win32)
        - 0x400000  - DLL's and Win95 (i.e. Chicago) executables

   RVA
       Relative Virtual Address - an offset relative to some base address,
       **once the file has been memory-mapped**.  The base address could be
       Image Base or the base address of a section.

       RVA's dont in general correspond to file pointers, unfortunately, since
       sections are guaranteed to be aligned on page boundaries.   Also,
       within a file, sections are aligned on disk-sector boundaries.  This means
       that RVA's don't need adjusting once they are loaded into memory.

       Obtaining file pointers from RVA's (i.e. without memory-mapping) is
       therefore not entirely straightforward.  Fortunately, section headers
       contain both a file pointer (i.e. PointerToRawData) and a Virtual
       Address that represent the base address of each section.  This
       information can then be used to convert RVA's into a particular
       section into file positions.

   Virtual Address
       An address assuming that the image is loaded at the Image Base address.
       To convert this to an RVA, subtract the Image Base. 


References:

  - Microsoft Portable Executable and Common Object File Format Specification 4.1,
    (Revision 4.1, August 1994), Microsoft Corporation

  - The Portable Executable File Format from Top to Bottom,
    Randy Kath, Microsoft Corporation, June 1992.

  - Peering inside the PE : A Tour of the Win32 Portable Executable File Format,
    Matt Pietrek, MSJ, 1994, #3 (Mar)


*/


/**********************************/
/*                                */
/* SYMTAB READING STATE VARIABLES */
/*                                */
/**********************************/

static  FILE *file;                           /* Object file handle */
static  char *filename;                       /* File name */

static  int  sections      = -1;              /* No. of sections (= No. of headers) */
static  IMAGE_SECTION_HEADER    *sec_hdrs;    /* Section headers    */
static  export_symtab  *symtab;

static  long int entry          = -1;     /* Entry number    - (valid when +ve) */
static  long int entries        = -1;     /* No. of entries  - (valid when +ve) */


static mlval open_symtab_file(mlval argument)
{

   /* Local Variables */

   IMAGE_DOS_HEADER        dos_header;
   DWORD                   NT_sig;
   IMAGE_FILE_HEADER       coff_header;
   IMAGE_OPTIONAL_HEADER   opt_header;
   IMAGE_DATA_DIRECTORY    *pddirs;

   IMAGE_SECTION_HEADER    section;

   USHORT  coff_flags;
   ULONG  export_rva;

   int  i, opt_header_size;
   long NT_headers_offset;
   

   filename = CSTRING(argument);
   file = fopen(filename, "rb");  /* Opening binary file */ 

   if (file == NULL)
     return MLFALSE;

   if (fread(&dos_header, sizeof(IMAGE_DOS_HEADER), 1, file) != 1) {
     (void)fclose(file);
     return MLFALSE;
   }

   if (dos_header.e_magic != DOS_MAGIC) {
     (void)fclose(file);
     return MLFALSE;
   }

   NT_headers_offset =  dos_header.e_lfanew;

   if (fseek(file, NT_headers_offset, SEEK_SET)) {
     (void)fclose(file);
     return MLFALSE;
   }

   if (fread(&NT_sig, 4, 1, file) != 1) {
     fclose(file);
     return MLFALSE;
   }

   if (NT_sig != IMAGE_NT_SIGNATURE) {
     fclose(file);
     return MLFALSE;
   }

   /* Read COFF File Header */
   if (fread(&coff_header, sizeof(IMAGE_FILE_HEADER), 1, file) != 1) {
     fclose(file);
     return MLFALSE;
   }

   coff_flags = coff_header.Characteristics;
   if ((coff_flags & IMAGE_FILE_DLL) == 0) {
     fclose(file);
     return MLFALSE;
   }


   /* Get size of `optional' header */
   opt_header_size = coff_header.SizeOfOptionalHeader;

   if (opt_header_size <= 0) {
     fclose(file);
     return MLFALSE;
   }

   /* Read `optional' header */
   if (fread(&opt_header, opt_header_size, 1, file) != 1) {
     fclose(file);
     return MLFALSE;
   }

   /* Get pointer to Data Directories */
   pddirs = opt_header.DataDirectory;

   /* Get no. of sections */
   sections = coff_header.NumberOfSections;

   if (sections <= 0) {
     fclose(file);
     return MLFALSE;
   }

   /* Allocate space for section headers */
   sec_hdrs = (IMAGE_SECTION_HEADER *)malloc(sections * sizeof(IMAGE_SECTION_HEADER));

   /* Read in the section headers */
   for( i=0 ; i < sections; i++) {
     if (fread(&section, sizeof(IMAGE_SECTION_HEADER), 1, file) != 1) {
       fclose(file);
       cleanup_open_symtab();
       return MLFALSE;
     };

     sec_hdrs[i] = section;
   };

   /* Get the RVA for the export section */
   export_rva  = pddirs[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;

   if (export_rva == (ULONG)NULL) {
     fclose(file);
     cleanup_open_symtab();
     return MLFALSE;
   };

   if ((symtab= get_export_symtab(export_rva)) == 0) {
     fclose(file);
     cleanup_open_symtab();
     return MLFALSE;
   }
   
   /* Initialisation completed */
   cleanup_open_symtab();

   /* Set Global Variables */
   entries = symtab -> Size;
   entry = 0;
   return MLTRUE;
}

static void cleanup_open_symtab(void)
{
   sections = entry = entries = -1;

   if (NULL != sec_hdrs) free(sec_hdrs);
}

static mlval next_symtab_entry(mlval argument)
{
  char strbuf[BUFSIZ];
  export_entry item;

  if ((entries >= 0) && (entry >= entries)) {
    return(ml_string(""));
  };

  item = (symtab -> Table)[entry];

  sprintf(strbuf,"%s c %d 0x%x", item.Name, item.Ordinal, item.Code);

  entry++;

  return(ml_string(strbuf));
}


static mlval close_symtab_file(mlval argument)
{

   fclose(file);      /* Close the file descriptor     */

   entry = entries = -1;

   free(symtab -> Table);
   free(symtab);

   return(MLUNIT);
}

static export_symtab *get_export_symtab (ULONG rva)
{
   IMAGE_SECTION_HEADER  *psecn;
   IMAGE_EXPORT_DIRECTORY  export_dir;

   export_entry  *table;

   char   **names;       /* Table of (char *)  */
   USHORT *ordinals;     /* Table of USHORT    */
   void   **codes;       /* Table of (void *)  */

   export_entry  entry;

   ULONG  secn_fp, export_fp, names_fp, anames_fp, ordinals_fp, codes_fp;
   ULONG  secn_rva, names_rva, anames_rva, ordinals_rva, codes_rva;

   int  i, entries;

   psecn = RVA_to_psection (rva);

   secn_rva = psecn -> VirtualAddress;     /* RVA of section          */
   secn_fp  = psecn -> PointerToRawData;   /* File pointer to section */

   export_fp = secn_fp + (rva - secn_rva);

   /* Seek to export section file pointer ... */
   if (fseek(file, export_fp, SEEK_SET))
     return (export_symtab *)0;

   /* ... and read the export directory structure */
   if (fread(&export_dir, sizeof(export_dir), 1, file) != 1)
     return (export_symtab *)0;

   entries = export_dir.NumberOfNames;

   table = (export_entry *)malloc(entries * sizeof(export_entry));

   names_rva  = (ULONG)export_dir.AddressOfNames;
   names_fp   = secn_fp + (names_rva - secn_rva);

   /* Names_fp now points at the ADDRESS of the actual RVA for the name table */
   fseek(file,names_fp,SEEK_SET);

   /* Read the actual names rva */
   fread(&anames_rva,sizeof(void *),1,file);

   /* Converting the actual names rva to a file pointer */
   anames_fp   = secn_fp + (anames_rva - secn_rva);
   fseek(file,anames_fp,SEEK_SET);

   if ((names= get_name_table(entries)) == (char **)0) {
     free(table);
     return (export_symtab *)0;
   }


   ordinals_rva  = (ULONG)export_dir.AddressOfNameOrdinals;
   ordinals_fp   = secn_fp + (ordinals_rva - secn_rva);

   fseek(file,ordinals_fp,SEEK_SET);
   ordinals = (USHORT *)malloc(entries * sizeof(USHORT));
   fread(ordinals,sizeof(USHORT),entries,file);

   codes_rva  = (ULONG)export_dir.AddressOfFunctions;
   codes_fp   = secn_fp + (codes_rva - secn_rva);

   fseek(file,codes_fp,SEEK_SET);
   codes = (void **)malloc(entries * sizeof(void *));
   fread(codes,sizeof(void *),entries,file);

   /* Transfer information to symtab */
   for (i=0; i < entries; i++) {
      entry.Name     = names[i];
      entry.Ordinal  = ordinals[i];
      entry.Code     = codes[i];
      table[i]       = entry;
   };

   free(codes);
   free(ordinals);
   free(names);

   symtab = (export_symtab *)malloc(sizeof(export_symtab));
   symtab -> Size  = entries;
   symtab -> Table = table;

   return symtab;
}


IMAGE_SECTION_HEADER *RVA_to_psection(ULONG rva)
{
    IMAGE_SECTION_HEADER *psecn;
    unsigned long secn_rva, secn_top;
    int i;

    for (i=0; i < sections; i++) {
       psecn = &sec_hdrs[i];
       secn_rva = psecn -> VirtualAddress;
       secn_top = secn_rva + section_size (psecn);
       if ((secn_rva <= rva) && (rva < secn_top))
         return(psecn);
    };

    return((IMAGE_SECTION_HEADER *)NULL);
}

ULONG section_size (IMAGE_SECTION_HEADER *psecn)
{
    return(psecn -> Misc.VirtualSize);
}

char **get_name_table(int num_str)
{
   char input[BUFSIZ];

   char **names;
   char *table;
   int i, j, size, first;
   long posn;

   if (num_str < 1)
     return ((char **)NULL);

   posn = ftell(file);

   /* Compute size of string table incl. terminating NULL's */
   size = 0;
   i = num_str;
   while (i > 0) {
       if (fscanf(file,"%s",input) == 1) {
	 i--;
	 size += strlen(input) + 1;
       } else {
	 return (char **)0;
       }
   }       


   /* Reset file pointer to beginning of string table */
   fseek (file,posn,SEEK_SET);

   /* Allocate heap memory and (re)read the string table into it */  
   table = (char *)malloc (size);
   fread ((void *)table,1,size,file);

   /* Create name table */
   names = (char **)malloc(num_str * sizeof(char *));

   /* Scan down string table, entering string ptrs into name table */
   first = 1;
   j = 0;
   for (i=0; j < num_str; i++) {
     if (first != 0) {
       names[j] = &table[i];
       j++;
     };
     first = (table[i] == 0);
   };

   return (names);
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
