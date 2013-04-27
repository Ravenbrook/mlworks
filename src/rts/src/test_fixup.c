/*  === TESTING GARBAGE COLLECTION FIXUP ===
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
 *  Description
 *  -----------
 *  A test suite for the innermost code in the GC. This file
 *  substitutes for main.c when building the testing image. 
 *
 *  Revision Log
 *  ------------
 *  $Log: test_fixup.c,v $
 *  Revision 1.4  1998/04/24 10:57:59  jont
 *  [Bug #70032]
 *  gen->values now measured in bytes
 *
 * Revision 1.3  1997/01/28  11:36:50  nickb
 * Add declaration of runtime.
 *
 * Revision 1.2  1995/05/31  08:52:31  nickb
 * Fill all spaces with bad values before each test.
 *
 * Revision 1.1  1995/05/26  14:30:12  nickb
 * new unit
 * A test harness for the fixup routine.
 *
 * */

#include <stdio.h>
#include "ansi.h"
#include "alloc.h"
#include "fixup.h"
#include "mem.h"
#include "utils.h"

#define align(v,n) (((word)(v) + (n-1)) & (~(n-1)))

#define TEST_WORDS 1000
#define TEST_NAME_SIZE 1000

static mlval *build_space;		/* where we build an object to test */
static mlval *copy_of_build_space;	/* A copy of an original object */
static mlval *from_space;		/* where the fixup finds objects */
static mlval *to_space;			/* where the fixup copies objects to */
static mlval fixable;			/* the value which the fixup fixes */

/* first a whole bunch of code as tools for the tests */

/* do_fix actually applies the 'fix' macro. */

static mlval *do_fix (mlval *to, mlval *what)
{
  mlval *answer = to;
  fix(answer,what);
  return answer;
}

/* output tools */

static char test_name[TEST_NAME_SIZE];	/* name of the current test */
static int debugging;		

/* name_test() creates the name of the current test.
 * When in debugging mode, it also prints it out. */

static void name_test(const char *string, ...)
{
  va_list arg;
  va_start (arg,string);
  vsprintf(test_name,string,arg);
  va_end(arg);
  if (debugging)
    printf("%s\n",test_name);
}

/* test_fail() prints a test failure message. */

static void test_fail(const char *string, ...)
{
  va_list arg;
  va_start (arg,string);
  printf("%s failed: \n",test_name);
  vprintf(string, arg);
  va_end (arg);
}

/* compare_copies() compares build_space (where an object was
   constructed) with to_space (to which it has been copied. It reports
   any discrepancies as test failures. */

static void compare_copied(size_t words)
{
  int i = 0;
  int same = 1;
  while (i < words) {
    if (build_space[i] != to_space[i]) {
      if (same)
	test_fail("  differences found in copy:\n");
      printf("    word %d (at 0x%x) was 0x%x is 0x%x\n",
	     i, (unsigned)(to_space+i), build_space[i], to_space[i]);
      same = 0;
    }
    i++;
  }
}

/* compare_original() compares build_space (where we have an image of
   the from_space object as it should be after fixing -- including any
   marks and or forwarding pointers) with from_space. Any
   discrepancies are reported as test failures. copy_of_build_space
   (where we have an image of the from_space object as it was before
   fixing) is used to clarify the failure message. */
    
static void compare_original(size_t words)
{
  int i = 0;
  int same = 1;
  while (i < words) {
    if (build_space[i] != from_space[i]) {
      if (same)
	test_fail("  differences found in from-object:\n");
      if (copy_of_build_space[i] != build_space[i])
	printf("    word %d (at 0x%x) was 0x%x, should be 0x%x, is 0x%x\n",
	       i, (unsigned)(from_space+i), copy_of_build_space[i],
	       build_space[i], from_space[i]);
      else
	printf("    word %d (at 0x%x) should be 0x%x, is 0x%x\n",
	       i, (unsigned)(from_space+i), build_space[i], from_space[i]);
      same = 0;
    }
    i++;
  }
}

/* compare_static compares build_space (where we constructed a static
   object) to the static object. Any differences are reported as test
   errors. */

static void compare_static(size_t words, struct ml_static_object *stat)
{
  int i = 0;
  int same = 1;
  while (i < words) {
    if (build_space[i] != stat->object[i]) {
      if (same)
	test_fail("  changes found in static object:\n");
      printf("    word %d (at 0x%x) was 0x%x is 0x%x\n",
	     i, (unsigned)(stat->object+i), build_space[i], stat->object[i]);
      same = 0;
    }
    i++;
  }
}  

/* fill() fills an area of memory with a value */

