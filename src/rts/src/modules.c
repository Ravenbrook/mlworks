/*  ==== GLOBAL MODULE TABLE ====
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
 *  The module table is an association list of ML values.
 *
 *  Revision Log
 *  ------------
 *  $Log: modules.c,v $
 *  Revision 1.5  1998/08/21 16:34:08  jont
 *  [Bug #30108]
 *  Implement DLL based ML code
 *
 * Revision 1.4  1998/02/23  18:24:07  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.3  1996/02/14  15:06:11  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.2  1994/06/09  14:43:21  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:11:42  nickh
 * new file
 *
 *  Revision 1.19  1993/11/22  16:51:26  jont
 *  Added extra function to lookup module timestamp
 *  Changed mt_add to accept extra parameter for module timestamp
 *
 *  Revision 1.18  1993/08/26  19:08:14  daveb
 *  mt_lookup no longer destructively modifies its argument.
 *
 *  Revision 1.17  1993/08/23  16:26:09  richard
 *  Added a missing root declaration in mt_lookup().
 *
 *  Revision 1.16  1993/08/17  16:39:05  daveb
 *  mt_lookup looks along the module path.
 *
 *  Revision 1.15  1993/04/19  14:45:16  richard
 *  Removed call to rusty polymorphic equality.
 *
 *  Revision 1.14  1993/02/01  14:48:21  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.13  1992/09/23  08:19:55  clive
 *  Needed some roots in mt_add
 *
 *  Revision 1.12  1992/08/26  15:50:52  richard
 *  The module table is now a pervasive value.
 *
 *  Revision 1.11  1992/07/13  11:37:35  richard
 *  Implemented the module table as a proper ML list.
 *
 *  Revision 1.10  1992/07/08  17:17:43  clive
 *  MLNIL for test in lookup - not MLUNIT
 *
 *  Revision 1.9  1992/07/02  09:12:35  richard
 *  Returns MLERROR rather than IMPOSSIBLE in the error case.
 *
 *  Revision 1.8  1992/07/01  14:40:23  richard
 *  Changed modules to be an entirely ML type to make them storage
 *  manager independent.
 *
 *  Revision 1.7  1992/03/17  17:42:35  richard
 *  Rewrote and generalised.
 *
 *  Revision 1.6  1992/03/11  12:16:17  richard
 *  The module table is now a C entity containing many C roots rather than one
 *  ML object.  The ML approach failed because the ML object was _updated_
 *  causing havoc with the generation mechanism.
 */


#include <string.h>

#include "modules.h"
#include "diagnostic.h"
#include "mltypes.h"
#include "values.h"
#include "allocator.h"
#include "gc.h"
#include "pervasives.h"

mlval mt_empty(void)
{
  return(MLNIL);
}

mlval mt_add(mlval table, mlval name, mlval structure, mlval time)
{
  mlval triple = MLUNIT, new_table = MLUNIT;

  declare_root(&table, 0);
  declare_root(&name, 0);
  declare_root(&structure, 0);
  declare_root(&time, 0);

  triple = allocate_record(3);
  FIELD(triple, 0) = name;
  FIELD(triple, 1) = structure;
  FIELD(triple, 2) = time;
  retract_root(&table);
  retract_root(&name);
  retract_root(&structure);
  retract_root(&time);
  new_table = mlw_cons(triple, table);

  return(new_table);
}

mlval mt_lookup(mlval table, mlval name, mlval parent)
{
  char *end, *path;
  mlval mod_name, t;
  unsigned int index, name_len = CSTRINGLENGTH(name) + 1;

  declare_root(&table, 0);
  declare_root(&parent, 0);
  declare_root(&name, 0);
  mod_name = allocate_string (CSTRINGLENGTH(parent) + name_len);
  retract_root(&parent);
  retract_root(&name);
  retract_root(&table);

  path = CSTRING(parent);

  end = path + strlen (path) - 1;

  DIAGNOSTIC(2, "parent = %s, name = %s", CSTRING(parent), CSTRING(name));
  do {
    while (end > path && *end != '.')
      end--;

    if (end > path) {
      index = end - path + 1;
      strncpy (CSTRING(mod_name), path, index);
      end --;
    } else {
      index = 0;
    }

    strcpy (CSTRING(mod_name) + index, CSTRING(name));
    CSTRING(mod_name)[index + name_len] = '\0';

    t = table;

    while(!MLISNIL(t))
    {
      mlval triple = MLHEAD(t);
  
      if(!strcmp(CSTRING(FIELD(triple, 0)), CSTRING(mod_name)))
        return(FIELD(triple, 1));
  
      t = MLTAIL(t);
    }
  } while (index != 0);

  return(MLERROR);
}

mlval mt_lookup_time(mlval table, mlval name, mlval parent)
{
  char *end, *path;
  mlval mod_name, t;
  unsigned int index, name_len = CSTRINGLENGTH(name) + 1;

  declare_root(&table, 0);
  declare_root(&parent, 0);
  declare_root(&name, 0);
  mod_name = allocate_string (CSTRINGLENGTH(parent) + name_len);
  retract_root(&parent);
  retract_root(&name);
  retract_root(&table);

  path = CSTRING(parent);

  end = path + strlen (path) - 1;

  DIAGNOSTIC(2, "parent = %s, name = %s", CSTRING(parent), CSTRING(name));
  do {
    while (end > path && *end != '.')
      end--;

    if (end > path) {
      index = end - path + 1;
      strncpy (CSTRING(mod_name), path, index);
      end --;
    } else {
      index = 0;
    }

    strcpy (CSTRING(mod_name) + index, CSTRING(name));
    CSTRING(mod_name)[index + name_len] = '\0';

    t = table;

    while(!MLISNIL(t))
    {
      mlval triple = MLHEAD(t);
  
      if(!strcmp(CSTRING(FIELD(triple, 0)), CSTRING(mod_name)))
        return(FIELD(triple, 2));
  
      t = MLTAIL(t);
    }
  } while (index != 0);

  return(MLERROR);
}

extern void mt_update(mlval structure, mlval name, mlval time)
{
  mlval temp = mt_add(DEREF(modules), name, structure, time);
  /* Do NOT inline this */
  MLUPDATE(modules, 0, temp);
}
