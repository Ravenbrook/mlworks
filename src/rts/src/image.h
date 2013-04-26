/*  ==== IMAGE SAVE, LOAD, AND DELIVERY ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module contains code for saving the ML heap to a file and loading a
 *  saved heap.  This needs more documentation.
 *
 *  Revision Log
 *  ------------
 *  $Log: image.h,v $
 *  Revision 1.5  1996/01/16 11:21:29  nickb
 *  Move EIMAGE* here from gc.h
 *
 * Revision 1.4  1995/11/27  17:52:48  jont
 * Add image_load_with_open_file for loading from NT saved executables
 * Add image_save_with_open_file for saving NT saved executables
 *
 * Revision 1.3  1995/09/26  13:04:06  jont
 * Add a version of image_load that can read from store
 * Add a version of image_save that can save to store
 * Add a function to determine how much store is required for an image save
 *
 * Revision 1.2  1994/06/09  14:46:52  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:17:44  nickh
 * new file
 *
 *  Revision 1.4  1993/04/02  14:24:17  jont
 *  Modified image format to include a header and table of contents
 *  Added an image_table function to return the table as a list of ml strings
 *
 *  Revision 1.3  1992/11/02  15:05:13  richard
 *  image_load and image_save are now local to the storage
 *  manager.  They are called from outside through the sm_interface
 *  function.
 *
 *  Revision 1.2  1992/07/01  15:24:28  richard
 *  Moved most declarations to storeman.h.
 *
 *  Revision 1.1  1992/03/17  16:45:38  richard
 *  Initial revision
 *
 */

#ifndef image_h
#define image_h

#include <stdio.h>
#include "mltypes.h"

enum /* errno */
{
  EIMPL = 1,		/* The operation is not supported */
  EIMAGEFORMAT,		/* The image is not in the correct format. */
  EIMAGEWRITE,		/* An error occured writing the image. */
  EIMAGEREAD,		/* An error occurred reading the image. */
  EIMAGEOPEN,		/* Unable to open file. */
  EIMAGEALLOC,		/* Unable to allocate memory. */
  EIMAGEVERSION		/* The image doesn't match the load code. */
};

extern mlval image_load(mlval);
extern mlval image_save(mlval);
extern mlval image_table(mlval);
extern mlval memory_image_load(void *ptr, size_t extent);
extern mlval memory_image_save(mlval, void *ptr, size_t limit, size_t *extent);
extern mlval memory_image_save_size(mlval, size_t *extent);
extern mlval image_load_with_open_file(FILE *, const char *);
extern mlval image_save_with_open_file(FILE *, mlval, const char *);
#endif
