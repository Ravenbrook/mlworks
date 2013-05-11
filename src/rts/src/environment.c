/*  ==== RUNTIME ENVIRONMENT MANAGEMENT ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Implementation
 *  --------------
 *  The runtime environment is an ML list of triples.  Entries are of the
 *  form (name, type, value) where name is the bound ML string, type is one
 *  of VALUE or STUB, and value is the ML value bound.  Values of type STUB
 *  are the closures of special ML functions which interface ML to C.
 *
 *  When a C function is added to the environment a static code vector from
 *  interface.h is closed over with the address of the C function to call,
 *  as well as the addresses of the C and ML state vectors, and the
 *  environment name of the C function.  When a the global state is unpacked
 *  after an image is loaded the environment is scanned and all such stubs
 *  have their closures fixed in case these C addresses have changed.  There
 *  is a similar mechanism for assembly language code vectors.
 *
 *  Revision Log
 *  ------------
 *  $Log: environment.c,v $
 *  Revision 1.12  1998/10/05 11:50:43  jont
 *  [Bug #70185]
 *  Avoid calling weak_add on loader_code if loader_code is DEAD
 *
 * Revision 1.11  1998/03/19  11:49:02  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.10  1998/02/23  17:59:57  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.9  1997/04/30  14:44:31  stephenb
 * [Bug #30030]
 * env_function -> mlw_bind_function since this function needs
 * to be visible to external users and hence cannot pollute the
 * name space.
 *
 * Revision 1.8  1996/09/10  11:31:38  nickb
 * Add missing retract_root().
 *
 * Revision 1.7  1996/05/15  14:58:12  nickb
 * Report multiple missing bindings before causing an error.
 *
 * Revision 1.6  1996/02/19  16:59:12  nickb
 * Clear environment on delivery.
 *
 * Revision 1.5  1996/02/16  14:37:57  nickb
 * Change to declare_global().
 *
 * Revision 1.4  1996/02/14  14:54:39  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.3  1994/12/12  15:15:48  jont
 * Convert function pointers to MLINTs under NT
 *
 * Revision 1.2  1994/06/09  14:34:46  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:00:15  nickh
 * new file
 *
 *  Revision 1.11  1993/04/28  14:48:56  jont
 *  Changed env_function and env_asm_function to return the closure produced
 *
 *  Revision 1.10  1993/02/01  14:36:35  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.9  1992/10/26  13:51:30  richard
 *  env_lookup() now returns an error code rather than raising
 *  and exception directly.  It is no longer called directly
 *  from ML.  See pervasives.c.
 *
 *  Revision 1.8  1992/08/26  15:44:50  richard
 *  Failure to find a binding in the runtime environment now
 *  raises an exception instead of bombing.
 *
 *  Revision 1.7  1992/08/04  16:14:51  richard
 *  Made sure that the stub code addresses are fixed as well as the actual
 *  functions.
 *
 *  Revision 1.6  1992/07/31  08:10:53  richard
 *  The C and assembler calling stubs are now single static routines.
 *  (Too many problems were caused by replicating them.)
 *
 *  Revision 1.5  1992/07/30  17:07:01  richard
 *  Commented out profile_new() until I can fix it.
 *
 *  Revision 1.4  1992/07/30  11:51:47  richard
 *  Stub code vectors are now static strings.
 *
 *  Revision 1.3  1992/07/29  14:26:12  richard
 *  New code vectors are declared to the profiler rather than the loader.
 *
 *  Revision 1.2  1992/07/29  12:16:06  richard
 *  Changed the environment from a list of weak arrays to a simple
 *  list of triples.  It shouldn't have been weak anyway!
 *
 *  Revision 1.1  1992/07/27  16:18:28  richard
 *  Initial revision
 *
 */

#include "environment.h"
#include "global.h"
#include "mltypes.h"
#include "values.h"
#include "allocator.h"
#include "diagnostic.h"
#include "interface.h"
#include "profiler.h"
#include "pervasives.h"
#include "utils.h"
#include "gc.h"
#include "loader.h"

#include <string.h>
#include <stdlib.h>
#include <assert.h>


/*  === THE ENVIRONMENT ===  */

#define VALUE		MLINT(0)
#define C_STUB		MLINT(1)
#define ASM_STUB	MLINT(2)
static mlval environment;


