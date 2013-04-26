/*  ==== IMAGE SAVE, LOAD, AND DELIVERY ====
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
 *  The live regions of the ML heap are written out in a straightforward
 *  manner, and a simple fixup() function is used to correct pointers when
 *  the heap is reloaded.  I have endeavoured to do any processing when the
 *  image is loaded rather than when it is saved in order to make saving
 *  fast and non-disruptive.
 *
 *  Revision Log
 *  ------------
 *  $Log: image.c,v $
 *  Revision 1.23  1998/08/21 16:33:35  jont
 *  [Bug #20133]
 *  Modify to use GC_HEAP_REAL_LIMIT
 *
 * Revision 1.22  1998/04/24  10:30:15  jont
 * [Bug #70032]
 * gen->values now measured in bytes
 *
 * Revision 1.21  1998/04/23  13:51:56  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.20  1998/03/03  17:23:19  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.19  1996/10/29  17:40:48  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.18  1996/08/05  14:02:54  jont
 * [Bug #1529]
 * Add a break at the end of the STORE_STREAM case of read
 *
 * Revision 1.17  1996/05/22  15:18:40  nickb
 * Make fix_entry spot static arrays and weakarrays.
 * Also correct use of static sizes -- they are in bytes, not words.
 *
 * Revision 1.16  1996/05/01  08:53:07  nickb
 * Rearrange stream-independent load and store.
 *
 * Revision 1.15  1996/02/14  17:21:18  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.14  1996/02/14  14:56:24  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.13  1996/02/13  17:15:36  jont
 * Add some type casts to preent compiler warnings under VC++
 *
 * Revision 1.12  1996/01/11  16:43:31  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.11  1995/11/27  17:59:42  jont
 * Add image_load_with_open_file for loading from NT saved executables
 * Add image_save_with_open_file for saving NT saved executables
 *
 * Revision 1.10  1995/09/26  13:11:27  jont
 * Add a version of image_load that can read from store
 * Add a version of image_save that can save to store
 * Add a function to determine how much store is required for an image save
 *
 * Revision 1.9  1995/09/07  16:00:12  jont
 * Delete image files when the write fails
 *
 * Revision 1.8  1995/07/14  10:56:51  nickb
 * Change to definition of OBJECT_SIZE macro.
 *
 * Revision 1.7  1995/05/21  16:00:30  brianm
 * Static objects can now be restored from images.
 *
 * Revision 1.6  1995/03/07  10:59:51  nickb
 * Static object header changed to have a generation pointer.
 *
 * Revision 1.5  1995/02/28  13:16:03  nickb
 * union static_object has become struct static_object.
 *
 * Revision 1.4  1995/02/27  16:53:07  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.3  1994/11/09  16:42:12  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.2  1994/06/09  14:48:13  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:20:20  nickh
 * new file
 *
 *  Revision 1.22  1994/01/28  17:47:46  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.21  1993/06/02  13:12:56  richard
 *  Changed some print formats from %08X to %p.
 *
 *  Revision 1.20  1993/05/11  13:23:07  daveb
 *  Increased some diagnostic levels.
 *
 *  Revision 1.19  1993/04/29  10:40:46  richard
 *  Increased diagnostic levels.
 *  Rewrote Jon's code for the contents table.
 *
 *  Revision 1.18  1993/04/02  15:38:03  jont
 *  Modified image format to include a header and table of contents
 *  Added an image_table function to return the table as a list of ml strings
 *
 *  Revision 1.17  1993/02/12  13:53:06  jont
 *  Changes for code vector reform.
 *
 *  Revision 1.16  1993/02/01  16:04:26  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.15  1992/11/02  13:07:44  richard
 *  Changed arguments to an ml value.
 *
 *  Revision 1.14  1992/10/02  09:40:41  richard
 *  Added missing consts.
 *
 *  Revision 1.13  1992/08/05  17:33:09  richard
 *  Code vectors are now tagged differently to strings.
 *
 *  Revision 1.12  1992/08/04  06:31:04  richard
 *  New version to deal with a new memory organisation using an
 *  arena manager.  See new gc.c and mem.h.
 *
 *  Revision 1.11  1992/07/30  11:28:07  richard
 *  Allowed pointers outside the heap.
 *
 *  Revision 1.10  1992/07/23  13:56:50  richard
 *  Reimplemented a lot of this to deal with large objects and return
 *  the correct error codes.  It now has more consistency checking as well.
 *
 *  Revision 1.9  1992/07/20  13:16:31  richard
 *  Replaced alloc() by allocate() to avoid clashing with a call in the
 *  memory manager.
 *
 *  Revision 1.8  1992/07/15  15:31:07  richard
 *  image_load now empties the GC_MODIFIED_LIST, as this is empty
 *  when the image is saved.  Changed the array header structure
 *  slightly.
 *
 *  Revision 1.7  1992/07/14  10:31:41  richard
 *  Implemented weak arrays.
 *
 *  Revision 1.6  1992/07/01  15:24:16  richard
 *  Corrected code for large objects, and removed some storage manager specific
 *  things.
 *
 *  Revision 1.5  1992/06/09  10:34:20  richard
 *  NIL is now a valid empty structure.
 *
 *  Revision 1.4  1992/03/23  15:53:58  richard
 *  Removed redundant diagnostics.
 *
 *  Revision 1.3  1992/03/19  11:56:46  richard
 *  Added checksums to images.
 *
 *  Revision 1.2  1992/03/18  15:49:35  richard
 *  Corrected fixup of zero.
 *
 *  Revision 1.1  1992/03/17  16:49:57  richard
 *  Initial revision
 *
 */

