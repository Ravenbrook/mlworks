/*  ==== GLOBAL C ROOTS ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  The runtime system needs to maintain some global C roots, such as the
 *  module table, debugger hook, etc.  These must be saved with a heap image
 *  and restored when it is reloaded.  This code takes care of organising
 *  the global roots.
 *
 *  Revision Log
 *  ------------
 *  $Log: global.h,v $
 *  Revision 1.7  1996/07/01 09:00:30  nickb
 *  Change names of other _NIL flags for consistency.
 *
 * Revision 1.6  1996/06/27  15:49:32  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.5  1996/02/19  13:54:18  nickb
 * Add weak_save.
 *
 * Revision 1.4  1996/02/16  18:39:22  nickb
 * Add some default flag values.
 *
 * Revision 1.3  1996/02/16  14:35:10  nickb
 * Add more sophistication to global roots.
 *
 * Revision 1.2  1994/06/09  14:36:39  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:03:33  nickh
 * new file
 *
 *  Revision 1.4  1992/08/07  08:44:47  richard
 *  Added weak_length and changed the type of weak_apply.
 *
 *  Revision 1.3  1992/08/05  09:53:10  richard
 *  Added weak list utilities.
 *
 *  Revision 1.2  1992/07/24  10:40:07  richard
 *  Added a hook function to global roots.
 *
 *  Revision 1.1  1992/07/23  11:22:54  richard
 *  Initial revision
 *
 */

#ifndef global_h
#define global_h

#include "mltypes.h"


/*  === DECLARE A ROOT AS GLOBAL ===
 *
 *  This function is similar to declare_root() except that the root is
 *  remembered for inclusion in the global root (see below).  It
 *  performs an implicit declare_root().  The root must be given a
 *  unique name which is used by global_pack() and global_unpack() to
 *  save and restore the root in a value.  (The address of the root is
 *  not used as its `name' to maintain compatability between runtime
 *  systems and images.)
 *
 *  The name passed must not be updated or deallocated.
 *
 *  Various flags and functions may also be passed to control the
 * behaviour of the roots at save, deliver, and load times:
 *
 * 1. At SAVE/DELIVER time:
 *
 * if the save_fn is non-nil, the save_fn is called. If it returns DEAD, the
 *		root is not recorded in the image. Otherwise the value it
 *		returns is recorded.		
 * if the NIL flag is set, the root is set to MLUNIT.
 *              This helps make deliver images smaller.
 * if the save_fn is NULL and the RECORD flag is set, the root is recorded
 * 		in the image.
 * 
 * 2. At LOAD time:
 * 
 * if the load_fn is non-nil, it is applied to the root and the loaded value.
 * otherwise the root is set to the loaded value.
 *
 * 3. If the loaded image is MISSING a name:
 *
 * if the missing_fn is non-nil, it is called.
 * otherwise: if the WARN flag is set, a warning is issued
 *            if either the WARN or UNIT flag is set, the root is set to MLUNIT.
 *            if neither flag is set, a runtime error is caused.
 *
 * 4. If the loaded image contains an UNMATCHED name:
 * 
 * if the IGNORE flag is set, the name is disregarded.
 * otherwise if the WARN flag is set, a warning is issued.
 * if neither flag is set, a runtime error is caused.  */

#define GLOBAL_SAVE_RECORD	 0x1
#define GLOBAL_SAVE_UNIT		 0x2
#define GLOBAL_SAVE_FLAGS	 0x3

#define GLOBAL_DELIVER_RECORD	 0x10
#define GLOBAL_DELIVER_UNIT	 0x20
#define GLOBAL_DELIVER_FLAGS	 0x30
#define GLOBAL_DELIVER_SHIFT	4	    /* turns deliver into save flags */

#define GLOBAL_MISSING_ERROR	0x000
#define GLOBAL_MISSING_UNIT	0x100
#define GLOBAL_MISSING_WARN     0x200
#define GLOBAL_MISSING_FLAGS	0x300

#define GLOBAL_UNMATCHED_ERROR	     0x0000
#define GLOBAL_UNMATCHED_IGNORE	     0x1000
#define GLOBAL_UNMATCHED_WARN        0x2000
#define GLOBAL_UNMATCHED_FLAGS	     0x3000

/* global entries which are weak lists should set this bit in their
 * flags. The lists are then tidied up on delivery. */

