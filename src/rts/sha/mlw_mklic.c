/* MLWorks Registration generator
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: mlw_mklic.c,v $
 * Revision 1.12  1999/03/12 10:10:34  mitchell
 * [Bug #190509]
 * Update version strings for 2.1
 *
 * Revision 1.11  1998/08/04  16:23:19  jont
 * [Bug #70147]
 * Make sure version 1.1 asks for an eidtion type
 *
 * Revision 1.10  1998/08/03  13:55:28  jkbrook
 * [Bug #30457]
 * Change platform groupings to reflect pricing not OS
 *
 * Revision 1.9  1998/07/29  16:20:05  jont
 * [Bug #70001]
 * Ensure we call fflush after printf and fprintf
 *
 * Revision 1.8  1998/07/21  11:08:05  jkbrook
 * [Bug #30447]
 * Update to create 2.0b0 as well as 2.0 licences
 * and update edition names [30436]
 *
 * Revision 1.7  1998/06/11  19:19:34  jkbrook
 * [Bug #30411]
 * Drop BETA from legal editions
 * in v2.0
 *
 * Revision 1.6  1998/04/02  16:42:02  jkbrook
 * [Bug #30382]
 * Fix command-line argument passing for v2.0
 *
 * Revision 1.5  1998/03/10  11:12:49  jkbrook
 * [Bug #50044]
 * User-input v2.0 licence codes should not contain 0 or 1
 * or lower-case letters
 *
 * Revision 1.4  1997/12/30  18:39:43  jkbrook
 * [Bug #30310]
 * Merge from MLWorks_11r1:
 * License generator should accept all release version numbers
 * (no actual change -- combines two changes to 11r1)
 *
 * Revision 1.3  1997/09/03  17:32:31  jkbrook
 * [Bug #30227]
 * Improving string-handling code wrt Windows
 *
 * Revision 1.2  1997/08/29  14:57:03  jkbrook
 * [Bug #30227]
 * Restoring previous revision comments
 *
 * Revision 1.1  1997/08/29  14:46:33  jkbrook
 * new unit
 * Modified from MLWrts/src/sha/register_common.c and
 * MLWrts/src/OS/{Unix,Win32}/register.c
 *
 * Revision 1.6  1997/08/08  09:09:16  jkbrook
 * [Bug #30223]
 * Shortening license codes by using base 36 for date elements and
 * reducing CHECK_CHARS from 10 to 8
 *
 * Revision 1.5  1997/08/04  12:37:26  jkbrook
 * [Bug #20072]
 * Adding edition info (e.g., student, personal) to licensing
 *
 * Revision 1.4  1997/08/01  13:34:58  jkbrook
 * [Bug #30223]
 * Shorten license codes by removing number
 *
 * Revision 1.3  1997/07/24  16:48:52  jkbrook
 * [Bug #20077]
 * Adding an install-by date
 *
 * Revision 1.2  1997/07/22  16:23:49  jkbrook
 * [Bug #20077]
 * License expiry should be to the nearest day
 *
 * Revision 1.1  1996/11/19  14:09:10  jont
 * new unit
 * Platform independent part of the registerer
 *
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <ctype.h>
#include "mlw_mklic.h"
#include "sha.h"

#define BUF_SIZE 1024

/* need to provide backwards compatibility to old-style licenses for v1.0r2 */

enum license_type {V1_0, V1_1, V2_0b0, V2_0, V2_1};

static void error(const char *msg)
{
  fprintf(stderr, "%s\n", msg);
  fflush(stderr);
  exit(1);
}

static void error_digit(const char *msg, int d)
{
  fprintf(stderr, msg, d);
  fflush(stderr);
  exit(1);
}

static char *massage_string(char* str)
{
  char *result;
  char *cp1, *cp2, *cp3;
  int len;

  len = strlen(str);
  result = malloc(len + 1);
  if (result == NULL)
    error("malloc failed\n");

  for (cp1 = str; isspace(*cp1); cp1++);
  for (cp2 = str+len-1; isspace(*cp2); cp2--);
  for (cp3 = result; cp1 <= cp2; cp1++, cp3++)
    *cp3 = tolower(*cp1);
  *cp3 = '\0';
  return result;
}

/* validate input for license_type and return value of type license_type if
valid */

static enum license_type check_license_type(char *str)
{
  char *massaged_string;
  enum license_type result;

  massaged_string = massage_string(str);

  /* make newer license by default */

  result = V1_1;