/*  === THE FUNCTION TABLE ===
 *
 *  The function table is a mapping from strings to C or assembler functions
 *  and to ML stub code vectors to those functions, allocated statically.
 *  It is used to fix the pointers in the closures of any stubs loaded with
 *  a heap image in case the functions or stub code vectors have moved.
 *
 *  NOTE: The address of the C function could be hard-wired into each stub,
 *  but it's fairly fiddly and difficult to do portably.
 */

static struct f_table_entry
{
  const char *name;
  mlval (*f)(mlval);
} *f_table = NULL;
size_t f_table_used = 0, f_table_size = 16;


/*  == Add a value to the environment ==
 *
 *  Binds value of type to name, adding extra weak arrays to the environment
 *  as necessary.
 */

static void env_insert(mlval name, mlval type, mlval value)
{
  mlval triple;
  declare_root(&name, 0);
  declare_root(&value, 0);
  triple = allocate_record(3);

  FIELD(triple, 0) = name;
  FIELD(triple, 1) = type;
  FIELD(triple, 2) = value;

  environment = cons(triple, environment);
  retract_root(&name);
  retract_root(&value);
}


/*  == Add a function to the function table ==
 *
 *  Adds a mapping from a name to a C function or assembler subroutine.
 */

static void f_table_insert(const char *name, mlval (*f)(mlval))
{
  if(f_table == NULL || f_table_used >= f_table_size)
  {
    f_table_size *= 2;
    f_table = (struct f_table_entry *)realloc(f_table, sizeof(struct f_table_entry) * f_table_size);
    if(f_table == NULL)
      error("Unable to expand environment function table");
  }

  f_table[f_table_used].name = name;
  f_table[f_table_used].f = f;
  ++f_table_used;
}


/*  === BIND A VALUE ===  */

void env_value(const char *name, mlval value)
{
  env_insert(ml_string(name), VALUE, value);
}

/*
 * Create a dummy code vector for a stub
 */

static mlval make_dummy_code(mlval name)
{
  mlval code, ancillary, names, profiles;
  declare_root(&name, 0);
  /* Build the name record */
  names = allocate_record(1);
  FIELD(names,0) = name;
  retract_root (&name);
  declare_root (&names, 0);
  /* Build the profiles record */
  profiles = allocate_record(1);
  FIELD(profiles,0) = (mlval)0;
  declare_root (&profiles, 0);
  /* Now make the anciallry record */
  ancillary = allocate_record (2);
  FIELD(ancillary,ANC_PROFILES) = profiles;
  FIELD(ancillary,ANC_NAMES) = names;
  retract_root (&names);
  retract_root (&profiles);
  declare_root (&ancillary, 0);
  /* Now make the dummy code vector */
  code = allocate_code(3);
  retract_root(&ancillary);
  CCVANCILLARY(code) = ancillary;
  FIELD(code, 1) = MAKEHEAD(BACKPTR, 2 * sizeof(mlval)); /* Back pointer */
  FIELD(code, 2) = make_ancill(0, 0, 0, -1, 0, 0);
  return (mlval)(((unsigned int)code)+8);
}

/*  == Create a new stub ==
 *
 *  Allocates and closes over a stub code vector with a C function and its
 *  name, and then binds it in the function table and environment.
 */

static mlval new_stub
  (const char *string, mlval (*f)(mlval), mlval type, mlval code)
{
  mlval closure, name, dummy_code;

#ifdef OS_NT
  assert(CINT(MLINT(f)) == (int)f);
  f = (mlval (*)(mlval))(MLINT(f)); /* NT compilers don't align functions properly */
#endif
  name = ml_string(string);
  declare_root(&name, 0);
  dummy_code = make_dummy_code(name);
  declare_root(&dummy_code, 0);
  if (loader_code && loader_code != DEAD) {
    loader_code = weak_add(loader_code, dummy_code); /* This may call gc, hence declare */
  } else {
    /*
     * loader_code can be DEAD during global root fixup in image load
    */
  } /* Don't worry about stuff done so early */
  closure = allocate_record(5);
  FIELD(closure, 0) = code;
  FIELD(closure, 1) = (mlval)f;
  FIELD(closure, 2) = name;
  FIELD(closure, 3) = type;
  FIELD(closure, 4) = dummy_code;
  retract_root(&dummy_code);
  retract_root(&name);

  f_table_insert(string, f);
  declare_root(&closure, 0);
  env_insert(name, type, closure);
  retract_root(&closure);
  return closure;
}


