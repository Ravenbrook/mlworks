/* rts/src/arch/SPARC/make_asm_offsets.c
 *
 * A program to generate automatically the values contained in asm_offsets.h
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: make_asm_offsets.c,v $
 * Revision 1.3  1995/09/06 15:02:49  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/07/17  09:46:03  nickb
 * Add space profiling slot.
 *
 * Revision 1.1  1995/06/06  16:58:10  jont
 * new unit
 * No reason given
 *
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "threads.h"

#include "make_asm_offsets_common.c"

int main(int argc, char*argv[])
{
  if (argc != 1) {
    fprintf(stderr, "make_asm_offsets: Illegal arguments passed '%s'\n", argv[1]);
    exit(1);
  } else {
    printf("/* This file is generated automatically by make_asm_offsets */\n");
    printf("/* DO NOT ALTER */\n");
    output_thread("c_pc", thread_offsetof(c_state.pc));
    output_thread("c_sp", thread_offsetof(c_state.sp));
    output_thread("c_tsp", thread_offsetof(c_state.thread_sp));
    output_thread("c_stack", thread_offsetof(c_state.stack));
    output_thread("c_callee_saves", thread_offsetof(c_state.callee_saves));
    output_thread("c_float_saves", thread_offsetof(c_state.float_saves));
    output_thread("ml_profile", thread_offsetof(ml_state.space_profile));
    output_common();
  }
  return 0;
}
