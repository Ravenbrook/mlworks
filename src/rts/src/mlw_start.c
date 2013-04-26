/*  === start_mlworks function ===
 *
 * Copyright (C) 1998, Harlequin Group plc
 * All rights reserved
 *
 *  Revision Log
 *  ------------
 *  $Log: mlw_start.c,v $
 *  Revision 1.3  1998/10/30 17:10:17  jont
 *  [Bug #70226]
 *  Move raise_count and stack_extension_count to here
 *
 * Revision 1.2  1998/10/19  10:48:55  jont
 * [Bug #70203]
 * Always do option parsing as per embedded images
 *
 * Revision 1.1  1998/10/16  14:25:01  jont
 * new unit
 * Extract start_mlworks into one file to avoid duplication
 *
 *
 */

#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "ansi.h"

#include "types.h"
#include "mltypes.h"

#include "values.h"
#include "profiler.h"
#include "license.h"
#include "options.h"
#include "mem.h"
#include "gc.h"
#include "loader.h"
#include "image.h"
#include "global.h"
#include "utils.h"
#include "allocator.h"
#include "interface.h"
#include "initialise.h"
#include "os.h"
#include "print.h"
#include "exec_delivery.h"
#include "pervasives.h"
#include "diagnostic.h"
#include "explore.h"
#include "environment.h"

#include "mlw_start.h"

#ifndef MACH_FIXUP
  #ifdef MEASURE_FIXUP
    #include "fixup.h"
  #endif
#endif

static const char usage_message[] =
  "Usage:   %s [options...] module...\n"
  "Options:\n"
  "\n"
  " Module Options:\n"
  "  --      This option does nothing, but nothing after it on the command \n"
  "          line will be treated as an option.\n"
  "  -load <file>\n"
  "          Load an image from <file> before loading any modules.\n"
  "  -from <file>\n"
  "          Read module file names from <file> before reading them from\n"
  "          the command line.\n"
  "  -save <file>\n"
  "          After loading the specified modules, save the image in <file>.\n"
  "  -pass <s> arg... <s>\n"
  "          Propagate arguments between the delimiter strings <s> to the\n"
  "          modules. <s> may be any string.\n"
  "\n"
  " Memory Management Options:\n"
  "  -c <n>  Report garbage collections at level <n> and above.\n"
  "  -limit <n>\n"
  "          Specifies an advisory arena extent size in Mb (default 100).\n"
  "          Collection frequency will increase as the amount of\n"
  "          virtual memory used by the process approaches this amount.\n"
  "  -stack <n>\n"
  "          Set initial maximum number of stack blocks to <n>.\n"
  "  -batch  Run in non-interactive mode; i.e. do not prompt when\n"
  "          virtual memory is exhausted.\n"
  "\n"
  " Profiling Options:\n"
  "  -profile <file>\n"
  "          Profile the entire run, writing the results to <file>.\n"
  "  -profile-scan <n>\n"
  "          When profiling, scan the stack every <n> milliseconds to\n"
  "          gather information.  An interval of zero disables scanning.\n"
  "          The default is 10 milliseconds.\n"
  "  -profile-depth <n>\n"
  "          When profiling with scanning, record patterns of caller\n"
  "          functions to a depth of <n> callers.  The default is zero.\n"
  "  -profile-select <s>\n"
  "          When profiling, only record information about functions which\n"
  "          include <s> in their names.  By default, all functions are\n"
  "          profiled.\n"
  "  -profile-manner <n>\n"
  "          A bit-pattern specifying which kind of profiling to do\n"
  "          Relevant bits are:-\n"
  "          Bit 0 - set for call counting\n"
  "          Bit 1 - set for time profiling\n"
  "          Bit 2 - set for space profiling\n"
  "          Bit 3 - set for space profile copying analysis\n"
  "                  (survival times for allocated values)\n"
  "          Bits 8-15 - set for space profile runtime type analysis\n"
  "                  (analysis broken down according to \"type\")\n"
  "          The default is 7 (i.e. time + space + call-counting)\n"
  "\n"
  " Miscellaneous Options:\n"
  "  -mono   Use the X resources for a monochrome screen (Unix only).\n"
  "  -verbose\n"
  "          Display some messages about runtime activities.\n"
  "  -statistics\n"
  "          Display various internal statistics at the end of the run.\n"
  "  -free-edition\n"
  "          Behave as a free edition (i.e., as if no license available).\n"
  "  -help   Display this message and exit.\n"