static void fill(mlval *where, size_t words, mlval val)
{
  while (words--)
    *where++ = val;
}

static void fill_all(void)
{
  fill(to_space, TEST_WORDS, DEAD);
  fill(build_space, TEST_WORDS, DEAD);
  fill(copy_of_build_space, TEST_WORDS, DEAD);
  fill(from_space, TEST_WORDS, DEAD);
}

/* blat() writes varied junk into memory. */

static void blat(mlval *where, size_t words)
{
  mlval seed = 0xdeadbeef;
  int i = words;
  while(i--) {
    *where++ = seed;
    seed ^= (seed<<2) ^ (seed >> 3);
  }
}

/* construct_object() builds an object in build_space with a header
   word constructed from the length and tag arguments. The contents of
   the object are junk built by blat(). */

static void construct_object(size_t data_words,
			     size_t length,
			     mlval tag)
{
  build_space[0] = MAKEHEAD(tag,length);
  blat(build_space+1,data_words);
}

/* test_fixup copies the constructed object from build_space to
   from_space, applies fixup, checks the fixed value, the number of
   words copied, and the copied words themselves. */

static void test_fixup(size_t words_built,
		       size_t words_fix_should_copy,
		       mlval fixed_value)
{
  mlval *new_to;

  memcpy(from_space, build_space, words_built*4);
  new_to = do_fix(to_space, &fixable);
  if (fixed_value != fixable)
    test_fail("  incorrect fix value 0x%x not 0x%x\n", fixable, fixed_value);
  else if (new_to - to_space != words_fix_should_copy)
    test_fail("  incorrect number of words copied %d not %ld\n",
	      new_to-to_space, words_fix_should_copy);
  else if (words_fix_should_copy)
    compare_copied(words_built);
}

/* We don't actually use this:

static void test_fixup_0_forward(size_t words_built,
				  size_t words_fix_should_copy,
				  mlval fixed_value)
{
  test_fixup(words_built,
	     words_fix_should_copy,
	     fixed_value);
  compare_original(words_built);
}

*/

/* test_fixup_1_forward() does a test_fixup and then applies a single
   fix to the built object and compares the from_space object against
   the resulting contents */

static void test_fixup_1_forward(size_t words_built,
				 size_t words_fix_should_copy,
				 mlval fixed_value,
				 mlval *where,
				 mlval forward)
{
  memcpy(copy_of_build_space, build_space, words_built*4);
  test_fixup(words_built,
	     words_fix_should_copy,
	     fixed_value);
  *where = EVACUATED;
  where[1] = forward;
  compare_original(words_built);
}

/* test_fixup_1_forward() does a test_fixup and then applies two fixes
   to the built object and compares the from_space object against the
   resulting contents */

static void test_fixup_2_forward(size_t words_built,
				 size_t words_fix_should_copy,
				 mlval fixed_value,
				 mlval *where1,
				 mlval forward1,
				 mlval *where2,
				 mlval forward2)
{
  memcpy(copy_of_build_space, build_space, words_built*4);
  test_fixup(words_built,
	     words_fix_should_copy,
	     fixed_value);
  *where1 = EVACUATED;
  *where2 = EVACUATED;
  where1[1] = forward1;
  where2[1] = forward2;
  compare_original(words_built);
}

/* 'map', to apply functions to a vector of argument values */

static void sizes_map (size_t *sizes, void (*f)(size_t))
{
  while(*sizes) {
    f(*sizes);
    sizes++;
  }
}

/* testing non-pointer values */

static void test_a_non_ptr(mlval it)
{
  name_test("testing non-pointer 0x%x",it);
  fixable = it;
  test_fixup(0,0,it);
}

static void test_non_ptr(void)
{
  test_a_non_ptr(0);
  test_a_non_ptr(4);
  test_a_non_ptr((mlval)to_space);
  test_a_non_ptr((mlval)from_space);
  test_a_non_ptr((mlval)from_space+4);
}

/* testing records and code objects */

size_t record_sizes[] = {1,2,3,4,10,11,0};

static mlval record_secondary = 0;

static void test_record_size(size_t size)
{
  size_t aligned_size = align(size+1,2u);
  mlval result = ((mlval)to_space)+POINTER;
  name_test("testing %s size %ld",
	    record_secondary == RECORD ? "record" :
	    record_secondary == CODE ? "code" :
	    "unrecognised record", size);
  fill_all();
  construct_object(aligned_size, size, record_secondary);
  fixable = ((mlval)from_space)+POINTER;
  test_fixup_1_forward(size+1, aligned_size, result,
		       build_space, result);
}

static void test_code(void)
{
  record_secondary = CODE;
  sizes_map(record_sizes, test_record_size);
}

