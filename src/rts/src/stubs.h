/* stubs.h
 *
 * A file to generate the assembler and c stubs because the MIPS
 * assembler is defective and can't do it itself
 *
 * $Log: stubs.h,v $
 * Revision 1.2  1998/05/20 13:59:48  jont
 * [Bug #70035]
 * Add stub_code_start and stub_code_end variables
 * for use in address validation
 *
 * Revision 1.1  1994/07/12  12:51:05  jont
 * new file
 *
 * Copyright (C) 1994 Harlequin
 *
 */

extern void stubs_init(void);

extern void *stubs_code_start;

extern void *stubs_code_end;

extern void *stubs_data_start;

extern void *stubs_data_end;
