/*  ==== GLOBAL C ROOTS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *  The global roots are maintained as a simple extensible table.  The
 *  global root package is an ML record containing the global root names and
 *  their values.
 *
 *  Revision Log
 *  ------------
 *  $Log: global.c,v $
 *  Revision 1.12  1998/03/02 13:21:56  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.11  1997/08/19  15:14:09  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.10  1996/07/01  09:00:52  nickb
 * Change names of other _NIL flags for consistency.
 *
 * Revision 1.9  1996/06/27  15:30:41  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.8  1996/02/29  12:00:20  nickb
 * fix MISSING_NIL bug.
 *
 * Revision 1.7  1996/02/19  17:13:25  nickb
 * A couple of bugs in global_unpack and weak table handling.
 *
 * Revision 1.5  1996/02/16  16:00:47  nickb
 * Add more sophistication to global roots.
 *
 * Revision 1.4  1995/09/19  10:25:24  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.3  1994/08/31  13:55:51  nickb
 * global_pack changed so it no longer mutates a record.
 *
 * Revision 1.2  1994/06/09  14:36:18  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:03:07  nickh
 * new file
 *
 *  Revision 1.8  1993/11/16  17:14:20  nickh
 *  Added root declaration and retraction in weak_add().
 *  (bug fix).
 *
 *  Revision 1.7  1993/04/30  14:19:47  richard
 *  Added some diagnostics to help with image inconsistency problems.
 *
 *  Revision 1.6  1993/04/29  12:23:02  richard
 *  Corrected a stylistically bad use of a macro which could trip
 *  us up later.
 *
 *  Revision 1.5  1993/02/01  14:38:27  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.4  1992/08/07  08:46:11  richard
 *  Added weak_length and changed the type of weak_apply.
 *
 *  Revision 1.3  1992/08/05  09:53:08  richard
 *  Added weak list utilities.
 *
 *  Revision 1.2  1992/07/24  14:06:46  richard
 *  Added a duplication test to declare_global().
 *  Added a hook to global roots so that other functions are called when they
 *  are unpacked.
 *
 *  Revision 1.1  1992/07/23  12:03:06  richard
 *  Initial revision
 *
 */

#include "global.h"
#include "gc.h"
#include "utils.h"
#include "values.h"
#include "allocator.h"
#include "diagnostic.h"

#include <string.h>
#include <stdlib.h>


struct entry
{
  const char *name;
  mlval *root;
  word flags;
  mlval (*save_fn)(const char *name, mlval *root, int deliver);
  void (*load_fn)(const char *name, mlval *root, mlval value);
  void (*missing_fn)(const char *name, mlval *root);
} *table = NULL;
size_t table_size = 16, table_used = 0;
  

extern void declare_global
	(const char *name, mlval *root, word flags,
	 mlval (*save_fn)(const char *name, mlval *root, int deliver),
	 void (*load_fn)(const char *name, mlval *root, mlval value),
         void (*missing_fn)(const char *name, mlval *root))
{
  size_t i;

  if ((flags & ~(word)GLOBAL_ALL_FLAGS) != 0)
    error("Unknown flag(s) 0x%x used for global declaration of name `%s'.",
	  flags & ~(word)GLOBAL_ALL_FLAGS, name);
  if ((missing_fn != NULL) && (flags & (GLOBAL_MISSING_FLAGS)))
    error("`Missing' flags 0x%x used with `missing' function in "
	  "global declaration of name `%s'.",
	  flags & GLOBAL_MISSING_FLAGS, name);

  for(i=0; i<table_used; ++i)
    if(strcmp(table[i].name, name) == 0)
      error("Duplicate global root definition for name `%s'.", name);

  if(table == NULL || table_used >= table_size) {
    table_size *= 2;
    table = (struct entry *)realloc(table, sizeof(struct entry) * table_size);
    if(table == NULL)
      error("Unable to expand global root table.");
  }

  table[table_used].name = name;
  table[table_used].root = root;
  table[table_used].flags = flags;
  table[table_used].save_fn = save_fn;
  table[table_used].load_fn = load_fn;
  table[table_used].missing_fn = missing_fn;
  ++table_used;

  declare_root(root, 1);
}

/* global_save_die is a save_fn which returns DEAD */

mlval global_save_die(const char *name, mlval *root, int deliver)
{
  return DEAD;
}