static void test_record(void)
{
  record_secondary = RECORD;
  sizes_map(record_sizes, test_record_size);
}

/* testing string objects */

size_t string_sizes[] = {1,4,5,8,9,12,27,0};

static void test_string_size(size_t size)
{
  size_t data_words = (size+3)>>2;
  size_t aligned_size = align(data_words+1,2u);
  mlval result = ((mlval)to_space)+POINTER;
  name_test("testing string size %ld", size);
  fill_all();
  construct_object(aligned_size, size, STRING);
  fixable = ((mlval)from_space)+POINTER;
  test_fixup_1_forward(data_words+1, aligned_size, result,
		       build_space, result);
}

/* testing reals */

static void test_real(void)
{
  mlval result = ((mlval)to_space)+POINTER;
  fill_all();
  construct_object(12, 12, BYTEARRAY);
  *(double *)(build_space+2) = 3.1415927;
  fixable = ((mlval)from_space)+POINTER;
  test_fixup_1_forward(4, 4, result, build_space, result);
}

/* testing all string-like objects (strings and reals) */

static void test_string(void)
{
  sizes_map(string_sizes, test_string_size);
  test_real();
}

/* testing arrays */

size_t array_sizes[] = {1,2,3,4,10,11};
static int array_on_entry_list = 0;
static mlval array_secondary = 0;
static union ml_array_header next, last;

static void test_array_size(size_t size)
{
  size_t aligned_size = align(size+3,2u);
  mlval result = ((mlval)to_space)+REFPTR;
  name_test("testing %s size %ld %s",
	    (array_secondary == ARRAY ? "array" :
	     array_secondary == WEAKARRAY ? "weak array" :
	     "unrecognised array"), size,
	    array_on_entry_list ? "on entry list" : "");
  if (array_on_entry_list) {
    next.the.back = (union ml_array_header *)from_space;
    last.the.forward = (union ml_array_header *)from_space;
  }
  fill_all();
  construct_object(aligned_size,size,array_secondary);
  if (array_on_entry_list) {
    ((union ml_array_header *)build_space)->the.forward = &next;
    ((union ml_array_header *)build_space)->the.back = &last;
  } else {
    ((union ml_array_header *)build_space)->the.forward = NULL;
    ((union ml_array_header *)build_space)->the.back = NULL;
  }
  fixable = ((mlval)from_space)+REFPTR;
  test_fixup_1_forward(size+3, aligned_size, result,
		       build_space, result);
  if (array_on_entry_list) {
    if (next.the.back != (union ml_array_header *)to_space) {
      test_fail("  entry list pointer in 'next' record not fixed.\n");
    }
    if (last.the.forward != (union ml_array_header *)to_space) {
      test_fail("  entry list pointer in 'last' record not fixed.\n");
    }
  }
}

static void test_array_entry_head(int on_entry_list, int secondary)
{
  array_on_entry_list = on_entry_list;
  array_secondary = secondary;
  sizes_map(array_sizes, test_array_size);
}

static void test_array_head(int secondary)
{
  test_array_entry_head(1,secondary);
  test_array_entry_head(0,secondary);
}

static void test_array(void)
{
  test_array_head(ARRAY);
  test_array_head(WEAKARRAY);
}

/* testing bytearrays */

size_t bytearray_sizes[] = {1,4,5,8,9,12,27,0};

static void test_bytearray_size(size_t size)
{
  size_t data_words = (size+3)>>2;
  size_t aligned_size = align(data_words+1,2u);
  mlval result = ((mlval)to_space)+REFPTR;
  name_test("testing bytearray size %ld", size);
  fill_all();
  construct_object(aligned_size, size, BYTEARRAY);
  fixable = ((mlval)from_space)+REFPTR;
  test_fixup_1_forward(data_words+1, aligned_size, result,
		       build_space, result);
}

static void test_bytearray(void)
{
  sizes_map(bytearray_sizes,test_bytearray_size);
}

/* testing already-evacuated objects */

static void test_evac_with_primary(mlval tag)
{
  name_test("testing already-evacuated value with primary %d",tag);
  build_space[0] = EVACUATED;
  build_space[1] = 0xdeadbeef;
  fixable = (mlval)from_space+tag;
  test_fixup(2,0,0xdeadbeef);
}

static void test_evac(void)
{
  test_evac_with_primary(POINTER);
  test_evac_with_primary(PAIRPTR);
  test_evac_with_primary(REFPTR);
}

/* testing pairs */

