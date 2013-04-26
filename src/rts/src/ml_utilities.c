/*  ==== MISCELLANEOUS ML UTILITY FUNCTIONS ====
 *
 *  Copyright (C) 1998 Harlequin Group plc
 *
 *  $Log: ml_utilities.c,v $
 *  Revision 1.1  1998/02/13 15:08:20  jont
 *  new unit
 *  Moved pc_in_closure to be available to all architectures
 *
 */

#include "mltypes.h"
#include "types.h"
#include "values.h"
#include "utils.h"
#include "ml_utilities.h"

extern int pc_in_closure(word pc, mlval clos)
{
  mlval code = FIELD(clos,0);
  word code_start = (word)CCODESTART(code);
  /* is it after the start of this function ? */
  if (pc >= code_start) {
    mlval codeobj = FOLLOWBACK(code);
    word code_end = ((word)OBJECT(codeobj)) + (LENGTH(OBJECT(codeobj)[0]) << 2);
    /* is it before the end of this code object ? */
    if (pc < code_end) { 
      int codenum = CCODENUMBER(code);
      int codes = NFIELDS(FIELD(CCVANCILLARY(codeobj), ANC_NAMES));
      if (codes != codenum+1) {
	if (FIELD(clos,1) == 0) {
	  /* so we are in a shared closure; not the case for stub_c */
	  mlval nextcode = FIELD(clos,2);
	  if (nextcode > code) {
	    code_end = (word)CCODESTART(nextcode);
	    /* is it after the end of this code item ? */
	    if (pc >= code_end)
	      return 0;
	  } else {
	    error("code vectors in wrong order");
	  }
	}
      }
      return 1;
    }
  }
  return 0;
}
