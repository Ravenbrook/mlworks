/*  ==== PERVASIVE STRINGS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: strings.c,v $
 *  Revision 1.10  1998/02/23 18:33:25  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.9  1996/06/04  14:15:36  io
 * add exn Size
 *
 * Revision 1.8  1996/05/03  14:04:18  matthew
 * Fixing problem with string equality -- compare the terminating bytes too!.
 *
 * Revision 1.7  1995/08/02  10:59:26  nickb
 * GC root error in implode_char().
 *
 * Revision 1.6  1995/05/26  10:53:26  matthew
 * Changing interface to implode_char function -- now takes a size parameter
 *
 * Revision 1.5  1995/05/23  10:50:46  daveb
 * Added unsafe_string_substring.
 *
 * Revision 1.4  1995/03/17  12:21:46  matthew
 * Adding implode_char function
 *
 * Revision 1.3  1994/07/11  14:09:54  matthew
 * Added "internal" entry points for string le & ge, for the convenience of
 * new lambda optimiser.
 *
 * Revision 1.2  1994/06/09  14:43:04  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:11:18  nickh
 * new file
 *
 *  Revision 1.7  1994/01/28  17:39:52  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.6  1993/09/02  14:25:02  jont
 *  Merging in bug fixes
 *
 *  Revision 1.5.1.2  1993/09/02  13:27:01  jont
 *  Modified concatenate to return one of the original strings if the other is empty
 *
 *  Revision 1.5.1.1  1993/03/30  16:38:41  jont
 *  Fork for bug fixing
 *
 *  Revision 1.5  1993/03/30  16:38:41  jont
 *  Minor efficiency improvement for imploding lots of single character strings
 *
 *  Revision 1.4  1993/02/01  16:04:37  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.3  1993/01/14  15:19:29  daveb
 *  Changed explode to use new representation of lists.
 *
 *  Revision 1.2  1992/11/17  15:00:38  jont
 *  Modified to use poly_eq for string eq and sparc coded versions
 *  of string < and >
 *
 *  Revision 1.1  1992/10/23  16:01:39  richard
 *  Initial revision
 *
 */

#include <string.h>

#include "strings.h"
#include "gc.h"
#include "allocator.h"
#include "mltypes.h"
#include "values.h"
#include "environment.h"
#include "exceptions.h"

static mlval string1, string2, stringlist;

#ifdef MACH_STRINGS

#include "mach.h"

#else /* use a C version */

/*  === STRINGS ===
 *
 *  NOTE: The current definitions of string_less() and string_greater() are
 *  incorrect as they do not take into account signed or unsigned
 *  characters.  ML requires unsigned comparison.
 */

static mlval string_equal(mlval argument)
{
  char *s1 = CSTRING(FIELD(argument, 0)),
       *s2 = CSTRING(FIELD(argument, 1));
  int length1 = LENGTH(GETHEADER(FIELD(argument,0)));
  int length2 = LENGTH(GETHEADER(FIELD(argument,1)));

  if(length1 == length2 && memcmp(s1, s2, (size_t) length1) == 0)
    return(MLTRUE);

  return(MLFALSE);
}

static mlval string_not_equal(mlval argument)
{
  char *s1 = CSTRING(FIELD(argument, 0)),
       *s2 = CSTRING(FIELD(argument, 1));
  int length1 = LENGTH(GETHEADER(FIELD(argument,0)));
  int length2 = LENGTH(GETHEADER(FIELD(argument,1)));

  if(length1 == length2 && memcmp(s1, s2, (size_t) length1) == 0)
    return(MLFALSE);

  return(MLTRUE);
}

static mlval string_less(mlval argument)
{
  char *s1 = CSTRING(FIELD(argument, 0)),
       *s2 = CSTRING(FIELD(argument, 1));
  int length1 = LENGTH(GETHEADER(FIELD(argument, 0)));
  int length2 = LENGTH(GETHEADER(FIELD(argument, 1)));
  int result;

  result = memcmp(s1,s2,(size_t)((length1 < length2) ? length1 : length2));
  return(MLINT((result < 0) || ((result == 0) && (length1 < length2))));
}

static mlval string_greater(mlval argument)
{
  char *s1 = CSTRING(FIELD(argument, 0)),
       *s2 = CSTRING(FIELD(argument, 1));
  int length1 = LENGTH(GETHEADER(FIELD(argument, 0)));
  int length2 = LENGTH(GETHEADER(FIELD(argument, 1)));
  int result;

  result = memcmp(s1,s2,(size_t)((length1 < length2) ? length1 : length2));
  return (MLINT((result > 0) || ((result == 0) && (length1 > length2))));
}

#endif /* MACH_STRINGS */

static mlval unsafe_substring(mlval argument)
{
  int start = CINT(FIELD(argument,1));
  int length = CINT(FIELD(argument,2));
  int bound;
  mlval result;

  string1 = FIELD(argument, 0);
  bound = LENGTH(GETHEADER(string1)) - 1;

  result = allocate_string((size_t) (length+1));
  memcpy(CSTRING(result), CSTRING(string1) + start, (size_t) length);
  CSTRING(result)[length] = '\0';

  string1 = MLUNIT;

  return(result);
}