/*  === BIND A C FUNCTION ===  */

mlw_ci_export mlval mlw_bind_function(const char *c_name, mlval (*f)(mlval))
{
  return new_stub(c_name, f, C_STUB, stub_c);
}


/*  === BIND AN ASSEMBLER SUBROUTINE ===  */

mlval env_asm_function(const char *c_name, mlval (*f)(mlval))
{
  return new_stub(c_name, f, ASM_STUB, stub_asm);
}

/*  === LOOK UP A VALUE === */

mlval env_lookup(const char *name)
{
  mlval list;

  for(list = environment; list != MLNIL; list = MLTAIL(list))
  {
    mlval triple = MLHEAD(list);

    if(strcmp(CSTRING(FIELD(triple, 0)), name) == 0)
      return(FIELD(triple, 2));
  }

  return(MLERROR);
}

/*  == Fix references to C or assembler on image load ==
 *
 *  An image from a slightly different runtime system may contain C or
 *  assembler stubs which have the wrong addresses in their closures.
 *  fix_closures is called when the global root `environment' is fixed
 *  after an image is loaded.  It scans the environment looking for
 *  bindings of type C_STUB or ASM_STUB and corrects their references
 *  using the function table.  */

static mlval rebuild_closure(unsigned int index, mlval closure)
{
  mlval name = FIELD(closure,2);
  DIAGNOSTIC(2, "  closure 0x%x name `%s'", closure, CSTRING(name));
  env_insert(name, FIELD(closure,3), closure);
  return DEAD;
}

static void fix_closures(const char *name, mlval *root, mlval value)
{
  mlval list;
  int failed = 0;

  DIAGNOSTIC(2, "fix_closures(root = 0x%X, value = 0x%X)", root, value);

  if (PRIMARY(value) == REFPTR) {
    /* if the loaded image was delivered, the environment is a weak
     * list, from which we have to reconstruct the original list */
    environment = MLNIL;
    weak_apply(value, rebuild_closure);
  } else
    *root = value;
  
  for(list = environment; list != MLNIL; list = MLTAIL(list)) {
    mlval triple = MLHEAD(list);
    mlval type = FIELD(triple, 1);
    
    if(type == C_STUB || type == ASM_STUB) {
      mlval closure = FIELD(triple, 2);
      char *name = CSTRING(FIELD(closure, 2));
      size_t i;
      
      DIAGNOSTIC(2, "  closure 0x%X  name `%s'", closure, name);
      
      for(i=0; i<f_table_used; ++i)
	if(strcmp(f_table[i].name, name) == 0) {
	  DIAGNOSTIC(2, "    f 0x%X -> 0x%X", FIELD(closure,1),f_table[i].f);
	  FIELD(closure, 1) = (mlval)f_table[i].f;
	  FIELD(closure, 0) = (mlval)(type == C_STUB ? stub_c : stub_asm);
	  goto next;
	}
      
      message("The runtime environment binding `%s' is a stub at 0x%X "
	      "which references an unregistered function named `%s'",
	      CSTRING(FIELD(triple, 0)), closure, name);
      failed = 1;
      
    next:
      /* empty statement */ ;
    }
  }
  if (failed)
    error ("The loaded image has an incompatible runtime environment.");
}

static mlval save_closures(const char *name, mlval *root, int deliver)
{
  if (deliver) {
    /* make weak array of environment function closures */
    mlval list = environment;
    declare_root(&list, 0);
    environment = weak_new(16);
    while(list != MLNIL) {
      mlval triple = MLHEAD(list);
      mlval type = FIELD(triple,1);
      if (type == ASM_STUB || type == C_STUB)
	environment = weak_add(environment,FIELD(triple,2));
      list = MLTAIL(list);
    }
    retract_root(&list);
    return environment;
  } else
    return *root;
}


/*  === INITIALISE THE ENVIRONMENT ===
 *
 *  Declares the environment as a global root which calls fix_closures and
 *  initialises an empty function table.
 */

void env_init(void)
{
  environment = MLNIL;
  declare_global("environment", &environment, GLOBAL_DEFAULT+GLOBAL_WEAK_LIST,
		 save_closures, fix_closures, NULL);

  f_table = NULL;
  f_table_used = 0;
  f_table_size = 64;
}
