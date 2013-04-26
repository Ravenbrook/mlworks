#include <sys/types.h>
#include <sys/utsname.h>
#ifndef linux
#include <sys/systeminfo.h>
#endif
#ifdef SGI
#include <invent.h>
#endif
#include <string.h>
#include "hqosarch.h"

#include <stdio.h>

void
host_platform(char *result)
{
	struct utsname uts;
	char processor[OSARCH_NAMESIZE];
	char arch[OSARCH_NAMESIZE];
	char *rel = uts.release;
	char *cp;

	if (uname(&uts) == -1)
        {
          strcpy(result, "unix-unknown");
          return;
	}
	if (strncmp(uts.sysname, "IRIX", 4) == 0)
        {
          strcpy(result, "irix");
	}
        else if ((strcmp(uts.sysname, "SunOS") == 0) ||
                 (strcmp(uts.sysname, "sunos") == 0))
        {
          if (strncmp(rel, "5", 1) == 0)
          {
            strcpy(result, "solaris_2");
            rel += 1 + (rel[1] == '.');
          }
          else if (strncmp(rel, "6", 1) == 0)
          {
            strcpy(result, "solaris_3");
            rel += 1 + (rel[1] == '.');
          }
          else
          {
            strcpy(result, "sunos");
          }
	}
        else if ((strcmp(uts.sysname, "Linux") == 0) ||
                 (strcmp(uts.sysname, "linux") == 0))
        {
          strcpy(result, "linux");
	}
        else
        {
          strcpy(result, "unknown");
	}
        cp = result + strlen(result);
        
	for (*cp++ = '_'; *cp = *rel; cp++, rel++)
        {
          if (*cp == '.' || *cp == '-')
            *cp = '_';
        }

        *cp++ = '-'; *cp = '\0';


#ifdef linux
        {
          char *mac = uts.machine;
          if (strlen(mac) == 4 && mac[0] == 'i' /* ix86 */
              && mac[2] == '8' && mac[3] == '6')
          { 
            int family = mac[1] - '0';
            if (family < 5)
              strcpy(arch, mac+1); /* eg 386, 486 */
            else if (family == 5)
              strcpy(arch, "pentium");
            else
              sprintf(arch, "pentium_%d", family-4);
          }
          else
            strcpy(arch, mac);
        }
#else
	if (sysinfo(SI_ARCHITECTURE, processor, sizeof(processor)) == -1)
        {
          strcpy(arch, "unknown");
	}
        else
        {
          strcpy(arch, processor);
	}
#endif
/*
	if (strncmp(uts.sysname, "IRIX", 4) == 0) {
#ifdef SGI
		inventory_t *inv = NULL;
		inv_state_t *istate = NULL;
		setinvent_r(&istate);
		while ((inv = getinvent_r(istate)) != NULL) {
			if (inv->inv_class == INV_PROCESSOR && inv->inv_type == INV_CPUCHIP) {
				sprintf(arch+strlen(arch), "_r%d", inv->inv_state);
				break;
			}
		}
		endinvent_r(istate);
#endif
	}
*/

	strcat(result, arch);
}

/*
 * $Log: hostplat.c,v $
 * Revision 1.5  2000/11/14 12:32:51  paule
 * [Bug #23692]
 * small unix bug fix
 *
 * Revision 1.4  2000/10/25  12:22:58  peterg
 * [Bug #11232]
 * Get a clean build on Linux
 *
 * Revision 1.3  1999/12/17  12:23:26  peter
 * [Bug #22725]
 * Take out the SGI revision code until I find out how to make it work.
 *
 * Revision 1.2  1999/12/16  18:44:14  peter
 * [Bug #22725]
 * Initial implementation. The architecture version number is not
 * right yet: I get mips_r2343 instead of mips_r10000.
 *
 * Revision 1.1  1999/12/15  14:48:58  johnk
 * new unit
 * [Bug #22725]
 * Add so JAM continues to build on UNIX systems.
 *
 */
