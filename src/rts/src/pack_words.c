/*  ==== C PACK_WORD OPERATORS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Pack word operators are used to map word values onto bytearrays
 *  (Word8Arrays).  This also allows for operations of differing
 *  endianness.
 *  
 *  
 *  Revision Log
 *  ------------
 *  $Log: pack_words.c,v $
 *  Revision 1.11  1998/08/17 16:18:29  jont
 *  [Bug #30465]
 *  Undo change for endianness of 16 bits values, which were correct before
 *
 * Revision 1.10  1998/08/17  14:14:32  jont
 * [Bug #30465]
 * Fix compiler warning
 * Fixed a compiler warning caused by use of = instead of ==
 * which the stupid MS compiler didn't point out.
 *
 * Revision 1.9  1998/08/13  16:49:18  jont
 * [Bug #30465]
 * Fix endianness problems with little endian machines
 *
 * Revision 1.8  1998/08/06  11:27:59  mitchell
 * [Bug #30467]
 * Remove the 24 bit word packing functions
 *
 * Revision 1.7  1998/08/06  11:12:25  mitchell
 * [Bug #30466]
 * Fix Pack16/24 subVec functions
 *
 * Revision 1.6  1998/08/05  14:36:14  mitchell
 * [Bug #30464]
 * Fix Pack32Big.subVec implementation
 *
 * Revision 1.5  1996/05/17  16:10:38  jont
 * Add new functions required by latest pack_word signature
 *
 * Revision 1.4  1995/09/04  10:56:17  daveb
 * Changed unsigned to word.
 *
 * Revision 1.3  1995/04/03  13:20:03  brianm
 * Updating to use allocate_word32() and CWORD32().
 *
 * Revision 1.2  1995/03/22  18:38:12  brianm
 * Changing Word32 repn. to immutable byte vectors (i.e. strings).
 *
 * Revision 1.1  1995/03/17  15:50:38  brianm
 * new unit
 * New file.
 *
 *
 */

#include "mltypes.h"
#include "allocator.h"
#include "values.h"
#include "diagnostic.h"
#include "environment.h"
#include "exceptions.h"
#include "words.h"
#include "pack_words.h"
#include "utils.h"

/* Local defines */

#define bit(a)                (1u << (a))
#define bitblk(hi,lo)         (bit(hi) | (bit(hi) - bit(lo)))
#define appmask(x,m)          ((x) & (m))
#define setmask(x,m)          ((x) | (m))
#define xormask(x,m)          ((x) ^ (m))
#define rshift(x,lo)          ((unsigned)(x) >> (lo))
#define getbitblk(u,hi,lo)    (appmask(rshift((u),(lo)),bitblk(1+(hi) - (lo),0)))
#define set1bitblk(u,hi,lo)   (setmask((u),bitblk((hi),(lo))))
#define set0bitblk(u,hi,lo)   (appmask((u),~(bitblk((hi),(lo)))))
#define setbitblk(u,hi,lo,v)  (setmask(set0bitblk((u),(hi),(lo)), \
                                       getbitblk((v),1 + (hi) - (lo),0) << (lo)))
#define invbitblk(u,hi,lo)    (xormask((u),bitblk((hi),(lo))))
#define signextend(u,a)       ((appmask(u,bit(a))) ? (setmask((u),(0 - bit(a)))) : u)


#define raise_subscript   \
        exn_raise_string(perv_exn_ref_value, "pack_words: subscript")

typedef enum endian { BIG, LITTLE } endian;

static endian machine_endian;

static void swop_bytes(byte *x, byte *y)
{
   byte temp;

   temp = *x;
   *x = *y;
   *y = temp;
}

static void rev_unsigned(unsigned *val)
{
   byte *x0, *x1, *x2, *x3;

   x0 = (byte *)val;
   x1 = (byte *)x0 + 1;
   x2 = (byte *)x1 + 1;
   x3 = (byte *)x2 + 1;

   swop_bytes(x0,x3);
   swop_bytes(x1,x2);
}

static void endian_change_word(endian end, unsigned *val) {
  if (end == machine_endian) {
    rev_unsigned(val);
  }
}

/* ==== 16 bit words ====
 *
 */

static mlval subV_word16(mlval argument)
{
  int len, index, word;
  mlval vector; 

  byte val1, val2, *addr;

  vector = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));

  len = CSTRINGLENGTH(vector);

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)(CSTRING(vector));

  val1 = addr[index++];
  val2 = addr[index];

  word = (val1 << 8) | val2;

  return(MLINT(word));
}

static mlval subV_rev_word16(mlval argument)
{
  int len, index, word;
  mlval vector; 

  byte val1, val2, *addr;

  vector = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));

  len = CSTRINGLENGTH(vector);

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)(CSTRING(vector));

  val1 = addr[index++];
  val2 = addr[index];

  word = (val2 << 8) | val1;

  return(MLINT(word));
}

static mlval subA_word16(mlval argument)
{
  int len, index, word;
  mlval array; 

  byte val1, val2, *addr;

  array = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)(CBYTEARRAY(array));

  val1 = addr[index++];
  val2 = addr[index];

  word = (val1 << 8) | val2;

  return(MLINT(word));
}

static mlval subA_rev_word16(mlval argument)
{
  int len, index, word;
  mlval array; 

  byte val1, val2, *addr;

  array = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)(CBYTEARRAY(array));

  val1 = addr[index++];
  val2 = addr[index];

  word = (val2 << 8) | val1;

  return(MLINT(word));
}