#include "ansi.h"
#include "arena.h"
#include "image.h"
#include "mem.h"
#include "gc.h"
#include "diagnostic.h"
#include "alloc.h"
#include "allocator.h"
#include "values.h"
#include "state.h"
#include "pervasives.h"
#include "cache.h"
#include "utils.h"

#include <stddef.h>
#include <stdio.h>
#include <errno.h>
#include <setjmp.h>
#include <string.h>


/*
 * Image format
 * Images now have a header, with three entries
 * plus the data refered to by these entries
 *
 * Entry offset Value
 * 0            Pointer to id string (NULL terminated)
 * 4            Pointer to files contents table (NULL terminated string)
 * 8            Pointer to the image data
 *
 * All pointers are word aligned
 */

#define IMAGE_HEADER_SIZE 12

/*  == Image id string ==
 *
 *  This string is written at the beginning of each image to ensure
 *  consistency.
 */

#define MAX_ID_LENGTH	40
static const char *id = "MLWorks image format 1.5\n";

/*
 * A type suitable for reading from both files and store
 */
struct stream {
  union {
    FILE *file;
    struct {
      void *ptr;
      size_t extent;
      size_t index;
    } store;
    size_t size;
  } the;
  word type;
};

enum stream_tag {
  FILE_STREAM,		/* a real stream */
  STORE_STREAM,		/* reading or writing into store */
  SIZE_STREAM		/* computing the size of a written image */
};

/*  == Bulletproof read, write, and allocate ==
 *
 *  These versions of fread(), fwrite(), and malloc() perform a non-local
 *  jump to the state saved in `problem' if they are unable to read, write,
 *  or allocate.  Both image_save() and image_load() set up an error handler
 *  to deal with this method, which eliminates a lot of checking elsewhere.
 */

static jmp_buf problem;

static void write(const void *whence, size_t size, size_t number, struct stream *stream)
{
  switch (stream->type) {
  case FILE_STREAM:
    if(fwrite(whence, size, number, stream->the.file) != number) 
      longjmp(problem, EIMAGEWRITE);
    break;
  case STORE_STREAM:
    {
      size_t extent = stream->the.store.extent;
      size_t index = stream->the.store.index;
      size_t bytes = size*number;
      void *ptr = stream->the.store.ptr;
      if ((double)size * (double)number > (double)(0xffffffff) || /* Multiply overflow */
	  index > index + bytes || /* Addition overflow */
	  index + bytes > extent /* Run off the end */
	  ) {
	longjmp(problem, EIMAGEWRITE);
      }
      memcpy(((char *)ptr)+index, whence, bytes);
      DIAGNOSTIC(4, "write writing %d bytes at offset %d", bytes,
		 stream->the.store.index);
      stream->the.store.index = index+bytes;
    }
    break;
  case SIZE_STREAM:
    {
      size_t bytes = size*number;
      if ((double)size * (double)number > (double)(0xffffffff)) /* Multiply overflow */
	longjmp(problem, EIMAGEWRITE);
      stream->the.size += bytes;
    }
    break;
  default:
    longjmp(problem, EIMAGEWRITE);
  }
}

static void read(void *whither, size_t size, size_t number, struct stream *stream)
{
  DIAGNOSTIC(4, "read %d of size %d\n", number, size);
  switch (stream->type) {
  case FILE_STREAM:
    DIAGNOSTIC(4, "FILE_STREAM, reading %d of size %d", number, size);
    if(fread(whither, size, number, stream->the.file) != number)
      longjmp(problem, EIMAGEREAD);
    break;
  case STORE_STREAM:
    {
      size_t extent = stream->the.store.extent;
      size_t index = stream->the.store.index;
      size_t bytes = size*number;
      void *ptr = stream->the.store.ptr;
      DIAGNOSTIC(4, "STORE_STREAM, extent %d, index %d", extent, index);
      if ((double)size * (double)number > (double)(0xffffffff) || /* Multiply overflow */
	  index > index + bytes || /* Addition overflow */
	  index + bytes > extent /* Run off the end */
	  ) {
	longjmp(problem, EIMAGEREAD);
      }
      memcpy(whither, ((char *)ptr)+index, bytes);
      stream->the.store.index += bytes;
    }
    break;
  case SIZE_STREAM:
    /* meaningless for reads */
    /* Fall through */
  default:
    longjmp(problem, EIMAGEREAD);
  }
}

static void *allocate(size_t size)
{
  void *p = malloc(size);

  if(p == NULL)
    longjmp(problem, EIMAGEALLOC);

  return(p);
}

