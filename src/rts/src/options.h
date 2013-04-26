/*  ==== COMMAND LINE OPTIONS PARSER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides a generalised parsing mechanism for the command
 *  line parameters passed to main().  A command line of the form:
 *
 *    command [options] parm...
 *
 *  where options are keywords beginning with OPTION_CHAR which can take
 *  zero or more arguments.  Options must come before any other parameters.
 *  The option OPTION_CHAR OPTION_CHAR (e.g. "--" on UNIX) is special: it
 *  terminates option processing.  All parameters after it are ignored.
 *
 *  Revision Log
 *  ------------
 *  $Log: options.h,v $
 *  Revision 1.2  1994/06/09 14:44:49  nickh
 *  new file
 *
 * Revision 1.1  1994/06/09  11:13:47  nickh
 * new file
 *
 *  Revision 1.4  1993/06/02  13:06:46  richard
 *  Improved the use of const on the argv parameter type.
 *
 *  Revision 1.3  1993/04/30  12:36:39  richard
 *  Multiple arguments can now be passed to the storage manager in a general
 *  way.
 *
 *  Revision 1.2  1992/09/01  10:48:23  richard
 *  Implemented delimited options.
 *
 *  Revision 1.1  1992/03/18  14:06:00  richard
 *  Initial revision
 *
 */

#ifndef options_h
#define options_h

#include <stddef.h>


/*  == Option switch character ==
 *
 *  This character is used to distinguish options from other parameters.
 */

#define OPTION_CHAR	'-'


/*  == Option desciptor ==
 *
 *  An option descriptor specifies the keyword for an option and the number
 *  of arguments it requires.  An array of these desciptors is passed to
 *  option_parse() below and updated to contains the parameters.
 */

struct option
{
  const char *name;
  int nr_arguments;
  int specified;
  const char *const *arguments;
};



/*  === PARSE COMMAND LINE OPTIONS ===
 *
 *  The option_parse() function is passed pointers to a list of arguments
 *  such as those passed to main().  (Actually, it is passed argc-1 and
 *  argv+1.) It also takes an array of option descriptors (see
 *  above) terminated with a descriptor whose `name' field is NULL.  The
 *  parameters in the argv array are matched against the option names and
 *  the option desciptors are updated to inidicate that they were specified.
 *
 *  For example, if OPTION_CHAR is '-' and the desciptor array is
 *  initialised to
 *   {{"x", 0, 0, NULL}, {"y", 2, 0, NULL}, {"z", 1, 0, NULL},
 *    {NULL, 0, 0, NULL}}
 *  and the command line was
 *   foo -y A B -x -- -z loofah
 *  i.e. it is the array
 *   {"foo", "-y", "A", "B", "-x", "--", "-z", "loofah"}
 *  the desciptors will be updated to
 *   {{"x", 0, 1, ?}, {"y", 2, 1, {"A", "B"}}, {"z", 1, 0, NULL},
 *    {NULL, 0, 0, NULL}}
 *  and the command array will be
 *   {"-z", "loofah"}
 *
 *  A non-zero value is returned iff successful, otherwise `errno' is set to
 *  one of the enumerated values below and argv is left pointing to the
 *  problematical parameter.
 *
 *  NOTE: option_parse does not make use of the fact that argv[argc] is
 *  NULL, so it is safe to use on other arrays of strings.
 */

enum
{
  EOPTIONUNKNOWN=1,	/* An option not in the desciptors was specified. */
  EOPTIONARGS,		/* The wrong number of arguments were specified. */
  EOPTIONDELIM		/* Missing delimiter from delimited option. */
};

typedef const char *const *argv_t;

int option_parse(int *argcp,
		 argv_t *argvp,
		 struct option *options[]);


/*  === UTILITIES ===
 *
 *  These cause fatal errors if the string is of the wrong form.
 */

int to_int(const char *s);
unsigned int to_unsigned(const char *s);

#endif
