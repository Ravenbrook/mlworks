/* rts/src/arch/I386/make_asm_offsets.c
 *
 * A program to generate automatically the values contained in asm_offsets.h
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
 * $Log: make_asm_offsets.c,v $
 * Revision 1.5  1998/06/11 11:36:41  jont
 * [Bug #30108]
 * Implement DLL based ML code
 *
 * Revision 1.4  1995/11/13  13:47:15  nickb
 * Add native thread fields.
 *
 * Revision 1.3  1995/09/06  13:09:20  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/07/17  12:29:57  nickb
 * Add space profiling slot.
 *
 * Revision 1.1  1995/06/06  16:56:59  jont
 * new unit
 * No reason given
 *
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "threads.h"
#include "values.h"

#include "make_asm_offsets_common.c"

int main(int argc, char*argv[])
{
  if (argc != 1) {
    fprintf(stderr, "make_asm_offsets: Illegal arguments passed '%s'\n", argv[1]);
    exit(1);
  } else {
    printf("/* This file is generated automatically by make_asm_offsets */\n");
    printf("/* DO NOT ALTER */\n");
#ifdef NATIVE_THREADS
    output_thread("c_native", thread_offsetof(c_state.native));
#else
    output_thread("c_stack", thread_offsetof(c_state.stack));
    output_thread("c_esp", thread_offsetof(c_state.esp));
    output_thread("c_ebp", thread_offsetof(c_state.ebp));
    output_thread("c_esi", thread_offsetof(c_state.esi));
    output_thread("c_edi", thread_offsetof(c_state.edi));
    output_thread("c_ebx", thread_offsetof(c_state.ebx));
#endif
    output_thread("c_sp", thread_offsetof(c_state.sp));
    output_thread("c_eip", thread_offsetof(c_state.eip));
    output_thread("ml_profile", thread_offsetof(ml_state.space_profile));
    output_common();
    output("STUB_ANCILL_","0",CCODE_MAKE_ANCILL(0,0,0,CCODE_NO_INTERCEPT,0,0));
    output("STUB_ANCILL_","1",CCODE_MAKE_ANCILL(0,0,0,CCODE_NO_INTERCEPT,0,1));
  }
  return 0;
}
