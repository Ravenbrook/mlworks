/* mlworks_license, validate a license for a client machine at install time
 *
 * Copyright (c) 1998 Harleqion Group plc
 *
 * $Log: mlworks_license.c,v $
 * Revision 1.3  1998/07/29 16:27:04  jont
 * [Bug #70001]
 * Call fflush after printf
 *
 */
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "license.h"
#include "mlw_mklic.h"
#include "validate_license.h"

/* License validation and installation */
/* uses the DLL also used by InstallShield */

/* TTY version */

static char *massage_string(char* str)
{
  char *result;
  char *cp1, *cp2, *cp3;
  int len;

  len = strlen(str);
  result = malloc(len + 1);
  if (result == NULL) {
    fprintf(stderr,"malloc failed\n");
    fflush(stderr);
    exit(1); /* Can't continue here */
  }
  for (cp1 = str; isspace(*cp1); cp1++);
  for (cp2 = str+len-1; isspace(*cp2); cp2--);
  for (cp3 = result; cp1 <= cp2; cp1++, cp3++)
    *cp3 = *cp1;

  *cp3 = '\0';
  return result;
}

static void print_license_result (enum license_check_result lcr);

static void tty_license()
{
    int BUF_SIZE = 1024;

    char * massaged_name;
    char * massaged_code;
    char * license_name;
    char * license_code;

    int len,p;

    license_name = malloc(BUF_SIZE);
    license_code = malloc(BUF_SIZE);

    printf("Licence name: ");
    fflush(stdout);
    fgets(license_name, BUF_SIZE, stdin);
    massaged_name = massage_string(license_name);
    len = strlen(massaged_name);
    for (p = 0; p < len; p++) {
      massaged_name[p] = tolower(massaged_name[p]);  
    };

    printf("Licence code: ");
    fflush(stdout);
    fgets(license_code, BUF_SIZE, stdin);
    massaged_code = massage_string(license_code);

    validate_and_install_license(massaged_name,massaged_code);
}

static void print_license_result (enum license_check_result lcr)
{
  switch (lcr) {
  case INVALID: 
    printf(LICENSE_ERROR_INVALID);
    break;
  case INSTALLDATE: 
    printf(LICENSE_ERROR_INSTALL);
    break;
  case EXPIRED: 
    printf(LICENSE_ERROR_EXPIRED);
    break;
  case ILLEGAL_CHARS: 
    printf(LICENSE_ERROR_CHARS);
    break;
  case OK: 
    printf("OK");
    break;
  case WRONG_EDITION: 
    printf(LICENSE_ERROR_VERSION);
    break;
  case NOT_FOUND: 
    printf("NOT_FOUND");
    break;
  case INTERNAL_ERROR: 
    printf("INTERNAL_ERROR");
    break;
  };
  fflush(stdout);
}

void main(int argc, char *argv[])
{
  char * got_name;
  char * got_code;

  /* Allocate twice as much space as needed for a legal licence code */

  int license_input_buffer = 2 *
                             (CHECK_CHARS + (2 * DATE_CHARS) + EDITION_CHARS);

  got_name = malloc(license_input_buffer);
  got_code = malloc(license_input_buffer);

  tty_license(got_name, got_code);
  
}
