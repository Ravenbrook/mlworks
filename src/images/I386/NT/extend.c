/*
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * A little program to cope with the bug that MS linker
 * seeks off the end of object files produced by gcc
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: extend.c,v $
 * Revision 1.1  1998/09/28 15:15:59  jont
 * new unit
 * A little program to get round a MS linker bug
 *
 *
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  FILE *output;
  unsigned long zeroes = 0;
  if (argc != 2) {
    fprintf(stderr, "extend: Bad args\n");
    exit(1);
  }
  output = fopen(argv[1], "ab");
  if (output == NULL) {
    fprintf(stderr, "extend: cannot open %s for output\n", argv[1]);
    exit(1);
  }
  if (fwrite(&zeroes, 1, 4, output) != 4) {
    fclose(output);
    fprintf(stderr, "extend: cannot append to %s\n", argv[1]);
    exit(1);
  }
  fclose(output);
  return 0;
}
