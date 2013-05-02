/*  ==== MODULE TABLE ====
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
 *  These functions provide a lookup table from module names to modules.
 *
 *  Revision Log
 *  ------------
 *  $Log: modules.h,v $
 *  Revision 1.2  1994/06/09 14:43:38  nickh
 *  new file
 *
 * Revision 1.1  1994/06/09  11:12:07  nickh
 * new file
 *
 *  Revision 1.7  1993/11/22  16:50:32  jont
 *  Added extra function to lookup module timestamp
 *  Changed mt_add to accept extra parameter for module timestamp
 *
 *  Revision 1.6  1993/08/12  13:43:42  daveb
 *  mt_lookup looks along the module path.
 *
 *  Revision 1.5  1992/08/26  15:50:47  richard
 *  The module table is now a pervasive value.
 *
 *  Revision 1.4  1992/07/01  14:40:24  richard
 *  Changed modules to be an entirely ML type to make them storage
 *  manager independent.
 *
 *  Revision 1.3  1992/03/17  13:29:20  richard
 *  Rewrote and generalised.
 *
 *  Revision 1.2  1992/03/11  11:30:27  richard
 *  Improved documentation slightly.
 *
 *  Revision 1.1  1991/10/17  15:15:11  davidt
 *  Initial revision
 */

#ifndef modules_h
#define modules_h


#include "mltypes.h"
#include "values.h"


extern mlval mt_empty(void);
extern mlval mt_add(mlval table, mlval name, mlval structure, mlval time);
extern mlval mt_lookup(mlval table, mlval name, mlval parent);
extern mlval mt_lookup_time(mlval table, mlval name, mlval parent);


#endif
