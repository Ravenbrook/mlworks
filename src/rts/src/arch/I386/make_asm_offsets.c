/* rts/src/arch/I386/make_asm_offsets.c
 *
 * A program to generate automatically the values contained in asm_offsets.h
 *
 * Copyright (C) 1995 Harlequin Ltd.
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
