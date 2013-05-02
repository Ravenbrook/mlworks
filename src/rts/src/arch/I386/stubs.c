/* stubs.c
 *
 * A file to generate the assembler and c stubs because the Intel
 * assembler is defective and can't do it itself
 *
 * $Log: stubs.c,v $
 * Revision 1.8  1998/05/20 15:02:01  jont
 * [Bug #70035]
 * Add stubs_code_start, stubs_code_end, stubs_data_start, stubs_data_end
 *
 * Revision 1.7  1997/05/30  12:07:18  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.6  1995/02/28  16:39:46  jont
 * Make calls to *_die return code 1.
 *
 * Revision 1.5  1995/01/17  17:05:46  jont
 * Fix problems with ancillary words in stub_c and stub_asm
 *
 * Revision 1.4  1994/11/25  11:25:35  nickb
 * Replace ml_gc_leaf_die (removed in error).
 *
 * Revision 1.3  1994/11/23  17:01:28  nickb
 * Remove set_stack_underflow_die.
 *
 * Revision 1.2  1994/10/06  15:49:28  jont
 * Make it Intel architecture specific
 *
 *
 * Copyright (C) 1994 Harlequin
 *
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "tags.h"
#include "mltypes.h"
#include "stubs.h"
#include "print.h"
#include "mach_values.h"
#include "values.h"

void *stubs_code_start;
void *stubs_code_end;
void *stubs_data_start;
void *stubs_data_end;

extern char text_internal_stub_c;		/* Where the stub to C code is */
extern char text_internal_stub_c_end;		/* Where it ends */
extern char text_internal_stub_asm;		/* Where the stub to assembler is */
extern char text_internal_stub_asm_end;	/* Where the stub to assembler is */

mlval stub_c = (mlval)NULL;
mlval stub_asm = (mlval)NULL; /* The vectors */

/* A place holder to indicate the start of the data for stubs */
/* Must come before all the data */

static int bar;

static struct {
  char *first;
  char *second;
} stubancill, stubnames, stubprofiles;

static struct {
  unsigned int first;
  unsigned int second;
} dummy;

#define STUB_C_NAME "stub to C"

static struct {
  unsigned int len;
  char name[sizeof(STUB_C_NAME)];
} sc_name =
{
  0,
  "stub to C"
};

static struct {
  unsigned int len;
  char name[100];
} sa_name =
{
  0,
  "stub to assembler"
};

/* A place holder to indicate the end of the data for stubs */
/* Must come after all the data */

static int foo;

static unsigned int align_to_double_word(unsigned int value)
{
  return ((value + 7) & ~7u);
}

void stubs_init(void)
{
  unsigned int stub_c_len =
    align_to_double_word((unsigned)(&text_internal_stub_c_end - &text_internal_stub_c));
  unsigned int stub_asm_len =
    align_to_double_word((unsigned)(&text_internal_stub_asm_end - &text_internal_stub_asm));
  unsigned long stubs_len = stub_c_len + stub_asm_len + 8 + 8 + 8 + 4;
  char *stub_vector = malloc(stubs_len);
  stub_vector = (char *) align_to_double_word((unsigned)stub_vector); /* Ensure alignment */
  /* Set up pointers */
  stub_c = (mlval)stub_vector + 8;
  stub_asm = (mlval)stub_vector + 8 + 8 + stub_c_len;
  /* Copy in code */
  memcpy((void *)((char *)stub_c + 8), &text_internal_stub_c, stub_c_len);
  memcpy((void *)((char *)stub_asm + 8), &text_internal_stub_asm, stub_asm_len);
  stubprofiles.first = NULL;
  stubprofiles.second = NULL;
  sc_name.len = ((strlen(sc_name.name) + 1) << 6) | STRING;
  sa_name.len = ((strlen(sa_name.name) + 1) << 6) | STRING;
  stubnames.first = ((char *)(&sc_name)) + POINTER;
  stubnames.second = ((char *)(&sa_name)) + POINTER;
  stubancill.first = ((char *)(&stubnames)) + PAIRPTR;
  stubancill.second = ((char *)(&stubprofiles)) + PAIRPTR;
  dummy.first = (8 << 6) | BACKPTR;
  dummy.second = CCODE_MAKE_ANCILL(2, 0, 0, CCODE_NO_INTERCEPT, 0, 0);
  /* Two callee saved registers stacked */
  /* No stacked parameters */
  memcpy((void *)stub_c, (void *)&dummy, 8);
  dummy.first = ((stub_c_len + 8 + 8) << 6) | BACKPTR;
  dummy.second = CCODE_MAKE_ANCILL(0, 0, 0, CCODE_NO_INTERCEPT, 0, 1);
  /* No callee save registers */
  /* No stacked parameters */
  memcpy((void *)stub_asm, (void *)&dummy, 8);
  dummy.first = ((stub_c_len + stub_asm_len + 8 + 8 + 8 - 4) << 6) | CODE;
  dummy.second = (int)(&stubancill) + PAIRPTR;
  memcpy(stub_vector, (void *)&dummy, 8);
  stub_c += POINTER;
  stub_asm += POINTER;
  stubs_code_start = stub_vector;
  stubs_code_end = stub_vector + stubs_len;
  stubs_data_start = &bar;
  stubs_data_end = &foo;
}