/*  == Checksum an area of memory ==  */

static word checksum(word *start, word *end)
{
  word sum = 0xDEC0DE;

  while(start < end)
    sum ^= *start++;

  return(sum);
}



/*  === SAVE AN IMAGE OF THE CURRENT HEAP ===
 *
 *  No processing of the image data is done when writing the image out to
 *  the file.  All pointers are fixed using the information recovered when
 *  it is loaded.
 */

static void image_save_common(struct stream *image, mlval root)
{
  struct ml_heap *gen;
  size_t nr_gens, nr_static;
  unsigned int id_len = word_align(strlen(id));
  unsigned int id_offset = IMAGE_HEADER_SIZE;
  unsigned int table_len = 0;
  unsigned int table_offset = id_offset + id_len;
  mlval table;
  unsigned int image_offset = 0;
  unsigned int i=0;

  /* Calculate the space required for the table of contents. */
  for(table=DEREF(modules); table!=MLNIL; table=MLTAIL(table)) {
    mlval name = FIELD(MLHEAD(table), 0);
    table_len += LENGTH(GETHEADER(name))-1 + 1;
  }
  table_len = word_align(table_len);
  image_offset = table_offset + table_len;

  /* Write the table of contents */

  write(&id_offset, sizeof(unsigned int), 1, image);
  write(&table_offset, sizeof(unsigned int), 1, image);
  write(&image_offset, sizeof(unsigned int), 1, image);

  i = strlen(id);
  write(id, sizeof(char), i, image);
  for(; i < id_len; i++) {
    char c = '\0';
    write(&c, sizeof(char), 1, image);
  }

  for(i=0, table = DEREF(modules); table != MLNIL; table = MLTAIL(table)) {
    mlval name = FIELD(MLHEAD(table), 0);
    unsigned int len = LENGTH(GETHEADER(name))-1;

    write(CSTRING(name), sizeof(char), len, image);

    if (MLTAIL(table) != MLNIL) {
      char c = ' ';
      write(&c, sizeof(char), 1, image);
      i++;
    }

    i += len;
  }
  for(; i < table_len; i++) write("\0", sizeof(char), 1, image);

  /* Write the heap root */
  write(&root, sizeof(mlval), 1, image);

  /* Count the number of generations and static objects so that */
  /* image_load() knows how large to make its tables. */

  nr_gens = nr_static = 0;
  for(gen = creation; gen != NULL; gen = gen->parent) {
    nr_static += gen->nr_static;
    ++nr_gens;
  }

  DIAGNOSTIC(4, "  writing table sizes", 0, 0);
  DIAGNOSTIC(4, "    nr_gens = %u  nr_static = %u", nr_gens, nr_static);

  write(&nr_gens, sizeof(size_t), 1, image);
  write(&nr_static, sizeof(size_t), 1, image);

  /* Write out generation and space descriptors (including their addresses), */
  /* and the live contents of the spaces.  Static objects are not */
  /* included at this stage. */

  DIAGNOSTIC(4, "  writing main heap contents", 0, 0);
  
  for(gen = creation; gen != NULL; gen=gen->parent) {
    word sum;
    mlval *top = (gen == creation) ? gen->top : gen->image_top;
    size_t live = top - gen->start;

    DIAGNOSTIC(4, "    generation 0x%X (%d)", gen, gen->number);
    DIAGNOSTIC(4, "      start 0x%X  top 0x%X", gen->start, top);

    write(&gen, sizeof(struct ml_heap *), 1, image);
    write(gen, sizeof(struct ml_heap), 1, image);
    sum = checksum(gen->start, top);

    DIAGNOSTIC(4, "      checksum 0x%X  live %u", sum, live);
    
    write(gen->start, sizeof(mlval), live, image);
    write(&sum, sizeof(word), 1, image);

  }

  if(nr_static > 0) {
    /* Write out the static objects, including their addresses. */
    
    DIAGNOSTIC(4, "  writing %u static objects", nr_static, 0);

    for(gen = creation; gen != NULL; gen = gen->parent) {
      struct ml_static_object *stat = gen->statics.forward;
      DIAGNOSTIC(4, "   generation %d, sentinel 0x%08x", gen->number, &gen->statics);

      while(stat != &gen->statics) {
	mlval header = stat->object[0];
	mlval secondary = SECONDARY(header);
	mlval length = LENGTH(header);
	size_t size = OBJECT_SIZE(secondary,length);
	word *base = stat->object;
	word *top = (word*)((byte*)base + size);
	word sum = checksum(base, top);

	DIAGNOSTIC(4, "    stat object 0x%08x, %u bytes", stat, size);
	DIAGNOSTIC(4, "      forward 0x%08x back 0x%08x", stat->forward, stat->back);

	write(&stat, sizeof(struct ml_static_object *), 1, image);
	write(stat, sizeof(struct ml_static_object), 1, image);
	write(&size, sizeof(size_t), 1, image);
	write(base, 1, size, image);
	write(&sum, sizeof(word), 1, image);
	stat = stat->forward;
      }
    }
  }
  return;
}

