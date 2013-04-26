#include "hqosarch.h"
#include <stdio.h>
#include <string.h>
#include <Gestalt.h>

void
host_platform(char *result)
{
	long g = 0L;

	if (Gestalt(gestaltSystemVersion, &g) == noErr)
	{
	  long osver = (g & 0xff00) >> 8;
	  char * osx = "";
	  if (osver > 9)
	    osx = "_x";

	  sprintf(result, "macos%s_%lx_%ld_%ld-", osx, osver, (g & 0xf0) >> 4, (g & 0xf));
	} else {
		strcpy(result, "unknown-");
	}
	if (Gestalt(gestaltSysArchitecture, &g) == noErr) {
		if (g == gestalt68k) {
			strcat(result, "68k");
		} else if (g == gestaltPowerPC) {
			strcat(result, "ppc_");
			if (Gestalt(gestaltNativeCPUtype, &g) == noErr) {
				switch (g) {
				case 0x101:
					strcat(result, "601");
					break;
				case 0x103:
					strcat(result, "603");
					break;
				case 0x104:
					strcat(result, "604");
					break;
				case 0x106:
					strcat(result, "603_e");
					break;
				case 0x107:
					strcat(result, "603_e_v");
					break;
				case 0x108:
					strcat(result, "g3");
					break;
				case 0x109:
					strcat(result, "604_e");
					break;
				case 0x10a:
					strcat(result, "604_e_v");
					break;
				case 0x154:
					strcat(result, "x704");
					break;
				case 0x160:
					strcat(result, "x704_2");
					break;
				case 0x10c:
					strcat(result, "g4");
					break;
				default:
					strcat(result, "unknown");
				}
			} else {
				strcat(result, "unknown");
			}
		} else {
			strcat(result, "unknown");
		}
	} else {
		strcat(result, "unknown");
	}
}

/*
 * $Log: hostplat.c,v $
 * Revision 1.4  2001/06/28 11:32:41  build
 * [Bug #23822]
 * make MacOS X specific
 *
 * Revision 1.3  2000/12/21  16:43:09  peter
 * [Bug #23845]
 * Add G4 Mac.
 *
 * Revision 1.2  2000/05/11  10:31:17  miker
 * [Bug #22203]
 * Include header for sprintf
 *
 * Revision 1.1  1999/12/20  13:05:23  peter
 * new unit
 * [Bug #22725]
 * Platform detection code for the Mac.
 *
 */
