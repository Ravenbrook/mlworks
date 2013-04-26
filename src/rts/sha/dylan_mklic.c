/* Harlequin Dylan Registration generator
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
 * $Log: dylan_mklic.c,v $
 * Revision 1.6  1999/06/16 23:56:16  palter
 * Add 2.1 as a valid release ...
 *
 * Revision 1.5  1998/09/29  20:34:14  palter
 * Recognize 1.1.1, 1.2, and 2.0 releases.
 *
 * Revision 1.4  1998/06/04  17:30:06  palter
 * Recognize 1.0.1 and 1.1 releases
 *
 * Revision 1.3  1998/06/04  17:27:31  palter
 * Recognize 1.0.1 and 1.1 releases
 *
 * Revision 1.2  1998/02/25  23:39:04  palter
 * New serial number based licensing scheme
 *
 * Revision 1.1  1997/11/20  16:21:12  palter
 * new unit
 * Generator of license keys for Harlequin Dylan
 *
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <ctype.h>
#include "dylan_mklic.h"
#include "sha.h"

static void error (const char *msg)
{
  fprintf(stderr, "%s\n", msg);
  exit(1);
}

static char *massage_string (char* str)
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

/* validate edition input */

static char *validate_edition(char *str) 
{
	
  char *massaged_string, *result;

  massaged_string = massage_string(str);

  if (strcmp(massaged_string, "personal") == 0) {
    result = PERSONAL;
  } else if (strcmp(massaged_string, "professional") == 0) {
    result = PROFESSIONAL;
  } else if (strcmp(massaged_string, "enterprise") == 0) {
    result = ENTERPRISE;
  } else if (strcmp(massaged_string, "internal") == 0) {
    result = INTERNAL;
  } else {
    error("Legal values for edition are personal, professional, enterprise, or internal");
  }

  return result;
}

/* validate release input */

static char *validate_release(char *str) 
{
	
  char *massaged_string, *result;

  massaged_string = massage_string(str);

  if (strcmp(massaged_string, "1.0") == 0) {
    result = RELEASE_1_0;
  } else if (strcmp(massaged_string, "1.0.1") == 0) {
    result = RELEASE_1_0_1;
  } else if (strcmp(massaged_string, "1.1") == 0) {
    result = RELEASE_1_1;
  } else if (strcmp(massaged_string, "1.1.1") == 0) {
    result = RELEASE_1_1_1;
  } else if (strcmp(massaged_string, "1.2") == 0) {
    result = RELEASE_1_2;
  } else if (strcmp(massaged_string, "2.0") == 0) {
    result = RELEASE_2_0;
  } else if (strcmp(massaged_string, "2.1") == 0) {
    result = RELEASE_2_1;
  } else {
    error("Legal values for release are 1.0, 1.0.1, 1.1, 1.1.1, 1.2, 2.0, or 2.1");
  }

  return result;
}

/* validate expiration date input */

static void validate_expiration(time_t now, char *input, char* expiration)
{
  struct tm *tm;
  time_t then;
  int days, encoded_then;

  if (strcmp(massage_string(input), "none") == 0) {
    sprintf(expiration, "0000");
  } else {
    if (sscanf(input, "%d", &days) < 1) {
      error("Expiration must be none or numbers of days before license expires");
    }
    then = now + (days * 24 * 3600);
    tm = localtime(&then);
    encoded_then = 512 * (tm->tm_year - 90) + 32 * (tm->tm_mon + 1) + tm->tm_mday;
    sprintf(expiration, "%.4x", encoded_then);
  }
}


static void compute_serial_and_key (const char *edition, const char *release,
				    const char *expiration, const char *prefix_string,
				    long serial,
				    char *serial_data, char *license_data)
{
  SHA_INFO sha_info;
  char input[128], *result;

  sprintf(serial_data, "%s-%s-%s%.8d", edition, release, prefix_string, serial);

  sprintf(input, "%s%s", serial_data, expiration);
  sha_string(&sha_info, input, strlen(input));
  result = sha_sprint(&sha_info);

  memcpy(license_data, result + CHECK_CHARS_START, CHECK_CHARS_LENGTH);
  license_data[CHECK_CHARS_LENGTH] = '\0';

  strcat(license_data, expiration);
}


int main(int argc, char **argv)
{
  struct tm *tm;
  time_t now;

  char serial_data[32], license_data[32];
  char prefix_string[8], expiration[8];
  char *edition, *release;
  long serial;
  int count, argi, prefix, i;
  int batch;

  if (argc != 4 && argc != 7) {
    fprintf(stderr, "Usage: dylan_mklic edition release expiration\n");
    fprintf(stderr, "   or: dylan_mklic batch count prefix edition release expiration\n");
    exit(2);
  }

  if (strcmp(massage_string(argv[1]), "batch") == 0) {
    batch = 1;
    argi = 4;
  } else {
    batch = 0;
    argi = 1;
  }

  /*---*** NEED BETTER RESOLUTION!  (Want tenths but struct tm only seconds!) */
  time(&now); 

  edition = validate_edition(argv[argi]);
  release = validate_release(argv[argi+1]);
  validate_expiration(now, argv[argi+2], expiration);

  tm = gmtime(&now);
  serial = 10 * (tm->tm_sec + 60 * (tm->tm_min + 60 * (tm->tm_hour + 24 * (tm->tm_mday - 1))));

  if (batch) {
    if (sscanf(argv[2], "%d", &count) < 1) {
      error("Batch count must be an integer");
    }
    if (sscanf(argv[3], "%d", &prefix) < 1) {
      error("Prefix must be an integer between 2000 and 9999, inclusive");
    }
    if (prefix < 2000 || prefix > 9999) {
      error("Prefix must be an integer between 2000 and 9999, inclusive");
    }
    sprintf(prefix_string, "%.4d", prefix);
    for (i = 0; i < count; i++, serial++) {
      compute_serial_and_key(edition, release, expiration, prefix_string,
			     serial, serial_data, license_data);
      printf("%s  %s\n", serial_data, license_data);
    }

  } else {
    sprintf(prefix_string, "%.2d%.2d", tm->tm_mon + 1, tm->tm_year % 100);
    compute_serial_and_key(edition, release, expiration, prefix_string,
			   serial, serial_data, license_data);
    printf("Serial number: %s\nLicense key: %s\n", serial_data, license_data);
  }
}