#define GLOBAL_WEAK_LIST	     0x10000
#define GLOBAL_MISC_FLAGS	     0x10000

#define GLOBAL_ALL_FLAGS	(GLOBAL_SAVE_FLAGS +		\
				 GLOBAL_DELIVER_FLAGS + 	\
				 GLOBAL_MISSING_FLAGS + 	\
				 GLOBAL_UNMATCHED_FLAGS +       \
				 GLOBAL_MISC_FLAGS)

extern void declare_global
	(const char *name, mlval *root, word flags,
	 mlval (*save_fn)(const char *name, mlval *root, int deliver),
	 void (*load_fn)(const char *name, mlval *root, mlval value),
         void (*missing_fn)(const char *name, mlval *root));

/* global_save_die is a suitable save_fn for a function which should
 * always be recorded as MLUNIT in any saved image. i.e. it always
 * returns DEAD. */

extern mlval global_save_die(const char *name, mlval *root, int deliver);

/* GLOBAL_ENV is the right set of flags for a root which is concerned
 * with the environment: it ensures that the value is preserved on
 * image save but zapped on delivery. Such a root should also either
 * have the GLOBAL_MISSING_UNIT flag (if MLUNIT is a meaningful value
 * for it to have) or have a missing_fn defined, so that it can be
 * reconstructed when loading a delivered image.  */

#define	GLOBAL_ENV		(GLOBAL_SAVE_RECORD + \
				 GLOBAL_DELIVER_UNIT + \
				 GLOBAL_UNMATCHED_ERROR )

/* GLOBAL_TRANSIENT is the right set of flags for a root which holds
 * some value which is only relevant to the current runtime
 * invocation. For instance, a set of callbacks for the user
 * interface. Such a root will be zapped on delivery, and can be
 * zapped on image save (by using global_save_die as the save_fn), and
 * should either be reconstructed by a missing_fn or have
 * GLOBAL_MISSING_UNIT set (and reconstruct on first use) */

#define GLOBAL_TRANSIENT	(GLOBAL_DELIVER_UNIT +   \
				 GLOBAL_UNMATCHED_ERROR)

/* GLOBAL_DEFAULT is the set of flags for a root which even has to be
 * preserved in delivered images. It also matches the behaviour which
 * the runtime had before all these switches were introduced. */

#define GLOBAL_DEFAULT    	(GLOBAL_SAVE_RECORD +		\
				 GLOBAL_DELIVER_RECORD + 	\
				 GLOBAL_MISSING_ERROR + 	\
				 GLOBAL_UNMATCHED_ERROR)


/*  === PACK/UNPACK THE GLOBAL ROOTS ===
 *
 *  global_pack() packs the roots that have been declared as global together
 *  in a single ML value, together with their declared names.
 *  global_tidy() is called by during the image clean, after all dead
 *  values have been GCed away. Its purpose is to allow the shrinking
 *  of weak lists in the global package.
 *  global_unpack() takes a value previously returned by global_pack() and
 * assigns the global roots from the values it contains.  */

extern mlval global_pack(int deliver);
extern void global_tidy(mlval package);
extern void global_unpack(mlval package);

/*  === ROOT UTILITIES ===
 *
 *  One of the common uses for global roots is to keep track of values on
 *  the ML heap, but not to keep them alive by doing so.  These functions
 *  administer lists of such values.
 */


/*  == Make a new list ==
 *
 *  The granularity paramter determines the size of the tables on the list.
 *  It should be larger for lists which are expected to contain more values.
 *  A good value for a small list is 16.
 */

extern mlval weak_new(size_t granularity);


/*  == Add a value to a list ==
 *
 *  Returns the new list.  The list parameter may be updated and should not
 *  be used again.
 */

extern mlval weak_add(mlval list, mlval value);


/*  == Calculate length of list ==
 *
 *  Returns the number of elements in the list.
 */

extern size_t weak_length(mlval list);


/*  == Fix values on a list ==
 *
 *  Applies the function f to all values on a list, including an index.  The
 *  function should return a (possibly different) value to replace the value
 *  to which it is applied.  This returned value may be DEAD to expunge the
 *  value from the list.  Returns the new list.
 */

extern void weak_apply(mlval list, mlval (*f)(unsigned int index, mlval));

#endif