static mlval update_word16(mlval argument)
{
  int len, index;
  mlval array, word; 

  byte val1, val2, *addr;

  array = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));
  word  = CINT(FIELD(argument, 2));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)CBYTEARRAY(array);

  val1 = (byte) rshift(word,8);
  val2 = (byte) word;

  addr[index++]   = val1;
  addr[index] = val2;

  return(MLUNIT);
}

static mlval update_rev_word16(mlval argument)
{
  int len, index;
  mlval array, word; 

  byte val1, val2, *addr;

  array = FIELD(argument,0);
  index = 2 * CINT(FIELD(argument, 1));
  word  = CINT(FIELD(argument, 2));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+1 < len)) raise_subscript;

  addr = (byte *)CBYTEARRAY(array);

  val2 = (byte) word;
  val1 = (byte) rshift(word,8);

  addr[index++]   = val2;
  addr[index] = val1;

  return(MLUNIT);
}

/* ===== 32 bit words ====
 *
 */

static mlval subV_word32(mlval argument)
{
  int len, index;
  mlval vector, w; 

  byte *addr;

  word *item, val;

  vector = FIELD(argument,0);
  index = sizeof(word) * CINT(FIELD(argument, 1));

  len = CSTRINGLENGTH(vector);

  if (!(0 <= index && index+3 < len)) raise_subscript;

  addr = (byte *)(index + CSTRING(vector));

  item = (word *)addr;
  val  = *item;

  endian_change_word(LITTLE, &val);

  w = allocate_word32();
  num_to_word32(val,w);

  return(w);
}

static mlval subV_rev_word32(mlval argument)
{
  int len, index;
  mlval vector, w; 

  byte *addr;

  word *item, val;

  vector = FIELD(argument,0);
  index = sizeof(word) * CINT(FIELD(argument, 1));

  len = CSTRINGLENGTH(vector);

  if (!(0 <= index && index+3 < len)) raise_subscript;

  addr = (byte *)(index + CSTRING(vector));
  item = (word *)addr;
  val  = *item;

  endian_change_word(BIG, &val);

  w = allocate_word32();
  num_to_word32(val,w);

  return(w);
}

static mlval subA_word32(mlval argument)
{
  int len, index;
  mlval array, w; 

  byte *addr;

  word *item, val;

  array = FIELD(argument,0);
  index = 4 * CINT(FIELD(argument, 1));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+3 < len)) raise_subscript;

  addr = (byte *)(CBYTEARRAY(array))+index;

  item = (word *)addr;
  val  = *item;

  endian_change_word(LITTLE, &val);

  w = allocate_word32();
  num_to_word32(val,w);

  return(w);
}

static mlval subA_rev_word32(mlval argument)
{
  int len, index;
  mlval array, w; 

  byte *addr;

  word *item, val;

  array = FIELD(argument,0);
  index = 4 * CINT(FIELD(argument, 1));

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+3 < len)) raise_subscript;

  addr = (byte *)(CBYTEARRAY(array))+index;

  item = (word *)addr;
  val  = *item;

  endian_change_word(BIG, &val);

  w = allocate_word32();
  num_to_word32(val,w);

  return(w);
}

static mlval update_word32(mlval argument)
{
  int len, index;
  mlval array, w; 

  byte *addr;

  word *val, *item;

  array = FIELD(argument,0);
  index = sizeof(word) * CINT(FIELD(argument, 1));
  w  = FIELD(argument, 2);

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+3 < len)) raise_subscript;

  addr = (byte *)(index + (word)CBYTEARRAY(array));

  item = (word *)addr;
  val  = CWORD32(w);

  *item = *val;
  endian_change_word(LITTLE, item);

  return(MLUNIT);
}

static mlval update_rev_word32(mlval argument)
{
  int len, index;
  mlval array, w; 

  byte *addr;

  word *val, *item;

  array = FIELD(argument,0);
  index = 4 * CINT(FIELD(argument, 1));
  w  = FIELD(argument, 2);

  len = LENGTH(GETHEADER(array));

  if (!(0 <= index && index+3 < len))  raise_subscript;

  addr = (byte *)(index + (word)CBYTEARRAY(array));

  item = (word *)addr;
  val  = CWORD32(w);

  *item = *val;
  endian_change_word(BIG, item);

  return(MLUNIT);
}

extern void pack_words_init(void)
{
  char foo[4] = "\0\0\0\377";
  unsigned int *bar = (unsigned int *)foo;
  if (*bar == 0xff) {
    machine_endian = BIG;
  } else if (*bar == 0xff000000) {
    machine_endian = LITTLE;
  } else {
    error("pack_words: Unable to determine machine endianness\n");
  }
  env_function("subV word16", subV_word16);
  env_function("subV reverse word16", subV_rev_word16);
  env_function("subV word32", subV_word32);
  env_function("subV reverse word32", subV_rev_word32);

  env_function("subA word16", subA_word16);
  env_function("subA reverse word16", subA_rev_word16);
  env_function("subA word32", subA_word32);
  env_function("subA reverse word32", subA_rev_word32);

  env_function("update word16", update_word16);
  env_function("update reverse word16", update_rev_word16);
  env_function("update word32", update_word32);
  env_function("update reverse word32", update_rev_word32);
}