mlval image_save(mlval argument)
{
  char *filename = CSTRING(FIELD(argument, 0));
  mlval root = FIELD(argument, 1);
  FILE *volatile image;
  int code = setjmp(problem);
  struct stream stream;

  if(code != 0) {
    (void)fclose(image);
    /* have to print the message this way because it is of unknown length */
    message_start();
    message_string("image save to '");
    message_string(filename);
    message_string("' failed, '");
    message_string(filename);
    message_string("' removed");
    message_end();
    if (remove(filename) != 0) {
      message_stderr("remove failed on '%s'", filename);
    }
    errno = code;
    return(MLERROR);
  }

  DIAGNOSTIC(2, "image_save(filename = \"%s\", root = 0x%X):", filename, root);

  image = fopen(filename, "wb");
  if(image == NULL) {
    DIAGNOSTIC(4, "  couldn't open file", 0, 0);
    errno = EIMAGEOPEN;
    return(MLERROR);
  }

  stream.type = FILE_STREAM;
  stream.the.file = image;
  (void)image_save_common(&stream, root);
  if(fclose(image) == EOF)
    longjmp(problem, EIMAGEWRITE);

  return(MLUNIT);
}

mlval image_save_with_open_file(FILE *image, mlval root, const char *filename)
{
  int code = setjmp(problem);
  struct stream stream;


  if(code != 0) {
    errno = code;
    return(MLERROR);
  }

  DIAGNOSTIC(2, "image_save(filename = \"%s\", root = 0x%X):", filename, root);

  stream.type = FILE_STREAM;
  stream.the.file = image;
  (void)image_save_common(&stream, root);

  return(MLUNIT);
}

mlval memory_image_save(mlval root, void *ptr, size_t limit, size_t *extent)
{
  int code = setjmp(problem);
  struct stream stream;

  if(code != 0) {
    message("executable image save failed");
    errno = code;
    return(MLERROR);
  }

  stream.type = STORE_STREAM;
  stream.the.store.ptr = ptr;
  stream.the.store.extent = limit;
  stream.the.store.index = 0;
  (void)image_save_common(&stream, root);

  *extent = stream.the.store.index; /* Remember how much used */
  DIAGNOSTIC(1, "Saving heap of size %d", *extent, 0);
  return MLUNIT;
}

mlval memory_image_save_size(mlval root, size_t *extent)
{
  int code = setjmp(problem);
  struct stream stream;

  if(code != 0) {
    message("executable image save failed");
    errno = code;
    return(MLERROR);
  }

  stream.type = SIZE_STREAM;
  stream.the.size = 0;
  (void)image_save_common(&stream, root);

  *extent = stream.the.size; /* Remember how much used */
  DIAGNOSTIC(1, "Heap size computed to be %d", *extent, 0);
  return MLUNIT;
}

/*  === LOAD AN IMAGE, REPLACING THE CURRENT HEAP ===  */


/*  == Pointer conversion tables ==
 *
 *  These static variables point to tables which are used to work out the
 *  correspondence between the memory configuration when the image was saved
 *  and its configuration on loading.
 *
 *  old_gen_table	pointers to where the generation descriptors were
 *  new_gen_table	where they are now
 *  old_stat_table	ditto for stat object headers
 *  new_stat_table
 *  stat_sizes		the size in bytes of the static objects
 *  old_basemap		maps old space numbers to their base address at
 			save time, or NULL if the space was outside the ML heap
 *  new_basemap         maps old space numbers to their new base address
 */

static size_t nr_gens, nr_static;
static struct ml_heap **old_gen_table, **new_gen_table;
static struct ml_static_object **old_stat_table, **new_stat_table;
static size_t *stat_sizes;
static mlval **old_basemap, **new_basemap;


/*  == Fixup an old image pointer ==
 *
 *  This function examines a save-time pointer and finds the object that it
 *  should point to using the pointer conversion tables above.
 */

static void fix(mlval *what)
{
  mlval value = *what;
  int space;
  mlval *base, *object, primary;
  size_t i;

  if(!MLVALISPTR(value))
    return;

  space = SPACE(value);

  if(space >= SPACES_IN_ARENA)
    return;

  base = old_basemap[space];
  object = OBJECT(value);
  primary = PRIMARY(value);

  /* Is the pointer to ML heap? */
  if(base != NULL) {
    *what = MLPTR(object-base+new_basemap[space], primary);
    return;
  }

  /* Is it a pointer to a static object? */
  for(i=0; i<nr_static; ++i) {
    word offset = (word)object - (word)(old_stat_table[i]->object);
    if (offset < (word)stat_sizes[i]) {
      *what = MLPTR((word)(new_stat_table[i]->object) + offset, primary);
      return;
    }
  }

  /* It's outside the heap, so leave it. */
}

#if 0
static void remove_dead_entry(union ml_array_header *array)
{
  array->the.back->the.forward = array->the.forward;
  array->the.forward->the.back = array->the.back;
}
#endif

