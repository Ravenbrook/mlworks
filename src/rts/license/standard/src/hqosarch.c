/*
 * $HopeName: HQNc-standard!src:hqosarch.c(trunk.14) $
 *
 */

#include <string.h>
#include <memory.h>
#include "hqosarch.h"

typedef struct NODE {
	char name[OSARCH_NAMESIZE];
	struct NODE **links;
	int index;
} NODE;

typedef struct NSTRING {
	char *str;
	int   len;
} NSTRING;

typedef struct PLATFORM {
	NSTRING os;
	NSTRING arch;
} PLATFORM;
 
/*
 * Hide the details of declaring the compatibility lists.
 * The main reason for this is not convenience or aesthetics,
 * but to help with visual consistency checking.
 */
#define DECNODE(type,name)       NODE *links_##type##_##name[] = {
#define ENDNODE(type,index,name) 0}; NODE type##_##name[1] = {#name, links_##type##_##name, index};

static char all[] = "all";

/*
 * Compatibility information for operating systems.
 *
 * The index numbers here must correspond exactly to the order in which
 * nodes appear in list_os. It would be safest to add new nodes at the end.
 */
DECNODE(os,all)                                      ENDNODE(os, 0,all)
DECNODE(os,pc)             os_all,                   ENDNODE(os, 1,pc)
DECNODE(os,dos)            os_pc,                    ENDNODE(os, 2,dos)
DECNODE(os,win)            os_dos,                   ENDNODE(os, 3,win)
DECNODE(os,win_32)         os_win,                   ENDNODE(os, 4,win_32)
DECNODE(os,win_95)         os_win_32,                ENDNODE(os, 5,win_95)
DECNODE(os,win_nt)         os_win_32,                ENDNODE(os, 6,win_nt)
DECNODE(os,win_nt_3)       os_win_nt,                ENDNODE(os, 7,win_nt_3)
DECNODE(os,win_nt_4)       os_win_nt_3,              ENDNODE(os, 8,win_nt_4)
DECNODE(os,win_nt_5)       os_win_nt_4,              ENDNODE(os, 9,win_nt_5)
DECNODE(os,unix)           os_all,                   ENDNODE(os,10,unix)
DECNODE(os,solaris)        os_unix,                  ENDNODE(os,11,solaris)
DECNODE(os,solaris_2)      os_solaris,               ENDNODE(os,12,solaris_2)
DECNODE(os,solaris_2_5)    os_solaris_2,             ENDNODE(os,13,solaris_2_5)
DECNODE(os,solaris_2_6)    os_solaris_2_5,           ENDNODE(os,14,solaris_2_6)
DECNODE(os,sunos)          os_unix,                  ENDNODE(os,15,sunos)
DECNODE(os,irix)           os_unix,                  ENDNODE(os,16,irix)
DECNODE(os,mac)            os_all,                   ENDNODE(os,17,mac)
DECNODE(os,macos)          os_mac,                   ENDNODE(os,18,macos)
DECNODE(os,macos_8)        os_macos,                 ENDNODE(os,19,macos_8)
DECNODE(os,irix_6)         os_irix,                  ENDNODE(os,20,irix_6)
DECNODE(os,irix_6_3)       os_irix_6,                ENDNODE(os,21,irix_6_3)
DECNODE(os,irix_6_4)       os_irix_6_3,              ENDNODE(os,22,irix_6_4)
DECNODE(os,irix_6_5)       os_irix_6_4,              ENDNODE(os,23,irix_6_5)
DECNODE(os,macos_9)        os_macos_8,               ENDNODE(os,24,macos_9)
DECNODE(os,linux)          os_unix,                  ENDNODE(os,25,linux)
  /* quick hack: */
DECNODE(os,linux_2)        os_linux,                 ENDNODE(os,26,linux_2)
DECNODE(os,win_98)         os_win_95,                ENDNODE(os,27,win_98)
DECNODE(os,macos_x)        os_macos,                 ENDNODE(os,28,macos_x)
DECNODE(os,win_me)         os_win_98,                ENDNODE(os,29,win_me)

