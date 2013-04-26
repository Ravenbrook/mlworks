/*  === LICENSING ===
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
 *  Uses the Harlequin License Server, and a timer interrupt.
 *
 * 
 *  $Log: license.c,v $
 *  Revision 1.40  1999/03/25 12:40:07  mitchell
 *  [Bug #190509]
 *  Use magic numbers from a working version of hqn_ms...
 *
 * Revision 1.39  1999/03/19  17:25:20  mitchell
 * Add strings for new permit
 *
 * Revision 1.38  1999/03/09  16:00:18  mitchell
 * [Bug #190509]
 * Update version strings to 2.1
 *
 * Revision 1.37  1998/08/23  16:14:51  jkbrook
 * [Bug #50100]
 * Set default to PERSONAL when license info is not found during
 * an interactive session
 *
 * Revision 1.36  1998/08/13  14:02:10  jkbrook
 * [Bug #30469]
 * Update license permit secret values (hqn_ms output) for version 2.0
 *
 * Revision 1.35  1998/08/10  19:22:40  jkbrook
 * [Bug #50100]
 * Set edition to Personal in all cases where license is INVALID since
 * we now offer users the choice of continuing in these cases
 *
 * Revision 1.34  1998/08/04  10:46:16  jkbrook
 * [Bug #30456]
 * Update license server details to 2.0 for 2.0 checkpoint
 *
 * Revision 1.33  1998/07/21  11:01:44  jkbrook
 * [Bug #30436]
 * Update edition names
 *
 * Revision 1.32  1998/07/15  15:01:17  jkbrook
 * [Bug #30435]
 * Remove validation and storage code
 *
 * Revision 1.31  1998/06/19  18:53:59  jkbrook
 * [Bug #30411]
 * Change license-server version to enable daily to run until
 * we have new permits
 *
 * Revision 1.30  1998/06/19  14:33:47  jkbrook
 * [Bug #30411]
 * When license-server doesn't serve a license, don't prompt
 * for new license and silently default to free
 *
 * Revision 1.29  1998/06/19  11:02:19  jkbrook
 * [Bug #30411]
 * Update license server version for AAAI release
 *
 * Revision 1.28  1998/06/11  14:05:54  jkbrook
 * [Bug #30411]
 * Handle free copies of MLWorks
 *
 * Revision 1.27  1998/05/12  08:27:56  johnh
 * [Bug #30303]
 * get edition.
 *
 * Revision 1.26  1998/04/02  16:39:23  jkbrook
 * [Bug #30382]
 * Convert date chars to lower case before converting back from
 * base 36
 *
 * Revision 1.25  1998/03/12  14:05:00  jkbrook
 * [Bug #50044]
 * Licence codes should not include 0 or 1
 * or lower-case letters in input
 *
 * Revision 1.24  1998/01/23  17:22:11  jont
 * [Bug #20076]
 * Don't terminate running image on network license loss
 *
 * Revision 1.23  1997/10/15  14:24:41  jont
 * [Bug #20072]
 * check_edition can pass unterminated strings to atoi. Fix this
 *
 * Revision 1.22  1997/10/15  14:03:34  jont
 * [Bug #30282]
 * Fix type of gethostid to match spec in header files under Solaris 2.6
 *
 * Revision 1.21  1997/09/01  15:38:21  jkbrook
 * [Bug #30227]
 * Include mlw_mklic.h instead of register.h
 *
 * Revision 1.20  1997/08/08  09:00:20  jkbrook
 * [Bug #30223]
 * Shortening license codes by using base 36 for date elements and
 * reducing CHECK_CHARS from 10 to 8
 *
 * Revision 1.19  1997/08/04  09:44:08  jkbrook
 * [Bug #20072]
 * Adding edition info (e.g., student, personal) to licensing
 *
 * Revision 1.18  1997/08/01  14:06:54  jkbrook
 * [Bug #20073]
 * Added datatype license_check_result for more flexible reporting
 * of license validation/checking results.
 *
 * Revision 1.17  1997/08/01  13:35:24  jkbrook
 * [Bug #30223]
 * Shorten license codes by removing number
 *
 * Revision 1.16  1997/07/24  16:25:45  jkbrook
 * [Bug #20077]
 * Adding an install-by date
 *
 * Revision 1.15  1997/07/22  16:19:46  jkbrook
 * [Bug #20077]
 * License expiry should be to the nearest day
 *
 * Revision 1.14  1997/01/07  15:30:47  jont
 * [Bug #1884]
 * Distinguish invalid licenses from expired licenses
 *
 * Revision 1.13  1996/12/19  12:06:57  jont
 * [Bug #1838]
 * Add license to contact message
 *
 * Revision 1.12  1996/12/19  11:12:04  stephenb
 * [Bug #1874]
 * Add a #include <unistd.h> to pick up the prototype for
 * gethostid amongst other things.
 *
 * Revision 1.11  1996/12/10  16:37:52  daveb
 * Made the registration scheme be the default.
 *
 * Revision 1.10  1996/11/13  13:51:28  daveb
 * Fixed bug in conversion of error_string to an ml value: sizeof("....") includes
 * the trailing null.  Replaced the existing code with a call to ml_string.
 * Also removed the trailing newline from the error string.
 *
 * Revision 1.9  1996/11/12  17:00:50  daveb
 * Added an expiration date.
 *
 * Revision 1.8  1996/11/12  12:23:27  daveb
 * Updated expiry message.
 *
 * Revision 1.7  1996/11/12  11:54:17  daveb
 * Fixed a typo in the previous change, which won't compile without it.
 *
 * Revision 1.6  1996/11/11  14:53:37  daveb
 * Added support for registration-style licensing.
 *
 * Revision 1.5  1996/11/06  16:13:33  jont
 * Try to reacquire license if lost/timed out.
 * This should allow processes to be stopped and restarted
 *
 * Revision 1.4  1996/10/23  11:24:40  jont
 * [Bug #1693]
 * Don't hang on license failure when running in batch mode
 *
 * Revision 1.3  1996/10/22  10:35:04  jont
 * [Bug #1685]
 * Change printf into DIAGNOSTIC
 *
 * Revision 1.2  1996/10/18  16:51:18  jont
 * new unit
 * Moving from MLWorks_License_dev to trunk
 *
 * Revision 1.1.1.1  1996/10/15  15:51:19  jont
 * new unit
 * No longer platform specific, so moved to a common place
 *
 * Revision 1.2.2.4  1996/10/14  16:28:06  nickb
 * Improve error behaviour.
 *
 * Revision 1.2.2.3  1996/10/09  12:45:33  nickb
 * Call timer function.
 *
 * Revision 1.2.2.2  1996/10/08  16:15:16  jont
 * Start adding stuff to use HQN_LS
 *
 * Revision 1.2.2.1  1996/10/07  16:13:29  hope
 * branched from 1.2
 *
 * Revision 1.2  1995/02/23  15:41:38  nickb
 * Change assignment of pid.
 *
 * Revision 1.1  1994/07/08  10:43:07  nickh
 * new file
 *
 *
 */