static void fix_entry(union ml_array_header **what)
{
  union ml_array_header *entry = *what;
  int space = SPACE(entry);
  mlval *base = old_basemap[space];
  size_t i;

  /* Is is a pointer to an array on the dynamic heap? */
  if(base != NULL) {
    *what = (union ml_array_header *)((mlval *)entry-base+new_basemap[space]);
    return;
  }

  /* Maybe it's a pointer to an entry list header in one of the
   * generation descriptors. */

  for(i=0; i<nr_gens; ++i)
    if(entry == &old_gen_table[i]->entry) {
      *what = &new_gen_table[i]->entry;
      return;
    }

  /* Last chance: an entry list header for a static array */
  for(i=0; i<nr_static; ++i) {
    if (entry ==  (union ml_array_header *)(old_stat_table[i]->object)) {
      *what = (union ml_array_header *)(new_stat_table[i]->object);
      return;
    }
  }

  DIAGNOSTIC(4, "bad array header pointer 0x%X at 0x%X", entry, what);
  longjmp(problem, EIMAGEFORMAT);
}

static void fix_static(struct ml_static_object **what)
{
  struct ml_static_object *stat = *what;
  size_t i;

  /* The old positions of the static objects are all in the old_stat_table. */

  for(i=0; i<nr_static; ++i)
    if(stat == old_stat_table[i]) {
      *what = new_stat_table[i];
      return;
    }

  /* If it isn't actually a static object it must be a pointer to a static */
  /* object list header in one of the generation descriptors. */

  for(i=0; i<nr_gens; ++i)
    if(stat == &old_gen_table[i]->statics) {
      *what = &new_gen_table[i]->statics;
      return;
    }

  DIAGNOSTIC(4, "bad static object header pointer 0x%X at 0x%X", stat, what);
  longjmp(problem, EIMAGEFORMAT);
}

static void scan(mlval *start, mlval *end)
{
  while(start < end) {
    mlval value = *start;
    
    switch(PRIMARY(value)) {
      case INTEGER0:
      case INTEGER1:
      case PRIMARY6:
      case PRIMARY7:
      ++start;
      break;
      
      case HEADER:
      switch(SECONDARY(value)) {
	case STRING:
	case BYTEARRAY:
	start = (mlval *)double_align((byte *)(start+1) + LENGTH(value));
	continue;

	case CODE:
	fix(start+1);
	cache_flush((void*)(start+2), (LENGTH(value)+1) * sizeof(mlval));
	start += LENGTH(value)+1;
	continue;
	
	case ARRAY:
	case WEAKARRAY:
	{
	  union ml_array_header *array = (union ml_array_header *)start;
	  
	  if(array->the.back != NULL) {
	    fix_entry(&array->the.forward);
	    fix_entry(&array->the.back);
	  }
	  
	  start = &array->the.element[0];
	}
	break;
	
	default:
	++start;
      }
      break;
      
      default:
      fix(start);
      ++start;
    }
  }
}

