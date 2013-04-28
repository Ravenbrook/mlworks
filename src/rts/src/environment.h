/*  ==== RUNTIME ENVIRONMENT ====
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
 *  Description
 *  -----------
 *  The runtime system communicates ML values to ML via a `runtime
 *  envinroment' which is a mapping from strings to ML values.
 *
 *  Revision Log
 *  ------------
 *  $Log: environment.h,v $
 *  Revision 1.3  1997/04/30 14:44:21  stephenb
 *  [Bug #30030]
 *  env_function -> mlw_bind_function since this function needs
 *  to be visible to external users and hence cannot pollute the
 *  name space.
 *
 * Revision 1.2  1994/06/09  14:35:03  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:00:41  nickh
 * new file
 *
 *  Revision 1.3  1993/04/28  14:37:58  jont
 *  Changed env_function and env_asm_function to return the closure produced
 *
 *  Revision 1.2  1992/10/26  13:51:32  richard
 *  env_lookup() now returns an error code rather than raising
 *  and exception directly.  It is no longer called directly
 *  from ML.  See pervasives.c.
 *
 *  Revision 1.1  1992/07/27  16:18:31  richard
 *  Initial revision
 *
 */

#ifndef environment_h
#define environment_h

#include "mltypes.h"
#include "mlw_ci_os.h"		/* mlw_ci_export */


/*  === INITIALISE ===
 *
 *  Sets up an empty runtime environment and declares various roots.
 */

extern void env_init(void);



/*  === ADD VALUES TO ENVIRONMENT ===
 *
 *  These functions bind strings to values in the runtime environment.
 */

/*  == Bind value ==
 *
 *  Binds a simple value to a string
 */

extern void env_value(const char *name, mlval value);


/*  == Bind C function ==
 *
 *  Packages up the C function to make it callable from ML as an ML function
 *  and binds it to a name.
 */

mlw_ci_export mlval mlw_bind_function(const char *name, mlval (*f)(mlval));

/*
** This is here to avoid having to go round all the code
** that used to call env_function and change it to mlw_bind_function.
*/
#define env_function mlw_bind_function



/*  == Bind assembler function ==
 *
 *  Packages up a GC-clean assembler subroutine to make it callable from ML
 *  as an ML function and binds it to a name.
 */

extern mlval env_asm_function(const char *name, mlval (*f)(mlval));


/*  === LOOK UP VALUE IN ENVIRONMENT ===
 *
 *  This function is looks up the ML value (or function closure) associated
 *  with a string in the runtime environemnt.  It returns ERROR if the
 *  string is unbound.
 */

extern mlval env_lookup(const char *name);


#endif
