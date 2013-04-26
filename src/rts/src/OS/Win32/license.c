/*  === LICENSING ===
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Uses the Harlequin License Server, and a timer interrupt.
 * 
 *  $Log: license.c,v $
 *  Revision 1.29  1998/08/24 08:39:30  jkbrook
 *  [Bug #50100]
 *  Set default to PERSONAL when license info is not found during
 *  an interactive session
 *
 * Revision 1.28  1998/08/11  11:48:32  jkbrook
 * [Bug #50100]
 * Fix continuing into Personal edition when license is invalid
 * now edition names have changed
 *
 * Revision 1.27  1998/07/17  15:13:26  jkbrook
 * [Bug #30436]
 * Update edition names
 *
 * Revision 1.26  1998/07/13  15:06:14  jkbrook
 * [Bug #30435]
 * Add function to set edition to free
 * and remove validation and storage code
 *
 * Revision 1.25  1998/06/11  14:13:07  jkbrook
 * [Bug #30411]
 * Handle free copies of MLWorks
 *
 * Revision 1.24  1998/05/11  16:58:34  johnh
 * [Bug #30303]
 * read edition.
 *
 * Revision 1.23  1998/04/02  16:37:28  jkbrook
 * [Bug #30382]
 * Convert date-chars to lower case before converting back from base 36
 *
 * Revision 1.22  1998/03/11  17:46:20  jkbrook
 * [Bug #50044]
 * Licence codes should not contain 0 or 1
 * or lower-case letters
 *
 * Revision 1.21  1997/12/23  17:51:22  jont
 * [Bug #30150]
 * Ensure allocation for key values is large enough for trailing zero
 *
 * Revision 1.20  1997/10/15  13:54:11  jont
 * [Bug #20072]
 * check_edition can pass unterminated strings to atoi. Fix this
 *
 * Revision 1.19  1997/09/03  15:41:40  jkbrook
 * [Bug #30227]
 * Include mlw_mklic.h instead of register.h
 *
 * Revision 1.18  1997/08/07  17:05:30  jkbrook
 * [Bug #30223]
 *  Shortening license codes by using base 36 for date elements and
 *  reducing CHECK_CHARS from 10 to 8
 *
 * Revision 1.17  1997/08/04  13:48:08  jkbrook
 * [Bug #20072]
 * Adding edition info (e.g., student, personal) to licensing
 *
 * Revision 1.16  1997/08/01  14:45:21  jkbrook
 * [Bug #20073]
 * Added datatype license_check_result for more flexible reporting
 * of license validation/checking results.
 *
 * Revision 1.15  1997/08/01  13:36:03  jkbrook
 * [Bug #30223]
 * Shorten license codes by removing number
 *
 * Revision 1.14  1997/07/24  16:47:03  jkbrook
 * [Bug #20077]
 * Adding an install-by date
 *
 * Revision 1.13  1997/07/22  16:17:39  jkbrook
 * [Bug #20077]
 * License expiry should be to the nearest day
 *
 * Revision 1.12  1997/06/16  14:14:27  daveb
 * [Bug #30176]
 * Removed the version sub-key of the MLWorks key.
 *
 * Revision 1.11  1997/06/16  10:15:29  daveb
 * [Bug #30169]
 * Updated version strings for 2.0m0.
 *
 * Revision 1.10  1997/01/07  15:30:19  jont
 * [Bug #1884]
 * Distinguish invalid licenses from expired licenses
 *
 * Revision 1.9  1996/12/19  12:06:54  jont
 * [Bug #1838]
 * Add license to contact message
 *
 * Revision 1.8  1996/11/19  13:14:27  jont
 * [Bug #0]
 * Modify to use initial section of the code for checking
 * as opposed to unix version which uses the final section
 *
 * Revision 1.7  1996/11/13  15:41:26  daveb
 * Added expiry date to licenses.
 * Also corrected definition of license_error_string.
 *
 * Revision 1.6  1996/11/12  12:30:00  daveb
 * Updated expiry message.
 *
 * Revision 1.5  1996/11/12  09:56:25  daveb
 * Added license checking for Windows.
 *
 * Revision 1.4  1996/10/23  11:25:09  jont
 * [Bug #1693]
 * Add flag to indicate how to process license failure
 *
 * Revision 1.3  1996/10/22  14:28:34  jont
 * new unit
 * New license serving stuff
 *
 *
 */

#include "environment.h"
#include "allocator.h"
#include "license.h"
#include "mltypes.h"
#include "utils.h"
#include "values.h"
#include "sha.h"
#include "mlw_mklic.h"
#include "diagnostic.h"
#include "version.h"
#include <ctype.h>
#include <stdlib.h>
#include <windows.h>

int license_failure_hang = 1;
DWORD license_size = 20;  
DWORD line_size = 1024;

/* default to version with delivery capability for delivered apps */

enum edition license_edition = PROFESSIONAL;

/* default to trying to get edition from license if present */

int act_as_free = 0;

static char c_license_error_invalid[] = LICENSE_ERROR_INVALID;
static char c_license_error_expired[] = LICENSE_ERROR_EXPIRED;
static char c_license_error_installdate[] = LICENSE_ERROR_INSTALL;
static char c_license_error_version[] = LICENSE_ERROR_VERSION;
static char c_license_error_chars[] = LICENSE_ERROR_CHARS;

static mlval license_error_invalid(mlval arg)
{
  return ml_string(c_license_error_invalid);
}

static mlval license_error_expired(mlval arg)
{
  return ml_string(c_license_error_expired);
}

static mlval license_error_installdate(mlval arg)
{
  return ml_string(c_license_error_installdate);
}

static mlval license_error_version(mlval arg)
{
  return ml_string(c_license_error_version);
}