  /* add new version numbers to this classification as they arise */

  if (strcmp(massaged_string,"v1.0r2") == 0) {
    result = V1_0;
  } else if (strcmp(massaged_string,"v1.1") == 0) {
    result = V1_1;
  } else if (strcmp(massaged_string,"v2.0b0") == 0) {
    result = V2_0b0;
  } else if (strcmp(massaged_string,"v2.0") == 0) {
    result = V2_0;
  } else if (strcmp(massaged_string,"v2.1") == 0) {
    result = V2_1;
  } else {
    error("Legal values for license type are v1.0r2, v1.1, v2.0b0, v2.0 or v2.1");
  };

  return result;
}

/* Some users have been confused by 0/O and 1/I/l, so we map 0,1 to
other characters and convert to upper case */

static char *convert_sha (char *raw_sha) {

  char *result;
  int i;

  result = malloc(CHECK_CHARS);

  strncpy(result, raw_sha, CHECK_CHARS);

  for (i = 0; i < CHECK_CHARS; i++) {
     if (result[i] == '0') {
       result[i] = '@';
     } else if (result[i] == '1') {
       result[i] = '%';
     } else if (isalpha(result[i])) {
       result[i] = toupper(result[i]);
     };
  };

  result[CHECK_CHARS] = '\0';

  return result;
};


static void print_license(const char *result, char *edition, char *inst_date, char *exp_date, char *platform, char *number, enum license_type lic_type) 
{
  int check_chars;
  char *code_string;

  if (lic_type == V1_0) {
    check_chars = V1_CHECK_CHARS;
  } else {
    check_chars = CHECK_CHARS;
  };

  code_string = malloc(check_chars + 1);


  /* platform has already been validated by check_platform */ 

  if (lic_type == V2_0 || lic_type == V2_1) {
    /* platforms are now divided into commericial unix vs. i386 */
    if ((strcmp(platform,"irix") == 0) ||
        (strcmp(platform,"solaris") == 0)) {
      memcpy(code_string, result + strlen(result)-check_chars, check_chars);
    } else if ((strcmp(platform,"linux") == 0) ||
               (strcmp(platform,"nt") == 0) ||
               (strcmp(platform,"win95") == 0)) {
             memcpy(code_string, result, check_chars);
    } else {
      error("Internal error: Illegal platform name passed to print_license");
    }
  } else {
    if (strcmp(platform,"unix") == 0) {
      memcpy(code_string, result + strlen(result)-check_chars, check_chars);
    } else if (strcmp(platform,"windows") == 0) {
      memcpy(code_string, result, check_chars);
    } else {
      error("Internal error: Illegal platform name passed to print_license");
    }
  };

  code_string[check_chars] = '\0';
 
  if ((lic_type == V2_0) || (lic_type == V2_0b0) || (lic_type == V2_1)) 
                code_string = convert_sha(code_string); 

  printf("The licence code is `%s", code_string);
  fflush(stdout);

  if (lic_type == V1_0) {
    printf("%s%s'\n", number, exp_date);
  } else if (lic_type == V1_1) {
    printf("%s%s%s'\n", edition, inst_date, exp_date);
  } else if ((lic_type == V2_0) || (lic_type == V2_0b0) || (lic_type == V2_1)) {
    printf("%s%s%s'\n", convert_sha(edition), convert_sha(inst_date), convert_sha(exp_date));
  };
  fflush(stdout);

  free(code_string);
}


static void print_result(char *name, char *edition, char *inst_date, char *exp_date, char *platform, char *number, enum license_type lic_type)
{
  SHA_INFO sha_info;
  char *input, *result;

  if (lic_type == V1_0) {
    input = malloc(strlen(name) + strlen(number) + strlen(exp_date) + 1);
  } else {
    input = malloc(strlen(name) + strlen(inst_date) + strlen(exp_date) + strlen(edition) + 1);
  };

  if (input == NULL)
    error("malloc failed\n");
  strcpy (input, name);
  if (lic_type == V1_0) {
    strcat (input, number);
  } else {
    strcat (input, edition);
    strcat (input, inst_date);
  }
  strcat (input, exp_date);

  sha_string(&sha_info, input, strlen(input));
  result = sha_sprint(&sha_info);
  print_license(result, edition, inst_date, exp_date, platform, number, lic_type);
  free(input);
  free(result);
}