#ifdef DEBUG
  "\n"
  " Debugging Runtime Only:\n"
#ifdef DIAGNOSTICS
  "  -d <n>  Set diagnostic level to <n>.\n"
#endif /* DIAGNOSTICS */
  "  -delivery\n"
  "          Abbreviate code vector names on loading.\n"
  "  -image-analysis\n"
  "          Print a heap analysis when loading an image file.\n"
#ifdef EXPLORER
  "  -explore\n"
  "          Run the heap explorer on the global root.\n"
#endif /* EXPLORER */
  "\n"
  " Hidden Options:\n"
  "  -relaxed\n"
  "          Do not check consistency of module time stamps.\n"
  "  -no-load-exec\n"
  "          Do not load the heap image (for a saved executable).\n"
  "  -save-exec <file>\n"
  "          Save as an executable in <file>.\n"
  "  -backtrace-depth <depth>\n"
  "          Maximum depth of the backtrace for an uncaught exception.\n"
  "  -show   Display the result of the final module.\n"
  "  -print <depth> <length> <indent> <tags>\n"
  "          Control the way values are output. This only affects (a) -show\n"
  "          (b) uncaught exception args, (c) MLWorks.Internal.Value.print.\n"
  "          <depth> is the maximum nesting of structures (zero for no\n"
  "          limit), <length> is the maximum length of strings (also zero\n"
  "          for no limit), <indent>, if non-zero, causes values to be\n"
  "          printed on separate lines using indentation to show structure\n"
  "          <tags>, if non-zero, causes internal value information to be\n"
  "          displayed. Defaults are all zero.\n"
  "  -gc-statistics filename\n"
  "          Write garbage collection statistics to file.\n"

#endif /* DEBUG */
;

static struct option
/* Module Options */
  option_load            = {"load", 1, 0, NULL},
  option_modules         = {"from", 1, 0, NULL},
  option_save            = {"save", 1, 0, NULL},

/* Memory Management Options */
  option_messages        = {"c", 1, 0, NULL},
  option_limit           = {"limit", 1, 0, NULL},
  option_stacksize       = {"stack", 1, 0, NULL},
  option_batch           = {"batch", 0, 0, NULL},

/* Profiling Options */
  option_profile         = {"profile", 1, 0, NULL},
  option_profile_scan    = {"profile-scan", 1, 0, NULL},
  option_profile_depth   = {"profile-depth", 1, 0, NULL},
  option_profile_select  = {"profile-select", 1, 0, NULL},
  option_profile_manner  = {"profile-manner", 1, 0, NULL},

/* Miscellaneous Options */
  option_mono	         = {"mono", 0, 0, NULL},
  option_verbose         = {"verbose", 0, 0, NULL},
  option_statistics      = {"statistics", 0, 0, NULL},
  option_free_edition    = {"free-edition", 0, 0, NULL},
  option_help            = {"help", 0, 0, NULL},

/* Hidden Options */
  option_dont_check      = {"relaxed", 0, 0, NULL},
  option_no_load_exec    = {"no-load-exec", 0, 0, NULL},
  option_save_exec       = {"save-exec", 1, 0, NULL},
  option_backtrace_depth = {"backtrace-depth", 1, 0, NULL},
  option_show	         = {"show", 0, 0, NULL},
  option_print           = {"print", 4, 0, NULL},
  option_gc_stats        = {"gc-statistics", 1, 0, NULL},

/* Debugging Options */
#ifdef DIAGNOSTICS
  option_diagnostic      = {"d", 1, 0, NULL},
#endif
#ifdef DEBUG
  option_delivery        = {"delivery", 0, 0, NULL},
  option_analysis        = {"image-analysis", 0, 0, NULL},
#endif
#ifdef EXPLORER
  option_explore         = {"explore", 0, 0, NULL},
#endif
  option_end	         = {NULL, 0, 0, NULL};

static struct option *options[] =
{
/* Module Options */
 &option_load, &option_modules, &option_save,

/* Memory Management Options */
 &option_messages, &option_limit, &option_stacksize, &option_batch,

/* Profiling Options */
 &option_profile, &option_profile_scan, &option_profile_depth,
 &option_profile_select, &option_profile_manner,

/* Miscellaneous Options */
 &option_mono, &option_verbose, &option_statistics, &option_free_edition,
 &option_help,

/* Hidden Options */
 &option_dont_check, &option_no_load_exec, &option_save_exec,
 &option_backtrace_depth, &option_show, &option_print, &option_gc_stats,

/* Debugging Options */
#ifdef DIAGNOSTICS
 &option_diagnostic,
#endif
#ifdef DEBUG
 &option_delivery, &option_analysis,
#endif
#ifdef EXPLORER
 &option_explore,
#endif
 &option_end
};