/* when packing the global table, we want to create a record
   containing all of the names (as ML strings) and all of the
   roots. So we must allocate the names on the ML heap before we
   create the record. So we create an array of the names, clear it,
   fill it with the names, then create the record and write into it */

mlval global_pack(int deliver)
{
  mlval name_array, val_array, flags_array, package;
  size_t i, array_index;

  name_array = allocate_array(table_used);
  for(i=0; i < table_used; i++)
    MLUPDATE(name_array,i,MLUNIT);
  declare_root (&name_array, 0);

  val_array = allocate_array(table_used);
  for(i=0; i < table_used; i++)
    MLUPDATE(val_array,i,MLUNIT);
  declare_root (&val_array, 0);

  flags_array = allocate_array(table_used);
  for(i=0; i < table_used; i++)
    MLUPDATE(flags_array,i,MLUNIT);
  declare_root (&flags_array, 0);

  array_index = 0;
  for(i=0; i < table_used; i++) {
    mlval temp = DEAD;			/* DEAD means "do not save" */
    word flags = table[i].flags;
    if (deliver)
      flags >>= GLOBAL_DELIVER_SHIFT;

    if (table[i].save_fn != NULL)
      temp = table[i].save_fn (table[i].name, table[i].root, deliver);
    else if (flags & GLOBAL_SAVE_RECORD)
      temp = (flags & GLOBAL_SAVE_UNIT) ? MLUNIT : *table[i].root;
    if (flags & GLOBAL_SAVE_UNIT) 	/* then we nil it out */
      *table[i].root = MLUNIT;
    if ((flags & GLOBAL_SAVE_RECORD) ||
	(temp != DEAD)) {	/* then it goes in the table */
      MLUPDATE(val_array,array_index,temp);
      temp = ml_string(table[i].name); /* Do NOT inline this */
      MLUPDATE(name_array,array_index,temp);
      MLUPDATE(flags_array,array_index,MLINT(table[i].flags));
      array_index++;
    }
  }

  package = allocate_record(4);
  FIELD(package,0) = MLINT(array_index);
  FIELD(package,1) = name_array;
  FIELD(package,2) = flags_array;
  FIELD(package,3) = val_array;

  retract_root(&name_array);
  retract_root(&val_array);
  retract_root(&flags_array);
  return(package);
}

void global_unpack(mlval package)
{
  size_t i, j, length, found;
  mlval name_array, val_array, flags_array;

  DIAGNOSTIC(2, "global_unpack(0x%X)", package, 0);

  name_array = FIELD(package,1);
  flags_array = FIELD(package,2);
  val_array = FIELD(package,3);
  declare_root(&name_array, 0);
  declare_root(&val_array, 0);
  declare_root(&flags_array, 0);

  length = CINT(FIELD(package,0));
  found = 0;
  /* first wipe out all the global roots, in case there's a GC while
   * we're here */
  for(i=0; i<table_used; ++i) {
    *table[i].root = DEAD;
  }
  /* for each global root, find it in the new image */
  for(i=0; i<table_used; ++i) {
    const char *name = table[i].name;
    for (j=0; j < length; ++j) {
      mlval image_name = MLSUB(name_array,j);
      if(image_name != MLUNIT && (strcmp(CSTRING(image_name), name) == 0)) {
	/* found */
	DIAGNOSTIC(4, "  %s: 0x%X", name, MLSUB(val_array, j));
	found++;
	MLUPDATE(name_array, j, MLUNIT);
	if(table[i].load_fn != NULL) {
	  DIAGNOSTIC(4, "  invoking fix function 0x%X", table[i].load_fn, 0);
	  (*table[i].load_fn)(name, table[i].root, MLSUB(val_array, j));
	} else
	  *table[i].root = MLSUB(val_array,j);
	goto next;
      }
    }
    /* not found */
    if (table[i].missing_fn)
      table[i].missing_fn(table[i].name, table[i].root);
    else {
      word flags = table[i].flags;
      if (flags & GLOBAL_MISSING_WARN)
	message("global root `%s' missing from loaded image",name);
      if ((flags & GLOBAL_MISSING_WARN) || (flags & GLOBAL_MISSING_UNIT))
	*table[i].root = MLUNIT;
      else
	error("global root `%s' missing from loaded image.", name);
    }
  next:
    ;	/* empty statement: required by Visual C++ */
  }
  if (found != length) { /* there are unmatched entries */
    for (j=0; j < length; ++j) {
      mlval image_name = MLSUB(name_array,j);
      if(image_name != MLUNIT) {
	word flags = MLSUB(flags_array,j);
	DIAGNOSTIC(4, "  unmatched entry %s",CSTRING(image_name),0);
	if ((flags & GLOBAL_UNMATCHED_IGNORE) == 0) {
	  if ((flags & GLOBAL_UNMATCHED_WARN))
	    message("loaded image has unmatched global root `%s'",
		    CSTRING(image_name));
	  else 
	    error("Loaded image has unmatched global root `%s'",
		  CSTRING(image_name));
	}
      }
    }
  }
  retract_root(&name_array);
  retract_root(&val_array);
  retract_root(&flags_array);
}


