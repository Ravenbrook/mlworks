/*  ==== PERVASIVE TRACE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: trace.c,v $
 *  Revision 1.11  1998/02/23 18:42:20  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.10  1998/01/29  16:24:27  jont
 * [Bug #70054]
 * Add missing declare and retract root calls
 * Also added missing declare_root call for trace_ml_apply_all_function
 *
 * Revision 1.9  1996/06/19  13:40:39  nickb
 * Make trace status return a new code for "not traceable".
 *
 * Revision 1.8  1996/02/16  12:50:24  nickb
 * Change to declare_global().
 *
 * Revision 1.7  1995/03/15  12:34:43  nickb
 * Manipulation of new implicit vector entries changes for threads.
 *
 * Revision 1.6  1995/02/20  15:04:42  matthew
 * Adding interface to implicit vector debugger functions
 *
 * Revision 1.5  1994/10/19  14:31:05  nickb
 * Use the invalid value from code_status enum.
 *
 * Revision 1.4  1994/06/23  09:35:51  nickh
 * Add untrace_all.
 *
 * Revision 1.3  1994/06/21  16:02:17  nickh
 * New ancillary structure and forced GC on image save.
 *
 * Revision 1.2  1994/06/09  14:53:56  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:30:01  nickh
 * new file
 *
 * Revision 1.5  1993/04/15  13:12:33  richard
 * Ripped out old tracing mechanism and installed a new one.
 *
 * Revision 1.4  1993/02/01  16:04:33  richard
 * Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 * Revision 1.3  1992/11/19  15:12:56  clive
 * Removed the maintaince of a list of traced functions
 *
 * Revision 1.2  1992/11/16  14:11:04  clive
 * Need to make the address of call_traced_code available to stacks.c
 *
 * Revision 1.1  1992/11/13  16:43:53  clive
 * Initial revision
 *
 *
 */

#include <errno.h>

#include "environment.h"
#include "values.h"
#include "allocator.h"
#include "implicit.h"
#include "tags.h"
#include "interface.h"
#include "intercept.h"
#include "exceptions.h"
#include "utils.h"
#include "trace.h"
#include "loader.h"
#include "global.h"
#include "gc.h"

static void internal_trace_intercept(mlval code,mlval f)
{
  if(code_intercept(code)) {
    switch(errno) {
    case EINTERCEPTFORM:
      exn_raise_string(perv_exn_ref_trace, "Function was not compiled with tracing enabled");
      
    default:
      error("internal_trace_intercept: Unexpected error %d from code_intercept()", errno);
    }
  } else
    CCODE_SET_INTERFN(code,f);
}

static mlval trace_intercept(mlval arg)
{
  mlval code = FIELD(FIELD(arg, 0), 0);
  mlval f = FIELD (arg,1);
  internal_trace_intercept (code,f);
  return (MLUNIT);
}

static mlval trace_code_intercept(mlval arg)
{
  mlval code = FIELD(arg, 0);
  mlval f = FIELD (arg,1);
  internal_trace_intercept (code,f);
  return (MLUNIT);
}

static void internal_trace_replace(mlval code,mlval f)
{
  if(code_replace(code)) {
    switch(errno) {
    case EINTERCEPTFORM:
      exn_raise_string(perv_exn_ref_trace, "Function was not compiled with tracing enabled");
      
    default:
      error("trace_replace: Unexpected error %d from code_replace()", errno);

    }
  } else
    CCODE_SET_INTERFN(code, f);
}


static mlval trace_replace(mlval arg)
{
  mlval code = FIELD(FIELD(arg, 0), 0);
  mlval f = FIELD (arg,1);
  internal_trace_replace (code,f);
  return (MLUNIT);
}

static mlval trace_code_replace(mlval arg)
{
  mlval code = FIELD(arg, 0);
  mlval f = FIELD (arg,1);
  internal_trace_replace (code,f);
  return (MLUNIT);
}

static mlval trace_restore(mlval arg)
{
  mlval code = FIELD(arg, 0);

  if(code_nop(code)) {
    switch(errno) {
    case EINTERCEPTFORM:
      exn_raise_string(perv_exn_ref_trace, "Function was not compiled with tracing enabled");
      
    default:
      error("trace_restore: Unexpected error %d from code_nop()", errno);
    }
  } else 
    CCODE_SET_INTERFN(code, MLUNIT);

  return(MLUNIT);
}
/*
                datatype status = INTERCEPT | NONE | REPLACE | UNTRACEABLE
*/
static mlval trace_status(mlval arg)
{
  switch(code_status(FIELD(arg, 0)))
  {
    /* See datatype MLWorks.Internal.Trace.status */
    /*      = INTERCEPT | NONE | REPLACE | UNTRACEABLE */
    case CS_INTERCEPT:	return(MLINT(0));
    case CS_NOP:	return(MLINT(1));
    case CS_REPLACE:	return(MLINT(2));
    case CS_INVALID:
      switch(errno) {
      case EINTERCEPTFORM:
	return (MLINT(3));

      default:
      error("trace_status: Unexpected error %d from code_status()", errno);
    }

    default:
    error("trace_status: Unexpected return value from code_status()");
  }
}

static mlval trace_restore_code(unsigned int index, mlval code)
{
  if (CCODE_CAN_INTERCEPT(code) && code_nop(code))
    error("trace_restore_code: Unexpected error %d from code_nop()", errno);

  return code;
}

static mlval trace_restore_all(mlval unit)
{
  weak_apply(loader_code,trace_restore_code);
  return MLUNIT;
}

static mlval trace_ml_apply_all_function = MLUNIT;

/* This only called on functions compiled for tracing */
static mlval trace_ml_apply (unsigned int index, mlval code)
{
  if (trace_ml_apply_all_function == MLUNIT)
    error("trace_ml_apply: function not set");
  else
    if (CCODE_CAN_INTERCEPT(code)) {
      declare_root(&code, 0);
      callml (code,trace_ml_apply_all_function);
      retract_root(&code);
    }
  return (code);
}

static mlval trace_ml_apply_all (mlval f)
{
  trace_ml_apply_all_function = f;
  weak_apply (loader_code,trace_ml_apply);
  trace_ml_apply_all_function = MLUNIT;
  return (MLUNIT);
}

static mlval trace_loader_ml_function = MLUNIT;

static void trace_loader_function (mlval code)
{
  if (trace_loader_ml_function != MLUNIT)
    if (CCODE_CAN_INTERCEPT(code))
      callml (code,trace_loader_ml_function);
}

static mlval trace_set_code_loader_function (mlval arg)
{
  trace_loader_ml_function = arg;
  loader_code_trace_observer = trace_loader_function;
  return (MLUNIT);
}

static mlval trace_unset_code_loader_function (mlval unit)
{
  trace_loader_ml_function = MLUNIT;
  loader_code_trace_observer = NULL;
  return (MLUNIT);
}
  
void trace_init()
{
  declare_global("trace loader ml function", &trace_loader_ml_function,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  env_function("trace ml apply all", trace_ml_apply_all);
  env_function("trace set code loader function", trace_set_code_loader_function);
  env_function("trace unset code loader function", trace_unset_code_loader_function);
  env_function("trace intercept", trace_intercept);
  env_function("trace replace", trace_replace);
  env_function("trace code intercept", trace_code_intercept);
  env_function("trace code replace", trace_code_replace);
  env_function("trace restore", trace_restore);
  env_function("trace status", trace_status);
  env_function("trace restore all", trace_restore_all);
  declare_root(&trace_ml_apply_all_function, 1);
}
