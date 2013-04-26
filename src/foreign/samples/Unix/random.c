/*  ==== FI EXAMPLES : random foreign functions ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This C module provides foreign functions to generate random numbers.
 *
 *  Revision Log
 *  ------------
 *  $Log: random.c,v $
 *  Revision 1.1  1996/08/30 11:08:33  davids
 *  new unit
 *
 *
 */

#include <stdlib.h>

void set_seed (long seed)
{
  srand48 (seed);
}

long random_num (long min, long max)
{
  long range, rand_num;

  range = max - min + 1;
  rand_num = lrand48 () % range;
  return rand_num + min;
}
