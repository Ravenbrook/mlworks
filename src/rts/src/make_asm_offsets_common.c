/* src/make_asm_offsets_common.c
 *
 * File to produce the shared stuff when making asm_offsets.h files
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: make_asm_offsets_common.c,v $
 * Revision 1.1  1995/06/06 16:55:29  jont
 * new unit
 * No reason given
 *
 *
 */

#define thread_offsetof(x) (offsetof(struct thread_state, x))
#define global_offsetof(x) (offsetof(struct global_state, x))

static void output(const char *type, const char *name, int value)
{
  printf("#define %s%s %d\n", type, name, value);
}

static void output_thread(const char *name, int value)
{
  output("THREAD_", name, value);
}

static void output_global(const char *name, int value)
{
  output("GLOBAL_", name, value);
}

static void output_common(void)
{
  output_thread("ml_global", thread_offsetof(ml_state.global));
  output_thread("ml_sp", thread_offsetof(ml_state.sp));
  output_thread("ml_stack_top", thread_offsetof(ml_state.stack_top));
  output_thread("global", thread_offsetof(global));
  output_global("in_ML", global_offsetof(in_ML));
  output_global("current_thread", global_offsetof(current_thread));
  output_global("toplevel", global_offsetof(toplevel));
}