static mlval license_error_chars(mlval arg)
{
  return ml_string(c_license_error_chars);
}

static mlval mlw_license_check_result_make (enum license_check_result index)
{
  return MLINT(index);
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
      DIAGNOSTIC(1,"Could not open HKEY_LOCAL_MACHINE\\SOFTWARE\\%s",edition_key,0);
      message_stderr
        ("Can't open `HKEY_LOCAL_MACHINE\\SOFTWARE\\Harlequin\\MLWorks'"
         " in the registry");
      free(edition_key);
      return 0;
    }
  } else {
    message_stderr ("In license.c");
    message_stderr
      ("Can't open `HKEY_LOCAL_MACHINE\\SOFTWARE' "
       "in the registry");
    free(edition_key);
    return 0;
  }
}

static char* query_value (HKEY hkey, char* vkey)
{
  DWORD len = 0;
  char *buffer;
  int status;

  status = RegQueryValueEx(hkey, vkey, NULL, NULL, NULL, &len);
  if (status != ERROR_SUCCESS) {
    DIAGNOSTIC (1, "Can't find %s in the registry", vkey, 0);
    return NULL;
  }

  buffer = malloc(len+1);
  if (buffer == NULL) {
    DIAGNOSTIC (1, "Can't malloc license string", 0, 0);
    return NULL;
  }

  status = RegQueryValueEx(hkey, vkey, NULL, NULL, buffer, &len);
     
  if (status != ERROR_SUCCESS) {
    free(buffer);
    return NULL;
  }
  else {
    buffer[len] = '\0';
    return buffer;
  }

}

/* get_license returns the encoded license info from the registry. */
static int get_license(char **name, char **code)
{
  HKEY hkey;

  if (open_mlworks_key(&hkey)) {
    *name = query_value(hkey, "User");
    if (*name == NULL)
      return 0;

    *code = query_value(hkey, "License");
    if (*code == NULL) {
      free(*name);
      return 0;
    }

    return 1;
  }
  else {
    DIAGNOSTIC (1, "open_mlworks_key failed", NULL, NULL);
    return 0;
  }
}

static int base_36_to_decimal (char d)
{
   int result;

   if (isalpha(d))
     result = ((int)(tolower(d)) - (int)('a')) + 10;
   else
     result = (int)(d) - (int)('0');

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
    DIAGNOSTIC(1, "sscanf failed", 0, 0);
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
    DIAGNOSTIC(1, "time failed", 0, 0);
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

static mlval license_get_edition(mlval arg)
{
  if (act_as_free) {
    return MLINT(PERSONAL);
  } else {
    return MLINT(license_edition);
  }
}

/* used to default to PERSONAL when license is corrupt in registry
    but user continues into a session, since actual default is Personal */
/* unit -> edition */

static mlval license_set_edition(mlval arg)
{
   license_edition = PERSONAL;
   DIAGNOSTIC(1,"Setting edition to Personal",0,0);

   return 0;
}

static int convert_edition(char edition) 
{
  return (((edition - '0') - 2));
}

/* license_check checks an existing license */
/* unit -> license_check_result */
/* Returns
 * NOT_FOUND        No license found -- run as Free
 * INVALID          License found but invalid
 * OK               License found and ok -- run as non-Free
 * EXPIRED          License found but expired
 * ILLEGAL_CHARS    Code contains zero or one
 */
static mlval license_check(mlval arg)
{
  char *name, *code;
  mlval result = MLUNIT;

  /* default for interactive versions */

  license_edition = PERSONAL;

  if (get_license(&name, &code)) {
    SHA_INFO sha_info;
    char *input, *sha_result;
    DWORD serial_num;
    int len;

    if (!GetVolumeInformation("C:\\", NULL, 0, &serial_num,
			      NULL, NULL, NULL, 0)) {
      result = mlw_license_check_result_make(NOT_FOUND);
      goto no_serial_num;
    }
    len = strlen(name);
    input = malloc(len + sizeof(DWORD) + 1);
    if (input == NULL)
      error("malloc failed");
    strcpy(input,name);
    memcpy(input+len, (char*)&serial_num, sizeof(DWORD));
    input[len + sizeof(DWORD)] = '\0';

    sha_string(&sha_info, input, len+sizeof(DWORD));
    sha_result = sha_sprint(&sha_info);


    if ((strcmp(sha_result,code) == 0)) {
	if (check_date(name)) {
	  DIAGNOSTIC (1, "License is valid", 0, 0);
          license_edition = convert_edition(name[DATE_CHARS]);
	  DIAGNOSTIC (1, "License edition set to %d", license_edition, 0);
	  result = mlw_license_check_result_make(OK);
	} else {
	  result = mlw_license_check_result_make(EXPIRED);
	}
    } else {
      result = mlw_license_check_result_make(INVALID);
    }

    free(input);
    free(sha_result);
 no_serial_num:
    free(name);
    free(code);
  } else {
    result = mlw_license_check_result_make(NOT_FOUND);
  }
  DIAGNOSTIC (1, "Edition is : %d", license_edition, 0);
  return result;
}

void license_release(void)
{
  /* No action required on Windows for this one */
}

void license_init(void)
{
  env_function("license check", license_check);
  env_function("license error expired", license_error_expired);
  env_function("license error invalid", license_error_invalid);
  env_function("license error install date", license_error_installdate);
  env_function("license error wrong version", license_error_version);
  env_function("license error illegal chars", license_error_chars);

  env_function("license get edition", license_get_edition);

  env_function("license set edition", license_set_edition);

  license_failure_hang = 1; /* Default wait for user interaction */
  act_as_free = 0; /* Default: check for license and set edition */

}

