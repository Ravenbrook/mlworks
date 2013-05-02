/*
 * objectfile.h
 * The ML object file format.
 * $Log: objectfile.h,v $
 * Revision 1.12  1998/04/22 11:30:27  jont
 * [Bug #70091]
 * Change OBJECT_FILE_VERSION as we're about
 * to change the consistency info format
 *
 * Revision 1.11  1998/01/27  17:59:58  jont
 * [Bug #30330]
 * Update OBJECT_FILE_VERSION to cope with modifications for valenvs in tynames
 *
 * Revision 1.10  1997/10/20  21:27:27  jont
 * [Bug #30089]
 * New version for change in time type
 *
 * Revision 1.9  1997/10/10  10:03:51  daveb
 * [Bug #20090]
 * Consistency information now stores modification times of the source,
 * instead of those of the object.
 * Therefore increased the object file version.
 *
 * Revision 1.8  1995/04/07  09:24:40  matthew
 * Adding OBJECT_CODE_VERSION
 *
 * Revision 1.7  1995/04/06  10:30:47  matthew
 * Changing header size and version number
 *
 * Revision 1.6  1994/07/22  14:31:00  jont
 * Increase version number for save register count
 *
 * Revision 1.5  1994/06/24  15:20:29  jont
 * Increase version to 13
 *
 * Revision 1.4  1994/06/21  16:00:03  nickh
 * Bump version number: wordset layout has changed.
 *
 * Revision 1.3  1994/06/13  12:04:11  nickh
 * Bump version number.
 *
 * Revision 1.2  1994/06/09  14:43:55  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:12:32  nickh
 * new file
 *
 * Revision 1.18  1993/11/30  15:49:44  matthew
 * New Version number because of change to TYNAME and METATYNAME
 *
 * Revision 1.17  1993/08/26  15:40:46  daveb
 * Added HEADER_SIZE.
 *
 * Revision 1.16  1993/06/14  18:53:30  daveb
 * New object file format.
 *
 * Revision 1.15  1993/05/27  15:07:15  jont
 * New version cos encapsulator has changed
 *
 * Revision 1.14  1993/05/13  13:21:01  richard
 * Changed the encapsulation format of code vectors, and so the
 * object file version is now 6.
 *
 * Revision 1.13  1993/03/24  12:17:20  richard
 * Corrected #define symbols to upper case.
 *
 * Revision 1.12  1993/03/18  11:40:18  jont
 * New version to account for code changes for leaf and intercept offset
 *
 * Revision 1.11  1993/02/03  16:00:12  jont
 * Changes for code vector reform
 *
 * Revision 1.10  1993/01/15  10:23:46  daveb
 * Changed version to object_file_version, because this identifier is
 * macro-expanded by the C pre-processor, and "version" had false matches.
 *
 * Revision 1.9  1993/01/15  10:07:52  daveb
 * Changed runtime_version to version (since it's the version of the
 * object file format, not of the runtime system).
 *
 * Revision 1.8  1993/01/04  16:05:36  daveb
 * Added a version number for the object file format.
 *
 * Revision 1.7  1992/05/12  15:17:57  jont
 * Changed to use a magic number we can safely represent
 *
 * Revision 1.6  1991/10/17  16:52:26  davidt
 * Put the magic numbers in here so that one awk script can collect
 * the magic numbers as well as the opcode numbers.
 *
 * Revision 1.5  91/10/16  14:40:33  davidt
 * Changed enum datatype to a set of #defines to make automatic generation
 * of the sml file from this file easier.
 * 
 * Revision 1.4  91/10/16  12:55:39  davidt
 * Took out lots of the redundant opcodes now that the object file format
 * has been redesigned.
 * 
 * Revision 1.3  91/10/15  16:46:16  davidt
 * Put in opcode_wordset and took out old (commented out) version
 * of opcode types.
 * 
 * Revision 1.2  91/05/15  15:29:09  jont
 * New set of opcodes for revision of load format
 * 
 * Revision 1.1  91/05/14  11:06:20  jont
 * Initial revision
 * 
 */

/* Avoid multiple inclusion */
#ifndef codes_h
#define codes_h

/*
 * GOOD_MAGIC (0x1ADE6818) is an ML object file of the same endianness.
 * NOT_SO_GOOD_MAGIC (0x1868DE1A) is an ML object file of the wrong endianness.
 */

#define OLD_GOOD_MAGIC		987654321
#define GOOD_MAGIC		450783256
#define NOT_SO_GOOD_MAGIC	409525786

#define HEADER_SIZE	36
/*
 * The current version number.  Changed whenever the format of the object
 * files or of the generated code is changed.  This number is tested
 * when loading an object file (loader.c, encapsulate.sml) and when loading
 * a wordset in the interpreter (interload.sml).
 */

#define OBJECT_FILE_VERSION 19

/*
 * The earliest version number with code format compatible with the latest version
 * ie.  if a change to the encapsulation format only affects type environments there
 * is no need to change this
*/

#define OBJECT_CODE_VERSION 19

/*
 * The opcodes used in the object file.
 */

#define OPCODE_CODESET	0
#define OPCODE_REAL	1
#define OPCODE_STRING	2
#define OPCODE_EXTERNAL	3

#endif
