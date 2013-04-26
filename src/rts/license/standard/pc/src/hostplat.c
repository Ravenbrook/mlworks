#include <string.h>
#include <windows.h>
#include "hqosarch.h"

#include <stdio.h>

void
host_platform(char *result)
{
	SYSTEM_INFO sys;
	OSVERSIONINFO os;
	char arch[OSARCH_NAMESIZE];

	ZeroMemory(&os, sizeof(os));
	os.dwOSVersionInfoSize = sizeof(os);
	GetVersionEx(&os);

	if (os.dwPlatformId == VER_PLATFORM_WIN32s) {
		strcpy(result, "win_32");
	} else if (os.dwPlatformId == VER_PLATFORM_WIN32_WINDOWS) {
		strcpy(result, "win");
		if (os.dwMinorVersion == 0) {
			strcat(result, "_95");
		} else if (os.dwMinorVersion == 10) {
			strcat(result, "_98");
		} else if (os.dwMinorVersion == 90) {
			strcat(result, "_me");
		}
	} else if (os.dwPlatformId == VER_PLATFORM_WIN32_NT) {
		sprintf(result, "win_nt_%d_%d", os.dwMajorVersion, os.dwMinorVersion);
	} else {
		strcpy(result, "pc");
	}

	strcat(result, "-");

	ZeroMemory(&sys, sizeof(sys));
	GetSystemInfo(&sys);

	if (os.dwPlatformId == VER_PLATFORM_WIN32_NT) {
		if (sys.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_INTEL) {
			int model = sys.wProcessorRevision >> 8;
			if (sys.wProcessorLevel == 3) {
				strcpy(arch, "386");
			} else if (sys.wProcessorLevel == 4) {
				strcpy(arch, "486");
				if (model < 2) {
					strcat(arch, "_dx");
				} else if (model == 2) {
					strcat(arch, "_sx");
				} else if (model == 3) {
					strcat(arch, "_dx_2");
				} else if (model == 4) {
					strcat(arch, "_sl");
				} else if (model == 5) {
					strcat(arch, "_sx_2");
				} else if (model == 7) {
					strcat(arch, "_dx_2");
				}
			} else if (sys.wProcessorLevel == 5) {
				strcpy(arch, "pentium");
				if (model == 3) {
					strcat(arch, "_overdrive");
				} else if (model == 4) {
					strcat(arch, "_mmx");
				} 
			} else if (sys.wProcessorLevel == 6) {
				strcpy(arch, "pentium");
				if (model == 1) {
					strcat(arch, "_pro");
				} else if (model == 3) {
					strcat(arch, "_2_3");
				} else if (model == 5) {
					strcat(arch, "_2_5");
				} 
			} else {
				strcpy(arch, "x86");
			}
		} else if (sys.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_ALPHA) {
			sprintf(arch, "alpha_%d_%d", sys.wProcessorLevel, sys.wProcessorRevision);
		} else {
			sprintf(arch, "unknown");
		}
	} else {
		if (sys.dwProcessorType == PROCESSOR_INTEL_386) {
			strcpy(arch, "386");
		} else if (sys.dwProcessorType == PROCESSOR_INTEL_486) {
			strcpy(arch, "486");
		} else if (sys.dwProcessorType == PROCESSOR_INTEL_PENTIUM) {
			strcpy(arch, "pentium");
		} else {
			strcpy(arch, "unknown");
		}
	}
	strcat(result, arch);
}

/*
 * $Log: hostplat.c,v $
 * Revision 1.2  2001/01/16 10:56:24  luke
 * [Bug #23880]
 * Add windows ME.
 *
 * Revision 1.1  1999/12/15  14:06:02  peter
 * new unit
 * [Bug #22725]
 * Platform detection for the PC.
 *
 */