NODE *list_os[] = {
	os_all,
	os_pc,
	os_dos,
	os_win,
	os_win_32,
	os_win_95,
	os_win_nt,
	os_win_nt_3,
	os_win_nt_4,
        os_win_nt_5,
	os_unix,
	os_solaris,
	os_solaris_2,
	os_solaris_2_5,
	os_solaris_2_6,
	os_sunos,
	os_irix,
	os_mac,
	os_macos,
	os_macos_8,
	os_irix_6,
	os_irix_6_3,
	os_irix_6_4,
	os_irix_6_5,
	os_macos_9,
        os_linux,
        os_linux_2,
        os_win_98,
        os_macos_x,
        os_win_me,
	0
};
#define OS_COUNT (sizeof(list_os)/sizeof(*list_os) - 1)

/*
 * Compatibility information for architectures.
 *
 * The mips r5000, r8000 and r10000 are all considered equivalent,
 * hence the forward declaration and circular links below.
 *
 * The index numbers here must correspond exactly to the order in which
 * nodes appear in list_arch. It would be safest to add new nodes at the end.
 */
extern NODE arch_mips_r10000[];

DECNODE(arch,all)                                       ENDNODE(arch, 0,all)
DECNODE(arch,x86)          arch_all,                    ENDNODE(arch, 1,x86)
DECNODE(arch,386)          arch_x86,                    ENDNODE(arch, 2,386)
DECNODE(arch,486)          arch_386,                    ENDNODE(arch, 3,486)
DECNODE(arch,486_sx)       arch_486,                    ENDNODE(arch, 4,486_sx)
DECNODE(arch,486_dx)       arch_486_sx,                 ENDNODE(arch, 5,486_dx)
DECNODE(arch,pentium)      arch_486,                    ENDNODE(arch, 6,pentium)
DECNODE(arch,mips)         arch_all,                    ENDNODE(arch, 7,mips)
DECNODE(arch,mips_r4000)   arch_mips,                   ENDNODE(arch, 8,mips_r4000)
DECNODE(arch,mips_r5000)   arch_mips, arch_mips_r10000, ENDNODE(arch, 9,mips_r5000)
DECNODE(arch,mips_r8000)   arch_mips_r5000,             ENDNODE(arch,10,mips_r8000)
DECNODE(arch,mips_r10000)  arch_mips_r8000,             ENDNODE(arch,11,mips_r10000)
DECNODE(arch,ppc)          arch_all,                    ENDNODE(arch,17,ppc)
DECNODE(arch,601)          arch_ppc,                    ENDNODE(arch,12,601)
DECNODE(arch,603)          arch_601,                    ENDNODE(arch,13,603)
DECNODE(arch,604)          arch_603,                    ENDNODE(arch,14,604)
DECNODE(arch,g3)           arch_604,                    ENDNODE(arch,15,g3)
DECNODE(arch,x704)         arch_g3,                     ENDNODE(arch,16,x704)
DECNODE(arch,sparc)        arch_all,                    ENDNODE(arch,18,sparc)
DECNODE(arch,g4)           arch_x704,                   ENDNODE(arch,19,g4)

NODE *list_arch[] = {
	arch_all,
	arch_x86,
	arch_386,
	arch_486,
	arch_486_sx,
	arch_486_dx,
	arch_pentium,
	arch_mips,
	arch_mips_r4000,
	arch_mips_r5000,
	arch_mips_r8000,
	arch_mips_r10000,
	arch_601,
	arch_603,
	arch_604,
	arch_g3,
	arch_x704,
	arch_ppc,
	arch_sparc,
	arch_g4,
	0
};
#define ARCH_COUNT (sizeof(list_arch)/sizeof(*list_arch) - 1)

#define MAX_COUNT (OS_COUNT > ARCH_COUNT ? OS_COUNT : ARCH_COUNT)

static int
str_eq_nstring(char *str, NSTRING nstring)
{
	return strncmp(str, nstring.str, nstring.len) == 0 && str[nstring.len] == '\0';
}

static NODE *
find(NSTRING name, NODE **np)
{
	while (*np && !str_eq_nstring((*np)->name, name))
		np++;
	return *np;
}

static int
compatible_rec(NODE *n, NSTRING name, char *visited)
{
	int i;

	if (visited[n->index])
		return 0;
	visited[n->index] = 1;
	if (str_eq_nstring(n->name, name))
		return 1;
	for (i = 0; n->links[i]; i++)
		if (compatible_rec(n->links[i], name, visited))
			return 1;
	return 0;
}