mlval weak_new(size_t granularity)
{
  mlval new = allocate_array(2);

  MLUPDATE(new, 0, MLINT(granularity));
  MLUPDATE(new, 1, MLNIL);

  return(new);
}

mlval weak_add(mlval list, mlval value)
{
  size_t granularity = CINT(MLSUB(list, 0)), i;
  mlval l, array;

  for(l = MLSUB(list, 1); l != MLNIL; l = MLTAIL(l)) {
    mlval array = MLHEAD(l);
    size_t length = LENGTH(ARRAYHEADER(array)), i;

    for(i=0; i<length; ++i)
      if(MLSUB(array, i) == DEAD) {
	MLUPDATE(array, i, value);
	return(list);
      }
  }

  declare_root(&list, 0);
  declare_root(&value, 0);
  array = allocate_weak_array(granularity);
  retract_root(&value);

  MLUPDATE(array, 0, value);
  for(i=1; i<granularity; ++i) {
    MLUPDATE(array, i, DEAD);
  }

  l = cons(array, MLSUB(list, 1)); /* Do NOT inline this */
  MLUPDATE(list, 1, l);
  retract_root(&list);

  return(list);
}

size_t weak_length(mlval list)
{
  size_t total = 0;
  mlval l;

  for(l = MLSUB(list, 1); l != MLNIL; l = MLTAIL(l))
  {
    mlval array = MLHEAD(l);
    size_t length = LENGTH(ARRAYHEADER(array)), i;

    for(i=0; i<length; ++i)
      if(MLSUB(array, i) != DEAD)
	++total;
  }

  return(total);
}

void weak_apply(mlval list, mlval (*f)(unsigned int, mlval))
{
  mlval l = MLUNIT, array = MLUNIT;
  unsigned int index = 0;

  declare_root(&list, 0);
  declare_root(&l, 0);
  declare_root(&array, 0);

  for(l=MLSUB(list, 1); l!=MLNIL; l=MLTAIL(l))
  {
    size_t length, i;

    array = MLHEAD(l);
    length = LENGTH(ARRAYHEADER(array));

    for(i=0; i<length; ++i)
    {
      mlval value = MLSUB(array, i);

      if(value != DEAD)
      {
	value = (*f)(index++, value);
	MLUPDATE(array, i, value);
      }
    }
  }

  retract_root(&array);
  retract_root(&l);
  retract_root(&list);
}

/* weak_tidy tidies up a weak list. It iterates over the table,
 * compacting the contents. */

static void weak_tidy(mlval value)
{
  size_t length = weak_length(value), index = 0;
  mlval new_array, new_cons, l;
  declare_root(&value, 0);
  new_array = allocate_weak_array(length);
  for(l = MLSUB(value, 1); l != MLNIL; l = MLTAIL(l)) {
    mlval array = MLHEAD(l);
    size_t alength = LENGTH(ARRAYHEADER(array)), i;
    for(i=0; i<alength; ++i) {
      mlval value = MLSUB(array,i);
      if (value != DEAD)
	MLUPDATE(new_array,index++,value);
    }
  }
  new_cons = cons(new_array,MLNIL);
  MLUPDATE(value,1,new_cons);
  retract_root(&value);
}

void global_tidy(mlval package)
{
  size_t array_size = CINT(FIELD(package,0));
  mlval val_array = FIELD(package,3);
  mlval flags_array = FIELD(package,2);
  size_t i;
  declare_root(&flags_array, 0);
  declare_root(&val_array, 0);
  for (i=0 ; i < array_size; i ++) {
    word flags = CINT(MLSUB(flags_array,i));
    mlval value = MLSUB(val_array,i);
    if (flags & GLOBAL_WEAK_LIST)
      weak_tidy(value);
  }
  retract_root(&flags_array);
  retract_root(&val_array);
}