static enum license_type get_inputs (int argc, char **argv, char* name, char *edition_name, char* inst_date, char* exp_date, char* platform, char* number)
{
  struct tm *tm;
  time_t now;
  char *default_date, *license_type_name;
  enum license_type lic_type;
  int i;
  unsigned int j, k;

  /* by default make newer licenses */
  lic_type = V1_1;

  license_type_name = malloc(BUF_SIZE);

  /* 5 is the minimum number of args for either license type */
  /* if given on the command line */

  if (argc < 5) {  
    /* first determine license type i.e., V1_0, V1_1, V2_0b0, V2_0 or V2_1 */
    printf("Licence type (i.e., v1.0r2, v1.1, v2.0b0, v2.0 or v2.1): ");
    fflush(stdout);
    fgets(license_type_name, BUF_SIZE, stdin);
    license_type_name[strlen(license_type_name)-1] = '\0';
    lic_type = check_license_type(license_type_name);

    /* always want platform and license name */
    if (lic_type == V2_0 | lic_type == V2_1) {
      printf("Platform (solaris, linux, irix, nt or win95): ");
    } else {
      printf("Platform (windows or unix): ");
    };
    fflush(stdout);
    fgets(platform, BUF_SIZE, stdin);
    printf("Licence name: ");
    fflush(stdout);
    fgets(name, BUF_SIZE, stdin);

    if (lic_type == V1_0) {
      printf("Licence number: ");
      fflush(stdout);
      fgets(number, BUF_SIZE, stdin);
    } else if (lic_type == V2_0b0 || lic_type == V1_1) {
      printf("Edition (e.g., beta, student, personal): ");
      fflush(stdout);
      fgets(edition_name, BUF_SIZE, stdin);
    } else if (lic_type == V2_0 || lic_type == V2_1) {
      printf("Edition (e.g., personal, professional): ");
      fflush(stdout);
      fgets(edition_name, BUF_SIZE, stdin);
    }
    /* (V1_1) IP_DATE_CHARS is used for default dates here for backwards
       compatibility and since base 36 conversion is done later anyway.
     */
    /* dates are input in decimal format (and converted to base 36 
       in v1.1 onwards).  In v2.0 offsets are also added later.
     */
    if (lic_type == V1_0) {
      printf("Expiry date (mmyy): ");
      fflush(stdout);
    } else {
      printf("Latest installation date (ddmmyy): ");
      fflush(stdout);
      fgets(inst_date, BUF_SIZE, stdin);
      printf("Expiry date (ddmmyy): ");
      fflush(stdout);
    };
    fgets(exp_date, BUF_SIZE, stdin);

    /* Strip trailing newlines */
    platform[strlen(platform)-1] = '\0';
    name[strlen(name)-1] = '\0';
    if (lic_type == V1_0) { 
      number[strlen(number)-1] = '\0';
    } else {
      edition_name[strlen(edition_name)-1] = '\0';
      inst_date[strlen(inst_date)-1] = '\0';
    };
    exp_date[strlen(exp_date)-1] = '\0';

  } else if ((argc >= 5) && (argc <= 7)) {
    /* all correct command-lines have between 5 and 7 args */
    strncpy(license_type_name, argv[1], BUF_SIZE);
    lic_type = check_license_type(license_type_name);

    /* always want platform and license name */
    strncpy(platform, argv[2], BUF_SIZE);
    strncpy(name, argv[3], BUF_SIZE);
    
    if (lic_type == V1_0) {
      strncpy(number, argv[4], BUF_SIZE);
    } else {
      strncpy(edition_name, argv[4], BUF_SIZE);
    }

    if ((argc == 6) && (lic_type == V1_0)) {
      strncpy(number, argv[4], BUF_SIZE);
      strncpy(exp_date, argv[5], BUF_SIZE);
    } else if ((argc == 7) && ((lic_type == V1_1) || (lic_type == V2_0) || (lic_type == V2_1))) {
      strncpy(inst_date, argv[5], BUF_SIZE);
      strncpy(exp_date, argv[6], BUF_SIZE);
    }
  } else {
      printf("Usage: mlw_mklic [v1.0r2 platform name number [mmyy]]\n");
      printf("       mlw_mklic [v1.1 platform name edition [ddmmyy ddmmyy]]\n");
      printf("       mlw_mklic [v2.0b0 platform name edition [ddmmyy ddmmyy]]\n");
      printf("       mlw_mklic [v2.0 platform name edition [ddmmyy ddmmyy]]\n");
      printf("       mlw_mklic [v2.1 platform name edition [ddmmyy ddmmyy]]\n");
      fflush(stdout);
      exit(2);
  }