#include <unistd.h>		/* sleep, gethostid */
#include "ansi.h"
#include "syscalls.h"
#include "utils.h"
#include "diagnostic.h"
#include "environment.h"
#include "allocator.h"
#include "license.h"
#include "signals.h"
#include "utils.h"
#include "values.h"
#include "x.h"
#include "hqn_ls.h"
#include "sha.h"
#include "mlw_mklic.h"
#include "version.h"
#include <errno.h>
#include <sys/errno.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define N_DATA_VALUES 4
#define N_CHALLENGES 4
#ifndef NULL
#define NULL 0
#endif

/* These messages are for the case where we find a corrupt license at 
the start of a session */

static char c_license_error_invalid[] = LICENSE_ERROR_INVALID;
static char c_license_error_expired[] = LICENSE_ERROR_EXPIRED;
static char c_license_error_installdate[] = LICENSE_ERROR_INSTALL;
static char c_license_error_version[] = LICENSE_ERROR_VERSION;
static char c_license_error_lost[] = "License expired or network error, continuing";
static char c_license_error_chars[] = LICENSE_ERROR_CHARS;

int license_failure_hang = 1;

int act_as_free = 0;

/* default to minimum edition allowing delivery (for use in executables) */
/* this is a global whose value is returned by "license get edition" */

enum edition license_edition = PROFESSIONAL;

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

#define PUBLISHER_NAME	"Harlequin Limited"
#define PRODUCT_NAME	"MLWorks Professional"
#define VERSION_STRING	"Version 2.1"

static int have_a_license = 0;
static int use_license_server = 0;

/* hqn_ms output follows: */
static hls_uint Chalvals[N_CHALLENGES] = {
    0x77d09eeb,
    0x1a7ca930,
    0x3503784,
    0x1c68674c,
};