static mlval image_load_common (struct stream *image)
{
  struct ml_heap *gen;
  size_t id_length;
  char file_id[MAX_ID_LENGTH];
  mlval root;
  int i;
  unsigned int id_offset, table_offset, image_offset;

  old_gen_table   = new_gen_table   = NULL;
  old_stat_table = new_stat_table   = NULL;
  old_basemap     = new_basemap     = NULL;
  stat_sizes			    = NULL;

  /* Does the image have the correct id? */

  DIAGNOSTIC(4, "  reading id_offset", 0, 0);
  read(&id_offset, sizeof(unsigned int), 1, image);
  DIAGNOSTIC(4, "  reading table_offset", 0, 0);
  read(&table_offset, sizeof(unsigned int), 1, image);
  DIAGNOSTIC(4, "  reading image_offset", 0, 0);
  read(&image_offset, sizeof(unsigned int), 1, image);
  DIAGNOSTIC(4, "  id_offset = %u  table_offset = %u", id_offset, table_offset);
  DIAGNOSTIC(4, "  image_offset = %u", image_offset, 0);
  if(id_offset!=IMAGE_HEADER_SIZE || id_offset>=table_offset || table_offset>image_offset)
    longjmp(problem, EIMAGEFORMAT);

  id_length = strlen(id);
  read(file_id, sizeof(char), id_length, image);
  DIAGNOSTIC(4, "id read was `%.24s'", id, 0);
  if(strncmp(id, file_id, id_length) != 0)
    longjmp(problem, EIMAGEVERSION);
  id_length += id_offset;

  /* Now ignore the name table, not necessary for real loading */
  while(id_length < image_offset) {
    char dummy;
    read(&dummy, sizeof(char), 1, image);
    ++id_length;
  }

  /* Read the heap root */

  read(&root, sizeof(mlval), 1, image);

  /* Allocate tables of pointers to the old and new positions of the */
  /* generations and static objects. */

  read(&nr_gens, sizeof(size_t), 1, image);
  read(&nr_static, sizeof(size_t), 1, image);

  DIAGNOSTIC(4, "  nr_gens = %u  nr_static = %u", nr_gens, nr_static);

  old_gen_table   = (struct ml_heap **)allocate(sizeof(struct ml_heap *) * nr_gens);
  new_gen_table   = (struct ml_heap **)allocate(sizeof(struct ml_heap *) * nr_gens);
  old_stat_table  = (struct ml_static_object **)allocate(sizeof(struct ml_static_object *) * nr_static);
  new_stat_table  = (struct ml_static_object **)allocate(sizeof(struct ml_static_object *) * nr_static);
  stat_sizes      = (size_t *)allocate(sizeof(size_t) * nr_static);
  old_basemap     = (mlval **)allocate(sizeof(mlval *) * SPACES_IN_ARENA);
  new_basemap     = (mlval **)allocate(sizeof(mlval *) * SPACES_IN_ARENA);

  for(i=0; i<SPACES_IN_ARENA; ++i)
    old_basemap[i] = new_basemap[i] = NULL;

  /* Delete the current heap. */
  gen = creation;
  while(gen != NULL) {
    struct ml_heap *parent = gen->parent;
    unmake_ml_heap(gen);
    gen = parent;
  }

  DIAGNOSTIC(4, "  reading main heap contents", 0, 0);

  for(i=0; i<(int)nr_gens; ++i) {
    size_t size, live;
    struct ml_heap *gen, descriptor;
    word old_sum, new_sum;
    mlval *top;

    DIAGNOSTIC(4, "    generation %i", i, 0);

    read(&old_gen_table[i], sizeof(struct ml_heap *), 1, image);
    read(&descriptor, sizeof(struct ml_heap), 1, image);

    DIAGNOSTIC(4, "      old descriptor was at 0x%X numbered %d", old_gen_table[i], descriptor.number);
    DIAGNOSTIC(4, "        parent 0x%X  child 0x%X", descriptor.parent, descriptor.child);
    DIAGNOSTIC(4, "        start 0x%X  end 0x%X", descriptor.start, descriptor.end);
    DIAGNOSTIC(4, "        entry forward 0x%X  back 0x%X", descriptor.entry.the.forward, descriptor.entry.the.back);
    DIAGNOSTIC(4, "        stat forward 0x%X  back 0x%X", descriptor.statics.forward, descriptor.statics.back);

    if(descriptor.number != i) {
      DIAGNOSTIC(4, "      bad generation number %d", descriptor.number, 0);
      longjmp(problem, EIMAGEFORMAT);
    }

    top = (i == 0) ? descriptor.top : descriptor.image_top;
    size = (descriptor.end - descriptor.start)*sizeof(mlval);
    live = (top - descriptor.start)*sizeof(mlval);

    DIAGNOSTIC(4, "        size 0x%X values  live 0x%X values", size, live);

    new_gen_table[i] = gen = make_ml_heap(descriptor.values, size);

    if(i == 0)
      creation = gen;
    else {
      gen->child = new_gen_table[i-1];
      new_gen_table[i-1]->parent = gen;
    }

    gen->number		= descriptor.number;
    gen->collect	= descriptor.collect;
    gen->values		= descriptor.values;
    gen->top		= gen->start + live/sizeof(mlval);
    gen->image_top	= gen->top; /* A suitable starting value */
    gen->entry		= descriptor.entry;
    gen->last		= descriptor.last;
    gen->nr_entries	= descriptor.nr_entries;
    gen->statics	= descriptor.statics;
    gen->nr_static	= descriptor.nr_static;

    DIAGNOSTIC(4, "      new descriptor is at 0x%X numbered %d", gen, gen->number);
    DIAGNOSTIC(4, "        start 0x%X  end 0x%X", gen->start, gen->end);

    read(gen->start, 1, live, image);

    read(&old_sum, sizeof(word), 1, image);
    new_sum = checksum(gen->start, gen->top);
    DIAGNOSTIC(4, "        checksum old 0x%X  new 0x%X", old_sum, new_sum);

    if(old_sum != new_sum)
      longjmp(problem, EIMAGEFORMAT);

    old_basemap[descriptor.space] = descriptor.start;
    new_basemap[descriptor.space] = gen->start;
  }

  if(nr_static > 0) {
    DIAGNOSTIC(4, "  reading stat objects", 0, 0);

    for(i=0; i<(int)nr_static; ++i) {
      struct ml_static_object *stat, descriptor;
      word old_sum, new_sum;
      word *base, *top;

      read(&old_stat_table[i], sizeof(struct ml_static_object *), 1, image);
      read(&descriptor, sizeof(struct ml_static_object), 1, image);
      read(&stat_sizes[i], sizeof(size_t), 1, image);

      DIAGNOSTIC(4, "    stat object was at 0x%X, %u bytes", old_stat_table[i], stat_sizes[i]);

      new_stat_table[i] = stat = make_static_object(stat_sizes[i]);

      stat -> forward = descriptor.forward;
      stat -> back    = descriptor.back; 

      DIAGNOSTIC(4, "         forward was at 0x%X back at 0x%X", (unsigned)stat -> forward, (unsigned)stat-> back);

      base = stat->object;
      read(base, 1, stat_sizes[i], image);
      top = (mlval *)((byte*)base + stat_sizes[i]);
      read(&old_sum, sizeof(word), 1, image);
      new_sum = checksum(base, top);

      DIAGNOSTIC(4, "      checksum old 0x%X  new 0x%X", old_sum, new_sum);

      if(old_sum != new_sum)
	longjmp(problem, EIMAGEFORMAT);
    };

  }

  DIAGNOSTIC(4, "  fixing root", 0, 0);
  fix(&root);

  DIAGNOSTIC(4, "  fixing heap values", 0, 0);
  for(gen = creation; gen != NULL; gen = gen->parent) {
    struct ml_static_object *stat;

    DIAGNOSTIC(4, "  generation 0x%X %d", gen, gen->number);

    DIAGNOSTIC(4, "    fixing entry forward 0x%X back 0x%X", gen->entry.the.forward, gen->entry.the.back);
    fix_entry(&gen->entry.the.forward);
    fix_entry(&gen->entry.the.back);
    DIAGNOSTIC(4, "    to           forward 0x%X back 0x%X", gen->entry.the.forward, gen->entry.the.back);

    DIAGNOSTIC(4, "    fixing stat  forward 0x%X back 0x%X", gen->statics.forward, gen->statics.back);
    fix_static(&gen->statics.forward);
    fix_static(&gen->statics.back);
    DIAGNOSTIC(4, "    to           forward 0x%X back 0x%X", gen->statics.forward, gen->statics.back);

    gen->statics.gen = gen;
    stat = gen->statics.forward;

    while(stat != &gen->statics) {
      mlval header = stat->object[0];
      mlval secondary = SECONDARY(header);
      mlval length = LENGTH(header);
      size_t size = OBJECT_SIZE(secondary,length);
      mlval *base = &stat->object[0];
      mlval *top = (mlval*) ((byte*)base + size);

      stat->gen = gen;
      DIAGNOSTIC(4, "        static object at 0x%X", stat, 0);
      DIAGNOSTIC(4, "          fixing forward 0x%X back 0x%X", stat->forward, stat->back);
      fix_static(&stat->forward);
      fix_static(&stat->back);
      DIAGNOSTIC(4, "          to     forward 0x%X back 0x%X", stat->forward, stat->back);

      DIAGNOSTIC(4, "          scanning 0x%X to 0x%X", base, top);
      scan(base, top);

      stat = stat->forward;
    }

    DIAGNOSTIC(4, "    scanning 0x%X to 0x%X", gen->start, gen->top);
    scan(gen->start, gen->top);
  }

  /* Fix any pointers dangling off the end of the entry lists */
#if 0
  for (gen = creation; gen!= NULL; gen=gen->parent) {
    union ml_array_header *array = gen->entry.the.forward, *last = &gen->entry;
    while (array != &gen->entry) {
      struct ml_heap *array_gen = GENERATION(array);
      if ((mlval *)array < array_gen->start || (mlval *)array >= array_gen->top) {
	/* Gone off the end, so point last back at gen->entry */
	DIAGNOSTIC(0, "Fixing off end pointer in entry list for generation %d", gen->number, 0);
	last->the.forward = &gen->entry;
	gen->entry.the.back = last;
	break; /* Finished while loop here */
      } else {
	last = array;
	array = array->the.forward;
      }
    }
  }
#else
  for (gen = creation; gen!= NULL; gen=gen->parent) {
    union ml_array_header *array;
    if (gen->nr_entries != 0) {
      fix_entry(&gen->last.the.back); /* This now points to the right place */
      /* Now fix the thing pointed to back into the entry list */
      array = gen->last.the.back;
      array->the.forward = &gen->entry;
      gen->entry.the.back = array;
    }
  }
#endif

  /* Copy the creation space pointers to the ML registers so that ML can use */
  /* them. */
  GC_HEAP_LIMIT = creation->end;
  GC_HEAP_REAL_LIMIT = creation->end;
  GC_HEAP_START = creation->top;
  GC_MODIFIED_LIST = NULL;

  return(root);
}