  if (strlen(name) < 6)
    error("Licence name must contain at least 6 characters\n");


  for(j = 0; j < strlen(inst_date); j++) {
    if (!isdigit(inst_date[j])) 
      error("Illegal character(s) in latest installation date (should be ddmmyy)\n");
  };

  for(k = 0; k < strlen(exp_date); k++) {
    if (!isdigit(exp_date[k])) 
      error("Illegal character(s) in expiry date (should be ddmmyy)\n");
  };

  if (lic_type == V1_1 || lic_type == V2_0 || lic_type == V2_1 || lic_type == V2_0b0) {
     /* (v1.1 onwards) if installation or expiry date unspecified make it 
        30 days from now.
     */

    if (strlen(exp_date) == 0 || strlen(inst_date) == 0) {
      /* this is done here since we need to get lic_type from the
         command-line first 
       */
      default_date = malloc(IP_DATE_CHARS);
      time(&now); 
      now+=(30 * 24 * 3600); /* thirty days in seconds */
      tm = localtime(&now);
      sprintf(default_date,"%.2d%.2d%.2d",tm->tm_mday,(tm->tm_mon+1),tm->tm_year);
      /* if installation date unspecified make it 30 days from now */
      if (strlen(inst_date) == 0) {
        strcpy(inst_date,default_date);
      }
      /* if expiry date unspecified make it 30 days from now */
      if (strlen(exp_date) == 0) {
        strcpy(exp_date,default_date);
      };
    }
    if (strlen(inst_date) != IP_DATE_CHARS)
      error_digit("Latest installation date must contain exactly %d characters (ddmmyy)\n", IP_DATE_CHARS);
    if (strlen(exp_date) != IP_DATE_CHARS)
      error_digit("Expiry date must contain exactly %d characters (ddmmyy)\n", IP_DATE_CHARS);
  } else {
    if (strlen(exp_date) == 0)  {
      default_date = malloc(V1_DATE_CHARS);
      time(&now); 
      tm = localtime(&now);
      /* default expiry date in mmyy end of the next month, 
         i.e., tm-tm_mon_+2
      */
      sprintf(exp_date,"%.2d%.2d",(tm->tm_mon+2),tm->tm_year);
    };

    if (strlen(exp_date) != V1_DATE_CHARS)
      error_digit("Expiry date must contain exactly %d characters (mmyy)\n", V1_DATE_CHARS);
  };

  if (lic_type == V1_0) {
    i = atoi(number);
    if (i < 1 || i > 999)
    error("Licence number must be between 1 and 999\n");
    sprintf(number, "%.3d", i);
  }

  return lic_type;
}


/* validate edition input and convert to an integer */

static char *convert_edition(char *str, enum license_type lic_type) 
{
	
  char *massaged_string, *result;

  result = malloc(EDITION_CHARS);
  massaged_string = massage_string(str);

  if ((lic_type == V2_0b0) || (lic_type == V1_1)) {
    if (strcmp(massaged_string,"beta") == 0) {
       sprintf (result,"%.1d",OLD_BETA);
    } else if (strcmp(massaged_string,"personal") == 0) {
       sprintf (result,"%.1d",OLD_PERSONAL);
    } else if (strcmp(massaged_string,"student") == 0) {
       sprintf (result,"%.1d",OLD_STUDENT);
    } else {
       error("Legal values for edition are beta, student or personal");
    }
  } else if (lic_type == V2_0 || lic_type == V2_1) {
    if (strcmp(massaged_string,"personal") == 0) {
       sprintf (result,"%.1d",PERSONAL);
    } else if (strcmp(massaged_string,"professional") == 0) {
       sprintf (result,"%.1d",PROFESSIONAL);
    } else if (strcmp(massaged_string,"enterprise") == 0) {
       sprintf (result,"%.1d",ENTERPRISE);
    } else {
       error("Legal values for edition are personal, professional or enterprise");
    }
  };

  return result;
}

/* validate input for platform and return massaged name if valid */