static hls_uint Signature1[ 16 ] = {
0x6073b5fd, 0x6fa870bc, 0x33ec7a98, 0xbc559b3e,
0x28bfac6f, 0xdefee315, 0xa3a1fa0a, 0x7d7d47a9,
0x826a4563, 0xc4537919, 0xb20d401c, 0xb4776b5b,
0x1d2fc6dc, 0x8eb5dbde, 0x31896029, 0xbfa2f430,
};

static hls_uint Signature2[ 16 ] = {
0x27b7a68c, 0x11ac2c7, 0x5d3b781c, 0x7582c96d,
0xd709b161, 0x5ec6c22e, 0xc71d741d, 0xeb7d2733,
0xf290319c, 0x3e445a04, 0x539c8524, 0x7eca1455,
0xde49f718, 0xaf2342ed, 0x92d2424d, 0xed58d042,
};

static hls_uint Signature3[ 16 ] = {
0x7954b5df, 0xe3f45f21, 0x97b6a687, 0x9573df4d,
0xfc2e93f7, 0x588c6208, 0x2538b956, 0xf64b9b4f,
0x3f2d8521, 0x3e4158d6, 0xc80d2d05, 0x279e921b,
0xd7470970, 0xc61e3486, 0x61d3ae89, 0xee1feefb,
};

static hls_uint Signature4[ 16 ] = {
0xb78c9023, 0x369e1214, 0x418eef21, 0xe93480ca,
0xf88f1631, 0x7d41679e, 0x8572997, 0x7ceaae0c,
0xba9e8071, 0x7d2cd7eb, 0xb1ec8763, 0x8849b302,
0xb6bd93b3, 0xcba247bf, 0x873b734e, 0xd0e251dd,
};

/* the following made static (it is not in the hqn_ms output) */

static hls_uint *Signatures[ N_CHALLENGES ] = {
    Signature1,
    Signature2,
    Signature3,
    Signature4,
};

/* hqn_ms output ends */

static hls_int Databuf[ N_DATA_VALUES + 1];

static LSdata ls_data;

static void init_lsdata(LSdata *ldata,
			const char *LicenseSystem,
			const char *PublisherName,
			const char *ProductName,
			const char *VersionString)
{
  /* casts necessary because the struct defn doesn't have const qualifiers */
  ldata->LicenseSystem = (char*)LicenseSystem;
  ldata->PublisherName = (char*)PublisherName;
  ldata->ProductName   = (char*)ProductName;
  ldata->VersionString = (char*)VersionString;
  ldata->Nchals = N_CHALLENGES;
  ldata->Chalvals = Chalvals;
  ldata->Ndata = N_DATA_VALUES;
  ldata->Data = Databuf;
  ldata->Sig_Index = Signatures;
}

static mlval mlw_license_check_result_make (enum license_check_result index)
{
  return MLINT(index);
}

static void license_lost(void)
{
  x_reveal_podium();
  message(c_license_error_lost);
  message_stderr(c_license_error_lost);
}

static void license_found(void)
{
  x_hide_podium();
}

static int initialise(int starting)
{
  hls_int result;
  result = ls_initialise(&ls_data);
  DIAGNOSTIC(1, "License started with result %d", result, 0);
  if (ls_get_license(&ls_data)) {
    have_a_license = 1;
    if (starting)
      signal_license_timer(ls_data.UpPeriod);
    return 1;
  } else
    return 0;
}

static mlval license_start()
{
  init_lsdata(&ls_data, HQNLS_VERSION,
	      PUBLISHER_NAME,
	      PRODUCT_NAME,
	      VERSION_STRING);
  if (initialise(1)) { /* Starting */
    /* eventually we want to pick up edition info from the server */
    license_edition = PROFESSIONAL;
    env_value("license edition", license_edition);
    return mlw_license_check_result_make(OK);
  } else {
    /* if no licence found run as Free version */
    license_edition = PERSONAL;
    return mlw_license_check_result_make(NOT_FOUND);
  }
}

extern void license_release(void)
{
  if (have_a_license)
    ls_release_lic(&ls_data);
}

void refresh_license(void)
{
  if (use_license_server) {
    if (have_a_license) {
      if (ls_update_lic(&ls_data) == 0) {
	have_a_license = 0;
	if (!initialise(0)) /* Not starting */
	  license_lost();
      }
    } else {
      if (initialise(0)) /* Try to reacquire the license */
	license_found();
    }
  }
}

/*  Implementation 2
 *  ----------------
 *  Uses the SHA algorithm
 * 
 */

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

static const char * name_file_stem = "/.mlworks_user";
static const char * code_file_stem = "/.mlworks_license";