mlval image_load(mlval argument)
{
  char *filename = CSTRING(argument);
  FILE *volatile image;
  struct stream stream;
  mlval root;
  int code;

  /* Catch errors generated by a longjmp to problem and clean up before */
  /* exiting with the error code specified. */
  
  if((code = setjmp(problem)) != 0) {
    (void)fclose(image);
    if(old_gen_table   != NULL) free(old_gen_table);
    if(new_gen_table   != NULL) free(new_gen_table);
    if(old_stat_table  != NULL) free(old_stat_table);
    if(new_stat_table  != NULL) free(new_stat_table);
    if(old_basemap     != NULL) free(old_basemap);
    if(new_basemap     != NULL) free(new_basemap);
    if(stat_sizes      != NULL) free(stat_sizes);
    errno = code;
    return(MLERROR);
  }

  DIAGNOSTIC(2, "image_load(\"%s\"):", filename, 0);

  image = fopen(filename, "rb");
  if(image == NULL) {
    DIAGNOSTIC(4, "  couldn't open image file", 0, 0);
    errno = EIMAGEOPEN;
    return(MLERROR);
  }

  stream.type = FILE_STREAM;
  stream.the.file = image;
  root = image_load_common(&stream);
  
  (void)fclose(image);

  return(root);
}

mlval image_load_with_open_file(FILE *image, const char *filename)
{
  struct stream stream;
  mlval root;
  int code;

  /* Catch errors generated by a longjmp to problem and clean up before */
  /* exiting with the error code specified. */
  
  if((code = setjmp(problem)) != 0) {
    if(old_gen_table   != NULL) free(old_gen_table);
    if(new_gen_table   != NULL) free(new_gen_table);
    if(old_stat_table  != NULL) free(old_stat_table);
    if(new_stat_table  != NULL) free(new_stat_table);
    if(old_basemap     != NULL) free(old_basemap);
    if(new_basemap     != NULL) free(new_basemap);
    if(stat_sizes      != NULL) free(stat_sizes);
    errno = code;
    return(MLERROR);
  }

  DIAGNOSTIC(2, "image_load(\"%s\"):", filename, 0);

  stream.type = FILE_STREAM;
  stream.the.file = image;
  root = image_load_common(&stream);
  
  return(root);
}

