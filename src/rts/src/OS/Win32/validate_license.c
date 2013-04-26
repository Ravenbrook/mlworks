/*  === LICENSING ===
 *
 *  Based on a pruned down version of license.c
 *
 *  Copyright (C) 1992, 1998 Harlequin Ltd.
 *
 *  $Log: validate_license.c,v $
 *  Revision 1.3  1998/08/03 16:07:12  jkbrook
 *  [Bug #30456]
 *  Make license code-check offset calculation platform-specific
 *  initially to support the reclassification of Linux
 *
 * Revision 1.2  1998/07/30  13:49:47  mitchell
 * [Bug #30435]
 * Make sure alerts aren't buried under other windows
 *
 * Revision 1.1  1998/07/02  11:57:00  mitchell
 * new unit
 * Support for license validation and installation as part of a windows DLL
 *
 *
 */

#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <time.h>

#include "license.h"
#include "sha.h"
#include "mlw_mklic.h"
#include "version.h"
#include "license_offset.h"

static void msg(char *s)
{ 
   MessageBox (NULL, s, "Warning", MB_ICONWARNING | MB_TOPMOST);
}

/* open_mlworks_key opens the key where the license is stored in the
   registry */
static int open_mlworks_key(HKEY *result) {
  DWORD disposition;
  HKEY software;
 
  char * edition_key;

  static char key_stem[] = "Harlequin\\MLWorks\\";

  edition_key = malloc (strlen(key_stem) + strlen(VERSION_STR) + 1);
  strcpy(edition_key,key_stem);
  strcat(edition_key,VERSION_STR);

  if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, "SOFTWARE", 0, /* NULL, */
		    KEY_EXECUTE, &software) == ERROR_SUCCESS) {
    if (RegCreateKeyEx (software, edition_key, 0, NULL,
		        REG_OPTION_NON_VOLATILE, KEY_EXECUTE|KEY_WRITE, NULL,
		        result, &disposition) == ERROR_SUCCESS) {
      return 1;
 
    } else {
      msg(
         "Can't open `HKEY_LOCAL_MACHINE\\SOFTWARE\\Harlequin\\MLWorks'"
         " in the registry");
      free(edition_key); 
      return 0;
    }
  } else {
    msg(
       "Can't open `HKEY_LOCAL_MACHINE\\SOFTWARE' "
       "in the registry");
    free(edition_key); 
    return 0;
  }
}

/* license_store stores the license and its encoded form in the file system. */
/* string -> bool */
int license_store(char *name)
{
  int result = 0;
  HKEY hkey;
  SHA_INFO sha_info;
  DWORD serial_num;
  char *input, *sha_result;
  int len;

  len = strlen(name);
  if (!GetVolumeInformation("C:\\", NULL, 0, &serial_num,
			    NULL, NULL, NULL, 0))
    return 0;

  input = malloc(len + sizeof(DWORD) + 1);
  if (input == NULL) {
    msg("malloc failed"); 
    return(0);
  }
  strcpy(input,name);
  memcpy(input+len, (char*)&serial_num, sizeof(DWORD));
  input[len+sizeof(DWORD)] = '\0';

  sha_string(&sha_info, input, len + sizeof(DWORD));
  sha_result = sha_sprint(&sha_info);

  if (open_mlworks_key(&hkey))
    if ((RegSetValueEx(hkey, "User", 0, REG_BINARY,
		       name, strlen(name)) == ERROR_SUCCESS) &&
        (RegSetValueEx(hkey, "License", 0, REG_BINARY,
		       sha_result, strlen(sha_result)) == ERROR_SUCCESS))
      result = 1;
    else
      result = 0;
  else
    result = 0;

  free(input);
  /* free(sha_result); */

  return result;
}

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

  result[CHECK_CHARS] = '\0';

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

  if (sscanf (date, "%1c%1c%1c", &day_36, &month_36, &year_36) < 3) {
    msg("sscanf failed");
    return 0;
  };

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

  if (time(&now) < 0) {
    msg("time failed");
    return 0;
  }
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

static int convert_edition(char edition) 
{
  return (((edition - '0') - 2));
}

