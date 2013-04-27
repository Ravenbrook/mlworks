/*  ==== FOREIGN OBJECT LOADER ====
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
 *  Provides core C/ML interface to foreign loader - based upon
 *  OS-provided run-time dynamic linking libraries (libdl).
 *
 *  Revision Log
 *  ------------
 *  $Log: foreign_loader.h,v $
 *  Revision 1.3  1995/03/23 16:45:41  brianm
 *  Restricting exported functions and added ifndef locks to prevent multiple loading.
 *
 * Revision 1.2  1995/03/01  15:51:43  brianm
 * Minor corrections.
 *
 * Revision 1.1  1995/03/01  09:51:14  brianm
 * new unit
 * Header for foreign object loading
 * */

#ifndef foreign_loader_h
#define foreign_loader_h

#include "fi_call_stub.h"

/* ==== Error hook for foreign interface call ====
 *
 *  Function called when num. args to foreign function is too large.
 *  (i.e. exceeds MAX_FI_ARG_LIMIT, defined in fi_call_stub.h).
 *
 */
extern mlval call_ffun_error(int);

/* ==== Foreign loader init function ====
 *
 *  Code to export foreign loading interface functions into the ML
 *  environment.
 *
 */
extern void  foreign_init(void);

#endif
