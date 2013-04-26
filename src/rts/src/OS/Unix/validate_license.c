/*  === LICENSE VALIDATION ===
 *
 *  Copyright (C) 1992, 1998 Harlequin Group plc
 *
 *  Implementation
 *  --------------
 *  Use SHA and writes to . files
 *
 *  Revision Log
 *  ------------
 *  
 *  $Log: validate_license.c,v $
 *  Revision 1.3  1998/08/03 15:11:09  jkbrook
 *  [Bug #30456]
 *  Make license code-check offset calculation platform-specific
 *  initially to support the reclassification of Linux
 *
 * Revision 1.2  1998/07/20  13:20:02  jkbrook
 * [Bug #30435]
 * Initialise output string in both gui and tty versions
 *
 * Revision 1.1  1998/07/15  15:08:22  jkbrook
 * new unit
 * [Bug #30435]
 * Standalone license-validator and dot-file writer
 *
 * 
 */

#include <unistd.h>		/* sleep, gethostid */

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "values.h"
#include "hqn_ls.h"
#include "sha.h"
#include "mlw_mklic.h"
#include "license.h"
#include "version.h"
#include "validate_license.h"
#include "license_offset.h"

#ifndef NULL
#define NULL 0
#endif

static const char * code_file_stem = "/.mlworks_license";
static const char * name_file_stem = "/.mlworks_user";

int license_failure_hang = 1;

int act_as_free = 0;

#ifdef Solaris_License /* Only needed on Solaris */
#include <sys/systeminfo.h>
/* These next to allow the license client to link correctly */

extern void bzero(void *a, size_t b);
extern void bzero(void *a, size_t b)
{
  memset(a,0,b);
}

extern void bcopy(const void *a, void *b, size_t c);
extern void bcopy(const void *a, void *b, size_t c)
{
  memcpy(b,a,c);
}

extern long gethostid(void);
extern long gethostid(void)
{
  char buff [300];
  char *end;
  if (sysinfo (SI_HW_SERIAL,buff, 287) == -1)
    return -1;
  return (strtoul(buff,&end,10) | (buff == end ? -1 : 0));
}
#endif

#define BUF_SIZE 1024

/* write_file writes a line to "file" in the user's home directory */
static int write_file(const char *file, char *buffer)
{
  char* path;
  char* home;
  FILE *f;

  home = getenv("HOME");

  if (home == NULL)
    goto could_not_determine_home;

  if (strlen(home)+strlen(file) > BUF_SIZE-1)
    goto buffer_too_small;

  path = malloc(BUF_SIZE);

  if (path == NULL) {
    fprintf (stderr,"Can't malloc filename string\n");
    goto malloc_failed;
  }

  strcpy(path,home);
  strcat(path,file);

  f = fopen(path, "w");
  if (f == NULL) {
    fprintf(stderr, "Could not open %s for writing", path);
    goto could_not_open_file;
  }
  if (fputs(buffer,f) == -1)
    goto could_not_write;

  if (fclose(f) == -1) {
    fprintf(stderr,"Could not flush data to %s", path);
    goto could_not_flush;
  }
  free(path);
  return 1;

 could_not_write:
  fclose(f);
 could_not_flush:
 could_not_open_file:
  free(path);
 malloc_failed:
 buffer_too_small:
 could_not_determine_home:
  return 0;
}

/* license_store stores the license and its encoded form in the file system. */

extern int license_store(char * name)
{
  int result;
  SHA_INFO sha_info;
  char *input, *sha_result;
  long hostid = gethostid();
  int len;

  char * foo;
  char * code_file;

  foo = malloc(strlen(name_file_stem) + strlen(VERSION_STR) + 1);
  code_file = malloc(strlen(code_file_stem) + strlen(VERSION_STR) + 1);


  strcpy(foo,name_file_stem);
  strcpy(code_file,code_file_stem);

  strcat(foo,VERSION_STR);
  strcat(code_file,VERSION_STR);

  code_file[strlen(code_file_stem) + strlen(VERSION_STR)] = '\0';
  foo[strlen(name_file_stem) + strlen(VERSION_STR)] = '\0';

  len = strlen(name);
  input = malloc(len+sizeof(long)+1);
  if (input == NULL)
    fprintf(stderr,"malloc failed");
  strcpy(input,name);
  memcpy(&input[len],(char*)&hostid,sizeof(long));
  input[len+sizeof(long)] = '\0';
  
  sha_string(&sha_info, input,len+sizeof(long));
  sha_result = sha_sprint(&sha_info);


  result = (write_file(foo, name) && write_file(code_file, sha_result));

  free(input);
  free(sha_result);
  return result;
}

/* Users are given their license name and a 15-character check string.  The
 * last 6 characters of this string are the expiry date, in the format ddmmyy.
 * The 6 characters before that are the install-by date, also as ddmmyy.
 * The 1 character before that encodes the edition.
 * The first 8 characters are the last 8 characters
 * of the result of hashing the name, edition, installation date and 
 * expiry date. CHECK_CHARS, EDITION_CHARS and DATE_CHARS are defined in 
 * rts/src/sha/mlw_mklic.h
 */