static void test_pair_contents(mlval car, mlval cdr)
{
  mlval result = (mlval)to_space+PAIRPTR;
  name_test("testing pair (0x%x,0x%x)",car,cdr);
  fill_all();
  build_space[0] = car;
  build_space[1] = cdr;
  fixable = (mlval)from_space+PAIRPTR;
  test_fixup_1_forward(2,2,result, build_space, result);
}

static void test_pair(void)
{
  test_pair_contents(MLUNIT,MLUNIT);
  test_pair_contents(POINTER,POINTER);
  test_pair_contents((mlval)to_space, (mlval)to_space);
}

/* testing unevacuated backptr objects */

static void test_backptr_not_evac_sized(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1,2u);
  mlval result = (mlval)(to_space + offset*2)+POINTER;
  name_test("testing backptr to non-evacuated object, size %d offset %d",
	    size, offset);
  fill_all();
  construct_object(aligned_size, size, CODE);
  build_space[offset*2] = MAKEHEAD(BACKPTR, offset*8);
  fixable = (mlval)(from_space + offset*2)+POINTER;
  test_fixup_2_forward(size+1, aligned_size, result,
		       build_space+offset*2, result,
		       build_space, (mlval)to_space+POINTER);
}

static void test_backptr_not_evac(void)
{
  test_backptr_not_evac_sized(200, 10);
  test_backptr_not_evac_sized(313, 2);
  test_backptr_not_evac_sized(117, 1);
}

/* testing evacuated backptr objects */

static void test_backptr_evac_sized(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1,2u);
  mlval result = 0xdeadbeef + offset*8;
  name_test("testing backptr to evacuated object, size %d offset %d",
	    size, offset);
  fill_all();
  construct_object(aligned_size, size, CODE);
  build_space[offset*2] = MAKEHEAD(BACKPTR, offset*8);
  build_space[0] = EVACUATED;
  build_space[1] = 0xdeadbeef;
  fixable = (mlval)(from_space + offset*2)+POINTER;
  test_fixup_1_forward(size+1, 0, result,
		       build_space+offset*2, result);
}

static void test_backptr_evac(void)
{
  test_backptr_evac_sized(200, 10);
  test_backptr_evac_sized(313, 2);
  test_backptr_evac_sized(117, 1);
}

/* testing all backptr objects */

static void test_backptr(void)
{
  test_backptr_evac();
  test_backptr_not_evac();
}

/* testing evacuated shared closure objects */

static void test_shared_closure_evac_sized(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1,2u);
  mlval result = 0xdeadbeef + offset*8;
  int i;
  name_test("testing pointer to evacuated shared closure, size %d offset %d",
	    size, offset);
  fill_all();
  construct_object(aligned_size, size, RECORD);
  for (i=offset; i > 0 ; i--)
    build_space[i*2] = 0;
  build_space[0] = EVACUATED;
  build_space[1] = 0xdeadbeef;
  fixable = (mlval)(from_space + offset*2)+POINTER;
  test_fixup_1_forward(size+1, 0, result, build_space+offset*2, result);
}


static void test_shared_closure_evac(void)
{
  test_shared_closure_evac_sized(200, 10);
  test_shared_closure_evac_sized(313, 2);
  test_shared_closure_evac_sized(117, 1);
}

/* testing unevacuated shared closure objects */

static void test_shared_closure_not_evac_sized(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1,2u);
  int i;
  mlval result = (mlval)(to_space + offset*2)+POINTER;
  name_test("testing pointer to shared closure, size %d offset %d",
	    size, offset);
  fill_all();
  construct_object(aligned_size, size, RECORD);
  for (i=offset; i > 0 ; i--)
    build_space[i*2] = 0;
  fixable = (mlval)(from_space + offset*2)+POINTER;
  test_fixup_2_forward(size+1, aligned_size, result,
		       build_space, (mlval)to_space+POINTER,
		       build_space+offset*2, result);
}

static void test_shared_closure_not_evac(void)
{
  test_shared_closure_not_evac_sized(200, 10);
  test_shared_closure_not_evac_sized(313, 2);
  test_shared_closure_not_evac_sized(117, 1);
}

/* testing all shared closure objects */

static void test_shared_closure(void)
{
  test_shared_closure_evac();
  test_shared_closure_not_evac();
}

/* general function for testing static objects */

static void test_static_fix(struct ml_static_object *stat,
			    size_t words_built,
			    mlval fixable_offset)
{
  mlval *new_to, fixed;
  stat->mark = 1;
  fixed = fixable = ((mlval)stat->object)+fixable_offset;
  memcpy(stat->object, build_space, words_built*4);
  new_to = do_fix(to_space, &fixable);
  if (new_to != to_space)
    test_fail("  to-space pointer has changed 0x%x to 0x%x\n",
	      to_space, new_to);
  if (fixed != fixable)
    test_fail("  fix value has changed 0x%x to 0x%x\n", fixed, fixable);
  if (stat->mark != 0)
    test_fail("  static object has not been marked\n");
  compare_static(words_built, stat);
}

