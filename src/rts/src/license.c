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

#include "license.h"
#include "values.h"
#include "allocator.h"
#include "environment.h"

/* These messages are for the case where we find a corrupt license at 
the start of a session */

static char c_license_error_invalid[] = LICENSE_ERROR_INVALID;
static char c_license_error_expired[] = LICENSE_ERROR_EXPIRED;
static char c_license_error_installdate[] = LICENSE_ERROR_INSTALL;
static char c_license_error_version[] = LICENSE_ERROR_VERSION;
static char c_license_error_chars[] = LICENSE_ERROR_CHARS;

/* default to minimum edition allowing delivery (for use in executables) */
/* this is a global whose value is returned by "license get edition" */

enum edition license_edition = PROFESSIONAL;

static mlval license_error_invalid(mlval arg)
{
  return ml_string(c_license_error_invalid);
}

static mlval license_error_expired(mlval arg)
{
  return ml_string(c_license_error_expired);
}

static mlval license_error_installdate(mlval arg)
{
  return ml_string(c_license_error_installdate);
}

static mlval license_error_version(mlval arg)
{
  return ml_string(c_license_error_version);
}

static mlval license_error_chars(mlval arg)
{
  return ml_string(c_license_error_chars);
}

static mlval license_get_edition(mlval arg)
{
  return MLINT(PROFESSIONAL);
}

static mlval license_set_edition(mlval arg)
{
  return 0;
}

static mlval license_check(mlval arg)
{
  return MLINT(OK);
}

void license_init(void)
{
  env_function("license check", license_check);
  env_function("license get edition", license_get_edition);
  env_function("license set edition", license_set_edition);
  env_function("license error expired", license_error_expired);
  env_function("license error invalid", license_error_invalid);
  env_function("license error install date", license_error_installdate);
  env_function("license error wrong version", license_error_version);
  env_function("license error illegal chars", license_error_chars);
}
