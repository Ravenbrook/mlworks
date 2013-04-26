/* rts/src/arch/SPARC/make_asm_offsets.c
 *
 * A program to generate automatically the values contained in asm_offsets.h
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: make_asm_offsets.c,v $
 * Revision 1.5  1997/05/30 09:32:31  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.4  1996/10/31  17:19:32  nickb
 * Exchange ml_state.base and ml_state.sp, to be consistent with other platforms.
 *
 * Revision 1.3  1995/09/06  15:29:59  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/06/16  16:24:22  nickb
 * Add space profiling slot. Also tidy up to remove compilation warnings.
 *
 * Revision 1.1  1995/06/06  17:00:37  jont
 * new unit
 * No reason given
 *
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include "threads.h"
#include "ansi.h"
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
    output_thread("c_pc", thread_offsetof(c_state.pc));
    output_thread("c_sp", thread_offsetof(c_state.sp));
    output_thread("c_tsp", thread_offsetof(c_state.thread_sp));
    output_thread("c_stack", thread_offsetof(c_state.stack));
    output_thread("ml_gc_sp", thread_offsetof(ml_state.gc_sp));
    output_thread("ml_g7", thread_offsetof(ml_state.g7));
    output_thread("ml_profile", thread_offsetof(ml_state.space_profile));
    output_common();

    output("STUB_ANCILL_","0",CCODE_MAKE_ANCILL(0,0,0,CCODE_NO_INTERCEPT,0,0));
    output("STUB_ANCILL_","1",CCODE_MAKE_ANCILL(0,0,0,CCODE_NO_INTERCEPT,0,1));
  }
  return 0;
}
