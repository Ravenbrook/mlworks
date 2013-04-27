/* src/make_asm_offsets_common.c
 *
 * File to produce the shared stuff when making asm_offsets.h files
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
