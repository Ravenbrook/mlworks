/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * Any Linux specific code which needs to override the default code
 * in  ../OS/common/unix.c should go here.
 *
 * $Log: unixlocal.c,v $
 * Revision 1.3  1997/05/22 08:46:18  johnh
 * [Bug #01702]
 * Changed definition of exn_raise_syserr.
 *
 * Revision 1.2  1996/04/02  12:31:18  stephenb
 * Replace the unix exception by Os.SysErr.
 *
 * Revision 1.1  1996/01/30  14:39:34  stephenb
 * new unit
 * There is now only one unix.c and this supports an idealised Unix.
 * This file contains any support functions needed under Linux
 * to support this idealised version.
 *
 */

#include "exceptions.h"		/* exn_raise_syserr */
#include "values.h"		/* MLINT */
#include "allocator.h"          /* ml_string */
#include "unixlocal.h"


extern mlval unix_set_block_mode(mlval arg)
{
  exn_raise_syserr(ml_string("Linux does not support set_block_mode"), MLINT(0));
}


extern mlval unix_can_input(mlval arg)
{
  exn_raise_syserr(ml_string("Linux does not support set_block_mode"), MLINT(0));
}