static int check_chars(char *code_string) 
{
  int len, i;

  len = strlen(code_string);

  for (i = 0; i < len; i++) {
    if (code_string[i] == '0' || code_string[i] == '1') {
      return 0;
    }
  }
  return 1;
}

/* license_validate checks that the user's input is valid, by repeating the
 * hash operation described above.
 */
/* string * string -> license_check_result */

enum license_check_result license_validate(char *name, char *check)
{
  SHA_INFO sha_info;
  char *input, *sha_result, *convert_check;

  /* The validation algorithm takes the name, appends the edition 
     and the installation and expiry dates, calls SHA, and compares the last
     ten digits of the result with the first ten of the check digits 
     after transformation to restore 0 and 1. 
  */
  if (strlen(check) != CHECK_CHARS + EDITION_CHARS + (2 * DATE_CHARS)) {
    msg(LICENSE_ERROR_INVALID);
    return(INVALID);
  }

  input = malloc(strlen(name) + EDITION_CHARS + (2 * DATE_CHARS) + 1);
  if (input == NULL) {
	msg("malloc failed"); return(INVALID); 
  }

  strcpy (input, name);
  strcat (input, convert_code(check + CHECK_CHARS));

  if (!check_chars(check)) {
    msg(LICENSE_ERROR_CHARS);
    return(ILLEGAL_CHARS);
  }

  convert_check = convert_code(check); 

  sha_string(&sha_info, input, strlen(input));
  sha_result = sha_sprint(&sha_info);
 
  /* Validation results:
   INVALID           license invalid (check failed)
   OK                license OK wrt to installation and expiry dates
   EXPIRED           expiry date passed
   INSTALLDATE       installation date passed
   WRONG_EDITION     license is for a different edition (e.g., student, personal)
  */

  if ((strncmp(convert_check, &sha_result[license_offset(strlen(sha_result))], CHECK_CHARS)) == 0) {
      /* check installation date */
    if (check_date (check+CHECK_CHARS+EDITION_CHARS)) {
	  if (check_date(&check[CHECK_CHARS+EDITION_CHARS+DATE_CHARS])) {
 		  return(OK);
	  } else {
	    msg(LICENSE_ERROR_EXPIRED);
		return(EXPIRED);
	  }
	} else {
	  msg(LICENSE_ERROR_INSTALL);
	  return(INSTALLDATE);
    }
  }
  
  msg(LICENSE_ERROR_INVALID);
  return(INVALID);
}


void cp_without_spaces(char *from, char *to)
{ int start = 0;
  int finish = strlen(from) - 1;
  int size;

  while (start <= finish && from[start] == ' ') start++;

  if (start < finish) 
    while (from[finish] == ' ') finish--;

  size = finish - start + 1;
  
  strncpy(to, &(from[start]), size);
  to[size] = 0;
}
 
__declspec( dllexport ) int validate_and_install_license(char *name, char *code);

int validate_and_install_license(char *name, char *code)
{
  /* strip off spaces at front and back, and convert name to lc */
  char pruned_name[80]; 
  char pruned_code[80]; 
  int i, code_size;

  cp_without_spaces(name, pruned_name);
  for (i = 0; pruned_name[i] != 0; i++) 
	pruned_name[i] = tolower(pruned_name[i]);
  cp_without_spaces(code, pruned_code);

  code_size = strlen(pruned_code);

  if (code_size < 4) {
    msg(LICENSE_ERROR_INVALID);
    return(FALSE);
  }
  
  if (license_validate(pruned_name, pruned_code) == OK) {
    char exp_date_chars[80];
    char edition_chars[2];
    strncpy(exp_date_chars, &(pruned_code[code_size - 3]), 3);
    exp_date_chars[3] = 0;
    strncpy(edition_chars, &(pruned_code[code_size - 7]), 1);
    edition_chars[1] = 0;
    strcat(exp_date_chars, edition_chars);
    strcat(exp_date_chars, pruned_name);
    return(license_store(exp_date_chars)); 
  } 
  else 
    return (FALSE);
}


BOOL __stdcall DllMain(HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved)
{
    switch( ul_reason_for_call ) {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:;
    }
    return TRUE;
}

