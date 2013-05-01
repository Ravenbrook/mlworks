/*  ==== LICENSE STUBS ====
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
 *  Provide stub functions so that we can load and run ML object files 
 *  or images created and/or compiled before MLWorks was open-sourced.
 */

#ifndef license_h
#define license_h

/* Create and declare licensing stubs. */

extern void license_init(void);

/* this type must correspond to that in main/__version.sml */

/* we always use PROFESSIONAL. */
enum edition {ENTERPRISE, PERSONAL, PROFESSIONAL};

/* this type must correspond to that in main/_license.sml */
/* alphabetical order of identifiers must be preserved when
adding new values */

/* we always use OK. */

enum license_check_result {EXPIRED,
                           ILLEGAL_CHARS,
                           INSTALLDATE,
                           INTERNAL_ERROR,
                           INVALID,
                           NOT_FOUND,
                           OK,
                           WRONG_EDITION};

extern enum edition license_edition;

#define LICENSE_ERROR_CONTACT "MLWorks licensing error! " \
        "This is some sort of legacy from the closed-source past. " \
        "It should be impossible."

/* We shouldn't ever see any of these error messages. */

#define LICENSE_ERROR_INVALID \
  "Invalid license.\n"

#define LICENSE_ERROR_EXPIRED \
  "Expired license.\n"

#define LICENSE_ERROR_INSTALL \
  "License installation date passed.\n"

#define LICENSE_ERROR_VERSION \
  "License for wrong edition.\n"

#define LICENSE_ERROR_CHARS \
   "License code contains invalid characters.\n"

#endif