/* Temporary code */

extern void ml_gc_leaf_die(void);

extern void ml_gc_leaf_die(void)
{
  fprintf(stderr, "ml_gc_leaf_die called\n");
  exit(1);
}
extern void ml_disturbance_die(void);

extern void ml_disturbance_die(void)
{
  fprintf(stderr, "ml_disturbance_die called\n");
  exit(1);
}

extern void ml_event_check_die(void);

extern void ml_event_check_die(void)
{
  fprintf(stderr, "ml_event_check_die called\n");
  exit(1);
}

extern void ml_event_check_leaf_die(void);

extern void ml_event_check_leaf_die(void)
{
  fprintf(stderr, "ml_event_check_leaf_die called\n");
  exit(1);
}

extern void c_raise_die(mlval);

extern void c_raise_die(mlval v)
{
  fprintf(stderr, "c_raise_die called\n");
  print(&print_defaults, stderr, v);
  exit(1);
}

extern void ml_raise_die(void);

extern void ml_raise_die(void)
{
  fprintf(stderr, "ml_raise_die called\n");
  exit(1);
}

extern void ml_raise_leaf_die(void);

extern void ml_raise_leaf_die(void)
{
  fprintf(stderr, "ml_raise_leaf_die called\n");
  exit(1);
}

extern void ml_replace_die(void);

extern void ml_replace_die(void)
{
  fprintf(stderr, "ml_replace_die called\n");
  exit(1);
}

extern void ml_replace_leaf_die(void);

extern void ml_replace_leaf_die(void)
{
  fprintf(stderr, "ml_replace_leaf_die called\n");
  exit(1);
}

extern void ml_intercept_die(void);

extern void ml_intercept_die(void)
{
  fprintf(stderr, "ml_intercept_die called\n");
  exit(1);
}

extern void ml_intercept_leaf_die(void);

extern void ml_intercept_leaf_die(void)
{
  fprintf(stderr, "ml_intercept_leaf_die called\n");
  exit(1);
}

extern void ml_replace_on_die(void);

extern void ml_replace_on_die(void)
{
  fprintf(stderr, "ml_replace_on_die called\n");
  exit(1);
}

extern void ml_replace_on_leaf_die(void);

extern void ml_replace_on_leaf_die(void)
{
  fprintf(stderr, "ml_replace_on_leaf_die called\n");
  exit(1);
}

extern void ml_intercept_on_die(void);

extern void ml_intercept_on_die(void)
{
  fprintf(stderr, "ml_intercept_on_die called\n");
  exit(1);
}

extern void ml_intercept_on_leaf_die(void);

extern void ml_intercept_on_leaf_die(void)
{
  fprintf(stderr, "ml_intercept_on_leaf_die called\n");
  exit(1);
}

extern void ml_nop_die(void);

extern void ml_nop_die(void)
{
  fprintf(stderr, "ml_nop_die called\n");
  exit(1);
}