#define BUF_SIZE 1024

/* read_file reads a line from "file" in the user's home directory */
static int read_file(const char *file, char *buffer)
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
    DIAGNOSTIC (1, "Can't malloc filename string", 0, 0);
    goto malloc_failed;
  }

  strcpy(path, home);
  strcat(path, file);

  f = fopen(path, "r");
  if (f == NULL) {
    DIAGNOSTIC(1, "Could not open %s for reading", path, 0);
    goto could_not_open_file;
  }
  if (fgets(buffer, BUF_SIZE, f) == NULL)
    goto could_not_read;
  
  fclose(f);
  free(path);
  return 1;

 could_not_read:
  fclose(f);
 could_not_open_file:
  free(path);
 malloc_failed:
 buffer_too_small:
 could_not_determine_home:
  return 0;
}

/* get_license gets the encoded license info from the file system. */
static int get_license(char *name, char *code)
{
  char * name_file;
  char * code_file;

  name_file = malloc(strlen(name_file_stem) + strlen(VERSION_STR));
  code_file = malloc(strlen(code_file_stem) + strlen(VERSION_STR));

  strcpy(name_file,name_file_stem);
  strcpy(code_file,code_file_stem);
 
  strcat(name_file,VERSION_STR);
  strcat(code_file,VERSION_STR);

  if (read_file(name_file, name)
      && read_file(code_file, code))
    return 1;
  else
    return 0;
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

static mlval license_get_edition(mlval arg)
{
  if (act_as_free) {
    return MLINT(PERSONAL);
  } else {
    return MLINT(license_edition);
  }
}

/* unit -> edition */

static mlval license_set_edition(mlval arg)
{
  /* this is used to default to PERSONAL in case when license is
   corrupt but user continues into session, since real default is 
   Professional */

  license_edition = PERSONAL;
  DIAGNOSTIC(1, "Set license edition to Personal",0,0);

  return 0;
}

static int convert_edition(char edition)
{
  return (((edition - '0') - 2));
}

/* check_license_files checks an existing license */
/* unit -> license_check_result */
/* Returns
 * NOT_FOUND        No license found -- run as Free
 * INVALID          License found but invalid   
 * OK               License found and ok -- run as non-Free
 * EXPIRED          License found but expired   
 * WRONG_EDITION    License is for a different edition
 */

static mlval check_license_files (void)
{
  char *name;
  char *code;

  mlval result = MLUNIT;

  name = malloc (BUF_SIZE);
  if(name == NULL) {
    DIAGNOSTIC (1, "Can't malloc license name string", 0, 0);
    result = mlw_license_check_result_make(INTERNAL_ERROR);
    goto name_malloc_failed;
  }

  code = malloc (BUF_SIZE);
  if(code == NULL) {
    DIAGNOSTIC (1, "Can't malloc license code string", 0, 0);
    result = mlw_license_check_result_make(INTERNAL_ERROR);
    goto code_malloc_failed;
  }

  /* default for interactive sessions */

  license_edition = PERSONAL;

  if (get_license(name, code)) {
    SHA_INFO sha_info;
    char *input, *sha_result;
    long hostid = gethostid();
    int len;

    len = strlen(name);
    input = malloc(len+sizeof(long)+1);
    if (input == NULL)
      error("malloc failed");
    strcpy(input,name);
    memcpy(&input[len],(char*)&hostid,sizeof(long));
    input[len+sizeof(long)] = '\0';
  
    sha_string(&sha_info, input,len+sizeof(long));
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
  } else {
    result = mlw_license_check_result_make(NOT_FOUND);  
  }

  DIAGNOSTIC (1, "Edition is: %d", license_edition, 0);

  free(code);
 code_malloc_failed:
  free(name);
 name_malloc_failed:
  return result;
}

/* By default, license_check starts the license server.  If MLWORKS_LICENSE
 * is set to "keyfile" in the environment, it instead checks the stored
 * license, and prompts the user if necessary. 
 */
/* unit -> license_check_result */
static mlval license_check(mlval arg)
{
  char *license_setting;

  license_setting = getenv("MLWORKS_LICENSE");
  if (license_setting != NULL && (strcmp(license_setting,"server") == 0)) {
    use_license_server = 1;
    return license_start();
  } else {
    return check_license_files();
  }
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

  have_a_license = 0;
  use_license_server = 0;   /* Default use registration scheme */
  license_failure_hang = 1; /* Default wait for user interaction */
  act_as_free = 0;
}