mlval memory_image_load(void *ptr, size_t extent)
{
  struct stream stream;
  mlval root;
  int code;

  /* Catch errors generated by a longjmp to problem and clean up before */
  /* exiting with the error code specified. */
  
  if((code = setjmp(problem)) != 0) {
    if(old_gen_table   != NULL) free(old_gen_table);
    if(new_gen_table   != NULL) free(new_gen_table);
    if(old_stat_table  != NULL) free(old_stat_table);
    if(new_stat_table  != NULL) free(new_stat_table);
    if(old_basemap     != NULL) free(old_basemap);
    if(new_basemap     != NULL) free(new_basemap);
    if(stat_sizes      != NULL) free(stat_sizes);
    errno = code;
    return(MLERROR);
  }

  stream.type = STORE_STREAM;
  stream.the.store.ptr = ptr;
  stream.the.store.extent = extent;
  stream.the.store.index = 0;
  root = image_load_common(&stream);

  return(root);
}


/*  ==== READ THE CONTENTS TABLE FOR AN IMAGE ====
 *
 *  Returns an ml list of strings representing the filenames that made up
 *  this image.
 */

mlval image_table(mlval argument)
{
  char *filename = CSTRING(argument);
  FILE *volatile image;
  unsigned int id_offset, id_length, table_offset, table_len, image_offset;
  char *table, *scan;
  mlval result;
  char file_id[MAX_ID_LENGTH];
  int code;
  struct stream stream;

  image = fopen(filename, "rb");
  if(image == NULL) {
    DIAGNOSTIC(4, "  couldn't open image file", 0, 0);
    errno = EIMAGEOPEN;
    return(MLERROR);
  }

  if((code = setjmp(problem)) != 0) {
    (void)fclose(image);
    errno = code;
    return(MLERROR);
  }

  stream.type = FILE_STREAM;
  stream.the.file = image;

  /* Does the image have the correct id? */

  read(&id_offset, sizeof(unsigned int), 1, &stream);
  read(&table_offset, sizeof(unsigned int), 1, &stream);
  read(&image_offset, sizeof(unsigned int), 1, &stream);
  DIAGNOSTIC(3, "  id_offset = %u  table_offset = %u", id_offset, table_offset);
  DIAGNOSTIC(3, "  image_offset = %u", image_offset, 0);

  if(id_offset!=IMAGE_HEADER_SIZE || id_offset>=table_offset || table_offset>image_offset)
    longjmp(problem, EIMAGEVERSION);

  id_length = strlen(id);
  read(file_id, sizeof(char), id_length, &stream);
  DIAGNOSTIC(3, "id read was `%.24s'", id, 0);
  if(strncmp(id, file_id, id_length) != 0)
    longjmp(problem, EIMAGEVERSION);
  id_length += id_offset;

  while (id_length < table_offset) {
    char dummy;
    read(&dummy, sizeof(char), 1, &stream);
    ++id_length;
  }

  table_len = image_offset - table_offset;

  DIAGNOSTIC(3, "  Read up to the table. table_len = %u", table_len, 0);

  if(table_len == 0) {
    fclose(image);
    return(MLNIL);
  }

  table = malloc(table_len);
  read(table, sizeof(char), table_len, &stream);
  fclose(image);

  DIAGNOSTIC(3, "  table `%s'", table, 0);

  if(table[table_len-1] != '\0') {
    free(table);
    longjmp(problem, EIMAGEFORMAT);
  }

  result = MLNIL;
  declare_root(&result, 0);
  for(scan=strtok(table, " "); scan!=NULL; scan=strtok(NULL, " ")) {
    mlval s = ml_string(scan);
    result = mlw_cons(s, result);
  }
  retract_root(&result);
  free(table);

  return(result);
}