static char *check_platform(char *platform, enum license_type lic_type) 
{
  char *result = massage_string(platform);

  if (lic_type == V2_0 || lic_type == V2_1) {
    if (!((strcmp(result,"irix") == 0) ||
         (strcmp(result,"solaris") == 0) ||
         (strcmp(result,"linux") == 0) ||
         (strcmp(result,"nt") == 0) ||
         (strcmp(result,"win95") == 0))) {
      error("Legal values for platform are irix, solaris, linux, nt and win95");
    }
  } else {
    if (!((strcmp(result,"unix") == 0) || (strcmp(result,"windows") == 0))) {
      error("Legal values for platform are unix or windows");
    }
  };

  return result;
}

/* Convert a decimal number between 0 and 35 to a base 36 (char) */

static char decimal_to_base_36 (int d)
{
  char result;

  if (d >= 0) {
    if (d < 10)
      result = (char)((int)('0') + d);
    else
      result = (char)((int)('a') + d - 10);
  } else {
    result = 0;
  };

  return result;
}

/* Convert a year in decimal yy format to that year expressed 
 * in terms of years since 1990 
 */

static unsigned char convert_year (int yy) 
{
  unsigned char result;

  /* default */
  result = 0;

  if (yy < 90) {
    if (yy > 25) {
      error("Year must be in the range 90-25 inclusive");
    } else {
      result = yy + 10; /* C21 dates from 1990 */ 
    }
  } else {
    result = yy - 90; /* C20 dates from 1990 */
  };

  return result;
}


static char *convert_date(char *date_string) 
{
  char *result; 
  int day, month, year;
  char day_36, month_36, year_36;

  result = malloc(DATE_CHARS);
  if (sscanf(date_string,"%2d%2d%2d",&day,&month,&year) < 3)
    return 0;

  day_36 = decimal_to_base_36(day);
  month_36 = decimal_to_base_36(month);
  year_36 = decimal_to_base_36(convert_year(year));

  sprintf(result,"%c%c%c",day_36,month_36,year_36);

  return result;
}

static char *offset_date(char *date_string) 
{
  char *result;
  int day, month, year; 

  result = malloc(DATE_CHARS);
  if (sscanf(date_string,"%2d%2d%2d",&day,&month,&year) < 3)
    return 0;

  /* don't want 0 or 1 to appear in the date so */
  sprintf(result,"%.2d%.2d%.2d",day+2,month+2,((year+2) % 100));

  return result;
}

static char *offset_edition(char *edition_string)
{
  char *result;
  int edition_code;

  result = malloc(EDITION_CHARS);

  if (sscanf(edition_string,"%2d",&edition_code) < 1)
    return 0;

  /* don't want 0 or 1 to appear in the edition code so */

  sprintf(result,"%d",edition_code+2);

  return result;

}


int main(int argc, char **argv)
{
  char *name, *edition_name, *inst_date, *exp_date, *massaged_name; 
  char *edition, *inst_date_36, *exp_date_36, *number;
  char *platform, *massaged_platform;

  enum license_type lic_type;

  platform = malloc(BUF_SIZE);
  name = malloc(BUF_SIZE);

  /* don't know at this stage which of these will be used */
  number = malloc(BUF_SIZE);
  edition_name = malloc(BUF_SIZE);
  inst_date = malloc(BUF_SIZE);
  exp_date = malloc(BUF_SIZE);


  if (name == NULL || edition_name == NULL || inst_date == NULL || 
      exp_date == NULL || platform == NULL || number == NULL)
    error("malloc failed\n");

  platform[0] = '\0';
  name[0] = '\0';
  number[0] = '\0';
  edition_name[0] = '\0';
  inst_date[0] = '\0';
  exp_date[0] = '\0';  

  lic_type = get_inputs(argc, argv, name, edition_name, inst_date, exp_date, platform, number);

  massaged_platform = check_platform(platform,lic_type);
  massaged_name = massage_string(name);

  if (lic_type == V1_0) {
    edition = NULL;
    inst_date_36 = NULL;
    print_result(massaged_name, edition, inst_date_36, exp_date, massaged_platform, number, lic_type);
  } else {
    number = NULL;
    if ((lic_type == V2_0) || (lic_type == V2_1) || (lic_type == V2_0b0)) {
      edition = offset_edition(convert_edition(edition_name,lic_type));
      inst_date_36 = convert_date(offset_date(inst_date));
      exp_date_36 = convert_date(offset_date(exp_date));
    } else {
      edition = convert_edition(edition_name,lic_type);
      inst_date_36 = convert_date(inst_date);
      exp_date_36 = convert_date(exp_date);
    }
    print_result(massaged_name, edition, inst_date_36, exp_date_36, massaged_platform, number, lic_type);
  };

  return(0);
}