/* testing regular static objects */

static void test_static_regular_size(size_t words, mlval secondary,
				     size_t size, mlval primary)
{
  struct ml_static_object *stat = make_static_object(words*4);
  fill_all();
  construct_object(words-1, size, secondary);
  name_test("testing regular static object header 0x%x primary %d",
	    stat->object[0],primary);
  test_static_fix(stat, words, primary);
  unmake_static_object(stat);
}
				     
static void test_static_regular(void)
{
  test_static_regular_size(6,RECORD,5,POINTER);
  test_static_regular_size(2,0,0,PAIRPTR);
  test_static_regular_size(100,CODE,98,POINTER);
}

/* testing backpointers into static objects */

static void test_static_backptr_size(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1, 2u);
  struct ml_static_object *stat = make_static_object(aligned_size * 4);
  fill_all();
  construct_object(aligned_size, size, CODE);
  build_space[offset*2] = MAKEHEAD(BACKPTR, offset*8);
  name_test("testing backptr to static object size %ld offset %ld",
	    size, offset);
  test_static_fix(stat, aligned_size, offset*8+POINTER);
  unmake_static_object(stat);
}

static void test_static_backptr(void)
{
  test_static_backptr_size(200, 10);
  test_static_backptr_size(313, 2);
  test_static_backptr_size(117, 1);
}

/* testing static shared closures */

static void test_static_shared_closure_sized(size_t size, size_t offset)
{
  size_t aligned_size = align(size+1,2u);
  struct ml_static_object *stat = make_static_object(aligned_size*4);
  int i;
  name_test("testing pointer to static shared closure, size %d offset %d",
	    size, offset);
  fill_all();
  construct_object(aligned_size, size, RECORD);
  for (i=offset; i > 0 ; i--)
    build_space[i*2] = 0;
  test_static_fix(stat, aligned_size, offset*8+POINTER);
}

static void test_static_shared_closure(void)
{
  test_static_shared_closure_sized(200,10);
  test_static_shared_closure_sized(313,2);
  test_static_shared_closure_sized(117,1);
}

/* testing all static objects */

static void test_static(void)
{
  test_static_regular();
  test_static_backptr();
  test_static_shared_closure();
}

/* testing values which do not address fromspace */

static void test_a_not_from(mlval it)
{
  name_test("testing a pointer not into from_space: 0x%x",it);
  fixable = it;
  test_fixup(0,0,it);
}

static void test_not_from(void)
{
  test_a_not_from(POINTER);
  test_a_not_from(PAIRPTR);
  test_a_not_from((mlval)to_space+POINTER);
  test_a_not_from((mlval)to_space+REFPTR);
  test_a_not_from((mlval)from_space-8+POINTER);
}

/* testing illegal values */

static void test_primary7(void)
{
  printf("cannot test primary 7 pointers.\n");
}

static void test_header50(void)
{
  printf ("cannot test header 50 records.\n");
}

/* preparing the various memory structures we need. */

static void prepare_arena(void)
{
  struct ml_heap *from;
  sm_init();
  from = make_ml_heap(TEST_WORDS*sizeof(mlval),0);
  space_type[from->space] = TYPE_FROM;
  from_space = from->start;
  resize_ml_heap(from,TEST_WORDS*sizeof(mlval));
  to_space = (mlval*)malloc(TEST_WORDS * sizeof(mlval));
  build_space = (mlval*)malloc(TEST_WORDS * sizeof(mlval));
  copy_of_build_space = (mlval*)malloc(TEST_WORDS * sizeof(mlval));
}

/* testing all objects tagged as pointers */

static void test_pointer(void)
{
  test_record();
  test_string();
  test_backptr();
  test_code();
  test_shared_closure();
  test_array();
  test_bytearray();
  test_header50();
}

/* our 'main' function */

extern int main(int argc, const char * const *argv)
{
  if (argc > 1)
    debugging = 1;
  prepare_arena();

  test_non_ptr();
  test_static();
  test_not_from();
  test_evac();
  test_pair();
  test_pointer();
  test_primary7();
  return 0;
}

/* declarations for the other values found in main.c, which this file
   replaces in the test system. */

mlval image_continuation = 0;
int module_argc = 0;		/* arguments to be passed to ML */
const char *const *module_argv = NULL;
const char *runtime = NULL;
int mono = 0;		/* running on a mono screen? */