static struct option
  option_epass	         = {"MLWpass", -1, 0, NULL};

static struct option *embedded_options[] =
{ &option_epass, &option_end };

mlval image_continuation = MLUNIT;

int module_argc = 0;
const char *const *module_argv = NULL;

int mono = 0;
const char *runtime;

static clock_t start = 0, stop = 0;

/*  == Load and link a module and add it to the module table ==
 *
 *  The module is loaded onto the heap by load_module() and linked by
 *  calling the resulting top-level function.
 */

static mlval load_link(const char *filename)
{
  mlval mod_name = MLUNIT;
  mlval result = internal_load_link (filename, &mod_name,
				     option_verbose.specified,
				     option_dont_check.specified,
#ifdef DEBUG
				     option_delivery.specified
#else
				     0
#endif
				     );
  if(result == MLERROR)
    switch(errno)
    {
      case ELOADREAD:
      error("The loader was unable to read from the file `%s' "
	    "despite being able to open it.", filename);

      case ELOADOPEN:
      error("The loader was unable to open the file `%s'.", filename);

      case ELOADALLOC:
      error("The loader was unable to allocate enough memory while "
	    "loading the file `%s'.", filename);

      case ELOADVERSION:
      error("The file `%s' contains a module of a version the loader does "
	    "not understand.", filename);

      case ELOADFORMAT:
      error("The file `%s' is not in the correct loader format.", filename);

      case ELOADEXTERNAL:
      error("The module in the file `%s' references an unloaded external "
	    "module called `%s'.", filename, CSTRING(load_external));

      default:
      error("The loader returned %d, which is not a valid error code.", errno);
    }
  else
    return(result);
}

/* == Profiling == */

#define DEFAULT_PROFILE_INTERVAL	10
#define DEFAULT_PROFILE_DEPTH		0

static FILE *profile_stream;
static const char *profile_selector = NULL;
static int profile_specified_manner = 0;

static int profile_manner(mlval code)
{
  if(profile_selector == NULL ||
     strstr(CSTRING(CCODENAME(code)), profile_selector) != NULL)
    return profile_specified_manner;
  else
    return 0;
}

/* Now we define a function to be called when MLWorks exits. */

#ifdef COLLECT_STATS
unsigned int raise_count = 0,
  stack_extension_count = 0;
#endif

extern void stop_mlworks(void)
{
  /* if we have not completed the load process, stop will still be 0 */
  if (stop == 0)
    stop = clock();

  /* if we're profiling... */

  if(option_profile.specified) {
    mlval discard;
    profile_end(&discard);
    if (discard != MLUNIT)
      error("Bad return value from the profiler.");
    if(fclose(profile_stream) == EOF)
      error("Unable to close profiler output file.");
  }

  /* GC statistics stream has to be flushed */
  if(gc_stat_stream != NULL)
    if(fclose(gc_stat_stream) == EOF)
      error("Unable to close statistics file.");

  /* and some statistics to be printed */
  if(option_verbose.specified || option_statistics.specified) {
    messager_function= NULL;
    message("Total loading time %lums.",
	    (long)(((double)(stop - start))*1000.0/(CLOCKS_PER_SEC)));
#ifdef COLLECT_STATS
    printf("Runtime system statistics:\n"
	   "  Raise count: %u\n"
	   "  Stack extension count: %u\n"
	   "  Maximum transient arena size: %ldk\n"
	   "  Maximum heap size: %ldk\n",
	   raise_count, stack_extension_count,
	   (long)(max_arena_extent>>10), (long)(max_heap_size>>10));
#endif
  }

#ifndef MACH_FIXUP
  #ifdef MEASURE_FIXUP
  report_fixup();
  #endif
#endif
  license_release();
}

extern mlval asm_trampoline(mlval);

/* Now the main function run in the top thread */