static int
compatible(NSTRING name1, NSTRING name2, NODE **list, char *visited, size_t list_len)
{
	while (name1.len > 0) {
		NODE *n = find(name1, list);
		if (n) {
			memset(visited, 0, list_len);
			return compatible_rec(n, name2, visited);
		}
		do {
			name1.len--;
		} while (name1.len > 0 && name1.str[name1.len] != VERSION_SEPARATOR);
	}
	return 0;
}

static void
parse_platform(char *string, PLATFORM *p)
{
	char *cp = strrchr(string, COMPONENT_SEPARATOR);
	p->os.str = string;
	if (cp) {
		p->os.len = cp - string;
		p->arch.str = cp+1;
	} else {
		p->os.len = strlen(string);
		p->arch.str = all;
	}
	p->arch.len = strlen(p->arch.str);
}

int
platform_includes(char *general, char *specific)
{
	char visited[MAX_COUNT];
	PLATFORM gen, spec;

	parse_platform(general,  &gen);
	parse_platform(specific, &spec);

	return compatible(spec.os,   gen.os,   list_os,   visited, OS_COUNT)
            && compatible(spec.arch, gen.arch, list_arch, visited, ARCH_COUNT);
}

int
platform_overlaps(char *platform1, char *platform2)
{
	char vis[MAX_COUNT];
	PLATFORM g, s;

	parse_platform(platform1, &g);
	parse_platform(platform2, &s);

	return 	(compatible(s.os,   g.os,   list_os,   vis, OS_COUNT)   || compatible(g.os,   s.os,   list_os,   vis, OS_COUNT))
	&&      (compatible(s.arch, g.arch, list_arch, vis, ARCH_COUNT) || compatible(g.arch, s.arch, list_arch, vis, ARCH_COUNT));
}

int
platform_included(char *specific, char *general)
{
	return platform_includes(general, specific);
}

int
platform_identical(char *platform1, char *platform2)
{
	return strcmp(platform1, platform2) == 0;
}

int
platform_different(char *platform1, char *platform2)
{
	return strcmp(platform1, platform2) != 0;
}

/*
 * $Log: hqosarch.c,v $
 * Revision 1.15  2001/09/20 10:50:51  rday
 * [Bug #24498]
 * add win_nt_5 (win2000)
 *
 * Revision 1.14  2001/01/16  10:56:24  luke
 * [Bug #23880]
 * Add windows ME.
 *
 * Revision 1.13  2000/12/21  16:43:12  peter
 * [Bug #23845]
 * Add G4 Mac.
 *
 * Revision 1.12  2000/12/19  16:44:01  miker
 * [Bug #23822]
 * Remove Mac OS X hack in favour of specifying preprocessor in makefile
 *
 * Revision 1.11  2000/12/14  10:15:41  luke
 * [Bug #23826]
 * Add Win98 as a kind of Win95
 *
 * Revision 1.10  2000/12/12  11:42:18  peterg
 * [Bug #11232]
 * Add linux
 *
 * Revision 1.9  2000/11/24  14:08:14  miker
 * [Bug #23773]
 * Hack for 486SX/DX on Mac OS X
 *
 * Revision 1.8  2000/07/24  14:50:56  luke
 * [Bug #23289]
 * add sparc
 *
 * Revision 1.7  2000/06/16  10:06:07  peterg
 * [Bug #1]
 * Add macos 9
 *
 * Revision 1.6  2000/03/20  19:12:01  peter
 * [Bug #22725]
 * Add some MacOS versions.
 *
 * Revision 1.5  1999/12/21  18:38:04  peter
 * [Bug #22725]
 * Add Irix versions.
 *
 * Revision 1.4  1999/12/15  14:07:10  peter
 * [Bug #22725]
 * Make NAMESIZE visible externally.
 *
 * Revision 1.3  1999/12/14  10:47:29  peter
 * [Bug #22725]
 * Add platform_identical and platform_different.
 *
 * Revision 1.2  1999/11/18  12:46:56  peter
 * [Bug #22725]
 * Add platform_included as the converse of platform_includes,
 * so that there is a complete set of functions available for
 * passing as parameters to other functions.
 *
 * Revision 1.1  1999/10/29  16:24:14  peter
 * new unit
 * [Bug #22725]
 * new unit
 *
 */