static mlval concatenate(mlval argument)
{
  size_t length1, length2;
  mlval result;

  string1 = FIELD(argument, 0);
  string2 = FIELD(argument, 1);
  length1 = LENGTH(GETHEADER(string1)) - 1;
  length2 = LENGTH(GETHEADER(string2)) - 1;

  if (length1 == 0) {
    result = string2;
    string1 = string2 = MLUNIT;
    return (result);
  } else if (length2 == 0) {
    result = string1;
    string1 = string2 = MLUNIT;
    return (result);
  };
  result = allocate_string(length1 + length2 + 1);

  memcpy(CSTRING(result), CSTRING(string1),length1);
  memcpy(CSTRING(result) + length1, CSTRING(string2), length2 + 1);

  string1 = string2 = MLUNIT;

  return(result);
}

static mlval explode(mlval argument)
{
  mlval result;
  size_t length = CSTRINGLENGTH(argument);

  string1 = argument;
  stringlist = MLNIL;

  while(length > 0)
  {
    mlval *start;
    size_t chunk = allocate_multiple(4, length, &start);

    if(chunk > 0)
    {
      char *string = CSTRING(string1);
      mlval *cell, list = stringlist;
      size_t i;

      for(i=0, cell=start; i<chunk; ++i, --length, cell+=4)
      {
	cell[0] = MLPTR(POINTER, &cell[2]);
	cell[1] = list;
	cell[2] = MAKEHEAD(STRING, 2);
	((char *)&cell[3])[0] = string[length-1];
	((char *)&cell[3])[1] = '\0';
	list = MLPTR(PAIRPTR, &cell[0]);
      }

      stringlist = list;
    }
    else
    {
      char *string;
      mlval tmp;

      string2 = allocate_string(2);

      string = CSTRING(string2);
      string[0] = CSTRING(string1)[length-1];
      string[1] = '\0';

      tmp = allocate_record(2);
      FIELD(tmp, 0) = string2;
      FIELD(tmp, 1) = stringlist;
      stringlist = tmp;
      --length;
    }
  }

  result = stringlist;
  string1 = string2 = stringlist = MLUNIT;

  return(result);
}


/*  == Implode a list of strings into a string ==
 *
 *  This function scans the list twice: once to find the length, and
 *  again to build the result string.  This is undesirable, but
 *  inevitable if the function is to be completely general.  However,
 *  for short strings it might be possible to fill up a local buffer
 *  and copy it, and only resort to length counting for long strings.
 *
 *  Raises: Size
 */

static mlval implode(mlval argument)
{
  word length = 0;
  mlval result, list;
  char *res;
  list = stringlist = argument;

  while(!MLISNIL(list))
  {
    length += LENGTH(GETHEADER(MLHEAD(list))) - 1;
    list = MLTAIL(list);
  }

  if (length > ML_MAX_STRING)
  {
    exn_raise (perv_exn_ref_size);
  }

  result = allocate_string(length + 1);
  res = CSTRING(result);
  CSTRING(result)[length] = '\0';

  list = stringlist;
  length = 0;

  while(!MLISNIL(list))
  {
    mlval hd = MLHEAD(list);
    word l = LENGTH(GETHEADER(hd)) - 1;
    char *str = CSTRING(hd);
    if (l == 1) res[length++] = *str;
    else {
      memcpy(res + length, str, l);
      length += l;
    };
    list = MLTAIL(list);
  }

  stringlist = MLUNIT;

  return(result);
}

/* This variant implodes a list of integers 
 * parameter is char list * size 
 * Raises: Size
 */
static mlval implode_char(mlval argument)
{
  word length;
  mlval result, list;
  char *res;
  stringlist = FIELD (argument,0);
  length = CINT (FIELD (argument,1));

  if (length > ML_MAX_STRING){
    exn_raise (perv_exn_ref_size);
  }
  result = allocate_string(length + 1);
  res = CSTRING(result);
  CSTRING(result)[length] = '\0';

  list = stringlist;
  length = 0;

  while(!MLISNIL(list))
  {
    res[length++] = (char) (CINT (MLHEAD(list)) & 0xFF);
    list = MLTAIL(list);
  }

  stringlist = MLUNIT;

  return(result);
}

/* This is the single argument revised basis implode()
 * val implode : char list -> string
 * Raises: Size
 */
static mlval string_implode (mlval argument)
{
  word length = 0;
  mlval result, list;
  char *res;
  stringlist = list = argument;
  
  /* pass1: determine length of list */
  while (!MLISNIL(list)){
    length += 1;
    list = MLTAIL (list);
  }
  if (length > ML_MAX_STRING){
    exn_raise (perv_exn_ref_size);
  }
  /* pass2: copy characters to string */
  result = allocate_string (length + 1);
  res = CSTRING(result);
  CSTRING(result)[length] = '\0';
  
  list = stringlist;
  length = 0;
  while (!MLISNIL(list)){
    res[length++] = (char) (CINT (MLHEAD(list)) & 0xff);
    list = MLTAIL(list);
  }
  stringlist = MLUNIT;
  return (result);
}

/*  === INITIALISE ===  */

void strings_init()
{
  string1 = string2 = stringlist = MLUNIT;
  declare_root(&string1, 0);
  declare_root(&string2, 0);
  declare_root(&stringlist, 0);

#ifdef MACH_STRINGS
  env_asm_function("string equal", poly_equal);
  env_asm_function("string not equal", poly_not_equal);
  env_asm_function("string less", ml_string_less);
  env_asm_function("string greater", ml_string_greater);
#else
  env_function("string equal", string_equal);
  env_function("string not equal", string_not_equal);
  env_function("string less", string_less);
  env_function("string greater", string_greater);
#endif /* MACH_STRINGS */

  env_function("string concatenate", concatenate);
  env_function("string explode", explode);
  env_function("string implode", implode);
  env_function("string c implode char", implode_char);
  env_function("string implode char", string_implode);
  env_function("string unsafe substring", unsafe_substring);
}