extern int start_mlworks(int argc, const char *const *argv, mlval setup, void (*declare)(void))
{
  int loop;
  mlval result = MLUNIT;
  struct profile_options profile_options;
  int embedded_image;
  int option_parse_status;

  runtime = argv[0];

  --argc; ++argv;	/* Skip the command name argument */

  embedded_image = (load_heap_from_executable(&result, runtime, 1) == 0);

  option_parse_status = option_parse(&argc, &argv, embedded_options);

  if (!option_parse_status && (errno == EOPTIONDELIM))
    error("Missing closing delimiter for option `%s'.", argv[0]);

  module_argc = argc; module_argv = argv;
  if (option_epass.specified) {
    option_parse_status =
      option_parse(&option_epass.nr_arguments,
		   &option_epass.arguments, options);
    argc = option_epass.nr_arguments;
    argv = option_epass.arguments;
  } else {
    argc = 0;
    option_parse_status = 1;
  }
#if 0
  {
    int i;
    printf("Program arguments:\n");
    for (i = 0; i < module_argc; i++) {
      printf("%d: '%s'\n", i, module_argv[i]);
    }
    printf("Runtime arguments:\n");
    for (i = 0; i < argc; i++) {
      printf("%d: '%s'\n", i, argv[i]);
    }
  }
#endif
  if(!option_parse_status)
    switch(errno)
    {
      case EOPTIONARGS:
      error("The wrong number of arguments were specified for the "
	    "option `%s'.  Use `-help' for help.", argv[0]);

      case EOPTIONUNKNOWN:
      error("An unknown option `%s' was specified.  Use `-help' for help.", argv[0]);

      case EOPTIONDELIM:
      error("Missing closing delimiter for option `%s'.  Use `-help' for help.", argv[0]);

      default:
      error("The option parser returned an unknown error code %d.", errno);
    }

  /* Handle a couple of options before initializing the runtime */

  if (option_help.specified) {
    printf(usage_message, runtime);
    exit(EXIT_SUCCESS);
  }

#ifdef DIAGNOSTICS
  if(option_diagnostic.specified)
    diagnostic_level = to_unsigned(option_diagnostic.arguments[0]);
#endif

#ifdef LICENSE
  license_init();
#endif

  /* Now we're ready to initialize the runtime */

  initialise();

  /* Now call declare_global function in dlls if there are any */

  if (declare != NULL) {
    (*declare)();
  }

  /* Right, now handle the simple options before loading an image */

  if (option_backtrace_depth.specified)
    max_backtrace_depth = to_int(option_backtrace_depth.arguments[0]);

  if (option_batch.specified) {
    license_failure_hang = 0;
  } else {
    out_of_memory_dialog = standard_out_of_memory_dialog;
  }

  if (option_limit.specified)
    arena_limit = to_unsigned(option_limit.arguments[0]) << 20;

  if (option_mono.specified)
    mono = 1;

  if (option_gc_stats.specified) {
    gc_stat_stream = fopen(option_gc_stats.arguments[0], "w");

    if(gc_stat_stream == NULL)
      error("Unable to open `%s' for writing.", option_gc_stats.arguments[0]);

    if(option_verbose.specified) {
      message_start();
      message_string("Writing garbage collection statistics to file `");
      message_string (	      option_gc_stats.arguments[0]);
      message_string("'.");
      message_end();
    }
  }

  if(option_print.specified) {
    print_defaults.depth_max = to_int(option_print.arguments[0]);
    print_defaults.string_length_max = to_unsigned(option_print.arguments[1]);
    print_defaults.indent = to_int(option_print.arguments[2]);
    print_defaults.tags = to_int(option_print.arguments[3]);
  }

  if (option_free_edition.specified) {
    DIAGNOSTIC(1,"Setting act_as_free to 1", 0, 0);
    act_as_free = 1;
  } else {
    DIAGNOSTIC(1,"Setting act_as_free to 0", 0, 0);
    act_as_free = 0;
  };


  /* Load initial image */
  /* First try for an image in the executable, if not prohibited */
  /* If none found, load from command line if one specified */
  {
    mlval root;
    int loaded = 1;
    if (!option_no_load_exec.specified && embedded_image) {
      loaded = load_heap_from_executable(&root, runtime, 0);
    }
    if (loaded == 1) { /* no heap in the executable */
      if(option_load.specified) {

	if(option_verbose.specified) {
	  message_start();
	  message_string("Loading image from file `");
	  message_string (	      option_load.arguments[0]);
	  message_string("'.");
	  message_end();
	}

	root = image_load(ml_string(option_load.arguments[0]));

	if(root == MLERROR)
	  switch(errno) {
	  case EIMPL:
	    error("Image loading is not implemented by this storage manager.");

	  case EIMAGEFORMAT:
	    error("The file `%s' is not in the correct image format.",
		  option_load.arguments[0]);

	  case EIMAGEOPEN:
	    error("The image loader was unable to open the file `%s'.",
		  option_load.arguments[0]);

	  case EIMAGEREAD:
	    error("The image loader was unable to read from the file `%s' "
		  "despite being able to open it.", option_load.arguments[0]);

	  case EIMAGEALLOC:
	    error("The image loader was unable to allocate enough memory "
		  "while loading the file `%s'.", option_load.arguments[0]);

	  case EIMAGEVERSION:
	    error("The image file `%s' is incompatible with the current "
		  "version of the image loader.", option_load.arguments[0]);

	  default:
	    error("The image loader returned %d, "
		  "which is not a valid error code.", errno);
	  }

#ifdef DEBUG
	if (option_analysis.specified)
	  gc_analyse_heap();
#endif
	loaded = 0; /* Success loading image */
      }
    } else if (loaded == 2) { /* An error occurred loading from executable */
      switch(errno) {
      case EIMAGEFORMAT:
	error("The file `%s' is not in the correct image format.",
	      runtime);

      case EIMAGEOPEN:
	error("The image loader was unable to open the file `%s'.",
	      runtime);

      case EIMAGEREAD:
	error("The image loader was unable to read from the file `%s' "
	      "despite being able to open it.", runtime);

      case EIMAGEALLOC:
	error("The image loader was unable to allocate enough memory while "
	      "loading the file `%s'.", runtime);

      case EIMAGEVERSION:
	error("The image file `%s' is incompatable with the current version "
	      "of the image loader.", runtime);

      default:
	error("The image loader returned %d, "
	      "which is not a valid error code.", errno);
      }
    }
    if(loaded == 0) { /* successfully loaded a heap */
      global_unpack(root);
#ifdef EXPLORER
      if (option_explore.specified)
	if (explore(root, 1))
	  exit(EXIT_SUCCESS);
#endif
    }
  }

  /* We have our heap; look at the remaining options */

  if (option_messages.specified)
    MLUPDATE(gc_message_level, 0, MLINT(to_int(option_messages.arguments[0])));

  if (option_stacksize.specified)
    MLUPDATE(max_stack_blocks, 0,
	     MLINT(to_int(option_stacksize.arguments[0])));

  if (option_profile.specified) {
    const char *filename = option_profile.arguments[0];
    int profile_depth;

    profile_stream = fopen(filename, "w");

    if(profile_stream == NULL)
      error("Unable to open `%s' for writing the profile.", filename);

    profile_selector =
      option_profile_select.specified ?
	option_profile_select.arguments[0] : NULL;

    profile_depth =
      option_profile_depth.specified ?
      to_unsigned(option_profile_depth.arguments[0]) :
      DEFAULT_PROFILE_DEPTH;

    if (profile_depth > PROFILE_DEPTH_MAX)
      error("The profiler cannot profile to depth %d (max %d)",
	    profile_depth, PROFILE_DEPTH_MAX);

    profile_specified_manner =
      (option_profile_manner.specified ?
       to_unsigned(option_profile_manner.arguments[0]) : PROFILE_ALL) +
	 (profile_depth << PROFILE_DEPTH_SHIFT);

    profile_options.interval =
      option_profile_scan.specified ?
      to_unsigned(option_profile_scan.arguments[0]) :
      DEFAULT_PROFILE_INTERVAL;

    profile_options.manner = profile_manner;

    profile_options.stream = profile_stream;

    if(option_verbose.specified) {
      message_start();
      message_string("Profiling to `");
      message_string(filename);
      message_content("' with scanning interval %u and depth %u.",
		      profile_options.interval, profile_depth);
      message_end();
    }

    if(profile_begin(&profile_options))
      error("The profile returned an unexpected error code %d.", errno);
  } else if (option_profile_scan.specified ||
	     option_profile_depth.specified ||
	     option_profile_select.specified ||
	     option_profile_manner.specified) {
    error("Profiling option given without -profile");
  }

  /* install the exit routines in case the image calls MLWorks.exit() */

  os_on_exit(stop_mlworks);

  start = clock();

  /* If an image with a continuation was loaded, execute it first. */
  if(image_continuation != MLUNIT) {
    result = image_continuation;
    image_continuation = MLUNIT;
    setup = MLUNIT; /* Don't do setup if we do image continuation */
    result = callml(MLUNIT, result);
  }

  /* If there is a module list file, load modules from there first. */
  if (option_modules.specified) {
    char filename[FILENAME_MAX+1];
    char format[10];
    FILE *f;

    if(option_verbose.specified) {
      message_start();
      message_string("Reading module filenames from file `");
      message_string(option_modules.arguments[0]);
      message_string("'.");
      message_end();
    }

    f = fopen(option_modules.arguments[0], "r");

    if(f == NULL)
      error("Unable to open module list file `%s'.",
	    option_modules.arguments[0]);

    (void)sprintf(format, " %%%us", FILENAME_MAX);

    while(fscanf(f, format, filename) == 1) {
      int c = fgetc(f);

      result = load_link(filename);

      if(c == EOF)
	break;
      else if(!isspace(c))
	error("Overlong filename in module list file `%s'.",
	      option_modules.arguments[0]);
    }

    (void)fclose(f);
  }

  /* Load any modules specified on the command line. */
  for(loop=0; loop<argc; ++loop)
    result = load_link(argv[loop]);

  /* Now run the setup passed as an arg */

  if (setup != MLUNIT) {
    result = asm_trampoline(setup);
  }

  stop = clock();

  /* Show the result of loading the last module */

  if (option_show.specified) {
    print(NULL, stdout, result);
    putchar('\n');
  }

  /* Save the resulting image */
  if(option_save.specified) {
    mlval global, filename, argument;

    if(option_verbose.specified) {
      message_start();
      message_string("Saving image to file `");
      message_string(option_save.arguments[0]);
      message_string("'");
      message_end();
    }

    global = global_pack(0);	/* 0 = not delivery */
    declare_root(&global, 1);
    filename = ml_string(option_save.arguments[0]);
    declare_root(&filename, 1);

    { /* verbosely collect all */
      mlval old_message_level = MLSUB(gc_message_level,0);
      MLUPDATE(gc_message_level,0,MLINT(-1));
      gc_collect_all();
      MLUPDATE(gc_message_level,0,old_message_level);
    }

    argument = allocate_record(2);
    FIELD(argument, 0) = filename;
    FIELD(argument, 1) = global;
    retract_root(&filename);
    retract_root(&global);

    if(image_save(argument) == MLERROR)
      switch(errno) {
	case EIMPL:
	error("Image saving is not implemented.");

	case EIMAGEOPEN:
	error("The image saver was unable to open the file `%s'.",
	      option_save.arguments[0]);

	case EIMAGEWRITE:
	error("The image saver was unable to write to the file `%s'.",
	      option_save.arguments[0]);

	default:
	error("The image saver returned %d, "
	      "which is not a valid error code.", errno);
      }
  }

  if(option_save_exec.specified)
  {
    mlval global, filename;

    if(option_verbose.specified) {
      message_start();
      message_string("Saving executable image to file `");
      message_string(option_save_exec.arguments[0]);
      message_string("'");
      message_end();
    }

    global = global_pack(0);	/* 0 = not delivery */
    declare_root(&global, 1);
    filename = ml_string(option_save_exec.arguments[0]);
    declare_root(&filename, 1);

    { /* verbosely collect all */
      mlval old_message_level = MLSUB(gc_message_level,0);
      MLUPDATE(gc_message_level,0,MLINT(-1));
      gc_collect_all();
      MLUPDATE(gc_message_level,0,old_message_level);
    }
    retract_root(&filename);
    retract_root(&global);

    if(save_executable(CSTRING(filename), global, APP_CURRENT) == MLERROR)
      switch(errno) {
	case EIMPL:
	error("Executable image saving is not implemented.");

	case EIMAGEOPEN:
	error("The image saver was unable to open the file `%s'.",
	      option_save_exec.arguments[0]);

        case EIMAGEREAD:
	error("The image loader was unable to read from the file `%s' "
	      "despite being able to open it.", runtime);

        case EIMAGEALLOC:
	error("The image loader was unable to allocate enough memory while "
	      "reading the file `%s'.", runtime);

	case EIMAGEWRITE:
	error("The image saver was unable to write to the file `%s'.",
	      option_save_exec.arguments[0]);

	default:
	error("The image saver returned %d, "
	      "which is not a valid error code.", errno);
      }
  }

  return(EXIT_SUCCESS);
}