/* conversion from base 36 to decimal */

static int base_36_to_decimal (char d)
{
  int result;

  if (isalpha(d))
    result = ((int)(tolower(d)) - (int)('a')) + 10;
  else
    result = (int)(d) - (int)('0');

  return result;
};

/* conversion from input format of SHA (upper case and omitting 0,1) to
internal format */

static char * convert_code (char * code_string) 
{
  
  char *result;
  int i;

  result = malloc(CHECK_CHARS);

  strncpy(result, code_string, CHECK_CHARS);

  for (i = 0; i < CHECK_CHARS; i++) {
     if (result[i] == '@') {
       result[i] = '0';
     } else if (result[i] == '%') {
       result[i] = '1';
     } else if (isalpha(result[i])) {
       result[i] = tolower(result[i]);
     };
  };

  return result;
};

/* check_date checks that the current date is before the date argument.
 * Its argument is a pointer to the expiry/install-by date, which is 
 * assumed to be DATE_CHARS long.  It is not assumed to be null-terminated  
 * after these chars.  
 */

static int check_date(char *date)
{
  struct tm *tm;
  char year_36, month_36, day_36;
  int year, month, day;
  time_t now;

  /* if sscanf fails here it may mean that we are checking an old license
   * with expiry date of form mmyy.  An appropriate message should
   * be printed (rather than license expired as here).
   */

  if (sscanf (date, "%1c%1c%1c", &day_36, &month_36, &year_36) < 3)
    return 0;

  /* convert back to decimal and remove offset */

  day = base_36_to_decimal(day_36) - 2;
  month = base_36_to_decimal(month_36) - 2;
  year = base_36_to_decimal(year_36) - 2;

  /* convert back to last-two-digits-of-year format in decimal */
  if (year < 10)
    year += 90;  /* C20 dates */
  else 
    year -= 10;  /* C21 dates */

  if (year < 90)
    year += 100;

  if (time(&now) < 0)
    return 0;
  tm = localtime(&now);
  /* struct tm numbers months from 0, whereas we number them from 1. */
  if (tm->tm_year > year || 
      (tm->tm_year == year && tm->tm_mon >= month) ||
      (tm->tm_year == year && tm->tm_mon == (month - 1) && tm->tm_mday > day)) {
    return 0;
  }
  /* Don't free tm; it's a static value in the library. */
  return 1;
}

static int check_chars(char *code_string) 
{
   int len, i;

   len = strlen(code_string);
 
   for (i = 0; i < len; i++) {
     if (code_string[i] == '0' || code_string[i] == '1' || islower(code_string[i])) {
       return 0;
     }
   }
   return 1;
}


/* license_validate checks that the user's input is valid. */
/* string * string -> license_check_result */

extern enum license_check_result license_validate (char * name, char * check)
{
  SHA_INFO sha_info;
  char *input, *sha_result, *convert_check, *convert_name;
  enum license_check_result result;
  int i;

  /* The validation algorithm takes the name, appends the edition
     and the installation and expiry dates, calls SHA, and compares the
     last ten digits of the result with the first ten of the check
     digits after tranformation to restore 0 and 1. 
  */

  if (strlen(check) != CHECK_CHARS + EDITION_CHARS + (2 * DATE_CHARS)) {
    fprintf (stderr, "License code has %d characters (should be %d)\n", strlen(check), CHECK_CHARS + EDITION_CHARS + (2 * DATE_CHARS));
    return MLFALSE;
  }

  if (!check_chars(check)) {
    result = ILLEGAL_CHARS;
    return(result);
  }
 
  convert_check = convert_code(check);

  convert_name = malloc(strlen(name) + 1);

  for (i = 0; i < strlen(name) + 1; i++) {
     convert_name[i] = tolower(name[i]);
  };

  input = malloc(strlen(name) + EDITION_CHARS + (2 * DATE_CHARS) + 1);
  if (input == NULL)
    fprintf(stderr,"malloc failed");

  strcpy (input, convert_name);
  strcat (input, convert_code(check+CHECK_CHARS));

  sha_string(&sha_info,input,strlen(input));
  sha_result = sha_sprint(&sha_info);


  /* Validation results:
   * INVALID => license invalid (check failed)
   * OK => license OK wrt to installation and expiry dates
   * INSTALLDATE => installation date passed
   * EXPIRED => expiry date passed 
   * WRONG_EDITION => license is for a different edition
   * ILLEGAL_CHARS => code contains zero or one
   */
  
  /* default */
  result = INVALID;

  if (!strncmp(convert_check, &sha_result[license_offset(strlen(sha_result))], CHECK_CHARS)) {
      /* check installation date */
       if (check_date(check+CHECK_CHARS+EDITION_CHARS)) {
         if (check_date(&check[CHECK_CHARS+EDITION_CHARS+DATE_CHARS])) {
           result = OK;
         } else {
           result = EXPIRED;
         }
       } else {
         result = INSTALLDATE;
       }
  } else {
    result = INVALID;
  }

  free(input);
  free(sha_result);
  free(convert_name);

  return result;
}

